import radius as radius
param application string

resource demo 'Applications.Core/containers@2022-03-15-privatepreview' = {
  name: 'demo'
  location: 'global'
  properties: {
    application: application
    container: {
      image: 'radius.azurecr.io/tutorial/webapp:edge'
      ports: {
        web: {
          containerPort: 3000
        }
      }
    }
    //CONNECTION
    connections: {
      redis: {
        source: db.id
      }
    }
    //CONNECTION
  }
}

//REDIS
param environment string
resource db 'Applications.Link/redisCaches@2022-03-15-privatepreview' = {
  name: 'db'
  location: 'global'
  properties: {
    application: application
    environment: environment
    mode: 'recipe'
    recipe: {
      name: 'redis-kubernetes'
    }
  }
}
//REDIS