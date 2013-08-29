class PackagesUpdater
  def update
    all_packages.each do |r_package|
      package = Package.where(name: r_package.name).first

      if package
        update_existing_package(r_package, package)
      else
        Package.create!(build_attributes(r_package, package))
      end
    end
  end

  private

  def update_existing_package(r_package, package)
    if package.current_version != r_package.version
      package.update_attributes(build_attributes(r_package, package))
    end
  end

  def build_attributes(r_package, package)
    {
      name: r_package.name,
      description: r_package.description,
      versions: (package.try(:versions) || []) + [r_package.version],
      current_version: r_package.version,
      authors: load_authors(r_package.authors)
    }
  end

  def load_authors(names)
    names.map { |name| Author.new name: name }
  end

  def all_packages
    RProject::RPackage.all
  end
end
