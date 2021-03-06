module StaticResponsesTests exposing (all)

import Dict exposing (Dict)
import Expect
import Pages.Internal.Platform.Mode as Mode
import Pages.Internal.Platform.StaticResponses as StaticResponses
import Pages.Internal.Platform.ToJsPayload as ToJsPayload
import Pages.StaticHttp as StaticHttp
import Pages.StaticHttp.Request as Request
import Secrets
import SecretsDict
import Test exposing (Test, describe, test)


getWithoutSecrets url =
    StaticHttp.get (Secrets.succeed url)


get : String -> Request.Request
get url =
    { method = "GET"
    , url = url
    , headers = []
    , body = StaticHttp.emptyBody
    }


all : Test
all =
    describe "Static Http Requests"
        [ test "andThen" <|
            \() ->
                StaticResponses.init Dict.empty (Ok []) config []
                    |> StaticResponses.nextStep config (Ok []) Mode.Dev (SecretsDict.unmasked Dict.empty) Dict.empty []
                    |> Expect.equal
                        (StaticResponses.Finish
                            (ToJsPayload.Success
                                { errors = []
                                , filesToGenerate = []
                                , manifest = ToJsPayload.stubManifest
                                , pages = Dict.fromList []
                                , staticHttpCache = Dict.fromList []
                                }
                            )
                        )
        ]


config =
    { generateFiles = \_ -> StaticHttp.succeed []
    , content = []
    , manifest = ToJsPayload.stubManifest
    }


getReq : String -> StaticHttp.RequestDetails
getReq url =
    { url = url
    , method = "GET"
    , headers = []
    , body = StaticHttp.emptyBody
    }
