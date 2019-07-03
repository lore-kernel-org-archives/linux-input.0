From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 32/39] HID: multitouch: Add pointstick support for ALPS Touchpad
Date: Tue,  2 Jul 2019 22:15:07 -0400
Message-ID: <20190703021514.17727-32-sashal@kernel.org>
References: <20190703021514.17727-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190703021514.17727-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 0a95fc733da375de0688d0f1fd3a2869a1c1d499 ]

There's a new ALPS touchpad/pointstick combo device that requires
MT_CLS_WIN_8_DUAL to make its pointsitck work as a mouse.

The device can be found on HP ZBook 17 G5.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h        | 1 +
 drivers/hid/hid-multitouch.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 4ea272eb34c8..cd7442eb25b9 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -83,6 +83,7 @@
 #define HID_DEVICE_ID_ALPS_U1_DUAL_3BTN_PTP	0x1220
 #define HID_DEVICE_ID_ALPS_U1		0x1215
 #define HID_DEVICE_ID_ALPS_T4_BTNLESS	0x120C
+#define HID_DEVICE_ID_ALPS_1222		0x1222
 
 
 #define USB_VENDOR_ID_AMI		0x046b
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 1565a307170a..42bb635895cf 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1780,6 +1780,10 @@ static const struct hid_device_id mt_devices[] = {
 		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
 			USB_VENDOR_ID_ALPS_JP,
 			HID_DEVICE_ID_ALPS_U1_DUAL_3BTN_PTP) },
+	{ .driver_data = MT_CLS_WIN_8_DUAL,
+		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
+			USB_VENDOR_ID_ALPS_JP,
+			HID_DEVICE_ID_ALPS_1222) },
 
 	/* Lenovo X1 TAB Gen 2 */
 	{ .driver_data = MT_CLS_WIN_8_DUAL,
-- 
2.20.1
