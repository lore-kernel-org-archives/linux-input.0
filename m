From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 15/77] HID: i2c-hid: Disable runtime PM on Goodix touchpad
Date: Thu, 14 Feb 2019 21:07:53 -0500
Message-ID: <20190215020855.176727-15-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 77ae0d8e401f083ca69c202502da4fc0e38cb1b7 ]

A Goodix touchpad doesn't work. Touching the touchpad can trigger IRQ
but there's no input event from HID subsystem.

Turns out it reports some invalid data:
[   22.136630] i2c_hid i2c-DELL091F:00: input: 0b 00 01 00 00 00 00 00 00 00 00

After some trial and error, it's another device that doesn't work well
with ON/SLEEP commands. Disable runtime PM to fix the issue.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h              | 3 +++
 drivers/hid/i2c-hid/i2c-hid-core.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 27519eb8ee63..81bc2f6b93a3 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -459,6 +459,9 @@
 #define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_010A 0x010a
 #define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_E100 0xe100
 
+#define I2C_VENDOR_ID_GOODIX		0x27c6
+#define I2C_DEVICE_ID_GOODIX_01F0	0x01f0
+
 #define USB_VENDOR_ID_GOODTOUCH		0x1aad
 #define USB_DEVICE_ID_GOODTOUCH_000f	0x000f
 
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 8555ce7e737b..c5edfa966343 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -179,6 +179,8 @@ static const struct i2c_hid_quirks {
 		I2C_HID_QUIRK_DELAY_AFTER_SLEEP },
 	{ USB_VENDOR_ID_LG, I2C_DEVICE_ID_LG_8001,
 		I2C_HID_QUIRK_NO_RUNTIME_PM },
+	{ I2C_VENDOR_ID_GOODIX, I2C_DEVICE_ID_GOODIX_01F0,
+		I2C_HID_QUIRK_NO_RUNTIME_PM },
 	{ 0, 0 }
 };
 
-- 
2.19.1
