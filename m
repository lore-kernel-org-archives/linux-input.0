From: Kenney Phillis <kphillisjr@gmail.com>
Subject: [PATCH] HID: add USB ID for Jess Tech USB 4-Axis 12-Button Gamepad
 in hid-pl
Date: Sun, 10 Apr 2011 10:57:16 -0500
Message-ID: <1302451036.21823.40.camel@dandel-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59508 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754470Ab1DJP52 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Apr 2011 11:57:28 -0400
Received: by mail-gx0-f174.google.com with SMTP id 21so1906390gxk.19
        for <linux-input@vger.kernel.org>; Sun, 10 Apr 2011 08:57:28 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Add support for 0f30:0107 device into hid-pl driver. This device has
the values in separate fields and resembles devices handled by hid-zpff.

Signed-off-by: Kenney Phillis <kphillisjr@gmail.com>
---
Forgot to sign the last email.

The tests for the modifications used the fftest tool. The only effects not
working are called 'Dampening Condition', 'Constant Force' and
'Spring Condition'. 

drivers/hid/hid-core.c |    1 +
drivers/hid/hid-ids.h  |    3 +++
drivers/hid/hid-pl.c   |    5 +++++
3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index d7cb7aa..8e4dcd3 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1754,6 +1754,7 @@ static const struct hid_device_id
hid_ignore_list[] = {
{ HID_USB_DEVICE(USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_1007) },
{ HID_USB_DEVICE(USB_VENDOR_ID_IMATION, USB_DEVICE_ID_DISC_STAKKA) },
{ HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_JESS_YUREX) },
+ { HID_USB_DEVICE(USB_VENDOR_ID_JESSTECH,
USB_DEVICE_ID_JESSTECH_GAMEPAD) },
{ HID_USB_DEVICE(USB_VENDOR_ID_KBGEAR,
USB_DEVICE_ID_KBGEAR_JAMSTUDIO) },
{ HID_USB_DEVICE(USB_VENDOR_ID_KWORLD,
USB_DEVICE_ID_KWORLD_RADIO_FM700) },
{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_GPEN_560) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index c0bda19..1ce39a0 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -345,6 +345,9 @@
#define USB_VENDOR_ID_JESS 0x0c45
#define USB_DEVICE_ID_JESS_YUREX 0x1010

+#define USB_VENDOR_ID_JESSTECH 0x0f30
+#define USB_DEVICE_ID_JESSTECH_GAMEPAD 0x0107
+
#define USB_VENDOR_ID_KBGEAR 0x084e
#define USB_DEVICE_ID_KBGEAR_JAMSTUDIO 0x1001

diff --git a/drivers/hid/hid-pl.c b/drivers/hid/hid-pl.c
index 46d117d..922ce47 100644
--- a/drivers/hid/hid-pl.c
+++ b/drivers/hid/hid-pl.c
@@ -17,6 +17,9 @@
  *  187c:0600 "Alienware Dual Compatible Game Pad"
  *   - USB/PS2 Game Controller with Alienware branding.
  *
+ *  0f30:0107 "Jess Tech USB 4-Axis 12-Button Gamepad"
+ *   - tested with the Game Elements Cobra Recoil: GGE908
+ *
  *  Copyright (c) 2007, 2009 Anssi Hannula <anssi.hannula@gmail.com>
  */

@@ -211,6 +214,8 @@ static const struct hid_device_id pl_devices[] = {
{ HID_USB_DEVICE(USB_VENDOR_ID_GAMERON,
USB_DEVICE_ID_GAMERON_DUAL_PCS_ADAPTOR),
.driver_data = 1 }, /* Twin USB Joystick */
{ HID_USB_DEVICE(USB_VENDOR_ID_GREENASIA, 0x0003), },
+ { HID_USB_DEVICE(USB_VENDOR_ID_JESSTECH,
USB_DEVICE_ID_JESSTECH_GAMEPAD) },
+ /* Jess tech USB 4-Axis 12-Button Gamepad */
{ }
};
MODULE_DEVICE_TABLE(hid, pl_devices);
-- 
1.7.1




