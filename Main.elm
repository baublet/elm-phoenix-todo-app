module Main exposing (..)

import Html exposing (Attribute, Html, button, div, h1, hr, input, span, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onCheck, onClick, onInput)
import Time exposing (now)


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


createTodo : Int -> String -> Todo
createTodo id todo =
    { id = id
    , todo = todo
    , completed = False
    , foreignId = 0
    , syncronized = False
    , syncronizing = False
    }



-- MODEL


type alias Model =
    { newTodoText : String
    , idCounter : Int
    , todos : List Todo
    }


model : Model
model =
    { newTodoText = ""
    , idCounter = 1
    , todos =
        [ { id = 0
          , todo = "Starting todo"
          , completed = False
          , foreignId = 0
          , syncronized = False
          , syncronizing = False
          }
        ]
    }



-- UPDATE


type Msg
    = TextChange Int String
    | Completed Int Bool
    | NewTextChange String
    | Add
    | Delete Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        TextChange id newContent ->
            { model
                | todos =
                    List.map
                        (\todo ->
                            if todo.id == id then
                                { todo | todo = newContent }
                            else
                                todo
                        )
                        model.todos
            }

        Completed id completed ->
            { model
                | todos =
                    List.map
                        (\todo ->
                            if todo.id == id then
                                { todo | completed = completed }
                            else
                                todo
                        )
                        model.todos
            }

        Delete id ->
            { model | todos = List.filter (\todo -> todo.id /= id) model.todos }

        NewTextChange newContent ->
            { model | newTodoText = newContent }

        Add ->
            { model
                | idCounter = model.idCounter + 1
                , todos =
                    createTodo model.idCounter model.newTodoText :: model.todos
            }



-- VIEW


todoDisplay : Todo -> Html Msg
todoDisplay todo =
    div []
        [ input [ type_ "checkbox", checked todo.completed, onCheck (Completed todo.id) ] []
        , input [ value todo.todo, disabled todo.completed, onInput (TextChange todo.id) ] []
        , button [ class "deleteButton", disabled (todo.completed == False), onClick (Delete todo.id) ] [ text "Delete" ]
        ]


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Do These Things" ]
        , div [] (List.map todoDisplay model.todos)
        , hr [] []
        , input [ onInput NewTextChange ]
            []
        , button
            [ onClick Add ]
            [ text "Add Todo" ]
        ]
