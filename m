From: "Guillermo A. Amaral" <g@maral.me>
Subject: [PATCH 1/2] Input: xpad - Minor coding style errors fixed.
Date: Sat,  1 Dec 2012 23:36:19 -0800
Message-ID: <1354433779-16274-1-git-send-email-g@maral.me>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:61117 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458Ab2LBHgt (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Dec 2012 02:36:49 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so852623dak.19
        for <linux-input@vger.kernel.org>; Sat, 01 Dec 2012 23:36:48 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: gregkh@linuxfoundation.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Guillermo A. Amaral" <g@maral.me>

From: "Guillermo A. Amaral" <g@maral.me>

Fixed a few minor coding style issues in xpad driver.

Signed-off-by: "Guillermo A. Amaral B." <g@maral.me>
---
 drivers/input/joystick/xpad.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 83811e4..3d8f39b 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -235,7 +235,7 @@ static const signed short xpad_abs_triggers[] = {
 	{ XPAD_XBOX360_VENDOR_PROTOCOL(vend,1) }, \
 	{ XPAD_XBOX360_VENDOR_PROTOCOL(vend,129) }
 
-static struct usb_device_id xpad_table [] = {
+static struct usb_device_id xpad_table[] = {
 	{ USB_INTERFACE_INFO('X', 'B', 0) },	/* X-Box USB-IF not approved class */
 	XPAD_XBOX360_VENDOR(0x045e),		/* Microsoft X-Box 360 controllers */
 	XPAD_XBOX360_VENDOR(0x046d),		/* Logitech X-Box 360 style controllers */
@@ -251,7 +251,7 @@ static struct usb_device_id xpad_table [] = {
 	{ }
 };
 
-MODULE_DEVICE_TABLE (usb, xpad_table);
+MODULE_DEVICE_TABLE(usb, xpad_table);
 
 struct usb_xpad {
 	struct input_dev *dev;		/* input device interface */
@@ -783,7 +783,7 @@ static int xpad_open(struct input_dev *dev)
 	struct usb_xpad *xpad = input_get_drvdata(dev);
 
 	/* URB was submitted in probe */
-	if(xpad->xtype == XTYPE_XBOX360W)
+	if (xpad->xtype == XTYPE_XBOX360W)
 		return 0;
 
 	xpad->irq_in->dev = xpad->udev;
-- 
1.7.8.6

