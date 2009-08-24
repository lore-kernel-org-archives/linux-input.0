From: "Ds, Sreedhara" <sreedhara.ds@intel.com>
Subject: 0001-Resitive-touch-screen-driver-for-Intel-Moorestown-pl.patch
Date: Mon, 24 Aug 2009 12:36:55 +0530
Message-ID: <0AE3E14D83C76F4994657326177D1FF963010302@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:29945 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569AbZHXHHr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Aug 2009 03:07:47 -0400
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>



Hello,

Attached is the patch that adds support for the Resistive touchscreen
on Intel's Moorestown platform. This has a dependency on the  Langwell
IPC driver that was submitted to the kernel mailing list but is still not
in the mainstream. The patch can be found at
http://lkml.org/lkml/2009/7/20/396. Also the driver depends on Moorestown SPI driver

Thanks,
Sreedhar


>From 1df86620bf0c1eebc5981ff4617c2cfc5bb867c8 Mon Sep 17 00:00:00 2001
From: Sreedhara DS <sreedhara.ds@intel.com>
Date: Tue, 18 Aug 2009 16:08:29 +0530
Subject: [PATCH] Resitive touch screen driver for Intel Moorestown platform.
 Driver tested with NEC, MAXIM or FreeScale PMICs using
 moblin "mrstouch" Xorg touch screen driver

        modified:   Kconfig
        modified:   Makefile
        new file:   mrstouch.c

Signed-off-by: Sreedhara DS <sreedhara.ds@intel.com>
---
 drivers/input/touchscreen/Kconfig    |    8 +
 drivers/input/touchscreen/Makefile   |    1 +
 drivers/input/touchscreen/mrstouch.c |  942 ++++++++++++++++++++++++++++++++++
 3 files changed, 951 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/touchscreen/mrstouch.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 72e2712..aa7db34 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -498,4 +498,12 @@ config TOUCHSCREEN_W90X900
          To compile this driver as a module, choose M here: the
          module will be called w90p910_ts.

+config TOUCHSCREEN_MRSTOUCH
+       tristate "Intel Moorstown Resistive touchscreen"
+       depends on LANGWELL_IPC && SPI_MRST
+       default y
+       help
+         Say Y here if you have a Intel Moorstown based Touchscreen
+         If unsure, say N.
+
 endif
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 3e1c5e0..9b67c17 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -40,3 +40,4 @@ obj-$(CONFIG_TOUCHSCREEN_WM97XX_ATMEL)        += atmel-wm97xx.o
 obj-$(CONFIG_TOUCHSCREEN_WM97XX_MAINSTONE)     += mainstone-wm97xx.o
 obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE)      += zylonite-wm97xx.o
 obj-$(CONFIG_TOUCHSCREEN_W90X900)      += w90p910_ts.o
