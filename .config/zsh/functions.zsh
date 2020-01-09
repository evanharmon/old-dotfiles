function tf_prompt_info() {
    # dont show 'default' workspace in home dir
    [[ "$PWD" == ~ ]] && return
    # check if in terraform dir
    if [ -d .terraform ]; then
      workspace=$(terraform workspace show 2> /dev/null) || return
      echo "[${workspace}]"
    fi
}

# See http://docs.aws.amazon.com/cli/latest/reference/sts/get-session-token.html .
# You must have jq installed and in your PATH https://stedolan.github.io/jq/ .
#
# ARGS:
# MFA_TOKEN=123456
# AWS_PROFILE="default"
# AWS_ROLE_NAME="MyRoleName"
# TARGET_ACCOUNT_ID="111111111111"
# usage: aws-assume-role-env 123456 MyProfileName MyRoleName 111111111111
function aws-assume-role-env () {
    local pkg=aws-assume-role
    local mfa_token
    if [[ ! $1 ]]; then
        echo "$pkg: missing required argument for MFA_TOKEN" 1>&2
        return 99
    fi
    mfa_token=$1

    local iam_user
    iam_user=$(whoami)

    local account_id profile serial_number
    if [[ ! $2 ]]; then
        echo "$pkg: missing required argument for profile" 1>&2
    fi
    profile=$2
    account_id=$(aws --profile $profile --output text sts get-caller-identity --query Account)
    serial_number="arn:aws:iam::${account_id}:mfa/$iam_user"

    rv="$?"
    if [[ $rv -ne 0 || ! account_id ]]; then
        echo "$pkg: failed to get account_id" 1>&2
        return "$rv"
    fi

    local role_name
    if [[ ! $3 ]]; then
        echo "$pkg: missing required argument for role_name" 1>&2
    fi
    role_name=$3

    local target_account_id role_arn
    if [[ ! $4 ]]; then
        echo "$pkg: missing required argument for target_account_id" 1>&2
    fi
    target_account_id=$4
    role_arn="arn:aws:iam::${target_account_id}:role/$role_name"

    local creds_json
    creds_json=$(aws --profile $profile --output json sts assume-role --duration 3600 --role-arn $role_arn --role-session-name $role_name --serial-number $serial_number --token-code $mfa_token)
    rv="$?"
    if [[ $rv -ne 0 || ! $creds_json ]]; then
        echo "$pkg: failed to get credentials for user '$iam_user' account '$account_id': $creds_json" 1>&2
        return "$rv"
    fi
    access_key_id=$(echo "$creds_json" | jq --exit-status --raw-output '.Credentials.AccessKeyId')
    rv="$?"
    if [[ $rv -ne 0 || ! $access_key_id ]]; then
        echo "$pkg: failed to parse output for access_key_id: $creds_json" 1>&2
        return "$rv"
    fi
    secret_access_key=$(echo "$creds_json" | jq --exit-status --raw-output '.Credentials.SecretAccessKey')
    rv="$?"
    if [[ $rv -ne 0 || ! $secret_access_key ]]; then
        echo "$pkg: failed to parse output for secret_access_key: $creds_json" 1>&2
        return "$rv"
    fi
    session_token=$(echo "$creds_json" | jq --exit-status --raw-output '.Credentials.SessionToken')
    rv="$?"
    if [[ $rv -ne 0 || ! $session_token ]]; then
        echo "$pkg: failed to parse output for session_token: $creds_json" 1>&2
        return "$rv"
    fi

    default_region=${AWS_REGION:-'us-east-1'}
    region=${AWS_REGION:-$default_region}

    # unset aws vars to be safe
    unset AWS_DEFAULT_PROFILE AWS_PROFILE AWS_REGION AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_ACCOUNT_ID AWS_SHARED_CREDENTIALS_FILE
    export AWS_ACCESS_KEY_ID=$access_key_id AWS_SECRET_ACCESS_KEY=$secret_access_key AWS_SESSION_TOKEN=$session_token AWS_REGION=$region AWS_DEFAULT_REGION=$default_region
}

# usage: aws-export-env MyProfileName
function aws-export-env () {
    local pkg=aws-export-env
    local iam_user
    iam_user=$(whoami)

    local account_id profile
    if [[ ! $1 ]]; then
        echo "$pkg: missing required argument for profile" 1>&2
        return 99
    fi
    profile=$1
    account_id=$(aws --profile $profile --output text sts get-caller-identity --query Account)

    rv="$?"
    if [[ $rv -ne 0 || ! account_id ]]; then
        echo "$pkg: failed to get account_id" 1>&2
        return "$rv"
    fi

    local creds_json
    creds_json=$(aws --profile $profile --output json sts get-session-token)
    rv="$?"
    if [[ $rv -ne 0 || ! $creds_json ]]; then
        echo "$pkg: failed to get credentials for user '$iam_user' account '$account_id': $creds_json" 1>&2
        return "$rv"
    fi
    local access_key secret_key session_token
    access_key=$(echo "$creds_json" | jq --exit-status --raw-output '.Credentials.AccessKeyId')
    rv="$?"
    if [[ $rv -ne 0 || ! $access_key ]]; then
        echo "$pkg: failed to parse output for AWS_ACCESS_KEY_ID: $creds_json" 1>&2
        return "$rv"
    fi
    secret_key=$(echo "$creds_json" | jq --exit-status --raw-output '.Credentials.SecretAccessKey')
    rv="$?"
    if [[ $rv -ne 0 || ! $secret_key ]]; then
        echo "$pkg: failed to parse output for AWS_SECRET_ACCESS_KEY: $creds_json" 1>&2
        return "$rv"
    fi
    session_token=$(echo "$creds_json" | jq --exit-status --raw-output '.Credentials.SessionToken')
    rv="$?"
    if [[ $rv -ne 0 || ! $session_token ]]; then
        echo "$pkg: failed to parse output for AWS_SESSION_TOKEN: $creds_json" 1>&2
        return "$rv"
    fi

    default_region=${AWS_REGION:-'us-east-1'}
    region=${AWS_REGION:-$default_region}

    # unset aws vars to be safe
    unset AWS_DEFAULT_PROFILE AWS_PROFILE AWS_REGION AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_ACCOUNT_ID AWS_SHARED_CREDENTIALS_FILE
    export AWS_REGION=$region AWS_DEFAULT_REGION=$default_region AWS_ACCESS_KEY_ID=$access_key AWS_SECRET_ACCESS_KEY=$secret_key AWS_SESSION_TOKEN=$session_token AWS_ACCOUNT_ID=$account_id
}

function aws-unset-env () {
    unset AWS_DEFAULT_PROFILE AWS_PROFILE AWS_REGION AWS_ACCOUNT_ID AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_SHARED_CREDENTIALS_FILE
}


# SET ITERM TAB TITLE
function ititle() {
	echo -ne "\033]0;"$1"\007"
}
