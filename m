From: "johann deneux" <johann.deneux@gmail.com>
Subject: [PATCH] iforce: Use interrupt URBs
Date: Sat, 12 May 2007 16:18:26 +0200
Message-ID: <38b3b7c0705120718m55073ca3i6f3d0012a93d7956@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_149382_11370532.1178979506800"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: dmitry <dmitry.torokhov@gmail.com>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>
List-Id: linux-input@vger.kernel.org

------=_Part_149382_11370532.1178979506800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

    Bug fix: Force feedback stopped working in 2.7.18.

    Use an interrupt bulk URB to send force-feedback data to the device
    instead of a bulk URB.

    Signed-off-by: Johann Deneux <johann.deneux@gmail.com>

diff --git a/drivers/input/joystick/iforce/iforce-usb.c
b/drivers/input/joystick/iforce/iforce-usb.c
index 750099d..1457b73 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -65,6 +65,7 @@ void iforce_usb_xmit(struct iforce *iforce)
 	XMIT_INC(iforce->xmit.tail, n);

 	if ( (n=usb_submit_urb(iforce->out, GFP_ATOMIC)) ) {
+		clear_bit(IFORCE_XMIT_RUNNING, iforce->xmit_flags);
 		warn("usb_submit_urb failed %d\n", n);
 	}

@@ -163,8 +164,8 @@ static int iforce_usb_probe(struct usb_interface *intf,
 	usb_fill_int_urb(iforce->irq, dev, usb_rcvintpipe(dev,
epirq->bEndpointAddress),
 			iforce->data, 16, iforce_usb_irq, iforce, epirq->bInterval);

-	usb_fill_bulk_urb(iforce->out, dev, usb_sndbulkpipe(dev,
epout->bEndpointAddress),
-			iforce + 1, 32, iforce_usb_out, iforce);
+	usb_fill_int_urb(iforce->out, dev, usb_sndintpipe(dev,
epout->bEndpointAddress),
+			iforce + 1, 32, iforce_usb_out, iforce, epout->bInterval);

 	usb_fill_control_urb(iforce->ctrl, dev, usb_rcvctrlpipe(dev, 0),
 			(void*) &iforce->cr, iforce->edata, 16, iforce_usb_ctrl, iforce);

------=_Part_149382_11370532.1178979506800
Content-Type: text/plain; name=patch-2007-05-12.txt; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f1m5xxq7
Content-Disposition: attachment; filename="patch-2007-05-12.txt"

Y29tbWl0IDhmZGFiYjc4MGY0ZTU5ZmFhOTI4YTgwNDBkNGQ3ZGE0Y2U1ZTliYjcKQXV0aG9yOiBK
b2hhbm4gRGVuZXV4IDxqb2hhbm4uZGVuZXV4QGdtYWlsLmNvbT4KRGF0ZTogICBTYXQgTWF5IDEy
IDE2OjAxOjQ2IDIwMDcgKzAyMDAKCiAgICBCdWcgZml4OiBGb3JjZSBmZWVkYmFjayBzdG9wcGVk
IHdvcmtpbmcgaW4gMi43LjE4LgogICAgCiAgICBVc2UgYW4gaW50ZXJydXB0IGJ1bGsgVVJCIHRv
IHNlbmQgZm9yY2UtZmVlZGJhY2sgZGF0YSB0byB0aGUgZGV2aWNlCiAgICBpbnN0ZWFkIG9mIGEg
YnVsayBVUkIuCiAgICAKICAgIFNpZ25lZC1vZmYtYnk6IEpvaGFubiBEZW5ldXggPGpvaGFubi5k
ZW5ldXhAZ21haWwuY29tPgoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5wdXQvam95c3RpY2svaWZv
cmNlL2lmb3JjZS11c2IuYyBiL2RyaXZlcnMvaW5wdXQvam95c3RpY2svaWZvcmNlL2lmb3JjZS11
c2IuYwppbmRleCA3NTAwOTlkLi4xNDU3YjczIDEwMDY0NAotLS0gYS9kcml2ZXJzL2lucHV0L2pv
eXN0aWNrL2lmb3JjZS9pZm9yY2UtdXNiLmMKKysrIGIvZHJpdmVycy9pbnB1dC9qb3lzdGljay9p
Zm9yY2UvaWZvcmNlLXVzYi5jCkBAIC02NSw2ICs2NSw3IEBAIHZvaWQgaWZvcmNlX3VzYl94bWl0
KHN0cnVjdCBpZm9yY2UgKmlmb3JjZSkKIAlYTUlUX0lOQyhpZm9yY2UtPnhtaXQudGFpbCwgbik7
CiAKIAlpZiAoIChuPXVzYl9zdWJtaXRfdXJiKGlmb3JjZS0+b3V0LCBHRlBfQVRPTUlDKSkgKSB7
CisJCWNsZWFyX2JpdChJRk9SQ0VfWE1JVF9SVU5OSU5HLCBpZm9yY2UtPnhtaXRfZmxhZ3MpOwog
CQl3YXJuKCJ1c2Jfc3VibWl0X3VyYiBmYWlsZWQgJWRcbiIsIG4pOwogCX0KIApAQCAtMTYzLDgg
KzE2NCw4IEBAIHN0YXRpYyBpbnQgaWZvcmNlX3VzYl9wcm9iZShzdHJ1Y3QgdXNiX2ludGVyZmFj
ZSAqaW50ZiwKIAl1c2JfZmlsbF9pbnRfdXJiKGlmb3JjZS0+aXJxLCBkZXYsIHVzYl9yY3ZpbnRw
aXBlKGRldiwgZXBpcnEtPmJFbmRwb2ludEFkZHJlc3MpLAogCQkJaWZvcmNlLT5kYXRhLCAxNiwg
aWZvcmNlX3VzYl9pcnEsIGlmb3JjZSwgZXBpcnEtPmJJbnRlcnZhbCk7CiAKLQl1c2JfZmlsbF9i
dWxrX3VyYihpZm9yY2UtPm91dCwgZGV2LCB1c2Jfc25kYnVsa3BpcGUoZGV2LCBlcG91dC0+YkVu
ZHBvaW50QWRkcmVzcyksCi0JCQlpZm9yY2UgKyAxLCAzMiwgaWZvcmNlX3VzYl9vdXQsIGlmb3Jj
ZSk7CisJdXNiX2ZpbGxfaW50X3VyYihpZm9yY2UtPm91dCwgZGV2LCB1c2Jfc25kaW50cGlwZShk
ZXYsIGVwb3V0LT5iRW5kcG9pbnRBZGRyZXNzKSwKKwkJCWlmb3JjZSArIDEsIDMyLCBpZm9yY2Vf
dXNiX291dCwgaWZvcmNlLCBlcG91dC0+YkludGVydmFsKTsKIAogCXVzYl9maWxsX2NvbnRyb2xf
dXJiKGlmb3JjZS0+Y3RybCwgZGV2LCB1c2JfcmN2Y3RybHBpcGUoZGV2LCAwKSwKIAkJCSh2b2lk
KikgJmlmb3JjZS0+Y3IsIGlmb3JjZS0+ZWRhdGEsIDE2LCBpZm9yY2VfdXNiX2N0cmwsIGlmb3Jj
ZSk7Cg==
------=_Part_149382_11370532.1178979506800--
