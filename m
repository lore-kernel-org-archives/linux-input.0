From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH] input: joystick: make USB drivers depend on USB
Date: Wed, 17 Jan 2018 22:30:10 +0100
Message-ID: <20180117213010.810-1-marcus.folkesson@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Marcus Folkesson <marcus.folkesson@gmail.com>, Tomohiro Yoshidomi <sylph23k@gmail.com>, David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

A driver should not enable an entire subsystem.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/input/joystick/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
index 332c0cc1b2ab..4a199cff8c68 100644
--- a/drivers/input/joystick/Kconfig
+++ b/drivers/input/joystick/Kconfig
@@ -279,8 +279,7 @@ config JOYSTICK_JOYDUMP
 
 config JOYSTICK_XPAD
 	tristate "X-Box gamepad support"
-	depends on USB_ARCH_HAS_HCD
-	select USB
+	depends on USB
 	help
 	  Say Y here if you want to use the X-Box pad with your computer.
 	  Make sure to say Y to "Joystick support" (CONFIG_INPUT_JOYDEV)
-- 
2.15.1
