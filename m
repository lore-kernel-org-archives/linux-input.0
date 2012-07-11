From: Yuri Khan <yurivkhan@gmail.com>
Subject: [PATCH 1/1] Input: xpad - Add Andamiro Pump It Up pad
Date: Wed, 11 Jul 2012 23:03:27 +0700
Message-ID: <1342022607-6147-2-git-send-email-yurivkhan@gmail.com>
References: <1342022607-6147-1-git-send-email-yurivkhan@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1342022607-6147-1-git-send-email-yurivkhan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Yuri Khan <yurivkhan@gmail.com>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Yuri Khan <yurivkhan@gmail.com>
---
 drivers/input/joystick/xpad.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 16974ef..a2cdfd6 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -142,6 +142,7 @@ static const struct xpad_device {
 	{ 0x0c12, 0x880a, "Pelican Eclipse PL-2023", 0, XTYPE_XBOX },
 	{ 0x0c12, 0x8810, "Zeroplus Xbox Controller", 0, XTYPE_XBOX },
 	{ 0x0c12, 0x9902, "HAMA VibraX - *FAULTY HARDWARE*", 0, XTYPE_XBOX },
+	{ 0x0d2f, 0x0002, "Andamiro Pump It Up pad", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX },
 	{ 0x0e4c, 0x1097, "Radica Gamester Controller", 0, XTYPE_XBOX },
 	{ 0x0e4c, 0x2390, "Radica Games Jtech Controller", 0, XTYPE_XBOX },
 	{ 0x0e6f, 0x0003, "Logic3 Freebird wireless Controller", 0, XTYPE_XBOX },
-- 
1.7.9.5
