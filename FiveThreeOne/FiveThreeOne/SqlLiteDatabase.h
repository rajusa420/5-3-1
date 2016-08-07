//
// Created by Raj Sathi on 1/27/15.
// Copyright (c) 2015 RajSathi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>



@interface SqlLiteDatabase : NSObject
{

@private
    sqlite3* database_;
    NSString* databasePath_;
}

-(id) initWithDatabaseFileName: (NSString*) databaseFileName;

-(sqlite3_stmt*) getStatement: (NSString*) sql;
-(BOOL) finalizeStatement: (sqlite3_stmt*) statement;
-(BOOL) executeStatement: (sqlite3_stmt*) statement;
-(NSArray*) executeStatement: (sqlite3_stmt*) statement processorTarget: (id) target processorSelector: (SEL) processor;

-(BOOL) beginTransaction;
-(void) rollbackTransaction;
-(BOOL) commitTransaction;

-(BOOL) bindInt: (int) value forStatement: (sqlite3_stmt*) statement atIndex: (int) index;
-(BOOL) bindInt64: (sqlite_int64) value forStatement: (sqlite3_stmt*) statement atIndex: (int) index;
-(BOOL) bindDouble: (double) value forStatement: (sqlite3_stmt*) statement atIndex: (int) index;
-(BOOL) bindString: (NSString*) text forStatement: (sqlite3_stmt*) statement atIndex: (int) index;
-(BOOL) bindCFUUID: (CFUUIDBytes) uuid forStatement: (sqlite3_stmt*) statement atIndex: (int) index;

-(CFUUIDBytes) convertByteBlobToCFUUID: (sqlite3_stmt*) statement atColumn: (int) column;
@property (nonatomic, retain) NSString* databasePath;
@end