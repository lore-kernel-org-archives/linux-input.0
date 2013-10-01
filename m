From: Manoj Chourasia <mchourasia@nvidia.com>
Subject: RE: weird hidraw behaviour
Date: Tue, 1 Oct 2013 17:13:16 +0530
Message-ID: <F1F6C959961EA744BBD5B8EEF8B8FEA16DDD19DD16@BGMAIL02.nvidia.com>
References: <20130924085606.GI28875@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_F1F6C959961EA744BBD5B8EEF8B8FEA16DDD19DD16BGMAIL02nvidi_"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3479 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095Ab3JALnR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Oct 2013 07:43:17 -0400
In-Reply-To: <20130924085606.GI28875@intel.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

--_002_F1F6C959961EA744BBD5B8EEF8B8FEA16DDD19DD16BGMAIL02nvidi_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Mika,

Can you please try the attached patch and see if it fixes this issue?

Thanks
-Manoj

-----Original Message-----
From: Mika Westerberg [mailto:mika.westerberg@linux.intel.com]=20
Sent: Tuesday, September 24, 2013 2:26 PM
To: Jiri Kosina; Manoj Chourasia
Cc: linux-input@vger.kernel.org
Subject: Q: weird hidraw behaviour

Hi,

I noticed that after commit 212a871a393 (HID: hidraw: correctly deallocat=
e memory on device disconnect) hidraw doesn't close the underlying hid de=
vice when the device node is closed last time.

For example I have a touch panel (HID over I2C) device with added debug p=
rints in i2c_hid_open()/i2c_hid_close():

=09# od -x /dev/hidraw0
=09[   41.363813] i2c_hid 1-004c: i2c_hid_power lvl:32
=09[   41.368464] i2c_hid 1-004c: i2c_hid_set_power
=09[   41.372831] i2c_hid 1-004c: __i2c_hid_command: cmd=3D54 01 00 08
=09[   41.451455] i2c_hid 1-004c: i2c_hid_open
=09^C

=09# od -x /dev/hidraw0
=09[   58.420928] i2c_hid 1-004c: i2c_hid_power lvl:32
=09[   58.425577] i2c_hid 1-004c: i2c_hid_set_power
=09[   58.429945] i2c_hid 1-004c: __i2c_hid_command: cmd=3D54 01 00 08
=09[   58.525276] i2c_hid 1-004c: i2c_hid_open
=09^C

i2c_hid_close() is never called. Is this intended or am I missing somethi=
ng?

Thanks.

-------------------------------------------------------------------------=
----------
This email message is for the sole use of the intended recipient(s) and m=
ay contain
confidential information.  Any unauthorized review, use, disclosure or di=
stribution
is prohibited.  If you are not the intended recipient, please contact the=
=20sender by
reply email and destroy all copies of the original message.
-------------------------------------------------------------------------=
----------

--_002_F1F6C959961EA744BBD5B8EEF8B8FEA16DDD19DD16BGMAIL02nvidi_
Content-Type: application/octet-stream;
	name="HID-hidraw-close-underlying-device-at-removal-of-las.patch"
Content-Description: HID-hidraw-close-underlying-device-at-removal-of-las.patch
Content-Disposition: attachment;
	modification-date="Tue, 01 Oct 2013 11:30:49 GMT"; creation-date="Tue, 01 Oct 2013 11:40:02 GMT";
	size=1644;
	filename="HID-hidraw-close-underlying-device-at-removal-of-las.patch"
Content-Transfer-Encoding: base64

