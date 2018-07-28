From: John S Gruber <JohnSGruber@gmail.com>
Subject: [PATCH 2/2] HID: redragon Add additional verification to rdesc
 modification quirk
Date: Sat, 28 Jul 2018 15:53:51 -0400
Message-ID: <CAPotdmQh_sWqPmiQ=_+fJ27AT7GA5hcne=wsXcmKhNnUpUs3wQ@mail.gmail.com>
References: <CAPotdmQtXmfHJfcgrXZ02NrPgS3Az=SpZnBsRZ_8dGvPfdi+Mw@mail.gmail.com>
 <1532807605-26023-1-git-send-email-JohnSGruber@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532807605-26023-1-git-send-email-JohnSGruber@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Robert Munteanu <rombert@apache.org>, linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, JohnSGruber@gmail.com
List-Id: linux-input@vger.kernel.org

There are many devices using the vendor_id 0c45 and device_id of 760b
combination. Also the two bytes 0x81 0x00 aren't rare for a report
description. For these reasons the report description being altered
by the quirk should be verified more completely

If I'm understanding this correctly, I believe for an array field the
report_size should be greater or equal to
ceil(log2(usage_maximum - usage_minimum + 1)). That's 3 bits for these 8
shift keys, 0xe0-0xe7. Therefore the incorrect report description can't
be valid for any device.

Check the actual count of the rdesc and compare the entire field
description to reduce the chance of patching the wrong thing by
inadvertence.

Signed-off-by: John S Gruber <JohnSGruber@gmail.com>
---
 drivers/hid/hid-redragon.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-redragon.c b/drivers/hid/hid-redragon.c
index 85a5fbb..6e506cb 100644
--- a/drivers/hid/hid-redragon.c
+++ b/drivers/hid/hid-redragon.c
@@ -18,6 +18,21 @@

 #include "hid-ids.h"

+static __u8 asura_redragon_badfield[] = {
+	0x05, 0x01,	/* Usage Page (GenericDesktop)		*/
+	0x09, 0x06,	/* Usage (Keyboard)			*/
+	0xa1, 0x01,	/* Collection (Application)		*/
+	0x85, 0x04,	/* Report ID (4)			*/
+	0x05, 0x07,	/* Usage Page (Keyboard)		*/
+	0x19, 0xe0,	/* Usage Minimum (0xe0) Left Control	*/
+	0x29, 0xe7,	/* Usage Maximum (0xe7) Right GUI	*/
+	0x15, 0x00,	/* Logical Minimum (0)			*/
+	0x25, 0x01,	/* Logical Maximum (1)			*/
+	0x75, 0x01,	/* Report Size (1)			*/
+	0x95, 0x08,	/* Report Count(8)			*/
+	0x81, 0x00	/* Input Array [Should be Input Var]	*/
+};
+

 /*
  * The Redragon Asura keyboard sends an incorrect HID descriptor.
@@ -36,7 +51,9 @@
 static __u8 *redragon_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	unsigned int *rsize)
 {
-	if (*rsize >= 102 && rdesc[100] == 0x81 && rdesc[101] == 0x00) {
+	if (*rsize == 169 &&
+			memcmp(&rdesc[78], asura_redragon_badfield,
+			sizeof(asura_redragon_badfield)) == 0) {
 		dev_info(&hdev->dev, "Fixing Redragon ASURA report descriptor.\n");
 		rdesc[101] = 0x02;
 	}
-- 
1.9.1
