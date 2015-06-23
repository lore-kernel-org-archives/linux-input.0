From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 01/11] Input: synaptics-rmi4 - embed the function modules in rmi_core
Date: Tue, 23 Jun 2015 15:17:20 -0400
Message-ID: <1435087050-11444-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1435087050-11444-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34572 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932596AbbFWTRh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Jun 2015 15:17:37 -0400
In-Reply-To: <1435087050-11444-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, Allie Xiong <axiong@synaptics.com>
Cc: Stephen Chandler Paul <cpaul@redhat.com>, benjamin.tissoires@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

the function modules can not be auto-loaded by udev. So at boot, the
functions are not there and the device is not properly populated.
Force the functions to be embedded in rmi_core so that when the touchpad
is there, the functions are there too.

There is not much use of having the functions separate anyway

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/rmi4/Kconfig      |  5 +----
 drivers/input/rmi4/Makefile     |  2 +-
 drivers/input/rmi4/rmi_bus.c    | 11 ++++++++++-
 drivers/input/rmi4/rmi_driver.h |  8 ++++++++
 drivers/input/rmi4/rmi_f11.c    | 10 +++++++++-
 5 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
index d0c7b6e..5e3890e 100644
--- a/drivers/input/rmi4/Kconfig
+++ b/drivers/input/rmi4/Kconfig
@@ -37,7 +37,7 @@ config RMI4_I2C
 	  This feature is not currently available as a loadable module.
 
 config RMI4_F11
-	tristate "RMI4 Function 11 (2D pointing)"
+	bool "RMI4 Function 11 (2D pointing)"
 	depends on RMI4_CORE
 	help
 	  Say Y here if you want to add support for RMI4 function 11.
@@ -46,9 +46,6 @@ config RMI4_F11
 	  touchpads.  For sensors that support relative pointing, F11 also
 	  provides mouse input.
 
-	  To compile this driver as a module, choose M here: the
-	  module will be called rmi-f11.
-
 config RMI4_F11_PEN
 	bool "RMI4 F11 Pen Support"
 	depends on RMI4_F11
diff --git a/drivers/input/rmi4/Makefile b/drivers/input/rmi4/Makefile
index 5c6bad5..63bc595 100644
--- a/drivers/input/rmi4/Makefile
+++ b/drivers/input/rmi4/Makefile
@@ -2,7 +2,7 @@ obj-$(CONFIG_RMI4_CORE) += rmi_core.o
 rmi_core-y := rmi_bus.o rmi_driver.o rmi_f01.o
 
 # Function drivers
-obj-$(CONFIG_RMI4_F11) += rmi_f11.o
+rmi_core-$(CONFIG_RMI4_F11) += rmi_f11.o
 
 # Transports
 obj-$(CONFIG_RMI4_I2C) += rmi_i2c.o
diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index 6e0454a..ef2078a 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -383,15 +383,24 @@ static int __init rmi_bus_init(void)
 		goto err_unregister_bus;
 	}
 
+	error = rmi_register_f11_handler();
+	if (error) {
+		pr_err("%s: error registering the RMI F11 handler: %d\n",
+			__func__, error);
+		goto err_unregister_f01;
+	}
+
 	error = rmi_register_physical_driver();
 	if (error) {
 		pr_err("%s: error registering the RMI physical driver: %d\n",
 			__func__, error);
-		goto err_unregister_f01;
+		goto err_unregister_f11;
 	}
 
 	return 0;
 
+err_unregister_f11:
+	rmi_unregister_f11_handler();
 err_unregister_f01:
 	rmi_unregister_f01_handler();
 err_unregister_bus:
diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index 34f7a7d..dda564f 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -113,4 +113,12 @@ void rmi_unregister_physical_driver(void);
 int rmi_register_f01_handler(void);
 void rmi_unregister_f01_handler(void);
 
+#ifdef CONFIG_RMI4_F11
+int rmi_register_f11_handler(void);
+void rmi_unregister_f11_handler(void);
+#else
+static inline int rmi_register_f11_handler(void) { return 0; }
+static inline void rmi_unregister_f11_handler(void) {}
+#endif
+
 #endif
diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index 7af4f68..4bdf4a5 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -1537,7 +1537,15 @@ static struct rmi_function_handler rmi_f11_handler = {
 	.attention	= rmi_f11_attention,
 };
 
-module_rmi_driver(rmi_f11_handler);
+int __init rmi_register_f11_handler(void)
+{
+	return rmi_register_function_handler(&rmi_f11_handler);
+}
+
+void rmi_unregister_f11_handler(void)
+{
+	rmi_unregister_function_handler(&rmi_f11_handler);
+}
 
 MODULE_AUTHOR("Christopher Heiny <cheiny@synaptics.com");
 MODULE_AUTHOR("Andrew Duggan <aduggan@synaptics.com");
-- 
2.4.3

