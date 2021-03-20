# Storytel-iOS-Sample

## Feature : 
as describe in IOS_programming_exercise file

## Supported version 
Minimum iOS version 11.0 - latest

## Technical Details

### BookListViewController.swift
This viewcontroller class is responisble for displaying book list in table and manage pagination. This class also managing tableview data source
This class is getting all the data from BookViewModel class 

### BookViewModel.swift
This viewmodel class is responsible to fetch the data from BookService and logic to hide full header or not

### BookService.swift
This class is respoinsible to create the network request using NetworkRequest and fetch and parse the data into BookList Model

### BookTableViewCell.swift
UITableViewCell subclass with UIImageView(thumbnail image view) with size 100 x 100 and label to display title and author and narrator

### ImageDownloader.swift
This class download the images and cache the images into Cache class. currently cache limit is 100 items


### StorytelTests
Unit test is written to 
1: Validate the author and narrator text in table cell
2: Validate the placeholder image
3: Validate corect url with page count or without page count 
