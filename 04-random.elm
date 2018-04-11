import Html exposing (..)
import Html.Events exposing (..)
import Random



main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Model =
  { dieFaceA : Int
  , dieFaceB : Int
  }


init : (Model, Cmd Msg)
init =
  (Model 1 1, Cmd.none)

twoAtOnce = Random.map2 (,) (Random.int 1 6) (Random.int 1 6)

-- UPDATE


type Msg
  = Roll
  | NewFace (Int, Int)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model, Random.generate NewFace twoAtOnce)

    NewFace (newFaceA, newFaceB) ->
      ({ model | dieFaceA = newFaceA, dieFaceB = newFaceB }, Cmd.none)



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text (toString model.dieFaceA) ]
    , h1 [] [ text (toString model.dieFaceB) ]
    , button [ onClick Roll ] [ text "Roll" ]
    ]