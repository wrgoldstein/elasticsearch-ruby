require 'elasticsearch/dsl/version'

require 'elasticsearch/dsl/search'
require 'elasticsearch/dsl/search/base_component'
require 'elasticsearch/dsl/search/base_aggregation_component'
require 'elasticsearch/dsl/search/query'
require 'elasticsearch/dsl/search/filter'
require 'elasticsearch/dsl/search/aggregation'

Dir[ File.expand_path('../dsl/search/queries/**/*.rb', __FILE__) ].each        { |f| require f }
Dir[ File.expand_path('../dsl/search/filters/**/*.rb', __FILE__) ].each        { |f| require f }
Dir[ File.expand_path('../dsl/search/aggregations/**/*.rb', __FILE__) ].each   { |f| require f }

module Elasticsearch

  # The main module, which can be included into your own class or namespace,
  # to provide the builder methods.
  #
  # @example
  #     include Elasticsearch::DSL
  #     definition = search do
  #       query do
  #         match title: 'test'
  #       end
  #     end
  #
  #     definition.to_hash
  #     # => { query: { match: { title: "test"} } }
  #
  # @see Search
  # @see http://www.elasticsearch.org/guide/en/elasticsearch/guide/current/query-dsl-intro.html
  #
  module DSL
    def self.included(base)
      base.__send__ :include, Elasticsearch::DSL::Search
    end
  end
end
