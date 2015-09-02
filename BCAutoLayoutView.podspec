Pod::Spec.new do |s|

  s.name         = "BCAutoLayoutView"
  s.version      = "0.1"
  s.summary      = "A drop-in solution for add subviews without consider setting NSLayoutConstraint"

  s.description  = <<-DESC
                   A UIView subclass that create constraints to its superview's inner bounds without much interactions.
                   DESC

  s.homepage     = "https://github.com/ustbenchan/BCAutoLayoutView"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "ustbenchan" => "ustbenchan@gmail.com" }

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/ustbenchan/BCAutoLayoutView.git", :tag => "v0.1" }

  s.source_files  = "Classes", "sources/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

  s.requires_arc = true

end
