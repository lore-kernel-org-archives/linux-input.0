From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH] drivers: input: keyboard: Kconfig: formatting cleanup
Date: Wed,  6 Mar 2019 16:13:02 +0100
Message-ID: <1551885182-18563-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so just
take damp cloth and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/input/keyboard/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index a878351..ef39f5c 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -138,14 +138,14 @@ config KEYBOARD_ATKBD_RDI_KEYCODES
 	  left-hand column.
 
 config KEYBOARD_QT1070
-       tristate "Atmel AT42QT1070 Touch Sensor Chip"
-       depends on I2C
-       help
-         Say Y here if you want to use Atmel AT42QT1070 QTouch
-         Sensor chip as input device.
-
-         To compile this driver as a module, choose M here:
-         the module will be called qt1070
+	tristate "Atmel AT42QT1070 Touch Sensor Chip"
+	depends on I2C
+	help
+	  Say Y here if you want to use Atmel AT42QT1070 QTouch
+	  Sensor chip as input device.
+
+	  To compile this driver as a module, choose M here:
+	  the module will be called qt1070
 
 config KEYBOARD_QT2160
 	tristate "Atmel AT42QT2160 Touch Sensor Chip"
-- 
1.9.1
