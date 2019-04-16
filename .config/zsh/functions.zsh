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
    AWS_ACCESS_KEY_ID=$(echo "$creds_json" | jq --exit-status --raw-output '.Credentials.AccessKeyId')
    rv="$?"
    if [[ $rv -ne 0 || ! $AWS_ACCESS_KEY_ID ]]; then
        echo "$pkg: failed to parse output for AWS_ACCESS_KEY_ID: $creds_json" 1>&2
        return "$rv"
    fi
    AWS_SECRET_ACCESS_KEY=$(echo "$creds_json" | jq --exit-status --raw-output '.Credentials.SecretAccessKey')
    rv="$?"
    if [[ $rv -ne 0 || ! $AWS_SECRET_ACCESS_KEY ]]; then
        echo "$pkg: failed to parse output for AWS_SECRET_ACCESS_KEY: $creds_json" 1>&2
        return "$rv"
    fi
    AWS_SESSION_TOKEN=$(echo "$creds_json" | jq --exit-status --raw-output '.Credentials.SessionToken')
    rv="$?"
    if [[ $rv -ne 0 || ! $AWS_SESSION_TOKEN ]]; then
        echo "$pkg: failed to parse output for AWS_SESSION_TOKEN: $creds_json" 1>&2
        return "$rv"
    fi

    export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
}
