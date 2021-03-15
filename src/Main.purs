module Main where

import Prelude

import Effect (Effect)

foreign import log :: forall a. a -> Effect Unit

class MyClass a where
  myFn :: a -> String

instance myClassString :: MyClass String where
  myFn x = x

instance myClassInt :: MyClass Int where
  myFn x = show x

type MyRecord =
  { myFn :: forall a. MyClass a => a -> String
  }

myRecord :: MyRecord
myRecord =
  { myFn: myFn
  }

fakeMyFn :: forall a. a -> String
fakeMyFn _ = "yes"

myRecord' :: MyRecord
myRecord' =
  { myFn: fakeMyFn
  }

main :: Effect Unit
main = do
  log myRecord
  log myRecord.myFn
  log $ myRecord.myFn "hi"
  log $ myRecord.myFn 1

  log myRecord'
  log myRecord'.myFn
  log $ myRecord'.myFn "hi"
  log $ myRecord'.myFn 1
