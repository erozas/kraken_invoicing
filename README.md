# Kraken Invoicing
Kraken Invoicing es una gema para interactuar con la API de facturación de Kraken Bolivia en aplicaciones de Ruby o de Ruby on Rails. Fue hecha como extensión de la integración de Kraken para [PetServi](https://petservi.com.bo "PetServi: pet shop de mascotas en Santa Cruz, Bolivia").

Antes de utilizar esta gema necesitas contratar el servicio de Kraken y obtener credenciales de integración de prueba, de lo contrario no podrás utilizar **Kraken Invoicing** para facturar.

## Configuración
Para poder hacer peticiones con la API de Kraken hace falta agregar credenciales de autenticación de manera de que nuestras peticiones sean válidas.

En el caso particular de Kraken, necesitamos generar un ***JWT (JSON Web Token)*** para autenticar todas las peticiones que nos tengan que identificar como clientes válidos.

La gema puede generar un token utilizando el ***CLIENT_ID*** y el ***CLIENT_SECRET*** proporcionados por la integración de Kraken.

Además de esto, necesitamos un ***API_ENDPOINT*** que es el endpoint de Kraken contra el que haremos las peticiones. Este endpoint cambia de acuerdo al entorno sobre el que vayamos a trabajar. Cuando vayas a integrar la librería, el equipo de Kraken te guiará con respecto a las credenciales que tienes que usar.

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

Por ejemplo, podemos acceder al *client_id* dentro de otra clase haciendo **KrakenInvoicing.configuration.client_id**

## Uso de la gema para hacer peticiones
Para hacer peticiones usando esta gema necesitamos crear una instancia de KrakenInvoicing::Client.
```ruby
# Le pasamos un token de autenticación previamente obtenido
client = KrakenInvoicing::Client.new(auth_token)

# El cliente se autentica utilizando la información de configuración que tenemos en el initializer
client = KrakenInvoicing::Client.new()
```
Una vez tenemos un cliente instanciado, lo usaremos para hacer peticiones a través del concepto de recursos.

## Recursos
Los recursos en esta librería representan a los recursos expuestos en la API de Kraken. 

Por el momento, los recursos son: **Invoice, Branch, Activity y Cycle** para representar a las facturas, las sucursales
de negocio, las actividades económicas del negocio y los ciclos de facturación.

El cliente tiene un método para cada uno de estos recursos y cada recurso tiene métodos para realizar las acciones provistas
por la integración.

## Branch Resource
Este recurso nos permite acceder a los endpoints asociados con las sucursales de nuestro negocio.

```ruby
  # Devuelve una colección de sucursales
  branches = client.branches.list
```

## Activity Resource
Nos permite acceder a los endpoints asociados con las actividades económicas que nuestro negocio tiene registradas.

```ruby
  # Devuelve una colección de actividades económicas
  activities = client.activities.list
```

## Invoice Resource
Nos permite acceder a los endpoints asociados con las facturas. De esta forma podemos acceder a un listado de facturas,
a una factura en específico, enviar una factura por email, generar un PDF para una factura y crear una nueva factura.

```ruby
  # Devuelve una colección paginada con las facturas asociadas a nuestro negocio 
  invoices = client.invoices.list

  # Devuelve la información básica de una factura en específico
  invoice = client.invoices.show(invoice_id)

  # Envía una factura ya emitida por correo electrónico
  client.invoices.send_by_email(email, invoice_id)

  # Devuelve la factura en formato PDF
  client.invoices.get_pdf(invoice_id)
```

## Facturando con Kraken
Para facturar usando esta librería vamos a usar el recurso Invoice pero debemos considerar que los parámetros que le pasemos
tengan un formato específico de forma de crear la factura con éxito.

```ruby
  # Parámetros necesarios
    {
      branchId: "integer [required]",
      economicActivityId: "integer [required]",
      cdcf: "boolean",
      customer: {
        invoiceEmail: "string",
        name: "string [required]",
        nit: "integer [required]"
      },
      details: [
        {
          concept: "string [required]",
          isDiscount: "boolean",
          quantity: "integer [required]",
          unitPrice: "integer [required]",
          subtotal: "integer [required]",
          sequence: "integer",
        }
      ],
      note: "string (max-length: 100)",
      totalAmount: "int [required]",
      firstName: "string",
      lastName: "string"
    }

  # Creando una factura
  invoice = client.invoices.create(invoice_params) 
```

## Consideraciones
Toda integración con Kraken se hace coordinando con su equipo técnico pero algunas cosas a tener en cuenta:
* El token devuelto tras autenticarnos usando el usuario y la contraseña es un JWT (JSON Web Token) que tiene una fecha de expiración de 1 mes.
* Las URL de integración cambian al pasar a producción.
* Debes considerar los escenarios de error (ver api_error.rb) para resguardar el flujo en tu aplicación y actuar  en consecuencia.
