From: "Nuno Lucas" <ntlucas@gmail.com>
Subject: [PATCH] linux-input: TSC-10 DM USB touchscreen driver assume 2-byte response from controller
Date: Thu, 6 Nov 2008 15:25:40 +0000
Message-ID: <c4f20e170811060725v2ae331f9t7b1ba48059f93170@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_23384_23790623.1225985140744"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:60403 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbYKFPZn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Nov 2008 10:25:43 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>, Andrew Morton <akpm@linux-foundation.org>

------=_Part_23384_23790623.1225985140744
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The usbtouchscreen module implements a driver for the TSC-10 DM USB
touchscreen controllers, but assumes a 2-byte response for the
CMD_RESET and CMD_RATE commands, when they can be only a single byte
when no EEPROM is connected.

The driver worked with an earlier controller revision, but new
revisions of the controller fail.

It seems the problem is that the early controller had the
SEL4/EEPROM-CS pin high, but the new controller has it down, making
the response different.

Without the fix, the controller would answer the single byte 0x06
(ACK), making the init fail with -ENODEV because buf[1] is 0xFF (as
initialized before).

As the single byte is the only thing we need to check it was ok, there
is no need to verify the second byte.

The [0x15 0x01] case is the NAK [0x15] response for when there is no
data in the EEPROM [bit-0 of second byte set], so I let that be, as I
don't have any controller with an EEPROM.

With this patch, both the earlier and latest controller work the same.

Note: This was previously submited as BUG #11961 [1] on the bugzilla
tracker, but rebased to version 2.6.27.4 and with unnecessary comments
and printk's removed.


Signed-off-by: Nuno Lucas <ntlucas@gmail.com>


[1] http://bugzilla.kernel.org/show_bug.cgi?id=11961

------=_Part_23384_23790623.1225985140744
Content-Type: text/x-patch; name=patch-fix_for_some_tsc205_controllers.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fn7jtj9h0
Content-Disposition: attachment;
 filename=patch-fix_for_some_tsc205_controllers.diff

ZGlmZiAtdXJOcCBsaW51eC0yLjYuMjcuNC9kcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL3VzYnRv
dWNoc2NyZWVuLmMgbGludXgtMi42LjI3LjQtcGF0Y2hlZC9kcml2ZXJzL2lucHV0L3RvdWNoc2Ny
ZWVuL3VzYnRvdWNoc2NyZWVuLmMKLS0tIGxpbnV4LTIuNi4yNy40L2RyaXZlcnMvaW5wdXQvdG91
Y2hzY3JlZW4vdXNidG91Y2hzY3JlZW4uYwkyMDA4LTEwLTI1IDIzOjA1OjA3LjAwMDAwMDAwMCAr
MDEwMAorKysgbGludXgtMi42LjI3LjQtcGF0Y2hlZC9kcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVu
L3VzYnRvdWNoc2NyZWVuLmMJMjAwOC0xMS0wNiAxNTowNzo0OS4wMDAwMDAwMDAgKzAwMDAKQEAg
LTQyNCw3ICs0MjQsNyBAQCBzdGF0aWMgaW50IGRtY190c2MxMF9pbml0KHN0cnVjdCB1c2J0b3Vj
CiAJICAgICAgICAgICAgICAgICAgICAgIDAsIDAsIGJ1ZiwgMiwgVVNCX0NUUkxfU0VUX1RJTUVP
VVQpOwogCWlmIChyZXQgPCAwKQogCQlnb3RvIGVycl9vdXQ7Ci0JaWYgKGJ1ZlswXSAhPSAweDA2
IHx8IGJ1ZlsxXSAhPSAweDAwKSB7CisJaWYgKGJ1ZlswXSAhPSAweDA2KSB7CiAJCXJldCA9IC1F
Tk9ERVY7CiAJCWdvdG8gZXJyX291dDsKIAl9CkBAIC00MzcsOCArNDM3LDcgQEAgc3RhdGljIGlu
dCBkbWNfdHNjMTBfaW5pdChzdHJ1Y3QgdXNidG91YwogCSAgICAgICAgICAgICAgICAgICAgICBU
U0MxMF9SQVRFXzE1MCwgMCwgYnVmLCAyLCBVU0JfQ1RSTF9TRVRfVElNRU9VVCk7CiAJaWYgKHJl
dCA8IDApCiAJCWdvdG8gZXJyX291dDsKLQlpZiAoKGJ1ZlswXSAhPSAweDA2IHx8IGJ1ZlsxXSAh
PSAweDAwKSAmJgotCSAgICAoYnVmWzBdICE9IDB4MTUgfHwgYnVmWzFdICE9IDB4MDEpKSB7CisJ
aWYgKChidWZbMF0gIT0gMHgwNikgJiYgKGJ1ZlswXSAhPSAweDE1IHx8IGJ1ZlsxXSAhPSAweDAx
KSkgewogCQlyZXQgPSAtRU5PREVWOwogCQlnb3RvIGVycl9vdXQ7CiAJfQo=
------=_Part_23384_23790623.1225985140744--
