Apipie.configure do |config|
  config.app_name                = "iCast"
  config.api_base_url            = "/1"
  config.doc_base_url            = "/doc"
  # were is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/**/*.rb"

  # Don't use apipie parameter validation
  config.validate = false

  # Use Markdown for template language in Apipie
  config.markup = Apipie::Markup::Markdown.new

  config.app_info = <<-DESC
  # iCast API Documentation

  ## Introduction

  iCast is a collaborative and open stream directory (for WebRadios and WebTVs).
  It's content is available under a CC-BY- SA license and this api can be found
  on GitHub (elthariel/icast). Amongst our goals we can find :

    * Provide a more modern alternative to dir.xiph.org
    * Provide a more open alternative to tunein/radionomy/shoutcast directory
    * Have an API-first service to encourage integration into services and devices (proof is, at the time of writing, we have almo the full API but no frontend)

  While we had mainly a few use cases for this project, we decided to try to have
  a unique and consistent API to serve all of them. The use cases are the
  following :

    * As a station owner, you want to be easily available to your viewers/listeners. So you want to publish your stations website/stream_url/details and some metadatas (current song and stuff).
    * As a web{radio, tv} enthusiast, you want to submit stations you like, their details and stuff to share them to the world.
    * As a listener/viewer, you want to easily find streams with the kind of content you like, in your favorites languages. You might also want some suggestions about other kind of content you would like.
    * As a developper, you'd like a first-class-citizen API to build a better frontend (what? you think ours sucks?), or to integrate it into your services, application and devices.
    * As a cool guy/girl, you like things to be and stay open. You're at the right place.


  ## User management

  While most of the *content* is available read-only unauthenticated. Being able
  to publish station or submit content requires you to be autenticated. We
  doesn't implement (yet) any fancy token or oauth facility for our api but
  currently rely on a session cookie to handle autheticated state.

  We require our users to provide a password and an email that will be validated
  with a classical confirmation link sent by mail that cannot be handled by the
  API.

  We provide most of the features you would expect to handle users :

    * User Creation (/users/registrations)
    * User Login (/users/sessions)
    * User password change (/users/passwords)
    * User's email address confirmation link resend (/user/confirmations)

  ## Querying stations

  We provide a few ways to browse our database :

    * Plain paginated listing (GET /stations)
    * List by language (GET /stations/language/:lang)
    * List by location (GET /stations/local) (You IP is geolocated to handle this)
    * List by genre (GET /stations/genres/genre1[,genre2])
    * FullText search (GET /stations/search)

  While the basic listing provides enough data to display the station in your
  UI, you can still request additional details about a particular station using
  GET /stations/:station_id_or_slug. You can also get a playlist for that
  station to tune in directly (GET /stations/:station_id_or_slug.{m3u|pls}).

  ## Contribution content

  Using this API, you can allow your user to contribute new content or suggest
  update on existing content. This API is fairly simple, or at least we tried to
  design in that way.

  Basically, there are two endpoints for contributions :

    * Contributing new content : POST /contributions
    * Suggesting a change : POST /stations/:station_id_or_slug/suggest

  Refer to these calls documentation for further details, but the main point is:
  You get a JSON description of a station from /stations/xxx, change it and
  submit it back. For new content, you have to build you own JSON but the format
  remains the same.

  ## Station Owner

  As a station owner, you will be able to publish changes to your station
  without requiring to use the contribution API nor validations from
  admin/moderators. This API is very simple and allows you to edit details of
  your station as well as push metadata changes. See (POST
  /stations/:station_id_or_slug)

  ## About POST/PATCH arguments format

  Our API supports POST/PATCH parameters passed both in the url-encoded format
  and in JSON format. In most (autogenerated from specs) examples of this
  documentation, you'll find the url-encoded format, but this doesn't me you
  can't use JSON. Let me gives you an example of how the two formats maps to
  each other :

  ### URL-Encoded

      param1=value1&param2[key1]=value21&param2[key2]=value22&param3[][key1]=value311&param3[][key1]=value312

  ### JSON-Encoded

      {
        "param1" = "value1",
        "param2" = {
          "key1" = "value21",
          "key2" = "value22"
        },
        param3 = [
          { "key1" = "value311" },
          { "key1" = "value312" }
        ]
      }

  DESC

end
