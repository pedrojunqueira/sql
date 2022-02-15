
    with "1 to 10"(V) as (

    select 1 
    union all 
    select V + 1 from "1 to 10"
    where V < 10

    ),
    string_to_iter as (

    select ename
    from emp
    where ename = "King"

    )

    select ename 
    from emp
    cross join "1 to 10"



