actor Main
  let env: Env

  new create(env': Env) =>
    env = env'
    env.input(notify())

  be meow(input': Array[U8] val) =>
    // Get the user input as a string
    let input: String = String.from_array(input')

    // Build the borders that go at the top/bottom of the speech bubble
    var counter: U64 = 0
    var border = ""
    let length = input.size().u64()

    while counter < length do
      border = border.add("-")
      counter = counter + 1
    end

    env.out.print(border)
    env.out.print(input)
    env.out.print(border)

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