+obj-$(CONFIG_TOUCHSCREEN_MRSTOUCH)    += mrstouch.o
diff --git a/drivers/input/touchscreen/mrstouch.c b/drivers/input/touchscreen/mrstouch.c
new file mode 100644
index 0000000..5cd91f8
--- /dev/null
+++ b/drivers/input/touchscreen/mrstouch.c
@@ -0,0 +1,942 @@
+/*
+ * mrstouch.c - Intel Moorestown Resistive Touch Screen Driver
+ *
+ * Copyright (C) 2008 Intel Corp
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.        See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; ifnot, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * Questions/Comments/Bug fixes to Sreedhara (sreedhara.ds@intel.com)
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/err.h>
+#include <linux/param.h>
+#include <linux/spi/spi.h>
+#include <linux/irq.h>
+#include <linux/delay.h>
+#include <asm/mrst_ipcdefs.h>
+
+MODULE_AUTHOR("Sreedhara Murthy. D.S, sreedhara.ds@intel.com");
+MODULE_DESCRIPTION("Intel Moorestown Resistive Touch Screen Driver");
+MODULE_LICENSE("GPL");
+
+#if defined(MRSTOUCH_DEBUG)
+#define mrstouch_debug(fmt, args...)\
+       do { \
+               printk(KERN_DEBUG "\n[MRSTOUCH(%d)] - ", __LINE__); \
+               printk(KERN_DEBUG fmt, ##args); \
+       } while (0);
+#else
+#define mrstouch_debug(fmt, args...)
+#endif
+
+#define mrstouch_error(fmt, args...)\
+       do { \
+               printk(KERN_ERR "\n[MRSTOUCH(%d)] - ", __LINE__); \
+               printk(KERN_ERR fmt, ##args); \
+       } while (0);
+
+static void mrstouch_pendet(struct work_struct *work);
+static DECLARE_DELAYED_WORK(mrstouch_queue, mrstouch_pendet);
+
+/* PMIC Interrupt registers */
+#define PMIC_REG_ID1   0x00 /*PMIC ID1 register */
+
+/* PMIC Interrupt registers */
+#define PMIC_REG_INT   0x04 /*PMIC interrupt register */
+#define PMIC_REG_MINT  0x05 /*PMIC interrupt mask register */
+
+/* ADC Interrupt registers */
+#define PMIC_REG_ADCINT   0x5F /*ADC interrupt register */
+#define PMIC_REG_MADCINT  0x60 /*ADC interrupt mask register */
+
+/* ADC Control registers */
+#define PMIC_REG_ADCCNTL1    0x61 /*ADC control register */
+
+/* ADC Channel Selection registers */
+#define PMICADDR0     0xA4
+#define END_OF_CHANNEL 0x1F
+
+/* ADC Result register */
+#define PMIC_REG_ADCSNS0H   0x64
+
+/* ADC channels for touch screen */
+#define MRST_TS_CHAN10   0xA /* Touch screen X+ connection */
+#define MRST_TS_CHAN11   0xB /* Touch screen X- connection */
+#define MRST_TS_CHAN12   0xC /* Touch screen Y+ connection */
+#define MRST_TS_CHAN13   0xD /* Touch screen Y- connection */
+
+/* Touch screen coordinate constants */
+#define TOUCH_PRESSURE         5
+#define TOUCH_PRESSURE_FS      100
+
+#define XMOVE_LIMIT    5
+#define YMOVE_LIMIT    5
+#define XYMOVE_CNT     3
+
+#define MAX_10BIT      ((1<<10)-1)
+
+/* Touch screen channel BIAS constants */
+#define XBIAS          0x20
+#define YBIAS          0x40
+#define ZBIAS          0x80
+
+/* Touch screen coordinates */
+#define MIN_X          10
+#define MAX_X          1024
+#define MIN_Y          10
+#define MAX_Y          1024
+#define WAIT_ADC_COMPLETION 10
+
+/* PMIC ADC round robin delays */
+#define ADC_LOOP_DELAY0 0x0 /* Continuous loop */
+#define ADC_LOOP_DELAY1 0x1 /* 4.5  ms approximate */
+
+/* PMIC Vendor Identifiers */
+#define PMIC_VENDOR_FS  0 /* PMIC vendor FreeScale */
+#define PMIC_VENDOR_MAXIM 1 /* PMIC vendor MAXIM */
+#define PMIC_VENDOR_NEC 2 /* PMIC vendor NEC */
+#define MRSTOUCH_MAX_CHANNELS 32 /* Maximum ADC channels */
+
+/* Touch screen device structure */
+struct mrstouch_dev {
+       struct spi_device *spi; /* SPI device associated with touch screen */
+       struct input_dev *input; /* input device for touchscreen*/
+       char            phys[32]; /* Device name */
+       struct task_struct *pendet_thrd; /* PENDET interrupt handler */
+       u16             asr; /* Address selection register */
+       int             irq;    /* Touch screen IRQ # */
+       uint            vendor;  /* PMIC vendor */
+       uint            rev;  /* PMIC revision */
+       bool            suspended; /* Device suspended status */
+       bool            disabled;  /* Device disabled status */
+       u16             x;  /* X coordinate */
+       u16             y;  /* Y coordinate */
+       bool            pendown;  /* PEN position */
+       uint            xmc;  /* Xmove count */
+       uint            ymc;  /* Xmove count */
+} ;
+
+
+/* Global Pointer to Touch screen device */
+static struct mrstouch_dev *mrstouchdevp;
+
+/* Utility to read PMIC ID */
+static int mrstouch_pmic_id(uint *vendor, uint *rev)
+{
+       int err;
+       struct mrst_pmic_reg_data adc_data;
+
+       adc_data.ioc = 1;
+       adc_data.num_entries = 1;
+       adc_data.pmic_reg_data[0].register_address = PMIC_REG_ID1;
+
+       err = mrst_pmic_ioread(&adc_data);
+       if (err)
+               return -1;
+
+       *vendor = (adc_data.pmic_reg_data[0].value) & 0x7;
+       *rev = (adc_data.pmic_reg_data[0].value >> 3) & 0x7;
+
+       return 0;
+}
+
+/*
+ * Parse ADC channels to find end of the channel configured by other ADC user
+ * NEC and MAXIM requires 4 channels and FreeScale needs 18 channels
+ */
+static int mrstouch_chan_parse(void)
+{
+       int err, i, j, chan, found;
+       struct mrst_pmic_reg_data adc_data;
+
+       adc_data.ioc = 1;
+
+       found = -1;
+       adc_data.num_entries = 4;
+
+       for (i = 0; i < MRSTOUCH_MAX_CHANNELS; i++) {
+               if (found >= 0)
+                       break;
+
+               for (j = 0; j <= 3; j++)
+                       adc_data.pmic_reg_data[j].register_address = PMICADDR0+i;
+
+               err = mrst_pmic_ioread(&adc_data);
+               if (err)
+                       return -1;
+
+               for (j = 0; j < adc_data.num_entries; j++) {
+                       chan = adc_data.pmic_reg_data[j].value;
+                       if (chan == END_OF_CHANNEL) {
+                               found = i;
+                               break;
+                       }
+               }
+       }
+
+       if (found < 0)
+               return 0;
+
+       if (mrstouchdevp->vendor == PMIC_VENDOR_FS) {
+               if (found && found > (MRSTOUCH_MAX_CHANNELS - 18))
+                       return -1;
+       } else {
+               if (found && found > (MRSTOUCH_MAX_CHANNELS - 4))
+                       return -1;
+       }
+       return found;
+}
+
+/* Utility to enable/disable pendet.
+ * pendet set to true enables PENDET interrupt
+ * pendet set to false disables PENDET interrupt
+ * Also clears RND mask bit
+*/
+static void pendet_enable(bool pendet)
+{
+       u8 adccntrl1 = 0;
+       u8 pendet_enabled = 0;
+       int retry = 0;
+       struct mrst_pmic_reg_data adc_data;
+
+       adc_data.ioc = 1;
+
+       adc_data.num_entries = 1;
+       adc_data.pmic_reg_data[0].register_address = PMIC_REG_ADCCNTL1;
+       mrst_pmic_ioread(&adc_data);
+       adccntrl1 = adc_data.pmic_reg_data[0].value;
+
+       if (pendet)
+               adccntrl1 |= 0x20; /* Enable pendet */
+       else
+               adccntrl1 &= 0xDF; /* Disable pendet */
+
+       adc_data.num_entries = 2;
+       adc_data.pmic_reg_data[0].register_address = PMIC_REG_MADCINT;
+       adc_data.pmic_reg_data[0].value = 0x0;
+       adc_data.pmic_reg_data[1].register_address = PMIC_REG_ADCCNTL1;
+       adc_data.pmic_reg_data[1].value = adccntrl1;
+       mrst_pmic_iowrite(&adc_data);
+
+       if (!pendet)
+               return;
+
+
+       /*
+        * Sometimes even after mrst_pmic_iowrite success
+        * the PMIC register value is not updated. Retry few iterations
+        * to enable pendet.
+       */
+       adc_data.num_entries = 1;
+       adc_data.pmic_reg_data[0].register_address = PMIC_REG_ADCCNTL1;
+       mrst_pmic_ioread(&adc_data);
+       pendet_enabled = (adc_data.pmic_reg_data[0].value >> 5) & 0x01;
+
+       retry = 0;
+       while (!pendet_enabled) {
+               retry++;
+               msleep(10);
+               adc_data.pmic_reg_data[0].register_address = PMIC_REG_ADCCNTL1;
+               adc_data.pmic_reg_data[0].value = adccntrl1;
+               mrst_pmic_iowrite(&adc_data);
+
+               adc_data.pmic_reg_data[0].register_address = PMIC_REG_ADCCNTL1;
+               mrst_pmic_ioread(&adc_data);
+               pendet_enabled = (adc_data.pmic_reg_data[0].value >> 5) & 0x01;
+               if (retry >= 10) {
+                       printk(KERN_ERR "Touch screen disabled\n");
+                       break;
+               }
+       }
+}
+
+
+/* To read PMIC ADC touch screen result
+ * Reads ADC storage registers for higher 7 and lower 3 bits
+ * converts the two readings to single value and turns off gain bit
+ */
+static int mrstouch_ts_chan_read(u16 offset, u16 chan, u16 *vp, u16 *vm)
+{
+       int err, count;
+       u16 result;
+       struct mrst_pmic_reg_data       adc_data;
+
+       adc_data.ioc = 1;
+       adc_data.num_entries = 4;
+
+       result = PMIC_REG_ADCSNS0H + offset;
+
+       if (chan == MRST_TS_CHAN12)
+               result += 4;
+
+       for (count = 0; count <= 3; count++)
+               adc_data.pmic_reg_data[count].register_address = result++;
+
+       err = mrst_pmic_ioread(&adc_data);
+       if (err)
+               return -1;
+
+       *vp = adc_data.pmic_reg_data[0].value << 3; /* Higher 7 bits */
+       *vp |= adc_data.pmic_reg_data[1].value & 0x7; /* Lower 3 bits */
+       *vp &= 0x3FF;
+
+       *vm = adc_data.pmic_reg_data[2].value << 3; /* Higher 7 bits */
+       *vm |= adc_data.pmic_reg_data[3].value & 0x7; /* Lower 3 bits */
+       *vm &= 0x3FF;
+
+       return 0;
+}
+
+/* To configure touch screen channels
+ * Writes touch screen channels to ADC address selection registers
+ */
+static int mrstouch_ts_chan_set(uint offset)
+{
+       int err, count;
+       u16 chan;
+       struct mrst_pmic_reg_data       adc_data;
+
+       adc_data.ioc = 1;
+       adc_data.num_entries = 5;
+
+       chan = PMICADDR0 + offset;
+       for (count = 0; count <= 3; count++) {
+               adc_data.pmic_reg_data[count].register_address = chan++;
+               adc_data.pmic_reg_data[count].value = MRST_TS_CHAN10 + count;
+       }
+       adc_data.pmic_reg_data[count].register_address = chan;
+       adc_data.pmic_reg_data[count].value = END_OF_CHANNEL;
+
+       err = mrst_pmic_iowrite(&adc_data);
+       if (err)
+               return -1;
+
+       return 0;
+}
+
+/* Initialize ADC */
+static int mrstouch_adc_init(struct mrstouch_dev *tsdev)
+{
+       int err, start;
+       struct mrst_pmic_mod_reg_data adc_data;
+
+       err = mrstouch_pmic_id(&tsdev->vendor, &tsdev->rev);
+       if (err) {
+               printk(KERN_ERR "Error in reading PMIC Id");
+               return err;
+       }
+
+       start = mrstouch_chan_parse();
+       if (start == -1) {
+               printk(KERN_ERR "Error in parse channels");
+               return start;
+       }
+
+       tsdev->asr = start;
+
+       mrstouch_debug("Channel offset(%d): 0x%X\n", tsdev->asr, tsdev->vendor);
+
+       /* ADC power on, start, enable PENDET and set loop delay
+        * ADC loop delay is set to 4.5 ms approximately
+        * Loop delay more than this results in jitter in adc readings
+        * Setting loop delay to 0 (continous loop) in MAXIM stops PENDET
+        * interrupt generation sometimes.
+        */
+       adc_data.ioc = 1;
+       adc_data.num_entries = 2;
+       adc_data.pmic_mod_reg_data[0].register_address = PMIC_REG_ADCCNTL1;
+       adc_data.pmic_mod_reg_data[0].bit_map = 0xE7;
+
+       adc_data.pmic_mod_reg_data[1].register_address = PMIC_REG_MADCINT;
+       adc_data.pmic_mod_reg_data[1].bit_map = 0x03;
+
+       if (tsdev->vendor == PMIC_VENDOR_FS) {
+               adc_data.pmic_mod_reg_data[0].value = 0xE0 | ADC_LOOP_DELAY0;
+               adc_data.pmic_mod_reg_data[1].value = 0x5;
+       } else {
+               /* NEC and MAXIm not consistent with loop delay 0 */
+               adc_data.pmic_mod_reg_data[0].value = 0xE0 | ADC_LOOP_DELAY1;
+               adc_data.pmic_mod_reg_data[1].value = 0x0;
+
+               /* configure touch screen channels */
+               err = mrstouch_ts_chan_set(tsdev->asr);
+               if (err)
+                       return err;
+       }
+
+       err = mrst_pmic_ioread_modify(&adc_data);
+
+       return err;
+}
+
+/* Reports x,y coordinates to event subsystem */
+static void mrstouch_report_xy(u16 x, u16 y, u16 z)
+{
+       int xdiff, ydiff;
+       bool moving = false;
+
+       if (mrstouchdevp->pendown && z <= TOUCH_PRESSURE) {
+               /* Pen removed, report button release */
+               mrstouch_debug("BTN REL(%d)", z);
+               input_report_key(mrstouchdevp->input, BTN_TOUCH, 0);
+               mrstouchdevp->pendown = false;
+
+               mrstouchdevp->xmc = 0;
+               mrstouchdevp->ymc = 0;
+               return;
+       }
+
+       xdiff = abs(x - mrstouchdevp->x);
+       ydiff = abs(y - mrstouchdevp->y);
+
+       if (xdiff > XMOVE_LIMIT)
+               mrstouchdevp->xmc++; /* Increment X move count */
+       if (ydiff > YMOVE_LIMIT)
+               mrstouchdevp->ymc++; /* Increment Y move count */
+
+       /*
+       if x and y values changes for XYMOVE_CNT readings it is considered
+       as stylus is moving. This is required to differentiate between stylus
+       movement and jitter
+       */
+       if (mrstouchdevp->xmc > XYMOVE_CNT || mrstouchdevp->ymc > XYMOVE_CNT)
+               moving = true; /* Stylus is moving */
+
+       if (x < MIN_X || x > MAX_X || y < MIN_Y || y > MAX_Y) {
+               /* Spurious values, release button if touched and return */
+               if (mrstouchdevp->pendown) {
+                       mrstouch_debug("BTN REL(%d)", z);
+                       input_report_key(mrstouchdevp->input, BTN_TOUCH, 0);
+                       mrstouchdevp->pendown = false;
+                       mrstouchdevp->xmc = 0;
+                       mrstouchdevp->ymc = 0;
+               }
+               return;
+       } else if (!moving && (xdiff <= XMOVE_LIMIT || ydiff <= YMOVE_LIMIT))
+               /*
+               ADC readings are differ by small variations in alternate
+               readings. Multiple ADC readings and averaging results in
+               slow response. All ADC readings fall within move limit are
+               considered as value of previous reading. This minimizes small
+               observable jitter in mouse pointer when stylus at fixed position
+               */
+               return;
+       else {
+               /* save x and y values */
+               mrstouchdevp->x = x;
+               mrstouchdevp->y = y;
+       }
+
+       input_report_abs(mrstouchdevp->input, ABS_X, x);
+       input_report_abs(mrstouchdevp->input, ABS_Y, y);
+       input_sync(mrstouchdevp->input);
+
+       if (!mrstouchdevp->pendown && z > TOUCH_PRESSURE) {
+               /* Pen touched, report button touch */
+               mrstouch_debug("BTN TCH(%d, %d, %d)", x, y, z);
+               input_report_key(mrstouchdevp->input, BTN_TOUCH, 1);
+               mrstouchdevp->pendown = true;
+       }
+}
+
+
+/* Utility to start ADC, used by freescale handler */
+static int pendet_mask(void)
+{
+       int err = 0;
+       struct mrst_pmic_mod_reg_data adc_data;
+
+       adc_data.ioc = 1;
+       adc_data.num_entries = 1;
+       adc_data.pmic_mod_reg_data[1].register_address = PMIC_REG_MADCINT;
+       adc_data.pmic_mod_reg_data[1].bit_map = 0x02;
+       adc_data.pmic_mod_reg_data[1].value = 0x01;
+
+       err = mrst_pmic_ioread_modify(&adc_data);
+
+       return err;
+}
+
+/* Utility to stop ADC, used by freescale handler */
+static int pendet_umask(void)
+{
+       int err = 0;
+       struct mrst_pmic_mod_reg_data adc_data;
+
+       adc_data.ioc = 1;
+       adc_data.num_entries = 1;
+       adc_data.pmic_mod_reg_data[1].register_address = PMIC_REG_MADCINT;
+       adc_data.pmic_mod_reg_data[1].bit_map = 0x02;
+       adc_data.pmic_mod_reg_data[1].value = 0x0;
+
+       err = mrst_pmic_ioread_modify(&adc_data);
+
+       return err;
+}
+
+/* Utility to read ADC, used by freescale handler */
+static int mrstouch_pmic_fs_adc_read(struct mrstouch_dev *tsdev)
+{
+       int err;
+       u16 x, y, z, result;
+       struct mrst_pmic_reg_data adc_data;
+
+       result = PMIC_REG_ADCSNS0H + tsdev->asr;
+
+       adc_data.ioc = 1;
+       adc_data.num_entries = 4;
+       adc_data.pmic_reg_data[0].register_address = result + 4;
+       adc_data.pmic_reg_data[1].register_address = result + 5;
+       adc_data.pmic_reg_data[2].register_address = result + 16;
+       adc_data.pmic_reg_data[3].register_address = result + 17;
+
+       err = mrst_pmic_ioread(&adc_data);
+       if (err)
+               goto ipc_error;
+
+       x = adc_data.pmic_reg_data[0].value << 3; /* Higher 7 bits */
+       x |= adc_data.pmic_reg_data[1].value & 0x7; /* Lower 3 bits */
+       x &= 0x3FF;
+
+       y = adc_data.pmic_reg_data[2].value << 3; /* Higher 7 bits */
+       y |= adc_data.pmic_reg_data[3].value & 0x7; /* Lower 3 bits */
+       y &= 0x3FF;
+
+       /* Read Z value */
+       adc_data.num_entries = 2;
+       adc_data.pmic_reg_data[0].register_address = result + 28;
+       adc_data.pmic_reg_data[1].register_address = result + 29;
+
+       err = mrst_pmic_ioread(&adc_data);
+       if (err)
+               goto ipc_error;
+
+       z = adc_data.pmic_reg_data[0].value << 3; /* Higher 7 bits */
+       z |= adc_data.pmic_reg_data[1].value & 0x7; /* Lower 3 bits */
+       z &= 0x3FF;
+
+#if defined(MRSTOUCH_PRINT_XYZP)
+       mrstouch_debug("X: %d, Y: %d, Z: %d", x, y, z);
+#endif
+
+       if (z >= TOUCH_PRESSURE_FS) {
+               mrstouch_report_xy(x, y, TOUCH_PRESSURE - 1); /* Pen Removed */
+               return TOUCH_PRESSURE - 1;
+       } else {
+               mrstouch_report_xy(x, y, TOUCH_PRESSURE + 1); /* Pen Touched */
+               return TOUCH_PRESSURE + 1;
+       }
+
+       return 0;
+
+ipc_error:
+       printk(KERN_ERR "IPC Error: %s", __func__);
+       return -1;
+}
+
+/* To handle free scale pmic pendet interrupt */
+static int pmic0_pendet(void *data)
+{
+       int err, count;
+       u16 chan;
+       unsigned int touched;
+       struct mrst_pmic_reg_data adc_data;
+       struct mrstouch_dev *tsdev = (struct mrstouch_dev *)data;
+
+       chan = PMICADDR0 + tsdev->asr;
+
+       adc_data.ioc = 1;
+       /* Set X BIAS */
+       adc_data.num_entries = 5;
+       for (count = 0; count <= 3; count++) {
+               adc_data.pmic_reg_data[count].register_address = chan++;
+               adc_data.pmic_reg_data[count].value = 0x2A;
+       }
+       adc_data.pmic_reg_data[count].register_address = chan++; /* Dummy */
+       adc_data.pmic_reg_data[count].value = 0;
+
+       err = mrst_pmic_iowrite(&adc_data);
+       if (err)
+               goto ipc_error;
+
+       msleep(WAIT_ADC_COMPLETION);
+
+       /* Set Y BIAS */
+       adc_data.num_entries = 5;
+       for (count = 0; count <= 3; count++) {
+               adc_data.pmic_reg_data[count].register_address = chan++;
+               adc_data.pmic_reg_data[count].value = 0x4A;
+       }
+       adc_data.pmic_reg_data[count].register_address = chan++; /* Dummy */
+       adc_data.pmic_reg_data[count].value = 0;
+
+       err = mrst_pmic_iowrite(&adc_data);
+       if (err)
+               goto ipc_error;
+
+       msleep(WAIT_ADC_COMPLETION);
+
+       /* Set Z BIAS */
+       chan += 2;
+       adc_data.num_entries = 4;
+       for (count = 0; count <= 3; count++) {
+               adc_data.pmic_reg_data[count].register_address = chan++;
+               adc_data.pmic_reg_data[count].value = 0x8A;
+       }
+
+       err = mrst_pmic_iowrite(&adc_data);
+       if (err)
+               goto ipc_error;
+
+       msleep(WAIT_ADC_COMPLETION);
+
+       /*Read touch screen channels till pen removed
+       * Freescale reports constant value of z for all points
+       * z is high when screen is not touched and low when touched
+       * Map high z value to not touched and low z value to pen touched
+       */
+       touched = mrstouch_pmic_fs_adc_read(tsdev);
+       while (touched > TOUCH_PRESSURE) {
+               touched = mrstouch_pmic_fs_adc_read(tsdev);
+               msleep(WAIT_ADC_COMPLETION);
+       }
+
+       /* Clear all TS channels */
+       chan = PMICADDR0 + tsdev->asr;
+       adc_data.ioc = 1;
+       adc_data.num_entries = 5;
+       for (count = 0; count <= 4; count++) {
+               adc_data.pmic_reg_data[count].register_address = chan++;
+               adc_data.pmic_reg_data[count].value = 0x0;
+       }
+       err = mrst_pmic_iowrite(&adc_data);
+       if (err)
+               goto ipc_error;
+
+       for (count = 0; count <= 4; count++) {
+               adc_data.pmic_reg_data[count].register_address = chan++;
+               adc_data.pmic_reg_data[count].value = 0x0;
+       }
+       err = mrst_pmic_iowrite(&adc_data);
+       if (err)
+               goto ipc_error;
+
+       chan += 2;
+       for (count = 0; count <= 4; count++) {
+               adc_data.pmic_reg_data[count].register_address = chan++;
+               adc_data.pmic_reg_data[count].value = 0x0;
+       }
+       err = mrst_pmic_iowrite(&adc_data);
+       if (err)
+               goto ipc_error;
+
+       return 0;
+
+ipc_error:
+       printk(KERN_ERR "IPC Error: %s", __func__);
+       return -1;
+}
+
+
+/* To enable X, Y and Z bias values
+ * Enables YPYM for X channels and XPXM for Y channels
+ */
+static int mrstouch_ts_bias_set(uint offset, uint bias)
+{
+       int err, count;
+       u16 chan, start;
+       struct mrst_pmic_reg_data adc_data;
+
+       chan = PMICADDR0 + offset;
+       start = MRST_TS_CHAN10;
+
+       adc_data.ioc = 1;
+       adc_data.num_entries = 4;
+
+       for (count = 0; count <= 3; count++) {
+               adc_data.pmic_reg_data[count].register_address = chan++;
+               adc_data.pmic_reg_data[count].value = bias | (start + count);
+       }
+
+       err = mrst_pmic_iowrite(&adc_data);
+       if (err)
+               return -1;
+
+       return 0;
+}
+
+/* To read touch screen channel values */
+static int mrstouch_adc_read(struct mrstouch_dev *tsdev)
+{
+       int err;
+       u16 xp, xm, yp, ym, zp, zm;
+
+       /* configure Y bias for X channels */
+       err = mrstouch_ts_bias_set(tsdev->asr, YBIAS);
+       if (err)
+               goto ipc_error;
+
+       msleep(WAIT_ADC_COMPLETION);
+
+       /* read x+ and x- channels */
+       err = mrstouch_ts_chan_read(tsdev->asr, MRST_TS_CHAN10, &xp, &xm);
+       if (err)
+               goto ipc_error;
+
+       /* configure x bias for y channels */
+       err = mrstouch_ts_bias_set(tsdev->asr, XBIAS);
+       if (err)
+               goto ipc_error;
+
+       msleep(WAIT_ADC_COMPLETION);
+
+       /* read y+ and y- channels */
+       err = mrstouch_ts_chan_read(tsdev->asr, MRST_TS_CHAN12, &yp, &ym);
+       if (err)
+               goto ipc_error;
+
+       /* configure z bias for x and y channels */
+       err = mrstouch_ts_bias_set(tsdev->asr, ZBIAS);
+       if (err)
+               goto ipc_error;
+
+       msleep(WAIT_ADC_COMPLETION);
+
+       /* read z+ and z- channels */
+       err = mrstouch_ts_chan_read(tsdev->asr, MRST_TS_CHAN10, &zp, &zm);
+       if (err)
+               goto ipc_error;
+
+#if defined(MRSTOUCH_PRINT_XYZP)
+       printk(KERN_INFO "X+: %d, Y+: %d, Z+: %d\n", xp, yp, zp);
+#endif
+
+#if defined(MRSTOUCH_PRINT_XYZP)
+       printk(KERN_INFO "X-: %d, Y-: %d, Z-: %d\n", xm, ym, zm);
+#endif
+       if (xm < MIN_X || xm > MAX_X || ym < MIN_Y || ym > MAX_Y)
+               return TOUCH_PRESSURE - 1;
+
+       mrstouch_report_xy(xp, yp, zp); /* report x and y to eventX */
+
+       return zp;
+
+ipc_error:
+       printk(KERN_ERR "IPC Error: %s", __func__);
+       return -1;
+}
+
+/* PENDET interrupt handler function for NEC and MAXIM */
+static void pmic12_pendet(void *data)
+{
+       unsigned int touched;
+       struct mrstouch_dev *tsdev = (struct mrstouch_dev *)data;
+
+       /* read touch screen channels till pen removed */
+       touched = mrstouch_adc_read(tsdev);
+       while (touched > TOUCH_PRESSURE) {
+               touched = mrstouch_adc_read(tsdev);
+               msleep(WAIT_ADC_COMPLETION);
+       }
+}
+
+/* Handler to process PENDET interrupt */
+static void mrstouch_pendet(struct work_struct *work)
+{
+       if (mrstouchdevp->vendor == PMIC_VENDOR_NEC ||
+               mrstouchdevp->vendor == PMIC_VENDOR_MAXIM) {
+               /* PENDET must be disabled in NEC before reading ADC */
+               pendet_enable(false); /* Disbale PENDET */
+               pmic12_pendet(mrstouchdevp);
+               pendet_enable(true); /*Enable PENDET */
+       } else if (mrstouchdevp->vendor == PMIC_VENDOR_FS) {
+               pendet_umask(); /* Stop ADC */
+               pmic0_pendet(mrstouchdevp);
+               pendet_mask(); /* Stop ADC */
+       } else
+               printk(KERN_ERR "Unknown PMIC, Not supported\n");
+
+       return;
+}
+
+/* PENDET interrupt handler */
+static irqreturn_t pendet_intr_handler(int irq, void *handle)
+{
+       schedule_delayed_work(&mrstouch_queue, 0);
+       return IRQ_HANDLED;
+}
+
+/* Intializes input device and registers with input subsystem */
+static int ts_input_dev_init(struct mrstouch_dev *tsdev, struct spi_device *spi)
+{
+       int err = 0;
+
+       mrstouch_debug("%s", __func__);
+
+       tsdev->input = input_allocate_device();
+       if (!tsdev->input) {
+               mrstouch_error("%s", "Input dev allocation failed");
+               return -1;
+       }
+
+       tsdev->input->name = "mrst_touchscreen";
+       snprintf(tsdev->phys, sizeof(tsdev->phys),
+                       "%s/input0", dev_name(&spi->dev));
+       tsdev->input->phys = tsdev->phys;
+       tsdev->input->dev.parent = &spi->dev;
+
+       tsdev->input->id.vendor = tsdev->vendor;
+       tsdev->input->id.version = tsdev->rev;
+
+       tsdev->input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+       tsdev->input->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+
+       input_set_abs_params(tsdev->input, ABS_X, MIN_X, MIN_Y, 0, 0);
+       input_set_abs_params(tsdev->input, ABS_Y, MIN_X, MIN_Y, 0, 0);
+
+       err = input_register_device(tsdev->input);
+       if (err) {
+               mrstouch_error("%s", "Input dev registration failed");
+               input_free_device(tsdev->input);
+               return -1;
+       }
+
+       mrstouch_debug("%s", "mrstouch initialized");
+
+       return 0;
+
+}
+
+/* Probe function for touch screen driver */
+static int __devinit mrstouch_probe(struct spi_device *mrstouch_spi)
+{
+       int err;
+       unsigned int myirq;
+       struct mrstouch_dev *tsdev;
+
+       mrstouch_debug("%s(%p)", __func__, mrstouch_spi);
+
+       mrstouchdevp = NULL;
+       myirq = mrstouch_spi->irq;
+
+       if (!mrstouch_spi->irq) {
+               mrstouch_error("%s(%d)", "No IRQ", myirq);
+               return -1;
+       }
+
+       tsdev = kzalloc(sizeof(struct mrstouch_dev), GFP_KERNEL);
+       if (!tsdev) {
+               mrstouch_error("%s", "ERROR: Memory failure");
+               return -ENOMEM;
+       }
+
+       tsdev->irq = myirq;
+       mrstouchdevp = tsdev;
+
+       if (mrstouch_adc_init(tsdev) != 0) {
+               mrstouch_error("%s", "ADC init failed");
+               goto mrstouch_err_free_mem;
+       }
+
+       dev_set_drvdata(&mrstouch_spi->dev, tsdev);
+       tsdev->spi = mrstouch_spi;
+
+       err = ts_input_dev_init(tsdev, mrstouch_spi);
+       if (err != 0) {
+               mrstouch_error("%s", "ts_input_dev_init failed");
+               goto mrstouch_err_free_mem;
+       }
+
+       mrstouch_debug("Requesting IRQ-%d", myirq);
+       err = request_irq(myirq, pendet_intr_handler,
+                               0, "mrstouch", tsdev);
+       if (err) {
+               mrstouch_error("IRQ Request Failed - %d", err);
+               goto mrstouch_err_free_mem;
+       }
+
+       mrstouch_debug("%s", "Driver initialized");
+
+       return 0;
+
+ mrstouch_err_free_mem:
+       kfree(tsdev);
+       return -1;
+}
+
+static int mrstouch_suspend(struct spi_device *spi, pm_message_t msg)
+{
+       mrstouch_debug("%s", __func__);
+       mrstouchdevp->suspended = 1;
+       return 0;
+}
+
+static int mrstouch_resume(struct spi_device *spi)
+{
+       mrstouch_debug("%s", __func__);
+       mrstouchdevp->suspended = 0;
+       return 0;
+}
+
+static int mrstouch_remove(struct spi_device *spi)
+{
+       mrstouch_debug("%s", __func__);
+       free_irq(mrstouchdevp->irq, mrstouchdevp);
+       input_unregister_device(mrstouchdevp->input);
+       input_free_device(mrstouchdevp->input);
+       kfree(mrstouchdevp);
+       return 0;
+}
+
+static struct spi_driver mrstouch_driver = {
+       .driver = {
+               .name   = "pmic_touch",
+               .bus    = &spi_bus_type,
+               .owner  = THIS_MODULE,
+       },
+       .probe          = mrstouch_probe,
+       .suspend        = mrstouch_suspend,
+       .resume         = mrstouch_resume,
+       .remove         = mrstouch_remove,
+};
+
+static int __init mrstouch_module_init(void)
+{
+       int err;
+
+       mrstouch_debug("%s", __func__);
+       err = spi_register_driver(&mrstouch_driver);
+       if (err) {
+               mrstouch_debug("%s(%d)", "SPI PENDET failed", err);
+               return -1;
+       }
+
+       return 0;
+}
+
+static void __exit mrstouch_module_exit(void)
+{
+       mrstouch_debug("%s", __func__);
+       spi_unregister_driver(&mrstouch_driver);
+       return;
+}
+
+module_init(mrstouch_module_init);
+module_exit(mrstouch_module_exit);
--
1.5.4.5
