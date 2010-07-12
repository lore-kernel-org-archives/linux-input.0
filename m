From: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Subject: [PATCH 2/3] HID: add HID_QUIRK_HIDINPUT_FORCE
Date: Mon, 12 Jul 2010 19:28:27 +0200
Message-ID: <1278955708-9428-2-git-send-email-daniel@caiaq.de>
References: <1278955708-9428-1-git-send-email-daniel@caiaq.de>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1278955708-9428-1-git-send-email-daniel-rDUAYElUppE@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

For devices with exotic HID report descriptors, it might be necessary to
make the HID core force the registration of an input device. Make that
possible by introducing a new quirk type.

Signed-off-by: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/hid/hid-core.c |    2 ++
 include/linux/hid.h    |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index aa0f7dc..5751db4 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1157,6 +1157,8 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 
 	if (hdev->quirks & HID_QUIRK_HIDDEV_FORCE)
 		connect_mask |= (HID_CONNECT_HIDDEV_FORCE | HID_CONNECT_HIDDEV);
+	if (hdev->quirks & HID_QUIRK_HIDINPUT_FORCE)
+		connect_mask |= HID_CONNECT_HIDINPUT_FORCE;
 	if (hdev->bus != BUS_USB)
 		connect_mask &= ~HID_CONNECT_HIDDEV;
 	if (hid_hiddev(hdev))
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 895001f..42a0f1d 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -311,6 +311,7 @@ struct hid_item {
 #define HID_QUIRK_HIDDEV_FORCE			0x00000010
 #define HID_QUIRK_BADPAD			0x00000020
 #define HID_QUIRK_MULTI_INPUT			0x00000040
+#define HID_QUIRK_HIDINPUT_FORCE		0x00000080
 #define HID_QUIRK_SKIP_OUTPUT_REPORTS		0x00010000
 #define HID_QUIRK_FULLSPEED_INTERVAL		0x10000000
 #define HID_QUIRK_NO_INIT_REPORTS		0x20000000
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
