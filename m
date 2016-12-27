From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: synaptics-rmi4 - use Kconfig "if" to express
 dependency
Date: Tue, 27 Dec 2016 11:47:04 -0800
Message-ID: <20161227194704.GA19182@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34624 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933248AbcL0TrI (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 27 Dec 2016 14:47:08 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Nick Dyer <nick@shmanahar.org>, Guenter Roeck <linux@roeck-us.net>, Lyude Paul <thatslyude@gmail.com>, linux-kernel@vger.kernel.org

There is no need to repeat "depends on RMI4_CORE" on every bit of RMI4
support, we can guard all of them at once with "if RMI4_CORE".

Also use tabs for F03 indentation.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

This depends on RMI4 F03 build fix I sent a few minutes ago.

 drivers/input/rmi4/Kconfig | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
index 8993983..78a78b9 100644
--- a/drivers/input/rmi4/Kconfig
+++ b/drivers/input/rmi4/Kconfig
@@ -9,9 +9,11 @@ config RMI4_CORE
 
 	  If unsure, say Y.
 
+if RMI4_CORE
+
 config RMI4_I2C
 	tristate "RMI4 I2C Support"
-	depends on RMI4_CORE && I2C
+	depends on I2C
 	help
 	  Say Y here if you want to support RMI4 devices connected to an I2C
 	  bus.
@@ -20,7 +22,7 @@ config RMI4_I2C
 
 config RMI4_SPI
 	tristate "RMI4 SPI Support"
-	depends on RMI4_CORE && SPI
+	depends on SPI
 	help
 	  Say Y here if you want to support RMI4 devices connected to a SPI
 	  bus.
@@ -29,7 +31,7 @@ config RMI4_SPI
 
 config RMI4_SMB
 	tristate "RMI4 SMB Support"
-	depends on RMI4_CORE && I2C
+	depends on I2C
 	help
 	  Say Y here if you want to support RMI4 devices connected to an SMB
 	  bus.
@@ -40,23 +42,20 @@ config RMI4_SMB
 	  called rmi_smbus.
 
 config RMI4_F03
-        bool "RMI4 Function 03 (PS2 Guest)"
-	depends on RMI4_CORE
+	bool "RMI4 Function 03 (PS2 Guest)"
 	depends on SERIO=y || RMI4_CORE=SERIO
-        help
-          Say Y here if you want to add support for RMI4 function 03.
+	help
+	  Say Y here if you want to add support for RMI4 function 03.
 
-          Function 03 provides PS2 guest support for RMI4 devices. This
-          includes support for TrackPoints on TouchPads.
+	  Function 03 provides PS2 guest support for RMI4 devices. This
+	  includes support for TrackPoints on TouchPads.
 
 config RMI4_2D_SENSOR
 	bool
-	depends on RMI4_CORE
 
 config RMI4_F11
 	bool "RMI4 Function 11 (2D pointing)"
 	select RMI4_2D_SENSOR
-	depends on RMI4_CORE
 	help
 	  Say Y here if you want to add support for RMI4 function 11.
 
@@ -67,7 +66,6 @@ config RMI4_F11
 config RMI4_F12
 	bool "RMI4 Function 12 (2D pointing)"
 	select RMI4_2D_SENSOR
-	depends on RMI4_CORE
 	help
 	  Say Y here if you want to add support for RMI4 function 12.
 
@@ -77,7 +75,6 @@ config RMI4_F12
 
 config RMI4_F30
 	bool "RMI4 Function 30 (GPIO LED)"
-	depends on RMI4_CORE
 	help
 	  Say Y here if you want to add support for RMI4 function 30.
 
@@ -86,7 +83,6 @@ config RMI4_F30
 
 config RMI4_F34
 	bool "RMI4 Function 34 (Device reflash)"
-	depends on RMI4_CORE
 	select FW_LOADER
 	help
 	  Say Y here if you want to add support for RMI4 function 34.
@@ -97,7 +93,6 @@ config RMI4_F34
 
 config RMI4_F54
 	bool "RMI4 Function 54 (Analog diagnostics)"
-	depends on RMI4_CORE
 	depends on VIDEO_V4L2=y || (RMI4_CORE=m && VIDEO_V4L2=m)
 	select VIDEOBUF2_VMALLOC
 	select RMI4_F55
@@ -109,9 +104,10 @@ config RMI4_F54
 
 config RMI4_F55
 	bool "RMI4 Function 55 (Sensor tuning)"
-	depends on RMI4_CORE
 	help
 	  Say Y here if you want to add support for RMI4 function 55
 
 	  Function 55 provides access to the RMI4 touch sensor tuning
 	  mechanism.
+
+endif # RMI_CORE
-- 
2.8.0.rc3.226.g39d4020


-- 
Dmitry
