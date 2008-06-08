module Halsbe
	class Parser
		module PrimaryLiterals
			Default           = /default/
			Nil               = /nil/
			False             = /false/
			True              = /true/
			StaticSymbol      = /'(?:[^\\']|\\.)*'/
			DynamicSymbol     = /"(?:[^\\"]|\\.)*"/
			Integer2          = /0b[01_]+/
			Integer8          = /0[0-7_]+/
			Integer10         = /0|[1-9][0-9_]*/
			Integer16         = /0x[0-9a-fA-F_]+/
			Integer           = /#{Integer2}|#{Integer8}|#{Integer10}|#{Integer16}/
			Decimal           = /#{Integer10}\.[0-9_]+/
			Float             = /#{Decimal}[eE][-+]?#{Integer10}/
			IntegralImaginary = /#{Integer}[iIjJ]/
			IntegralComplex   = /#{Integer}[-+]#{IntegralImaginary}/
			Imaginary         = /(?:#{Integer}|#{Decimal}|#{Float})[iIjJ]/
			Complex           = /(?:#{Integer}|#{Decimal}|#{Float})[-+]#{Imaginary}/
			Rational          = /
			  (?:#{Integer}|#{Decimal}|#{IntegralComplex})
			  \/
			  (?:#{Integer}|#{Decimal}|#{IntegralComplex})
			/x
			Date      = /\d{4}-\d{2}-\d{2}/
			Time      = /\d{2}:\d{2}(?::#{Decimal})?(?:[-+]\d{4})?/
			DateTime  = /#{Date}T#{Time}/

			def primary_literal
				try {
					scalar
					# list
				}
			end
			
			def scalar
				pseudo ||
				symbol ||
				datetime ||
				numeric
			end
			
			def pseudo
				append_scan(Nil, :Nil, :literal) ||
				append_scan(Default, :Default, :literal) ||
				append_scan(False, :False, :literal) ||
				append_scan(True, :True, :literal)
			end
			
			def symbol
				static_symbol ||
				dynamic_symbol
			end
			
			def static_symbol
				append_scan(StaticSymbol, :StaticSymbol, :literal)
			end
			
			def dynamic_symbol
				append_scan(DynamicSymbol, :DynamicSymbol, :literal)
			end

			def datetime
				date_and_time ||
				date ||
				time
			end
			
			def date_and_time
				append_scan(DateTime, :DateTime, :literal) if @scanner.check(DateTime)
			end

			def date
				append_scan(Date, :Date, :literal) if @scanner.check(Date)
			end

			def time
				append_scan(Time, :Time, :literal) if @scanner.check(Time)
			end
			
			def numeric # order is important
				complex ||
				float ||
				decimal ||
				rational ||
				integer
			end
			
			def integer
				integer2 ||
				integer8 ||
				integer16 ||
				integer10
			end
			
			def integer2
				append_scan(Integer2, :Integer2, :literal) if @scanner.check(Integer2)
			end
			
			def integer8
				append_scan(Integer8, :Integer8, :literal) if @scanner.check(Integer8)
			end
			
			def integer10
				append_scan(Integer10, :Integer10, :literal) if @scanner.check(Integer10)
			end
			
			def integer16
				append_scan(Integer16, :Integer16, :literal) if @scanner.check(Integer16)
			end
			
			def rational
				append_scan(Rational, :Rational, :literal) if @scanner.check(Rational)
			end
			
			def decimal
				append_scan(Decimal, :Decimal, :literal) if @scanner.check(Decimal)
			end
			
			def float
				append_scan(Float, :Float, :literal) if @scanner.check(Float)
			end
			
			def complex
				if @scanner.check(IntegralComplex) then
					append_scan(IntegralComplex, :IntegralComplex, :literal)
				elsif @scanner.check(Complex) then
					append_scan(Complex, :Complex, :literal)
				else
					false
				end
			end
		end
	end
end
