From: "johann deneux" <johann.deneux@gmail.com>
Subject: [PATCH] iforce: Clean-ups
Date: Sat, 12 May 2007 16:21:03 +0200
Message-ID: <38b3b7c0705120721x1f0717dfsb1d8c5785235f027@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_149394_20524571.1178979663816"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: dmitry <dmitry.torokhov@gmail.com>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>
List-Id: linux-input@vger.kernel.org

------=_Part_149394_20524571.1178979663816
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

    Minor clean-ups.

    Signed-off-by: Johann Deneux <johann.deneux@gmail.com>

diff --git a/drivers/input/joystick/iforce/iforce-main.c
b/drivers/input/joystick/iforce/iforce-main.c
index fb129c4..682244b 100644
--- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -370,10 +370,8 @@ int iforce_init_device(struct iforce *iforce)

 /*
  * Disable spring, enable force feedback.
- * FIXME: We should use iforce_set_autocenter() et al here.
  */
-
-	iforce_send_packet(iforce, FF_CMD_AUTOCENTER, "\004\000");
+	iforce_set_autocenter(input_dev, 0);

 /*
  * Find appropriate device entry
diff --git a/drivers/input/joystick/iforce/iforce-packets.c
b/drivers/input/joystick/iforce/iforce-packets.c
index 21c4e13..ebce070 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -246,6 +246,8 @@ void iforce_process_packet(struct iforce *iforce,
u16 cmd, unsigned char *data)

 int iforce_get_id_packet(struct iforce *iforce, char *packet)
 {
+	int status;
+
 	switch (iforce->bus) {

 	case IFORCE_USB:
@@ -254,18 +256,23 @@ int iforce_get_id_packet(struct iforce *iforce,
char *packet)
 		iforce->cr.bRequest = packet[0];
 		iforce->ctrl->dev = iforce->usbdev;

-		if (usb_submit_urb(iforce->ctrl, GFP_ATOMIC))
+		status = usb_submit_urb(iforce->ctrl, GFP_ATOMIC);
+		if (status)
+		{
+			err("usb_submit_urb failed %d", status);
 			return -1;
+		}

 		wait_event_interruptible_timeout(iforce->wait,
 			iforce->ctrl->status != -EINPROGRESS, HZ);

 		if (iforce->ctrl->status) {
+			dbg("iforce->ctrl->status = %d", iforce->ctrl->status);
 			usb_unlink_urb(iforce->ctrl);
 			return -1;
 		}
 #else
-		err("iforce_get_id_packet: iforce->bus = USB!");
+		dbg("iforce_get_id_packet: iforce->bus = USB!");
 #endif
 		break;

------=_Part_149394_20524571.1178979663816
Content-Type: text/plain; name=patch-2007-05-12-2.txt;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f1m61ekl
Content-Disposition: attachment; filename="patch-2007-05-12-2.txt"

Y29tbWl0IDM4N2FhZjE4YWFkOGJiZTAzNTc5OTkyOTlhN2ViMDhlMTFiMzBjNTAKQXV0aG9yOiBK
b2hhbm4gRGVuZXV4IDxqb2hhbm4uZGVuZXV4QGdtYWlsLmNvbT4KRGF0ZTogICBTYXQgTWF5IDEy
IDE2OjA0OjI5IDIwMDcgKzAyMDAKCiAgICBNaW5vciBjbGVhbi11cHMuCiAgICAKICAgIFNpZ25l
ZC1vZmYtYnk6IEpvaGFubiBEZW5ldXggPGpvaGFubi5kZW5ldXhAZ21haWwuY29tPgoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaW5wdXQvam95c3RpY2svaWZvcmNlL2lmb3JjZS1tYWluLmMgYi9kcml2
ZXJzL2lucHV0L2pveXN0aWNrL2lmb3JjZS9pZm9yY2UtbWFpbi5jCmluZGV4IGZiMTI5YzQuLjY4
MjI0NGIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW5wdXQvam95c3RpY2svaWZvcmNlL2lmb3JjZS1t
YWluLmMKKysrIGIvZHJpdmVycy9pbnB1dC9qb3lzdGljay9pZm9yY2UvaWZvcmNlLW1haW4uYwpA
QCAtMzcwLDEwICszNzAsOCBAQCBpbnQgaWZvcmNlX2luaXRfZGV2aWNlKHN0cnVjdCBpZm9yY2Ug
Kmlmb3JjZSkKIAogLyoKICAqIERpc2FibGUgc3ByaW5nLCBlbmFibGUgZm9yY2UgZmVlZGJhY2su
Ci0gKiBGSVhNRTogV2Ugc2hvdWxkIHVzZSBpZm9yY2Vfc2V0X2F1dG9jZW50ZXIoKSBldCBhbCBo
ZXJlLgogICovCi0KLQlpZm9yY2Vfc2VuZF9wYWNrZXQoaWZvcmNlLCBGRl9DTURfQVVUT0NFTlRF
UiwgIlwwMDRcMDAwIik7CisJaWZvcmNlX3NldF9hdXRvY2VudGVyKGlucHV0X2RldiwgMCk7CiAK
IC8qCiAgKiBGaW5kIGFwcHJvcHJpYXRlIGRldmljZSBlbnRyeQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pbnB1dC9qb3lzdGljay9pZm9yY2UvaWZvcmNlLXBhY2tldHMuYyBiL2RyaXZlcnMvaW5wdXQv
am95c3RpY2svaWZvcmNlL2lmb3JjZS1wYWNrZXRzLmMKaW5kZXggMjFjNGUxMy4uZWJjZTA3MCAx
MDA2NDQKLS0tIGEvZHJpdmVycy9pbnB1dC9qb3lzdGljay9pZm9yY2UvaWZvcmNlLXBhY2tldHMu
YworKysgYi9kcml2ZXJzL2lucHV0L2pveXN0aWNrL2lmb3JjZS9pZm9yY2UtcGFja2V0cy5jCkBA
IC0yNDYsNiArMjQ2LDggQEAgdm9pZCBpZm9yY2VfcHJvY2Vzc19wYWNrZXQoc3RydWN0IGlmb3Jj
ZSAqaWZvcmNlLCB1MTYgY21kLCB1bnNpZ25lZCBjaGFyICpkYXRhKQogCiBpbnQgaWZvcmNlX2dl
dF9pZF9wYWNrZXQoc3RydWN0IGlmb3JjZSAqaWZvcmNlLCBjaGFyICpwYWNrZXQpCiB7CisJaW50
IHN0YXR1czsKKwogCXN3aXRjaCAoaWZvcmNlLT5idXMpIHsKIAogCWNhc2UgSUZPUkNFX1VTQjoK
QEAgLTI1NCwxOCArMjU2LDIzIEBAIGludCBpZm9yY2VfZ2V0X2lkX3BhY2tldChzdHJ1Y3QgaWZv
cmNlICppZm9yY2UsIGNoYXIgKnBhY2tldCkKIAkJaWZvcmNlLT5jci5iUmVxdWVzdCA9IHBhY2tl
dFswXTsKIAkJaWZvcmNlLT5jdHJsLT5kZXYgPSBpZm9yY2UtPnVzYmRldjsKIAotCQlpZiAodXNi
X3N1Ym1pdF91cmIoaWZvcmNlLT5jdHJsLCBHRlBfQVRPTUlDKSkKKwkJc3RhdHVzID0gdXNiX3N1
Ym1pdF91cmIoaWZvcmNlLT5jdHJsLCBHRlBfQVRPTUlDKTsKKwkJaWYgKHN0YXR1cykKKwkJewor
CQkJZXJyKCJ1c2Jfc3VibWl0X3VyYiBmYWlsZWQgJWQiLCBzdGF0dXMpOwogCQkJcmV0dXJuIC0x
OworCQl9CiAKIAkJd2FpdF9ldmVudF9pbnRlcnJ1cHRpYmxlX3RpbWVvdXQoaWZvcmNlLT53YWl0
LAogCQkJaWZvcmNlLT5jdHJsLT5zdGF0dXMgIT0gLUVJTlBST0dSRVNTLCBIWik7CiAKIAkJaWYg
KGlmb3JjZS0+Y3RybC0+c3RhdHVzKSB7CisJCQlkYmcoImlmb3JjZS0+Y3RybC0+c3RhdHVzID0g
JWQiLCBpZm9yY2UtPmN0cmwtPnN0YXR1cyk7CiAJCQl1c2JfdW5saW5rX3VyYihpZm9yY2UtPmN0
cmwpOwogCQkJcmV0dXJuIC0xOwogCQl9CiAjZWxzZQotCQllcnIoImlmb3JjZV9nZXRfaWRfcGFj
a2V0OiBpZm9yY2UtPmJ1cyA9IFVTQiEiKTsKKwkJZGJnKCJpZm9yY2VfZ2V0X2lkX3BhY2tldDog
aWZvcmNlLT5idXMgPSBVU0IhIik7CiAjZW5kaWYKIAkJYnJlYWs7CiAK
------=_Part_149394_20524571.1178979663816--
