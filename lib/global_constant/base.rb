# frozen_string_literal: true
module GlobalConstant

  class Base

    class << self

      def simple_token_web
        @simple_token_web ||= env_config['simple_token_web']
      end

      def api_root_url
        simple_token_api['root_url']
      end

      def root_url
        simple_token_web['root_url']
      end

      def cloudfront_domain
        env_config.fetch('cloudfront', {})['domain']
      end

      def environment_name
        Rails.env
      end

      def current_time
        Time.now
      end

      private

      def env_config
        @env_config ||= fetch_config
      end

      def fetch_config
        @fetch_config ||= begin
          template = ERB.new File.new("#{Rails.root}/config/constants.yml").read
          YAML.load(template.result(binding)).fetch('constants', {}) || {}
        end
      end

    end

  end

end