From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 31/39] HID: uclogic: Add support for Huion HS64 tablet
Date: Tue,  2 Jul 2019 22:15:06 -0400
Message-ID: <20190703021514.17727-31-sashal@kernel.org>
References: <20190703021514.17727-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190703021514.17727-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Kyle Godbey <me@kyle.ee>, Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Kyle Godbey <me@kyle.ee>

[ Upstream commit 315ffcc9a1e054bb460f9203058b52dc26b1173d ]

Add support for Huion HS64 drawing tablet to hid-uclogic

Signed-off-by: Kyle Godbey <me@kyle.ee>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h            | 1 +
 drivers/hid/hid-uclogic-core.c   | 2 ++
 drivers/hid/hid-uclogic-params.c | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b5615ffa74ba..4ea272eb34c8 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -572,6 +572,7 @@
 
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
2.20.1
