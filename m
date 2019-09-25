From: You-Sheng Yang <vicamo.yang@canonical.com>
Subject: [PATCH 2/2] HID: i2c-hid: add 60ms SET_POWER delay for Goodix touchpad
Date: Wed, 25 Sep 2019 17:43:26 +0800
Message-ID: <20190925094326.41693-3-vicamo.yang@canonical.com>
References: <20190925094326.41693-1-vicamo.yang@canonical.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190925094326.41693-1-vicamo.yang@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Hui Wang <hui.wang@canonical.com>, Julian Sax <jsbc@gmx.de>, HungNien Chen <hn.chen@weidahitech.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Goodix touchpad 27C6:01F0 fails to switch to PTP mode when resumed from
suspend. The traffic after resumed looks like:

  [ 275.312190] i2c_hid i2c-DELL096E:00: i2c_hid_set_power
  [ 275.312191] i2c_hid i2c-DELL096E:00: __i2c_hid_command: cmd=05 00 01 08
  [ 283.926905] i2c_hid i2c-DELL096E:00: i2c_hid_set_power
  [ 283.926910] i2c_hid i2c-DELL096E:00: __i2c_hid_command: cmd=05 00 00 08
  [ 283.927146] i2c_hid i2c-DELL096E:00: i2c_hid_set_or_send_report
  [ 283.927149] i2c_hid i2c-DELL096E:00: __i2c_hid_command: cmd=05 00 37 03 06 00 05 00 07 00 00
  [ 283.927872] i2c_hid i2c-DELL096E:00: i2c_hid_set_or_send_report
  [ 283.927874] i2c_hid i2c-DELL096E:00: __i2c_hid_command: cmd=05 00 33 03 06 00 05 00 03 03 00
  [ 283.929148] i2c_hid i2c-DELL096E:00: i2c_hid_set_or_send_report
  [ 283.929151] i2c_hid i2c-DELL096E:00: __i2c_hid_command: cmd=05 00 35 03 06 00 05 00 05 03 00
  [ 289.262675] i2c_hid i2c-DELL096E:00: input: 0b 00 01 00 00 00 00 00 00 00 00
  [ 289.270314] i2c_hid i2c-DELL096E:00: input: 0b 00 01 00 fe 00 00 00 00 00 00
  [ 289.276806] i2c_hid i2c-DELL096E:00: input: 0b 00 01 00 fd 00 00 00 00 00 00
  ...

The time delay between i2c_hid_set_power and i2c_hid_set_or_send_report
is less than vendor recommended 60ms, so it failed to complete its power
state transition, ignored i2c_hid_set_or_send_report and is still
operating in legacy mouse mode, and therefore it gives unsupported input
reports.

This change updates the quirk for the device to specifies a 60ms
post-setpower-delay-ms.

References: https://bugzilla.kernel.org/show_bug.cgi?id=204991
Signed-off-by: You-Sheng Yang <vicamo.yang@canonical.com>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index a5bc2786dc440..8c01ce33f1c61 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -180,7 +180,7 @@ static const struct i2c_hid_quirks {
 	{ USB_VENDOR_ID_LG, I2C_DEVICE_ID_LG_8001,
 		I2C_HID_QUIRK_NO_RUNTIME_PM },
 	{ I2C_VENDOR_ID_GOODIX, I2C_DEVICE_ID_GOODIX_01F0,
-		I2C_HID_QUIRK_NO_RUNTIME_PM },
+		I2C_HID_QUIRK_NO_RUNTIME_PM, 60 },
 	{ USB_VENDOR_ID_ELAN, HID_ANY_ID,
 		 I2C_HID_QUIRK_BOGUS_IRQ },
 	{ 0, 0 }
-- 
2.23.0
