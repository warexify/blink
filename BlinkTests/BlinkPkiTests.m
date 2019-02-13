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
}

- (void)testRSAImport {
  NSString * openSSH =
@"-----BEGIN OPENSSH PRIVATE KEY-----\n\
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAABFwAAAAdzc2gtcn\n\
NhAAAAAwEAAQAAAQEAsTFIg87NYDX/bCoYv4IZPyjWObI3IZNwNEHFsw8EWdVlKvYfaMhT\n\
dWdESD4eVVDZms0UlleHO9d2H+OBuXRz2myUGlng8nW38pBaob0x0GpXHr1MqfSrq0MspH\n\
NuOduYFe5asrptdzk1Tz17JJbcBC4pG3NRNmBHwAfLGVeH3vUlLhHI689d7HM7XXCsevWx\n\
IFVYB9IE96MbPJd5rAxoNIWy3IN1AvmhTNUGLxBxUmuEJZBfguVZYd1WbbvvpsC6MJnxtg\n\
gD+0Tp18fUr2PwW4IGocKWZcrJpc7MyqJfhwE1iFP0IzC6CFm3WCyGcEl0pZbx2pI9WKND\n\
7NkOwpBcQQAAA9DQ8yFd0PMhXQAAAAdzc2gtcnNhAAABAQCxMUiDzs1gNf9sKhi/ghk/KN\n\
Y5sjchk3A0QcWzDwRZ1WUq9h9oyFN1Z0RIPh5VUNmazRSWV4c713Yf44G5dHPabJQaWeDy\n\
dbfykFqhvTHQalcevUyp9KurQyykc24525gV7lqyum13OTVPPXskltwELikbc1E2YEfAB8\n\
sZV4fe9SUuEcjrz13scztdcKx69bEgVVgH0gT3oxs8l3msDGg0hbLcg3UC+aFM1QYvEHFS\n\
a4QlkF+C5Vlh3VZtu++mwLowmfG2CAP7ROnXx9SvY/BbggahwpZlysmlzszKol+HATWIU/\n\
QjMLoIWbdYLIZwSXSllvHakj1Yo0Ps2Q7CkFxBAAAAAwEAAQAAAQBonJQXXWzbNIYMMf5S\n\
cli9dTqk7Zam+AjykTJLOL502wvThWOd1UeQtNsXW7VE4WrXfeR9rkdlCRvwT70y5JHRjv\n\
ERbabk/qMPTjJz8uMKDP5KY7BzVsRTZGFi5dNZzU/JAuQBSRd/oALdOYsOWxKiVS5nynlU\n\
BRvXP8Kkv4y0EEOSaR6BcYt8eSKHnbUvhwkP5V8lq+mpaHjdkUQBJYriAjx2jgIo2nz7Z2\n\
BiODO32KJKsurJpeQigjfZPUCwAUBsScCVC28dELf/vgw0piOe8rqOeW6HQvxqPv5idjtP\n\
wtebdVMFmbAzZjBUJNCyYqLlw+8S0qWZ8lfGa4Tp8N8BAAAAgQDVRdnIYsPOD5NsWDc4g0\n\
AfgSa9lC+Zaf9Qne2gcFGdBscpr8aKO9dUPt/k/311jKp+B7B0Pm8fgPaGV31j/rPZgC6I\n\
SYNArMZ31ugfGTVVEr3zErnLCuHNs6lUtQYj7y7lV/GGfBQkjR7gU14LCPh0W7rwM15SEt\n\
tVaGT8K2tGmQAAAIEA31FAWhOKiXKAFiVzX8Oo9qp70NMrSeb9RIrv0bwxknxmcAiTM20I\n\
01JkJe5/D7NefD9LLld1eoYTb3AMtgWyV4VZOWln4IdvPyIaCwkQ2ieAyLvnavqye/T51K\n\
+dek3/1IG9R3+drZg3QYjFYhiiY6DhH3Jr1+DLu6dQa42cHhkAAACBAMsf7gk6Iz09VwGJ\n\
0acj4siMCcElEcLj2qzP6tCZK5trO5AMeo9Ls2tNfK5T78wQnJdzzKHbDpksJgoPrHXAD5\n\
LTabWHRdZhwoZ5uJzF4d2qctJIEcLZUDof6UOTRh71AGCj1wWYqnwq9vPtzdlD6e+kkbDo\n\
61llXpLuoD/EQKRpAAAAE3l1cnlAWXVyeXMtaU1hYy5sYW4BAgMEBQYH\n\
-----END OPENSSH PRIVATE KEY-----\n\
";
  
  NSString *rsaPKC1 =
@"-----BEGIN RSA PRIVATE KEY-----\n\
MIIEpAIBAAKCAQEAt92RfTD1hLdNrTor7967V+OSvjntMXaS6kHegwCZ6nW/Ysr7\n\
amUwhNq/LTfcFt2YoUwQLdfXssxzFhQYwR+C7Z9jR66O2yhoedCB9erg9dTZAUBs\n\
0fMZfsxsggJxVihUCelbQEAdof2zyqfwWnnJ37XpzoZIs1XHBZPXPM0cDVGzqd3t\n\
QrzFWI6YSxyKHWEsyW9R9CjY5S8MppvJAyvn0XdF2u0uU5ouu9oaADln6aG45bvj\n\
tilFXIFzeBIrlVR0HLGNqw3pNThTPuT1zwx7mfXDjYhAykxKpYFExBigsFQKa5En\n\
lTj9nh8vMYorYlvworZf/zj32tDKCd19IIAc5QIDAQABAoIBAQC0vMKVU5kkuqNK\n\
kxI5mrKB9Jx9DagRpUNJrzIxiFfEV7aoQGvf7FRDZFvk8TIR8AZnF8QXrELF6Z9/\n\
poWm4XjsaG9JOVgIKrJ4e/QkbpxwSqh+SHwv7U20jPJk4k3SqZXioFco013NrPwd\n\
S/RCm9FLbSDF+M5iKwGWg/tiMyVOGMJUcuR7CFXmX39l9Rnk2dGAqJmNo/seRHdl\n\
sku8Kd8ttUjQ12ituS2BG7OzSEwQGb6cp0Oc84GC5MVcD6l5a5udob+mmJAIiVj8\n\
fWefNR1dGEkfoCyCJddj5Y1W7Nkt2qsldubQOsvRkDhnWPHmkqgs/0ocGXo/xWNS\n\
OaY6Z+xBAoGBAPUTUlyXtgYDyhL1dmqIzyiF6G00zq3Jx6YQL8SC1TzddQ8Hu8Dd\n\
Et3rP5vFQLzD0MkvKhdct11cUcZVPboUIbkWqi3n3VSRBFAj4623Vd3+LmtPtueW\n\
CDalL9bSknZFYimoZgIFf8wHKIVDLA6FAg6OCCGtOjWqpaTgw2eJF6DpAoGBAMAP\n\
v8TobR3dbdBAMkWYCWNc4R0ifAOhXsdnkGt5+2Z0Wj9iT/72jIxba1pJlDzFGkYi\n\
PHCkJ+V60QcDGVfKN2RFRz5puQvZ2hZEjbD7iUOwRuUQtcMGbkYUgFC78M5drEbj\n\
cYugvaLfkI2fnhP3G2dzZO4v5s+hak7tPJtdej6dAoGBALQG44Oc9ltowTI4Giqc\n\
IQD1jQ1bs086YGx+i3hhW18AlxLZbXR5cXiPbQRyW+HOPjrraJIMy63LOU7mIxfj\n\
3fnmylA6eP28IVz1YDSl7m/KXjL6NbPdJF9v7LpzqJ80zK0pRPXLMFuiDoQGGgD4\n\
d9BVSWfjplTx7Ag4C5KsxCyxAoGAa+1tul1SVCIGf6xTk8AoJmofJpwmTHP2KuAL\n\
zBm0KJLh1BSPF5u8x3LoFMicQLoSVa8Pf8z/jnlB1UrshuTf070KmAwZLIuzfifv\n\
57CyJhN9A2Qsf/exKDiFEtlKLO1+zicpu2kMp+Yx+SPlVRrbj3rNEPxiG/N9JfUy\n\
xav18hECgYBvGOAFniWXBBA0mj+a1JS1ApAjRuv1AVOiAqSf7o6Hn4Upm2Z3Lz8n\n\
Ou5Sc6I4YVgcWO9j8SJJaVoET2bx/71OE7na1EafDX2e1C+zmCCo4UGwakXOAHtG\n\
zZ4qp35qc7XVEdHe9qJzzCJjDn4IE5QUh50drPcAbEpWpEobxGyJVA==\n\
-----END RSA PRIVATE KEY-----\n\
";
  
//  [self _testRSAImport:rsaPKC1];
  [self _testRSAImport:openSSH];
  
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
    XCTAssertTrue(pki.isValidPrivateKey);
    [keyNotNil fulfill];
  }];
  
  XCTAssertEqual([XCTWaiter waitForExpectations:@[keyNotNil] timeout:0.5], XCTWaiterResultCompleted);
}

- (void)_testRSAImport:(NSString *)key {
  XCTestExpectation *keyNotNil = [[XCTestExpectation alloc] initWithDescription:@"wait for RSA"];
  [Pki importPrivateKey:key controller:nil andCallback:^(Pki *pki) {
    XCTAssertNotNil(pki);
    XCTAssertEqualObjects(pki.keyTypeName, @"RSA");
    XCTAssertTrue(pki.isValidPrivateKey);
    [keyNotNil fulfill];
  }];
  
  XCTAssertEqual([XCTWaiter waitForExpectations:@[keyNotNil] timeout:0.5], XCTWaiterResultCompleted);
}

@end
