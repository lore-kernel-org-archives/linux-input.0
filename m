From: "Ds, Sreedhara" <sreedhara.ds@intel.com>
Subject: Emailing:
 0001-Resitive-touch-screen-driver-for-Intel-Moorestown-pl.patch
Date: Tue, 18 Aug 2009 10:40:28 +0530
Message-ID: <0AE3E14D83C76F4994657326177D1FF95CEA7E07@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_0AE3E14D83C76F4994657326177D1FF95CEA7E07bgsmsx501garcor_"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26519 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750965AbZHRFMS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Aug 2009 01:12:18 -0400
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: "Trisal, Kalhan" <kalhan.trisal@intel.com>, "Mahalingam, Nithish" <nithish.mahalingam@intel.com>

--_002_0AE3E14D83C76F4994657326177D1FF95CEA7E07bgsmsx501garcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hello,

Attached is the patch that adds support for the Resistive touchscreen
on Intel's Moorestown platform. This has a dependency on the  Langwell
IPC driver that was submitted to the kernel mailing list but is still not
in the mainstream. The patch can be found at
http://lkml.org/lkml/2009/7/20/396. Also the driver depends on Moorestown S=
PI driver

Thanks,
Sreedhar


>From 1df86620bf0c1eebc5981ff4617c2cfc5bb867c8 Mon Sep 17 00:00:00 2001
From: Sreedhara DS <sreedhara.ds@intel.com>
Date: Tue, 18 Aug 2009 16:08:29 +0530
Subject: [PATCH] Resitive touch screen driver for Intel Moorestown platform=
.
 Driver tested with NEC, MAXIM or FreeScale PMICs using
 moblin "mrstouch" Xorg touch screen driver

        modified:   Kconfig
        modified:   Makefile
        new file:   mrstouch.c

Signed-off-by: Sreedhara DS <sreedhara.ds@intel.com>
---
 drivers/input/touchscreen/Kconfig    |    8 +
 drivers/input/touchscreen/Makefile   |    1 +
 drivers/input/touchscreen/mrstouch.c |  942 ++++++++++++++++++++++++++++++=
++++
 3 files changed, 951 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/touchscreen/mrstouch.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/=
Kconfig
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
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen=
/Makefile
index 3e1c5e0..9b67c17 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -40,3 +40,4 @@ obj-$(CONFIG_TOUCHSCREEN_WM97XX_ATMEL)        +=3D atmel-=
wm97xx.o
 obj-$(CONFIG_TOUCHSCREEN_WM97XX_MAINSTONE)     +=3D mainstone-wm97xx.o
 obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE)      +=3D zylonite-wm97xx.o
 obj-$(CONFIG_TOUCHSCREEN_W90X900)      +=3D w90p910_ts.o
