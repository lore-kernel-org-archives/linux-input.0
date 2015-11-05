From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 14/26] Input: synaptics-rmi4: Clean up Makefile
Date: Thu, 5 Nov 2015 15:40:43 -0800
Message-ID: <1446766843-30852-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>
List-Id: linux-input@vger.kernel.org

The Makefile contained commands for a different build environment. These
should be removed and are not needed in the upstream kernel.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/input/rmi4/Makefile | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/input/rmi4/Makefile b/drivers/input/rmi4/Makefile
index 63bc595..37b6789 100644
--- a/drivers/input/rmi4/Makefile
+++ b/drivers/input/rmi4/Makefile
@@ -8,19 +8,3 @@ rmi_core-$(CONFIG_RMI4_F11) += rmi_f11.o
 obj-$(CONFIG_RMI4_I2C) += rmi_i2c.o
 
 ccflags-$(CONFIG_RMI4_DEBUG) += -DDEBUG
-
-ifeq ($(KERNELRELEASE),)
-
-# KERNELDIR ?= /home/<AndroidKernelDirectory>
-PWD := $(shell pwd)
-
-.PHONY: build clean
-
-build:
-	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules
-
-clean:
-	rm -rf *.o *~ core .depend .*.cmd *.ko *.mod.c
-
-endif
-
-- 
2.1.4
