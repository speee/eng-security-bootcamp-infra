sticked_version = '8:6.8.9.9-7ubuntu5'
packages = %w[
  imagemagick-common
  libmagickcore-6.q16-2
  libmagickwand-6.q16-2
  libmagickcore-6.q16-2-extra
  imagemagick-6.q16
  imagemagick
  libmagickcore-6-arch-config
  libmagickcore-6-headers
  libmagickcore-6.q16-dev
  libmagickwand-6-headers
  libmagickwand-6.q16-dev
  libmagickwand-dev
]

packages.each do |name|
  package name do
    version sticked_version
  end
end

execute "apt-mark hold #{packages.join(' ')}"
