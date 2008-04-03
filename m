From: Anssi Hannula <dmitry.torokhov@gmail.com>
Subject: [PATCH 12/37] Input: xpad - fix dpad handling of unknown devices
Date: Thu, 3 Apr 2008 16:18:10 -0400
Message-ID: <a0979923d7c34c9c60d0ee8a533f9502dcfbd42b.1208783694.git.dmitry.torokhov@gmail.com>
References: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:8681 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760144AbYDUNTY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2008 09:19:24 -0400
Received: by wa-out-1112.google.com with SMTP id m16so3106317waf.23
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2008 06:19:24 -0700 (PDT)
In-Reply-To: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jkosina@suse.cz, akpm@linux-foundation.org

For devices not specifically listed in xpad.c, xpad->dpad_mapping
is initially set to MAP_DPAD_UNKNOWN. In xpad_probe() it gets changed
to either MAP_DPAD_TO_BUTTONS or MAP_DPAD_TO_AXES, depending on the
module parameter dpad_to_buttons.

However, MAP_DPAD_UNKNOWN is defined as -1, while the field is u8.
This results in actual value of 255, causing the MAP_DPAD_UNKNOWN
check in xpad_probe() to fail.
Fix that by defining MAP_DPAD_UNKNOWN as 2 instead.

Also, setting module parameter dpad_to_buttons to 1 should obviously
map dpad to buttons, while the default behaviour (0) should be to map
dpad to axes. However, dpad_to_buttons is directly assigned to
xpad->dpad_mapping, and as MAP_DPAD_TO_BUTTONS is 0, the actual
behaviour is reversed.
Fix that by negating dpad_to_buttons in assignment.

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/joystick/xpad.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 8804ad3..6288c4f 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -87,7 +87,7 @@
    but we map them to axes when possible to simplify things */
 #define MAP_DPAD_TO_BUTTONS    0
 #define MAP_DPAD_TO_AXES       1
-#define MAP_DPAD_UNKNOWN       -1
+#define MAP_DPAD_UNKNOWN       2
 
 #define XTYPE_XBOX        0
 #define XTYPE_XBOX360     1
@@ -653,7 +653,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	xpad->dpad_mapping = xpad_device[i].dpad_mapping;
 	xpad->xtype = xpad_device[i].xtype;
 	if (xpad->dpad_mapping == MAP_DPAD_UNKNOWN)
-		xpad->dpad_mapping = dpad_to_buttons;
+		xpad->dpad_mapping = !dpad_to_buttons;
 	if (xpad->xtype == XTYPE_UNKNOWN)
 		xpad->xtype = (intf->cur_altsetting->desc.bInterfaceClass == USB_CLASS_VENDOR_SPEC);
 	xpad->dev = input_dev;
-- 
1.5.5.rc2.6.gf58d