RnJvbSAwNWI4NTg5OTUzNGVhY2NlMjFkYjBiMzliODZiZWNhNjFkNzc5OWM4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYW5vaiBDaG91cmFzaWEgPG1jaG91cmFzaWFAbnZpZGlhLmNv
bT4KRGF0ZTogVHVlLCAxIE9jdCAyMDEzIDE1OjM5OjAwICswNTMwClN1YmplY3Q6IFtQQVRDSF0g
SElEOiBoaWRyYXc6IGNsb3NlIHVuZGVybHlpbmcgZGV2aWNlIGF0IHJlbW92YWwgb2YgbGFzdAog
cmVhZGVyCgpFdmVuIHRob3VnaCBkZXZpY2UgZXhpc3QgYml0IGlzIHNldCB0aGUgdW5kZXJseWlu
ZwpIVyBkZXZpY2Ugc2hvdWxkIGJlIGNsb3NlZCB3aGVuIHRoZSBsYXN0IHJlYWRlcgpvZiB0aGUg
ZGV2aWNlIGlzIGNsb3NlZCBpLmUuIG9wZW4gY291bnQgZHJvcHMgdG8gemVyby4KClNpZ25lZC1v
ZmYtYnk6IE1hbm9qIENob3VyYXNpYSA8bWNob3VyYXNpYUBudmlkaWEuY29tPgotLS0KIGRyaXZl
cnMvaGlkL2hpZHJhdy5jIHwgICAyMiArKysrKysrKysrKysrKystLS0tLS0tCiAxIGZpbGUgY2hh
bmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2hpZC9oaWRyYXcuYyBiL2RyaXZlcnMvaGlkL2hpZHJhdy5jCmluZGV4IGRiZmUzMDAuLjRm
YWY3MjggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaGlkL2hpZHJhdy5jCisrKyBiL2RyaXZlcnMvaGlk
L2hpZHJhdy5jCkBAIC0zMDUsMTkgKzMwNSwyNyBAQCBzdGF0aWMgaW50IGhpZHJhd19mYXN5bmMo
aW50IGZkLCBzdHJ1Y3QgZmlsZSAqZmlsZSwgaW50IG9uKQogc3RhdGljIHZvaWQgZHJvcF9yZWYo
c3RydWN0IGhpZHJhdyAqaGlkcmF3LCBpbnQgZXhpc3RzX2JpdCkKIHsKIAlpZiAoZXhpc3RzX2Jp
dCkgewotCQloaWRfaHdfY2xvc2UoaGlkcmF3LT5oaWQpOwogCQloaWRyYXctPmV4aXN0ID0gMDsK
LQkJaWYgKGhpZHJhdy0+b3BlbikKKwkJaWYgKGhpZHJhdy0+b3BlbikgeworCQkJaGlkX2h3X2Ns
b3NlKGhpZHJhdy0+aGlkKTsKIAkJCXdha2VfdXBfaW50ZXJydXB0aWJsZSgmaGlkcmF3LT53YWl0
KTsKKwkJfQogCX0gZWxzZSB7CiAJCS0taGlkcmF3LT5vcGVuOwogCX0KIAotCWlmICghaGlkcmF3
LT5vcGVuICYmICFoaWRyYXctPmV4aXN0KSB7Ci0JCWRldmljZV9kZXN0cm95KGhpZHJhd19jbGFz
cywgTUtERVYoaGlkcmF3X21ham9yLCBoaWRyYXctPm1pbm9yKSk7Ci0JCWhpZHJhd190YWJsZVto
aWRyYXctPm1pbm9yXSA9IE5VTEw7Ci0JCWtmcmVlKGhpZHJhdyk7Ci0JfQorCWlmICghaGlkcmF3
LT5vcGVuKQorCQlpZiAoIWhpZHJhdy0+ZXhpc3QpIHsKKwkJCWRldmljZV9kZXN0cm95KGhpZHJh
d19jbGFzcywKKwkJCQlNS0RFVihoaWRyYXdfbWFqb3IsIGhpZHJhdy0+bWlub3IpKTsKKwkJCWhp
ZHJhd190YWJsZVtoaWRyYXctPm1pbm9yXSA9IE5VTEw7CisJCQlrZnJlZShoaWRyYXcpOworCQl9
IGVsc2UgeworCQkJLyogY2xvc2UgZGV2aWNlIGZvciBsYXN0IHJlYWRlciAqLworCQkJaGlkX2h3
X3Bvd2VyKGhpZHJhdy0+aGlkLCBQTV9ISU5UX05PUk1BTCk7CisJCQloaWRfaHdfY2xvc2UoaGlk
cmF3LT5oaWQpOworCQl9CisKIH0KIAogc3RhdGljIGludCBoaWRyYXdfcmVsZWFzZShzdHJ1Y3Qg
aW5vZGUgKiBpbm9kZSwgc3RydWN0IGZpbGUgKiBmaWxlKQotLSAKMS43LjkuNQoK

--_002_F1F6C959961EA744BBD5B8EEF8B8FEA16DDD19DD16BGMAIL02nvidi_--
