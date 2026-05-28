with source as (

  select * from  {{ ref('raw_sponsors') }}

)

, final as (

  select
    {{ dbt_utils.generate_surrogate_key(['sponsor_id']) }} as stg_sponsor_id
    , sponsor_id
    , sponsor_name
    , cast(createdAt as timestamp) as created_at
  from source
  where sponsor_id not in ('sp_099')

)

select * from final
