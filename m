From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: uclogic: make input_mapping independent of usb
Date: Fri, 13 Mar 2015 11:42:02 -0400
Message-ID: <1426261322-7451-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

No need to retrieve the USB handle in input_mapping() when we already
do that in probe. It also allows to use the quirk without having to
add the product ID matching.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Nick,

no need to cc DIGImend-devel when replying on this one, I'll send the same
to DIGImend-devel as soon as I have a patchwork link.

Cheers,
Benjamin

 drivers/hid/hid-uclogic.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
index bdda9fd..6473e83 100644
--- a/drivers/hid/hid-uclogic.c
+++ b/drivers/hid/hid-uclogic.c
@@ -627,6 +627,7 @@ struct uclogic_drvdata {
 	__u8 *rdesc;
 	unsigned int rsize;
 	bool invert_pen_inrange;
+	bool ignore_pen_interface;
 };
 
 static __u8 *uclogic_report_fixup(struct hid_device *hdev, __u8 *rdesc,
@@ -719,16 +720,12 @@ static int uclogic_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
 {
-	struct usb_interface *intf;
-
-	if (hdev->product == USB_DEVICE_ID_HUION_TABLET) {
-		intf = to_usb_interface(hdev->dev.parent);
+	struct uclogic_drvdata *drvdata = hid_get_drvdata(hdev);
 
-		/* discard the unused pen interface */
-		if ((intf->cur_altsetting->desc.bInterfaceNumber != 0) &&
-		    (field->application == HID_DG_PEN))
-			return -1;
-	}
+	/* discard the unused pen interface */
+	if ((drvdata->ignore_pen_interface) &&
+	    (field->application == HID_DG_PEN))
+		return -1;
 
 	/* let hid-core decide what to do */
 	return 0;
@@ -908,6 +905,8 @@ static int uclogic_probe(struct hid_device *hdev,
 				return rc;
 			}
 			drvdata->invert_pen_inrange = true;
+		} else {
+			drvdata->ignore_pen_interface = true;
 		}
 		break;
 	}
-- 
2.3.1