+obj-$(CONFIG_TOUCHSCREEN_MRSTOUCH)    +=3D mrstouch.o
diff --git a/drivers/input/touchscreen/mrstouch.c b/drivers/input/touchscre=
en/mrstouch.c
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
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
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
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
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
+       struct spi_device *spi; /* SPI device associated with touch screen =
*/
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
+       adc_data.ioc =3D 1;
+       adc_data.num_entries =3D 1;
+       adc_data.pmic_reg_data[0].register_address =3D PMIC_REG_ID1;
+
+       err =3D mrst_pmic_ioread(&adc_data);
+       if (err)
+               return -1;
+
+       *vendor =3D (adc_data.pmic_reg_data[0].value) & 0x7;
+       *rev =3D (adc_data.pmic_reg_data[0].value >> 3) & 0x7;
+
+       return 0;
+}
+
+/*
+ * Parse ADC channels to find end of the channel configured by other ADC u=
ser
+ * NEC and MAXIM requires 4 channels and FreeScale needs 18 channels
+ */
+static int mrstouch_chan_parse(void)
+{
+       int err, i, j, chan, found;
+       struct mrst_pmic_reg_data adc_data;
+
+       adc_data.ioc =3D 1;
+
+       found =3D -1;
+       adc_data.num_entries =3D 4;
+
+       for (i =3D 0; i < MRSTOUCH_MAX_CHANNELS; i++) {
+               if (found >=3D 0)
+                       break;
+
+               for (j =3D 0; j <=3D 3; j++)
+                       adc_data.pmic_reg_data[j].register_address =3D PMIC=
ADDR0+i;
+
+               err =3D mrst_pmic_ioread(&adc_data);
+               if (err)
+                       return -1;
+
+               for (j =3D 0; j < adc_data.num_entries; j++) {
+                       chan =3D adc_data.pmic_reg_data[j].value;
+                       if (chan =3D=3D END_OF_CHANNEL) {
+                               found =3D i;
+                               break;
+                       }
+               }
+       }
+
+       if (found < 0)
+               return 0;
+
+       if (mrstouchdevp->vendor =3D=3D PMIC_VENDOR_FS) {
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
+       u8 adccntrl1 =3D 0;
+       u8 pendet_enabled =3D 0;
+       int retry =3D 0;
+       struct mrst_pmic_reg_data adc_data;
+
+       adc_data.ioc =3D 1;
+
+       adc_data.num_entries =3D 1;
+       adc_data.pmic_reg_data[0].register_address =3D PMIC_REG_ADCCNTL1;
+       mrst_pmic_ioread(&adc_data);
+       adccntrl1 =3D adc_data.pmic_reg_data[0].value;
+
+       if (pendet)
+               adccntrl1 |=3D 0x20; /* Enable pendet */
+       else
+               adccntrl1 &=3D 0xDF; /* Disable pendet */
+
+       adc_data.num_entries =3D 2;
+       adc_data.pmic_reg_data[0].register_address =3D PMIC_REG_MADCINT;
+       adc_data.pmic_reg_data[0].value =3D 0x0;
+       adc_data.pmic_reg_data[1].register_address =3D PMIC_REG_ADCCNTL1;
+       adc_data.pmic_reg_data[1].value =3D adccntrl1;
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
+       adc_data.num_entries =3D 1;
+       adc_data.pmic_reg_data[0].register_address =3D PMIC_REG_ADCCNTL1;
+       mrst_pmic_ioread(&adc_data);
+       pendet_enabled =3D (adc_data.pmic_reg_data[0].value >> 5) & 0x01;
+
+       retry =3D 0;
+       while (!pendet_enabled) {
+               retry++;
+               msleep(10);
+               adc_data.pmic_reg_data[0].register_address =3D PMIC_REG_ADC=
CNTL1;
+               adc_data.pmic_reg_data[0].value =3D adccntrl1;
+               mrst_pmic_iowrite(&adc_data);
+
+               adc_data.pmic_reg_data[0].register_address =3D PMIC_REG_ADC=
CNTL1;
+               mrst_pmic_ioread(&adc_data);
+               pendet_enabled =3D (adc_data.pmic_reg_data[0].value >> 5) &=
 0x01;
+               if (retry >=3D 10) {
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
+       adc_data.ioc =3D 1;
+       adc_data.num_entries =3D 4;
+
+       result =3D PMIC_REG_ADCSNS0H + offset;
+
+       if (chan =3D=3D MRST_TS_CHAN12)
+               result +=3D 4;
+
+       for (count =3D 0; count <=3D 3; count++)
+               adc_data.pmic_reg_data[count].register_address =3D result++=
;
+
+       err =3D mrst_pmic_ioread(&adc_data);
+       if (err)
+               return -1;
+
+       *vp =3D adc_data.pmic_reg_data[0].value << 3; /* Higher 7 bits */
+       *vp |=3D adc_data.pmic_reg_data[1].value & 0x7; /* Lower 3 bits */
+       *vp &=3D 0x3FF;
+
+       *vm =3D adc_data.pmic_reg_data[2].value << 3; /* Higher 7 bits */
+       *vm |=3D adc_data.pmic_reg_data[3].value & 0x7; /* Lower 3 bits */
+       *vm &=3D 0x3FF;
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
+       adc_data.ioc =3D 1;
+       adc_data.num_entries =3D 5;
+
+       chan =3D PMICADDR0 + offset;
+       for (count =3D 0; count <=3D 3; count++) {
+               adc_data.pmic_reg_data[count].register_address =3D chan++;
+               adc_data.pmic_reg_data[count].value =3D MRST_TS_CHAN10 + co=
unt;
+       }
+       adc_data.pmic_reg_data[count].register_address =3D chan;
+       adc_data.pmic_reg_data[count].value =3D END_OF_CHANNEL;
+
+       err =3D mrst_pmic_iowrite(&adc_data);
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
+       err =3D mrstouch_pmic_id(&tsdev->vendor, &tsdev->rev);
+       if (err) {
+               printk(KERN_ERR "Error in reading PMIC Id");
+               return err;
+       }
+
+       start =3D mrstouch_chan_parse();
+       if (start =3D=3D -1) {
+               printk(KERN_ERR "Error in parse channels");
+               return start;
+       }
+
+       tsdev->asr =3D start;
+
+       mrstouch_debug("Channel offset(%d): 0x%X\n", tsdev->asr, tsdev->ven=
dor);
+
+       /* ADC power on, start, enable PENDET and set loop delay
+        * ADC loop delay is set to 4.5 ms approximately
+        * Loop delay more than this results in jitter in adc readings
+        * Setting loop delay to 0 (continous loop) in MAXIM stops PENDET
+        * interrupt generation sometimes.
+        */
+       adc_data.ioc =3D 1;
+       adc_data.num_entries =3D 2;
+       adc_data.pmic_mod_reg_data[0].register_address =3D PMIC_REG_ADCCNTL=
1;
+       adc_data.pmic_mod_reg_data[0].bit_map =3D 0xE7;
+
+       adc_data.pmic_mod_reg_data[1].register_address =3D PMIC_REG_MADCINT=
;
+       adc_data.pmic_mod_reg_data[1].bit_map =3D 0x03;
+
+       if (tsdev->vendor =3D=3D PMIC_VENDOR_FS) {
+               adc_data.pmic_mod_reg_data[0].value =3D 0xE0 | ADC_LOOP_DEL=
AY0;
+               adc_data.pmic_mod_reg_data[1].value =3D 0x5;
+       } else {
+               /* NEC and MAXIm not consistent with loop delay 0 */
+               adc_data.pmic_mod_reg_data[0].value =3D 0xE0 | ADC_LOOP_DEL=
AY1;
+               adc_data.pmic_mod_reg_data[1].value =3D 0x0;
+
+               /* configure touch screen channels */
+               err =3D mrstouch_ts_chan_set(tsdev->asr);
+               if (err)
+                       return err;
+       }
+
+       err =3D mrst_pmic_ioread_modify(&adc_data);
+
+       return err;
+}
+
+/* Reports x,y coordinates to event subsystem */
+static void mrstouch_report_xy(u16 x, u16 y, u16 z)
+{
+       int xdiff, ydiff;
+       bool moving =3D false;
+
+       if (mrstouchdevp->pendown && z <=3D TOUCH_PRESSURE) {
+               /* Pen removed, report button release */
+               mrstouch_debug("BTN REL(%d)", z);
+               input_report_key(mrstouchdevp->input, BTN_TOUCH, 0);
+               mrstouchdevp->pendown =3D false;
+
+               mrstouchdevp->xmc =3D 0;
+               mrstouchdevp->ymc =3D 0;
+               return;
+       }
+
+       xdiff =3D abs(x - mrstouchdevp->x);
+       ydiff =3D abs(y - mrstouchdevp->y);
+
+       if (xdiff > XMOVE_LIMIT)
+               mrstouchdevp->xmc++; /* Increment X move count */
+       if (ydiff > YMOVE_LIMIT)
+               mrstouchdevp->ymc++; /* Increment Y move count */
+
+       /*
+       if x and y values changes for XYMOVE_CNT readings it is considered
+       as stylus is moving. This is required to differentiate between styl=
us
+       movement and jitter
+       */
+       if (mrstouchdevp->xmc > XYMOVE_CNT || mrstouchdevp->ymc > XYMOVE_CN=
T)
+               moving =3D true; /* Stylus is moving */
+
+       if (x < MIN_X || x > MAX_X || y < MIN_Y || y > MAX_Y) {
+               /* Spurious values, release button if touched and return */
+               if (mrstouchdevp->pendown) {
+                       mrstouch_debug("BTN REL(%d)", z);
+                       input_report_key(mrstouchdevp->input, BTN_TOUCH, 0)=
;
+                       mrstouchdevp->pendown =3D false;
+                       mrstouchdevp->xmc =3D 0;
+                       mrstouchdevp->ymc =3D 0;
+               }
+               return;
+       } else if (!moving && (xdiff <=3D XMOVE_LIMIT || ydiff <=3D YMOVE_L=
IMIT))
+               /*
+               ADC readings are differ by small variations in alternate
+               readings. Multiple ADC readings and averaging results in
+               slow response. All ADC readings fall within move limit are
+               considered as value of previous reading. This minimizes sma=
ll
+               observable jitter in mouse pointer when stylus at fixed pos=
ition
+               */
+               return;
+       else {
+               /* save x and y values */
+               mrstouchdevp->x =3D x;
+               mrstouchdevp->y =3D y;
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
+               mrstouchdevp->pendown =3D true;
+       }
+}
+
+
+/* Utility to start ADC, used by freescale handler */
+static int pendet_mask(void)
+{
+       int err =3D 0;
+       struct mrst_pmic_mod_reg_data adc_data;
+
+       adc_data.ioc =3D 1;
+       adc_data.num_entries =3D 1;
+       adc_data.pmic_mod_reg_data[1].register_address =3D PMIC_REG_MADCINT=
;
+       adc_data.pmic_mod_reg_data[1].bit_map =3D 0x02;
+       adc_data.pmic_mod_reg_data[1].value =3D 0x01;
+
+       err =3D mrst_pmic_ioread_modify(&adc_data);
+
+       return err;
+}
+
+/* Utility to stop ADC, used by freescale handler */
+static int pendet_umask(void)
+{
+       int err =3D 0;
+       struct mrst_pmic_mod_reg_data adc_data;
+
+       adc_data.ioc =3D 1;
+       adc_data.num_entries =3D 1;
+       adc_data.pmic_mod_reg_data[1].register_address =3D PMIC_REG_MADCINT=
;
+       adc_data.pmic_mod_reg_data[1].bit_map =3D 0x02;
+       adc_data.pmic_mod_reg_data[1].value =3D 0x0;
+
+       err =3D mrst_pmic_ioread_modify(&adc_data);
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
+       result =3D PMIC_REG_ADCSNS0H + tsdev->asr;
+
+       adc_data.ioc =3D 1;
+       adc_data.num_entries =3D 4;
+       adc_data.pmic_reg_data[0].register_address =3D result + 4;
+       adc_data.pmic_reg_data[1].register_address =3D result + 5;
+       adc_data.pmic_reg_data[2].register_address =3D result + 16;
+       adc_data.pmic_reg_data[3].register_address =3D result + 17;
+
+       err =3D mrst_pmic_ioread(&adc_data);
+       if (err)
+               goto ipc_error;
+
+       x =3D adc_data.pmic_reg_data[0].value << 3; /* Higher 7 bits */
+       x |=3D adc_data.pmic_reg_data[1].value & 0x7; /* Lower 3 bits */
+       x &=3D 0x3FF;
+
+       y =3D adc_data.pmic_reg_data[2].value << 3; /* Higher 7 bits */
+       y |=3D adc_data.pmic_reg_data[3].value & 0x7; /* Lower 3 bits */
+       y &=3D 0x3FF;
+
+       /* Read Z value */
+       adc_data.num_entries =3D 2;
+       adc_data.pmic_reg_data[0].register_address =3D result + 28;
+       adc_data.pmic_reg_data[1].register_address =3D result + 29;
+
+       err =3D mrst_pmic_ioread(&adc_data);
+       if (err)
+               goto ipc_error;
+
+       z =3D adc_data.pmic_reg_data[0].value << 3; /* Higher 7 bits */
+       z |=3D adc_data.pmic_reg_data[1].value & 0x7; /* Lower 3 bits */
+       z &=3D 0x3FF;
+
+#if defined(MRSTOUCH_PRINT_XYZP)
+       mrstouch_debug("X: %d, Y: %d, Z: %d", x, y, z);
+#endif
+
+       if (z >=3D TOUCH_PRESSURE_FS) {
+               mrstouch_report_xy(x, y, TOUCH_PRESSURE - 1); /* Pen Remove=
d */
+               return TOUCH_PRESSURE - 1;
+       } else {
+               mrstouch_report_xy(x, y, TOUCH_PRESSURE + 1); /* Pen Touche=
d */
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
+       struct mrstouch_dev *tsdev =3D (struct mrstouch_dev *)data;
+
+       chan =3D PMICADDR0 + tsdev->asr;
+
+       adc_data.ioc =3D 1;
+       /* Set X BIAS */
+       adc_data.num_entries =3D 5;
+       for (count =3D 0; count <=3D 3; count++) {
+               adc_data.pmic_reg_data[count].register_address =3D chan++;
+               adc_data.pmic_reg_data[count].value =3D 0x2A;
+       }
+       adc_data.pmic_reg_data[count].register_address =3D chan++; /* Dummy=
 */
+       adc_data.pmic_reg_data[count].value =3D 0;
+
+       err =3D mrst_pmic_iowrite(&adc_data);
+       if (err)
+               goto ipc_error;
+
+       msleep(WAIT_ADC_COMPLETION);
+
+       /* Set Y BIAS */
+       adc_data.num_entries =3D 5;
+       for (count =3D 0; count <=3D 3; count++) {
+               adc_data.pmic_reg_data[count].register_address =3D chan++;
+               adc_data.pmic_reg_data[count].value =3D 0x4A;
+       }
+       adc_data.pmic_reg_data[count].register_address =3D chan++; /* Dummy=
 */
+       adc_data.pmic_reg_data[count].value =3D 0;
+
+       err =3D mrst_pmic_iowrite(&adc_data);
+       if (err)
+               goto ipc_error;
+
+       msleep(WAIT_ADC_COMPLETION);
+
+       /* Set Z BIAS */
+       chan +=3D 2;
+       adc_data.num_entries =3D 4;
+       for (count =3D 0; count <=3D 3; count++) {
+               adc_data.pmic_reg_data[count].register_address =3D chan++;
+               adc_data.pmic_reg_data[count].value =3D 0x8A;
+       }
+
+       err =3D mrst_pmic_iowrite(&adc_data);
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
+       touched =3D mrstouch_pmic_fs_adc_read(tsdev);
+       while (touched > TOUCH_PRESSURE) {
+               touched =3D mrstouch_pmic_fs_adc_read(tsdev);
+               msleep(WAIT_ADC_COMPLETION);
+       }
+
+       /* Clear all TS channels */
+       chan =3D PMICADDR0 + tsdev->asr;
+       adc_data.ioc =3D 1;
+       adc_data.num_entries =3D 5;
+       for (count =3D 0; count <=3D 4; count++) {
+               adc_data.pmic_reg_data[count].register_address =3D chan++;
+               adc_data.pmic_reg_data[count].value =3D 0x0;
+       }
+       err =3D mrst_pmic_iowrite(&adc_data);
+       if (err)
+               goto ipc_error;
+
+       for (count =3D 0; count <=3D 4; count++) {
+               adc_data.pmic_reg_data[count].register_address =3D chan++;
+               adc_data.pmic_reg_data[count].value =3D 0x0;
+       }
+       err =3D mrst_pmic_iowrite(&adc_data);
+       if (err)
+               goto ipc_error;
+
+       chan +=3D 2;
+       for (count =3D 0; count <=3D 4; count++) {
+               adc_data.pmic_reg_data[count].register_address =3D chan++;
+               adc_data.pmic_reg_data[count].value =3D 0x0;
+       }
+       err =3D mrst_pmic_iowrite(&adc_data);
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
+       chan =3D PMICADDR0 + offset;
+       start =3D MRST_TS_CHAN10;
+
+       adc_data.ioc =3D 1;
+       adc_data.num_entries =3D 4;
+
+       for (count =3D 0; count <=3D 3; count++) {
+               adc_data.pmic_reg_data[count].register_address =3D chan++;
+               adc_data.pmic_reg_data[count].value =3D bias | (start + cou=
nt);
+       }
+
+       err =3D mrst_pmic_iowrite(&adc_data);
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
+       err =3D mrstouch_ts_bias_set(tsdev->asr, YBIAS);
+       if (err)
+               goto ipc_error;
+
+       msleep(WAIT_ADC_COMPLETION);
+
+       /* read x+ and x- channels */
+       err =3D mrstouch_ts_chan_read(tsdev->asr, MRST_TS_CHAN10, &xp, &xm)=
;
+       if (err)
+               goto ipc_error;
+
+       /* configure x bias for y channels */
+       err =3D mrstouch_ts_bias_set(tsdev->asr, XBIAS);
+       if (err)
+               goto ipc_error;
+
+       msleep(WAIT_ADC_COMPLETION);
+
+       /* read y+ and y- channels */
+       err =3D mrstouch_ts_chan_read(tsdev->asr, MRST_TS_CHAN12, &yp, &ym)=
;
+       if (err)
+               goto ipc_error;
+
+       /* configure z bias for x and y channels */
+       err =3D mrstouch_ts_bias_set(tsdev->asr, ZBIAS);
+       if (err)
+               goto ipc_error;
+
+       msleep(WAIT_ADC_COMPLETION);
+
+       /* read z+ and z- channels */
+       err =3D mrstouch_ts_chan_read(tsdev->asr, MRST_TS_CHAN10, &zp, &zm)=
;
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
+       struct mrstouch_dev *tsdev =3D (struct mrstouch_dev *)data;
+
+       /* read touch screen channels till pen removed */
+       touched =3D mrstouch_adc_read(tsdev);
+       while (touched > TOUCH_PRESSURE) {
+               touched =3D mrstouch_adc_read(tsdev);
+               msleep(WAIT_ADC_COMPLETION);
+       }
+}
+
+/* Handler to process PENDET interrupt */
+static void mrstouch_pendet(struct work_struct *work)
+{
+       if (mrstouchdevp->vendor =3D=3D PMIC_VENDOR_NEC ||
+               mrstouchdevp->vendor =3D=3D PMIC_VENDOR_MAXIM) {
+               /* PENDET must be disabled in NEC before reading ADC */
+               pendet_enable(false); /* Disbale PENDET */
+               pmic12_pendet(mrstouchdevp);
+               pendet_enable(true); /*Enable PENDET */
+       } else if (mrstouchdevp->vendor =3D=3D PMIC_VENDOR_FS) {
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
+static int ts_input_dev_init(struct mrstouch_dev *tsdev, struct spi_device=
 *spi)
+{
+       int err =3D 0;
+
+       mrstouch_debug("%s", __func__);
+
+       tsdev->input =3D input_allocate_device();
+       if (!tsdev->input) {
+               mrstouch_error("%s", "Input dev allocation failed");
+               return -1;
+       }
+
+       tsdev->input->name =3D "mrst_touchscreen";
+       snprintf(tsdev->phys, sizeof(tsdev->phys),
+                       "%s/input0", dev_name(&spi->dev));
+       tsdev->input->phys =3D tsdev->phys;
+       tsdev->input->dev.parent =3D &spi->dev;
+
+       tsdev->input->id.vendor =3D tsdev->vendor;
+       tsdev->input->id.version =3D tsdev->rev;
+
+       tsdev->input->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+       tsdev->input->keybit[BIT_WORD(BTN_TOUCH)] =3D BIT_MASK(BTN_TOUCH);
+
+       input_set_abs_params(tsdev->input, ABS_X, MIN_X, MIN_Y, 0, 0);
+       input_set_abs_params(tsdev->input, ABS_Y, MIN_X, MIN_Y, 0, 0);
+
+       err =3D input_register_device(tsdev->input);
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
+       mrstouchdevp =3D NULL;
+       myirq =3D mrstouch_spi->irq;
+
+       if (!mrstouch_spi->irq) {
+               mrstouch_error("%s(%d)", "No IRQ", myirq);
+               return -1;
+       }
+
+       tsdev =3D kzalloc(sizeof(struct mrstouch_dev), GFP_KERNEL);
+       if (!tsdev) {
+               mrstouch_error("%s", "ERROR: Memory failure");
+               return -ENOMEM;
+       }
+
+       tsdev->irq =3D myirq;
+       mrstouchdevp =3D tsdev;
+
+       if (mrstouch_adc_init(tsdev) !=3D 0) {
+               mrstouch_error("%s", "ADC init failed");
+               goto mrstouch_err_free_mem;
+       }
+
+       dev_set_drvdata(&mrstouch_spi->dev, tsdev);
+       tsdev->spi =3D mrstouch_spi;
+
+       err =3D ts_input_dev_init(tsdev, mrstouch_spi);
+       if (err !=3D 0) {
+               mrstouch_error("%s", "ts_input_dev_init failed");
+               goto mrstouch_err_free_mem;
+       }
+
+       mrstouch_debug("Requesting IRQ-%d", myirq);
+       err =3D request_irq(myirq, pendet_intr_handler,
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
+       mrstouchdevp->suspended =3D 1;
+       return 0;
+}
+
+static int mrstouch_resume(struct spi_device *spi)
+{
+       mrstouch_debug("%s", __func__);
+       mrstouchdevp->suspended =3D 0;
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
+static struct spi_driver mrstouch_driver =3D {
+       .driver =3D {
+               .name   =3D "pmic_touch",
+               .bus    =3D &spi_bus_type,
+               .owner  =3D THIS_MODULE,
+       },
+       .probe          =3D mrstouch_probe,
+       .suspend        =3D mrstouch_suspend,
+       .resume         =3D mrstouch_resume,
+       .remove         =3D mrstouch_remove,
+};
+
+static int __init mrstouch_module_init(void)
+{
+       int err;
+
+       mrstouch_debug("%s", __func__);
+       err =3D spi_register_driver(&mrstouch_driver);
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

--_002_0AE3E14D83C76F4994657326177D1FF95CEA7E07bgsmsx501garcor_
Content-Type: application/octet-stream;
	name="0001-Resitive-touch-screen-driver-for-Intel-Moorestown-pl.patch"
Content-Description: 0001-Resitive-touch-screen-driver-for-Intel-Moorestown-pl.patch
Content-Disposition: attachment;
	filename="0001-Resitive-touch-screen-driver-for-Intel-Moorestown-pl.patch";
	size=28532; creation-date="Tue, 18 Aug 2009 16:12:18 GMT";
	modification-date="Tue, 18 Aug 2009 16:12:18 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxZGY4NjYyMGJmMGMxZWViYzU5ODFmZjQ2MTdjMmNmYzViYjg2N2M4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogU3JlZWRoYXJhIERTIDxzcmVlZGhhcmEuZHNAaW50ZWwuY29t
Pg0KRGF0ZTogVHVlLCAxOCBBdWcgMjAwOSAxNjowODoyOSArMDUzMA0KU3ViamVjdDogW1BBVENI
XSBSZXNpdGl2ZSB0b3VjaCBzY3JlZW4gZHJpdmVyIGZvciBJbnRlbCBNb29yZXN0b3duIHBsYXRm
b3JtLg0KIERyaXZlciB0ZXN0ZWQgd2l0aCBORUMsIE1BWElNIG9yIEZyZWVTY2FsZSBQTUlDcyB1
c2luZw0KIG1vYmxpbiAibXJzdG91Y2giIFhvcmcgdG91Y2ggc2NyZWVuIGRyaXZlcg0KDQoJbW9k
aWZpZWQ6ICAgS2NvbmZpZw0KCW1vZGlmaWVkOiAgIE1ha2VmaWxlDQoJbmV3IGZpbGU6ICAgbXJz
dG91Y2guYw0KDQpTaWduZWQtb2ZmLWJ5OiBTcmVlZGhhcmEgRFMgPHNyZWVkaGFyYS5kc0BpbnRl
bC5jb20+DQotLS0NCiBkcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL0tjb25maWcgICAgfCAgICA4
ICsNCiBkcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL01ha2VmaWxlICAgfCAgICAxICsNCiBkcml2
ZXJzL2lucHV0L3RvdWNoc2NyZWVuL21yc3RvdWNoLmMgfCAgOTQyICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCiAzIGZpbGVzIGNoYW5nZWQsIDk1MSBpbnNlcnRpb25zKCspLCAw
IGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2lucHV0L3RvdWNoc2Ny
ZWVuL21yc3RvdWNoLmMNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4v
S2NvbmZpZyBiL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vS2NvbmZpZw0KaW5kZXggNzJlMjcx
Mi4uYWE3ZGIzNCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vS2NvbmZp
Zw0KKysrIGIvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9LY29uZmlnDQpAQCAtNDk4LDQgKzQ5
OCwxMiBAQCBjb25maWcgVE9VQ0hTQ1JFRU5fVzkwWDkwMA0KIAkgIFRvIGNvbXBpbGUgdGhpcyBk
cml2ZXIgYXMgYSBtb2R1bGUsIGNob29zZSBNIGhlcmU6IHRoZQ0KIAkgIG1vZHVsZSB3aWxsIGJl
IGNhbGxlZCB3OTBwOTEwX3RzLg0KIA0KK2NvbmZpZyBUT1VDSFNDUkVFTl9NUlNUT1VDSA0KKwl0
cmlzdGF0ZSAiSW50ZWwgTW9vcnN0b3duIFJlc2lzdGl2ZSB0b3VjaHNjcmVlbiINCisJZGVwZW5k
cyBvbiBMQU5HV0VMTF9JUEMgJiYgU1BJX01SU1QNCisJZGVmYXVsdCB5DQorCWhlbHANCisJICBT
YXkgWSBoZXJlIGlmIHlvdSBoYXZlIGEgSW50ZWwgTW9vcnN0b3duIGJhc2VkIFRvdWNoc2NyZWVu
DQorCSAgSWYgdW5zdXJlLCBzYXkgTi4NCisNCiBlbmRpZg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW5wdXQvdG91Y2hzY3JlZW4vTWFrZWZpbGUgYi9kcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL01h
a2VmaWxlDQppbmRleCAzZTFjNWUwLi45YjY3YzE3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pbnB1
dC90b3VjaHNjcmVlbi9NYWtlZmlsZQ0KKysrIGIvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9N
YWtlZmlsZQ0KQEAgLTQwLDMgKzQwLDQgQEAgb2JqLSQoQ09ORklHX1RPVUNIU0NSRUVOX1dNOTdY
WF9BVE1FTCkJKz0gYXRtZWwtd205N3h4Lm8NCiBvYmotJChDT05GSUdfVE9VQ0hTQ1JFRU5fV005
N1hYX01BSU5TVE9ORSkJKz0gbWFpbnN0b25lLXdtOTd4eC5vDQogb2JqLSQoQ09ORklHX1RPVUNI
U0NSRUVOX1dNOTdYWF9aWUxPTklURSkJKz0genlsb25pdGUtd205N3h4Lm8NCiBvYmotJChDT05G
SUdfVE9VQ0hTQ1JFRU5fVzkwWDkwMCkJKz0gdzkwcDkxMF90cy5vDQorb2JqLSQoQ09ORklHX1RP
VUNIU0NSRUVOX01SU1RPVUNIKSAgICArPSBtcnN0b3VjaC5vDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pbnB1dC90b3VjaHNjcmVlbi9tcnN0b3VjaC5jIGIvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVl
bi9tcnN0b3VjaC5jDQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMC4uNWNkOTFm
OA0KLS0tIC9kZXYvbnVsbA0KKysrIGIvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9tcnN0b3Vj
aC5jDQpAQCAtMCwwICsxLDk0MiBAQA0KKy8qDQorICogbXJzdG91Y2guYyAtIEludGVsIE1vb3Jl
c3Rvd24gUmVzaXN0aXZlIFRvdWNoIFNjcmVlbiBEcml2ZXINCisgKg0KKyAqIENvcHlyaWdodCAo
QykgMjAwOCBJbnRlbCBDb3JwDQorICoNCisgKiB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KKyAqDQorICog
VGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFu
ZC9vciBtb2RpZnkNCisgKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1
YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQ0KKyAqIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5k
YXRpb247IHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZS4NCisgKg0KKyAqIFRoaXMgcHJvZ3JhbSBp
cyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLCBidXQNCisg
KiBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5
IG9mDQorICogTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQ
T1NFLglTZWUgdGhlIEdOVQ0KKyAqIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0
YWlscy4NCisgKg0KKyAqIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdO
VSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFsb25nDQorICogd2l0aCB0aGlzIHByb2dyYW07IGlm
bm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLCBJbmMuLA0KKyAqIDU5
IFRlbXBsZSBQbGFjZSwgU3VpdGUgMzMwLCBCb3N0b24sIE1BIDAyMTExLTEzMDcgVVNBLg0KKyAq
DQorICogUXVlc3Rpb25zL0NvbW1lbnRzL0J1ZyBmaXhlcyB0byBTcmVlZGhhcmEgKHNyZWVkaGFy
YS5kc0BpbnRlbC5jb20pDQorICogfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCisgKi8NCisjaW5jbHVkZSA8
bGludXgvbW9kdWxlLmg+DQorI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4NCisjaW5jbHVkZSA8bGlu
dXgvaW5wdXQuaD4NCisjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+DQorI2luY2x1ZGUgPGxp
bnV4L2Vyci5oPg0KKyNpbmNsdWRlIDxsaW51eC9wYXJhbS5oPg0KKyNpbmNsdWRlIDxsaW51eC9z
cGkvc3BpLmg+DQorI2luY2x1ZGUgPGxpbnV4L2lycS5oPg0KKyNpbmNsdWRlIDxsaW51eC9kZWxh
eS5oPg0KKyNpbmNsdWRlIDxhc20vbXJzdF9pcGNkZWZzLmg+DQorDQorTU9EVUxFX0FVVEhPUigi
U3JlZWRoYXJhIE11cnRoeS4gRC5TLCBzcmVlZGhhcmEuZHNAaW50ZWwuY29tIik7DQorTU9EVUxF
X0RFU0NSSVBUSU9OKCJJbnRlbCBNb29yZXN0b3duIFJlc2lzdGl2ZSBUb3VjaCBTY3JlZW4gRHJp
dmVyIik7DQorTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOw0KKw0KKyNpZiBkZWZpbmVkKE1SU1RPVUNI
X0RFQlVHKQ0KKyNkZWZpbmUgbXJzdG91Y2hfZGVidWcoZm10LCBhcmdzLi4uKVwNCisJZG8geyBc
DQorCQlwcmludGsoS0VSTl9ERUJVRyAiXG5bTVJTVE9VQ0goJWQpXSAtICIsIF9fTElORV9fKTsg
XA0KKwkJcHJpbnRrKEtFUk5fREVCVUcgZm10LCAjI2FyZ3MpOyBcDQorCX0gd2hpbGUgKDApOw0K
KyNlbHNlDQorI2RlZmluZSBtcnN0b3VjaF9kZWJ1ZyhmbXQsIGFyZ3MuLi4pDQorI2VuZGlmDQor
DQorI2RlZmluZSBtcnN0b3VjaF9lcnJvcihmbXQsIGFyZ3MuLi4pXA0KKwlkbyB7IFwNCisJCXBy
aW50ayhLRVJOX0VSUiAiXG5bTVJTVE9VQ0goJWQpXSAtICIsIF9fTElORV9fKTsgXA0KKwkJcHJp
bnRrKEtFUk5fRVJSIGZtdCwgIyNhcmdzKTsgXA0KKwl9IHdoaWxlICgwKTsNCisNCitzdGF0aWMg
dm9pZCBtcnN0b3VjaF9wZW5kZXQoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKTsNCitzdGF0aWMg
REVDTEFSRV9ERUxBWUVEX1dPUksobXJzdG91Y2hfcXVldWUsIG1yc3RvdWNoX3BlbmRldCk7DQor
DQorLyogUE1JQyBJbnRlcnJ1cHQgcmVnaXN0ZXJzICovDQorI2RlZmluZSBQTUlDX1JFR19JRDEg
ICAweDAwIC8qUE1JQyBJRDEgcmVnaXN0ZXIgKi8NCisNCisvKiBQTUlDIEludGVycnVwdCByZWdp
c3RlcnMgKi8NCisjZGVmaW5lIFBNSUNfUkVHX0lOVCAgIDB4MDQgLypQTUlDIGludGVycnVwdCBy
ZWdpc3RlciAqLw0KKyNkZWZpbmUgUE1JQ19SRUdfTUlOVCAgMHgwNSAvKlBNSUMgaW50ZXJydXB0
IG1hc2sgcmVnaXN0ZXIgKi8NCisNCisvKiBBREMgSW50ZXJydXB0IHJlZ2lzdGVycyAqLw0KKyNk
ZWZpbmUgUE1JQ19SRUdfQURDSU5UICAgMHg1RiAvKkFEQyBpbnRlcnJ1cHQgcmVnaXN0ZXIgKi8N
CisjZGVmaW5lIFBNSUNfUkVHX01BRENJTlQgIDB4NjAgLypBREMgaW50ZXJydXB0IG1hc2sgcmVn
aXN0ZXIgKi8NCisNCisvKiBBREMgQ29udHJvbCByZWdpc3RlcnMgKi8NCisjZGVmaW5lIFBNSUNf
UkVHX0FEQ0NOVEwxICAgIDB4NjEgLypBREMgY29udHJvbCByZWdpc3RlciAqLw0KKw0KKy8qIEFE
QyBDaGFubmVsIFNlbGVjdGlvbiByZWdpc3RlcnMgKi8NCisjZGVmaW5lIFBNSUNBRERSMCAgICAg
MHhBNA0KKyNkZWZpbmUgRU5EX09GX0NIQU5ORUwgMHgxRg0KKw0KKy8qIEFEQyBSZXN1bHQgcmVn
aXN0ZXIgKi8NCisjZGVmaW5lIFBNSUNfUkVHX0FEQ1NOUzBIICAgMHg2NA0KKw0KKy8qIEFEQyBj
aGFubmVscyBmb3IgdG91Y2ggc2NyZWVuICovDQorI2RlZmluZSBNUlNUX1RTX0NIQU4xMCAgIDB4
QSAvKiBUb3VjaCBzY3JlZW4gWCsgY29ubmVjdGlvbiAqLw0KKyNkZWZpbmUgTVJTVF9UU19DSEFO
MTEgICAweEIgLyogVG91Y2ggc2NyZWVuIFgtIGNvbm5lY3Rpb24gKi8NCisjZGVmaW5lIE1SU1Rf
VFNfQ0hBTjEyICAgMHhDIC8qIFRvdWNoIHNjcmVlbiBZKyBjb25uZWN0aW9uICovDQorI2RlZmlu
ZSBNUlNUX1RTX0NIQU4xMyAgIDB4RCAvKiBUb3VjaCBzY3JlZW4gWS0gY29ubmVjdGlvbiAqLw0K
Kw0KKy8qIFRvdWNoIHNjcmVlbiBjb29yZGluYXRlIGNvbnN0YW50cyAqLw0KKyNkZWZpbmUgVE9V
Q0hfUFJFU1NVUkUgICAJNQ0KKyNkZWZpbmUgVE9VQ0hfUFJFU1NVUkVfRlMJMTAwDQorDQorI2Rl
ZmluZSBYTU9WRV9MSU1JVAk1DQorI2RlZmluZSBZTU9WRV9MSU1JVAk1DQorI2RlZmluZSBYWU1P
VkVfQ05UCTMNCisNCisjZGVmaW5lIE1BWF8xMEJJVAkoKDE8PDEwKS0xKQ0KKw0KKy8qIFRvdWNo
IHNjcmVlbiBjaGFubmVsIEJJQVMgY29uc3RhbnRzICovDQorI2RlZmluZSBYQklBUwkJMHgyMA0K
KyNkZWZpbmUgWUJJQVMJCTB4NDANCisjZGVmaW5lIFpCSUFTCQkweDgwDQorDQorLyogVG91Y2gg
c2NyZWVuIGNvb3JkaW5hdGVzICovDQorI2RlZmluZSBNSU5fWAkJMTANCisjZGVmaW5lIE1BWF9Y
CQkxMDI0DQorI2RlZmluZSBNSU5fWQkJMTANCisjZGVmaW5lIE1BWF9ZCQkxMDI0DQorI2RlZmlu
ZSBXQUlUX0FEQ19DT01QTEVUSU9OIDEwDQorDQorLyogUE1JQyBBREMgcm91bmQgcm9iaW4gZGVs
YXlzICovDQorI2RlZmluZSBBRENfTE9PUF9ERUxBWTAgMHgwIC8qIENvbnRpbnVvdXMgbG9vcCAq
Lw0KKyNkZWZpbmUgQURDX0xPT1BfREVMQVkxIDB4MSAvKiA0LjUgIG1zIGFwcHJveGltYXRlICov
DQorDQorLyogUE1JQyBWZW5kb3IgSWRlbnRpZmllcnMgKi8NCisjZGVmaW5lIFBNSUNfVkVORE9S
X0ZTICAwIC8qIFBNSUMgdmVuZG9yIEZyZWVTY2FsZSAqLw0KKyNkZWZpbmUgUE1JQ19WRU5ET1Jf
TUFYSU0gMSAvKiBQTUlDIHZlbmRvciBNQVhJTSAqLw0KKyNkZWZpbmUgUE1JQ19WRU5ET1JfTkVD
IDIgLyogUE1JQyB2ZW5kb3IgTkVDICovDQorI2RlZmluZSBNUlNUT1VDSF9NQVhfQ0hBTk5FTFMg
MzIgLyogTWF4aW11bSBBREMgY2hhbm5lbHMgKi8NCisNCisvKiBUb3VjaCBzY3JlZW4gZGV2aWNl
IHN0cnVjdHVyZSAqLw0KK3N0cnVjdCBtcnN0b3VjaF9kZXYgew0KKwlzdHJ1Y3Qgc3BpX2Rldmlj
ZSAqc3BpOyAvKiBTUEkgZGV2aWNlIGFzc29jaWF0ZWQgd2l0aCB0b3VjaCBzY3JlZW4gKi8NCisJ
c3RydWN0IGlucHV0X2RldiAqaW5wdXQ7IC8qIGlucHV0IGRldmljZSBmb3IgdG91Y2hzY3JlZW4q
Lw0KKwljaGFyIAkJcGh5c1szMl07IC8qIERldmljZSBuYW1lICovDQorCXN0cnVjdCB0YXNrX3N0
cnVjdCAqcGVuZGV0X3RocmQ7IC8qIFBFTkRFVCBpbnRlcnJ1cHQgaGFuZGxlciAqLw0KKwl1MTYg
ICAgICAgICAgICAgYXNyOyAvKiBBZGRyZXNzIHNlbGVjdGlvbiByZWdpc3RlciAqLw0KKwlpbnQg
ICAgICAgICAgICAgaXJxOyAgICAvKiBUb3VjaCBzY3JlZW4gSVJRICMgKi8NCisJdWludAkJdmVu
ZG9yOyAgLyogUE1JQyB2ZW5kb3IgKi8NCisJdWludAkJcmV2OyAgLyogUE1JQyByZXZpc2lvbiAq
Lw0KKwlib29sCQlzdXNwZW5kZWQ7IC8qIERldmljZSBzdXNwZW5kZWQgc3RhdHVzICovDQorCWJv
b2wJCWRpc2FibGVkOyAgLyogRGV2aWNlIGRpc2FibGVkIHN0YXR1cyAqLw0KKwl1MTYJCXg7ICAv
KiBYIGNvb3JkaW5hdGUgKi8NCisJdTE2CQl5OyAgLyogWSBjb29yZGluYXRlICovDQorCWJvb2wJ
CXBlbmRvd247ICAvKiBQRU4gcG9zaXRpb24gKi8NCisJdWludAkJeG1jOyAgLyogWG1vdmUgY291
bnQgKi8NCisJdWludAkJeW1jOyAgLyogWG1vdmUgY291bnQgKi8NCit9IDsNCisNCisNCisvKiBH
bG9iYWwgUG9pbnRlciB0byBUb3VjaCBzY3JlZW4gZGV2aWNlICovDQorc3RhdGljIHN0cnVjdCBt
cnN0b3VjaF9kZXYgKm1yc3RvdWNoZGV2cDsNCisNCisvKiBVdGlsaXR5IHRvIHJlYWQgUE1JQyBJ
RCAqLw0KK3N0YXRpYyBpbnQgbXJzdG91Y2hfcG1pY19pZCh1aW50ICp2ZW5kb3IsIHVpbnQgKnJl
dikNCit7DQorCWludCBlcnI7DQorCXN0cnVjdCBtcnN0X3BtaWNfcmVnX2RhdGEgYWRjX2RhdGE7
DQorDQorCWFkY19kYXRhLmlvYyA9IDE7DQorCWFkY19kYXRhLm51bV9lbnRyaWVzID0gMTsNCisJ
YWRjX2RhdGEucG1pY19yZWdfZGF0YVswXS5yZWdpc3Rlcl9hZGRyZXNzID0gUE1JQ19SRUdfSUQx
Ow0KKw0KKwllcnIgPSBtcnN0X3BtaWNfaW9yZWFkKCZhZGNfZGF0YSk7DQorCWlmIChlcnIpDQor
CQlyZXR1cm4gLTE7DQorDQorCSp2ZW5kb3IgPSAoYWRjX2RhdGEucG1pY19yZWdfZGF0YVswXS52
YWx1ZSkgJiAweDc7DQorCSpyZXYgPSAoYWRjX2RhdGEucG1pY19yZWdfZGF0YVswXS52YWx1ZSA+
PiAzKSAmIDB4NzsNCisNCisJcmV0dXJuIDA7DQorfQ0KKw0KKy8qDQorICogUGFyc2UgQURDIGNo
YW5uZWxzIHRvIGZpbmQgZW5kIG9mIHRoZSBjaGFubmVsIGNvbmZpZ3VyZWQgYnkgb3RoZXIgQURD
IHVzZXINCisgKiBORUMgYW5kIE1BWElNIHJlcXVpcmVzIDQgY2hhbm5lbHMgYW5kIEZyZWVTY2Fs
ZSBuZWVkcyAxOCBjaGFubmVscw0KKyAqLw0KK3N0YXRpYyBpbnQgbXJzdG91Y2hfY2hhbl9wYXJz
ZSh2b2lkKQ0KK3sNCisJaW50IGVyciwgaSwgaiwgY2hhbiwgZm91bmQ7DQorCXN0cnVjdCBtcnN0
X3BtaWNfcmVnX2RhdGEgYWRjX2RhdGE7DQorDQorCWFkY19kYXRhLmlvYyA9IDE7DQorDQorCWZv
dW5kID0gLTE7DQorCWFkY19kYXRhLm51bV9lbnRyaWVzID0gNDsNCisNCisJZm9yIChpID0gMDsg
aSA8IE1SU1RPVUNIX01BWF9DSEFOTkVMUzsgaSsrKSB7DQorCQlpZiAoZm91bmQgPj0gMCkNCisJ
CQlicmVhazsNCisNCisJCWZvciAoaiA9IDA7IGogPD0gMzsgaisrKQ0KKwkJCWFkY19kYXRhLnBt
aWNfcmVnX2RhdGFbal0ucmVnaXN0ZXJfYWRkcmVzcyA9IFBNSUNBRERSMCtpOw0KKw0KKwkJZXJy
ID0gbXJzdF9wbWljX2lvcmVhZCgmYWRjX2RhdGEpOw0KKwkJaWYgKGVycikNCisJCQlyZXR1cm4g
LTE7DQorDQorCQlmb3IgKGogPSAwOyBqIDwgYWRjX2RhdGEubnVtX2VudHJpZXM7IGorKykgew0K
KwkJCWNoYW4gPSBhZGNfZGF0YS5wbWljX3JlZ19kYXRhW2pdLnZhbHVlOw0KKwkJCWlmIChjaGFu
ID09IEVORF9PRl9DSEFOTkVMKSB7DQorCQkJCWZvdW5kID0gaTsNCisJCQkJYnJlYWs7DQorCQkJ
fQ0KKwkJfQ0KKwl9DQorDQorCWlmIChmb3VuZCA8IDApDQorCQlyZXR1cm4gMDsNCisNCisJaWYg
KG1yc3RvdWNoZGV2cC0+dmVuZG9yID09IFBNSUNfVkVORE9SX0ZTKSB7DQorCQlpZiAoZm91bmQg
JiYgZm91bmQgPiAoTVJTVE9VQ0hfTUFYX0NIQU5ORUxTIC0gMTgpKQ0KKwkJCXJldHVybiAtMTsN
CisJfSBlbHNlIHsNCisJCWlmIChmb3VuZCAmJiBmb3VuZCA+IChNUlNUT1VDSF9NQVhfQ0hBTk5F
TFMgLSA0KSkNCisJCQlyZXR1cm4gLTE7DQorCX0NCisJcmV0dXJuIGZvdW5kOw0KK30NCisNCisv
KiBVdGlsaXR5IHRvIGVuYWJsZS9kaXNhYmxlIHBlbmRldC4NCisgKiBwZW5kZXQgc2V0IHRvIHRy
dWUgZW5hYmxlcyBQRU5ERVQgaW50ZXJydXB0DQorICogcGVuZGV0IHNldCB0byBmYWxzZSBkaXNh
YmxlcyBQRU5ERVQgaW50ZXJydXB0DQorICogQWxzbyBjbGVhcnMgUk5EIG1hc2sgYml0DQorKi8N
CitzdGF0aWMgdm9pZCBwZW5kZXRfZW5hYmxlKGJvb2wgcGVuZGV0KQ0KK3sNCisJdTggYWRjY250
cmwxID0gMDsNCisJdTggcGVuZGV0X2VuYWJsZWQgPSAwOw0KKwlpbnQgcmV0cnkgPSAwOw0KKwlz
dHJ1Y3QgbXJzdF9wbWljX3JlZ19kYXRhIGFkY19kYXRhOw0KKw0KKwlhZGNfZGF0YS5pb2MgPSAx
Ow0KKw0KKwlhZGNfZGF0YS5udW1fZW50cmllcyA9IDE7DQorCWFkY19kYXRhLnBtaWNfcmVnX2Rh
dGFbMF0ucmVnaXN0ZXJfYWRkcmVzcyA9IFBNSUNfUkVHX0FEQ0NOVEwxOw0KKwltcnN0X3BtaWNf
aW9yZWFkKCZhZGNfZGF0YSk7DQorCWFkY2NudHJsMSA9IGFkY19kYXRhLnBtaWNfcmVnX2RhdGFb
MF0udmFsdWU7DQorDQorCWlmIChwZW5kZXQpDQorCQlhZGNjbnRybDEgfD0gMHgyMDsgLyogRW5h
YmxlIHBlbmRldCAqLw0KKwllbHNlDQorCQlhZGNjbnRybDEgJj0gMHhERjsgLyogRGlzYWJsZSBw
ZW5kZXQgKi8NCisNCisJYWRjX2RhdGEubnVtX2VudHJpZXMgPSAyOw0KKwlhZGNfZGF0YS5wbWlj
X3JlZ19kYXRhWzBdLnJlZ2lzdGVyX2FkZHJlc3MgPSBQTUlDX1JFR19NQURDSU5UOw0KKwlhZGNf
ZGF0YS5wbWljX3JlZ19kYXRhWzBdLnZhbHVlID0gMHgwOw0KKwlhZGNfZGF0YS5wbWljX3JlZ19k
YXRhWzFdLnJlZ2lzdGVyX2FkZHJlc3MgPSBQTUlDX1JFR19BRENDTlRMMTsNCisJYWRjX2RhdGEu
cG1pY19yZWdfZGF0YVsxXS52YWx1ZSA9IGFkY2NudHJsMTsNCisJbXJzdF9wbWljX2lvd3JpdGUo
JmFkY19kYXRhKTsNCisNCisJaWYgKCFwZW5kZXQpDQorCQlyZXR1cm47DQorDQorDQorCS8qDQor
CSAqIFNvbWV0aW1lcyBldmVuIGFmdGVyIG1yc3RfcG1pY19pb3dyaXRlIHN1Y2Nlc3MNCisJICog
dGhlIFBNSUMgcmVnaXN0ZXIgdmFsdWUgaXMgbm90IHVwZGF0ZWQuIFJldHJ5IGZldyBpdGVyYXRp
b25zDQorCSAqIHRvIGVuYWJsZSBwZW5kZXQuDQorCSovDQorCWFkY19kYXRhLm51bV9lbnRyaWVz
ID0gMTsNCisJYWRjX2RhdGEucG1pY19yZWdfZGF0YVswXS5yZWdpc3Rlcl9hZGRyZXNzID0gUE1J
Q19SRUdfQURDQ05UTDE7DQorCW1yc3RfcG1pY19pb3JlYWQoJmFkY19kYXRhKTsNCisJcGVuZGV0
X2VuYWJsZWQgPSAoYWRjX2RhdGEucG1pY19yZWdfZGF0YVswXS52YWx1ZSA+PiA1KSAmIDB4MDE7
DQorDQorCXJldHJ5ID0gMDsNCisJd2hpbGUgKCFwZW5kZXRfZW5hYmxlZCkgew0KKwkJcmV0cnkr
KzsNCisJCW1zbGVlcCgxMCk7DQorCQlhZGNfZGF0YS5wbWljX3JlZ19kYXRhWzBdLnJlZ2lzdGVy
X2FkZHJlc3MgPSBQTUlDX1JFR19BRENDTlRMMTsNCisJCWFkY19kYXRhLnBtaWNfcmVnX2RhdGFb
MF0udmFsdWUgPSBhZGNjbnRybDE7DQorCQltcnN0X3BtaWNfaW93cml0ZSgmYWRjX2RhdGEpOw0K
Kw0KKwkJYWRjX2RhdGEucG1pY19yZWdfZGF0YVswXS5yZWdpc3Rlcl9hZGRyZXNzID0gUE1JQ19S
RUdfQURDQ05UTDE7DQorCQltcnN0X3BtaWNfaW9yZWFkKCZhZGNfZGF0YSk7DQorCQlwZW5kZXRf
ZW5hYmxlZCA9IChhZGNfZGF0YS5wbWljX3JlZ19kYXRhWzBdLnZhbHVlID4+IDUpICYgMHgwMTsN
CisJCWlmIChyZXRyeSA+PSAxMCkgew0KKwkJCXByaW50ayhLRVJOX0VSUiAiVG91Y2ggc2NyZWVu
IGRpc2FibGVkXG4iKTsNCisJCQlicmVhazsNCisJCX0NCisJfQ0KK30NCisNCisNCisvKiBUbyBy
ZWFkIFBNSUMgQURDIHRvdWNoIHNjcmVlbiByZXN1bHQNCisgKiBSZWFkcyBBREMgc3RvcmFnZSBy
ZWdpc3RlcnMgZm9yIGhpZ2hlciA3IGFuZCBsb3dlciAzIGJpdHMNCisgKiBjb252ZXJ0cyB0aGUg
dHdvIHJlYWRpbmdzIHRvIHNpbmdsZSB2YWx1ZSBhbmQgdHVybnMgb2ZmIGdhaW4gYml0DQorICov
DQorc3RhdGljIGludCBtcnN0b3VjaF90c19jaGFuX3JlYWQodTE2IG9mZnNldCwgdTE2IGNoYW4s
IHUxNiAqdnAsIHUxNiAqdm0pDQorew0KKwlpbnQgZXJyLCBjb3VudDsNCisJdTE2IHJlc3VsdDsN
CisJc3RydWN0IG1yc3RfcG1pY19yZWdfZGF0YQlhZGNfZGF0YTsNCisNCisJYWRjX2RhdGEuaW9j
ID0gMTsNCisJYWRjX2RhdGEubnVtX2VudHJpZXMgPSA0Ow0KKw0KKwlyZXN1bHQgPSBQTUlDX1JF
R19BRENTTlMwSCArIG9mZnNldDsNCisNCisJaWYgKGNoYW4gPT0gTVJTVF9UU19DSEFOMTIpDQor
CQlyZXN1bHQgKz0gNDsNCisNCisJZm9yIChjb3VudCA9IDA7IGNvdW50IDw9IDM7IGNvdW50Kysp
DQorCQlhZGNfZGF0YS5wbWljX3JlZ19kYXRhW2NvdW50XS5yZWdpc3Rlcl9hZGRyZXNzID0gcmVz
dWx0Kys7DQorDQorCWVyciA9IG1yc3RfcG1pY19pb3JlYWQoJmFkY19kYXRhKTsNCisJaWYgKGVy
cikNCisJCXJldHVybiAtMTsNCisNCisJKnZwID0gYWRjX2RhdGEucG1pY19yZWdfZGF0YVswXS52
YWx1ZSA8PCAzOyAvKiBIaWdoZXIgNyBiaXRzICovDQorCSp2cCB8PSBhZGNfZGF0YS5wbWljX3Jl
Z19kYXRhWzFdLnZhbHVlICYgMHg3OyAvKiBMb3dlciAzIGJpdHMgKi8NCisJKnZwICY9IDB4M0ZG
Ow0KKw0KKwkqdm0gPSBhZGNfZGF0YS5wbWljX3JlZ19kYXRhWzJdLnZhbHVlIDw8IDM7IC8qIEhp
Z2hlciA3IGJpdHMgKi8NCisJKnZtIHw9IGFkY19kYXRhLnBtaWNfcmVnX2RhdGFbM10udmFsdWUg
JiAweDc7IC8qIExvd2VyIDMgYml0cyAqLw0KKwkqdm0gJj0gMHgzRkY7DQorDQorCXJldHVybiAw
Ow0KK30NCisNCisvKiBUbyBjb25maWd1cmUgdG91Y2ggc2NyZWVuIGNoYW5uZWxzDQorICogV3Jp
dGVzIHRvdWNoIHNjcmVlbiBjaGFubmVscyB0byBBREMgYWRkcmVzcyBzZWxlY3Rpb24gcmVnaXN0
ZXJzDQorICovDQorc3RhdGljIGludCBtcnN0b3VjaF90c19jaGFuX3NldCh1aW50IG9mZnNldCkN
Cit7DQorCWludCBlcnIsIGNvdW50Ow0KKwl1MTYgY2hhbjsNCisJc3RydWN0IG1yc3RfcG1pY19y
ZWdfZGF0YQlhZGNfZGF0YTsNCisNCisJYWRjX2RhdGEuaW9jID0gMTsNCisJYWRjX2RhdGEubnVt
X2VudHJpZXMgPSA1Ow0KKw0KKwljaGFuID0gUE1JQ0FERFIwICsgb2Zmc2V0Ow0KKwlmb3IgKGNv
dW50ID0gMDsgY291bnQgPD0gMzsgY291bnQrKykgew0KKwkJYWRjX2RhdGEucG1pY19yZWdfZGF0
YVtjb3VudF0ucmVnaXN0ZXJfYWRkcmVzcyA9IGNoYW4rKzsNCisJCWFkY19kYXRhLnBtaWNfcmVn
X2RhdGFbY291bnRdLnZhbHVlID0gTVJTVF9UU19DSEFOMTAgKyBjb3VudDsNCisJfQ0KKwlhZGNf
ZGF0YS5wbWljX3JlZ19kYXRhW2NvdW50XS5yZWdpc3Rlcl9hZGRyZXNzID0gY2hhbjsNCisJYWRj
X2RhdGEucG1pY19yZWdfZGF0YVtjb3VudF0udmFsdWUgPSBFTkRfT0ZfQ0hBTk5FTDsNCisNCisJ
ZXJyID0gbXJzdF9wbWljX2lvd3JpdGUoJmFkY19kYXRhKTsNCisJaWYgKGVycikNCisJCXJldHVy
biAtMTsNCisNCisJcmV0dXJuIDA7DQorfQ0KKw0KKy8qIEluaXRpYWxpemUgQURDICovDQorc3Rh
dGljIGludCBtcnN0b3VjaF9hZGNfaW5pdChzdHJ1Y3QgbXJzdG91Y2hfZGV2ICp0c2RldikNCit7
DQorCWludCBlcnIsIHN0YXJ0Ow0KKwlzdHJ1Y3QgbXJzdF9wbWljX21vZF9yZWdfZGF0YSBhZGNf
ZGF0YTsNCisNCisJZXJyID0gbXJzdG91Y2hfcG1pY19pZCgmdHNkZXYtPnZlbmRvciwgJnRzZGV2
LT5yZXYpOw0KKwlpZiAoZXJyKSB7DQorCQlwcmludGsoS0VSTl9FUlIgIkVycm9yIGluIHJlYWRp
bmcgUE1JQyBJZCIpOw0KKwkJcmV0dXJuIGVycjsNCisJfQ0KKw0KKwlzdGFydCA9IG1yc3RvdWNo
X2NoYW5fcGFyc2UoKTsNCisJaWYgKHN0YXJ0ID09IC0xKSB7DQorCQlwcmludGsoS0VSTl9FUlIg
IkVycm9yIGluIHBhcnNlIGNoYW5uZWxzIik7DQorCQlyZXR1cm4gc3RhcnQ7DQorCX0NCisNCisJ
dHNkZXYtPmFzciA9IHN0YXJ0Ow0KKw0KKwltcnN0b3VjaF9kZWJ1ZygiQ2hhbm5lbCBvZmZzZXQo
JWQpOiAweCVYXG4iLCB0c2Rldi0+YXNyLCB0c2Rldi0+dmVuZG9yKTsNCisNCisJLyogQURDIHBv
d2VyIG9uLCBzdGFydCwgZW5hYmxlIFBFTkRFVCBhbmQgc2V0IGxvb3AgZGVsYXkNCisJICogQURD
IGxvb3AgZGVsYXkgaXMgc2V0IHRvIDQuNSBtcyBhcHByb3hpbWF0ZWx5DQorCSAqIExvb3AgZGVs
YXkgbW9yZSB0aGFuIHRoaXMgcmVzdWx0cyBpbiBqaXR0ZXIgaW4gYWRjIHJlYWRpbmdzDQorCSAq
IFNldHRpbmcgbG9vcCBkZWxheSB0byAwIChjb250aW5vdXMgbG9vcCkgaW4gTUFYSU0gc3RvcHMg
UEVOREVUDQorCSAqIGludGVycnVwdCBnZW5lcmF0aW9uIHNvbWV0aW1lcy4NCisJICovDQorCWFk
Y19kYXRhLmlvYyA9IDE7DQorCWFkY19kYXRhLm51bV9lbnRyaWVzID0gMjsNCisJYWRjX2RhdGEu
cG1pY19tb2RfcmVnX2RhdGFbMF0ucmVnaXN0ZXJfYWRkcmVzcyA9IFBNSUNfUkVHX0FEQ0NOVEwx
Ow0KKwlhZGNfZGF0YS5wbWljX21vZF9yZWdfZGF0YVswXS5iaXRfbWFwID0gMHhFNzsNCisNCisJ
YWRjX2RhdGEucG1pY19tb2RfcmVnX2RhdGFbMV0ucmVnaXN0ZXJfYWRkcmVzcyA9IFBNSUNfUkVH
X01BRENJTlQ7DQorCWFkY19kYXRhLnBtaWNfbW9kX3JlZ19kYXRhWzFdLmJpdF9tYXAgPSAweDAz
Ow0KKw0KKwlpZiAodHNkZXYtPnZlbmRvciA9PSBQTUlDX1ZFTkRPUl9GUykgew0KKwkJYWRjX2Rh
dGEucG1pY19tb2RfcmVnX2RhdGFbMF0udmFsdWUgPSAweEUwIHwgQURDX0xPT1BfREVMQVkwOw0K
KwkJYWRjX2RhdGEucG1pY19tb2RfcmVnX2RhdGFbMV0udmFsdWUgPSAweDU7DQorCX0gZWxzZSB7
DQorCQkvKiBORUMgYW5kIE1BWEltIG5vdCBjb25zaXN0ZW50IHdpdGggbG9vcCBkZWxheSAwICov
DQorCQlhZGNfZGF0YS5wbWljX21vZF9yZWdfZGF0YVswXS52YWx1ZSA9IDB4RTAgfCBBRENfTE9P
UF9ERUxBWTE7DQorCQlhZGNfZGF0YS5wbWljX21vZF9yZWdfZGF0YVsxXS52YWx1ZSA9IDB4MDsN
CisNCisJCS8qIGNvbmZpZ3VyZSB0b3VjaCBzY3JlZW4gY2hhbm5lbHMgKi8NCisJCWVyciA9IG1y
c3RvdWNoX3RzX2NoYW5fc2V0KHRzZGV2LT5hc3IpOw0KKwkJaWYgKGVycikNCisJCQlyZXR1cm4g
ZXJyOw0KKwl9DQorDQorCWVyciA9IG1yc3RfcG1pY19pb3JlYWRfbW9kaWZ5KCZhZGNfZGF0YSk7
DQorDQorCXJldHVybiBlcnI7DQorfQ0KKw0KKy8qIFJlcG9ydHMgeCx5IGNvb3JkaW5hdGVzIHRv
IGV2ZW50IHN1YnN5c3RlbSAqLw0KK3N0YXRpYyB2b2lkIG1yc3RvdWNoX3JlcG9ydF94eSh1MTYg
eCwgdTE2IHksIHUxNiB6KQ0KK3sNCisJaW50IHhkaWZmLCB5ZGlmZjsNCisJYm9vbCBtb3Zpbmcg
PSBmYWxzZTsNCisNCisJaWYgKG1yc3RvdWNoZGV2cC0+cGVuZG93biAmJiB6IDw9IFRPVUNIX1BS
RVNTVVJFKSB7DQorCQkvKiBQZW4gcmVtb3ZlZCwgcmVwb3J0IGJ1dHRvbiByZWxlYXNlICovDQor
CQltcnN0b3VjaF9kZWJ1ZygiQlROIFJFTCglZCkiLCB6KTsNCisJCWlucHV0X3JlcG9ydF9rZXko
bXJzdG91Y2hkZXZwLT5pbnB1dCwgQlROX1RPVUNILCAwKTsNCisJCW1yc3RvdWNoZGV2cC0+cGVu
ZG93biA9IGZhbHNlOw0KKw0KKwkJbXJzdG91Y2hkZXZwLT54bWMgPSAwOw0KKwkJbXJzdG91Y2hk
ZXZwLT55bWMgPSAwOw0KKwkJcmV0dXJuOw0KKwl9DQorDQorCXhkaWZmID0gYWJzKHggLSBtcnN0
b3VjaGRldnAtPngpOw0KKwl5ZGlmZiA9IGFicyh5IC0gbXJzdG91Y2hkZXZwLT55KTsNCisNCisJ
aWYgKHhkaWZmID4gWE1PVkVfTElNSVQpDQorCQltcnN0b3VjaGRldnAtPnhtYysrOyAvKiBJbmNy
ZW1lbnQgWCBtb3ZlIGNvdW50ICovDQorCWlmICh5ZGlmZiA+IFlNT1ZFX0xJTUlUKQ0KKwkJbXJz
dG91Y2hkZXZwLT55bWMrKzsgLyogSW5jcmVtZW50IFkgbW92ZSBjb3VudCAqLw0KKw0KKwkvKg0K
KwlpZiB4IGFuZCB5IHZhbHVlcyBjaGFuZ2VzIGZvciBYWU1PVkVfQ05UIHJlYWRpbmdzIGl0IGlz
IGNvbnNpZGVyZWQNCisJYXMgc3R5bHVzIGlzIG1vdmluZy4gVGhpcyBpcyByZXF1aXJlZCB0byBk
aWZmZXJlbnRpYXRlIGJldHdlZW4gc3R5bHVzDQorCW1vdmVtZW50IGFuZCBqaXR0ZXINCisJKi8N
CisJaWYgKG1yc3RvdWNoZGV2cC0+eG1jID4gWFlNT1ZFX0NOVCB8fCBtcnN0b3VjaGRldnAtPnlt
YyA+IFhZTU9WRV9DTlQpDQorCQltb3ZpbmcgPSB0cnVlOyAvKiBTdHlsdXMgaXMgbW92aW5nICov
DQorDQorCWlmICh4IDwgTUlOX1ggfHwgeCA+IE1BWF9YIHx8IHkgPCBNSU5fWSB8fCB5ID4gTUFY
X1kpIHsNCisJCS8qIFNwdXJpb3VzIHZhbHVlcywgcmVsZWFzZSBidXR0b24gaWYgdG91Y2hlZCBh
bmQgcmV0dXJuICovDQorCQlpZiAobXJzdG91Y2hkZXZwLT5wZW5kb3duKSB7DQorCQkJbXJzdG91
Y2hfZGVidWcoIkJUTiBSRUwoJWQpIiwgeik7DQorCQkJaW5wdXRfcmVwb3J0X2tleShtcnN0b3Vj
aGRldnAtPmlucHV0LCBCVE5fVE9VQ0gsIDApOw0KKwkJCW1yc3RvdWNoZGV2cC0+cGVuZG93biA9
IGZhbHNlOw0KKwkJCW1yc3RvdWNoZGV2cC0+eG1jID0gMDsNCisJCQltcnN0b3VjaGRldnAtPnlt
YyA9IDA7DQorCQl9DQorCQlyZXR1cm47DQorCX0gZWxzZSBpZiAoIW1vdmluZyAmJiAoeGRpZmYg
PD0gWE1PVkVfTElNSVQgfHwgeWRpZmYgPD0gWU1PVkVfTElNSVQpKQ0KKwkJLyoNCisJCUFEQyBy
ZWFkaW5ncyBhcmUgZGlmZmVyIGJ5IHNtYWxsIHZhcmlhdGlvbnMgaW4gYWx0ZXJuYXRlDQorCQly
ZWFkaW5ncy4gTXVsdGlwbGUgQURDIHJlYWRpbmdzIGFuZCBhdmVyYWdpbmcgcmVzdWx0cyBpbg0K
KwkJc2xvdyByZXNwb25zZS4gQWxsIEFEQyByZWFkaW5ncyBmYWxsIHdpdGhpbiBtb3ZlIGxpbWl0
IGFyZQ0KKwkJY29uc2lkZXJlZCBhcyB2YWx1ZSBvZiBwcmV2aW91cyByZWFkaW5nLiBUaGlzIG1p
bmltaXplcyBzbWFsbA0KKwkJb2JzZXJ2YWJsZSBqaXR0ZXIgaW4gbW91c2UgcG9pbnRlciB3aGVu
IHN0eWx1cyBhdCBmaXhlZCBwb3NpdGlvbg0KKwkJKi8NCisJCXJldHVybjsNCisJZWxzZSB7DQor
CQkvKiBzYXZlIHggYW5kIHkgdmFsdWVzICovDQorCQltcnN0b3VjaGRldnAtPnggPSB4Ow0KKwkJ
bXJzdG91Y2hkZXZwLT55ID0geTsNCisJfQ0KKw0KKwlpbnB1dF9yZXBvcnRfYWJzKG1yc3RvdWNo
ZGV2cC0+aW5wdXQsIEFCU19YLCB4KTsNCisJaW5wdXRfcmVwb3J0X2FicyhtcnN0b3VjaGRldnAt
PmlucHV0LCBBQlNfWSwgeSk7DQorCWlucHV0X3N5bmMobXJzdG91Y2hkZXZwLT5pbnB1dCk7DQor
DQorCWlmICghbXJzdG91Y2hkZXZwLT5wZW5kb3duICYmIHogPiBUT1VDSF9QUkVTU1VSRSkgew0K
KwkJLyogUGVuIHRvdWNoZWQsIHJlcG9ydCBidXR0b24gdG91Y2ggKi8NCisJCW1yc3RvdWNoX2Rl
YnVnKCJCVE4gVENIKCVkLCAlZCwgJWQpIiwgeCwgeSwgeik7DQorCQlpbnB1dF9yZXBvcnRfa2V5
KG1yc3RvdWNoZGV2cC0+aW5wdXQsIEJUTl9UT1VDSCwgMSk7DQorCQltcnN0b3VjaGRldnAtPnBl
bmRvd24gPSB0cnVlOw0KKwl9DQorfQ0KKw0KKw0KKy8qIFV0aWxpdHkgdG8gc3RhcnQgQURDLCB1
c2VkIGJ5IGZyZWVzY2FsZSBoYW5kbGVyICovDQorc3RhdGljIGludCBwZW5kZXRfbWFzayh2b2lk
KQ0KK3sNCisJaW50IGVyciA9IDA7DQorCXN0cnVjdCBtcnN0X3BtaWNfbW9kX3JlZ19kYXRhIGFk
Y19kYXRhOw0KKw0KKwlhZGNfZGF0YS5pb2MgPSAxOw0KKwlhZGNfZGF0YS5udW1fZW50cmllcyA9
IDE7DQorCWFkY19kYXRhLnBtaWNfbW9kX3JlZ19kYXRhWzFdLnJlZ2lzdGVyX2FkZHJlc3MgPSBQ
TUlDX1JFR19NQURDSU5UOw0KKwlhZGNfZGF0YS5wbWljX21vZF9yZWdfZGF0YVsxXS5iaXRfbWFw
ID0gMHgwMjsNCisJYWRjX2RhdGEucG1pY19tb2RfcmVnX2RhdGFbMV0udmFsdWUgPSAweDAxOw0K
Kw0KKwllcnIgPSBtcnN0X3BtaWNfaW9yZWFkX21vZGlmeSgmYWRjX2RhdGEpOw0KKw0KKwlyZXR1
cm4gZXJyOw0KK30NCisNCisvKiBVdGlsaXR5IHRvIHN0b3AgQURDLCB1c2VkIGJ5IGZyZWVzY2Fs
ZSBoYW5kbGVyICovDQorc3RhdGljIGludCBwZW5kZXRfdW1hc2sodm9pZCkNCit7DQorCWludCBl
cnIgPSAwOw0KKwlzdHJ1Y3QgbXJzdF9wbWljX21vZF9yZWdfZGF0YSBhZGNfZGF0YTsNCisNCisJ
YWRjX2RhdGEuaW9jID0gMTsNCisJYWRjX2RhdGEubnVtX2VudHJpZXMgPSAxOw0KKwlhZGNfZGF0
YS5wbWljX21vZF9yZWdfZGF0YVsxXS5yZWdpc3Rlcl9hZGRyZXNzID0gUE1JQ19SRUdfTUFEQ0lO
VDsNCisJYWRjX2RhdGEucG1pY19tb2RfcmVnX2RhdGFbMV0uYml0X21hcCA9IDB4MDI7DQorCWFk
Y19kYXRhLnBtaWNfbW9kX3JlZ19kYXRhWzFdLnZhbHVlID0gMHgwOw0KKw0KKwllcnIgPSBtcnN0
X3BtaWNfaW9yZWFkX21vZGlmeSgmYWRjX2RhdGEpOw0KKw0KKwlyZXR1cm4gZXJyOw0KK30NCisN
CisvKiBVdGlsaXR5IHRvIHJlYWQgQURDLCB1c2VkIGJ5IGZyZWVzY2FsZSBoYW5kbGVyICovDQor
c3RhdGljIGludCBtcnN0b3VjaF9wbWljX2ZzX2FkY19yZWFkKHN0cnVjdCBtcnN0b3VjaF9kZXYg
KnRzZGV2KQ0KK3sNCisJaW50IGVycjsNCisJdTE2IHgsIHksIHosIHJlc3VsdDsNCisJc3RydWN0
IG1yc3RfcG1pY19yZWdfZGF0YSBhZGNfZGF0YTsNCisNCisJcmVzdWx0ID0gUE1JQ19SRUdfQURD
U05TMEggKyB0c2Rldi0+YXNyOw0KKw0KKwlhZGNfZGF0YS5pb2MgPSAxOw0KKwlhZGNfZGF0YS5u
dW1fZW50cmllcyA9IDQ7DQorCWFkY19kYXRhLnBtaWNfcmVnX2RhdGFbMF0ucmVnaXN0ZXJfYWRk
cmVzcyA9IHJlc3VsdCArIDQ7DQorCWFkY19kYXRhLnBtaWNfcmVnX2RhdGFbMV0ucmVnaXN0ZXJf
YWRkcmVzcyA9IHJlc3VsdCArIDU7DQorCWFkY19kYXRhLnBtaWNfcmVnX2RhdGFbMl0ucmVnaXN0
ZXJfYWRkcmVzcyA9IHJlc3VsdCArIDE2Ow0KKwlhZGNfZGF0YS5wbWljX3JlZ19kYXRhWzNdLnJl
Z2lzdGVyX2FkZHJlc3MgPSByZXN1bHQgKyAxNzsNCisNCisJZXJyID0gbXJzdF9wbWljX2lvcmVh
ZCgmYWRjX2RhdGEpOw0KKwlpZiAoZXJyKQ0KKwkJZ290byBpcGNfZXJyb3I7DQorDQorCXggPSBh
ZGNfZGF0YS5wbWljX3JlZ19kYXRhWzBdLnZhbHVlIDw8IDM7IC8qIEhpZ2hlciA3IGJpdHMgKi8N
CisJeCB8PSBhZGNfZGF0YS5wbWljX3JlZ19kYXRhWzFdLnZhbHVlICYgMHg3OyAvKiBMb3dlciAz
IGJpdHMgKi8NCisJeCAmPSAweDNGRjsNCisNCisJeSA9IGFkY19kYXRhLnBtaWNfcmVnX2RhdGFb
Ml0udmFsdWUgPDwgMzsgLyogSGlnaGVyIDcgYml0cyAqLw0KKwl5IHw9IGFkY19kYXRhLnBtaWNf
cmVnX2RhdGFbM10udmFsdWUgJiAweDc7IC8qIExvd2VyIDMgYml0cyAqLw0KKwl5ICY9IDB4M0ZG
Ow0KKw0KKwkvKiBSZWFkIFogdmFsdWUgKi8NCisJYWRjX2RhdGEubnVtX2VudHJpZXMgPSAyOw0K
KwlhZGNfZGF0YS5wbWljX3JlZ19kYXRhWzBdLnJlZ2lzdGVyX2FkZHJlc3MgPSByZXN1bHQgKyAy
ODsNCisJYWRjX2RhdGEucG1pY19yZWdfZGF0YVsxXS5yZWdpc3Rlcl9hZGRyZXNzID0gcmVzdWx0
ICsgMjk7DQorDQorCWVyciA9IG1yc3RfcG1pY19pb3JlYWQoJmFkY19kYXRhKTsNCisJaWYgKGVy
cikNCisJCWdvdG8gaXBjX2Vycm9yOw0KKw0KKwl6ID0gYWRjX2RhdGEucG1pY19yZWdfZGF0YVsw
XS52YWx1ZSA8PCAzOyAvKiBIaWdoZXIgNyBiaXRzICovDQorCXogfD0gYWRjX2RhdGEucG1pY19y
ZWdfZGF0YVsxXS52YWx1ZSAmIDB4NzsgLyogTG93ZXIgMyBiaXRzICovDQorCXogJj0gMHgzRkY7
DQorDQorI2lmIGRlZmluZWQoTVJTVE9VQ0hfUFJJTlRfWFlaUCkNCisJbXJzdG91Y2hfZGVidWco
Ilg6ICVkLCBZOiAlZCwgWjogJWQiLCB4LCB5LCB6KTsNCisjZW5kaWYNCisNCisJaWYgKHogPj0g
VE9VQ0hfUFJFU1NVUkVfRlMpIHsNCisJCW1yc3RvdWNoX3JlcG9ydF94eSh4LCB5LCBUT1VDSF9Q
UkVTU1VSRSAtIDEpOyAvKiBQZW4gUmVtb3ZlZCAqLw0KKwkJcmV0dXJuIFRPVUNIX1BSRVNTVVJF
IC0gMTsNCisJfSBlbHNlIHsNCisJCW1yc3RvdWNoX3JlcG9ydF94eSh4LCB5LCBUT1VDSF9QUkVT
U1VSRSArIDEpOyAvKiBQZW4gVG91Y2hlZCAqLw0KKwkJcmV0dXJuIFRPVUNIX1BSRVNTVVJFICsg
MTsNCisJfQ0KKw0KKwlyZXR1cm4gMDsNCisNCitpcGNfZXJyb3I6DQorCXByaW50ayhLRVJOX0VS
UiAiSVBDIEVycm9yOiAlcyIsIF9fZnVuY19fKTsNCisJcmV0dXJuIC0xOw0KK30NCisNCisvKiBU
byBoYW5kbGUgZnJlZSBzY2FsZSBwbWljIHBlbmRldCBpbnRlcnJ1cHQgKi8NCitzdGF0aWMgaW50
IHBtaWMwX3BlbmRldCh2b2lkICpkYXRhKQ0KK3sNCisJaW50IGVyciwgY291bnQ7DQorCXUxNiBj
aGFuOw0KKwl1bnNpZ25lZCBpbnQgdG91Y2hlZDsNCisJc3RydWN0IG1yc3RfcG1pY19yZWdfZGF0
YSBhZGNfZGF0YTsNCisJc3RydWN0IG1yc3RvdWNoX2RldiAqdHNkZXYgPSAoc3RydWN0IG1yc3Rv
dWNoX2RldiAqKWRhdGE7DQorDQorCWNoYW4gPSBQTUlDQUREUjAgKyB0c2Rldi0+YXNyOw0KKw0K
KwlhZGNfZGF0YS5pb2MgPSAxOw0KKwkvKiBTZXQgWCBCSUFTICovDQorCWFkY19kYXRhLm51bV9l
bnRyaWVzID0gNTsNCisJZm9yIChjb3VudCA9IDA7IGNvdW50IDw9IDM7IGNvdW50KyspIHsNCisJ
CWFkY19kYXRhLnBtaWNfcmVnX2RhdGFbY291bnRdLnJlZ2lzdGVyX2FkZHJlc3MgPSBjaGFuKys7
DQorCQlhZGNfZGF0YS5wbWljX3JlZ19kYXRhW2NvdW50XS52YWx1ZSA9IDB4MkE7DQorCX0NCisJ
YWRjX2RhdGEucG1pY19yZWdfZGF0YVtjb3VudF0ucmVnaXN0ZXJfYWRkcmVzcyA9IGNoYW4rKzsg
LyogRHVtbXkgKi8NCisJYWRjX2RhdGEucG1pY19yZWdfZGF0YVtjb3VudF0udmFsdWUgPSAwOw0K
Kw0KKwllcnIgPSBtcnN0X3BtaWNfaW93cml0ZSgmYWRjX2RhdGEpOw0KKwlpZiAoZXJyKQ0KKwkJ
Z290byBpcGNfZXJyb3I7DQorDQorCW1zbGVlcChXQUlUX0FEQ19DT01QTEVUSU9OKTsNCisNCisJ
LyogU2V0IFkgQklBUyAqLw0KKwlhZGNfZGF0YS5udW1fZW50cmllcyA9IDU7DQorCWZvciAoY291
bnQgPSAwOyBjb3VudCA8PSAzOyBjb3VudCsrKSB7DQorCQlhZGNfZGF0YS5wbWljX3JlZ19kYXRh
W2NvdW50XS5yZWdpc3Rlcl9hZGRyZXNzID0gY2hhbisrOw0KKwkJYWRjX2RhdGEucG1pY19yZWdf
ZGF0YVtjb3VudF0udmFsdWUgPSAweDRBOw0KKwl9DQorCWFkY19kYXRhLnBtaWNfcmVnX2RhdGFb
Y291bnRdLnJlZ2lzdGVyX2FkZHJlc3MgPSBjaGFuKys7IC8qIER1bW15ICovDQorCWFkY19kYXRh
LnBtaWNfcmVnX2RhdGFbY291bnRdLnZhbHVlID0gMDsNCisNCisJZXJyID0gbXJzdF9wbWljX2lv
d3JpdGUoJmFkY19kYXRhKTsNCisJaWYgKGVycikNCisJCWdvdG8gaXBjX2Vycm9yOw0KKw0KKwlt
c2xlZXAoV0FJVF9BRENfQ09NUExFVElPTik7DQorDQorCS8qIFNldCBaIEJJQVMgKi8NCisJY2hh
biArPSAyOw0KKwlhZGNfZGF0YS5udW1fZW50cmllcyA9IDQ7DQorCWZvciAoY291bnQgPSAwOyBj
b3VudCA8PSAzOyBjb3VudCsrKSB7DQorCQlhZGNfZGF0YS5wbWljX3JlZ19kYXRhW2NvdW50XS5y
ZWdpc3Rlcl9hZGRyZXNzID0gY2hhbisrOw0KKwkJYWRjX2RhdGEucG1pY19yZWdfZGF0YVtjb3Vu
dF0udmFsdWUgPSAweDhBOw0KKwl9DQorDQorCWVyciA9IG1yc3RfcG1pY19pb3dyaXRlKCZhZGNf
ZGF0YSk7DQorCWlmIChlcnIpDQorCQlnb3RvIGlwY19lcnJvcjsNCisNCisJbXNsZWVwKFdBSVRf
QURDX0NPTVBMRVRJT04pOw0KKw0KKwkvKlJlYWQgdG91Y2ggc2NyZWVuIGNoYW5uZWxzIHRpbGwg
cGVuIHJlbW92ZWQNCisJKiBGcmVlc2NhbGUgcmVwb3J0cyBjb25zdGFudCB2YWx1ZSBvZiB6IGZv
ciBhbGwgcG9pbnRzDQorCSogeiBpcyBoaWdoIHdoZW4gc2NyZWVuIGlzIG5vdCB0b3VjaGVkIGFu
ZCBsb3cgd2hlbiB0b3VjaGVkDQorCSogTWFwIGhpZ2ggeiB2YWx1ZSB0byBub3QgdG91Y2hlZCBh
bmQgbG93IHogdmFsdWUgdG8gcGVuIHRvdWNoZWQNCisJKi8NCisJdG91Y2hlZCA9IG1yc3RvdWNo
X3BtaWNfZnNfYWRjX3JlYWQodHNkZXYpOw0KKwl3aGlsZSAodG91Y2hlZCA+IFRPVUNIX1BSRVNT
VVJFKSB7DQorCQl0b3VjaGVkID0gbXJzdG91Y2hfcG1pY19mc19hZGNfcmVhZCh0c2Rldik7DQor
CQltc2xlZXAoV0FJVF9BRENfQ09NUExFVElPTik7DQorCX0NCisNCisJLyogQ2xlYXIgYWxsIFRT
IGNoYW5uZWxzICovDQorCWNoYW4gPSBQTUlDQUREUjAgKyB0c2Rldi0+YXNyOw0KKwlhZGNfZGF0
YS5pb2MgPSAxOw0KKwlhZGNfZGF0YS5udW1fZW50cmllcyA9IDU7DQorCWZvciAoY291bnQgPSAw
OyBjb3VudCA8PSA0OyBjb3VudCsrKSB7DQorCQlhZGNfZGF0YS5wbWljX3JlZ19kYXRhW2NvdW50
XS5yZWdpc3Rlcl9hZGRyZXNzID0gY2hhbisrOw0KKwkJYWRjX2RhdGEucG1pY19yZWdfZGF0YVtj
b3VudF0udmFsdWUgPSAweDA7DQorCX0NCisJZXJyID0gbXJzdF9wbWljX2lvd3JpdGUoJmFkY19k
YXRhKTsNCisJaWYgKGVycikNCisJCWdvdG8gaXBjX2Vycm9yOw0KKw0KKwlmb3IgKGNvdW50ID0g
MDsgY291bnQgPD0gNDsgY291bnQrKykgew0KKwkJYWRjX2RhdGEucG1pY19yZWdfZGF0YVtjb3Vu
dF0ucmVnaXN0ZXJfYWRkcmVzcyA9IGNoYW4rKzsNCisJCWFkY19kYXRhLnBtaWNfcmVnX2RhdGFb
Y291bnRdLnZhbHVlID0gMHgwOw0KKwl9DQorCWVyciA9IG1yc3RfcG1pY19pb3dyaXRlKCZhZGNf
ZGF0YSk7DQorCWlmIChlcnIpDQorCQlnb3RvIGlwY19lcnJvcjsNCisNCisJY2hhbiArPSAyOw0K
Kwlmb3IgKGNvdW50ID0gMDsgY291bnQgPD0gNDsgY291bnQrKykgew0KKwkJYWRjX2RhdGEucG1p
Y19yZWdfZGF0YVtjb3VudF0ucmVnaXN0ZXJfYWRkcmVzcyA9IGNoYW4rKzsNCisJCWFkY19kYXRh
LnBtaWNfcmVnX2RhdGFbY291bnRdLnZhbHVlID0gMHgwOw0KKwl9DQorCWVyciA9IG1yc3RfcG1p
Y19pb3dyaXRlKCZhZGNfZGF0YSk7DQorCWlmIChlcnIpDQorCQlnb3RvIGlwY19lcnJvcjsNCisN
CisJcmV0dXJuIDA7DQorDQoraXBjX2Vycm9yOg0KKwlwcmludGsoS0VSTl9FUlIgIklQQyBFcnJv
cjogJXMiLCBfX2Z1bmNfXyk7DQorCXJldHVybiAtMTsNCit9DQorDQorDQorLyogVG8gZW5hYmxl
IFgsIFkgYW5kIFogYmlhcyB2YWx1ZXMNCisgKiBFbmFibGVzIFlQWU0gZm9yIFggY2hhbm5lbHMg
YW5kIFhQWE0gZm9yIFkgY2hhbm5lbHMNCisgKi8NCitzdGF0aWMgaW50IG1yc3RvdWNoX3RzX2Jp
YXNfc2V0KHVpbnQgb2Zmc2V0LCB1aW50IGJpYXMpDQorew0KKwlpbnQgZXJyLCBjb3VudDsNCisJ
dTE2IGNoYW4sIHN0YXJ0Ow0KKwlzdHJ1Y3QgbXJzdF9wbWljX3JlZ19kYXRhIGFkY19kYXRhOw0K
Kw0KKwljaGFuID0gUE1JQ0FERFIwICsgb2Zmc2V0Ow0KKwlzdGFydCA9IE1SU1RfVFNfQ0hBTjEw
Ow0KKw0KKwlhZGNfZGF0YS5pb2MgPSAxOw0KKwlhZGNfZGF0YS5udW1fZW50cmllcyA9IDQ7DQor
DQorCWZvciAoY291bnQgPSAwOyBjb3VudCA8PSAzOyBjb3VudCsrKSB7DQorCQlhZGNfZGF0YS5w
bWljX3JlZ19kYXRhW2NvdW50XS5yZWdpc3Rlcl9hZGRyZXNzID0gY2hhbisrOw0KKwkJYWRjX2Rh
dGEucG1pY19yZWdfZGF0YVtjb3VudF0udmFsdWUgPSBiaWFzIHwgKHN0YXJ0ICsgY291bnQpOw0K
Kwl9DQorDQorCWVyciA9IG1yc3RfcG1pY19pb3dyaXRlKCZhZGNfZGF0YSk7DQorCWlmIChlcnIp
DQorCQlyZXR1cm4gLTE7DQorDQorCXJldHVybiAwOw0KK30NCisNCisvKiBUbyByZWFkIHRvdWNo
IHNjcmVlbiBjaGFubmVsIHZhbHVlcyAqLw0KK3N0YXRpYyBpbnQgbXJzdG91Y2hfYWRjX3JlYWQo
c3RydWN0IG1yc3RvdWNoX2RldiAqdHNkZXYpDQorew0KKwlpbnQgZXJyOw0KKwl1MTYgeHAsIHht
LCB5cCwgeW0sIHpwLCB6bTsNCisNCisJLyogY29uZmlndXJlIFkgYmlhcyBmb3IgWCBjaGFubmVs
cyAqLw0KKwllcnIgPSBtcnN0b3VjaF90c19iaWFzX3NldCh0c2Rldi0+YXNyLCBZQklBUyk7DQor
CWlmIChlcnIpDQorCQlnb3RvIGlwY19lcnJvcjsNCisNCisJbXNsZWVwKFdBSVRfQURDX0NPTVBM
RVRJT04pOw0KKw0KKwkvKiByZWFkIHgrIGFuZCB4LSBjaGFubmVscyAqLw0KKwllcnIgPSBtcnN0
b3VjaF90c19jaGFuX3JlYWQodHNkZXYtPmFzciwgTVJTVF9UU19DSEFOMTAsICZ4cCwgJnhtKTsN
CisJaWYgKGVycikNCisJCWdvdG8gaXBjX2Vycm9yOw0KKw0KKwkvKiBjb25maWd1cmUgeCBiaWFz
IGZvciB5IGNoYW5uZWxzICovDQorCWVyciA9IG1yc3RvdWNoX3RzX2JpYXNfc2V0KHRzZGV2LT5h
c3IsIFhCSUFTKTsNCisJaWYgKGVycikNCisJCWdvdG8gaXBjX2Vycm9yOw0KKw0KKwltc2xlZXAo
V0FJVF9BRENfQ09NUExFVElPTik7DQorDQorCS8qIHJlYWQgeSsgYW5kIHktIGNoYW5uZWxzICov
DQorCWVyciA9IG1yc3RvdWNoX3RzX2NoYW5fcmVhZCh0c2Rldi0+YXNyLCBNUlNUX1RTX0NIQU4x
MiwgJnlwLCAmeW0pOw0KKwlpZiAoZXJyKQ0KKwkJZ290byBpcGNfZXJyb3I7DQorDQorCS8qIGNv
bmZpZ3VyZSB6IGJpYXMgZm9yIHggYW5kIHkgY2hhbm5lbHMgKi8NCisJZXJyID0gbXJzdG91Y2hf
dHNfYmlhc19zZXQodHNkZXYtPmFzciwgWkJJQVMpOw0KKwlpZiAoZXJyKQ0KKwkJZ290byBpcGNf
ZXJyb3I7DQorDQorCW1zbGVlcChXQUlUX0FEQ19DT01QTEVUSU9OKTsNCisNCisJLyogcmVhZCB6
KyBhbmQgei0gY2hhbm5lbHMgKi8NCisJZXJyID0gbXJzdG91Y2hfdHNfY2hhbl9yZWFkKHRzZGV2
LT5hc3IsIE1SU1RfVFNfQ0hBTjEwLCAmenAsICZ6bSk7DQorCWlmIChlcnIpDQorCQlnb3RvIGlw
Y19lcnJvcjsNCisNCisjaWYgZGVmaW5lZChNUlNUT1VDSF9QUklOVF9YWVpQKQ0KKwlwcmludGso
S0VSTl9JTkZPICJYKzogJWQsIFkrOiAlZCwgWis6ICVkXG4iLCB4cCwgeXAsIHpwKTsNCisjZW5k
aWYNCisNCisjaWYgZGVmaW5lZChNUlNUT1VDSF9QUklOVF9YWVpQKQ0KKwlwcmludGsoS0VSTl9J
TkZPICJYLTogJWQsIFktOiAlZCwgWi06ICVkXG4iLCB4bSwgeW0sIHptKTsNCisjZW5kaWYNCisJ
aWYgKHhtIDwgTUlOX1ggfHwgeG0gPiBNQVhfWCB8fCB5bSA8IE1JTl9ZIHx8IHltID4gTUFYX1kp
DQorCQlyZXR1cm4gVE9VQ0hfUFJFU1NVUkUgLSAxOw0KKw0KKwltcnN0b3VjaF9yZXBvcnRfeHko
eHAsIHlwLCB6cCk7IC8qIHJlcG9ydCB4IGFuZCB5IHRvIGV2ZW50WCAqLw0KKw0KKwlyZXR1cm4g
enA7DQorDQoraXBjX2Vycm9yOg0KKwlwcmludGsoS0VSTl9FUlIgIklQQyBFcnJvcjogJXMiLCBf
X2Z1bmNfXyk7DQorCXJldHVybiAtMTsNCit9DQorDQorLyogUEVOREVUIGludGVycnVwdCBoYW5k
bGVyIGZ1bmN0aW9uIGZvciBORUMgYW5kIE1BWElNICovDQorc3RhdGljIHZvaWQgcG1pYzEyX3Bl
bmRldCh2b2lkICpkYXRhKQ0KK3sNCisJdW5zaWduZWQgaW50IHRvdWNoZWQ7DQorCXN0cnVjdCBt
cnN0b3VjaF9kZXYgKnRzZGV2ID0gKHN0cnVjdCBtcnN0b3VjaF9kZXYgKilkYXRhOw0KKw0KKwkv
KiByZWFkIHRvdWNoIHNjcmVlbiBjaGFubmVscyB0aWxsIHBlbiByZW1vdmVkICovDQorCXRvdWNo
ZWQgPSBtcnN0b3VjaF9hZGNfcmVhZCh0c2Rldik7DQorCXdoaWxlICh0b3VjaGVkID4gVE9VQ0hf
UFJFU1NVUkUpIHsNCisJCXRvdWNoZWQgPSBtcnN0b3VjaF9hZGNfcmVhZCh0c2Rldik7DQorCQlt
c2xlZXAoV0FJVF9BRENfQ09NUExFVElPTik7DQorCX0NCit9DQorDQorLyogSGFuZGxlciB0byBw
cm9jZXNzIFBFTkRFVCBpbnRlcnJ1cHQgKi8NCitzdGF0aWMgdm9pZCBtcnN0b3VjaF9wZW5kZXQo
c3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KK3sNCisJaWYgKG1yc3RvdWNoZGV2cC0+dmVuZG9y
ID09IFBNSUNfVkVORE9SX05FQyB8fA0KKwkJbXJzdG91Y2hkZXZwLT52ZW5kb3IgPT0gUE1JQ19W
RU5ET1JfTUFYSU0pIHsNCisJCS8qIFBFTkRFVCBtdXN0IGJlIGRpc2FibGVkIGluIE5FQyBiZWZv
cmUgcmVhZGluZyBBREMgKi8NCisJCXBlbmRldF9lbmFibGUoZmFsc2UpOyAvKiBEaXNiYWxlIFBF
TkRFVCAqLw0KKwkJcG1pYzEyX3BlbmRldChtcnN0b3VjaGRldnApOw0KKwkJcGVuZGV0X2VuYWJs
ZSh0cnVlKTsgLypFbmFibGUgUEVOREVUICovDQorCX0gZWxzZSBpZiAobXJzdG91Y2hkZXZwLT52
ZW5kb3IgPT0gUE1JQ19WRU5ET1JfRlMpIHsNCisJCXBlbmRldF91bWFzaygpOyAvKiBTdG9wIEFE
QyAqLw0KKwkJcG1pYzBfcGVuZGV0KG1yc3RvdWNoZGV2cCk7DQorCQlwZW5kZXRfbWFzaygpOyAv
KiBTdG9wIEFEQyAqLw0KKwl9IGVsc2UNCisJCXByaW50ayhLRVJOX0VSUiAiVW5rbm93biBQTUlD
LCBOb3Qgc3VwcG9ydGVkXG4iKTsNCisNCisJcmV0dXJuOw0KK30NCisNCisvKiBQRU5ERVQgaW50
ZXJydXB0IGhhbmRsZXIgKi8NCitzdGF0aWMgaXJxcmV0dXJuX3QgcGVuZGV0X2ludHJfaGFuZGxl
cihpbnQgaXJxLCB2b2lkICpoYW5kbGUpDQorew0KKwlzY2hlZHVsZV9kZWxheWVkX3dvcmsoJm1y
c3RvdWNoX3F1ZXVlLCAwKTsNCisJcmV0dXJuIElSUV9IQU5ETEVEOw0KK30NCisNCisvKiBJbnRp
YWxpemVzIGlucHV0IGRldmljZSBhbmQgcmVnaXN0ZXJzIHdpdGggaW5wdXQgc3Vic3lzdGVtICov
DQorc3RhdGljIGludCB0c19pbnB1dF9kZXZfaW5pdChzdHJ1Y3QgbXJzdG91Y2hfZGV2ICp0c2Rl
diwgc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkNCit7DQorCWludCBlcnIgPSAwOw0KKw0KKwltcnN0
b3VjaF9kZWJ1ZygiJXMiLCBfX2Z1bmNfXyk7DQorDQorCXRzZGV2LT5pbnB1dCA9IGlucHV0X2Fs
bG9jYXRlX2RldmljZSgpOw0KKwlpZiAoIXRzZGV2LT5pbnB1dCkgew0KKwkJbXJzdG91Y2hfZXJy
b3IoIiVzIiwgIklucHV0IGRldiBhbGxvY2F0aW9uIGZhaWxlZCIpOw0KKwkJcmV0dXJuIC0xOw0K
Kwl9DQorDQorCXRzZGV2LT5pbnB1dC0+bmFtZSA9ICJtcnN0X3RvdWNoc2NyZWVuIjsNCisJc25w
cmludGYodHNkZXYtPnBoeXMsIHNpemVvZih0c2Rldi0+cGh5cyksDQorCQkJIiVzL2lucHV0MCIs
IGRldl9uYW1lKCZzcGktPmRldikpOw0KKwl0c2Rldi0+aW5wdXQtPnBoeXMgPSB0c2Rldi0+cGh5
czsNCisJdHNkZXYtPmlucHV0LT5kZXYucGFyZW50ID0gJnNwaS0+ZGV2Ow0KKw0KKwl0c2Rldi0+
aW5wdXQtPmlkLnZlbmRvciA9IHRzZGV2LT52ZW5kb3I7DQorCXRzZGV2LT5pbnB1dC0+aWQudmVy
c2lvbiA9IHRzZGV2LT5yZXY7DQorDQorCXRzZGV2LT5pbnB1dC0+ZXZiaXRbMF0gPSBCSVRfTUFT
SyhFVl9LRVkpIHwgQklUX01BU0soRVZfQUJTKTsNCisJdHNkZXYtPmlucHV0LT5rZXliaXRbQklU
X1dPUkQoQlROX1RPVUNIKV0gPSBCSVRfTUFTSyhCVE5fVE9VQ0gpOw0KKw0KKwlpbnB1dF9zZXRf
YWJzX3BhcmFtcyh0c2Rldi0+aW5wdXQsIEFCU19YLCBNSU5fWCwgTUlOX1ksIDAsIDApOw0KKwlp
bnB1dF9zZXRfYWJzX3BhcmFtcyh0c2Rldi0+aW5wdXQsIEFCU19ZLCBNSU5fWCwgTUlOX1ksIDAs
IDApOw0KKw0KKwllcnIgPSBpbnB1dF9yZWdpc3Rlcl9kZXZpY2UodHNkZXYtPmlucHV0KTsNCisJ
aWYgKGVycikgew0KKwkJbXJzdG91Y2hfZXJyb3IoIiVzIiwgIklucHV0IGRldiByZWdpc3RyYXRp
b24gZmFpbGVkIik7DQorCQlpbnB1dF9mcmVlX2RldmljZSh0c2Rldi0+aW5wdXQpOw0KKwkJcmV0
dXJuIC0xOw0KKwl9DQorDQorCW1yc3RvdWNoX2RlYnVnKCIlcyIsICJtcnN0b3VjaCBpbml0aWFs
aXplZCIpOw0KKw0KKwlyZXR1cm4gMDsNCisNCit9DQorDQorLyogUHJvYmUgZnVuY3Rpb24gZm9y
IHRvdWNoIHNjcmVlbiBkcml2ZXIgKi8NCitzdGF0aWMgaW50IF9fZGV2aW5pdCBtcnN0b3VjaF9w
cm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqbXJzdG91Y2hfc3BpKQ0KK3sNCisJaW50IGVycjsNCisJ
dW5zaWduZWQgaW50IG15aXJxOw0KKwlzdHJ1Y3QgbXJzdG91Y2hfZGV2ICp0c2RldjsNCisNCisJ
bXJzdG91Y2hfZGVidWcoIiVzKCVwKSIsIF9fZnVuY19fLCBtcnN0b3VjaF9zcGkpOw0KKw0KKwlt
cnN0b3VjaGRldnAgPSBOVUxMOw0KKwlteWlycSA9IG1yc3RvdWNoX3NwaS0+aXJxOw0KKw0KKwlp
ZiAoIW1yc3RvdWNoX3NwaS0+aXJxKSB7DQorCQltcnN0b3VjaF9lcnJvcigiJXMoJWQpIiwgIk5v
IElSUSIsIG15aXJxKTsNCisJCXJldHVybiAtMTsNCisJfQ0KKw0KKwl0c2RldiA9IGt6YWxsb2Mo
c2l6ZW9mKHN0cnVjdCBtcnN0b3VjaF9kZXYpLCBHRlBfS0VSTkVMKTsNCisJaWYgKCF0c2Rldikg
ew0KKwkJbXJzdG91Y2hfZXJyb3IoIiVzIiwgIkVSUk9SOiBNZW1vcnkgZmFpbHVyZSIpOw0KKwkJ
cmV0dXJuIC1FTk9NRU07DQorCX0NCisNCisJdHNkZXYtPmlycSA9IG15aXJxOw0KKwltcnN0b3Vj
aGRldnAgPSB0c2RldjsNCisNCisJaWYgKG1yc3RvdWNoX2FkY19pbml0KHRzZGV2KSAhPSAwKSB7
DQorCQltcnN0b3VjaF9lcnJvcigiJXMiLCAiQURDIGluaXQgZmFpbGVkIik7DQorCQlnb3RvIG1y
c3RvdWNoX2Vycl9mcmVlX21lbTsNCisJfQ0KKw0KKwlkZXZfc2V0X2RydmRhdGEoJm1yc3RvdWNo
X3NwaS0+ZGV2LCB0c2Rldik7DQorCXRzZGV2LT5zcGkgPSBtcnN0b3VjaF9zcGk7DQorDQorCWVy
ciA9IHRzX2lucHV0X2Rldl9pbml0KHRzZGV2LCBtcnN0b3VjaF9zcGkpOw0KKwlpZiAoZXJyICE9
IDApIHsNCisJCW1yc3RvdWNoX2Vycm9yKCIlcyIsICJ0c19pbnB1dF9kZXZfaW5pdCBmYWlsZWQi
KTsNCisJCWdvdG8gbXJzdG91Y2hfZXJyX2ZyZWVfbWVtOw0KKwl9DQorDQorCW1yc3RvdWNoX2Rl
YnVnKCJSZXF1ZXN0aW5nIElSUS0lZCIsIG15aXJxKTsNCisJZXJyID0gcmVxdWVzdF9pcnEobXlp
cnEsIHBlbmRldF9pbnRyX2hhbmRsZXIsDQorCQkJCTAsICJtcnN0b3VjaCIsIHRzZGV2KTsNCisJ
aWYgKGVycikgew0KKwkJbXJzdG91Y2hfZXJyb3IoIklSUSBSZXF1ZXN0IEZhaWxlZCAtICVkIiwg
ZXJyKTsNCisJCWdvdG8gbXJzdG91Y2hfZXJyX2ZyZWVfbWVtOw0KKwl9DQorDQorCW1yc3RvdWNo
X2RlYnVnKCIlcyIsICJEcml2ZXIgaW5pdGlhbGl6ZWQiKTsNCisNCisJcmV0dXJuIDA7DQorDQor
IG1yc3RvdWNoX2Vycl9mcmVlX21lbToNCisJa2ZyZWUodHNkZXYpOw0KKwlyZXR1cm4gLTE7DQor
fQ0KKw0KK3N0YXRpYyBpbnQgbXJzdG91Y2hfc3VzcGVuZChzdHJ1Y3Qgc3BpX2RldmljZSAqc3Bp
LCBwbV9tZXNzYWdlX3QgbXNnKQ0KK3sNCisJbXJzdG91Y2hfZGVidWcoIiVzIiwgX19mdW5jX18p
Ow0KKwltcnN0b3VjaGRldnAtPnN1c3BlbmRlZCA9IDE7DQorCXJldHVybiAwOw0KK30NCisNCitz
dGF0aWMgaW50IG1yc3RvdWNoX3Jlc3VtZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KK3sNCisJ
bXJzdG91Y2hfZGVidWcoIiVzIiwgX19mdW5jX18pOw0KKwltcnN0b3VjaGRldnAtPnN1c3BlbmRl
ZCA9IDA7DQorCXJldHVybiAwOw0KK30NCisNCitzdGF0aWMgaW50IG1yc3RvdWNoX3JlbW92ZShz
dHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KK3sNCisJbXJzdG91Y2hfZGVidWcoIiVzIiwgX19mdW5j
X18pOw0KKwlmcmVlX2lycShtcnN0b3VjaGRldnAtPmlycSwgbXJzdG91Y2hkZXZwKTsNCisJaW5w
dXRfdW5yZWdpc3Rlcl9kZXZpY2UobXJzdG91Y2hkZXZwLT5pbnB1dCk7DQorCWlucHV0X2ZyZWVf
ZGV2aWNlKG1yc3RvdWNoZGV2cC0+aW5wdXQpOw0KKwlrZnJlZShtcnN0b3VjaGRldnApOw0KKwly
ZXR1cm4gMDsNCit9DQorDQorc3RhdGljIHN0cnVjdCBzcGlfZHJpdmVyIG1yc3RvdWNoX2RyaXZl
ciA9IHsNCisJLmRyaXZlciA9IHsNCisJCS5uYW1lICAgPSAicG1pY190b3VjaCIsDQorCQkuYnVz
ICAgID0gJnNwaV9idXNfdHlwZSwNCisJCS5vd25lciAgPSBUSElTX01PRFVMRSwNCisJfSwNCisJ
LnByb2JlICAgICAgICAgID0gbXJzdG91Y2hfcHJvYmUsDQorCS5zdXNwZW5kICAgICAgICA9IG1y
c3RvdWNoX3N1c3BlbmQsDQorCS5yZXN1bWUgICAgICAgICA9IG1yc3RvdWNoX3Jlc3VtZSwNCisJ
LnJlbW92ZSAgICAgICAgID0gbXJzdG91Y2hfcmVtb3ZlLA0KK307DQorDQorc3RhdGljIGludCBf
X2luaXQgbXJzdG91Y2hfbW9kdWxlX2luaXQodm9pZCkNCit7DQorCWludCBlcnI7DQorDQorCW1y
c3RvdWNoX2RlYnVnKCIlcyIsIF9fZnVuY19fKTsNCisJZXJyID0gc3BpX3JlZ2lzdGVyX2RyaXZl
cigmbXJzdG91Y2hfZHJpdmVyKTsNCisJaWYgKGVycikgew0KKwkJbXJzdG91Y2hfZGVidWcoIiVz
KCVkKSIsICJTUEkgUEVOREVUIGZhaWxlZCIsIGVycik7DQorCQlyZXR1cm4gLTE7DQorCX0NCisN
CisJcmV0dXJuIDA7DQorfQ0KKw0KK3N0YXRpYyB2b2lkIF9fZXhpdCBtcnN0b3VjaF9tb2R1bGVf
ZXhpdCh2b2lkKQ0KK3sNCisJbXJzdG91Y2hfZGVidWcoIiVzIiwgX19mdW5jX18pOw0KKwlzcGlf
dW5yZWdpc3Rlcl9kcml2ZXIoJm1yc3RvdWNoX2RyaXZlcik7DQorCXJldHVybjsNCit9DQorDQor
bW9kdWxlX2luaXQobXJzdG91Y2hfbW9kdWxlX2luaXQpOw0KK21vZHVsZV9leGl0KG1yc3RvdWNo
X21vZHVsZV9leGl0KTsNCi0tIA0KMS41LjQuNQ0KDQo=

--_002_0AE3E14D83C76F4994657326177D1FF95CEA7E07bgsmsx501garcor_--
