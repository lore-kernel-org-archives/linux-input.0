From: Matthieu CASTET <matthieu.castet-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] hid-core : optimize in case of hidraw
Date: Thu, 28 Jun 2012 16:53:11 +0200
Message-ID: <1340895191-13059-1-git-send-email-matthieu.castet@parrot.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jkosina-AlSwsSmVLrQ@public.gmane.org, Matthieu CASTET <matthieu.castet-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

When using hidraw, hid buffer can be big and take lot's of
time to process (interrupt) kernel context.
Don't try to parse report if we are only interrested in hidraw.

Also don't prepare data for debug stuff if no debugfs file
are opened.

Signed-off-by: Matthieu CASTET <matthieu.castet-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org>
---
 drivers/hid/hid-core.c    |   10 ++++++++--
 drivers/hid/hid-picolcd.c |    2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 8e3a6b2..9f8f7c6 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1194,8 +1194,10 @@ int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, int size,
 			goto out;
 	}
 
-	for (a = 0; a < report->maxfield; a++)
-		hid_input_field(hid, report->field[a], cdata, interrupt);
+	if (hid->claimed != HID_CLAIMED_HIDRAW) {
+		for (a = 0; a < report->maxfield; a++)
+			hid_input_field(hid, report->field[a], cdata, interrupt);
+	}
 
 	if (hid->claimed & HID_CLAIMED_INPUT)
 		hidinput_report_event(hid, report);
@@ -1243,6 +1245,10 @@ int hid_input_report(struct hid_device *hid, int type, u8 *data, int size, int i
 		goto unlock;
 	}
 
+	/* Avoid unnecessary overhead if debugfs is disabled */
+	if (list_empty(&hid->debug_list))
+		goto nomem;
+
 	buf = kmalloc(sizeof(char) * HID_DEBUG_BUFSIZE, GFP_ATOMIC);
 
 	if (!buf)
diff --git a/drivers/hid/hid-picolcd.c b/drivers/hid/hid-picolcd.c
index 45c3433..3e0a1e5 100644
--- a/drivers/hid/hid-picolcd.c
+++ b/drivers/hid/hid-picolcd.c
@@ -1846,7 +1846,7 @@ static void picolcd_debug_out_report(struct picolcd_data *data,
 #define BUFF_SZ 256
 
 	/* Avoid unnecessary overhead if debugfs is disabled */
-	if (!hdev->debug_events)
+	if (list_empty(&hdev->debug_list))
 		return;
 
 	buff = kmalloc(BUFF_SZ, GFP_ATOMIC);
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
