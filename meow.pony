actor Main
  let env: Env

  new create(env': Env) =>
    env = env'
    env.input(notify())

  be meow(input': Array[U8] val) =>
    // Get the user input as a string
    let input: String trn = recover String end
    input.append(String.from_array(input'))
    input.rstrip()

    // Build the borders that go at the top/bottom of the speech bubble
    var counter: U64 = 0
    var top_border = ""
    var bottom_border = ""
    var leading_whitespace = ""
    let length = input.size().u64() + 1

    while counter < length do
      top_border = top_border.add("_")
      bottom_border = bottom_border.add("-")
      leading_whitespace = leading_whitespace.add(" ")

      counter = counter + 1
    end

    env.out.print(" " + top_border)
    env.out.write("< " + consume input + " >\n")
    env.out.write(" " + bottom_border)

    var cat = ""
    cat = cat.add("""                      _..""" + "\n")
    cat = cat.add(leading_whitespace + """\    /}_{\           /.-'""" + "\n")
    cat = cat.add(leading_whitespace + """ \  ( • • )-.___...-'/""" + "\n")
    cat = cat.add(leading_whitespace + """    ==._.==         ;""" + "\n")
    cat = cat.add(leading_whitespace + """         \   _..._ /,""" + "\n")
    cat = cat.add(leading_whitespace + """         {_;/   {_//"""" + "\n")

    env.out.print(cat)

  fun tag notify(): StdinNotify iso^ =>
    object iso is StdinNotify
      let parent: Main = this

      fun ref apply(data: Array[U8] iso) =>
        parent.meow(consume data)
    end
