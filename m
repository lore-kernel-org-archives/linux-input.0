From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 5/6] HID: uclogic: discard the extra Pen input node on Huion tablets
Date: Tue,  3 Mar 2015 12:44:04 -0500
Message-ID: <1425404645-20134-6-git-send-email-benjamin.tissoires@redhat.com>
References: <1425404645-20134-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425404645-20134-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>
List-Id: linux-input@vger.kernel.org

Some Huion tablets present 2 HID Pen interfaces. Only one is used, so
we can drop the unused one.

Reviewed-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

no changes in v3
new in v2

 drivers/hid/hid-uclogic.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
index ada8a94..f44e72b 100644
--- a/drivers/hid/hid-uclogic.c
+++ b/drivers/hid/hid-uclogic.c
@@ -713,6 +713,25 @@ static __u8 *uclogic_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	return rdesc;
 }
 
+static int uclogic_input_mapping(struct hid_device *hdev, struct hid_input *hi,
+		struct hid_field *field, struct hid_usage *usage,
+		unsigned long **bit, int *max)
+{
+	struct usb_interface *intf;
+
+	if (hdev->product == USB_DEVICE_ID_HUION_TABLET) {
+		intf = to_usb_interface(hdev->dev.parent);
+
+		/* discard the unused pen interface */
+		if ((intf->cur_altsetting->desc.bInterfaceNumber != 0) &&
+		    (field->application == HID_DG_PEN))
+			return -1;
+	}
+
+	/* let hid-core decide what to do */
+	return 0;
+}
+
 static void uclogic_input_configured(struct hid_device *hdev,
 		struct hid_input *hi)
 {
@@ -947,6 +966,7 @@ static struct hid_driver uclogic_driver = {
 	.probe = uclogic_probe,
 	.report_fixup = uclogic_report_fixup,
 	.raw_event = uclogic_raw_event,
+	.input_mapping = uclogic_input_mapping,
 	.input_configured = uclogic_input_configured,
 };
 module_hid_driver(uclogic_driver);
-- 
2.1.0
