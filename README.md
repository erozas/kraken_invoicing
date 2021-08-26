# Kraken Invoicing
Kraken Invoicing es una gema para interactuar con la API de facturación de Kraken Bolivia en aplicaciones de Ruby o de Ruby on Rails. Fue hecha como extensión de la integración de Kraken para [PetServi](https://petservi.com.bo "PetServi: pet shop de mascotas en Santa Cruz, Bolivia").

Antes de utilizar esta gema necesitas contratar el servicio de Kraken y obtener credenciales de integración de prueba, de lo contrario no podrás utilizar **Kraken Invoicing** para facturar.

## Configuración
Para poder hacer peticiones con la API de Kraken hace falta agregar credenciales de autenticación de manera de que nuestras peticiones sean válidas.

En el caso particular de Kraken, necesitamos generar un JWT (JSON Web Token) para autenticar todas las peticiones que nos tengan que identificar como clientes válidos.

La gema puede generar un token utilizando el *CLIENT_ID* y el *CLIENT_SECRET* proporcionados por la integración de Kraken.

Además de esto, necesitamos un *API_ENDPOINT* que es el endpoint de Kraken contra el que haremos las peticiones. Este endpoint cambia de acuerdo al entorno sobre el que vayamos a trabajar. Cuando vayas a integrar la librería, el equipo de Kraken te guiará con respecto a las credenciales que tienes que usar.

Para pasar esta información usamos el método *.configure* de la clase KrakenInvoicing antes de instanciar el cliente. 

```ruby
KrakenInvoicing.configure do |config|
  config.api_endpoint = 'https://endpoint-suministrado-por-kraken.com'
  config.auth_token = 'unTokenObtenidoPreviamente' 
  config.cliend_id = 'id_de_cliente_suministrador_por_kraken'
  config.client_secret = 'secreto_del_cliente_suministrado_por_kraken'
  config.remember_me = true
end
```
En Rails puedes hacer esto creando un initializer como por ejemplo: */config/initializers/kraken.rb* pegando el código de arriba. Con esto tendrás acceso a las variables de configuración de manera global.

Por ejemplo, podemos acceder al *client_id* dentro de otra clase haciendo **KrakenInvoicing.client_id**

## Uso de la gema para hacer peticiones
Para hacer peticiones usando esta gema necesitamos crear una instancia de KrakenInvoicing::Client.
```ruby
# Le pasamos un token de autenticación previamente obtenido
client = KrakenInvoicing::Client.new(auth_token)

# El cliente se autentica utilizando la información de configuración que tenemos en el initializer
client = KrakenInvoicing::Client.new()
```
