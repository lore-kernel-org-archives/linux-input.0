From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH] Add Cobalt button interface driver support
Date: Wed, 4 Apr 2007 00:01:41 -0400
Message-ID: <200704040001.41494.dtor@insightbb.com>
References: <20070216123608.733f04a3.yoichi_yuasa@tripeaks.co.jp> <d120d5000702160715x6f64853y59abb8a22e7d164c@mail.gmail.com> <20070217012242.6a51f55b.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070217012242.6a51f55b.yoichi_yuasa@tripeaks.co.jp>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Yoichi,

Could you please try the patch below? It moves platform device creation
code into cobalt arch code to belletr follow driver model.

Thank you!

-- 
Dmitry

Input: cobalt buttons - separate device and driver registration

Create platform device for cobalt buttons as part of arch setup.
This makes the driver follow current driver model more closely.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 arch/mips/cobalt/Makefile        |    2 -
 arch/mips/cobalt/buttons.c       |   54 +++++++++++++++++++++++++++++++++++++++
 drivers/input/misc/cobalt_btns.c |   24 -----------------
 3 files changed, 56 insertions(+), 24 deletions(-)

Index: work/arch/mips/cobalt/Makefile
===================================================================
--- work.orig/arch/mips/cobalt/Makefile
+++ work/arch/mips/cobalt/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the Cobalt micro systems family specific parts of the kernel
 #
 
-obj-y	 := irq.o reset.o setup.o
+obj-y	 := irq.o reset.o setup.o buttons.o
 
 obj-$(CONFIG_EARLY_PRINTK)	+= console.o
 obj-$(CONFIG_MTD_PHYSMAP)	+= mtd.o
Index: work/arch/mips/cobalt/buttons.c
===================================================================
--- /dev/null
+++ work/arch/mips/cobalt/buttons.c
@@ -0,0 +1,54 @@
+/*
+ *  Cobalt buttons platform device.
+ *
+ *  Copyright (C) 2007  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/platform_device.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+
+static struct resource cobalt_buttons_resource __initdata = {
+	.start	= 0x1d000000,
+	.end	= 0x1d000003,
+	.flags	= IORESOURCE_MEM,
+};
+
+static __init int cobalt_add_buttons(void)
+{
+	struct platform_device *pd;
+	int error;
+
+	pd = platform_device_alloc("Cobalt buttons", -1);
+	if (!pd)
+		return -ENOMEM;
+
+	error = platform_device_add_resources(pd, &cobalt_buttons_resource, 1);
+	if (error)
+		goto err_free_device;
+
+	error = platform_device_add(pd);
+	if (error)
+		goto err_free_device;
+
+	return 0;
+
+ err_free_device:
+	platform_device_put(pd);
+	return error;
+}
+device_initcall(cobalt_add_buttons);
Index: work/drivers/input/misc/cobalt_btns.c
===================================================================
--- work.orig/drivers/input/misc/cobalt_btns.c
+++ work/drivers/input/misc/cobalt_btns.c
@@ -50,14 +50,6 @@ static struct buttons_map buttons_map[] 
 	{ 0x80000000, KEY_SELECT, },
 };
 
-static struct resource cobalt_buttons_resource __initdata = {
-	.start	= 0x1d000000,
-	.end	= 0x1d000003,
-	.flags	= IORESOURCE_MEM,
-};
-
-static struct platform_device *cobalt_buttons_device;
-
 static struct timer_list buttons_timer;
 
 static void handle_buttons(unsigned long data)
@@ -183,26 +175,12 @@ static struct platform_driver cobalt_but
 
 static int __init cobalt_buttons_init(void)
 {
-	int retval;
-
-	cobalt_buttons_device = platform_device_register_simple("Cobalt buttons", -1,
-	                                                        &cobalt_buttons_resource, 1);
-	if (IS_ERR(cobalt_buttons_device)) {
-		retval = PTR_ERR(cobalt_buttons_device);
-		return retval;
-	}
-
-	retval = platform_driver_register(&cobalt_buttons_driver);
-	if (retval < 0)
-		platform_device_unregister(cobalt_buttons_device);
-
-	return retval;
+	return platform_driver_register(&cobalt_buttons_driver);
 }
 
 static void __exit cobalt_buttons_exit(void)
 {
 	platform_driver_unregister(&cobalt_buttons_driver);
-	platform_device_unregister(cobalt_buttons_device);
 }
 
 module_init(cobalt_buttons_init);
