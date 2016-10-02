From: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v7 3/5] input: touchscreen: mxs-lradc: Add support for touchscreen
Date: Sun,  2 Oct 2016 16:15:47 +0200
Message-ID: <8cf09a8c576ac22345bf31e0b3ae03b1d6efecdc.1475416202.git.ksenija.stanojevic@gmail.com>
References: <cover.1475416202.git.ksenija.stanojevic@gmail.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1475416202.git.ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <cover.1475416202.git.ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
References: <cover.1475416202.git.ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-95f8Dae0BrPYtjvyW6yDsg@public.gmane.org, stefan.wahren-eS4NqCHxEME@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Add 4-wire/5-wire touchscreen controller.

Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Changes in v7:
 - remove touch_ret variable in probe and use ret instead
 - make error check on of_property_read_u32 in probe

Changes in v6:
 - update copyright

Changes in v5:
 - add field void __iomem *base to struct mxs_lradc_adc
 - change arguments in all functions for accessing I/O memory
   to follow the previous change.
 - use devm_ioremap for mapping I/O memory

Changes in v4:
 - update copyright
 - use platform_get_irq_byname
 - use irq_of_parse_and_map

Changes in v3:
 - make buffer large enough for timestamps
 - remove unnecessary blank lines

Changes in v2:
 - improve commit message
 - do not change spacing in Kconfig
 - impove formating
 - remove wrapper show_scale_avail
 - use correct syntax for comments
 - use devm_iio_trigger_alloc
 - do not allocate buffer dynamically
 - use iio_device_claim_*_mode helpers
 - add spinlock in struct mxs_lradc_ts to enable locking in interrupt handler
 - only grab irqs that are relevant to adc
 - remove blank line at the end of the file
 - change licence to GPL
 - add copyright

 drivers/input/touchscreen/Kconfig  | 10 ++++++++++
 drivers/input/touchscreen/Makefile |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 2fb1f43..49ea962 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -305,6 +305,16 @@ config TOUCHSCREEN_EGALAX_SERIAL
 	  To compile this driver as a module, choose M here: the
 	  module will be called egalax_ts_serial.
 
+config TOUCHSCREEN_MXS_LRADC
+	tristate "Freescale i.MX23/i.MX28 LRADC touchscreen"
+	depends on MFD_MXS_LRADC
+	help
+	  Say Y here if you have a touchscreen connected to the low-resolution
+	  analog-to-digital converter (LRADC) on an i.MX23 or i.MX28 processor.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called mxs-lradc-ts.
+
 config TOUCHSCREEN_FT6236
 	tristate "FT6236 I2C touchscreen"
 	depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index b4373d6..9f2b76b 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_TOUCHSCREEN_MIGOR)		+= migor_ts.o
 obj-$(CONFIG_TOUCHSCREEN_MMS114)	+= mms114.o
 obj-$(CONFIG_TOUCHSCREEN_MTOUCH)	+= mtouch.o
 obj-$(CONFIG_TOUCHSCREEN_MK712)		+= mk712.o
+obj-$(CONFIG_TOUCHSCREEN_MXS_LRADC)     += mxs-lradc-ts.o
 obj-$(CONFIG_TOUCHSCREEN_HP600)		+= hp680_ts_input.o
 obj-$(CONFIG_TOUCHSCREEN_HP7XX)		+= jornada720_ts.o
 obj-$(CONFIG_TOUCHSCREEN_IPAQ_MICRO)	+= ipaq-micro-ts.o
-- 
1.9.1
