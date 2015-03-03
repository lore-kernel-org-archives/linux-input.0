From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 6/6] HID: uclogic: actually invert the in-range bit for huion tablets only
Date: Tue,  3 Mar 2015 12:44:05 -0500
Message-ID: <1425404645-20134-7-git-send-email-benjamin.tissoires@redhat.com>
References: <1425404645-20134-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425404645-20134-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>
List-Id: linux-input@vger.kernel.org

This hack is only needed for Huion tablets. It does not seem to have
any effect on the other tablets handled by this device right now, but
it's better to check for the product id sooner than discovering that
we have messed up one tablet later.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

changes in v3:
- stores a flag to know when to invert the bit.
- add #define UCLOGIC_PEN_REPORT_ID

new in v2

 drivers/hid/hid-uclogic.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
index f44e72b..bdda9fd 100644
--- a/drivers/hid/hid-uclogic.c
+++ b/drivers/hid/hid-uclogic.c
@@ -564,6 +564,7 @@ enum uclogic_ph_id {
 
 /* Report descriptor template placeholder */
 #define UCLOGIC_PH(_ID) UCLOGIC_PH_HEAD, UCLOGIC_PH_ID_##_ID
+#define UCLOGIC_PEN_REPORT_ID	0x07
 
 /* Fixed report descriptor template */
 static const __u8 uclogic_tablet_rdesc_template[] = {
@@ -625,6 +626,7 @@ enum uclogic_prm {
 struct uclogic_drvdata {
 	__u8 *rdesc;
 	unsigned int rsize;
+	bool invert_pen_inrange;
 };
 
 static __u8 *uclogic_report_fixup(struct hid_device *hdev, __u8 *rdesc,
@@ -905,6 +907,7 @@ static int uclogic_probe(struct hid_device *hdev,
 				hid_err(hdev, "tablet enabling failed\n");
 				return rc;
 			}
+			drvdata->invert_pen_inrange = true;
 		}
 		break;
 	}
@@ -927,12 +930,12 @@ static int uclogic_probe(struct hid_device *hdev,
 static int uclogic_raw_event(struct hid_device *hdev, struct hid_report *report,
 			u8 *data, int size)
 {
-	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
+	struct uclogic_drvdata *drvdata = hid_get_drvdata(hdev);
 
-	/* If this is a pen input report */
-	if (intf->cur_altsetting->desc.bInterfaceNumber == 0 &&
-	    report->type == HID_INPUT_REPORT &&
-	    report->id == 0x07 && size >= 2)
+	if ((drvdata->invert_pen_inrange) &&
+	    (report->type == HID_INPUT_REPORT) &&
+	    (report->id == UCLOGIC_PEN_REPORT_ID) &&
+	    (size >= 2))
 		/* Invert the in-range bit */
 		data[1] ^= 0x40;
 
-- 
2.1.0
