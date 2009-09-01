From: "Ds, Sreedhara" <sreedhara.ds@intel.com>
Subject: Emailing:
 0001-Resistive-touch-screen-driver-for-Intel-Moorestown-p.patch
Date: Tue, 1 Sep 2009 10:54:56 +0530
Message-ID: <0AE3E14D83C76F4994657326177D1FF9631330FF@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_0AE3E14D83C76F4994657326177D1FF9631330FFbgsmsx501garcor_"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:49791 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091AbZIAF0N (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Sep 2009 01:26:13 -0400
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Trisal, Kalhan" <kalhan.trisal@intel.com>, "Huded, Ashok V" <ashok.v.huded@intel.com>, "Ds, Sreedhara" <sreedhara.ds@intel.com>

--_002_0AE3E14D83C76F4994657326177D1FF9631330FFbgsmsx501garcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hello,

Resubmitting the patch. Changes include comments from Dmitry Torokhov [dmit=
ry.torokhov@gmail.com]
Summary of changes:
1. Kill this default line.
        =3D> Corrected
2. To compile this driver as a module...
        =3D> Corrected
3. dev_dbg()?, dev_err()?
        =3D> Local debug print utility is replaced by dev_dbg and dev_err
4. Unused variables removed from struct mrstouch_dev
5. Why global? Can't we write our drivers so they support multiple devices =
even though platform may only have one?
        =3D>Global static struct mrstouch_dev *mrstouchdevp removed and cor=
rected as per the suggestion to support multiple devices
6. input_sync(); not required after reporting button action events. input_s=
ync() is enough after reporting X,Y values
7. -ENOMEM, -EINVAL used as per the suggestion
8. Who is unregistering input device on request_irq() failure?
        =3D>Code added to handle unregistering input device on request_irq(=
) failure
9. 'suspended' is boolean, so please use 'true' and 'false'. However, what =
is the point of these 2 functions anyway?
        =3D>These functions are not required and are removed
10. Do not call input_free_device() after calling input_unregister_device()
        =3D>Corrected
11. Why do you mange retrun value of spi_register_driver()?
        =3D>Corrected
12. No need for empty "return" statements.
        =3D>Corrected
13. Delayed work queue is replaced by kernel thread to process PENDET inter=
rupts



>From ad032521ce86602fd83f313878b25c8fadb66b09 Mon Sep 17 00:00:00 2001
From: Sreedhara DS <sreedhara.ds@intel.com>
Date: Wed, 2 Sep 2009 10:44:19 +0530
Subject: [PATCH] Resistive touch screen driver for Intel Moorestown platfor=
m
 Driver works with NEC, MAXIM and FreeScale PMICs
 Tested with moblin mrstouch Xorg touchscreen driver

        modified:   Kconfig
        modified:   Makefile
        new file:   mrstouch.c

Signed-off-by: Sreedhara DS <sreedhara.ds@intel.com>
---
 drivers/input/touchscreen/Kconfig    |    9 +
 drivers/input/touchscreen/Makefile   |    1 +
 drivers/input/touchscreen/mrstouch.c |  896 ++++++++++++++++++++++++++++++=
++++
 3 files changed, 906 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/touchscreen/mrstouch.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/=
Kconfig
index 72e2712..0fa31e9 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -498,4 +498,13 @@ config TOUCHSCREEN_W90X900
          To compile this driver as a module, choose M here: the
          module will be called w90p910_ts.

+config TOUCHSCREEN_MRSTOUCH
+       tristate "Intel Moorestown Resistive touchscreen"
+       depends on LANGWELL_IPC && SPI_MRST
+       default y
+       help
+         Say Y here if you have a Intel Moorstown platform
+
+         To compile this driver as a module, choose M here: the
+         module will be called mrstouch.
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
index 0000000..0a50e87
--- /dev/null
+++ b/drivers/input/touchscreen/mrstouch.c
@@ -0,0 +1,896 @@
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
+#include <linux/kthread.h>
+#include <asm/mrst_ipcdefs.h>
+
+MODULE_AUTHOR("Sreedhara Murthy. D.S, sreedhara.ds@intel.com");
+MODULE_DESCRIPTION("Intel Moorestown Resistive Touch Screen Driver");
+MODULE_LICENSE("GPL");
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
+       struct semaphore lock; /* Sync between interrupt and PENDET handler=
 */
