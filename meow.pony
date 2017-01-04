actor Main
  new create(env: Env) =>
    let cat = """
 ______
< Meow >
 ------                       _..
        \    /}_{\           /.-'
         \  ( • • )-.___...-'/
            ==._.==         ;
                 \   _..._ /,
                 {_;/   {_//""""

    env.out.print(cat)
