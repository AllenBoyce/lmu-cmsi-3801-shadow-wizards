module Exercises
    ( change
    , Shape(..)
    , surfaceArea
    , volume
    , powers
    , BST(..)
    , insert
    , inorder
    , contains
    , size
    , firstThenApply
    , meaningfulLineCount -- put the proper exports here
    ) where

import qualified Data.Map as Map
import Data.Text (pack, unpack, replace)
import Data.List(isPrefixOf, find)
import Data.Char(isSpace)

change :: Integer -> Either String (Map.Map Integer Integer)
change amount
    | amount < 0 = Left "amount cannot be negative"
    | otherwise = Right $ changeHelper [25, 10, 5, 1] amount Map.empty
        where
          changeHelper [] remaining counts = counts
          changeHelper (d:ds) remaining counts =
            changeHelper ds newRemaining newCounts
              where
                (count, newRemaining) = remaining `divMod` d
                newCounts = Map.insert d count counts

firstThenApply :: [a] -> (a -> Bool) -> (a -> b) -> Maybe b
firstThenApply xs pred f = f <$> find pred xs

powers :: Integral a => a -> [Integer]
powers b = [fromIntegral b ^ n | n <- [0..]]

meaningfulLineCount :: FilePath -> IO Int
meaningfulLineCount path = do
    contents <- readFile path
    let fileLines = lines contents
        filteredLines = filter (\line -> not (null line) && not (all isSpace line) && ((/='#') . head . dropWhile isSpace) line) fileLines
    return (length filteredLines)

data Shape
    = Sphere Double
    | Box Double Double Double
    deriving (Eq, Show)
volume :: Shape -> Double
volume (Sphere r) = (4/3) * pi * r^3
volume (Box l w h) = l * w * h

surfaceArea :: Shape -> Double
surfaceArea (Sphere r) = 4 * pi * r^2
surfaceArea (Box l w h) = 2 * (l * w + w * h + h * l)


data BST a
    = Empty
    | Node a (BST a) (BST a)

size :: BST a -> Int
size Empty = 0
size (Node _ left right) = 1 + size left + size right

inorder :: BST a -> [a]
inorder Empty = []
inorder (Node value left right) = inorder left ++ [value] ++ inorder right

insert :: Ord a => a -> BST a -> BST a
insert value Empty = Node value Empty Empty
insert value (Node nodeValue left right)
    | value < nodeValue = Node nodeValue (insert value left) right
    | value > nodeValue = Node nodeValue left (insert value right)
    | otherwise = Node nodeValue left right

instance (Show a) => Show (BST a) where
    show Empty = "()"
    show (Node value left right) = "(" ++ 
        (if size left /= 0 then show left else "") ++
        show value ++
        (if size right /= 0 then show right else "") ++
        ")"

contains :: Ord a => a -> BST a -> Bool
contains _ Empty = False
contains x (Node value left right)
    | x == value = True
    | x < value = contains x left
    | otherwise = contains x right