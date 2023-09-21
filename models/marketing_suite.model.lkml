# Define the database connection to be used for this model.

connection: "ga_tbc_test"

# include all the views
include: "/views/**/*.view.lkml"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: marketing_suite_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: marketing_suite_default_datagroup

# Explores allow you to join together different views (database tables) based on the
# relationships between fields. By joining a view into an Explore, you make those
# fields available to users for data analysis.
# Explores should be purpose-built for specific use cases.

# To see the Explore you’re building, navigate to the Explore menu and select an Explore under "Marketing Suite"

explore: events {
  join: events__items {
    view_label: "Events : Items"
    sql: LEFT JOIN UNNEST(${events.items}) as events__items ;;
    relationship: one_to_many
  }
  join: events__event_params {
    view_label: "Events : Event Params"
    sql: LEFT JOIN UNNEST(${events.event_params}) as events__event_params ;;
    relationship: one_to_many
  }
  join: events__user_properties {
    view_label: "Events : User Properties"
    sql: LEFT JOIN UNNEST(${events.user_properties}) as events__user_properties ;;
    relationship: one_to_many
  }
}
