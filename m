From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] Input: xpad - Add usb-ids for the XBOX360 controller built into the GPD win 2
Date: Thu,  7 Jun 2018 12:15:17 +0200
Message-ID: <20180607101517.11630-1-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The GPD win 2 x86 portable game computer comes with a builtin XBOX360
controller with a vid:pid of 0079:18d4. Add support for this controller.

BugLink: https://www.reddit.com/r/gpdwin/comments/8l5vn8/gpd_win_2_gamepad_in_linux/
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/joystick/xpad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 06e9650b3b30..c4f119a6e9d7 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -123,6 +123,7 @@ static const struct xpad_device {
 	u8 mapping;
 	u8 xtype;
 } xpad_device[] = {
+	{ 0x0079, 0x18d4, "GPD WIN 2", 0, XTYPE_XBOX360 },
 	{ 0x044f, 0x0f00, "Thrustmaster Wheel", 0, XTYPE_XBOX },
 	{ 0x044f, 0x0f03, "Thrustmaster Wheel", 0, XTYPE_XBOX },
 	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
-- 
2.17.1
