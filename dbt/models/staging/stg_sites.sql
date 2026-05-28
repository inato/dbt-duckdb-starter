with source as (

  select * from {{ ref('raw_sites') }}

)

, final as (

  select
    {{ dbt_utils.generate_surrogate_key(['site_id']) }} as stg_site_id
    , site_id
    , siteName
    , countryCode
    , country_name
  from source

)

select * from final
