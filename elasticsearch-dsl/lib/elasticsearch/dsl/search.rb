module Elasticsearch
  module DSL

    # Provides DSL methods for building the search definition
    # (queries, filters, aggregations, sorting, etc)
    #
    module Search

      # Initialize a new Search object
      #
      # @example Building a search definition declaratively
      #
      #     definition = search do
      #       query do
      #         match title: 'test'
      #       end
      #     end
      #
      # @example Using the class imperatively
      #
      #     definition = Search.new
      #     query = Query.new
      #     definition.query query
      #     definition.to_hash
      #     # => => {:query=>{:match=>{:title=>"Test"}}}
      #
      # @see http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/search.html
      #
      def search(*args, &block)
        Search.new(*args, &block)
      end

      # Wraps the whole search definition (queries, filters, aggregations, sorting, etc)
      #
      class Search
        def initialize(*args, &block)
          instance_eval(&block) if block
        end

        # DSL method for building the `query` part of a search definition
        #
        # @return [self]
        #
        def query(*args, &block)
          if block
            @query = Query.new(*args, &block)
          else
            @query = args.first
          end
          self
        end

        # Converts the search definition to a Hash
        #
        # @return [Hash]
        #
        def to_hash
          hash = {}
          hash.update(query: @query.to_hash) if @query
          hash
        end
      end
    end
  end
end
