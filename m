From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input: Modify the qt602240 driver to be compatible
 with mXT1386 device - functional changes
Date: Sat, 29 Jan 2011 00:27:38 -0800
Message-ID: <20110129082738.GC26915@core.coreip.homeip.net>
References: <4D3DAE3C.6060806@atmel.com>
 <20110124170756.GB31066@core.coreip.homeip.net>
 <4D3EA7DD.6000601@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63806 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023Ab1A2I1q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 29 Jan 2011 03:27:46 -0500
Received: by iyj18 with SMTP id 18so3301219iyj.19
        for <linux-input@vger.kernel.org>; Sat, 29 Jan 2011 00:27:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D3EA7DD.6000601@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Iiro Valkonen <iiro.valkonen@atmel.com>
Cc: linux-input@vger.kernel.org, jy0922.shim@samsung.com

Hi Iiro,

On Tue, Jan 25, 2011 at 12:37:17PM +0200, Iiro Valkonen wrote:
> On 01/24/2011 07:07 PM, Dmitry Torokhov wrote:
> > 
> > Thank you for the patch. Could I ask you to split the qt602240->mxt
> > renames from the functional changes so latter are easier to review?
> > 
> 
> And here are the minimum functional changes required to get mXT1386 running with this driver.
> 
> How to proceed with changing the name from "qt602240_ts.c/h"? My suggestion is "atmel_mxt_ts.c/h".
> 

So I have the patch below for rename, please let me know if you are OK
with Kconfig wording.

BTW, I need your signoffs for the 2 patches you sent.

Thanks.

-- 
Dmitry


Input: qt602240_ts - rename to atmel_mxt_ts

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Since the driver will be supporting whole range of Atmels mXT touchscreen
controllers we better rename it to atmel_mxt_ts.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 arch/arm/mach-s5pv210/mach-goni.c        |    2 
 drivers/input/touchscreen/Kconfig        |   24 -
 drivers/input/touchscreen/Makefile       |    2 
 drivers/input/touchscreen/atmel_mxt_ts.c | 1406 ++++++++++++++++++++++++++++++
 drivers/input/touchscreen/qt602240_ts.c  | 1406 ------------------------------
 include/linux/i2c/atmel_mxt_ts.h         |   38 +
 include/linux/i2c/qt602240_ts.h          |   38 -
 7 files changed, 1458 insertions(+), 1458 deletions(-)
 create mode 100644 drivers/input/touchscreen/atmel_mxt_ts.c
 delete mode 100644 drivers/input/touchscreen/qt602240_ts.c
 create mode 100644 include/linux/i2c/atmel_mxt_ts.h
 delete mode 100644 include/linux/i2c/qt602240_ts.h


diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index e22d511..fd2747f 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -15,7 +15,7 @@
 #include <linux/fb.h>
 #include <linux/i2c.h>
 #include <linux/i2c-gpio.h>
-#include <linux/i2c/qt602240_ts.h>
+#include <linux/i2c/atmel_mxt_ts.h>
 #include <linux/mfd/max8998.h>
 #include <linux/mfd/wm8994/pdata.h>
 #include <linux/regulator/fixed.h>
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 91278ca..9e3086f 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -86,6 +86,18 @@ config TOUCHSCREEN_AD7879_SPI
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7879-spi.
 
+config TOUCHSCREEN_ATMEL_MXT
+	tristate "Atmel mXT I2C Touchscreen"
+	depends on I2C
+	help
+	  Say Y here if you have Atmel mXT series I2C touchscreen,
+	  such as AT42QT602240/ATMXT224, connected to your system.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called atmel_mxt_ts.
+
 config TOUCHSCREEN_BITSY
 	tristate "Compaq iPAQ H3600 (Bitsy) touchscreen"
 	depends on SA1100_BITSY
@@ -368,18 +380,6 @@ config TOUCHSCREEN_PENMOUNT
 	  To compile this driver as a module, choose M here: the
 	  module will be called penmount.
 
-config TOUCHSCREEN_QT602240
-	tristate "QT602240 I2C Touchscreen"
-	depends on I2C
-	help
-	  Say Y here if you have the AT42QT602240/ATMXT224 I2C touchscreen
-	  connected to your system.
-
-	  If unsure, say N.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called qt602240_ts.
-
 config TOUCHSCREEN_MIGOR
 	tristate "Renesas MIGO-R touchscreen"
 	depends on SH_MIGOR && I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index a6cc617..1a48cb5 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_TOUCHSCREEN_AD7879)	+= ad7879.o
 obj-$(CONFIG_TOUCHSCREEN_AD7879_I2C)	+= ad7879-i2c.o
 obj-$(CONFIG_TOUCHSCREEN_AD7879_SPI)	+= ad7879-spi.o
 obj-$(CONFIG_TOUCHSCREEN_ADS7846)	+= ads7846.o
+obj-$(CONFIG_TOUCHSCREEN_ATMEL_MXT)	+= atmel_mxt_ts.o
 obj-$(CONFIG_TOUCHSCREEN_ATMEL_TSADCC)	+= atmel_tsadcc.o
 obj-$(CONFIG_TOUCHSCREEN_BITSY)		+= h3600_ts_input.o
 obj-$(CONFIG_TOUCHSCREEN_BU21013)       += bu21013_ts.o
@@ -40,7 +41,6 @@ obj-$(CONFIG_TOUCHSCREEN_HTCPEN)	+= htcpen.o
 obj-$(CONFIG_TOUCHSCREEN_USB_COMPOSITE)	+= usbtouchscreen.o
 obj-$(CONFIG_TOUCHSCREEN_PCAP)		+= pcap_ts.o
 obj-$(CONFIG_TOUCHSCREEN_PENMOUNT)	+= penmount.o
-obj-$(CONFIG_TOUCHSCREEN_QT602240)	+= qt602240_ts.o
 obj-$(CONFIG_TOUCHSCREEN_S3C2410)	+= s3c2410_ts.o
 obj-$(CONFIG_TOUCHSCREEN_ST1232)	+= st1232.o
 obj-$(CONFIG_TOUCHSCREEN_STMPE)		+= stmpe-ts.o
diff --git a/drivers/input/touchscreen/qt602240_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
similarity index 99%
rename from drivers/input/touchscreen/qt602240_ts.c
rename to drivers/input/touchscreen/atmel_mxt_ts.c
index 4dcb0e8..4706778 100644
--- a/drivers/input/touchscreen/qt602240_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -16,7 +16,7 @@
 #include <linux/delay.h>
 #include <linux/firmware.h>
 #include <linux/i2c.h>
-#include <linux/i2c/qt602240_ts.h>
+#include <linux/i2c/atmel_mxt_ts.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
diff --git a/include/linux/i2c/qt602240_ts.h b/include/linux/i2c/atmel_mxt_ts.h
similarity index 100%
rename from include/linux/i2c/qt602240_ts.h
rename to include/linux/i2c/atmel_mxt_ts.h
