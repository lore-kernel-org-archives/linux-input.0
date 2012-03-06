From: "benjamin.tissoires" <benjamin.tissoires@gmail.com>
Subject: [PATCH 2/4] HID: multitouch: add new PID from Ideacom
Date: Tue,  6 Mar 2012 10:53:46 +0100
Message-ID: <1331027628-7946-2-git-send-email-benjamin.tissoires@gmail.com>
References: <1331027628-7946-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1331027628-7946-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "benjamin.tissoires" <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Benjamin Tissoires <benjamin.tissoires@enac.fr>

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
---
 drivers/hid/hid-ids.h        |    1 +
 drivers/hid/hid-multitouch.c |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 36664d8..e2fb977 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -374,6 +374,7 @@
 
 #define USB_VENDOR_ID_IDEACOM		0x1cb6
 #define USB_DEVICE_ID_IDEACOM_IDC6650	0x6650
+#define USB_DEVICE_ID_IDEACOM_IDC6651	0x6651
 
 #define USB_VENDOR_ID_ILITEK		0x222a
 #define USB_DEVICE_ID_ILITEK_MULTITOUCH	0x0001
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 04adb4b..1e6de67 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -825,6 +825,9 @@ static const struct hid_device_id mt_devices[] = {
 	{ .driver_data = MT_CLS_SERIAL,
 		HID_USB_DEVICE(USB_VENDOR_ID_IDEACOM,
 			USB_DEVICE_ID_IDEACOM_IDC6650) },
+	{ .driver_data = MT_CLS_SERIAL,
+		HID_USB_DEVICE(USB_VENDOR_ID_IDEACOM,
+			USB_DEVICE_ID_IDEACOM_IDC6651) },
 
 	/* Ilitek dual touch panel */
 	{  .driver_data = MT_CLS_DEFAULT,
-- 
1.7.7.6
