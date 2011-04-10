From: Kenney Phillis <kphillisjr@gmail.com>
Subject: [PATCH] HID: add USB ID for Alienware Dual Compatible Game Pad in
 hid-pl
Date: Sun, 10 Apr 2011 10:57:11 -0500
Message-ID: <1302451031.21823.39.camel@dandel-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59508 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449Ab1DJP5Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Apr 2011 11:57:25 -0400
Received: by gxk21 with SMTP id 21so1906390gxk.19
        for <linux-input@vger.kernel.org>; Sun, 10 Apr 2011 08:57:25 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Add support for 187c:0600 device into hid-pl driver. This device has
the values in separate fields and resembles devices handled by hid-zpff=
=2E

Signed-off-by: Kenney Phillis <kphillisjr@gmail.com>
---
=46orgot to sign the last email.

The tests for the modifications used the fftest tool. The only effects =
not
working are called 'Dampening Condition', 'Constant Force' and
'Spring Condition'.=20

drivers/hid/hid-core.c |    1 +
drivers/hid/hid-ids.h  |    3 +++
drivers/hid/hid-pl.c   |    5 +++++
3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index e968776..d7cb7aa 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1290,6 +1290,7 @@ static const struct hid_device_id
hid_have_special_driver[] =3D {
{ HID_USB_DEVICE(USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_X5_005D) },
{ HID_USB_DEVICE(USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_RP_649) },
{ HID_USB_DEVICE(USB_VENDOR_ID_ACRUX, 0x0802) },
+ { HID_USB_DEVICE(USB_VENDOR_ID_ALIENWARE,
USB_DEVICE_ID_ALIENWARE_GAMEPAD) },
{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE,
USB_DEVICE_ID_APPLE_ATV_IRCONTROL) },
{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL4) }=
,
{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE,
USB_DEVICE_ID_APPLE_MIGHTYMOUSE) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 65ac53d..c0bda19 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -58,6 +58,9 @@
#define USB_VENDOR_ID_ALCOR 0x058f
#define USB_DEVICE_ID_ALCOR_USBRS232 0x9720

+#define USB_VENDOR_ID_ALIENWARE 0x187c
+#define USB_DEVICE_ID_ALIENWARE_GAMEPAD 0x0600
+
#define USB_VENDOR_ID_ALPS 0x0433
#define USB_DEVICE_ID_IBM_GAMEPAD 0x1101

diff --git a/drivers/hid/hid-pl.c b/drivers/hid/hid-pl.c
index 06e5300..46d117d 100644
--- a/drivers/hid/hid-pl.c
+++ b/drivers/hid/hid-pl.c
@@ -14,6 +14,9 @@
  *  0e8f:0003 "GASIA USB Gamepad"
  *   - another version of the K=C3=B6nig gamepad
  *
+ *  187c:0600 "Alienware Dual Compatible Game Pad"
+ *   - USB/PS2 Game Controller with Alienware branding.
+ *
  *  Copyright (c) 2007, 2009 Anssi Hannula <anssi.hannula@gmail.com>
  */

@@ -201,6 +204,8 @@ err:
}

static const struct hid_device_id pl_devices[] =3D {
+ { HID_USB_DEVICE(USB_VENDOR_ID_ALIENWARE,
USB_DEVICE_ID_ALIENWARE_GAMEPAD) },
+ /* Alienware Dual Compatible */
{ HID_USB_DEVICE(USB_VENDOR_ID_GAMERON,
USB_DEVICE_ID_GAMERON_DUAL_PSX_ADAPTOR),
=2Edriver_data =3D 1 }, /* Twin USB Joystick */
{ HID_USB_DEVICE(USB_VENDOR_ID_GAMERON,
USB_DEVICE_ID_GAMERON_DUAL_PCS_ADAPTOR),
--=20
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
