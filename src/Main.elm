module Main exposing (..)

import Browser
import Html exposing (Html, a, div, h1, p, text, textarea)
import Html.Attributes exposing (class, href, style, target)
import Html.Events exposing (onClick, onInput)



---- MODEL ----


type alias Model =
    { inputField : String
    , infoBox : String
    , infoVisible : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( { inputField = info.demo, infoBox = info.what, infoVisible = True }, Cmd.none )



---- UPDATE ----


type Msg
    = UpdateInput String
    | SetInfo String
    | TransposeUp
    | TransposeDown
    | ToggleInfoVisibility


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateInput userInput ->
            ( { model | inputField = userInput }, Cmd.none )

        SetInfo whichInfo ->
            ( { model | infoBox = whichInfo }, Cmd.none )

        TransposeUp ->
            ( { model | inputField = transposeAllUp model.inputField }, Cmd.none )

        TransposeDown ->
            ( { model | inputField = transposeAllDown model.inputField }, Cmd.none )

        ToggleInfoVisibility ->
            if model.infoVisible == True then
                ( { model | infoVisible = False }, Cmd.none )

            else
                ( { model | infoVisible = True }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    ---- ROOT CONTAINER ----
    div [ class "min-vh-100 yellow code pb1 f6 f5-ns f4-l bg-black cover", style "background-image" "url(harmonica-bg.jpg)" ]
        ---- TITLE WITH APP NAME ----
        [ h1 [ class "mt0 pb3-m pt5-m pt5-l pb2-l pt4 tc ttu f3 f2-m f1-l lh-title" ] [ text "elmaester's harmonica assistant" ]

        ---- BUTTON FOR HIDING / SHOWING THE INFO ----
        , p [ onClick ToggleInfoVisibility, class "w-third center tc ttu pointer grow red", style "text-shadow" "1px 1px 2px black" ]
            [ if model.infoVisible == True then
                text "hide info"

              else
                text "show info"
            ]
        , if model.infoVisible == True then
            ---- MENU AND INFO CONTAINER ----
            div [ class "center w-80-l w-100 min-h-100" ]
                ---- MENU BUTTONS CONTAINER ----
                [ div [ class "bt bl bb fl pa2 w-30" ]
                    ---- WHAT DOES THIS DO? ----
                    [ p
                        [ class "tc grow pointer"
                        , onClick <| SetInfo info.what
                        , if model.infoBox == info.what then
                            class "ttu black bg-yellow"

                          else
                            class ""
                        , style "text-shadow" "1px 1px 2px black"
                        ]
                        [ text "What does this do?" ]

                    ---- RECOMMENDED PIANO ----
                    , p
                        [ class "tc grow pointer"
                        , onClick <| SetInfo info.piano
                        , if model.infoBox == info.piano then
                            class "ttu black bg-yellow"

                          else
                            class ""
                        , style "text-shadow" "1px 1px 2px black"
                        ]
                        [ text "Recommended piano "
                        , a [ href "https://www.apronus.com/music/flashpiano.htm", target "_blank", class "red", style "text-decoration" "none" ] [ text "link" ]
                        ]

                    ---- TUTORIAL ----
                    , p
                        [ class "tc grow pointer"
                        , onClick <| SetInfo info.tutorial
                        , if model.infoBox == info.tutorial then
                            class "ttu black bg-yellow"

                          else
                            class ""
                        , style "text-shadow" "1px 1px 2px black"
                        ]
                        [ text "Tutorial "
                        , a [ href "https://youtu.be/mnL2xXTgdQc", target "_blank", class "red", style "text-decoration" "none" ] [ text "video" ]
                        ]

                    ---- NOTE FORMATS ----
                    , p
                        [ class "tc grow pointer"
                        , onClick <| SetInfo info.formats
                        , if model.infoBox == info.formats then
                            class "ttu black bg-yellow"

                          else
                            class ""
                        , style "text-shadow" "1px 1px 2px black"
                        ]
                        [ text "Note formats" ]

                    ---- TRANSPOSING ----
                    , p
                        [ class "tc grow pointer"
                        , onClick <| SetInfo info.transposing
                        , if model.infoBox == info.transposing then
                            class "ttu black bg-yellow"

                          else
                            class ""
                        , style "text-shadow" "1px 1px 2px black"
                        ]
                        [ text "Transposing" ]

                    ---- CONTACT ----
                    , p
                        [ class "tc grow pointer"
                        , onClick <| SetInfo info.author
                        , if model.infoBox == info.author then
                            class "ttu black bg-yellow"

                          else
                            class ""
                        , style "text-shadow" "1px 1px 2px black"
                        ]
                        [ text "Contact" ]
                    ]

                ---- INFO WINDOW RIGHT SIDE ----
                , div [ class "ba fl pa4-l pa3-m pa3-ns pa2 w-70 dt h4", style "white-space" "pre-wrap", style "text-shadow" "1px 1px 2px black" ] [ p [ class "v-mid dtc" ] [ text model.infoBox ] ]
                ]

          else
            text ""
        , div
            [ class "cf"
            , if model.infoVisible == True then
                class "mb4-m mb3 mb4-ns mb5-l"

              else
                class ""
            ]
            []

        ---- BUTTON FOR REMOVING DEMO INPUT ----
        , if model.inputField == info.demo then
            p [ class "w-third center tc pointer grow red ttu", onClick (UpdateInput ""), style "text-shadow" "1px 1px 2px black" ] [ text "clear demo input" ]

          else
            text ""

        ---- TEXT AREA FOR ENTERING NOTES ----
        , textarea [ class "fw9 o-60 db center mb5-l mb4-m mb3-ns mb3 w-100 h4 tc w-80-ns w-80-m w-60-l", onInput UpdateInput ] [ text model.inputField ]

        ---- OUTPUT AREA FOR HARMONICA TABS ----
        , p [ style "white-space" "pre-wrap", class "mb0 pv4 ba w-100 center b--yellow tc w-80-ns w-80-m w-60-l fw9" ] [ text (model.inputField |> leGrandeConversion) ]

        ---- CONTAINER OF TRANSPOSITION BUTTONS ----
        , div [ class "w-100 center flex justify-around w-80-ns w-80-m w-60-l" ]
            [ p [ class "pointer dib tc bl bb br b--yellow mt0 pa2 dim", onClick TransposeDown ] [ text "Transpose↓" ]
            , p [ class "pointer dib tc bl bb br b--yellow mt0 pa2 dim", onClick TransposeUp ] [ text "Transpose↑" ]
            ]

        ---- FOOTER WITH THE LIST OF TECHNOLOGIES USED AND GITHUB LINK ----
        , p [ class "tc mt4-m mt3 mt5-l f7 gray" ] [ text "Made with ", a [ href "https://elm-lang.org/", target "_blank", class "white-70 grow dib", style "text-decoration" "none" ] [ text "Elm" ], text ", ", a [ href "http://tachyons.io/", target "_blank", class "white-70 grow dib", style "text-decoration" "none" ] [ text "Tachyons" ], text ", ", a [ href "https://neovim.io/", target "_blank", class "white-70 grow dib", style "text-decoration" "none" ] [ text "Neovim" ], text " and love ❤️ Source code ", a [ href "https://github.com/elmaester/harmonica-assistant", target "_blank", class "white-70 grow dib", style "text-decoration" "none" ] [ text "here" ] ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }



---- CUSTOM FUNCTIONS ----
---- HIGHEST LEVEL FUNCTION FOR CONVERTING NOTES TO HARMONICA TABS ----


leGrandeConversion : String -> String
leGrandeConversion inputString =
    inputString |> splitByNewline |> applySpaceSplitToEachList |> applyConversionToEachList |> applyConcatToEachList |> joinWithNewline



---- HELPER FUNCTIONS FOR STRING MANIPULATION ----
---- join lists of converted notes (i.e. already harmonica tabs) with the newline character as separator ----


joinWithNewline : List String -> String
joinWithNewline newlinedOutputList =
    String.join "\n" newlinedOutputList



---- split the user input String into a list of Strings using " " character as delimiter. thus is obtained a list of Strings, each String is one note ----


getListOfNotes : String -> List String
getListOfNotes notesString =
    String.split " " notesString



---- convert a list of Strings (where each String represents a single harmonica hole / tab element) into a single String (join with the " " character as separator) ----


makeStringOfHoles : List String -> String
makeStringOfHoles holesList =
    String.join " " holesList



---- split a String into a list of Strings, newline character is the delimiter ----


splitByNewline : String -> List String
splitByNewline notesString =
    String.split "\n" notesString



---- HIGHER ORDER HELPER FUNCTIONS WHICH CALL LOWER LEVEL FUNCTIONS ON LISTS OF STRINGS ----
---- apply getListOfNotes to each newline separated List ----


applySpaceSplitToEachList : List String -> List (List String)
applySpaceSplitToEachList newlinedList =
    List.map getListOfNotes newlinedList



---- apply getListOfNotes to each newline separated List ----


applyConversionToEachList : List (List String) -> List (List String)
applyConversionToEachList listOfLists =
    List.map convertListOfNotes listOfLists



---- apply makeStringOfHoles to each list ----


applyConcatToEachList : List (List String) -> List String
applyConcatToEachList convertedLists =
    List.map makeStringOfHoles convertedLists



---- convert list of notes to list of holes ----


convertListOfNotes : List String -> List String
convertListOfNotes list =
    List.map convertNote list



---- HIGH LEVEL TRANSPOSITION FUNCTIONS (ordered by level, high to low) ----


transposeAllUp : String -> String
transposeAllUp stringOfHoles =
    stringOfHoles |> splitByNewline |> applySpaceSplitToEachList |> applyTransUpToEachList |> applyConcatToEachList |> joinWithNewline


applyTransUpToEachList : List (List String) -> List (List String)
applyTransUpToEachList list =
    if List.isEmpty (List.filter isInvalidToTransposeUp list) then
        List.map transUpAList list

    else
        list


transUpAList : List String -> List String
transUpAList list =
    List.map transOneUp list


transposeAllDown : String -> String
transposeAllDown stringOfHoles =
    stringOfHoles |> splitByNewline |> applySpaceSplitToEachList |> applyTransDownToEachList |> applyConcatToEachList |> joinWithNewline


applyTransDownToEachList : List (List String) -> List (List String)
applyTransDownToEachList list =
    if List.isEmpty (List.filter isInvalidToTransposeDown list) then
        List.map transDownAList list

    else
        list


transDownAList : List String -> List String
transDownAList list =
    List.map transOneDown list



---- CHECK WHETHER TRANSPOSITION SHOULD BE ALLOWED (True means transposition should not happen) ----


isInvalidToTransposeUp : List String -> Bool
isInvalidToTransposeUp list =
    if
        List.member "f#6" list
            || List.member "g6" list
            || List.member "g#6" list
            || List.member "a6" list
            || List.member "a#6" list
            || List.member "b6" list
            || List.member "c7" list
    then
        True

    else
        False


isInvalidToTransposeDown : List String -> Bool
isInvalidToTransposeDown list =
    if
        List.member "f#4" list
            || List.member "f4" list
            || List.member "e4" list
            || List.member "d#4" list
            || List.member "d4" list
            || List.member "c#4" list
            || List.member "c4" list
    then
        True

    else
        False



---- LOWEST LEVEL FUNCTIONS ----
---- conversion of a single note to a single hole / tab element ----


convertNote : String -> String
convertNote note =
    case note of
        "" ->
            ""

        "c4" ->
            "1"

        "c#4" ->
            "-1'"

        "d4" ->
            "-1"

        "d#4" ->
            "!d#4"

        "e4" ->
            "2"

        "f4" ->
            "-2''"

        "f#4" ->
            "-2'"

        "g4" ->
            "3"

        "g#4" ->
            "-3'''"

        "a4" ->
            "-3''"

        "a#4" ->
            "-3'"

        "b4" ->
            "-3"

        "c5" ->
            "4"

        "c#5" ->
            "-4'"

        "d5" ->
            "-4"

        "d#5" ->
            "!d#5"

        "e5" ->
            "5"

        "f5" ->
            "-5"

        "f#5" ->
            "!f#5"

        "g5" ->
            "6"

        "g#5" ->
            "-6'"

        "a5" ->
            "-6"

        "a#5" ->
            "!a#5"

        "b5" ->
            "-7"

        "c6" ->
            "7"

        "c#6" ->
            "!c#6"

        "d6" ->
            "-8"

        "d#6" ->
            "8'"

        "e6" ->
            "8"

        "f6" ->
            "-9"

        "f#6" ->
            "9'"

        "g6" ->
            "9"

        "g#6" ->
            "!g#6"

        "a6" ->
            "-10"

        "a#6" ->
            "10''"

        "b6" ->
            "10'"

        "c7" ->
            "10"

        _ ->
            "0"



---- Transpose up function for one note ----


transOneUp : String -> String
transOneUp note =
    case note of
        "" ->
            ""

        "c4" ->
            "g4"

        "c#4" ->
            "g#4"

        "d4" ->
            "a4"

        "d#4" ->
            "a#4"

        "e4" ->
            "b4"

        "f4" ->
            "c5"

        "f#4" ->
            "c#5"

        "g4" ->
            "d5"

        "g#4" ->
            "d#5"

        "a4" ->
            "e5"

        "a#4" ->
            "f5"

        "b4" ->
            "f#5"

        "c5" ->
            "g5"

        "c#5" ->
            "g#5"

        "d5" ->
            "a5"

        "d#5" ->
            "a#5"

        "e5" ->
            "b5"

        "f5" ->
            "c6"

        "f#5" ->
            "c#6"

        "g5" ->
            "d6"

        "g#5" ->
            "d#6"

        "a5" ->
            "e6"

        "a#5" ->
            "f6"

        "b5" ->
            "f#6"

        "c6" ->
            "g6"

        "c#6" ->
            "g#6"

        "d6" ->
            "a6"

        "d#6" ->
            "a#6"

        "e6" ->
            "b6"

        "f6" ->
            "c7"

        _ ->
            "0"



---- Transpose down function for one note ----


transOneDown : String -> String
transOneDown note =
    case note of
        "" ->
            ""

        "c7" ->
            "f6"

        "b6" ->
            "e6"

        "a#6" ->
            "d#6"

        "a6" ->
            "d6"

        "g#6" ->
            "c#6"

        "g6" ->
            "c6"

        "f#6" ->
            "b5"

        "f6" ->
            "a#5"

        "e6" ->
            "a5"

        "d#6" ->
            "g#5"

        "d6" ->
            "g5"

        "c#6" ->
            "f#5"

        "c6" ->
            "f5"

        "b5" ->
            "e5"

        "a#5" ->
            "d#5"

        "a5" ->
            "d5"

        "g#5" ->
            "c#5"

        "g5" ->
            "c5"

        "f#5" ->
            "b4"

        "f5" ->
            "a#4"

        "e5" ->
            "a4"

        "d#5" ->
            "g#4"

        "d5" ->
            "g4"

        "c#5" ->
            "f#4"

        "c5" ->
            "f4"

        "b4" ->
            "e4"

        "a#4" ->
            "d#4"

        "a4" ->
            "d4"

        "g#4" ->
            "c#4"

        "g4" ->
            "c4"

        _ ->
            "0"



---- A RECORD WHICH CONTAINS ALL STRING VALUES FOR THE APP'S TEXTUAL ELEMENTS ----


info =
    { what = "It solves a problem I have. The problem is: harmonica is a terrible instrument for picking tunes by ear. When you play harmonica tentatively, you lose your breath very quickly. Then you're winded and unable to pay proper attention to the sounds you're hearing. Your ability to pick tunes by ear is thus impaired. Harmonica also doesn't give you any visual cues. You're holding it in your mouth so you don't see what's going on. You have no visual representation of the notes available to you. And to make things worse, notes are located in a non-sequential order on the harmonica.\n\nDue to all of these reasons, it is better to use a different instrument (piano is ideal) for the picking, and then just use the harmonica to play tabs with confidence. This tool gives you harmonica tabs as the output. As input you have to feed it properly formatted notes. So the answer is: elmaester's harmonica assistant converts properly formatted musical notes to harmonica tabs. The target instrument is a diatonic harmonica in the key of C - most common one, and the one I happen to own."
    , piano = "There is a really nice online virtual piano I recommend using. It would make no sense for me to reimplement here what those guys at apronus.com have done so well already (click the red \"LINK\" to go there).\n\nA word about settings: the defaults are no good for our purposes. When you open the site, you want to click the \"octaves\" button. There you want to \"remove lowest octave\" once and \"add higher octave\" twice. What you will have then is a range from C4 till C7 - exactly what a C harmonica is able to produce. Then there's a button right next to \"octaves\". You want to choose \"computer keyboard plays from C5 to C7\" - that is the range most tunes will be in. Now you can use your computer keyboard keys to play the piano. On the screen you can see labels on the upper edge of piano keys - these correspond to your computer keyboard keys. The numbers row on your keyboard plays sharp# notes."
    , tutorial = "Click the red \"VIDEO\" link to watch a demonstration video for this app on YouTube.\n\nHere are some step-by-step instructions for using this app:\n\nStep 1: Open the recommended piano link and set the settings as described in the recommended piano section of this menu.\n\nStep 2: Use your ears and fingers to play the melody you like. Write down or memorize the note names.\n\nStep 3: Enter the notes from Step 2 into this app's input field, and make sure you follow the format demonstrated in the demo input, and described in the note formats section of this menu.\n\nStep 4: Grab your diatonic harmonica in the key of C and play the tab you see in the output field of the app.\n\nStep 5: Enjoy!"
    , formats = "All available inputs are listed in the text area when this app is in its initial state. As you can see, available to you are all notes between c4 and c7, including sharp# notes. However, in the output area you can see that some of them correspond to an exclamation mark ! followed by the name of the note. That is because these notes are not available on a C diatonic harmonica. By design, it doesn't have all of them. Harmonica is like a broken piano with missing keys. Don't blame me.\n\nFYI, there is a way to access these notes anyway, through a technique called OVERbending (not the same thing as bending). However, it is a very advanced technique, mastered by only elite players probably, and it also can't be done on just any harmonica. It has to be a high quality expensive one. So for the purpose of this app, we just assume these notes don't exist. Their non-existence is indicated by the exclamation mark!\n\nIn the output you can see numbers. These numbers correspond to the 10 holes of the harmonica. Minus sign - indicates you have to draw (breathe in). Lack of the minus sign - indicates you have to blow (breathe out). You can also see the apostrophe ' character. That one means you have to BEND. Bending is a somewhat advanced technique you have to learn on the harmonica, in order to be able to play notes which require it.\n\nFor the app to work properly, each note must be separated from its neighbors by one space. All letters must be lowercase. Multiline input is supported."
    , transposing = "In music, transposition refers to the process of moving a collection of notes up or down in pitch by a constant interval. The smallest such interval is a semitone.\n\nIn other words, by transposing we can change the pitch of a melody, make it sound higher or lower, depending on whether we are transposing up or down. What's important is that it remains the same melody as before, just in a different pitch.\n\nTransposition is implemented as a feature in this app, you can see respective buttons under the output field. It's also implemented in a safe way: it only works if the result of the transposition would still be entirely within the C4-C7 range of a diatonic harmonica in the key of C. Otherwise nothing will happen when you click the button.\n\nWith a typical melody, you should be able to get at least two viable options of pitch to play that melody in, sometimes more, depending on how wide the range of your melody is. Transposing can sometimes help avoid the necessity of bending, or work around the notes which are missing on harmonica, and that makes your life easier as a musician."
    , author = "Thank you for visiting!\n\nMy name is Oleg. I am an aspiring self-taught web-developer from Ukraine, and this is my demo project in Elm.\n\nSource code is available on GitHub (link in the footer).\n\nThe next step on my path of learning is going to be React.\n\nFeedback and job offers are welcome at: olegmorket@gmail.com\n\nI am eligible to work without a visa in the EU due to second citizenship."
    , demo = "c4 c#4 d4 d#4 e4 f4 f#4 g4 g#4 a4 a#4 b4\nc5 c#5 d5 d#5 e5 f5 f#5 g5 g#5 a5 a#5 b5\nc6 c#6 d6 d#6 e6 f6 f#6 g6 g#6 a6 a#6 b6\nc7"
    }
