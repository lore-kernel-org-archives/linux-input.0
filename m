From: Ethan Warth <redyoshi49q@gmail.com>
Subject: [PATCH] HID: add support for 0079:1846 Mayflash/Dragonrise USB
 Gamecube Adapter
Date: Fri, 6 Sep 2019 01:11:08 -0500
Message-ID: <CAAPc1Th4mgE=ntLY=NXn2Jbfgi0OBpZ5R2sYGhWJ_4+syuPA9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jikos@kernel.org, benjamin.tissoires@redhat.com
List-Id: linux-input@vger.kernel.org

>From 32bdfb1d652cc38ab13f8616df58dee726201785 Mon Sep 17 00:00:00 2001
From: Ethan Warth <redyoshi49q@gmail.com>
Date: Wed, 4 Sep 2019 16:07:45 -0500
Subject: [PATCH] HID: add support for 0079:1846 Mayflash/Dragonrise USB Gam=
ecube
 Adapter

Mayflash/Dragonrise seems to have yet another device ID for one of their
Gamecube controller adapters.  Previous to this commit, the adapter
registered only one /dev/input/js* device, and all controller inputs (from
any controller) were mapped to this device.  This patch defines the 1846
USB device ID and enables the HID_QUIRK_MULTI_INPUT quirk for it, which
fixes that (with the patch, four /dev/input/js* devices are created, one
for each of the four controller ports).
---
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-mf.c     | 2 ++
 drivers/hid/hid-quirks.c | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0a00be19f7a0..9cd909985a4c 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -362,6 +362,7 @@
 #define USB_DEVICE_ID_DRAGONRISE_DOLPHINBAR    0x1803
 #define USB_DEVICE_ID_DRAGONRISE_GAMECUBE1    0x1843
 #define USB_DEVICE_ID_DRAGONRISE_GAMECUBE2    0x1844
+#define USB_DEVICE_ID_DRAGONRISE_GAMECUBE3    0x1846

 #define USB_VENDOR_ID_DWAV        0x0eef
 #define USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER    0x0001
diff --git a/drivers/hid/hid-mf.c b/drivers/hid/hid-mf.c
index fc75f30f537c..92d7ecd41a78 100644
--- a/drivers/hid/hid-mf.c
+++ b/drivers/hid/hid-mf.c
@@ -153,6 +153,8 @@ static const struct hid_device_id mf_devices[] =3D {
         .driver_data =3D HID_QUIRK_MULTI_INPUT },
     { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE,
USB_DEVICE_ID_DRAGONRISE_GAMECUBE2),
         .driver_data =3D 0 }, /* No quirk required */
+    { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE,
USB_DEVICE_ID_DRAGONRISE_GAMECUBE3),
+        .driver_data =3D HID_QUIRK_MULTI_INPUT },
     { }
 };
 MODULE_DEVICE_TABLE(hid, mf_devices);
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 166f41f3173b..a11f1abb029e 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -72,6 +72,7 @@ static const struct hid_device_id hid_quirks[] =3D {
     { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE,
USB_DEVICE_ID_REDRAGON_SEYMUR2),
HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
     { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE,
USB_DEVICE_ID_DRAGONRISE_DOLPHINBAR), HID_QUIRK_MULTI_INPUT },
     { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE,
USB_DEVICE_ID_DRAGONRISE_GAMECUBE1), HID_QUIRK_MULTI_INPUT },
+    { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE,
USB_DEVICE_ID_DRAGONRISE_GAMECUBE3), HID_QUIRK_MULTI_INPUT },
     { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE,
USB_DEVICE_ID_DRAGONRISE_PS3), HID_QUIRK_MULTI_INPUT },
     { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE,
USB_DEVICE_ID_DRAGONRISE_WIIU), HID_QUIRK_MULTI_INPUT },
     { HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER), HID_QUIRK_MULTI_INPUT |
HID_QUIRK_NOGET },
@@ -476,6 +477,7 @@ static const struct hid_device_id
hid_have_special_driver[] =3D {
     { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE,
USB_DEVICE_ID_DRAGONRISE_DOLPHINBAR) },
     { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE,
USB_DEVICE_ID_DRAGONRISE_GAMECUBE1) },
     { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE,
USB_DEVICE_ID_DRAGONRISE_GAMECUBE2) },
+    { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE,
USB_DEVICE_ID_DRAGONRISE_GAMECUBE3) },
 #endif
 #if IS_ENABLED(CONFIG_HID_MICROSOFT)
     { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
USB_DEVICE_ID_MS_COMFORT_MOUSE_4500) },
--=20
2.17.1

Some lines added in the patch exceed the recommended line width; this is
so that the added lines can share a consistent format with other lines in
the adjacent code.

Signed-off-by: Ethan Warth <redyoshi49q@gmail.com>



Perfect normality is impossible.  Be unique!
   =E2=80=95redyoshi49q
