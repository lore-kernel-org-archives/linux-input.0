From: Kyle Godbey <me@kyle.ee>
Subject: [PATCH] HID: uclogic: Add support for Huion HS64 tablet
Date: Sat, 15 Jun 2019 18:15:06 -0500
Message-ID: <20190615231506.17443-1-me@kyle.ee>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kyle Godbey <me@kyle.ee>
List-Id: linux-input@vger.kernel.org

Add support for Huion HS64 drawing tablet to hid-uclogic

Signed-off-by: Kyle Godbey <me@kyle.ee>
---
 drivers/hid/hid-ids.h            | 1 +
 drivers/hid/hid-uclogic-core.c   | 2 ++
 drivers/hid/hid-uclogic-params.c | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 84e0c78d73cd..86ed32dd18ca 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -569,6 +569,7 @@
 
 #define USB_VENDOR_ID_HUION		0x256c
 #define USB_DEVICE_ID_HUION_TABLET	0x006e
+#define USB_DEVICE_ID_HUION_HS64	0x006d
 
 #define USB_VENDOR_ID_IBM					0x04b3
 #define USB_DEVICE_ID_IBM_SCROLLPOINT_III			0x3100
diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index 8fe02d81265d..914fb527ae7a 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -369,6 +369,8 @@ static const struct hid_device_id uclogic_devices[] = {
 				USB_DEVICE_ID_UCLOGIC_TABLET_TWHA60) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HUION,
 				USB_DEVICE_ID_HUION_TABLET) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HUION,
+				USB_DEVICE_ID_HUION_HS64) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC,
 				USB_DEVICE_ID_HUION_TABLET) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC,
diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 0187c9f8fc22..273d784fff66 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -977,6 +977,8 @@ int uclogic_params_init(struct uclogic_params *params,
 		/* FALL THROUGH */
 	case VID_PID(USB_VENDOR_ID_HUION,
 		     USB_DEVICE_ID_HUION_TABLET):
+	case VID_PID(USB_VENDOR_ID_HUION,
+		     USB_DEVICE_ID_HUION_HS64):
 	case VID_PID(USB_VENDOR_ID_UCLOGIC,
 		     USB_DEVICE_ID_HUION_TABLET):
 	case VID_PID(USB_VENDOR_ID_UCLOGIC,
-- 
2.21.0
