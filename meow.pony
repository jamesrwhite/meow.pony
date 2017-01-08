actor Main
  let env: Env

  new create(env': Env) =>
    env = env'
    env.input(notify())

  be meow(input': Array[U8] val) =>
    // Get the user input as a string
    let input: String = String.from_array(input')

    // Build the borders that go at the top/bottom of the speech bubble
    var top_counter: U64 = 0
    var bottom_counter: U64 = 0
    var top_border = ""
    var bottom_border = ""
    let length = input.size().u64()

    while top_counter < length do
      top_border = top_border.add("_")
      top_counter = top_counter + 1
    end

    while bottom_counter < length do
      bottom_border = bottom_border.add("-")
      bottom_counter = bottom_counter + 1
    end

    env.out.print(" " + top_border)
    env.out.write("< " + input + " >\n")
    env.out.print(" " + bottom_border)

    let cat = """
                              _..
        \    /}_{\           /.-'
         \  ( • • )-.___...-'/
            ==._.==         ;
                 \   _..._ /,
                 {_;/   {_//""""

      env.out.print(cat)

  fun tag notify(): StdinNotify iso^ =>
    object iso is StdinNotify
      let parent: Main = this

      fun ref apply(data: Array[U8] iso) =>
        parent.meow(consume data)
    end