+       bool            busy; /* Busy flag */
+       u16             asr; /* Address selection register */
+       int             irq;    /* Touch screen IRQ # */
+       uint            vendor;  /* PMIC vendor */
+       uint            rev;  /* PMIC revision */
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
+static int mrstouch_chan_parse(struct mrstouch_dev *tsdev)
+{
+       int err, i, j, chan, found;
+       struct mrst_pmic_reg_data pdata;
+
+       pdata.ioc =3D 1;
+
+       found =3D -1;
+       pdata.num_entries =3D 4;
+
+       for (i =3D 0; i < MRSTOUCH_MAX_CHANNELS; i++) {
+               if (found >=3D 0)
+                       break;
+
+               for (j =3D 0; j <=3D 3; j++)
+                       pdata.pmic_reg_data[j].register_address =3D PMICADD=
R0+i;
+
+               err =3D mrst_pmic_ioread(&pdata);
+               if (err)
+                       return -1;
+
+               for (j =3D 0; j < pdata.num_entries; j++) {
+                       chan =3D pdata.pmic_reg_data[j].value;
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
+       if (tsdev->vendor =3D=3D PMIC_VENDOR_FS) {
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
+       start =3D mrstouch_chan_parse(tsdev);
+       if (start =3D=3D -1) {
+               printk(KERN_ERR "Error in parse channels");
+               return start;
+       }
+
+       tsdev->asr =3D start;
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
+static void mrstouch_report_xy(struct mrstouch_dev *tsdev, u16 x, u16 y, u=
16 z)
+{
+       int xdiff, ydiff;
+       bool moving =3D false;
+
+       if (tsdev->pendown && z <=3D TOUCH_PRESSURE) {
+               /* Pen removed, report button release */
+               dev_dbg(&tsdev->spi->dev, "BTN REL(%d)", z);
+               input_report_key(tsdev->input, BTN_TOUCH, 0);
+               tsdev->pendown =3D false;
+
+               tsdev->xmc =3D 0;
+               tsdev->ymc =3D 0;
+               return;
+       }
+
+       xdiff =3D abs(x - tsdev->x);
+       ydiff =3D abs(y - tsdev->y);
+
+       if (xdiff > XMOVE_LIMIT)
+               tsdev->xmc++; /* Increment X move count */
+       if (ydiff > YMOVE_LIMIT)
+               tsdev->ymc++; /* Increment Y move count */
+
+       /*
+       if x and y values changes for XYMOVE_CNT readings it is considered
+       as stylus is moving. This is required to differentiate between styl=
us
+       movement and jitter
+       */
+       if (tsdev->xmc > XYMOVE_CNT || tsdev->ymc > XYMOVE_CNT)
+               moving =3D true; /* Stylus is moving */
+
+       if (x < MIN_X || x > MAX_X || y < MIN_Y || y > MAX_Y) {
+               /* Spurious values, release button if touched and return */
+               if (tsdev->pendown) {
+                       dev_dbg(&tsdev->spi->dev, "BTN REL(%d)", z);
+                       input_report_key(tsdev->input, BTN_TOUCH, 0);
+                       tsdev->pendown =3D false;
+                       tsdev->xmc =3D 0;
+                       tsdev->ymc =3D 0;
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
+               tsdev->x =3D x;
+               tsdev->y =3D y;
+       }
+
+       input_report_abs(tsdev->input, ABS_X, x);
+       input_report_abs(tsdev->input, ABS_Y, y);
+       input_sync(tsdev->input);
+
+       if (!tsdev->pendown && z > TOUCH_PRESSURE) {
+               /* Pen touched, report button touch */
+               dev_dbg(&tsdev->spi->dev, "BTN TCH(%d, %d, %d)", x, y, z);
+               input_report_key(tsdev->input, BTN_TOUCH, 1);
+               tsdev->pendown =3D true;
+       }
+}
+
+
+/* Utility to start ADC, used by freescale handler */
+static int pendet_mask(uint mask)
+{
+       int err =3D 0;
+       struct mrst_pmic_mod_reg_data adc_data;
+
+       adc_data.ioc =3D 1;
+       adc_data.num_entries =3D 1;
+       adc_data.pmic_mod_reg_data[1].register_address =3D PMIC_REG_MADCINT=
;
+       adc_data.pmic_mod_reg_data[1].bit_map =3D 0x02;
+       adc_data.pmic_mod_reg_data[1].value =3D mask;
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
+       dev_dbg(&tsdev->spi->dev, "X: %d, Y: %d, Z: %d", x, y, z);
+
+       if (z >=3D TOUCH_PRESSURE_FS) { /* Pen Removed */
+               mrstouch_report_xy(tsdev, x, y, TOUCH_PRESSURE - 1);
+               return TOUCH_PRESSURE - 1;
+       } else { /* Pen Touched */
+               mrstouch_report_xy(tsdev, x, y, TOUCH_PRESSURE + 1);
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
+       mrstouch_report_xy(tsdev, xp, yp, zp); /* report x and y to eventX =
*/
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
+int mrstouch_pendet(void *data)
+{
+       struct mrstouch_dev *tsdev =3D (struct mrstouch_dev *)data;
+
+       while (1) {
+               down(&tsdev->lock); /* Wait for PENDET interrupt */
+
+               if (tsdev->busy)
+                       return 0;
+
+               tsdev->busy =3D true;
+
+               if (tsdev->vendor =3D=3D PMIC_VENDOR_NEC ||
+                       tsdev->vendor =3D=3D PMIC_VENDOR_MAXIM) {
+                       /* PENDET must be disabled in NEC before reading AD=
C */
+                       pendet_enable(false); /* Disbale PENDET */
+                       pmic12_pendet(tsdev);
+                       pendet_enable(true); /*Enable PENDET */
+               } else if (tsdev->vendor =3D=3D PMIC_VENDOR_FS) {
+                       pendet_mask(0); /* Disable PENDET */
+                       pmic0_pendet(tsdev);
+                       pendet_mask(1); /* Enable PENDET */
+               } else
+                       printk(KERN_ERR "Unknown PMIC, Not supported\n");
+
+               tsdev->busy =3D false;
+       }
+
+       return 0;
+}
+
+/* PENDET interrupt handler */
+static irqreturn_t pendet_intr_handler(int irq, void *handle)
+{
+       struct mrstouch_dev *tsdev =3D (struct mrstouch_dev *)handle;
+       up(&tsdev->lock);
+
+       return IRQ_HANDLED;
+}
+
+/* Intializes input device and registers with input subsystem */
+static int ts_input_dev_init(struct mrstouch_dev *tsdev, struct spi_device=
 *spi)
+{
+       int err =3D 0;
+
+       tsdev->input =3D input_allocate_device();
+       if (!tsdev->input) {
+               dev_err(&tsdev->spi->dev, "%s", "Input dev allocation faile=
d");
+               return -ENOMEM;
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
+               dev_err(&tsdev->spi->dev, "%s", "Input dev register failed"=
);
+               input_free_device(tsdev->input);
+               return err;
+       }
+
+       dev_dbg(&tsdev->spi->dev, "%s", "mrstouch initialized");
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
+       myirq =3D mrstouch_spi->irq;
+
+       if (!mrstouch_spi->irq) {
+               dev_err(&mrstouch_spi->dev, "%s(%d)", "No IRQ", myirq);
+               return -EINVAL;
+       }
+
+       tsdev =3D kzalloc(sizeof(struct mrstouch_dev), GFP_KERNEL);
+       if (!tsdev) {
+               dev_err(&tsdev->spi->dev, "%s", "ERROR: Memory failure");
+               return -ENOMEM;
+       }
+
+       tsdev->irq =3D myirq;
+
+       err =3D ts_input_dev_init(tsdev, mrstouch_spi);
+       if (err) {
+               dev_err(&tsdev->spi->dev, "%s", "ts_input_dev_init failed")=
;
+               kfree(tsdev);
+               return err;
+       }
+
+       err =3D mrstouch_adc_init(tsdev);
+       if (err) {
+               dev_err(&tsdev->spi->dev, "%s", "ADC init failed");
+               goto mrstouch_error;
+       }
+
+       dev_set_drvdata(&mrstouch_spi->dev, tsdev);
+       tsdev->spi =3D mrstouch_spi;
+
+       sema_init(&tsdev->lock, 1);
+       down(&tsdev->lock);
+
+       tsdev->pendet_thrd =3D kthread_run(mrstouch_pendet,
+                                       (void *)tsdev, "pendet handler");
+       if (IS_ERR(tsdev->pendet_thrd)) {
+               dev_err(&tsdev->spi->dev, "kthread_run failed \n");
+               goto mrstouch_error;
+       }
+
+       dev_dbg(&tsdev->spi->dev, "Requesting IRQ-%d", myirq);
+       err =3D request_irq(myirq, pendet_intr_handler,
+                               0, "mrstouch", tsdev);
+       if (err) {
+               dev_err(&tsdev->spi->dev, "IRQ Request Failed - %d", err);
+               goto mrstouch_error;
+       }
+
+       dev_dbg(&tsdev->spi->dev, "%s", "Driver initialized");
+
+       return 0;
+
+ mrstouch_error:
+       input_unregister_device(tsdev->input);
+       kfree(tsdev);
+       return -1;
+}
+
+static __devexit int mrstouch_remove(struct spi_device *spi)
+{
+       free_irq(mrstouchdevp->irq, mrstouchdevp);
+       input_unregister_device(mrstouchdevp->input);
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
+       .remove         =3D __devexit_p(mrstouch_remove),
+};
+
+static int __init mrstouch_module_init(void)
+{
+       return spi_register_driver(&mrstouch_driver);
+}
+
+static void __exit mrstouch_module_exit(void)
+{
+       spi_unregister_driver(&mrstouch_driver);
+}
+
+module_init(mrstouch_module_init);
+module_exit(mrstouch_module_exit);
--
1.5.4.5

--_002_0AE3E14D83C76F4994657326177D1FF9631330FFbgsmsx501garcor_
Content-Type: application/octet-stream;
	name="0001-Resistive-touch-screen-driver-for-Intel-Moorestown-p.patch"
Content-Description: 0001-Resistive-touch-screen-driver-for-Intel-Moorestown-p.patch
Content-Disposition: attachment;
	filename="0001-Resistive-touch-screen-driver-for-Intel-Moorestown-p.patch";
	size=27351; creation-date="Wed, 02 Sep 2009 10:49:06 GMT";
	modification-date="Wed, 02 Sep 2009 10:49:06 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhZDAzMjUyMWNlODY2MDJmZDgzZjMxMzg3OGIyNWM4ZmFkYjY2YjA5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogU3JlZWRoYXJhIERTIDxzcmVlZGhhcmEuZHNAaW50ZWwuY29t
Pg0KRGF0ZTogV2VkLCAyIFNlcCAyMDA5IDEwOjQ0OjE5ICswNTMwDQpTdWJqZWN0OiBbUEFUQ0hd
IFJlc2lzdGl2ZSB0b3VjaCBzY3JlZW4gZHJpdmVyIGZvciBJbnRlbCBNb29yZXN0b3duIHBsYXRm
b3JtDQogRHJpdmVyIHdvcmtzIHdpdGggTkVDLCBNQVhJTSBhbmQgRnJlZVNjYWxlIFBNSUNzDQog
VGVzdGVkIHdpdGggbW9ibGluIG1yc3RvdWNoIFhvcmcgdG91Y2hzY3JlZW4gZHJpdmVyDQoNCglt
b2RpZmllZDogICBLY29uZmlnDQoJbW9kaWZpZWQ6ICAgTWFrZWZpbGUNCgluZXcgZmlsZTogICBt
cnN0b3VjaC5jDQoNClNpZ25lZC1vZmYtYnk6IFNyZWVkaGFyYSBEUyA8c3JlZWRoYXJhLmRzQGlu
dGVsLmNvbT4NCi0tLQ0KIGRyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vS2NvbmZpZyAgICB8ICAg
IDkgKw0KIGRyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vTWFrZWZpbGUgICB8ICAgIDEgKw0KIGRy
aXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vbXJzdG91Y2guYyB8ICA4OTYgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KIDMgZmlsZXMgY2hhbmdlZCwgOTA2IGluc2VydGlvbnMoKyks
IDAgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvaW5wdXQvdG91Y2hz
Y3JlZW4vbXJzdG91Y2guYw0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVl
bi9LY29uZmlnIGIvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9LY29uZmlnDQppbmRleCA3MmUy
NzEyLi4wZmEzMWU5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9LY29u
ZmlnDQorKysgYi9kcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL0tjb25maWcNCkBAIC00OTgsNCAr
NDk4LDEzIEBAIGNvbmZpZyBUT1VDSFNDUkVFTl9XOTBYOTAwDQogCSAgVG8gY29tcGlsZSB0aGlz
IGRyaXZlciBhcyBhIG1vZHVsZSwgY2hvb3NlIE0gaGVyZTogdGhlDQogCSAgbW9kdWxlIHdpbGwg
YmUgY2FsbGVkIHc5MHA5MTBfdHMuDQogDQorY29uZmlnIFRPVUNIU0NSRUVOX01SU1RPVUNIDQor
CXRyaXN0YXRlICJJbnRlbCBNb29yZXN0b3duIFJlc2lzdGl2ZSB0b3VjaHNjcmVlbiINCisJZGVw
ZW5kcyBvbiBMQU5HV0VMTF9JUEMgJiYgU1BJX01SU1QNCisJZGVmYXVsdCB5DQorCWhlbHANCisJ
ICBTYXkgWSBoZXJlIGlmIHlvdSBoYXZlIGEgSW50ZWwgTW9vcnN0b3duIHBsYXRmb3JtDQorDQor
CSAgVG8gY29tcGlsZSB0aGlzIGRyaXZlciBhcyBhIG1vZHVsZSwgY2hvb3NlIE0gaGVyZTogdGhl
DQorCSAgbW9kdWxlIHdpbGwgYmUgY2FsbGVkIG1yc3RvdWNoLg0KIGVuZGlmDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9NYWtlZmlsZSBiL2RyaXZlcnMvaW5wdXQvdG91
Y2hzY3JlZW4vTWFrZWZpbGUNCmluZGV4IDNlMWM1ZTAuLjliNjdjMTcgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL01ha2VmaWxlDQorKysgYi9kcml2ZXJzL2lucHV0L3Rv
dWNoc2NyZWVuL01ha2VmaWxlDQpAQCAtNDAsMyArNDAsNCBAQCBvYmotJChDT05GSUdfVE9VQ0hT
Q1JFRU5fV005N1hYX0FUTUVMKQkrPSBhdG1lbC13bTk3eHgubw0KIG9iai0kKENPTkZJR19UT1VD
SFNDUkVFTl9XTTk3WFhfTUFJTlNUT05FKQkrPSBtYWluc3RvbmUtd205N3h4Lm8NCiBvYmotJChD
T05GSUdfVE9VQ0hTQ1JFRU5fV005N1hYX1pZTE9OSVRFKQkrPSB6eWxvbml0ZS13bTk3eHgubw0K
IG9iai0kKENPTkZJR19UT1VDSFNDUkVFTl9XOTBYOTAwKQkrPSB3OTBwOTEwX3RzLm8NCitvYmot
JChDT05GSUdfVE9VQ0hTQ1JFRU5fTVJTVE9VQ0gpICAgICs9IG1yc3RvdWNoLm8NCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL21yc3RvdWNoLmMgYi9kcml2ZXJzL2lucHV0
L3RvdWNoc2NyZWVuL21yc3RvdWNoLmMNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAw
MDAwLi4wYTUwZTg3DQotLS0gL2Rldi9udWxsDQorKysgYi9kcml2ZXJzL2lucHV0L3RvdWNoc2Ny
ZWVuL21yc3RvdWNoLmMNCkBAIC0wLDAgKzEsODk2IEBADQorLyoNCisgKiBtcnN0b3VjaC5jIC0g
SW50ZWwgTW9vcmVzdG93biBSZXNpc3RpdmUgVG91Y2ggU2NyZWVuIERyaXZlcg0KKyAqDQorICog
Q29weXJpZ2h0IChDKSAyMDA4IEludGVsIENvcnANCisgKg0KKyAqIH5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
DQorICoNCisgKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3Ry
aWJ1dGUgaXQgYW5kL29yIG1vZGlmeQ0KKyAqIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05V
IEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5DQorICogdGhlIEZyZWUgU29m
dHdhcmUgRm91bmRhdGlvbjsgdmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLg0KKyAqDQorICogVGhp
cyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2Vm
dWwsIGJ1dA0KKyAqIFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxp
ZWQgd2FycmFudHkgb2YNCisgKiBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJU
SUNVTEFSIFBVUlBPU0UuCVNlZSB0aGUgR05VDQorICogR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBm
b3IgbW9yZSBkZXRhaWxzLg0KKyAqDQorICogWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29w
eSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYWxvbmcNCisgKiB3aXRoIHRoaXMg
cHJvZ3JhbTsgaWZub3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24sIElu
Yy4sDQorICogNTkgVGVtcGxlIFBsYWNlLCBTdWl0ZSAzMzAsIEJvc3RvbiwgTUEgMDIxMTEtMTMw
NyBVU0EuDQorICoNCisgKiBRdWVzdGlvbnMvQ29tbWVudHMvQnVnIGZpeGVzIHRvIFNyZWVkaGFy
YSAoc3JlZWRoYXJhLmRzQGludGVsLmNvbSkNCisgKiB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KKyAqLw0K
KyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCisjaW5jbHVkZSA8bGludXgvaW5pdC5oPg0KKyNp
bmNsdWRlIDxsaW51eC9pbnB1dC5oPg0KKyNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4NCisj
aW5jbHVkZSA8bGludXgvZXJyLmg+DQorI2luY2x1ZGUgPGxpbnV4L3BhcmFtLmg+DQorI2luY2x1
ZGUgPGxpbnV4L3NwaS9zcGkuaD4NCisjaW5jbHVkZSA8bGludXgvaXJxLmg+DQorI2luY2x1ZGUg
PGxpbnV4L2RlbGF5Lmg+DQorI2luY2x1ZGUgPGxpbnV4L2t0aHJlYWQuaD4NCisjaW5jbHVkZSA8
YXNtL21yc3RfaXBjZGVmcy5oPg0KKw0KK01PRFVMRV9BVVRIT1IoIlNyZWVkaGFyYSBNdXJ0aHku
IEQuUywgc3JlZWRoYXJhLmRzQGludGVsLmNvbSIpOw0KK01PRFVMRV9ERVNDUklQVElPTigiSW50
ZWwgTW9vcmVzdG93biBSZXNpc3RpdmUgVG91Y2ggU2NyZWVuIERyaXZlciIpOw0KK01PRFVMRV9M
SUNFTlNFKCJHUEwiKTsNCisNCisvKiBQTUlDIEludGVycnVwdCByZWdpc3RlcnMgKi8NCisjZGVm
aW5lIFBNSUNfUkVHX0lEMSAgIDB4MDAgLypQTUlDIElEMSByZWdpc3RlciAqLw0KKw0KKy8qIFBN
SUMgSW50ZXJydXB0IHJlZ2lzdGVycyAqLw0KKyNkZWZpbmUgUE1JQ19SRUdfSU5UICAgMHgwNCAv
KlBNSUMgaW50ZXJydXB0IHJlZ2lzdGVyICovDQorI2RlZmluZSBQTUlDX1JFR19NSU5UICAweDA1
IC8qUE1JQyBpbnRlcnJ1cHQgbWFzayByZWdpc3RlciAqLw0KKw0KKy8qIEFEQyBJbnRlcnJ1cHQg
cmVnaXN0ZXJzICovDQorI2RlZmluZSBQTUlDX1JFR19BRENJTlQgICAweDVGIC8qQURDIGludGVy
cnVwdCByZWdpc3RlciAqLw0KKyNkZWZpbmUgUE1JQ19SRUdfTUFEQ0lOVCAgMHg2MCAvKkFEQyBp
bnRlcnJ1cHQgbWFzayByZWdpc3RlciAqLw0KKw0KKy8qIEFEQyBDb250cm9sIHJlZ2lzdGVycyAq
Lw0KKyNkZWZpbmUgUE1JQ19SRUdfQURDQ05UTDEgICAgMHg2MSAvKkFEQyBjb250cm9sIHJlZ2lz
dGVyICovDQorDQorLyogQURDIENoYW5uZWwgU2VsZWN0aW9uIHJlZ2lzdGVycyAqLw0KKyNkZWZp
bmUgUE1JQ0FERFIwICAgICAweEE0DQorI2RlZmluZSBFTkRfT0ZfQ0hBTk5FTCAweDFGDQorDQor
LyogQURDIFJlc3VsdCByZWdpc3RlciAqLw0KKyNkZWZpbmUgUE1JQ19SRUdfQURDU05TMEggICAw
eDY0DQorDQorLyogQURDIGNoYW5uZWxzIGZvciB0b3VjaCBzY3JlZW4gKi8NCisjZGVmaW5lIE1S
U1RfVFNfQ0hBTjEwICAgMHhBIC8qIFRvdWNoIHNjcmVlbiBYKyBjb25uZWN0aW9uICovDQorI2Rl
ZmluZSBNUlNUX1RTX0NIQU4xMSAgIDB4QiAvKiBUb3VjaCBzY3JlZW4gWC0gY29ubmVjdGlvbiAq
Lw0KKyNkZWZpbmUgTVJTVF9UU19DSEFOMTIgICAweEMgLyogVG91Y2ggc2NyZWVuIFkrIGNvbm5l
Y3Rpb24gKi8NCisjZGVmaW5lIE1SU1RfVFNfQ0hBTjEzICAgMHhEIC8qIFRvdWNoIHNjcmVlbiBZ
LSBjb25uZWN0aW9uICovDQorDQorLyogVG91Y2ggc2NyZWVuIGNvb3JkaW5hdGUgY29uc3RhbnRz
ICovDQorI2RlZmluZSBUT1VDSF9QUkVTU1VSRSAgIAk1DQorI2RlZmluZSBUT1VDSF9QUkVTU1VS
RV9GUwkxMDANCisNCisjZGVmaW5lIFhNT1ZFX0xJTUlUCTUNCisjZGVmaW5lIFlNT1ZFX0xJTUlU
CTUNCisjZGVmaW5lIFhZTU9WRV9DTlQJMw0KKw0KKyNkZWZpbmUgTUFYXzEwQklUCSgoMTw8MTAp
LTEpDQorDQorLyogVG91Y2ggc2NyZWVuIGNoYW5uZWwgQklBUyBjb25zdGFudHMgKi8NCisjZGVm
aW5lIFhCSUFTCQkweDIwDQorI2RlZmluZSBZQklBUwkJMHg0MA0KKyNkZWZpbmUgWkJJQVMJCTB4
ODANCisNCisvKiBUb3VjaCBzY3JlZW4gY29vcmRpbmF0ZXMgKi8NCisjZGVmaW5lIE1JTl9YCQkx
MA0KKyNkZWZpbmUgTUFYX1gJCTEwMjQNCisjZGVmaW5lIE1JTl9ZCQkxMA0KKyNkZWZpbmUgTUFY
X1kJCTEwMjQNCisjZGVmaW5lIFdBSVRfQURDX0NPTVBMRVRJT04gMTANCisNCisvKiBQTUlDIEFE
QyByb3VuZCByb2JpbiBkZWxheXMgKi8NCisjZGVmaW5lIEFEQ19MT09QX0RFTEFZMCAweDAgLyog
Q29udGludW91cyBsb29wICovDQorI2RlZmluZSBBRENfTE9PUF9ERUxBWTEgMHgxIC8qIDQuNSAg
bXMgYXBwcm94aW1hdGUgKi8NCisNCisvKiBQTUlDIFZlbmRvciBJZGVudGlmaWVycyAqLw0KKyNk
ZWZpbmUgUE1JQ19WRU5ET1JfRlMgIDAgLyogUE1JQyB2ZW5kb3IgRnJlZVNjYWxlICovDQorI2Rl
ZmluZSBQTUlDX1ZFTkRPUl9NQVhJTSAxIC8qIFBNSUMgdmVuZG9yIE1BWElNICovDQorI2RlZmlu
ZSBQTUlDX1ZFTkRPUl9ORUMgMiAvKiBQTUlDIHZlbmRvciBORUMgKi8NCisjZGVmaW5lIE1SU1RP
VUNIX01BWF9DSEFOTkVMUyAzMiAvKiBNYXhpbXVtIEFEQyBjaGFubmVscyAqLw0KKw0KKy8qIFRv
dWNoIHNjcmVlbiBkZXZpY2Ugc3RydWN0dXJlICovDQorc3RydWN0IG1yc3RvdWNoX2RldiB7DQor
CXN0cnVjdCBzcGlfZGV2aWNlICpzcGk7IC8qIFNQSSBkZXZpY2UgYXNzb2NpYXRlZCB3aXRoIHRv
dWNoIHNjcmVlbiAqLw0KKwlzdHJ1Y3QgaW5wdXRfZGV2ICppbnB1dDsgLyogaW5wdXQgZGV2aWNl
IGZvciB0b3VjaHNjcmVlbiovDQorCWNoYXIgCQlwaHlzWzMyXTsgLyogRGV2aWNlIG5hbWUgKi8N
CisJc3RydWN0IHRhc2tfc3RydWN0ICpwZW5kZXRfdGhyZDsgLyogUEVOREVUIGludGVycnVwdCBo
YW5kbGVyICovDQorCXN0cnVjdCBzZW1hcGhvcmUgbG9jazsgLyogU3luYyBiZXR3ZWVuIGludGVy
cnVwdCBhbmQgUEVOREVUIGhhbmRsZXIgKi8NCisJYm9vbAkJYnVzeTsgLyogQnVzeSBmbGFnICov
DQorCXUxNiAgICAgICAgICAgICBhc3I7IC8qIEFkZHJlc3Mgc2VsZWN0aW9uIHJlZ2lzdGVyICov
DQorCWludCAgICAgICAgICAgICBpcnE7ICAgIC8qIFRvdWNoIHNjcmVlbiBJUlEgIyAqLw0KKwl1
aW50CQl2ZW5kb3I7ICAvKiBQTUlDIHZlbmRvciAqLw0KKwl1aW50CQlyZXY7ICAvKiBQTUlDIHJl
dmlzaW9uICovDQorCXUxNgkJeDsgIC8qIFggY29vcmRpbmF0ZSAqLw0KKwl1MTYJCXk7ICAvKiBZ
IGNvb3JkaW5hdGUgKi8NCisJYm9vbAkJcGVuZG93bjsgIC8qIFBFTiBwb3NpdGlvbiAqLw0KKwl1
aW50CQl4bWM7ICAvKiBYbW92ZSBjb3VudCAqLw0KKwl1aW50CQl5bWM7ICAvKiBYbW92ZSBjb3Vu
dCAqLw0KK30gOw0KKw0KKw0KKy8qIEdsb2JhbCBQb2ludGVyIHRvIFRvdWNoIHNjcmVlbiBkZXZp
Y2UgKi8NCitzdGF0aWMgc3RydWN0IG1yc3RvdWNoX2RldiAqbXJzdG91Y2hkZXZwOw0KKw0KKy8q
IFV0aWxpdHkgdG8gcmVhZCBQTUlDIElEICovDQorc3RhdGljIGludCBtcnN0b3VjaF9wbWljX2lk
KHVpbnQgKnZlbmRvciwgdWludCAqcmV2KQ0KK3sNCisJaW50IGVycjsNCisJc3RydWN0IG1yc3Rf
cG1pY19yZWdfZGF0YSBhZGNfZGF0YTsNCisNCisJYWRjX2RhdGEuaW9jID0gMTsNCisJYWRjX2Rh
dGEubnVtX2VudHJpZXMgPSAxOw0KKwlhZGNfZGF0YS5wbWljX3JlZ19kYXRhWzBdLnJlZ2lzdGVy
X2FkZHJlc3MgPSBQTUlDX1JFR19JRDE7DQorDQorCWVyciA9IG1yc3RfcG1pY19pb3JlYWQoJmFk
Y19kYXRhKTsNCisJaWYgKGVycikNCisJCXJldHVybiAtMTsNCisNCisJKnZlbmRvciA9IChhZGNf
ZGF0YS5wbWljX3JlZ19kYXRhWzBdLnZhbHVlKSAmIDB4NzsNCisJKnJldiA9IChhZGNfZGF0YS5w
bWljX3JlZ19kYXRhWzBdLnZhbHVlID4+IDMpICYgMHg3Ow0KKw0KKwlyZXR1cm4gMDsNCit9DQor
DQorLyoNCisgKiBQYXJzZSBBREMgY2hhbm5lbHMgdG8gZmluZCBlbmQgb2YgdGhlIGNoYW5uZWwg
Y29uZmlndXJlZCBieSBvdGhlciBBREMgdXNlcg0KKyAqIE5FQyBhbmQgTUFYSU0gcmVxdWlyZXMg
NCBjaGFubmVscyBhbmQgRnJlZVNjYWxlIG5lZWRzIDE4IGNoYW5uZWxzDQorICovDQorc3RhdGlj
IGludCBtcnN0b3VjaF9jaGFuX3BhcnNlKHN0cnVjdCBtcnN0b3VjaF9kZXYgKnRzZGV2KQ0KK3sN
CisJaW50IGVyciwgaSwgaiwgY2hhbiwgZm91bmQ7DQorCXN0cnVjdCBtcnN0X3BtaWNfcmVnX2Rh
dGEgcGRhdGE7DQorDQorCXBkYXRhLmlvYyA9IDE7DQorDQorCWZvdW5kID0gLTE7DQorCXBkYXRh
Lm51bV9lbnRyaWVzID0gNDsNCisNCisJZm9yIChpID0gMDsgaSA8IE1SU1RPVUNIX01BWF9DSEFO
TkVMUzsgaSsrKSB7DQorCQlpZiAoZm91bmQgPj0gMCkNCisJCQlicmVhazsNCisNCisJCWZvciAo
aiA9IDA7IGogPD0gMzsgaisrKQ0KKwkJCXBkYXRhLnBtaWNfcmVnX2RhdGFbal0ucmVnaXN0ZXJf
YWRkcmVzcyA9IFBNSUNBRERSMCtpOw0KKw0KKwkJZXJyID0gbXJzdF9wbWljX2lvcmVhZCgmcGRh
dGEpOw0KKwkJaWYgKGVycikNCisJCQlyZXR1cm4gLTE7DQorDQorCQlmb3IgKGogPSAwOyBqIDwg
cGRhdGEubnVtX2VudHJpZXM7IGorKykgew0KKwkJCWNoYW4gPSBwZGF0YS5wbWljX3JlZ19kYXRh
W2pdLnZhbHVlOw0KKwkJCWlmIChjaGFuID09IEVORF9PRl9DSEFOTkVMKSB7DQorCQkJCWZvdW5k
ID0gaTsNCisJCQkJYnJlYWs7DQorCQkJfQ0KKwkJfQ0KKwl9DQorDQorCWlmIChmb3VuZCA8IDAp
DQorCQlyZXR1cm4gMDsNCisNCisJaWYgKHRzZGV2LT52ZW5kb3IgPT0gUE1JQ19WRU5ET1JfRlMp
IHsNCisJCWlmIChmb3VuZCAmJiBmb3VuZCA+IChNUlNUT1VDSF9NQVhfQ0hBTk5FTFMgLSAxOCkp
DQorCQkJcmV0dXJuIC0xOw0KKwl9IGVsc2Ugew0KKwkJaWYgKGZvdW5kICYmIGZvdW5kID4gKE1S
U1RPVUNIX01BWF9DSEFOTkVMUyAtIDQpKQ0KKwkJCXJldHVybiAtMTsNCisJfQ0KKwlyZXR1cm4g
Zm91bmQ7DQorfQ0KKw0KKy8qIFV0aWxpdHkgdG8gZW5hYmxlL2Rpc2FibGUgcGVuZGV0Lg0KKyAq
IHBlbmRldCBzZXQgdG8gdHJ1ZSBlbmFibGVzIFBFTkRFVCBpbnRlcnJ1cHQNCisgKiBwZW5kZXQg
c2V0IHRvIGZhbHNlIGRpc2FibGVzIFBFTkRFVCBpbnRlcnJ1cHQNCisgKiBBbHNvIGNsZWFycyBS
TkQgbWFzayBiaXQNCisqLw0KK3N0YXRpYyB2b2lkIHBlbmRldF9lbmFibGUoYm9vbCBwZW5kZXQp
DQorew0KKwl1OCBhZGNjbnRybDEgPSAwOw0KKwl1OCBwZW5kZXRfZW5hYmxlZCA9IDA7DQorCWlu
dCByZXRyeSA9IDA7DQorCXN0cnVjdCBtcnN0X3BtaWNfcmVnX2RhdGEgYWRjX2RhdGE7DQorDQor
CWFkY19kYXRhLmlvYyA9IDE7DQorDQorCWFkY19kYXRhLm51bV9lbnRyaWVzID0gMTsNCisJYWRj
X2RhdGEucG1pY19yZWdfZGF0YVswXS5yZWdpc3Rlcl9hZGRyZXNzID0gUE1JQ19SRUdfQURDQ05U
TDE7DQorCW1yc3RfcG1pY19pb3JlYWQoJmFkY19kYXRhKTsNCisJYWRjY250cmwxID0gYWRjX2Rh
dGEucG1pY19yZWdfZGF0YVswXS52YWx1ZTsNCisNCisJaWYgKHBlbmRldCkNCisJCWFkY2NudHJs
MSB8PSAweDIwOyAvKiBFbmFibGUgcGVuZGV0ICovDQorCWVsc2UNCisJCWFkY2NudHJsMSAmPSAw
eERGOyAvKiBEaXNhYmxlIHBlbmRldCAqLw0KKw0KKwlhZGNfZGF0YS5udW1fZW50cmllcyA9IDI7
DQorCWFkY19kYXRhLnBtaWNfcmVnX2RhdGFbMF0ucmVnaXN0ZXJfYWRkcmVzcyA9IFBNSUNfUkVH
X01BRENJTlQ7DQorCWFkY19kYXRhLnBtaWNfcmVnX2RhdGFbMF0udmFsdWUgPSAweDA7DQorCWFk
Y19kYXRhLnBtaWNfcmVnX2RhdGFbMV0ucmVnaXN0ZXJfYWRkcmVzcyA9IFBNSUNfUkVHX0FEQ0NO
VEwxOw0KKwlhZGNfZGF0YS5wbWljX3JlZ19kYXRhWzFdLnZhbHVlID0gYWRjY250cmwxOw0KKwlt
cnN0X3BtaWNfaW93cml0ZSgmYWRjX2RhdGEpOw0KKw0KKwlpZiAoIXBlbmRldCkNCisJCXJldHVy
bjsNCisNCisNCisJLyoNCisJICogU29tZXRpbWVzIGV2ZW4gYWZ0ZXIgbXJzdF9wbWljX2lvd3Jp
dGUgc3VjY2Vzcw0KKwkgKiB0aGUgUE1JQyByZWdpc3RlciB2YWx1ZSBpcyBub3QgdXBkYXRlZC4g
UmV0cnkgZmV3IGl0ZXJhdGlvbnMNCisJICogdG8gZW5hYmxlIHBlbmRldC4NCisJKi8NCisJYWRj
X2RhdGEubnVtX2VudHJpZXMgPSAxOw0KKwlhZGNfZGF0YS5wbWljX3JlZ19kYXRhWzBdLnJlZ2lz
dGVyX2FkZHJlc3MgPSBQTUlDX1JFR19BRENDTlRMMTsNCisJbXJzdF9wbWljX2lvcmVhZCgmYWRj
X2RhdGEpOw0KKwlwZW5kZXRfZW5hYmxlZCA9IChhZGNfZGF0YS5wbWljX3JlZ19kYXRhWzBdLnZh
bHVlID4+IDUpICYgMHgwMTsNCisNCisJcmV0cnkgPSAwOw0KKwl3aGlsZSAoIXBlbmRldF9lbmFi
bGVkKSB7DQorCQlyZXRyeSsrOw0KKwkJbXNsZWVwKDEwKTsNCisJCWFkY19kYXRhLnBtaWNfcmVn
X2RhdGFbMF0ucmVnaXN0ZXJfYWRkcmVzcyA9IFBNSUNfUkVHX0FEQ0NOVEwxOw0KKwkJYWRjX2Rh
dGEucG1pY19yZWdfZGF0YVswXS52YWx1ZSA9IGFkY2NudHJsMTsNCisJCW1yc3RfcG1pY19pb3dy
aXRlKCZhZGNfZGF0YSk7DQorDQorCQlhZGNfZGF0YS5wbWljX3JlZ19kYXRhWzBdLnJlZ2lzdGVy
X2FkZHJlc3MgPSBQTUlDX1JFR19BRENDTlRMMTsNCisJCW1yc3RfcG1pY19pb3JlYWQoJmFkY19k
YXRhKTsNCisJCXBlbmRldF9lbmFibGVkID0gKGFkY19kYXRhLnBtaWNfcmVnX2RhdGFbMF0udmFs
dWUgPj4gNSkgJiAweDAxOw0KKwkJaWYgKHJldHJ5ID49IDEwKSB7DQorCQkJcHJpbnRrKEtFUk5f
RVJSICJUb3VjaCBzY3JlZW4gZGlzYWJsZWRcbiIpOw0KKwkJCWJyZWFrOw0KKwkJfQ0KKwl9DQor
fQ0KKw0KKw0KKy8qIFRvIHJlYWQgUE1JQyBBREMgdG91Y2ggc2NyZWVuIHJlc3VsdA0KKyAqIFJl
YWRzIEFEQyBzdG9yYWdlIHJlZ2lzdGVycyBmb3IgaGlnaGVyIDcgYW5kIGxvd2VyIDMgYml0cw0K
KyAqIGNvbnZlcnRzIHRoZSB0d28gcmVhZGluZ3MgdG8gc2luZ2xlIHZhbHVlIGFuZCB0dXJucyBv
ZmYgZ2FpbiBiaXQNCisgKi8NCitzdGF0aWMgaW50IG1yc3RvdWNoX3RzX2NoYW5fcmVhZCh1MTYg
b2Zmc2V0LCB1MTYgY2hhbiwgdTE2ICp2cCwgdTE2ICp2bSkNCit7DQorCWludCBlcnIsIGNvdW50
Ow0KKwl1MTYgcmVzdWx0Ow0KKwlzdHJ1Y3QgbXJzdF9wbWljX3JlZ19kYXRhCWFkY19kYXRhOw0K
Kw0KKwlhZGNfZGF0YS5pb2MgPSAxOw0KKwlhZGNfZGF0YS5udW1fZW50cmllcyA9IDQ7DQorDQor
CXJlc3VsdCA9IFBNSUNfUkVHX0FEQ1NOUzBIICsgb2Zmc2V0Ow0KKw0KKwlpZiAoY2hhbiA9PSBN
UlNUX1RTX0NIQU4xMikNCisJCXJlc3VsdCArPSA0Ow0KKw0KKwlmb3IgKGNvdW50ID0gMDsgY291
bnQgPD0gMzsgY291bnQrKykNCisJCWFkY19kYXRhLnBtaWNfcmVnX2RhdGFbY291bnRdLnJlZ2lz
dGVyX2FkZHJlc3MgPSByZXN1bHQrKzsNCisNCisJZXJyID0gbXJzdF9wbWljX2lvcmVhZCgmYWRj
X2RhdGEpOw0KKwlpZiAoZXJyKQ0KKwkJcmV0dXJuIC0xOw0KKw0KKwkqdnAgPSBhZGNfZGF0YS5w
bWljX3JlZ19kYXRhWzBdLnZhbHVlIDw8IDM7IC8qIEhpZ2hlciA3IGJpdHMgKi8NCisJKnZwIHw9
IGFkY19kYXRhLnBtaWNfcmVnX2RhdGFbMV0udmFsdWUgJiAweDc7IC8qIExvd2VyIDMgYml0cyAq
Lw0KKwkqdnAgJj0gMHgzRkY7DQorDQorCSp2bSA9IGFkY19kYXRhLnBtaWNfcmVnX2RhdGFbMl0u
dmFsdWUgPDwgMzsgLyogSGlnaGVyIDcgYml0cyAqLw0KKwkqdm0gfD0gYWRjX2RhdGEucG1pY19y
ZWdfZGF0YVszXS52YWx1ZSAmIDB4NzsgLyogTG93ZXIgMyBiaXRzICovDQorCSp2bSAmPSAweDNG
RjsNCisNCisJcmV0dXJuIDA7DQorfQ0KKw0KKy8qIFRvIGNvbmZpZ3VyZSB0b3VjaCBzY3JlZW4g
Y2hhbm5lbHMNCisgKiBXcml0ZXMgdG91Y2ggc2NyZWVuIGNoYW5uZWxzIHRvIEFEQyBhZGRyZXNz
IHNlbGVjdGlvbiByZWdpc3RlcnMNCisgKi8NCitzdGF0aWMgaW50IG1yc3RvdWNoX3RzX2NoYW5f
c2V0KHVpbnQgb2Zmc2V0KQ0KK3sNCisJaW50IGVyciwgY291bnQ7DQorCXUxNiBjaGFuOw0KKwlz
dHJ1Y3QgbXJzdF9wbWljX3JlZ19kYXRhCWFkY19kYXRhOw0KKw0KKwlhZGNfZGF0YS5pb2MgPSAx
Ow0KKwlhZGNfZGF0YS5udW1fZW50cmllcyA9IDU7DQorDQorCWNoYW4gPSBQTUlDQUREUjAgKyBv
ZmZzZXQ7DQorCWZvciAoY291bnQgPSAwOyBjb3VudCA8PSAzOyBjb3VudCsrKSB7DQorCQlhZGNf
ZGF0YS5wbWljX3JlZ19kYXRhW2NvdW50XS5yZWdpc3Rlcl9hZGRyZXNzID0gY2hhbisrOw0KKwkJ
YWRjX2RhdGEucG1pY19yZWdfZGF0YVtjb3VudF0udmFsdWUgPSBNUlNUX1RTX0NIQU4xMCArIGNv
dW50Ow0KKwl9DQorCWFkY19kYXRhLnBtaWNfcmVnX2RhdGFbY291bnRdLnJlZ2lzdGVyX2FkZHJl
c3MgPSBjaGFuOw0KKwlhZGNfZGF0YS5wbWljX3JlZ19kYXRhW2NvdW50XS52YWx1ZSA9IEVORF9P
Rl9DSEFOTkVMOw0KKw0KKwllcnIgPSBtcnN0X3BtaWNfaW93cml0ZSgmYWRjX2RhdGEpOw0KKwlp
ZiAoZXJyKQ0KKwkJcmV0dXJuIC0xOw0KKw0KKwlyZXR1cm4gMDsNCit9DQorDQorLyogSW5pdGlh
bGl6ZSBBREMgKi8NCitzdGF0aWMgaW50IG1yc3RvdWNoX2FkY19pbml0KHN0cnVjdCBtcnN0b3Vj
aF9kZXYgKnRzZGV2KQ0KK3sNCisJaW50IGVyciwgc3RhcnQ7DQorCXN0cnVjdCBtcnN0X3BtaWNf
bW9kX3JlZ19kYXRhIGFkY19kYXRhOw0KKw0KKwllcnIgPSBtcnN0b3VjaF9wbWljX2lkKCZ0c2Rl
di0+dmVuZG9yLCAmdHNkZXYtPnJldik7DQorCWlmIChlcnIpIHsNCisJCXByaW50ayhLRVJOX0VS
UiAiRXJyb3IgaW4gcmVhZGluZyBQTUlDIElkIik7DQorCQlyZXR1cm4gZXJyOw0KKwl9DQorDQor
CXN0YXJ0ID0gbXJzdG91Y2hfY2hhbl9wYXJzZSh0c2Rldik7DQorCWlmIChzdGFydCA9PSAtMSkg
ew0KKwkJcHJpbnRrKEtFUk5fRVJSICJFcnJvciBpbiBwYXJzZSBjaGFubmVscyIpOw0KKwkJcmV0
dXJuIHN0YXJ0Ow0KKwl9DQorDQorCXRzZGV2LT5hc3IgPSBzdGFydDsNCisNCisJLyogQURDIHBv
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
IGV2ZW50IHN1YnN5c3RlbSAqLw0KK3N0YXRpYyB2b2lkIG1yc3RvdWNoX3JlcG9ydF94eShzdHJ1
Y3QgbXJzdG91Y2hfZGV2ICp0c2RldiwgdTE2IHgsIHUxNiB5LCB1MTYgeikNCit7DQorCWludCB4
ZGlmZiwgeWRpZmY7DQorCWJvb2wgbW92aW5nID0gZmFsc2U7DQorDQorCWlmICh0c2Rldi0+cGVu
ZG93biAmJiB6IDw9IFRPVUNIX1BSRVNTVVJFKSB7DQorCQkvKiBQZW4gcmVtb3ZlZCwgcmVwb3J0
IGJ1dHRvbiByZWxlYXNlICovDQorCQlkZXZfZGJnKCZ0c2Rldi0+c3BpLT5kZXYsICJCVE4gUkVM
KCVkKSIsIHopOw0KKwkJaW5wdXRfcmVwb3J0X2tleSh0c2Rldi0+aW5wdXQsIEJUTl9UT1VDSCwg
MCk7DQorCQl0c2Rldi0+cGVuZG93biA9IGZhbHNlOw0KKw0KKwkJdHNkZXYtPnhtYyA9IDA7DQor
CQl0c2Rldi0+eW1jID0gMDsNCisJCXJldHVybjsNCisJfQ0KKw0KKwl4ZGlmZiA9IGFicyh4IC0g
dHNkZXYtPngpOw0KKwl5ZGlmZiA9IGFicyh5IC0gdHNkZXYtPnkpOw0KKw0KKwlpZiAoeGRpZmYg
PiBYTU9WRV9MSU1JVCkNCisJCXRzZGV2LT54bWMrKzsgLyogSW5jcmVtZW50IFggbW92ZSBjb3Vu
dCAqLw0KKwlpZiAoeWRpZmYgPiBZTU9WRV9MSU1JVCkNCisJCXRzZGV2LT55bWMrKzsgLyogSW5j
cmVtZW50IFkgbW92ZSBjb3VudCAqLw0KKw0KKwkvKg0KKwlpZiB4IGFuZCB5IHZhbHVlcyBjaGFu
Z2VzIGZvciBYWU1PVkVfQ05UIHJlYWRpbmdzIGl0IGlzIGNvbnNpZGVyZWQNCisJYXMgc3R5bHVz
IGlzIG1vdmluZy4gVGhpcyBpcyByZXF1aXJlZCB0byBkaWZmZXJlbnRpYXRlIGJldHdlZW4gc3R5
bHVzDQorCW1vdmVtZW50IGFuZCBqaXR0ZXINCisJKi8NCisJaWYgKHRzZGV2LT54bWMgPiBYWU1P
VkVfQ05UIHx8IHRzZGV2LT55bWMgPiBYWU1PVkVfQ05UKQ0KKwkJbW92aW5nID0gdHJ1ZTsgLyog
U3R5bHVzIGlzIG1vdmluZyAqLw0KKw0KKwlpZiAoeCA8IE1JTl9YIHx8IHggPiBNQVhfWCB8fCB5
IDwgTUlOX1kgfHwgeSA+IE1BWF9ZKSB7DQorCQkvKiBTcHVyaW91cyB2YWx1ZXMsIHJlbGVhc2Ug
YnV0dG9uIGlmIHRvdWNoZWQgYW5kIHJldHVybiAqLw0KKwkJaWYgKHRzZGV2LT5wZW5kb3duKSB7
DQorCQkJZGV2X2RiZygmdHNkZXYtPnNwaS0+ZGV2LCAiQlROIFJFTCglZCkiLCB6KTsNCisJCQlp
bnB1dF9yZXBvcnRfa2V5KHRzZGV2LT5pbnB1dCwgQlROX1RPVUNILCAwKTsNCisJCQl0c2Rldi0+
cGVuZG93biA9IGZhbHNlOw0KKwkJCXRzZGV2LT54bWMgPSAwOw0KKwkJCXRzZGV2LT55bWMgPSAw
Ow0KKwkJfQ0KKwkJcmV0dXJuOw0KKwl9IGVsc2UgaWYgKCFtb3ZpbmcgJiYgKHhkaWZmIDw9IFhN
T1ZFX0xJTUlUIHx8IHlkaWZmIDw9IFlNT1ZFX0xJTUlUKSkNCisJCS8qDQorCQlBREMgcmVhZGlu
Z3MgYXJlIGRpZmZlciBieSBzbWFsbCB2YXJpYXRpb25zIGluIGFsdGVybmF0ZQ0KKwkJcmVhZGlu
Z3MuIE11bHRpcGxlIEFEQyByZWFkaW5ncyBhbmQgYXZlcmFnaW5nIHJlc3VsdHMgaW4NCisJCXNs
b3cgcmVzcG9uc2UuIEFsbCBBREMgcmVhZGluZ3MgZmFsbCB3aXRoaW4gbW92ZSBsaW1pdCBhcmUN
CisJCWNvbnNpZGVyZWQgYXMgdmFsdWUgb2YgcHJldmlvdXMgcmVhZGluZy4gVGhpcyBtaW5pbWl6
ZXMgc21hbGwNCisJCW9ic2VydmFibGUgaml0dGVyIGluIG1vdXNlIHBvaW50ZXIgd2hlbiBzdHls
dXMgYXQgZml4ZWQgcG9zaXRpb24NCisJCSovDQorCQlyZXR1cm47DQorCWVsc2Ugew0KKwkJLyog
c2F2ZSB4IGFuZCB5IHZhbHVlcyAqLw0KKwkJdHNkZXYtPnggPSB4Ow0KKwkJdHNkZXYtPnkgPSB5
Ow0KKwl9DQorDQorCWlucHV0X3JlcG9ydF9hYnModHNkZXYtPmlucHV0LCBBQlNfWCwgeCk7DQor
CWlucHV0X3JlcG9ydF9hYnModHNkZXYtPmlucHV0LCBBQlNfWSwgeSk7DQorCWlucHV0X3N5bmMo
dHNkZXYtPmlucHV0KTsNCisNCisJaWYgKCF0c2Rldi0+cGVuZG93biAmJiB6ID4gVE9VQ0hfUFJF
U1NVUkUpIHsNCisJCS8qIFBlbiB0b3VjaGVkLCByZXBvcnQgYnV0dG9uIHRvdWNoICovDQorCQlk
ZXZfZGJnKCZ0c2Rldi0+c3BpLT5kZXYsICJCVE4gVENIKCVkLCAlZCwgJWQpIiwgeCwgeSwgeik7
DQorCQlpbnB1dF9yZXBvcnRfa2V5KHRzZGV2LT5pbnB1dCwgQlROX1RPVUNILCAxKTsNCisJCXRz
ZGV2LT5wZW5kb3duID0gdHJ1ZTsNCisJfQ0KK30NCisNCisNCisvKiBVdGlsaXR5IHRvIHN0YXJ0
IEFEQywgdXNlZCBieSBmcmVlc2NhbGUgaGFuZGxlciAqLw0KK3N0YXRpYyBpbnQgcGVuZGV0X21h
c2sodWludCBtYXNrKQ0KK3sNCisJaW50IGVyciA9IDA7DQorCXN0cnVjdCBtcnN0X3BtaWNfbW9k
X3JlZ19kYXRhIGFkY19kYXRhOw0KKw0KKwlhZGNfZGF0YS5pb2MgPSAxOw0KKwlhZGNfZGF0YS5u
dW1fZW50cmllcyA9IDE7DQorCWFkY19kYXRhLnBtaWNfbW9kX3JlZ19kYXRhWzFdLnJlZ2lzdGVy
X2FkZHJlc3MgPSBQTUlDX1JFR19NQURDSU5UOw0KKwlhZGNfZGF0YS5wbWljX21vZF9yZWdfZGF0
YVsxXS5iaXRfbWFwID0gMHgwMjsNCisJYWRjX2RhdGEucG1pY19tb2RfcmVnX2RhdGFbMV0udmFs
dWUgPSBtYXNrOw0KKw0KKwllcnIgPSBtcnN0X3BtaWNfaW9yZWFkX21vZGlmeSgmYWRjX2RhdGEp
Ow0KKw0KKwlyZXR1cm4gZXJyOw0KK30NCisNCisvKiBVdGlsaXR5IHRvIHJlYWQgQURDLCB1c2Vk
IGJ5IGZyZWVzY2FsZSBoYW5kbGVyICovDQorc3RhdGljIGludCBtcnN0b3VjaF9wbWljX2ZzX2Fk
Y19yZWFkKHN0cnVjdCBtcnN0b3VjaF9kZXYgKnRzZGV2KQ0KK3sNCisJaW50IGVycjsNCisJdTE2
IHgsIHksIHosIHJlc3VsdDsNCisJc3RydWN0IG1yc3RfcG1pY19yZWdfZGF0YSBhZGNfZGF0YTsN
CisNCisJcmVzdWx0ID0gUE1JQ19SRUdfQURDU05TMEggKyB0c2Rldi0+YXNyOw0KKw0KKwlhZGNf
ZGF0YS5pb2MgPSAxOw0KKwlhZGNfZGF0YS5udW1fZW50cmllcyA9IDQ7DQorCWFkY19kYXRhLnBt
aWNfcmVnX2RhdGFbMF0ucmVnaXN0ZXJfYWRkcmVzcyA9IHJlc3VsdCArIDQ7DQorCWFkY19kYXRh
LnBtaWNfcmVnX2RhdGFbMV0ucmVnaXN0ZXJfYWRkcmVzcyA9IHJlc3VsdCArIDU7DQorCWFkY19k
YXRhLnBtaWNfcmVnX2RhdGFbMl0ucmVnaXN0ZXJfYWRkcmVzcyA9IHJlc3VsdCArIDE2Ow0KKwlh
ZGNfZGF0YS5wbWljX3JlZ19kYXRhWzNdLnJlZ2lzdGVyX2FkZHJlc3MgPSByZXN1bHQgKyAxNzsN
CisNCisJZXJyID0gbXJzdF9wbWljX2lvcmVhZCgmYWRjX2RhdGEpOw0KKwlpZiAoZXJyKQ0KKwkJ
Z290byBpcGNfZXJyb3I7DQorDQorCXggPSBhZGNfZGF0YS5wbWljX3JlZ19kYXRhWzBdLnZhbHVl
IDw8IDM7IC8qIEhpZ2hlciA3IGJpdHMgKi8NCisJeCB8PSBhZGNfZGF0YS5wbWljX3JlZ19kYXRh
WzFdLnZhbHVlICYgMHg3OyAvKiBMb3dlciAzIGJpdHMgKi8NCisJeCAmPSAweDNGRjsNCisNCisJ
eSA9IGFkY19kYXRhLnBtaWNfcmVnX2RhdGFbMl0udmFsdWUgPDwgMzsgLyogSGlnaGVyIDcgYml0
cyAqLw0KKwl5IHw9IGFkY19kYXRhLnBtaWNfcmVnX2RhdGFbM10udmFsdWUgJiAweDc7IC8qIExv
d2VyIDMgYml0cyAqLw0KKwl5ICY9IDB4M0ZGOw0KKw0KKwkvKiBSZWFkIFogdmFsdWUgKi8NCisJ
YWRjX2RhdGEubnVtX2VudHJpZXMgPSAyOw0KKwlhZGNfZGF0YS5wbWljX3JlZ19kYXRhWzBdLnJl
Z2lzdGVyX2FkZHJlc3MgPSByZXN1bHQgKyAyODsNCisJYWRjX2RhdGEucG1pY19yZWdfZGF0YVsx
XS5yZWdpc3Rlcl9hZGRyZXNzID0gcmVzdWx0ICsgMjk7DQorDQorCWVyciA9IG1yc3RfcG1pY19p
b3JlYWQoJmFkY19kYXRhKTsNCisJaWYgKGVycikNCisJCWdvdG8gaXBjX2Vycm9yOw0KKw0KKwl6
ID0gYWRjX2RhdGEucG1pY19yZWdfZGF0YVswXS52YWx1ZSA8PCAzOyAvKiBIaWdoZXIgNyBiaXRz
ICovDQorCXogfD0gYWRjX2RhdGEucG1pY19yZWdfZGF0YVsxXS52YWx1ZSAmIDB4NzsgLyogTG93
ZXIgMyBiaXRzICovDQorCXogJj0gMHgzRkY7DQorDQorCWRldl9kYmcoJnRzZGV2LT5zcGktPmRl
diwgIlg6ICVkLCBZOiAlZCwgWjogJWQiLCB4LCB5LCB6KTsNCisNCisJaWYgKHogPj0gVE9VQ0hf
UFJFU1NVUkVfRlMpIHsgLyogUGVuIFJlbW92ZWQgKi8NCisJCW1yc3RvdWNoX3JlcG9ydF94eSh0
c2RldiwgeCwgeSwgVE9VQ0hfUFJFU1NVUkUgLSAxKTsNCisJCXJldHVybiBUT1VDSF9QUkVTU1VS
RSAtIDE7DQorCX0gZWxzZSB7IC8qIFBlbiBUb3VjaGVkICovDQorCQltcnN0b3VjaF9yZXBvcnRf
eHkodHNkZXYsIHgsIHksIFRPVUNIX1BSRVNTVVJFICsgMSk7DQorCQlyZXR1cm4gVE9VQ0hfUFJF
U1NVUkUgKyAxOw0KKwl9DQorDQorCXJldHVybiAwOw0KKw0KK2lwY19lcnJvcjoNCisJcHJpbnRr
KEtFUk5fRVJSICJJUEMgRXJyb3I6ICVzIiwgX19mdW5jX18pOw0KKwlyZXR1cm4gLTE7DQorfQ0K
Kw0KKy8qIFRvIGhhbmRsZSBmcmVlIHNjYWxlIHBtaWMgcGVuZGV0IGludGVycnVwdCAqLw0KK3N0
YXRpYyBpbnQgcG1pYzBfcGVuZGV0KHZvaWQgKmRhdGEpDQorew0KKwlpbnQgZXJyLCBjb3VudDsN
CisJdTE2IGNoYW47DQorCXVuc2lnbmVkIGludCB0b3VjaGVkOw0KKwlzdHJ1Y3QgbXJzdF9wbWlj
X3JlZ19kYXRhIGFkY19kYXRhOw0KKwlzdHJ1Y3QgbXJzdG91Y2hfZGV2ICp0c2RldiA9IChzdHJ1
Y3QgbXJzdG91Y2hfZGV2ICopZGF0YTsNCisNCisJY2hhbiA9IFBNSUNBRERSMCArIHRzZGV2LT5h
c3I7DQorDQorCWFkY19kYXRhLmlvYyA9IDE7DQorCS8qIFNldCBYIEJJQVMgKi8NCisJYWRjX2Rh
dGEubnVtX2VudHJpZXMgPSA1Ow0KKwlmb3IgKGNvdW50ID0gMDsgY291bnQgPD0gMzsgY291bnQr
Kykgew0KKwkJYWRjX2RhdGEucG1pY19yZWdfZGF0YVtjb3VudF0ucmVnaXN0ZXJfYWRkcmVzcyA9
IGNoYW4rKzsNCisJCWFkY19kYXRhLnBtaWNfcmVnX2RhdGFbY291bnRdLnZhbHVlID0gMHgyQTsN
CisJfQ0KKwlhZGNfZGF0YS5wbWljX3JlZ19kYXRhW2NvdW50XS5yZWdpc3Rlcl9hZGRyZXNzID0g
Y2hhbisrOyAvKiBEdW1teSAqLw0KKwlhZGNfZGF0YS5wbWljX3JlZ19kYXRhW2NvdW50XS52YWx1
ZSA9IDA7DQorDQorCWVyciA9IG1yc3RfcG1pY19pb3dyaXRlKCZhZGNfZGF0YSk7DQorCWlmIChl
cnIpDQorCQlnb3RvIGlwY19lcnJvcjsNCisNCisJbXNsZWVwKFdBSVRfQURDX0NPTVBMRVRJT04p
Ow0KKw0KKwkvKiBTZXQgWSBCSUFTICovDQorCWFkY19kYXRhLm51bV9lbnRyaWVzID0gNTsNCisJ
Zm9yIChjb3VudCA9IDA7IGNvdW50IDw9IDM7IGNvdW50KyspIHsNCisJCWFkY19kYXRhLnBtaWNf
cmVnX2RhdGFbY291bnRdLnJlZ2lzdGVyX2FkZHJlc3MgPSBjaGFuKys7DQorCQlhZGNfZGF0YS5w
bWljX3JlZ19kYXRhW2NvdW50XS52YWx1ZSA9IDB4NEE7DQorCX0NCisJYWRjX2RhdGEucG1pY19y
ZWdfZGF0YVtjb3VudF0ucmVnaXN0ZXJfYWRkcmVzcyA9IGNoYW4rKzsgLyogRHVtbXkgKi8NCisJ
YWRjX2RhdGEucG1pY19yZWdfZGF0YVtjb3VudF0udmFsdWUgPSAwOw0KKw0KKwllcnIgPSBtcnN0
X3BtaWNfaW93cml0ZSgmYWRjX2RhdGEpOw0KKwlpZiAoZXJyKQ0KKwkJZ290byBpcGNfZXJyb3I7
DQorDQorCW1zbGVlcChXQUlUX0FEQ19DT01QTEVUSU9OKTsNCisNCisJLyogU2V0IFogQklBUyAq
Lw0KKwljaGFuICs9IDI7DQorCWFkY19kYXRhLm51bV9lbnRyaWVzID0gNDsNCisJZm9yIChjb3Vu
dCA9IDA7IGNvdW50IDw9IDM7IGNvdW50KyspIHsNCisJCWFkY19kYXRhLnBtaWNfcmVnX2RhdGFb
Y291bnRdLnJlZ2lzdGVyX2FkZHJlc3MgPSBjaGFuKys7DQorCQlhZGNfZGF0YS5wbWljX3JlZ19k
YXRhW2NvdW50XS52YWx1ZSA9IDB4OEE7DQorCX0NCisNCisJZXJyID0gbXJzdF9wbWljX2lvd3Jp
dGUoJmFkY19kYXRhKTsNCisJaWYgKGVycikNCisJCWdvdG8gaXBjX2Vycm9yOw0KKw0KKwltc2xl
ZXAoV0FJVF9BRENfQ09NUExFVElPTik7DQorDQorCS8qUmVhZCB0b3VjaCBzY3JlZW4gY2hhbm5l
bHMgdGlsbCBwZW4gcmVtb3ZlZA0KKwkqIEZyZWVzY2FsZSByZXBvcnRzIGNvbnN0YW50IHZhbHVl
IG9mIHogZm9yIGFsbCBwb2ludHMNCisJKiB6IGlzIGhpZ2ggd2hlbiBzY3JlZW4gaXMgbm90IHRv
dWNoZWQgYW5kIGxvdyB3aGVuIHRvdWNoZWQNCisJKiBNYXAgaGlnaCB6IHZhbHVlIHRvIG5vdCB0
b3VjaGVkIGFuZCBsb3cgeiB2YWx1ZSB0byBwZW4gdG91Y2hlZA0KKwkqLw0KKwl0b3VjaGVkID0g
bXJzdG91Y2hfcG1pY19mc19hZGNfcmVhZCh0c2Rldik7DQorCXdoaWxlICh0b3VjaGVkID4gVE9V
Q0hfUFJFU1NVUkUpIHsNCisJCXRvdWNoZWQgPSBtcnN0b3VjaF9wbWljX2ZzX2FkY19yZWFkKHRz
ZGV2KTsNCisJCW1zbGVlcChXQUlUX0FEQ19DT01QTEVUSU9OKTsNCisJfQ0KKw0KKwkvKiBDbGVh
ciBhbGwgVFMgY2hhbm5lbHMgKi8NCisJY2hhbiA9IFBNSUNBRERSMCArIHRzZGV2LT5hc3I7DQor
CWFkY19kYXRhLmlvYyA9IDE7DQorCWFkY19kYXRhLm51bV9lbnRyaWVzID0gNTsNCisJZm9yIChj
b3VudCA9IDA7IGNvdW50IDw9IDQ7IGNvdW50KyspIHsNCisJCWFkY19kYXRhLnBtaWNfcmVnX2Rh
dGFbY291bnRdLnJlZ2lzdGVyX2FkZHJlc3MgPSBjaGFuKys7DQorCQlhZGNfZGF0YS5wbWljX3Jl
Z19kYXRhW2NvdW50XS52YWx1ZSA9IDB4MDsNCisJfQ0KKwllcnIgPSBtcnN0X3BtaWNfaW93cml0
ZSgmYWRjX2RhdGEpOw0KKwlpZiAoZXJyKQ0KKwkJZ290byBpcGNfZXJyb3I7DQorDQorCWZvciAo
Y291bnQgPSAwOyBjb3VudCA8PSA0OyBjb3VudCsrKSB7DQorCQlhZGNfZGF0YS5wbWljX3JlZ19k
YXRhW2NvdW50XS5yZWdpc3Rlcl9hZGRyZXNzID0gY2hhbisrOw0KKwkJYWRjX2RhdGEucG1pY19y
ZWdfZGF0YVtjb3VudF0udmFsdWUgPSAweDA7DQorCX0NCisJZXJyID0gbXJzdF9wbWljX2lvd3Jp
dGUoJmFkY19kYXRhKTsNCisJaWYgKGVycikNCisJCWdvdG8gaXBjX2Vycm9yOw0KKw0KKwljaGFu
ICs9IDI7DQorCWZvciAoY291bnQgPSAwOyBjb3VudCA8PSA0OyBjb3VudCsrKSB7DQorCQlhZGNf
ZGF0YS5wbWljX3JlZ19kYXRhW2NvdW50XS5yZWdpc3Rlcl9hZGRyZXNzID0gY2hhbisrOw0KKwkJ
YWRjX2RhdGEucG1pY19yZWdfZGF0YVtjb3VudF0udmFsdWUgPSAweDA7DQorCX0NCisJZXJyID0g
bXJzdF9wbWljX2lvd3JpdGUoJmFkY19kYXRhKTsNCisJaWYgKGVycikNCisJCWdvdG8gaXBjX2Vy
cm9yOw0KKw0KKwlyZXR1cm4gMDsNCisNCitpcGNfZXJyb3I6DQorCXByaW50ayhLRVJOX0VSUiAi
SVBDIEVycm9yOiAlcyIsIF9fZnVuY19fKTsNCisJcmV0dXJuIC0xOw0KK30NCisNCisNCisvKiBU
byBlbmFibGUgWCwgWSBhbmQgWiBiaWFzIHZhbHVlcw0KKyAqIEVuYWJsZXMgWVBZTSBmb3IgWCBj
aGFubmVscyBhbmQgWFBYTSBmb3IgWSBjaGFubmVscw0KKyAqLw0KK3N0YXRpYyBpbnQgbXJzdG91
Y2hfdHNfYmlhc19zZXQodWludCBvZmZzZXQsIHVpbnQgYmlhcykNCit7DQorCWludCBlcnIsIGNv
dW50Ow0KKwl1MTYgY2hhbiwgc3RhcnQ7DQorCXN0cnVjdCBtcnN0X3BtaWNfcmVnX2RhdGEgYWRj
X2RhdGE7DQorDQorCWNoYW4gPSBQTUlDQUREUjAgKyBvZmZzZXQ7DQorCXN0YXJ0ID0gTVJTVF9U
U19DSEFOMTA7DQorDQorCWFkY19kYXRhLmlvYyA9IDE7DQorCWFkY19kYXRhLm51bV9lbnRyaWVz
ID0gNDsNCisNCisJZm9yIChjb3VudCA9IDA7IGNvdW50IDw9IDM7IGNvdW50KyspIHsNCisJCWFk
Y19kYXRhLnBtaWNfcmVnX2RhdGFbY291bnRdLnJlZ2lzdGVyX2FkZHJlc3MgPSBjaGFuKys7DQor
CQlhZGNfZGF0YS5wbWljX3JlZ19kYXRhW2NvdW50XS52YWx1ZSA9IGJpYXMgfCAoc3RhcnQgKyBj
b3VudCk7DQorCX0NCisNCisJZXJyID0gbXJzdF9wbWljX2lvd3JpdGUoJmFkY19kYXRhKTsNCisJ
aWYgKGVycikNCisJCXJldHVybiAtMTsNCisNCisJcmV0dXJuIDA7DQorfQ0KKw0KKy8qIFRvIHJl
YWQgdG91Y2ggc2NyZWVuIGNoYW5uZWwgdmFsdWVzICovDQorc3RhdGljIGludCBtcnN0b3VjaF9h
ZGNfcmVhZChzdHJ1Y3QgbXJzdG91Y2hfZGV2ICp0c2RldikNCit7DQorCWludCBlcnI7DQorCXUx
NiB4cCwgeG0sIHlwLCB5bSwgenAsIHptOw0KKw0KKwkvKiBjb25maWd1cmUgWSBiaWFzIGZvciBY
IGNoYW5uZWxzICovDQorCWVyciA9IG1yc3RvdWNoX3RzX2JpYXNfc2V0KHRzZGV2LT5hc3IsIFlC
SUFTKTsNCisJaWYgKGVycikNCisJCWdvdG8gaXBjX2Vycm9yOw0KKw0KKwltc2xlZXAoV0FJVF9B
RENfQ09NUExFVElPTik7DQorDQorCS8qIHJlYWQgeCsgYW5kIHgtIGNoYW5uZWxzICovDQorCWVy
ciA9IG1yc3RvdWNoX3RzX2NoYW5fcmVhZCh0c2Rldi0+YXNyLCBNUlNUX1RTX0NIQU4xMCwgJnhw
LCAmeG0pOw0KKwlpZiAoZXJyKQ0KKwkJZ290byBpcGNfZXJyb3I7DQorDQorCS8qIGNvbmZpZ3Vy
ZSB4IGJpYXMgZm9yIHkgY2hhbm5lbHMgKi8NCisJZXJyID0gbXJzdG91Y2hfdHNfYmlhc19zZXQo
dHNkZXYtPmFzciwgWEJJQVMpOw0KKwlpZiAoZXJyKQ0KKwkJZ290byBpcGNfZXJyb3I7DQorDQor
CW1zbGVlcChXQUlUX0FEQ19DT01QTEVUSU9OKTsNCisNCisJLyogcmVhZCB5KyBhbmQgeS0gY2hh
bm5lbHMgKi8NCisJZXJyID0gbXJzdG91Y2hfdHNfY2hhbl9yZWFkKHRzZGV2LT5hc3IsIE1SU1Rf
VFNfQ0hBTjEyLCAmeXAsICZ5bSk7DQorCWlmIChlcnIpDQorCQlnb3RvIGlwY19lcnJvcjsNCisN
CisJLyogY29uZmlndXJlIHogYmlhcyBmb3IgeCBhbmQgeSBjaGFubmVscyAqLw0KKwllcnIgPSBt
cnN0b3VjaF90c19iaWFzX3NldCh0c2Rldi0+YXNyLCBaQklBUyk7DQorCWlmIChlcnIpDQorCQln
b3RvIGlwY19lcnJvcjsNCisNCisJbXNsZWVwKFdBSVRfQURDX0NPTVBMRVRJT04pOw0KKw0KKwkv
KiByZWFkIHorIGFuZCB6LSBjaGFubmVscyAqLw0KKwllcnIgPSBtcnN0b3VjaF90c19jaGFuX3Jl
YWQodHNkZXYtPmFzciwgTVJTVF9UU19DSEFOMTAsICZ6cCwgJnptKTsNCisJaWYgKGVycikNCisJ
CWdvdG8gaXBjX2Vycm9yOw0KKw0KKyNpZiBkZWZpbmVkKE1SU1RPVUNIX1BSSU5UX1hZWlApDQor
CXByaW50ayhLRVJOX0lORk8gIlgrOiAlZCwgWSs6ICVkLCBaKzogJWRcbiIsIHhwLCB5cCwgenAp
Ow0KKyNlbmRpZg0KKw0KKyNpZiBkZWZpbmVkKE1SU1RPVUNIX1BSSU5UX1hZWlApDQorCXByaW50
ayhLRVJOX0lORk8gIlgtOiAlZCwgWS06ICVkLCBaLTogJWRcbiIsIHhtLCB5bSwgem0pOw0KKyNl
bmRpZg0KKwlpZiAoeG0gPCBNSU5fWCB8fCB4bSA+IE1BWF9YIHx8IHltIDwgTUlOX1kgfHwgeW0g
PiBNQVhfWSkNCisJCXJldHVybiBUT1VDSF9QUkVTU1VSRSAtIDE7DQorDQorCW1yc3RvdWNoX3Jl
cG9ydF94eSh0c2RldiwgeHAsIHlwLCB6cCk7IC8qIHJlcG9ydCB4IGFuZCB5IHRvIGV2ZW50WCAq
Lw0KKw0KKwlyZXR1cm4genA7DQorDQoraXBjX2Vycm9yOg0KKwlwcmludGsoS0VSTl9FUlIgIklQ
QyBFcnJvcjogJXMiLCBfX2Z1bmNfXyk7DQorCXJldHVybiAtMTsNCit9DQorDQorLyogUEVOREVU
IGludGVycnVwdCBoYW5kbGVyIGZ1bmN0aW9uIGZvciBORUMgYW5kIE1BWElNICovDQorc3RhdGlj
IHZvaWQgcG1pYzEyX3BlbmRldCh2b2lkICpkYXRhKQ0KK3sNCisJdW5zaWduZWQgaW50IHRvdWNo
ZWQ7DQorCXN0cnVjdCBtcnN0b3VjaF9kZXYgKnRzZGV2ID0gKHN0cnVjdCBtcnN0b3VjaF9kZXYg
KilkYXRhOw0KKw0KKwkvKiByZWFkIHRvdWNoIHNjcmVlbiBjaGFubmVscyB0aWxsIHBlbiByZW1v
dmVkICovDQorCXRvdWNoZWQgPSBtcnN0b3VjaF9hZGNfcmVhZCh0c2Rldik7DQorCXdoaWxlICh0
b3VjaGVkID4gVE9VQ0hfUFJFU1NVUkUpIHsNCisJCXRvdWNoZWQgPSBtcnN0b3VjaF9hZGNfcmVh
ZCh0c2Rldik7DQorCQltc2xlZXAoV0FJVF9BRENfQ09NUExFVElPTik7DQorCX0NCit9DQorDQor
LyogSGFuZGxlciB0byBwcm9jZXNzIFBFTkRFVCBpbnRlcnJ1cHQgKi8NCitpbnQgbXJzdG91Y2hf
cGVuZGV0KHZvaWQgKmRhdGEpDQorew0KKwlzdHJ1Y3QgbXJzdG91Y2hfZGV2ICp0c2RldiA9IChz
dHJ1Y3QgbXJzdG91Y2hfZGV2ICopZGF0YTsNCisNCisJd2hpbGUgKDEpIHsNCisJCWRvd24oJnRz
ZGV2LT5sb2NrKTsgLyogV2FpdCBmb3IgUEVOREVUIGludGVycnVwdCAqLw0KKw0KKwkJaWYgKHRz
ZGV2LT5idXN5KQ0KKwkJCXJldHVybiAwOw0KKw0KKwkJdHNkZXYtPmJ1c3kgPSB0cnVlOw0KKw0K
KwkJaWYgKHRzZGV2LT52ZW5kb3IgPT0gUE1JQ19WRU5ET1JfTkVDIHx8DQorCQkJdHNkZXYtPnZl
bmRvciA9PSBQTUlDX1ZFTkRPUl9NQVhJTSkgew0KKwkJCS8qIFBFTkRFVCBtdXN0IGJlIGRpc2Fi
bGVkIGluIE5FQyBiZWZvcmUgcmVhZGluZyBBREMgKi8NCisJCQlwZW5kZXRfZW5hYmxlKGZhbHNl
KTsgLyogRGlzYmFsZSBQRU5ERVQgKi8NCisJCQlwbWljMTJfcGVuZGV0KHRzZGV2KTsNCisJCQlw
ZW5kZXRfZW5hYmxlKHRydWUpOyAvKkVuYWJsZSBQRU5ERVQgKi8NCisJCX0gZWxzZSBpZiAodHNk
ZXYtPnZlbmRvciA9PSBQTUlDX1ZFTkRPUl9GUykgew0KKwkJCXBlbmRldF9tYXNrKDApOyAvKiBE
aXNhYmxlIFBFTkRFVCAqLw0KKwkJCXBtaWMwX3BlbmRldCh0c2Rldik7DQorCQkJcGVuZGV0X21h
c2soMSk7IC8qIEVuYWJsZSBQRU5ERVQgKi8NCisJCX0gZWxzZQ0KKwkJCXByaW50ayhLRVJOX0VS
UiAiVW5rbm93biBQTUlDLCBOb3Qgc3VwcG9ydGVkXG4iKTsNCisNCisJCXRzZGV2LT5idXN5ID0g
ZmFsc2U7DQorCX0NCisNCisJcmV0dXJuIDA7DQorfQ0KKw0KKy8qIFBFTkRFVCBpbnRlcnJ1cHQg
aGFuZGxlciAqLw0KK3N0YXRpYyBpcnFyZXR1cm5fdCBwZW5kZXRfaW50cl9oYW5kbGVyKGludCBp
cnEsIHZvaWQgKmhhbmRsZSkNCit7DQorCXN0cnVjdCBtcnN0b3VjaF9kZXYgKnRzZGV2ID0gKHN0
cnVjdCBtcnN0b3VjaF9kZXYgKiloYW5kbGU7DQorCXVwKCZ0c2Rldi0+bG9jayk7DQorDQorCXJl
dHVybiBJUlFfSEFORExFRDsNCit9DQorDQorLyogSW50aWFsaXplcyBpbnB1dCBkZXZpY2UgYW5k
IHJlZ2lzdGVycyB3aXRoIGlucHV0IHN1YnN5c3RlbSAqLw0KK3N0YXRpYyBpbnQgdHNfaW5wdXRf
ZGV2X2luaXQoc3RydWN0IG1yc3RvdWNoX2RldiAqdHNkZXYsIHN0cnVjdCBzcGlfZGV2aWNlICpz
cGkpDQorew0KKwlpbnQgZXJyID0gMDsNCisNCisJdHNkZXYtPmlucHV0ID0gaW5wdXRfYWxsb2Nh
dGVfZGV2aWNlKCk7DQorCWlmICghdHNkZXYtPmlucHV0KSB7DQorCQlkZXZfZXJyKCZ0c2Rldi0+
c3BpLT5kZXYsICIlcyIsICJJbnB1dCBkZXYgYWxsb2NhdGlvbiBmYWlsZWQiKTsNCisJCXJldHVy
biAtRU5PTUVNOw0KKwl9DQorDQorCXRzZGV2LT5pbnB1dC0+bmFtZSA9ICJtcnN0X3RvdWNoc2Ny
ZWVuIjsNCisJc25wcmludGYodHNkZXYtPnBoeXMsIHNpemVvZih0c2Rldi0+cGh5cyksDQorCQkJ
IiVzL2lucHV0MCIsIGRldl9uYW1lKCZzcGktPmRldikpOw0KKwl0c2Rldi0+aW5wdXQtPnBoeXMg
PSB0c2Rldi0+cGh5czsNCisJdHNkZXYtPmlucHV0LT5kZXYucGFyZW50ID0gJnNwaS0+ZGV2Ow0K
Kw0KKwl0c2Rldi0+aW5wdXQtPmlkLnZlbmRvciA9IHRzZGV2LT52ZW5kb3I7DQorCXRzZGV2LT5p
bnB1dC0+aWQudmVyc2lvbiA9IHRzZGV2LT5yZXY7DQorDQorCXRzZGV2LT5pbnB1dC0+ZXZiaXRb
MF0gPSBCSVRfTUFTSyhFVl9LRVkpIHwgQklUX01BU0soRVZfQUJTKTsNCisJdHNkZXYtPmlucHV0
LT5rZXliaXRbQklUX1dPUkQoQlROX1RPVUNIKV0gPSBCSVRfTUFTSyhCVE5fVE9VQ0gpOw0KKw0K
KwlpbnB1dF9zZXRfYWJzX3BhcmFtcyh0c2Rldi0+aW5wdXQsIEFCU19YLCBNSU5fWCwgTUlOX1ks
IDAsIDApOw0KKwlpbnB1dF9zZXRfYWJzX3BhcmFtcyh0c2Rldi0+aW5wdXQsIEFCU19ZLCBNSU5f
WCwgTUlOX1ksIDAsIDApOw0KKw0KKwllcnIgPSBpbnB1dF9yZWdpc3Rlcl9kZXZpY2UodHNkZXYt
PmlucHV0KTsNCisJaWYgKGVycikgew0KKwkJZGV2X2VycigmdHNkZXYtPnNwaS0+ZGV2LCAiJXMi
LCAiSW5wdXQgZGV2IHJlZ2lzdGVyIGZhaWxlZCIpOw0KKwkJaW5wdXRfZnJlZV9kZXZpY2UodHNk
ZXYtPmlucHV0KTsNCisJCXJldHVybiBlcnI7DQorCX0NCisNCisJZGV2X2RiZygmdHNkZXYtPnNw
aS0+ZGV2LCAiJXMiLCAibXJzdG91Y2ggaW5pdGlhbGl6ZWQiKTsNCisNCisJcmV0dXJuIDA7DQor
DQorfQ0KKw0KKy8qIFByb2JlIGZ1bmN0aW9uIGZvciB0b3VjaCBzY3JlZW4gZHJpdmVyICovDQor
c3RhdGljIGludCBfX2RldmluaXQgbXJzdG91Y2hfcHJvYmUoc3RydWN0IHNwaV9kZXZpY2UgKm1y
c3RvdWNoX3NwaSkNCit7DQorCWludCBlcnI7DQorCXVuc2lnbmVkIGludCBteWlycTsNCisJc3Ry
dWN0IG1yc3RvdWNoX2RldiAqdHNkZXY7DQorDQorCW15aXJxID0gbXJzdG91Y2hfc3BpLT5pcnE7
DQorDQorCWlmICghbXJzdG91Y2hfc3BpLT5pcnEpIHsNCisJCWRldl9lcnIoJm1yc3RvdWNoX3Nw
aS0+ZGV2LCAiJXMoJWQpIiwgIk5vIElSUSIsIG15aXJxKTsNCisJCXJldHVybiAtRUlOVkFMOw0K
Kwl9DQorDQorCXRzZGV2ID0ga3phbGxvYyhzaXplb2Yoc3RydWN0IG1yc3RvdWNoX2RldiksIEdG
UF9LRVJORUwpOw0KKwlpZiAoIXRzZGV2KSB7DQorCQlkZXZfZXJyKCZ0c2Rldi0+c3BpLT5kZXYs
ICIlcyIsICJFUlJPUjogTWVtb3J5IGZhaWx1cmUiKTsNCisJCXJldHVybiAtRU5PTUVNOw0KKwl9
DQorDQorCXRzZGV2LT5pcnEgPSBteWlycTsNCisNCisJZXJyID0gdHNfaW5wdXRfZGV2X2luaXQo
dHNkZXYsIG1yc3RvdWNoX3NwaSk7DQorCWlmIChlcnIpIHsNCisJCWRldl9lcnIoJnRzZGV2LT5z
cGktPmRldiwgIiVzIiwgInRzX2lucHV0X2Rldl9pbml0IGZhaWxlZCIpOw0KKwkJa2ZyZWUodHNk
ZXYpOw0KKwkJcmV0dXJuIGVycjsNCisJfQ0KKw0KKwllcnIgPSBtcnN0b3VjaF9hZGNfaW5pdCh0
c2Rldik7DQorCWlmIChlcnIpIHsNCisJCWRldl9lcnIoJnRzZGV2LT5zcGktPmRldiwgIiVzIiwg
IkFEQyBpbml0IGZhaWxlZCIpOw0KKwkJZ290byBtcnN0b3VjaF9lcnJvcjsNCisJfQ0KKw0KKwlk
ZXZfc2V0X2RydmRhdGEoJm1yc3RvdWNoX3NwaS0+ZGV2LCB0c2Rldik7DQorCXRzZGV2LT5zcGkg
PSBtcnN0b3VjaF9zcGk7DQorDQorCXNlbWFfaW5pdCgmdHNkZXYtPmxvY2ssIDEpOw0KKwlkb3du
KCZ0c2Rldi0+bG9jayk7DQorDQorCXRzZGV2LT5wZW5kZXRfdGhyZCA9IGt0aHJlYWRfcnVuKG1y
c3RvdWNoX3BlbmRldCwNCisJCQkJCSh2b2lkICopdHNkZXYsICJwZW5kZXQgaGFuZGxlciIpOw0K
KwlpZiAoSVNfRVJSKHRzZGV2LT5wZW5kZXRfdGhyZCkpIHsNCisJCWRldl9lcnIoJnRzZGV2LT5z
cGktPmRldiwgImt0aHJlYWRfcnVuIGZhaWxlZCBcbiIpOw0KKwkJZ290byBtcnN0b3VjaF9lcnJv
cjsNCisJfQ0KKw0KKwlkZXZfZGJnKCZ0c2Rldi0+c3BpLT5kZXYsICJSZXF1ZXN0aW5nIElSUS0l
ZCIsIG15aXJxKTsNCisJZXJyID0gcmVxdWVzdF9pcnEobXlpcnEsIHBlbmRldF9pbnRyX2hhbmRs
ZXIsDQorCQkJCTAsICJtcnN0b3VjaCIsIHRzZGV2KTsNCisJaWYgKGVycikgew0KKwkJZGV2X2Vy
cigmdHNkZXYtPnNwaS0+ZGV2LCAiSVJRIFJlcXVlc3QgRmFpbGVkIC0gJWQiLCBlcnIpOw0KKwkJ
Z290byBtcnN0b3VjaF9lcnJvcjsNCisJfQ0KKw0KKwlkZXZfZGJnKCZ0c2Rldi0+c3BpLT5kZXYs
ICIlcyIsICJEcml2ZXIgaW5pdGlhbGl6ZWQiKTsNCisNCisJcmV0dXJuIDA7DQorDQorIG1yc3Rv
dWNoX2Vycm9yOg0KKwlpbnB1dF91bnJlZ2lzdGVyX2RldmljZSh0c2Rldi0+aW5wdXQpOw0KKwlr
ZnJlZSh0c2Rldik7DQorCXJldHVybiAtMTsNCit9DQorDQorc3RhdGljIF9fZGV2ZXhpdCBpbnQg
bXJzdG91Y2hfcmVtb3ZlKHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpDQorew0KKwlmcmVlX2lycSht
cnN0b3VjaGRldnAtPmlycSwgbXJzdG91Y2hkZXZwKTsNCisJaW5wdXRfdW5yZWdpc3Rlcl9kZXZp
Y2UobXJzdG91Y2hkZXZwLT5pbnB1dCk7DQorCWtmcmVlKG1yc3RvdWNoZGV2cCk7DQorCXJldHVy
biAwOw0KK30NCisNCitzdGF0aWMgc3RydWN0IHNwaV9kcml2ZXIgbXJzdG91Y2hfZHJpdmVyID0g
ew0KKwkuZHJpdmVyID0gew0KKwkJLm5hbWUgICA9ICJwbWljX3RvdWNoIiwNCisJCS5idXMgICAg
PSAmc3BpX2J1c190eXBlLA0KKwkJLm93bmVyICA9IFRISVNfTU9EVUxFLA0KKwl9LA0KKwkucHJv
YmUgICAgICAgICAgPSBtcnN0b3VjaF9wcm9iZSwNCisJLnJlbW92ZSAgICAgICAgID0gX19kZXZl
eGl0X3AobXJzdG91Y2hfcmVtb3ZlKSwNCit9Ow0KKw0KK3N0YXRpYyBpbnQgX19pbml0IG1yc3Rv
dWNoX21vZHVsZV9pbml0KHZvaWQpDQorew0KKwlyZXR1cm4gc3BpX3JlZ2lzdGVyX2RyaXZlcigm
bXJzdG91Y2hfZHJpdmVyKTsNCit9DQorDQorc3RhdGljIHZvaWQgX19leGl0IG1yc3RvdWNoX21v
ZHVsZV9leGl0KHZvaWQpDQorew0KKwlzcGlfdW5yZWdpc3Rlcl9kcml2ZXIoJm1yc3RvdWNoX2Ry
aXZlcik7DQorfQ0KKw0KK21vZHVsZV9pbml0KG1yc3RvdWNoX21vZHVsZV9pbml0KTsNCittb2R1
bGVfZXhpdChtcnN0b3VjaF9tb2R1bGVfZXhpdCk7DQotLSANCjEuNS40LjUNCg0K

--_002_0AE3E14D83C76F4994657326177D1FF9631330FFbgsmsx501garcor_--
