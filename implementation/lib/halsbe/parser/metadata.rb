module Halsbe
	class Parser
		module MetaData
			Shebang       = /#!.*/
			MetaDataKey   = /(?!\+\+\+)[^:]+/
			MetaDataSep   = /:\s+/
			MetaDataValue = /.*/
	
			def meta_data
				append(:MetaData, nil) do
					scan_newline if append_scan(Shebang, :Shebang, nil)
	
					try(0,-1) { # repeat as long as we can
						append(:MetaDataPair, :_matadatapair) do
							meta_data_key && meta_data_sep && meta_data_value && scan_newline
						end
					}
				end
			end
			
			def shebang
				scan_newline
			end
			
			def meta_data_key
				append_scan(MetaDataKey, :MetaDataKey, nil)
			end
	
			def meta_data_sep
				append_scan(MetaDataSep, :MetaDataSep, nil)
			end
	
			def meta_data_value
				append_scan(MetaDataValue, :MetaDataValue, nil)
			end
		end
	end
end
