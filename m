From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 6/6] HID: uclogic: actually invert the in-range bit for huion tablets only
Date: Thu, 26 Feb 2015 13:57:29 -0500
Message-ID: <1424977049-18648-7-git-send-email-benjamin.tissoires@redhat.com>
References: <1424977049-18648-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424977049-18648-1-git-send-email-benjamin.tissoires@redhat.com>
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

New in v2

 drivers/hid/hid-uclogic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
index f44e72b..5f5c16e 100644
--- a/drivers/hid/hid-uclogic.c
+++ b/drivers/hid/hid-uclogic.c
@@ -930,7 +930,8 @@ static int uclogic_raw_event(struct hid_device *hdev, struct hid_report *report,
 	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
 
 	/* If this is a pen input report */
-	if (intf->cur_altsetting->desc.bInterfaceNumber == 0 &&
+	if (hdev->product == USB_DEVICE_ID_HUION_TABLET &&
+	    intf->cur_altsetting->desc.bInterfaceNumber == 0 &&
 	    report->type == HID_INPUT_REPORT &&
 	    report->id == 0x07 && size >= 2)
 		/* Invert the in-range bit */
-- 
2.1.0
