# Copyright 2011-2013 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You
# may not use this file except in compliance with the License. A copy of
# the License is located at
#
#     http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is
# distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
# ANY KIND, either express or implied. See the License for the specific
# language governing permissions and limitations under the License.

module AWS
  class STS

    # Client class for AWS Security Token Service (STS).
    class Client < Core::QueryClient

      REGION_US_E1 = 'sts.amazonaws.com'

      # @private
      CACHEABLE_REQUESTS = Set[]

      def initialize *args
        super
        unless config.use_ssl?
          msg = 'AWS Security Token Service (STS) requires ssl but the ' + 
            ':use_ssl option is set to false.  Try passing :use_ssl => true'
          raise ArgumentError, msg
        end
      end

      # client methods #

      # @!method assume_role(options = {})
      # Calls the AssumeRole API operation.
      # @param [Hash] options
      #   * +:role_arn+ - *required* - (String) The Amazon Resource Name (ARN)
      #     of the role that the caller is assuming.
      #   * +:role_session_name+ - *required* - (String) An identifier for the
      #     assumed role session. The session name is included as part of the
      #     AssumedRoleUser.
      #   * +:policy+ - (String) A supplemental policy that can be associated
      #     with the temporary security credentials. The caller can restrict
      #     the permissions that are available on the role's temporary security
      #     credentials to maintain the least amount of privileges. When a
      #     service call is made with the temporary security credentials, both
      #     the role's permission policy and supplemental policy are checked.
      #     For more information about how permissions work in the context of
      #     temporary credentials, see Controlling Permissions in Temporary
      #     Credentials.
      #   * +:duration_seconds+ - (Integer) The duration, in seconds, of the
      #     role session. The value can range from 900 seconds (15 minutes) to
      #     3600 seconds (1 hour). By default, the value is set to 3600 seconds
      #     (1 hour).
      #   * +:external_id+ - (String) A unique identifier that is generated by
      #     a third party for each of their customers. For each role that the
      #     third party can assume, they should instruct their customers to
      #     create a role with the external ID that was generated by the third
      #     party. Each time the third party assumes the role, they must pass
      #     the customer's correct external ID. The external ID is useful in
      #     order to help third parties bind a role to the customer who created
      #     it. For more information about the external ID, see About the
      #     External ID in Using Temporary Security Credentials.
      # @return [Core::Response]
      #   The #data method of the response object returns
      #   a hash with the following structure:
      #   * +:credentials+ - (Hash)
      #     * +:access_key_id+ - (String)
      #     * +:secret_access_key+ - (String)
      #     * +:session_token+ - (String)
      #     * +:expiration+ - (Time)
      #   * +:assumed_role_user+ - (Hash)
      #     * +:assumed_role_id+ - (String)
      #     * +:arn+ - (String)
      #   * +:packed_policy_size+ - (Integer)

      # @!method get_federation_token(options = {})
      # Calls the GetFederationToken API operation.
      # @param [Hash] options
      #   * +:name+ - *required* - (String) The name of the federated user
      #     associated with the credentials. For information about limitations
      #     on user names, go to Limitations on IAM Entities in Using IAM.
      #   * +:policy+ - (String) A policy specifying the permissions to
      #     associate with the credentials. The caller can delegate their own
      #     permissions by specifying a policy, and both policies will be
      #     checked when a service call is made. For more information about how
      #     permissions work in the context of temporary credentials, see
      #     Controlling Permissions in Temporary Credentials in Using IAM.
      #   * +:duration_seconds+ - (Integer) The duration, in seconds, that the
      #     session should last. Acceptable durations for federation sessions
      #     range from 900s (15 minutes) to 129600s (36 hours), with 43200s (12
      #     hours) as the default. Sessions for AWS account owners are
      #     restricted to a maximum of 3600s (one hour). If the duration is
      #     longer than one hour, the session for AWS account owners defaults
      #     to one hour.
      # @return [Core::Response]
      #   The #data method of the response object returns
      #   a hash with the following structure:
      #   * +:credentials+ - (Hash)
      #     * +:access_key_id+ - (String)
      #     * +:secret_access_key+ - (String)
      #     * +:session_token+ - (String)
      #     * +:expiration+ - (Time)
      #   * +:federated_user+ - (Hash)
      #     * +:federated_user_id+ - (String)
      #     * +:arn+ - (String)
      #   * +:packed_policy_size+ - (Integer)

      # @!method get_session_token(options = {})
      # Calls the GetSessionToken API operation.
      # @param [Hash] options
      #   * +:duration_seconds+ - (Integer) The duration, in seconds, that the
      #     credentials should remain valid. Acceptable durations for IAM user
      #     sessions range from 900s (15 minutes) to 129600s (36 hours), with
      #     43200s (12 hours) as the default. Sessions for AWS account owners
      #     are restricted to a maximum of 3600s (one hour). If the duration is
      #     longer than one hour, the session for AWS account owners defaults
      #     to one hour.
      #   * +:serial_number+ - (String) The identification number of the MFA
      #     device for the user. If the IAM user has a policy requiring MFA
      #     authentication (or is in a group requiring MFA authentication) to
      #     access resources, provide the device value here.The value is in the
      #     Security Credentials tab of the user's details pane in the IAM
      #     console. If the IAM user has an active MFA device, the details pane
      #     displays a Multi-Factor Authentication Device value. The value is
      #     either for a virtual device, such as
      #     arn:aws:iam::123456789012:mfa/user, or it is the device serial
      #     number for a hardware device (usually the number from the back of
      #     the device), such as GAHT12345678. For more information, see Using
      #     Multi-Factor Authentication (MFA) Devices with AWS in Using IAM.
      #   * +:token_code+ - (String) The value provided by the MFA device. If
      #     the user has an access policy requiring an MFA code (or is in a
      #     group requiring an MFA code), provide the value here to get
      #     permission to resources as specified in the access policy. If MFA
      #     authentication is required, and the user does not provide a code
      #     when requesting a set of temporary security credentials, the user
      #     will receive an "access denied" response when requesting resources
      #     that require MFA authentication. For more information, see Using
      #     Multi-Factor Authentication (MFA) Devices with AWS in Using IAM.
      # @return [Core::Response]
      #   The #data method of the response object returns
      #   a hash with the following structure:
      #   * +:credentials+ - (Hash)
      #     * +:access_key_id+ - (String)
      #     * +:secret_access_key+ - (String)
      #     * +:session_token+ - (String)
      #     * +:expiration+ - (Time)

      # end client methods #

      define_client_methods('2011-06-15')

    end
  end
end