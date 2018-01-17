From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH] input: mouse: make USB drivers depend on USB
Date: Wed, 17 Jan 2018 22:35:35 +0100
Message-ID: <20180117213535.1102-1-marcus.folkesson@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

A driver should not enable an entire subsystem.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/input/mouse/Kconfig | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
index 89ebb8f39fee..38aed9b0bcb8 100644
--- a/drivers/input/mouse/Kconfig
+++ b/drivers/input/mouse/Kconfig
@@ -202,8 +202,7 @@ config MOUSE_SERIAL
 
 config MOUSE_APPLETOUCH
 	tristate "Apple USB Touchpad support"
-	depends on USB_ARCH_HAS_HCD
-	select USB
+	depends on USB
 	help
 	  Say Y here if you want to use an Apple USB Touchpad.
 
@@ -223,8 +222,7 @@ config MOUSE_APPLETOUCH
 
 config MOUSE_BCM5974
 	tristate "Apple USB BCM5974 Multitouch trackpad support"
-	depends on USB_ARCH_HAS_HCD
-	select USB
+	depends on USB
 	help
 	  Say Y here if you have an Apple USB BCM5974 Multitouch
 	  trackpad.
@@ -418,8 +416,7 @@ config MOUSE_SYNAPTICS_I2C
 
 config MOUSE_SYNAPTICS_USB
 	tristate "Synaptics USB device support"
-	depends on USB_ARCH_HAS_HCD
-	select USB
+	depends on USB
 	help
 	  Say Y here if you want to use a Synaptics USB touchpad or pointing
 	  stick.
-- 
2.15.1
