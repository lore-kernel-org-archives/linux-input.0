From: flibitijibibo@gmail.com
Subject: [PATCH v3] xpad: Add GPD Win 2 Controller USB IDs
Date: Wed, 30 May 2018 21:14:59 -0400
Message-ID: <20180531011459.2911-1-flibitijibibo@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: stable@vger.kernel.org, hadess@hadess.net, aicommander@gmail.com, Ethan Lee <flibitijibibo@gmail.com>
List-Id: linux-input@vger.kernel.org

From: Ethan Lee <flibitijibibo@gmail.com>

GPD Win 2 Website: http://www.gpd.hk/gpdwin2.asp

Tested on a unit from the first production run sent to Indiegogo backers

Signed-off-by: Ethan Lee <flibitijibibo@gmail.com>
---
 drivers/input/joystick/xpad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 06e9650b3b30..a89b81b35932 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -123,6 +123,7 @@ static const struct xpad_device {
 	u8 mapping;
 	u8 xtype;
 } xpad_device[] = {
+	{ 0x0079, 0x18d4, "GPD Win 2 Controller", 0, XTYPE_XBOX360 },
 	{ 0x044f, 0x0f00, "Thrustmaster Wheel", 0, XTYPE_XBOX },
 	{ 0x044f, 0x0f03, "Thrustmaster Wheel", 0, XTYPE_XBOX },
 	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
@@ -409,6 +410,7 @@ static const signed short xpad_abs_triggers[] = {
 
 static const struct usb_device_id xpad_table[] = {
 	{ USB_INTERFACE_INFO('X', 'B', 0) },	/* X-Box USB-IF not approved class */
+	XPAD_XBOX360_VENDOR(0x0079),		/* GPD Win 2 Controller */
 	XPAD_XBOX360_VENDOR(0x044f),		/* Thrustmaster X-Box 360 controllers */
 	XPAD_XBOX360_VENDOR(0x045e),		/* Microsoft X-Box 360 controllers */
 	XPAD_XBOXONE_VENDOR(0x045e),		/* Microsoft X-Box One controllers */
-- 
2.13.6
