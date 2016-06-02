From: Florian Fischer <fischer@wivw.de>
Subject: [PATCH 1/1] Force feedback for Fanatec Clubsport wheel
Date: Thu, 2 Jun 2016 17:56:08 +0200
Message-ID: <72d04420-1f2c-62fe-8b41-42c8260650e5@wivw.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------439F71FE5DC96456F14B5318"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:59538 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210AbcFBP4N (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Jun 2016 11:56:13 -0400
Received: from [10.1.1.17] ([93.104.238.242]) by mrelayeu.kundenserver.de
 (mreue004) with ESMTPSA (Nemesis) id 0M1kaM-1bSvJ52H2Q-00tlXW for
 <linux-input@vger.kernel.org>; Thu, 02 Jun 2016 17:56:09 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------439F71FE5DC96456F14B5318
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi!

I am trying to add support for force feedback for the "Fanatec Clubsport
Wheel Base V2". (More information at
http://www.fanatec.com/eu-de/wheel-bases/clubsport-wheel-base-v2-eu-eu.html
)
It is a configurable racing wheel for enthusiasts.

Using a simple hack (by handling it somewhat like a Logitech G27, see
patch below) I managed to get constant force effects working.
However, the wheel only ever moves towards the right (no matter which
effect direction or value is specified). Also (less important), the
spring centering isn't turned off automatically like it is for Logitech
wheels.
>From looking at the kernel source, I get the impression that there's no
real standard for HID force feedback... so is there anything I can try
except USB debugging (which I can't) and contacting the manufacturer
(who seem to have no interest in supporting Linux)?

Best regards,
  Florian


-- 
Dipl.-Inform. Florian Fischer
Würzburger Institut für Verkehrswissenschaften GmbH (WIVW)
Robert-Bosch-Str. 4            97209 Veitshöchheim
Tel:   0931-78009105           Fax:   0931-78009150
E-Mail: fischer@wivw.de        Homepage: www.wivw.de
Handelsregister HRB 6430 Sitz Würzburg
Umsatzsteuer ID: DE 198235088
Geschäftsführung: Dr. Armin Kaussner, Alexandra Neukum


--------------439F71FE5DC96456F14B5318
Content-Type: text/plain; charset=UTF-8;
 name="linux-fanatec.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="linux-fanatec.patch"

LS0tIG9yaWdpbmFsL2xpbnV4LTQuNC42L2RyaXZlcnMvaGlkL2hpZC1sZy5jCTIwMTYtMDMt
MTYgMTY6NDM6MTcuMDAwMDAwMDAwICswMTAwCisrKyBsaW51eC00LjQuNi9kcml2ZXJzL2hp
ZC9oaWQtbGcuYwkyMDE2LTA2LTAyIDE0OjU1OjI3LjQwNTMzMDEyNiArMDIwMApAQCAtODE4
LDYgKzgxOCw5IEBACiAJCS5kcml2ZXJfZGF0YSA9IExHX1JERVNDX1JFTF9BQlMgfSwKIAl7
IEhJRF9VU0JfREVWSUNFKFVTQl9WRU5ET1JfSURfTE9HSVRFQ0gsIFVTQl9ERVZJQ0VfSURf
U1BBQ0VUUkFWRUxMRVIpLAogCQkuZHJpdmVyX2RhdGEgPSBMR19SREVTQ19SRUxfQUJTIH0s
CisJLy8gRkYgVEVTVAorCXsgSElEX1VTQl9ERVZJQ0UoVVNCX1ZFTkRPUl9JRF9FTkRPUiwg
VVNCX0RFVklDRV9JRF9FTkRPUl9DTFVCU1BPUlRfV0hFRUwpLAorCQkuZHJpdmVyX2RhdGEg
PSBMR19GRjQgfSwgCiAJeyB9CiB9OwogCi0tLSBvcmlnaW5hbC9saW51eC00LjQuNi9kcml2
ZXJzL2hpZC9oaWQtbGc0ZmYuYwkyMDE2LTAzLTE2IDE2OjQzOjE3LjAwMDAwMDAwMCArMDEw
MAorKysgbGludXgtNC40LjYvZHJpdmVycy9oaWQvaGlkLWxnNGZmLmMJMjAxNi0wNi0wMiAx
NDo1NTozNi4zNTczMzAxMDEgKzAyMDAKQEAgLTE0Niw3ICsxNDYsOCBAQAogCXtVU0JfREVW
SUNFX0lEX0xPR0lURUNIX0cyN19XSEVFTCwgICBsZzRmZl93aGVlbF9lZmZlY3RzLCA0MCwg
OTAwLCBsZzRmZl9zZXRfcmFuZ2VfZzI1fSwKIAl7VVNCX0RFVklDRV9JRF9MT0dJVEVDSF9H
MjlfV0hFRUwsICAgbGc0ZmZfd2hlZWxfZWZmZWN0cywgNDAsIDkwMCwgbGc0ZmZfc2V0X3Jh
bmdlX2cyNX0sCiAJe1VTQl9ERVZJQ0VfSURfTE9HSVRFQ0hfTU9NT19XSEVFTDIsIGxnNGZm
X3doZWVsX2VmZmVjdHMsIDQwLCAyNzAsIE5VTEx9LAotCXtVU0JfREVWSUNFX0lEX0xPR0lU
RUNIX1dJSV9XSEVFTCwgICBsZzRmZl93aGVlbF9lZmZlY3RzLCA0MCwgMjcwLCBOVUxMfQor
CXtVU0JfREVWSUNFX0lEX0xPR0lURUNIX1dJSV9XSEVFTCwgICBsZzRmZl93aGVlbF9lZmZl
Y3RzLCA0MCwgMjcwLCBOVUxMfSwKKwl7VVNCX0RFVklDRV9JRF9FTkRPUl9DTFVCU1BPUlRf
V0hFRUwsIGxnNGZmX3doZWVsX2VmZmVjdHMsIDQwLCA5MDAsIE5VTEx9IAogfTsKIAogc3Rh
dGljIGNvbnN0IHN0cnVjdCBsZzRmZl9tdWx0aW1vZGVfd2hlZWwgbGc0ZmZfbXVsdGltb2Rl
X3doZWVsc1tdID0gewo=
--------------439F71FE5DC96456F14B5318--
