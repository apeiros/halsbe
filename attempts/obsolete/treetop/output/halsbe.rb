module Halsbe
  include Treetop::Runtime

  def root
    @root || :document
  end

  module Document0
    def meta_separator
      elements[0]
    end

    def inline_data
      elements[1]
    end
  end

  module Document1
    def meta_data
      elements[0]
    end

    def meta_separator
      elements[1]
    end

    def code
      elements[2]
    end

  end

  def _nt_document
    start_index = index
    if node_cache[:document].has_key?(index)
      cached = node_cache[:document][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_meta_data
    s0 << r1
    if r1
      r2 = _nt_meta_separator
      s0 << r2
      if r2
        r3 = _nt_code
        s0 << r3
        if r3
          i5, s5 = index, []
          r6 = _nt_meta_separator
          s5 << r6
          if r6
            s7, i7 = [], index
            loop do
              if index < input_length
                r8 = (SyntaxNode).new(input, index...(index + 1))
                @index += 1
              else
                terminal_parse_failure("any character")
                r8 = nil
              end
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
            r5.extend(Document0)
          else
            self.index = i5
            r5 = nil
          end
          if r5
            r4 = r5
          else
            r4 = SyntaxNode.new(input, index...index)
          end
          s0 << r4
        end
      end
    end
    if s0.last
      r0 = (Document).new(input, i0...index, s0)
      r0.extend(Document1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:document][start_index] = r0

    return r0
  end

  module MetaData0
    def shebang
      elements[0]
    end

  end

  module MetaData1
    def meta_tuple
      elements[1]
    end
  end

  def _nt_meta_data
    start_index = index
    if node_cache[:meta_data].has_key?(index)
      cached = node_cache[:meta_data][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    i2, s2 = index, []
    r3 = _nt_shebang
    s2 << r3
    if r3
      if input.index("\n", index) == index
        r4 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("\n")
        r4 = nil
      end
      s2 << r4
    end
    if s2.last
      r2 = (SyntaxNode).new(input, i2...index, s2)
      r2.extend(MetaData0)
    else
      self.index = i2
      r2 = nil
    end
    if r2
      r1 = r2
    else
      r1 = SyntaxNode.new(input, index...index)
    end
    s0 << r1
    if r1
      s5, i5 = [], index
      loop do
        r6 = _nt_meta_tuple
        if r6
          s5 << r6
        else
          break
        end
      end
      r5 = SyntaxNode.new(input, i5...index, s5)
      s0 << r5
    end
    if s0.last
      r0 = (MetaData).new(input, i0...index, s0)
      r0.extend(MetaData1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:meta_data][start_index] = r0

    return r0
  end

  module Shebang0
  end

  module Shebang1
  end

  def _nt_shebang
    start_index = index
    if node_cache[:shebang].has_key?(index)
      cached = node_cache[:shebang][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index("#!", index) == index
      r1 = (SyntaxNode).new(input, index...(index + 2))
      @index += 2
    else
      terminal_parse_failure("#!")
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        i3, s3 = index, []
        i4 = index
        if input.index("\n", index) == index
          r5 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("\n")
          r5 = nil
        end
        if r5
          r4 = nil
        else
          self.index = i4
          r4 = SyntaxNode.new(input, index...index)
        end
        s3 << r4
        if r4
          if index < input_length
            r6 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("any character")
            r6 = nil
          end
          s3 << r6
        end
        if s3.last
          r3 = (SyntaxNode).new(input, i3...index, s3)
          r3.extend(Shebang0)
        else
          self.index = i3
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = SyntaxNode.new(input, i2...index, s2)
      s0 << r2
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(Shebang1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:shebang][start_index] = r0

    return r0
  end

  module MetaTuple0
  end

  module MetaTuple1
    def meta_key
      elements[0]
    end

    def meta_sep
      elements[1]
    end

    def meta_value
      elements[2]
    end

  end

  def _nt_meta_tuple
    start_index = index
    if node_cache[:meta_tuple].has_key?(index)
      cached = node_cache[:meta_tuple][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_meta_key
    s0 << r1
    if r1
      i2, s2 = index, []
      if input.index(":", index) == index
        r3 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure(":")
        r3 = nil
      end
      s2 << r3
      if r3
        s4, i4 = [], index
        loop do
          if input.index(" ", index) == index
            r5 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure(" ")
            r5 = nil
          end
          if r5
            s4 << r5
          else
            break
          end
        end
        r4 = SyntaxNode.new(input, i4...index, s4)
        s2 << r4
      end
      if s2.last
        r2 = (SyntaxNode).new(input, i2...index, s2)
        r2.extend(MetaTuple0)
      else
        self.index = i2
        r2 = nil
      end
      s0 << r2
      if r2
        r6 = _nt_meta_value
        s0 << r6
        if r6
          if input.index("\n", index) == index
            r7 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("\n")
            r7 = nil
          end
          s0 << r7
        end
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(MetaTuple1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:meta_tuple][start_index] = r0

    return r0
  end

  module MetaKey0
  end

  def _nt_meta_key
    start_index = index
    if node_cache[:meta_key].has_key?(index)
      cached = node_cache[:meta_key][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index(Regexp.new('[A-Za-z_]'), index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        if input.index(Regexp.new('[A-Za-z0-9_]'), index) == index
          r3 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = SyntaxNode.new(input, i2...index, s2)
      s0 << r2
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(MetaKey0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:meta_key][start_index] = r0

    return r0
  end

  module MetaValue0
  end

  def _nt_meta_value
    start_index = index
    if node_cache[:meta_value].has_key?(index)
      cached = node_cache[:meta_value][index]
      @index = cached.interval.end if cached
      return cached
    end

    s0, i0 = [], index
    loop do
      i1, s1 = index, []
      i2 = index
      if input.index("\n", index) == index
        r3 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("\n")
        r3 = nil
      end
      if r3
        r2 = nil
      else
        self.index = i2
        r2 = SyntaxNode.new(input, index...index)
      end
      s1 << r2
      if r2
        if index < input_length
          r4 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("any character")
          r4 = nil
        end
        s1 << r4
      end
      if s1.last
        r1 = (SyntaxNode).new(input, i1...index, s1)
        r1.extend(MetaValue0)
      else
        self.index = i1
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    r0 = SyntaxNode.new(input, i0...index, s0)

    node_cache[:meta_value][start_index] = r0

    return r0
  end

  def _nt_meta_separator
    start_index = index
    if node_cache[:meta_separator].has_key?(index)
      cached = node_cache[:meta_separator][index]
      @index = cached.interval.end if cached
      return cached
    end

    if input.index("+++\n", index) == index
      r0 = (SyntaxNode).new(input, index...(index + 4))
      @index += 4
    else
      terminal_parse_failure("+++\n")
      r0 = nil
    end

    node_cache[:meta_separator][start_index] = r0

    return r0
  end

  def _nt_code
    start_index = index
    if node_cache[:code].has_key?(index)
      cached = node_cache[:code][index]
      @index = cached.interval.end if cached
      return cached
    end

    s0, i0 = [], index
    loop do
      i1 = index
      r2 = _nt_empty_line
      if r2
        r1 = r2
      else
        r3 = _nt_doc_comment
        if r3
          r1 = r3
        else
          r4 = _nt_statement
          if r4
            r1 = r4
          else
            self.index = i1
            r1 = nil
          end
        end
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    r0 = Code.new(input, i0...index, s0)

    node_cache[:code][start_index] = r0

    return r0
  end

  module EmptyLine0
  end

  def _nt_empty_line
    start_index = index
    if node_cache[:empty_line].has_key?(index)
      cached = node_cache[:empty_line][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    s1, i1 = [], index
    loop do
      r2 = _nt_whitespace
      if r2
        s1 << r2
      else
        break
      end
    end
    r1 = SyntaxNode.new(input, i1...index, s1)
    s0 << r1
    if r1
      if input.index("\n", index) == index
        r3 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("\n")
        r3 = nil
      end
      s0 << r3
    end
    if s0.last
      r0 = (EmptyLine).new(input, i0...index, s0)
      r0.extend(EmptyLine0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:empty_line][start_index] = r0

    return r0
  end

  module DocComment0
  end

  module DocComment1
  end

  module DocComment2
    def comment_text_nodes
      elements[4]
    end

  end

  def _nt_doc_comment
    start_index = index
    if node_cache[:doc_comment].has_key?(index)
      cached = node_cache[:doc_comment][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    s1, i1 = [], index
    loop do
      r2 = _nt_whitespace
      if r2
        s1 << r2
      else
        break
      end
    end
    r1 = SyntaxNode.new(input, i1...index, s1)
    s0 << r1
    if r1
      if input.index("---", index) == index
        r3 = (SyntaxNode).new(input, index...(index + 3))
        @index += 3
      else
        terminal_parse_failure("---")
        r3 = nil
      end
      s0 << r3
      if r3
        s4, i4 = [], index
        loop do
          if input.index(Regexp.new('[\\x00-\\x09\\x0b-\\xff]'), index) == index
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
        r4 = SyntaxNode.new(input, i4...index, s4)
        s0 << r4
        if r4
          if input.index("\n", index) == index
            r6 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("\n")
            r6 = nil
          end
          s0 << r6
          if r6
            s7, i7 = [], index
            loop do
              i8, s8 = index, []
              i9 = index
              if input.index("---", index) == index
                r10 = (SyntaxNode).new(input, index...(index + 3))
                @index += 3
              else
                terminal_parse_failure("---")
                r10 = nil
              end
              if r10
                r9 = nil
              else
                self.index = i9
                r9 = SyntaxNode.new(input, index...index)
              end
              s8 << r9
              if r9
                s11, i11 = [], index
                loop do
                  i12, s12 = index, []
                  i13 = index
                  if input.index("\n", index) == index
                    r14 = (SyntaxNode).new(input, index...(index + 1))
                    @index += 1
                  else
                    terminal_parse_failure("\n")
                    r14 = nil
                  end
                  if r14
                    r13 = nil
                  else
                    self.index = i13
                    r13 = SyntaxNode.new(input, index...index)
                  end
                  s12 << r13
                  if r13
                    if index < input_length
                      r15 = (SyntaxNode).new(input, index...(index + 1))
                      @index += 1
                    else
                      terminal_parse_failure("any character")
                      r15 = nil
                    end
                    s12 << r15
                  end
                  if s12.last
                    r12 = (SyntaxNode).new(input, i12...index, s12)
                    r12.extend(DocComment0)
                  else
                    self.index = i12
                    r12 = nil
                  end
                  if r12
                    s11 << r12
                  else
                    break
                  end
                end
                r11 = SyntaxNode.new(input, i11...index, s11)
                s8 << r11
                if r11
                  if input.index("\n", index) == index
                    r16 = (SyntaxNode).new(input, index...(index + 1))
                    @index += 1
                  else
                    terminal_parse_failure("\n")
                    r16 = nil
                  end
                  s8 << r16
                end
              end
              if s8.last
                r8 = (SyntaxNode).new(input, i8...index, s8)
                r8.extend(DocComment1)
              else
                self.index = i8
                r8 = nil
              end
              if r8
                s7 << r8
              else
                break
              end
            end
            r7 = SyntaxNode.new(input, i7...index, s7)
            s0 << r7
            if r7
              s17, i17 = [], index
              loop do
                r18 = _nt_whitespace
                if r18
                  s17 << r18
                else
                  break
                end
              end
              r17 = SyntaxNode.new(input, i17...index, s17)
              s0 << r17
              if r17
                if input.index("---", index) == index
                  r19 = (SyntaxNode).new(input, index...(index + 3))
                  @index += 3
                else
                  terminal_parse_failure("---")
                  r19 = nil
                end
                s0 << r19
                if r19
                  s20, i20 = [], index
                  loop do
                    if input.index(Regexp.new('[\\x00-\\x09\\x0b-\\xff]'), index) == index
                      r21 = (SyntaxNode).new(input, index...(index + 1))
                      @index += 1
                    else
                      r21 = nil
                    end
                    if r21
                      s20 << r21
                    else
                      break
                    end
                  end
                  r20 = SyntaxNode.new(input, i20...index, s20)
                  s0 << r20
                  if r20
                    if input.index("\n", index) == index
                      r22 = (SyntaxNode).new(input, index...(index + 1))
                      @index += 1
                    else
                      terminal_parse_failure("\n")
                      r22 = nil
                    end
                    s0 << r22
                  end
                end
              end
            end
          end
        end
      end
    end
    if s0.last
      r0 = (DocComment).new(input, i0...index, s0)
      r0.extend(DocComment2)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:doc_comment][start_index] = r0

    return r0
  end

  module Statement0
    def expression
      elements[0]
    end

    def consume_eol
      elements[1]
    end
  end

  def _nt_statement
    start_index = index
    if node_cache[:statement].has_key?(index)
      cached = node_cache[:statement][index]
      @index = cached.interval.end if cached
      return cached
    end

    s0, i0 = [], index
    loop do
      i1, s1 = index, []
      r2 = _nt_expression
      s1 << r2
      if r2
        r3 = _nt_consume_eol
        s1 << r3
      end
      if s1.last
        r1 = (SyntaxNode).new(input, i1...index, s1)
        r1.extend(Statement0)
      else
        self.index = i1
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    if s0.empty?
      self.index = i0
      r0 = nil
    else
      r0 = Statement.new(input, i0...index, s0)
    end

    node_cache[:statement][start_index] = r0

    return r0
  end

  module EolWithComment0
  end

  module EolWithComment1
  end

  module EolWithComment2
    def eol
      elements[2]
    end
  end

  def _nt_eol_with_comment
    start_index = index
    if node_cache[:eol_with_comment].has_key?(index)
      cached = node_cache[:eol_with_comment][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    i2, s2 = index, []
    s3, i3 = [], index
    loop do
      r4 = _nt_whitespace
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
    s2 << r3
    if r3
      if input.index("//", index) == index
        r5 = (SyntaxNode).new(input, index...(index + 2))
        @index += 2
      else
        terminal_parse_failure("//")
        r5 = nil
      end
      s2 << r5
      if r5
        s6, i6 = [], index
        loop do
          i7, s7 = index, []
          i8 = index
          if input.index("\n", index) == index
            r9 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("\n")
            r9 = nil
          end
          if r9
            r8 = nil
          else
            self.index = i8
            r8 = SyntaxNode.new(input, index...index)
          end
          s7 << r8
          if r8
            if index < input_length
              r10 = (SyntaxNode).new(input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure("any character")
              r10 = nil
            end
            s7 << r10
          end
          if s7.last
            r7 = (SyntaxNode).new(input, i7...index, s7)
            r7.extend(EolWithComment0)
          else
            self.index = i7
            r7 = nil
          end
          if r7
            s6 << r7
          else
            break
          end
        end
        r6 = SyntaxNode.new(input, i6...index, s6)
        s2 << r6
      end
    end
    if s2.last
      r2 = (SyntaxNode).new(input, i2...index, s2)
      r2.extend(EolWithComment1)
    else
      self.index = i2
      r2 = nil
    end
    if r2
      r1 = r2
    else
      r1 = SyntaxNode.new(input, index...index)
    end
    s0 << r1
    if r1
      s11, i11 = [], index
      loop do
        r12 = _nt_whitespace
        if r12
          s11 << r12
        else
          break
        end
      end
      r11 = SyntaxNode.new(input, i11...index, s11)
      s0 << r11
      if r11
        r13 = _nt_eol
        s0 << r13
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(EolWithComment2)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:eol_with_comment][start_index] = r0

    return r0
  end

  def _nt_consume_eol
    start_index = index
    if node_cache[:consume_eol].has_key?(index)
      cached = node_cache[:consume_eol][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    if input.index("\n", index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("\n")
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i2 = index
      if index < input_length
        r3 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("any character")
        r3 = nil
      end
      if r3
        r2 = nil
      else
        self.index = i2
        r2 = SyntaxNode.new(input, index...index)
      end
      if r2
        r0 = r2
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:consume_eol][start_index] = r0

    return r0
  end

  def _nt_eol
    start_index = index
    if node_cache[:eol].has_key?(index)
      cached = node_cache[:eol][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1 = index
    if input.index("\n", index) == index
      r2 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("\n")
      r2 = nil
    end
    if r2
      self.index = i1
      r1 = SyntaxNode.new(input, index...index)
    else
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i3 = index
      if index < input_length
        r4 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("any character")
        r4 = nil
      end
      if r4
        r3 = nil
      else
        self.index = i3
        r3 = SyntaxNode.new(input, index...index)
      end
      if r3
        r0 = r3
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:eol][start_index] = r0

    return r0
  end

  def _nt_expression
    start_index = index
    if node_cache[:expression].has_key?(index)
      cached = node_cache[:expression][index]
      @index = cached.interval.end if cached
      return cached
    end

    r0 = _nt_chain

    node_cache[:expression][start_index] = r0

    return r0
  end

  module Chain0
  end

  def _nt_chain
    start_index = index
    if node_cache[:chain].has_key?(index)
      cached = node_cache[:chain][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    r2 = _nt_receiver
    if r2
      r1 = r2
    else
      r1 = SyntaxNode.new(input, index...index)
    end
    s0 << r1
    if r1
      s3, i3 = [], index
      loop do
        i4 = index
        r5 = _nt_required_call
        if r5
          r4 = r5
        else
          r6 = _nt_optional_call
          if r6
            r4 = r6
          else
            self.index = i4
            r4 = nil
          end
        end
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
    if s0.last
      r0 = (Chain).new(input, i0...index, s0)
      r0.extend(Chain0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:chain][start_index] = r0

    return r0
  end

  def _nt_receiver
    start_index = index
    if node_cache[:receiver].has_key?(index)
      cached = node_cache[:receiver][index]
      @index = cached.interval.end if cached
      return cached
    end

    r0 = _nt_value

    node_cache[:receiver][start_index] = r0

    return r0
  end

  module RequiredCall0
    def methodname
      elements[1]
    end

    def arguments
      elements[2]
    end
  end

  def _nt_required_call
    start_index = index
    if node_cache[:required_call].has_key?(index)
      cached = node_cache[:required_call][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index(".", index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure(".")
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_bareword
      s0 << r2
      if r2
        r3 = _nt_arguments
        s0 << r3
      end
    end
    if s0.last
      r0 = (RequiredCall).new(input, i0...index, s0)
      r0.extend(RequiredCall0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:required_call][start_index] = r0

    return r0
  end

  module OptionalCall0
    def methodname
      elements[1]
    end

    def arguments
      elements[2]
    end
  end

  def _nt_optional_call
    start_index = index
    if node_cache[:optional_call].has_key?(index)
      cached = node_cache[:optional_call][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index(".", index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure(".")
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_bareword
      s0 << r2
      if r2
        r3 = _nt_arguments
        s0 << r3
      end
    end
    if s0.last
      r0 = (OptionalCall).new(input, i0...index, s0)
      r0.extend(OptionalCall0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:optional_call][start_index] = r0

    return r0
  end

  def _nt_value
    start_index = index
    if node_cache[:value].has_key?(index)
      cached = node_cache[:value][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_variable
    if r1
      r0 = r1
    else
      r2 = _nt_literal
      if r2
        r0 = r2
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:value][start_index] = r0

    return r0
  end

  def _nt_variable
    start_index = index
    if node_cache[:variable].has_key?(index)
      cached = node_cache[:variable][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_constant
    if r1
      r0 = r1
    else
      r2 = _nt_instance_variable
      if r2
        r0 = r2
      else
        r3 = _nt_local_variable
        if r3
          r0 = r3
        else
          r4 = _nt_bound_variable
          if r4
            r0 = r4
          else
            self.index = i0
            r0 = nil
          end
        end
      end
    end

    node_cache[:variable][start_index] = r0

    return r0
  end

  module Constant0
    def bareword
      elements[1]
    end
  end

  def _nt_constant
    start_index = index
    if node_cache[:constant].has_key?(index)
      cached = node_cache[:constant][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index(":", index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure(":")
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_bareword
      s0 << r2
    end
    if s0.last
      r0 = (Constant).new(input, i0...index, s0)
      r0.extend(Constant0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:constant][start_index] = r0

    return r0
  end

  module InstanceVariable0
    def bareword
      elements[1]
    end
  end

  def _nt_instance_variable
    start_index = index
    if node_cache[:instance_variable].has_key?(index)
      cached = node_cache[:instance_variable][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index("@", index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("@")
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_bareword
      s0 << r2
    end
    if s0.last
      r0 = (InstanceVariable).new(input, i0...index, s0)
      r0.extend(InstanceVariable0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:instance_variable][start_index] = r0

    return r0
  end

  module LocalVariable0
    def bareword
      elements[1]
    end
  end

  def _nt_local_variable
    start_index = index
    if node_cache[:local_variable].has_key?(index)
      cached = node_cache[:local_variable][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index("$", index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("$")
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_bareword
      s0 << r2
    end
    if s0.last
      r0 = (LocalVariable).new(input, i0...index, s0)
      r0.extend(LocalVariable0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:local_variable][start_index] = r0

    return r0
  end

  module BoundVariable0
    def bareword
      elements[1]
    end
  end

  def _nt_bound_variable
    start_index = index
    if node_cache[:bound_variable].has_key?(index)
      cached = node_cache[:bound_variable][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index("!", index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("!")
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_bareword
      s0 << r2
    end
    if s0.last
      r0 = (BoundVariable).new(input, i0...index, s0)
      r0.extend(BoundVariable0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:bound_variable][start_index] = r0

    return r0
  end

  module Bareword0
  end

  def _nt_bareword
    start_index = index
    if node_cache[:bareword].has_key?(index)
      cached = node_cache[:bareword][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index(Regexp.new('[A-Za-z_]'), index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        if input.index(Regexp.new('[A-Za-z0-9_]'), index) == index
          r3 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = SyntaxNode.new(input, i2...index, s2)
      s0 << r2
    end
    if s0.last
      r0 = (Bareword).new(input, i0...index, s0)
      r0.extend(Bareword0)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:bareword][start_index] = r0

    return r0
  end

  module Arguments0
    def argument
      elements[1]
    end
  end

  module Arguments1
    def argument
      elements[0]
    end

  end

  module Arguments2
  end

  def _nt_arguments
    start_index = index
    if node_cache[:arguments].has_key?(index)
      cached = node_cache[:arguments][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index("(", index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("(")
      r1 = nil
    end
    s0 << r1
    if r1
      i3, s3 = index, []
      r4 = _nt_argument
      s3 << r4
      if r4
        s5, i5 = [], index
        loop do
          i6, s6 = index, []
          if input.index(", ", index) == index
            r7 = (SyntaxNode).new(input, index...(index + 2))
            @index += 2
          else
            terminal_parse_failure(", ")
            r7 = nil
          end
          s6 << r7
          if r7
            r8 = _nt_argument
            s6 << r8
          end
          if s6.last
            r6 = (SyntaxNode).new(input, i6...index, s6)
            r6.extend(Arguments0)
          else
            self.index = i6
            r6 = nil
          end
          if r6
            s5 << r6
          else
            break
          end
        end
        r5 = SyntaxNode.new(input, i5...index, s5)
        s3 << r5
      end
      if s3.last
        r3 = (SyntaxNode).new(input, i3...index, s3)
        r3.extend(Arguments1)
      else
        self.index = i3
        r3 = nil
      end
      if r3
        r2 = r3
      else
        r2 = SyntaxNode.new(input, index...index)
      end
      s0 << r2
      if r2
        if input.index(")", index) == index
          r9 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure(")")
          r9 = nil
        end
        s0 << r9
      end
    end
    if s0.last
      r0 = (ArgumentList).new(input, i0...index, s0)
      r0.extend(Arguments2)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:arguments][start_index] = r0

    return r0
  end

  module Argument0
    def bareword
      elements[0]
    end

  end

  module Argument1
    def value
      elements[1]
    end
  end

  def _nt_argument
    start_index = index
    if node_cache[:argument].has_key?(index)
      cached = node_cache[:argument][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    i2, s2 = index, []
    r3 = _nt_bareword
    s2 << r3
    if r3
      if input.index(": ", index) == index
        r4 = (SyntaxNode).new(input, index...(index + 2))
        @index += 2
      else
        terminal_parse_failure(": ")
        r4 = nil
      end
      s2 << r4
    end
    if s2.last
      r2 = (SyntaxNode).new(input, i2...index, s2)
      r2.extend(Argument0)
    else
      self.index = i2
      r2 = nil
    end
    if r2
      r1 = r2
    else
      r1 = SyntaxNode.new(input, index...index)
    end
    s0 << r1
    if r1
      r5 = _nt_value
      s0 << r5
    end
    if s0.last
      r0 = (Argument).new(input, i0...index, s0)
      r0.extend(Argument1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:argument][start_index] = r0

    return r0
  end

  def _nt_whitespace
    start_index = index
    if node_cache[:whitespace].has_key?(index)
      cached = node_cache[:whitespace][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    if input.index(" ", index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure(" ")
      r1 = nil
    end
    if r1
      r0 = r1
    else
      if input.index("\t", index) == index
        r2 = (Whitespace).new(input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure("\t")
        r2 = nil
      end
      if r2
        r0 = r2
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:whitespace][start_index] = r0

    return r0
  end

  def _nt_literal
    start_index = index
    if node_cache[:literal].has_key?(index)
      cached = node_cache[:literal][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    r1 = _nt_primary_literal
    if r1
      r0 = r1
    else
      r2 = _nt_secondary_literal
      if r2
        r0 = r2
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:literal][start_index] = r0

    return r0
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

  module SecondaryLiteral0
  end

  module SecondaryLiteral1
    def type
      elements[1]
    end

    def data
      elements[2]
    end
  end

  def _nt_secondary_literal
    start_index = index
    if node_cache[:secondary_literal].has_key?(index)
      cached = node_cache[:secondary_literal][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index("%", index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("%")
      r1 = nil
    end
    s0 << r1
    if r1
      i3, s3 = index, []
      if input.index(Regexp.new('[A-Za-z_]'), index) == index
        r4 = (SyntaxNode).new(input, index...(index + 1))
        @index += 1
      else
        r4 = nil
      end
      s3 << r4
      if r4
        s5, i5 = [], index
        loop do
          if input.index(Regexp.new('[A-Za-z0-9_]'), index) == index
            r6 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            r6 = nil
          end
          if r6
            s5 << r6
          else
            break
          end
        end
        r5 = SyntaxNode.new(input, i5...index, s5)
        s3 << r5
      end
      if s3.last
        r3 = (SyntaxNode).new(input, i3...index, s3)
        r3.extend(SecondaryLiteral0)
      else
        self.index = i3
        r3 = nil
      end
      if r3
        r2 = r3
      else
        r2 = SyntaxNode.new(input, index...index)
      end
      s0 << r2
      if r2
        r7 = _nt_secondary_squote
        s0 << r7
      end
    end
    if s0.last
      r0 = (SecondaryLiteral).new(input, i0...index, s0)
      r0.extend(SecondaryLiteral1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:secondary_literal][start_index] = r0

    return r0
  end

  module SecondaryCurlyBraces0
    def secondary_curly_braces
      elements[1]
    end

  end

  module SecondaryCurlyBraces1
  end

  def _nt_secondary_curly_braces
    start_index = index
    if node_cache[:secondary_curly_braces].has_key?(index)
      cached = node_cache[:secondary_curly_braces][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    if input.index("{", index) == index
      r2 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("{")
      r2 = nil
    end
    s1 << r2
    if r2
      r3 = _nt_secondary_curly_braces
      s1 << r3
      if r3
        if input.index("}", index) == index
          r4 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("}")
          r4 = nil
        end
        s1 << r4
      end
    end
    if s1.last
      r1 = (SyntaxNode).new(input, i1...index, s1)
      r1.extend(SecondaryCurlyBraces0)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      s5, i5 = [], index
      loop do
        i6 = index
        i7, s7 = index, []
        i8 = index
        if input.index("}", index) == index
          r9 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("}")
          r9 = nil
        end
        if r9
          r8 = nil
        else
          self.index = i8
          r8 = SyntaxNode.new(input, index...index)
        end
        s7 << r8
        if r8
          if index < input_length
            r10 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("any character")
            r10 = nil
          end
          s7 << r10
        end
        if s7.last
          r7 = (SyntaxNode).new(input, i7...index, s7)
          r7.extend(SecondaryCurlyBraces1)
        else
          self.index = i7
          r7 = nil
        end
        if r7
          r6 = r7
        else
          if input.index('\}', index) == index
            r11 = (SyntaxNode).new(input, index...(index + 2))
            @index += 2
          else
            terminal_parse_failure('\}')
            r11 = nil
          end
          if r11
            r6 = r11
          else
            self.index = i6
            r6 = nil
          end
        end
        if r6
          s5 << r6
        else
          break
        end
      end
      r5 = SyntaxNode.new(input, i5...index, s5)
      if r5
        r0 = r5
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:secondary_curly_braces][start_index] = r0

    return r0
  end

  module SecondaryParens0
    def secondary_parens
      elements[1]
    end

  end

  module SecondaryParens1
  end

  def _nt_secondary_parens
    start_index = index
    if node_cache[:secondary_parens].has_key?(index)
      cached = node_cache[:secondary_parens][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    if input.index("(", index) == index
      r2 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("(")
      r2 = nil
    end
    s1 << r2
    if r2
      r3 = _nt_secondary_parens
      s1 << r3
      if r3
        if input.index(")", index) == index
          r4 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure(")")
          r4 = nil
        end
        s1 << r4
      end
    end
    if s1.last
      r1 = (SyntaxNode).new(input, i1...index, s1)
      r1.extend(SecondaryParens0)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      s5, i5 = [], index
      loop do
        i6 = index
        i7, s7 = index, []
        i8 = index
        if input.index(")", index) == index
          r9 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure(")")
          r9 = nil
        end
        if r9
          r8 = nil
        else
          self.index = i8
          r8 = SyntaxNode.new(input, index...index)
        end
        s7 << r8
        if r8
          if index < input_length
            r10 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("any character")
            r10 = nil
          end
          s7 << r10
        end
        if s7.last
          r7 = (SyntaxNode).new(input, i7...index, s7)
          r7.extend(SecondaryParens1)
        else
          self.index = i7
          r7 = nil
        end
        if r7
          r6 = r7
        else
          if input.index('\)', index) == index
            r11 = (SyntaxNode).new(input, index...(index + 2))
            @index += 2
          else
            terminal_parse_failure('\)')
            r11 = nil
          end
          if r11
            r6 = r11
          else
            self.index = i6
            r6 = nil
          end
        end
        if r6
          s5 << r6
        else
          break
        end
      end
      r5 = SyntaxNode.new(input, i5...index, s5)
      if r5
        r0 = r5
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:secondary_parens][start_index] = r0

    return r0
  end

  module SecondaryBrackets0
    def secondary_brackets
      elements[1]
    end

  end

  module SecondaryBrackets1
  end

  def _nt_secondary_brackets
    start_index = index
    if node_cache[:secondary_brackets].has_key?(index)
      cached = node_cache[:secondary_brackets][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    if input.index("[", index) == index
      r2 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("[")
      r2 = nil
    end
    s1 << r2
    if r2
      r3 = _nt_secondary_brackets
      s1 << r3
      if r3
        if input.index("]", index) == index
          r4 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("]")
          r4 = nil
        end
        s1 << r4
      end
    end
    if s1.last
      r1 = (SyntaxNode).new(input, i1...index, s1)
      r1.extend(SecondaryBrackets0)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      s5, i5 = [], index
      loop do
        i6 = index
        i7, s7 = index, []
        i8 = index
        if input.index("]", index) == index
          r9 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("]")
          r9 = nil
        end
        if r9
          r8 = nil
        else
          self.index = i8
          r8 = SyntaxNode.new(input, index...index)
        end
        s7 << r8
        if r8
          if index < input_length
            r10 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("any character")
            r10 = nil
          end
          s7 << r10
        end
        if s7.last
          r7 = (SyntaxNode).new(input, i7...index, s7)
          r7.extend(SecondaryBrackets1)
        else
          self.index = i7
          r7 = nil
        end
        if r7
          r6 = r7
        else
          if input.index('\]', index) == index
            r11 = (SyntaxNode).new(input, index...(index + 2))
            @index += 2
          else
            terminal_parse_failure('\]')
            r11 = nil
          end
          if r11
            r6 = r11
          else
            self.index = i6
            r6 = nil
          end
        end
        if r6
          s5 << r6
        else
          break
        end
      end
      r5 = SyntaxNode.new(input, i5...index, s5)
      if r5
        r0 = r5
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:secondary_brackets][start_index] = r0

    return r0
  end

  module SecondaryAngle0
    def secondary_angle
      elements[1]
    end

  end

  module SecondaryAngle1
  end

  def _nt_secondary_angle
    start_index = index
    if node_cache[:secondary_angle].has_key?(index)
      cached = node_cache[:secondary_angle][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0 = index
    i1, s1 = index, []
    if input.index("<", index) == index
      r2 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("<")
      r2 = nil
    end
    s1 << r2
    if r2
      r3 = _nt_secondary_angle
      s1 << r3
      if r3
        if input.index(">", index) == index
          r4 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure(">")
          r4 = nil
        end
        s1 << r4
      end
    end
    if s1.last
      r1 = (SyntaxNode).new(input, i1...index, s1)
      r1.extend(SecondaryAngle0)
    else
      self.index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      s5, i5 = [], index
      loop do
        i6 = index
        i7, s7 = index, []
        i8 = index
        if input.index(">", index) == index
          r9 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure(">")
          r9 = nil
        end
        if r9
          r8 = nil
        else
          self.index = i8
          r8 = SyntaxNode.new(input, index...index)
        end
        s7 << r8
        if r8
          if index < input_length
            r10 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("any character")
            r10 = nil
          end
          s7 << r10
        end
        if s7.last
          r7 = (SyntaxNode).new(input, i7...index, s7)
          r7.extend(SecondaryAngle1)
        else
          self.index = i7
          r7 = nil
        end
        if r7
          r6 = r7
        else
          if input.index('\>', index) == index
            r11 = (SyntaxNode).new(input, index...(index + 2))
            @index += 2
          else
            terminal_parse_failure('\>')
            r11 = nil
          end
          if r11
            r6 = r11
          else
            self.index = i6
            r6 = nil
          end
        end
        if r6
          s5 << r6
        else
          break
        end
      end
      r5 = SyntaxNode.new(input, i5...index, s5)
      if r5
        r0 = r5
      else
        self.index = i0
        r0 = nil
      end
    end

    node_cache[:secondary_angle][start_index] = r0

    return r0
  end

  module SecondarySquote0
  end

  module SecondarySquote1
  end

  def _nt_secondary_squote
    start_index = index
    if node_cache[:secondary_squote].has_key?(index)
      cached = node_cache[:secondary_squote][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index("'", index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure("'")
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        i3 = index
        i4, s4 = index, []
        i5 = index
        if input.index("'", index) == index
          r6 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("'")
          r6 = nil
        end
        if r6
          r5 = nil
        else
          self.index = i5
          r5 = SyntaxNode.new(input, index...index)
        end
        s4 << r5
        if r5
          if index < input_length
            r7 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("any character")
            r7 = nil
          end
          s4 << r7
        end
        if s4.last
          r4 = (SyntaxNode).new(input, i4...index, s4)
          r4.extend(SecondarySquote0)
        else
          self.index = i4
          r4 = nil
        end
        if r4
          r3 = r4
        else
          if input.index("\\'", index) == index
            r8 = (SyntaxNode).new(input, index...(index + 2))
            @index += 2
          else
            terminal_parse_failure("\\'")
            r8 = nil
          end
          if r8
            r3 = r8
          else
            self.index = i3
            r3 = nil
          end
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = SyntaxNode.new(input, i2...index, s2)
      s0 << r2
      if r2
        if input.index("'", index) == index
          r9 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("'")
          r9 = nil
        end
        s0 << r9
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(SecondarySquote1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:secondary_squote][start_index] = r0

    return r0
  end

  module SecondaryDquote0
  end

  module SecondaryDquote1
  end

  def _nt_secondary_dquote
    start_index = index
    if node_cache[:secondary_dquote].has_key?(index)
      cached = node_cache[:secondary_dquote][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('"', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('"')
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        i3 = index
        i4, s4 = index, []
        i5 = index
        if input.index('"', index) == index
          r6 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure('"')
          r6 = nil
        end
        if r6
          r5 = nil
        else
          self.index = i5
          r5 = SyntaxNode.new(input, index...index)
        end
        s4 << r5
        if r5
          if index < input_length
            r7 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("any character")
            r7 = nil
          end
          s4 << r7
        end
        if s4.last
          r4 = (SyntaxNode).new(input, i4...index, s4)
          r4.extend(SecondaryDquote0)
        else
          self.index = i4
          r4 = nil
        end
        if r4
          r3 = r4
        else
          if input.index('\"', index) == index
            r8 = (SyntaxNode).new(input, index...(index + 2))
            @index += 2
          else
            terminal_parse_failure('\"')
            r8 = nil
          end
          if r8
            r3 = r8
          else
            self.index = i3
            r3 = nil
          end
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = SyntaxNode.new(input, i2...index, s2)
      s0 << r2
      if r2
        if input.index('"', index) == index
          r9 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure('"')
          r9 = nil
        end
        s0 << r9
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(SecondaryDquote1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:secondary_dquote][start_index] = r0

    return r0
  end

  module SecondaryBacktick0
  end

  module SecondaryBacktick1
  end

  def _nt_secondary_backtick
    start_index = index
    if node_cache[:secondary_backtick].has_key?(index)
      cached = node_cache[:secondary_backtick][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('`', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('`')
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        i3 = index
        i4, s4 = index, []
        i5 = index
        if input.index('`', index) == index
          r6 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure('`')
          r6 = nil
        end
        if r6
          r5 = nil
        else
          self.index = i5
          r5 = SyntaxNode.new(input, index...index)
        end
        s4 << r5
        if r5
          if index < input_length
            r7 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("any character")
            r7 = nil
          end
          s4 << r7
        end
        if s4.last
          r4 = (SyntaxNode).new(input, i4...index, s4)
          r4.extend(SecondaryBacktick0)
        else
          self.index = i4
          r4 = nil
        end
        if r4
          r3 = r4
        else
          if input.index('\`', index) == index
            r8 = (SyntaxNode).new(input, index...(index + 2))
            @index += 2
          else
            terminal_parse_failure('\`')
            r8 = nil
          end
          if r8
            r3 = r8
          else
            self.index = i3
            r3 = nil
          end
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = SyntaxNode.new(input, i2...index, s2)
      s0 << r2
      if r2
        if input.index('`', index) == index
          r9 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure('`')
          r9 = nil
        end
        s0 << r9
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(SecondaryBacktick1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:secondary_backtick][start_index] = r0

    return r0
  end

  module SecondarySlash0
  end

  module SecondarySlash1
  end

  def _nt_secondary_slash
    start_index = index
    if node_cache[:secondary_slash].has_key?(index)
      cached = node_cache[:secondary_slash][index]
      @index = cached.interval.end if cached
      return cached
    end

    i0, s0 = index, []
    if input.index('/', index) == index
      r1 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('/')
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        i3 = index
        i4, s4 = index, []
        i5 = index
        if input.index('/', index) == index
          r6 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure('/')
          r6 = nil
        end
        if r6
          r5 = nil
        else
          self.index = i5
          r5 = SyntaxNode.new(input, index...index)
        end
        s4 << r5
        if r5
          if index < input_length
            r7 = (SyntaxNode).new(input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure("any character")
            r7 = nil
          end
          s4 << r7
        end
        if s4.last
          r4 = (SyntaxNode).new(input, i4...index, s4)
          r4.extend(SecondarySlash0)
        else
          self.index = i4
          r4 = nil
        end
        if r4
          r3 = r4
        else
          if input.index('\/', index) == index
            r8 = (SyntaxNode).new(input, index...(index + 2))
            @index += 2
          else
            terminal_parse_failure('\/')
            r8 = nil
          end
          if r8
            r3 = r8
          else
            self.index = i3
            r3 = nil
          end
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = SyntaxNode.new(input, i2...index, s2)
      s0 << r2
      if r2
        if input.index('/', index) == index
          r9 = (SyntaxNode).new(input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure('/')
          r9 = nil
        end
        s0 << r9
      end
    end
    if s0.last
      r0 = (SyntaxNode).new(input, i0...index, s0)
      r0.extend(SecondarySlash1)
    else
      self.index = i0
      r0 = nil
    end

    node_cache[:secondary_slash][start_index] = r0

    return r0
  end

  def _nt_digit
    start_index = index
    if node_cache[:digit].has_key?(index)
      cached = node_cache[:digit][index]
      @index = cached.interval.end if cached
      return cached
    end

    if input.index(Regexp.new('[0-9]'), index) == index
      r0 = (SyntaxNode).new(input, index...(index + 1))
      @index += 1
    else
      r0 = nil
    end

    node_cache[:digit][start_index] = r0

    return r0
  end

end

class HalsbeParser < Treetop::Runtime::CompiledParser
  include Halsbe
end

