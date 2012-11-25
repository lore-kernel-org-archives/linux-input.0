From: =?ISO-8859-1?Q?Ortwin_Gl=FCck?= <odi@odi.ch>
Subject: [PATCH] HID: hid-input: battery quirk for Apple keyboard
Date: Sun, 25 Nov 2012 15:08:34 +0100
Message-ID: <50B22662.4070503@odi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Support battery capacity on another Apple wireless
keyboard.

NB: most likely all other APPLE_ALU_WIRELESS_*
keyboards should be added as well.

Signed-off-by: Ortwin Gl=FCck <odi@odi.ch>
---
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 5301006..b2ae097 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -299,6 +299,9 @@ static enum power_supply_property hidinput_battery_=
props[] =3D {

  static const struct hid_device_id hid_battery_quirks[] =3D {
         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
+                              USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_IS=
O),
+         HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
+       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
                                USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_A=
NSI),
           HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
