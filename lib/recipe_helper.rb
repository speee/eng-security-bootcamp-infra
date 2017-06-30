class MItamae::RecipeContext
  def attrs
    node[:attributes]
  end

  def global_attrs
    node[:global_attributes]
  end

  def include_middleware(name)
    include_recipe File.join(top_dir, 'recipes', 'middleware', name)
  end

  def top_dir
    @top_dir ||= File.expand_path('../..', __FILE__)
  end
end

class MItamae::ResourceContext
  def attrs
    node[:attributes]
  end

  def global_attrs
    node[:global_attributes]
  end
end

class MItamae::Resource::Template < MItamae::Resource::RemoteFile
  def attrs
    node[:attributes]
  end

  def global_attrs
    node[:global_attributes]
  end
end
