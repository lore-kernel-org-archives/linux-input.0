From: pchavent <Paul.Chavent@onera.fr>
Subject: [PATCH] HID : core : fix hid delimiter local tag parsing.
Date: Sun, 07 Jul 2013 18:35:39 +0200
Message-ID: <4754ed7e96bbb6e75d5b61d3997ce8e5@sybille.onecert.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_694de067527fd650d5bb64ef7a57558a"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from briaree.onecert.fr ([134.212.190.4]:49385 "EHLO
	briaree.onecert.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604Ab3GGQxb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 7 Jul 2013 12:53:31 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, linux-input@vger.kernel.org
Cc: paul.chavent@fnac.net

--=_694de067527fd650d5bb64ef7a57558a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8;
 format=flowed

Hi.

When i plug an USB HID device with the DELIMITER tag in its report 
descriptor, the device doesn't load.

The problem comes from the "return 1" in the DELIMITER switch of the 
local tags parsing.

I join a trivial patch that return no error when encounter the 
DELIMITER tag.

Please review it.


Regards.

Paul.

--=_694de067527fd650d5bb64ef7a57558a
Content-Transfer-Encoding: base64
Content-Type: text/x-c;
 name=0001-HID-core-fix-hid-delimiter-local-tag-parsing.patch
Content-Disposition: attachment;
 filename=0001-HID-core-fix-hid-delimiter-local-tag-parsing.patch

RnJvbSBkMzRlN2JlMzZkNmMzOTI1NzhhYzljODE2MTQzMjVmOWJmZjlkZTkzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQYXVsIENoYXZlbnQgPHBhdWwuY2hhdmVudEBvbmVyYS5mcj4K
RGF0ZTogU3VuLCA3IEp1bCAyMDEzIDE3OjQzOjU2ICswMjAwClN1YmplY3Q6IFtQQVRDSF0gSElE
IDogY29yZSA6IGZpeCBoaWQgZGVsaW1pdGVyIGxvY2FsIHRhZyBwYXJzaW5nLgoKLS0tCiBkcml2
ZXJzL2hpZC9oaWQtY29yZS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9oaWQvaGlkLWNvcmUuYyBiL2Ry
aXZlcnMvaGlkL2hpZC1jb3JlLmMKaW5kZXggMzY2NjhkMS4uMWUyM2FlOSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9oaWQvaGlkLWNvcmUuYworKysgYi9kcml2ZXJzL2hpZC9oaWQtY29yZS5jCkBAIC00
NTAsNyArNDUwLDcgQEAgc3RhdGljIGludCBoaWRfcGFyc2VyX2xvY2FsKHN0cnVjdCBoaWRfcGFy
c2VyICpwYXJzZXIsIHN0cnVjdCBoaWRfaXRlbSAqaXRlbSkKIAkJCX0KIAkJCXBhcnNlci0+bG9j
YWwuZGVsaW1pdGVyX2RlcHRoLS07CiAJCX0KLQkJcmV0dXJuIDE7CisJCXJldHVybiAwOwogCiAJ
Y2FzZSBISURfTE9DQUxfSVRFTV9UQUdfVVNBR0U6CiAKLS0gCjEuNy4xMi4xCgo=
--=_694de067527fd650d5bb64ef7a57558a--

