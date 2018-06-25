module Main exposing (..)

import Html exposing (Attribute, Html, div, h1, input, span, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onCheck, onInput)


main =
    Html.beginnerProgram { model = model, view = view, update = update }


type alias Todo =
    { id : Int
    , todo : String
    , completed : Bool
    , foreignId : Int
    , syncronized : Bool
    , syncronizing : Bool
    }



-- MODEL


type alias Model =
    List Todo


model : Model
model =
    [ { id = 0
      , todo = "Starting todo"
      , completed = False
      , foreignId = 0
      , syncronized = False
      , syncronizing = False
      }
    ]



-- UPDATE


type Msg
    = TextChange Int String
    | Completed Int Bool


update : Msg -> Model -> Model
update msg model =
    case msg of
        TextChange id newContent ->
            List.map
                (\todo ->
                    if todo.id == id then
                        { todo | todo = newContent }
                    else
                        todo
                )
                model

        Completed id completed ->
            List.map
                (\todo ->
                    if todo.id == id then
                        { todo | completed = completed }
                    else
                        todo
                )
                model



-- VIEW


todoDisplay : Todo -> Html Msg
todoDisplay todo =
    div []
        [ input [ value todo.todo, onInput (TextChange todo.id) ] []
        , input [ type_ "checkbox", checked todo.completed, onCheck (Completed todo.id) ] []
        ]


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Do These Things" ]
        , div [] (List.map todoDisplay model)
        ]
