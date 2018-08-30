module Namespaceable
  extend ActiveSupport::Concern

  class_methods do
    @@current_association_namespace = nil
    @@current_association_namespace_lock = Mutex.new

    def has_many(name, scope=nil, **options, &extension)
      options[:class_name] = namespaced_klass_name(name, options, true) if namespaced?
      super(name, scope, **options, &extension)
    end

    def has_one(name, scope=nil, **options)
      options[:class_name] = namespaced_klass_name(name, options) if namespaced?
      super(name, scope, options)
    end

    def belongs_to(name, scope=nil, **options)
      options[:class_name] = namespaced_klass_name(name, options) if namespaced?
      super(name, scope, options)
    end

    protected
      def namespace(namespace)
        @@current_association_namespace_lock.synchronize do
          @@current_association_namespace = namespace
          yield
          @@current_association_namespace = nil
        end
      end

      def namespaced?
        return @@current_association_namespace.present?
      end

      def namespaced_klass_name(model, options, plural=false)
        model_name = options[:class_name]
        model_name ||= (plural ? model.to_s.singularize : model.to_s).camelize
        klass_name = @@current_association_namespace.to_s.camelize

        return "#{klass_name}::#{model_name}"
      end
  end
end