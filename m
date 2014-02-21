From: Marcin Lulek <admin@webreactor.eu>
Subject: [PATCH 1/1] Add device id for Thrustmaster GPX Gamepad for joystick/xpad.c driver
Date: Fri, 21 Feb 2014 23:51:21 +0100
Message-ID: <1393023081-31679-1-git-send-email-info@webreactor.eu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcin Lulek <info@webreactor.eu>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thomaz de Oliveira dos Reis <thor27@gmail.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Signed-off-by: Marcin Lulek <info@webreactor.eu>
---
 drivers/input/joystick/xpad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 603fe0d..b94668f 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -124,6 +124,7 @@ static const struct xpad_device {
 	{ 0x045e, 0x0291, "Xbox 360 Wireless Receiver (XBOX)", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
 	{ 0x045e, 0x0719, "Xbox 360 Wireless Receiver", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
 	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
+	{ 0x24c6, 0x5b02, "Thrustmaster, Inc. GPX Controller", 0, XTYPE_XBOX360 },
 	{ 0x046d, 0xc21d, "Logitech Gamepad F310", 0, XTYPE_XBOX360 },
 	{ 0x046d, 0xc21f, "Logitech Gamepad F710", 0, XTYPE_XBOX360 },
 	{ 0x046d, 0xc242, "Logitech Chillstream Controller", 0, XTYPE_XBOX360 },
-- 
1.8.3.2
