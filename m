From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: [PATCH 3/3] hid-multitouch: add support for new Hanvon panels
Date: Tue, 29 Nov 2011 13:13:12 +0100
Message-ID: <1322568792-4432-4-git-send-email-benjamin.tissoires@enac.fr>
References: <1322568792-4432-1-git-send-email-benjamin.tissoires@enac.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1322568792-4432-1-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@enac.fr>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
---
 drivers/hid/hid-core.c       |    1 +
 drivers/hid/hid-ids.h        |    3 +++
 drivers/hid/hid-multitouch.c |    5 +++++
 3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index e3c9e61..24b6d4b 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1425,6 +1425,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GYRATION, USB_DEVICE_ID_GYRATION_REMOTE_2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GYRATION, USB_DEVICE_ID_GYRATION_REMOTE_3) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HANVON, USB_DEVICE_ID_HANVON_MULTITOUCH) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HANVON_ALT, USB_DEVICE_ID_HANVON_ALT_MULTITOUCH) },
  	{ HID_USB_DEVICE(USB_VENDOR_ID_IDEACOM, USB_DEVICE_ID_IDEACOM_IDC6650) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK, USB_DEVICE_ID_HOLTEK_ON_LINE_GRIP) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ILITEK, USB_DEVICE_ID_ILITEK_MULTITOUCH) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index ebfad17..4b4f346 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -359,6 +359,9 @@
 #define USB_VENDOR_ID_HANVON		0x20b3
 #define USB_DEVICE_ID_HANVON_MULTITOUCH	0x0a18
 
+#define USB_VENDOR_ID_HANVON_ALT	0x22ed
+#define USB_DEVICE_ID_HANVON_ALT_MULTITOUCH	0x1010
+
 #define USB_VENDOR_ID_HAPP		0x078b
 #define USB_DEVICE_ID_UGCI_DRIVING	0x0010
 #define USB_DEVICE_ID_UGCI_FLYING	0x0020
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index bd6e410..2d321a5 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -745,6 +745,11 @@ static const struct hid_device_id mt_devices[] = {
 		HID_USB_DEVICE(USB_VENDOR_ID_GOODTOUCH,
 			USB_DEVICE_ID_GOODTOUCH_000f) },
 
+	/* Hanvon panels */
+	{ .driver_data = MT_CLS_DUAL_INRANGE_CONTACTID,
+		HID_USB_DEVICE(USB_VENDOR_ID_HANVON_ALT,
+			USB_DEVICE_ID_HANVON_ALT_MULTITOUCH) },
+
 	/* Ideacom panel */
 	{ .driver_data = MT_CLS_SERIAL,
 		HID_USB_DEVICE(USB_VENDOR_ID_IDEACOM,
-- 
1.7.4.4
