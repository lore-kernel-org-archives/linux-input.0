From: Cameron Gutman <aicommander@gmail.com>
Subject: [PATCH 2/2] Input: xpad - add support for Razer Wildcat gamepad
Date: Sat, 25 Mar 2017 15:31:02 -0700
Message-ID: <20170325223102.21136-3-aicommander@gmail.com>
References: <20170325223102.21136-1-aicommander@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170325223102.21136-1-aicommander@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, rojtberg@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Cameron Gutman <aicommander@gmail.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Cc: stable@vger.kernel.org
Signed-off-by: Cameron Gutman <aicommander@gmail.com>
---
 drivers/input/joystick/xpad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index efb798a..5c3d249 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -202,6 +202,7 @@ static const struct xpad_device {
 	{ 0x1430, 0x8888, "TX6500+ Dance Pad (first generation)", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX },
 	{ 0x146b, 0x0601, "BigBen Interactive XBOX 360 Controller", 0, XTYPE_XBOX360 },
 	{ 0x1532, 0x0037, "Razer Sabertooth", 0, XTYPE_XBOX360 },
+	{ 0x1532, 0x0a03, "Razer Wildcat", 0, XTYPE_XBOXONE },
 	{ 0x15e4, 0x3f00, "Power A Mini Pro Elite", 0, XTYPE_XBOX360 },
 	{ 0x15e4, 0x3f0a, "Xbox Airflo wired controller", 0, XTYPE_XBOX360 },
 	{ 0x15e4, 0x3f10, "Batarang Xbox 360 controller", 0, XTYPE_XBOX360 },
@@ -326,6 +327,7 @@ static struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x1430),		/* RedOctane X-Box 360 controllers */
 	XPAD_XBOX360_VENDOR(0x146b),		/* BigBen Interactive Controllers */
 	XPAD_XBOX360_VENDOR(0x1532),		/* Razer Sabertooth */
+	XPAD_XBOXONE_VENDOR(0x1532),		/* Razer Wildcat */
 	XPAD_XBOX360_VENDOR(0x15e4),		/* Numark X-Box 360 controllers */
 	XPAD_XBOX360_VENDOR(0x162e),		/* Joytech X-Box 360 controllers */
 	XPAD_XBOX360_VENDOR(0x1689),		/* Razer Onza */
-- 
2.9.3
