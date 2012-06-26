desc "List available tasks"
task :default do
	sh %{ rake -T }
end

desc "Make ConnectivityTest_EP.exe executable"
task :exe do
	sh %{ ocra ConnectivityTest_EX.rb }
	sh %{ RD /S /Q dist && MD dist }
	sh %{ cp ConnectivityTest_EX.exe README dist }
end
