module Griddler
  module Adapters
    class CloudmailinAdapter
      def initialize(params)
        @params = params
      end

      def self.normalize_params(params)
        adapter = new(params)
        adapter.normalize_params
      end

      def normalize_params
        {
          to: recipients,
          from: params[:envelope][:from],
          subject: params[:headers][:Subject],
          text: params[:plain],
          attachments: params.fetch(:attachments) { [] },
        }
      end

      private

        attr_reader :params

        def recipients
          if params[:envelope][:to]
            params[:envelope][:to].split(',')
          elsif params[:envelope][:recipients]
            params[:envelope][:recipients].values
          else
            []
          end
        end

    end
  end
end
