module PrimaryLiterals
  include Treetop::Runtime

  def root
    @root || :primary_literal
  end

  def _nt_primary_literal
    start_index = index
    if node_cache[:primary_literal].has_key?(index)
      cached = node_cache[:primary_literal][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_datetime
    if r1
      r0 = r1
    else
      r2 = _nt_numeric
      if r2
        r0 = r2
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:primary_literal][start_index] = r0

    return r0
  end

  def _nt_datetime
    start_index = index
    if node_cache[:datetime].has_key?(index)
      cached = node_cache[:datetime][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_date_and_time
    if r1
      r0 = r1
    else
      r2 = _nt_date
      if r2
        r0 = r2
      else
        r3 = _nt_time
        if r3
          r0 = r3
        else
          self.index = i0
          r0 = nil
        end
      end
    end

    node_cache[:datetime][start_index] = r0

    return r0
  end

  module DateAndTime0
    def date
      elements[0]
    end

    def time
      elements[2]
    end
  end

  def _nt_date_and_time
    start_index = index
    if node_cache[:date_and_time].has_key?(index)
      cached = node_cache[:date_and_time][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_date
    s0 << r1
    if r1
      if input.index("T", index) == index
        r2 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("T")
        r2 = nil
      end
      s0 << r2
      if r2
        r3 = _nt_time
        s0 << r3
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(DateAndTime0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:date_and_time][start_index] = r0

    return r0
  end

  module Date0
    def digit
      elements[0]
    end

    def digit
      elements[1]
    end

    def digit
      elements[2]
    end

    def digit
      elements[3]
    end

    def digit
      elements[5]
    end

    def digit
      elements[6]
    end

    def digit
      elements[8]
    end

    def digit
      elements[9]
    end
  end

  def _nt_date
    start_index = index
    if node_cache[:date].has_key?(index)
      cached = node_cache[:date][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_digit
    s0 << r1
    if r1
      r2 = _nt_digit
      s0 << r2
      if r2
        r3 = _nt_digit
        s0 << r3
        if r3
          r4 = _nt_digit
          s0 << r4
          if r4
            if input.index("-", index) == index
              r5 = (SyntaxNode).new(input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure("-")
              r5 = nil
            end
            s0 << r5
            if r5
              r6 = _nt_digit
              s0 << r6
              if r6
                r7 = _nt_digit
                s0 << r7
                if r7
                  if input.index("-", index) == index
                    r8 = (SyntaxNode).new(input, index...(index + 1))
                    @index += 1
                  else
                    terminal_parse_failure("-")
                    r8 = nil
                  end
                  s0 << r8
                  if r8
                    r9 = _nt_digit
                    s0 << r9
                    if r9
                      r10 = _nt_digit
                      s0 << r10
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Date0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:date][start_index] = r0

    return r0
  end

  module Time0
  end

  module Time1
    def digit
      elements[1]
    end

    def digit
      elements[2]
    end

    def digit
      elements[3]
    end

    def digit
      elements[4]
    end
  end

  module Time2
    def digit
      elements[0]
    end

    def digit
      elements[1]
    end

    def digit
      elements[3]
    end

    def digit
      elements[4]
    end

    def digit
      elements[6]
    end

    def digit
      elements[7]
    end

  end

  def _nt_time
    start_index = index
    if node_cache[:time].has_key?(index)
      cached = node_cache[:time][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_digit
    s0 << r1
    if r1
      r2 = _nt_digit
      s0 << r2
      if r2
        if input.index(":", index) == index
          r3 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure(":")
          r3 = nil
        end
        s0 << r3
        if r3
          r4 = _nt_digit
          s0 << r4
          if r4
            r5 = _nt_digit
            s0 << r5
            if r5
              if input.index(":", index) == index
                r6 = (SyntaxNode).new(input, index...(index + 1))
                @index += 1
              else
                terminal_parse_failure(":")
                r6 = nil
              end
              s0 << r6
              if r6
                r7 = _nt_digit
                s0 << r7
                if r7
                  r8 = _nt_digit
                  s0 << r8
                  if r8
                    i10, s10 = index, []
                    if index < input_length
                      r11 = (SyntaxNode).new(input, index...(index + 1))
                      @index += 1
                    else
                      terminal_parse_failure("any character")
                      r11 = nil
                    end
                    s10 << r11
                    if r11
                      s12, i12 = [], index
                      loop do
                        r13 = _nt_digit
                        if r13
                          s12 << r13
                        else
                          break
                        end
                      end
                      if s12.empty?
                        self.index = i12
                        r12 = nil
                      else
                        r12 = SyntaxNode.new(input, i12...index, s12)
                      end
                      s10 << r12
                    end
                    if s10.last
                      r10 = (SyntaxNode).new(input, i10...index, s10)
                      r10.extend(Time0)
                    else
                      self.index = i10
                      r10 = nil
                    end
                    if r10
                      r9 = r10
                    else
                      r9 = SyntaxNode.new(input, index...index)
                    end
                    s0 << r9
                    if r9
                      i15, s15 = index, []
                      if input.index(Regexp.new('[+-]'), index) == index
                        r16 = (SyntaxNode).new(input, index...(index + 1))
                        @index += 1
                      else
                        r16 = nil
                      end
                      s15 << r16
                      if r16
                        r17 = _nt_digit
                        s15 << r17
                        if r17
                          r18 = _nt_digit
                          s15 << r18
                          if r18
                            r19 = _nt_digit
                            s15 << r19
                            if r19
                              r20 = _nt_digit
                              s15 << r20
                            end
                          end
                        end
                      end
                      if s15.last
                        r15 = (SyntaxNode).new(input, i15...index, s15)
                        r15.extend(Time1)
                      else
                        self.index = i15
                        r15 = nil
                      end
                      if r15
                        r14 = r15
                      else
                        r14 = SyntaxNode.new(input, index...index)
                      end
                      s0 << r14
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Time2)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:time][start_index] = r0

    return r0
  end

  def _nt_numeric
    start_index = index
    if node_cache[:numeric].has_key?(index)
      cached = node_cache[:numeric][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_complex
    if r1
      r0 = r1
    else
      r2 = _nt_scalar_numeric
      if r2
        r0 = r2
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:numeric][start_index] = r0

    return r0
  end

  module Complex0
    def scalar_numeric
      elements[0]
    end

  end

  module Complex1
    def scalar_numeric
      elements[1]
    end

  end

  def _nt_complex
    start_index = index
    if node_cache[:complex].has_key?(index)
      cached = node_cache[:complex][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    i2 = index
    i3, s3 = index, []
    r4 = _nt_scalar_numeric
    s3 << r4
    if r4
      if input.index(Regexp.new('[+-]'), index) == index
        r5 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        r5 = nil
      end
      s3 << r5
    end
    if s3.last
      r3 = (SyntaxNode).new(input, i3...index, s3)
      r3.extend(Complex0)
    else
      self.index = i3
      r3 = nil
    end
    if r3
      r2 = r3
    else
      if input.index(Regexp.new('[+-]'), index) == index
        r6 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        r6 = nil
      end
      if r6
        r2 = r6
      else
        self.index = i2
        r2 = nil
      end
    end
    if r2
      r1 = r2
    else
      r1 = SyntaxNode.new(input, index...index)
    end
    s0 << r1
    if r1
      r7 = _nt_scalar_numeric
      s0 << r7
      if r7
        if input.index(Regexp.new('[IiJj]'), index) == index
          r8 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          r8 = nil
        end
        s0 << r8
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Complex1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:complex][start_index] = r0

    return r0
  end

  def _nt_scalar_numeric
    start_index = index
    if node_cache[:scalar_numeric].has_key?(index)
      cached = node_cache[:scalar_numeric][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_rational
    if r1
      r0 = r1
    else
      r2 = _nt_float
      if r2
        r0 = r2
      else
        r3 = _nt_decimal
        if r3
          r0 = r3
        else
          r4 = _nt_integer
          if r4
            r0 = r4
          else
            self.index = i0
            r0 = nil
          end
        end
      end
    end

    node_cache[:scalar_numeric][start_index] = r0

    return r0
  end

  module Rational0
    def integer
      elements[0]
    end

    def integer
      elements[2]
    end
  end

  def _nt_rational
    start_index = index
    if node_cache[:rational].has_key?(index)
      cached = node_cache[:rational][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_integer
    s0 << r1
    if r1
      if input.index("/", index) == index
        r2 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("/")
        r2 = nil
      end
      s0 << r2
      if r2
        r3 = _nt_integer
        s0 << r3
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Rational0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:rational][start_index] = r0

    return r0
  end

  module Float0
    def integer10
      elements[2]
    end
  end

  def _nt_float
    start_index = index
    if node_cache[:float].has_key?(index)
      cached = node_cache[:float][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    i1 = index
    r2 = _nt_decimal
    if r2
      r1 = r2
    else
      r3 = _nt_integer10
      if r3
        r1 = r3
      else
        self.index = i1
        r1 = nil
      end
    end
    s0 << r1
    if r1
      if input.index(Regexp.new('[Ee]'), index) == index
        r4 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        r4 = nil
      end
      s0 << r4
      if r4
        r5 = _nt_integer10
        s0 << r5
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Float0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:float][start_index] = r0

    return r0
  end

  module Decimal0
    def integer10
      elements[0]
    end

  end

  def _nt_decimal
    start_index = index
    if node_cache[:decimal].has_key?(index)
      cached = node_cache[:decimal][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_integer10
    s0 << r1
    if r1
      if input.index(".", index) == index
        r2 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure(".")
        r2 = nil
      end
      s0 << r2
      if r2
        s3, i3 = [], index
        loop do
          r4 = _nt_digit
          if r4
            s3 << r4
          else
            break
          end
        end
        if s3.empty?
          self.index = i3
          r3 = nil
        else
          r3 = SyntaxNode.new(input, i3...index, s3)
        end
        s0 << r3
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Decimal0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:decimal][start_index] = r0

    return r0
  end

  def _nt_integer
    start_index = index
    if node_cache[:integer].has_key?(index)
      cached = node_cache[:integer][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_integer2
    if r1
      r0 = r1
    else
      r2 = _nt_integer8
      if r2
        r0 = r2
      else
        r3 = _nt_integer16
        if r3
          r0 = r3
        else
          r4 = _nt_integer10
          if r4
            r0 = r4
          else
            self.index = i0
            r0 = nil
          end
        end
      end
    end

    node_cache[:integer][start_index] = r0

    return r0
  end

  module Integer20
  end

  def _nt_integer2
    start_index = index
    if node_cache[:integer2].has_key?(index)
      cached = node_cache[:integer2][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index(Regexp.new('[+-]'), index) == index
      r2 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      r2 = nil
    end
    if r2
      r1 = r2
    else
      r1 = SyntaxNode.new(input, index...index)
    end
    s0 << r1
    if r1
      if input.index("0b", index) == index
        r3 = (SyntaxNode).new(input, index...(index + 2))
        @index += 2
      else
        terminal_parse_failure("0b")
        r3 = nil
      end
      s0 << r3
      if r3
        s4, i4 = [], index
        loop do
          if input.index(Regexp.new('[01]'), index) == index
            r5 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            r5 = nil
          end
          if r5
            s4 << r5
          else
            break
          end
        end
        if s4.empty?
          self.index = i4
          r4 = nil
        else
          r4 = SyntaxNode.new(input, i4...index, s4)
        end
        s0 << r4
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Integer20)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:integer2][start_index] = r0

    return r0
  end

  module Integer80
  end

  def _nt_integer8
    start_index = index
    if node_cache[:integer8].has_key?(index)
      cached = node_cache[:integer8][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index(Regexp.new('[+-]'), index) == index
      r2 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      r2 = nil
    end
    if r2
      r1 = r2
    else
      r1 = SyntaxNode.new(input, index...index)
    end
    s0 << r1
    if r1
      if input.index("0", index) == index
        r3 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("0")
        r3 = nil
      end
      s0 << r3
      if r3
        s4, i4 = [], index
        loop do
          if input.index(Regexp.new('[0-7]'), index) == index
            r5 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            r5 = nil
          end
          if r5
            s4 << r5
          else
            break
          end
        end
        if s4.empty?
          self.index = i4
          r4 = nil
        else
          r4 = SyntaxNode.new(input, i4...index, s4)
        end
        s0 << r4
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Integer80)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:integer8][start_index] = r0

    return r0
  end

  module Integer100
  end

  module Integer101
  end

  def _nt_integer10
    start_index = index
    if node_cache[:integer10].has_key?(index)
      cached = node_cache[:integer10][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index(Regexp.new('[+-]'), index) == index
      r2 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      r2 = nil
    end
    if r2
      r1 = r2
    else
      r1 = SyntaxNode.new(input, index...index)
    end
    s0 << r1
    if r1
      i3 = index
      if input.index("0", index) == index
        r4 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("0")
        r4 = nil
      end
      if r4
        r3 = r4
      else
        i5, s5 = index, []
        if input.index(Regexp.new('[1-9]'), index) == index
          r6 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          r6 = nil
        end
        s5 << r6
        if r6
          s7, i7 = [], index
          loop do
            r8 = _nt_digit
            if r8
              s7 << r8
            else
              break
            end
          end
          r7 = SyntaxNode.new(input, i7...index, s7)
          s5 << r7
        end
        if s5.last
          r5 = (SyntaxNode).new(input, i5...index, s5)
          r5.extend(Integer100)
        else
          self.index = i5
          r5 = nil
        end
        if r5
          r3 = r5
        else
          self.index = i3
          r3 = nil
        end
      end
      s0 << r3
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Integer101)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:integer10][start_index] = r0

    return r0
  end

  module Integer160
  end

  def _nt_integer16
    start_index = index
    if node_cache[:integer16].has_key?(index)
      cached = node_cache[:integer16][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index(Regexp.new('[+-]'), index) == index
      r2 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      r2 = nil
    end
    if r2
      r1 = r2
    else
      r1 = SyntaxNode.new(input, index...index)
    end
    s0 << r1
    if r1
      if input.index("0x", index) == index
        r3 = (SyntaxNode).new(input, index...(index + 2))
        @index += 2
      else
        terminal_parse_failure("0x")
        r3 = nil
      end
      s0 << r3
      if r3
        s4, i4 = [], index
        loop do
          if input.index(Regexp.new('[0-9A-Fa-f]'), index) == index
            r5 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            r5 = nil
          end
          if r5
            s4 << r5
          else
            break
          end
        end
        if s4.empty?
          self.index = i4
          r4 = nil
        else
          r4 = SyntaxNode.new(input, i4...index, s4)
        end
        s0 << r4
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Integer160)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:integer16][start_index] = r0

    return r0
  end

end

class PrimaryLiteralsParser < Treetop::Runtime::CompiledParser
  include PrimaryLiterals
end

