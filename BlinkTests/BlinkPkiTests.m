//////////////////////////////////////////////////////////////////////////////////
//
// B L I N K
//
// Copyright (C) 2016-2019 Blink Mobile Shell Project
//
// This file is part of Blink.
//
// Blink is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Blink is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Blink. If not, see <http://www.gnu.org/licenses/>.
//
// In addition, Blink is also subject to certain additional terms under
// GNU GPL version 3 section 7.
//
// You should have received a copy of these additional terms immediately
// following the terms and conditions of the GNU General Public License
// which accompanied the Blink Source Code. If not, see
// <http://www.github.com/blinksh/blink>.
//
////////////////////////////////////////////////////////////////////////////////


#import <XCTest/XCTest.h>
#import "BKPubKey.h"

@interface BlinkPkiTests : XCTestCase

@end

@implementation BlinkPkiTests

- (void)testRSAGeneration {
  [self _testRSAGenWithLength:256];
  [self _testRSAGenWithLength:512];
  [self _testRSAGenWithLength:2048];
  [self _testRSAGenWithLength:4096];
  [self _testRSAGenWithLength:-1096];
}

- (void)_testRSAGenWithLength:(int) length {
  Pki * pki = [[Pki alloc] initRSAWithLength:length];
  
  XCTAssertNotNil(pki);
  XCTAssertEqualObjects(pki.keyTypeName, @"RSA");
  XCTAssertNotNil(pki.privateKey);
  
  XCTestExpectation *keyNotNil = [[XCTestExpectation alloc] initWithDescription:
                                  [NSString stringWithFormat:@"wait for RSA %@", @(length)]];
  [Pki importPrivateKey:pki.privateKey controller:nil andCallback:^(Pki *key) {
    XCTAssertNotNil(pki);
    [keyNotNil fulfill];
    NSLog(@"bla %@", @(length));
  }];
  
  XCTAssertEqual([XCTWaiter waitForExpectations:@[keyNotNil] timeout:0.5], XCTWaiterResultCompleted);
}

@end
