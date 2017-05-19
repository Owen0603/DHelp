//
//  Struct.h
//  DHelp
//
//  Created by 姚凤 on 2017/3/10.
//  Copyright © 2017年 姚凤. All rights reserved.
//

#ifndef Struct_h
#define Struct_h

#define DAPINOTIFICATION_REQUEST_START @"APINOTIFICATION_REQUEST_START"

typedef enum
{
    OutputLanguageObjectiveC = 0,
    OutputLanguageJava,
    OutputLanguageCoreDataObjectiveC,
    OutputLanguageDjangoPython,
    OutputLanguagePython
} OutputLanguage;


typedef NS_ENUM(unsigned int, HTTPMethod) {
    HTTPMethodGet = 0,
    HTTPMethodPost = 1,
    HTTPMethodPut = 2,
    HTTPMethodHead = 3
};

typedef NS_ENUM(unsigned int, JsonLibrary) {
    JsonLibraryNone = 0,
    JsonLibraryScalaPlay,
    JsonLibraryScalaAkkaHttpSpray
};

#endif /* Struct_h */
