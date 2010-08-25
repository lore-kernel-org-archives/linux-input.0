From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 2/2] intel_mid_touch: Resync upstream with the development tree
Date: Wed, 25 Aug 2010 15:22:22 +0100
Message-ID: <20100825142217.2831.18768.stgit@localhost.localdomain>
References: <20100825142200.2831.42013.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19663 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751696Ab0HYPCE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Aug 2010 11:02:04 -0400
In-Reply-To: <20100825142200.2831.42013.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, greg@kroah.com

This merges bits from the two diverging trees including code by Andy Ross
and Arjan van de Ven

Signed-off-by: Andy Ross <andy.ross@windriver.com>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/staging/mrst-touchscreen/TODO              |    3 
 drivers/staging/mrst-touchscreen/intel-mid-touch.c |  938 ++++++++------------
 2 files changed, 378 insertions(+), 563 deletions(-)


diff --git a/drivers/staging/mrst-touchscreen/TODO b/drivers/staging/mrst-touchscreen/TODO
index 7157028..0bb20d4 100644
--- a/drivers/staging/mrst-touchscreen/TODO
+++ b/drivers/staging/mrst-touchscreen/TODO
@@ -1,2 +1 @@
-- Move the driver to not think it is SPI (requires fixing some of the SFI
-  and firmware side)
+- Final fixups and checks on r/m/w sequence conversions
diff --git a/drivers/staging/mrst-touchscreen/intel-mid-touch.c b/drivers/staging/mrst-touchscreen/intel-mid-touch.c
index 2a1a692..c0cfbc2 100644
--- a/drivers/staging/mrst-touchscreen/intel-mid-touch.c
+++ b/drivers/staging/mrst-touchscreen/intel-mid-touch.c
@@ -19,15 +19,11 @@
  * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
  *
  * Questions/Comments/Bug fixes to Sreedhara (sreedhara.ds@intel.com)
- * 			    Ramesh Agarwal (ramesh.agarwal@intel.com)
+ *			    Ramesh Agarwal (ramesh.agarwal@intel.com)
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
  * TODO:
- *	kill off mrstouch_debug eventually
  *	review conversion of r/m/w sequences
- *	Replace interrupt mutex abuse
- *	Kill of mrstouchdevp pointer
- *
  */
 
 #include <linux/module.h>
@@ -36,216 +32,101 @@
 #include <linux/interrupt.h>
 #include <linux/err.h>
 #include <linux/param.h>
-#include <linux/spi/spi.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
 #include <linux/irq.h>
 #include <linux/delay.h>
-#include <linux/kthread.h>
 #include <asm/intel_scu_ipc.h>
 
-
-#if defined(MRSTOUCH_DEBUG)
-#define mrstouch_debug(fmt, args...)\
-	do { \
-		printk(KERN_DEBUG "\n[MRSTOUCH(%d)] - ", __LINE__); \
-		printk(KERN_DEBUG fmt, ##args); \
-	} while (0);
-#else
-#define mrstouch_debug(fmt, args...)
-#endif
-
 /* PMIC Interrupt registers */
-#define PMIC_REG_ID1   0x00 /*PMIC ID1 register */
+#define PMIC_REG_ID1		0x00 /* PMIC ID1 register */
 
 /* PMIC Interrupt registers */
-#define PMIC_REG_INT   0x04 /*PMIC interrupt register */
-#define PMIC_REG_MINT  0x05 /*PMIC interrupt mask register */
+#define PMIC_REG_INT		0x04 /* PMIC interrupt register */
+#define PMIC_REG_MINT		0x05 /* PMIC interrupt mask register */
 
 /* ADC Interrupt registers */
-#define PMIC_REG_ADCINT   0x5F /*ADC interrupt register */
-#define PMIC_REG_MADCINT  0x60 /*ADC interrupt mask register */
+#define PMIC_REG_ADCINT		0x5F /* ADC interrupt register */
+#define PMIC_REG_MADCINT	0x60 /* ADC interrupt mask register */
 
 /* ADC Control registers */
-#define PMIC_REG_ADCCNTL1    0x61 /*ADC control register */
+#define PMIC_REG_ADCCNTL1	0x61 /* ADC control register */
 
 /* ADC Channel Selection registers */
-#define PMICADDR0     0xA4
-#define END_OF_CHANNEL 0x1F
+#define PMICADDR0		0xA4
+#define END_OF_CHANNEL		0x1F
 
 /* ADC Result register */
-#define PMIC_REG_ADCSNS0H   0x64
+#define PMIC_REG_ADCSNS0H	0x64
 
 /* ADC channels for touch screen */
-#define MRST_TS_CHAN10   0xA /* Touch screen X+ connection */
-#define MRST_TS_CHAN11   0xB /* Touch screen X- connection */
-#define MRST_TS_CHAN12   0xC /* Touch screen Y+ connection */
-#define MRST_TS_CHAN13   0xD /* Touch screen Y- connection */
-
-/* Touch screen coordinate constants */
-#define TOUCH_PRESSURE   	50
-#define TOUCH_PRESSURE_FS	100
-
-#define XMOVE_LIMIT	5
-#define YMOVE_LIMIT	5
-#define XYMOVE_CNT	3
-
-#define MAX_10BIT	((1<<10)-1)
+#define MRST_TS_CHAN10		0xA /* Touch screen X+ connection */
+#define MRST_TS_CHAN11		0xB /* Touch screen X- connection */
+#define MRST_TS_CHAN12		0xC /* Touch screen Y+ connection */
+#define MRST_TS_CHAN13		0xD /* Touch screen Y- connection */
 
 /* Touch screen channel BIAS constants */
-#define XBIAS		0x20
-#define YBIAS		0x40
-#define ZBIAS		0x80
+#define MRST_XBIAS		0x20
+#define MRST_YBIAS		0x40
+#define MRST_ZBIAS		0x80
 
 /* Touch screen coordinates */
-#define MIN_X		10
-#define MAX_X		1024
-#define MIN_Y		10
-#define MAX_Y		1024
-#define WAIT_ADC_COMPLETION 10
+#define MRST_X_MIN		10
+#define MRST_X_MAX		1024
+#define MRST_X_FUZZ		5
+#define MRST_Y_MIN		10
+#define MRST_Y_MAX		1024
+#define MRST_Y_FUZZ		5
+#define MRST_PRESSURE_MIN	0
+#define MRST_PRESSURE_NOMINAL	50
+#define MRST_PRESSURE_MAX	100
+
+#define WAIT_ADC_COMPLETION	10 /* msec */
 
 /* PMIC ADC round robin delays */
-#define ADC_LOOP_DELAY0 0x0 /* Continuous loop */
-#define ADC_LOOP_DELAY1 0x1 /* 4.5  ms approximate */
+#define ADC_LOOP_DELAY0		0x0 /* Continuous loop */
+#define ADC_LOOP_DELAY1		0x1 /* 4.5  ms approximate */
 
 /* PMIC Vendor Identifiers */
-#define PMIC_VENDOR_FS  0 /* PMIC vendor FreeScale */
-#define PMIC_VENDOR_MAXIM 1 /* PMIC vendor MAXIM */
-#define PMIC_VENDOR_NEC 2 /* PMIC vendor NEC */
-#define MRSTOUCH_MAX_CHANNELS 32 /* Maximum ADC channels */
+#define PMIC_VENDOR_FS		0 /* PMIC vendor FreeScale */
+#define PMIC_VENDOR_MAXIM	1 /* PMIC vendor MAXIM */
+#define PMIC_VENDOR_NEC		2 /* PMIC vendor NEC */
+#define MRSTOUCH_MAX_CHANNELS	32 /* Maximum ADC channels */
 
 /* Touch screen device structure */
 struct mrstouch_dev {
-	struct spi_device *spi; /* SPI device associated with touch screen */
-	struct input_dev *input; /* input device for touchscreen*/
-	char 		phys[32]; /* Device name */
-	struct task_struct *pendet_thrd; /* PENDET interrupt handler */
-	struct mutex lock; /* Sync between interrupt and PENDET handler */
-	bool            busy; /* Busy flag */
-	u16             asr; /* Address selection register */
-	int             irq;    /* Touch screen IRQ # */
-	uint		vendor;  /* PMIC vendor */
-	uint		rev;  /* PMIC revision */
-	bool		suspended; /* Device suspended status */
-	bool		disabled;  /* Device disabled status */
-	u16		x;  /* X coordinate */
-	u16		y;  /* Y coordinate */
-	bool		pendown;  /* PEN position */
-} ;
-
-
-/* Global Pointer to Touch screen device */
-static struct mrstouch_dev *mrstouchdevp;
-
-/* Utility to read PMIC ID */
-static int mrstouch_pmic_id(uint *vendor, uint *rev)
-{
-	int err;
-	u8 r;
-
-	err = intel_scu_ipc_ioread8(PMIC_REG_ID1, &r);
-	if (err)
-		return err;
+	struct device *dev; /* device associated with touch screen */
+	struct input_dev *input;
+	char phys[32];
+	u16 asr;		/* Address selection register */
+	int irq;
+	unsigned int vendor;	/* PMIC vendor */
+	unsigned int rev;	/* PMIC revision */
+
+	int (*read_prepare)(struct mrstouch_dev *tsdev);
+	int (*read)(struct mrstouch_dev *tsdev, u16 *x, u16 *y, u16 *z);
+	int (*read_finish)(struct mrstouch_dev *tsdev);
+};
 
-	*vendor = r & 0x7;
-	*rev = (r >> 3) & 0x7;
 
-	return 0;
-}
+/*************************** NEC and Maxim Interface ************************/
 
-/*
- * Parse ADC channels to find end of the channel configured by other ADC user
- * NEC and MAXIM requires 4 channels and FreeScale needs 18 channels
- */
-static int mrstouch_chan_parse(struct mrstouch_dev *tsdev)
+static int mrstouch_nec_adc_read_prepare(struct mrstouch_dev *tsdev)
 {
-	int err, i, found;
-	u8 r8;
-
-	found = -1;
-
-	for (i = 0; i < MRSTOUCH_MAX_CHANNELS; i++) {
-		if (found >= 0)
-			break;
-
-		err = intel_scu_ipc_ioread8(PMICADDR0 + i, &r8);
-		if (err)
-			return err;
-
-		if (r8 == END_OF_CHANNEL) {
-			found = i;
-			break;
-		}
-	}
-	if (found < 0)
-		return 0;
-
-	if (tsdev->vendor == PMIC_VENDOR_FS) {
-		if (found && found > (MRSTOUCH_MAX_CHANNELS - 18))
-			return -ENOSPC;
-	} else {
-		if (found && found > (MRSTOUCH_MAX_CHANNELS - 4))
-			return -ENOSPC;
-	}
-	return found;
+	/* Disable pen detection during ADC read */
+	return intel_scu_ipc_update_register(PMIC_REG_ADCCNTL1, 0, 0x20);
 }
 
-/* Utility to enable/disable pendet.
- * pendet set to true enables PENDET interrupt
- * pendet set to false disables PENDET interrupt
- * Also clears RND mask bit
-*/
-static int pendet_enable(struct mrstouch_dev *tsdev, bool pendet)
+static int mrstouch_nec_adc_read_finish(struct mrstouch_dev *tsdev)
 {
-	u16 reg;
-	u8 r;
-	u8 pendet_enabled = 0;
-	int retry = 0;
-	int err;
-
-	err = intel_scu_ipc_ioread16(PMIC_REG_MADCINT, &reg);
-	if (err)
-		return err;
-
-	if (pendet) {
-		reg &= ~0x0005;
-		reg |= 0x2000; /* Enable pendet */
-	} else
-		reg &= 0xDFFF; /* Disable pendet */
-
-	/* Set MADCINT and update ADCCNTL1 (next reg byte) */
-	err = intel_scu_ipc_iowrite16(PMIC_REG_MADCINT, reg);
-	if (!pendet || err)
-		return err;
-
-	/*
-	 * Sometimes even after the register write succeeds
-	 * the PMIC register value is not updated. Retry few iterations
-	 * to enable pendet.
-	 */
-
-	err = intel_scu_ipc_ioread8(PMIC_REG_ADCCNTL1, &r);
-	pendet_enabled = (r >> 5) & 0x01;
-
-	retry = 0;
-	while (!err && !pendet_enabled) {
-		retry++;
-		msleep(10);
-		err = intel_scu_ipc_iowrite8(PMIC_REG_ADCCNTL1, reg >> 8);
-		if (err)
-			break;
-		err = intel_scu_ipc_ioread8(PMIC_REG_ADCCNTL1, &r);
-		if (err == 0)
-			pendet_enabled = (r >> 5) & 0x01;
-		if (retry >= 10) {
-			dev_err(&tsdev->spi->dev, "Touch screen disabled.\n");
-			return -EIO;
-		}
-	}
-	return 0;
+	/* Re-enable pen detection */
+	return intel_scu_ipc_update_register(PMIC_REG_ADCCNTL1, 0x20, 0x20);
 }
 
-/* To read PMIC ADC touch screen result
- * Reads ADC storage registers for higher 7 and lower 3 bits
- * converts the two readings to single value and turns off gain bit
+/*
+ * Reads PMIC ADC touch screen result
+ * Reads ADC storage registers for higher 7 and lower 3 bits and
+ * converts the two readings into a single value and turns off gain bit
  */
 static int mrstouch_ts_chan_read(u16 offset, u16 chan, u16 *vp, u16 *vm)
 {
@@ -277,199 +158,93 @@ static int mrstouch_ts_chan_read(u16 offset, u16 chan, u16 *vp, u16 *vm)
 	return 0;
 }
 
-/* To configure touch screen channels
- * Writes touch screen channels to ADC address selection registers
+/*
+ * Enables X, Y and Z bias values
+ * Enables YPYM for X channels and XPXM for Y channels
  */
-static int mrstouch_ts_chan_set(uint offset)
+static int mrstouch_ts_bias_set(uint offset, uint bias)
 {
-	u16 chan;
-
-	int ret, count;
+	int count;
+	u16 chan, start;
+	u16 reg[4];
+	u8 data[4];
 
 	chan = PMICADDR0 + offset;
-	for (count = 0; count <= 3; count++) {
-		ret = intel_scu_ipc_iowrite8(chan++, MRST_TS_CHAN10 + count);
-		if (ret)
-			return ret;
-	}
-	return intel_scu_ipc_iowrite8(chan++, END_OF_CHANNEL);
-}
-
-/* Initialize ADC */
-static int mrstouch_adc_init(struct mrstouch_dev *tsdev)
-{
-	int err, start;
-	u8 ra, rm;
-
-	err = mrstouch_pmic_id(&tsdev->vendor, &tsdev->rev);
-	if (err) {
-		dev_err(&tsdev->spi->dev, "Unable to read PMIC id\n");
-		return err;
-	}
-
-	start = mrstouch_chan_parse(tsdev);
-	if (start < 0) {
-		dev_err(&tsdev->spi->dev, "Unable to parse channels\n");
-		return start;
-	}
-
-	tsdev->asr = start;
-
-	mrstouch_debug("Channel offset(%d): 0x%X\n", tsdev->asr, tsdev->vendor);
-
-	/* ADC power on, start, enable PENDET and set loop delay
-	 * ADC loop delay is set to 4.5 ms approximately
-	 * Loop delay more than this results in jitter in adc readings
-	 * Setting loop delay to 0 (continous loop) in MAXIM stops PENDET
-	 * interrupt generation sometimes.
-	 */
-
-	if (tsdev->vendor == PMIC_VENDOR_FS) {
-		ra = 0xE0 | ADC_LOOP_DELAY0;
-		rm = 0x5;
-	} else {
-		/* NEC and MAXIm not consistent with loop delay 0 */
-		ra = 0xE0 | ADC_LOOP_DELAY1;
-		rm = 0x0;
-
-		/* configure touch screen channels */
-		err = mrstouch_ts_chan_set(tsdev->asr);
-		if (err)
-			return err;
-	}
-	err = intel_scu_ipc_update_register(PMIC_REG_ADCCNTL1, ra, 0xE7);
-	if (err == 0)
-		err = intel_scu_ipc_update_register(PMIC_REG_MADCINT, rm, 0x03);
-	return err;
-}
-
-/* Reports x,y coordinates to event subsystem */
-static void mrstouch_report_xy(struct mrstouch_dev *tsdev, u16 x, u16 y, u16 z)
-{
-	int xdiff, ydiff;
-
-	if (tsdev->pendown && z <= TOUCH_PRESSURE) {
-		/* Pen removed, report button release */
-		mrstouch_debug("BTN REL(%d)", z);
-		input_report_key(tsdev->input, BTN_TOUCH, 0);
-		tsdev->pendown = false;
-	}
-
-	xdiff = abs(x - tsdev->x);
-	ydiff = abs(y - tsdev->y);
-
-	/*
-	if x and y values changes for XYMOVE_CNT readings it is considered
-	as stylus is moving. This is required to differentiate between stylus
-	movement and jitter
-	*/
-	if (x < MIN_X || x > MAX_X || y < MIN_Y || y > MAX_Y) {
-		/* Spurious values, release button if touched and return */
-		if (tsdev->pendown) {
-			mrstouch_debug("BTN REL(%d)", z);
-			input_report_key(tsdev->input, BTN_TOUCH, 0);
-			tsdev->pendown = false;
-		}
-		return;
-	} else if (xdiff >= XMOVE_LIMIT || ydiff >= YMOVE_LIMIT) {
-		tsdev->x = x;
-		tsdev->y = y;
-
-		input_report_abs(tsdev->input, ABS_X, x);
-		input_report_abs(tsdev->input, ABS_Y, y);
-		input_sync(tsdev->input);
-	}
-
+	start = MRST_TS_CHAN10;
 
-	if (!tsdev->pendown && z > TOUCH_PRESSURE) {
-		/* Pen touched, report button touch */
-		mrstouch_debug("BTN TCH(%d, %d, %d)", x, y, z);
-		input_report_key(tsdev->input, BTN_TOUCH, 1);
-		tsdev->pendown = true;
+	for (count = 0; count <= 3; count++) {
+		reg[count] = chan++;
+		data[count] = bias | (start + count);
 	}
-}
-
 
-/* Utility to start ADC, used by freescale handler */
-static int pendet_mask(void)
-{
-	return 	intel_scu_ipc_update_register(PMIC_REG_MADCINT, 0x02, 0x02);
-}
-
-/* Utility to stop ADC, used by freescale handler */
-static int pendet_umask(void)
-{
-	return 	intel_scu_ipc_update_register(PMIC_REG_MADCINT, 0x00, 0x02);
+	return intel_scu_ipc_writev(reg, data, 4);
 }
 
-/* Utility to read ADC, used by freescale handler */
-static int mrstouch_pmic_fs_adc_read(struct mrstouch_dev *tsdev)
+/* To read touch screen channel values */
+static int mrstouch_nec_adc_read(struct mrstouch_dev *tsdev,
+				 u16 *x, u16 *y, u16 *z)
 {
 	int err;
-	u16 x, y, z, result;
-	u16 reg[4];
-	u8 data[4];
+	u16 xm, ym, zm;
 
-	result = PMIC_REG_ADCSNS0H + tsdev->asr;
+	/* configure Y bias for X channels */
+	err = mrstouch_ts_bias_set(tsdev->asr, MRST_YBIAS); /* XXX XBIAS? */
+	if (err)
+		goto ipc_error;
 
-	reg[0] = result + 4;
-	reg[1] = result + 5;
-	reg[2] = result + 16;
-	reg[3] = result + 17;
+	msleep(WAIT_ADC_COMPLETION);
 
-	err = intel_scu_ipc_readv(reg, data, 4);
+	/* read x+ and x- channels */
+	err = mrstouch_ts_chan_read(tsdev->asr, MRST_TS_CHAN10, x, &xm);
 	if (err)
 		goto ipc_error;
 
-	x = data[0] << 3; /* Higher 7 bits */
-	x |= data[1] & 0x7; /* Lower 3 bits */
-	x &= 0x3FF;
-
-	y = data[2] << 3; /* Higher 7 bits */
-	y |= data[3] & 0x7; /* Lower 3 bits */
-	y &= 0x3FF;
+	/* configure x bias for y channels */
+	err = mrstouch_ts_bias_set(tsdev->asr, MRST_XBIAS); /* XXX YBIAS? */
+	if (err)
+		goto ipc_error;
 
-	/* Read Z value */
-	reg[0] = result + 28;
-	reg[1] = result + 29;
+	msleep(WAIT_ADC_COMPLETION);
 
-	err = intel_scu_ipc_readv(reg, data, 4);
+	/* read y+ and y- channels */
+	err = mrstouch_ts_chan_read(tsdev->asr, MRST_TS_CHAN12, y, &ym);
 	if (err)
 		goto ipc_error;
 
-	z = data[0] << 3; /* Higher 7 bits */
-	z |= data[1] & 0x7; /* Lower 3 bits */
-	z &= 0x3FF;
+	/* configure z bias for x and y channels */
+	err = mrstouch_ts_bias_set(tsdev->asr, MRST_ZBIAS);
+	if (err)
+		goto ipc_error;
 
-#if defined(MRSTOUCH_PRINT_XYZP)
-	mrstouch_debug("X: %d, Y: %d, Z: %d", x, y, z);
-#endif
+	msleep(WAIT_ADC_COMPLETION);
 
-	if (z >= TOUCH_PRESSURE_FS) {
-		mrstouch_report_xy(tsdev, x, y, TOUCH_PRESSURE - 1); /* Pen Removed */
-		return TOUCH_PRESSURE - 1;
-	} else {
-		mrstouch_report_xy(tsdev, x, y, TOUCH_PRESSURE + 1); /* Pen Touched */
-		return TOUCH_PRESSURE + 1;
-	}
+	/* read z+ and z- channels */
+	err = mrstouch_ts_chan_read(tsdev->asr, MRST_TS_CHAN10, z, &zm);
+	if (err)
+		goto ipc_error;
 
 	return 0;
 
 ipc_error:
-	dev_err(&tsdev->spi->dev, "ipc error during fs_adc read\n");
+	dev_err(tsdev->dev, "ipc error during adc read\n");
 	return err;
 }
 
-/* To handle free scale pmic pendet interrupt */
-static int pmic0_pendet(void *dev_id)
+
+/*************************** Freescale Interface ************************/
+
+static int mrstouch_fs_adc_read_prepare(struct mrstouch_dev *tsdev)
 {
 	int err, count;
 	u16 chan;
-	unsigned int touched;
-	struct mrstouch_dev *tsdev = (struct mrstouch_dev *)dev_id;
 	u16 reg[5];
 	u8 data[5];
 
+	/* Stop the ADC */
+	err = intel_scu_ipc_update_register(PMIC_REG_MADCINT, 0x00, 0x02);
+	if (err)
+		goto ipc_error;
+
 	chan = PMICADDR0 + tsdev->asr;
 
 	/* Set X BIAS */
@@ -507,16 +282,65 @@ static int pmic0_pendet(void *dev_id)
 
 	msleep(WAIT_ADC_COMPLETION);
 
-	/*Read touch screen channels till pen removed
-	 * Freescale reports constant value of z for all points
-	 * z is high when screen is not touched and low when touched
-	 * Map high z value to not touched and low z value to pen touched
-	 */
-	touched = mrstouch_pmic_fs_adc_read(tsdev);
-	while (touched > TOUCH_PRESSURE) {
-		touched = mrstouch_pmic_fs_adc_read(tsdev);
-		msleep(WAIT_ADC_COMPLETION);
-	}
+	return 0;
+
+ipc_error:
+	dev_err(tsdev->dev, "ipc error during %s\n", __func__);
+	return err;
+}
+
+static int mrstouch_fs_adc_read(struct mrstouch_dev *tsdev,
+				u16 *x, u16 *y, u16 *z)
+{
+	int err;
+	u16 result;
+	u16 reg[4];
+	u8 data[4];
+
+	result = PMIC_REG_ADCSNS0H + tsdev->asr;
+
+	reg[0] = result + 4;
+	reg[1] = result + 5;
+	reg[2] = result + 16;
+	reg[3] = result + 17;
+
+	err = intel_scu_ipc_readv(reg, data, 4);
+	if (err)
+		goto ipc_error;
+
+	*x = data[0] << 3; /* Higher 7 bits */
+	*x |= data[1] & 0x7; /* Lower 3 bits */
+	*x &= 0x3FF;
+
+	*y = data[2] << 3; /* Higher 7 bits */
+	*y |= data[3] & 0x7; /* Lower 3 bits */
+	*y &= 0x3FF;
+
+	/* Read Z value */
+	reg[0] = result + 28;
+	reg[1] = result + 29;
+
+	err = intel_scu_ipc_readv(reg, data, 4);
+	if (err)
+		goto ipc_error;
+
+	*z = data[0] << 3; /* Higher 7 bits */
+	*z |= data[1] & 0x7; /* Lower 3 bits */
+	*z &= 0x3FF;
+
+	return 0;
+
+ipc_error:
+	dev_err(tsdev->dev, "ipc error during %s\n", __func__);
+	return err;
+}
+
+static int mrstouch_fs_adc_read_finish(struct mrstouch_dev *tsdev)
+{
+	int err, count;
+	u16 chan;
+	u16 reg[5];
+	u8 data[5];
 
 	/* Clear all TS channels */
 	chan = PMICADDR0 + tsdev->asr;
@@ -540,321 +364,313 @@ static int pmic0_pendet(void *dev_id)
 	if (err)
 		goto ipc_error;
 
+	/* Start ADC */
+	err = intel_scu_ipc_update_register(PMIC_REG_MADCINT, 0x02, 0x02);
+	if (err)
+		goto ipc_error;
+
 	return 0;
 
 ipc_error:
-	dev_err(&tsdev->spi->dev, "ipc error during pendet\n");
+	dev_err(tsdev->dev, "ipc error during %s\n", __func__);
 	return err;
 }
 
-
-/* To enable X, Y and Z bias values
- * Enables YPYM for X channels and XPXM for Y channels
- */
-static int mrstouch_ts_bias_set(uint offset, uint bias)
+static void mrstouch_report_event(struct input_dev *input,
+			unsigned int x, unsigned int y, unsigned int z)
 {
-	int count;
-	u16 chan, start;
-	u16 reg[4];
-	u8 data[4];
-
-	chan = PMICADDR0 + offset;
-	start = MRST_TS_CHAN10;
-
-	for (count = 0; count <= 3; count++) {
-		reg[count] = chan++;
-		data[count] = bias | (start + count);
+	if (z > MRST_PRESSURE_NOMINAL) {
+		/* Pen touched, report button touch and coordinates */
+		input_report_key(input, BTN_TOUCH, 1);
+		input_report_abs(input, ABS_X, x);
+		input_report_abs(input, ABS_Y, y);
+	} else {
+		input_report_key(input, BTN_TOUCH, 0);
 	}
-	return intel_scu_ipc_writev(reg, data, 4);
+
+	input_report_abs(input, ABS_PRESSURE, z);
+	input_sync(input);
 }
 
-/* To read touch screen channel values */
-static int mrstouch_adc_read(struct mrstouch_dev *tsdev)
+/* PENDET interrupt handler */
+static irqreturn_t mrstouch_pendet_irq(int irq, void *dev_id)
 {
-	int err;
-	u16 xp, xm, yp, ym, zp, zm;
+	struct mrstouch_dev *tsdev = dev_id;
+	u16 x, y, z;
 
-	/* configure Y bias for X channels */
-	err = mrstouch_ts_bias_set(tsdev->asr, YBIAS);
-	if (err)
-		goto ipc_error;
+	/*
+	 * FIXME: should we lower thread priority? Maybe not, we
+	 * not spinnig but sleeping...
+	 */
 
-	msleep(WAIT_ADC_COMPLETION);
+	if (tsdev->read_prepare(tsdev))
+		goto out;
 
-	/* read x+ and x- channels */
-	err = mrstouch_ts_chan_read(tsdev->asr, MRST_TS_CHAN10, &xp, &xm);
-	if (err)
-		goto ipc_error;
-
-	/* configure x bias for y channels */
-	err = mrstouch_ts_bias_set(tsdev->asr, XBIAS);
-	if (err)
-		goto ipc_error;
+	do {
+		if (tsdev->read(tsdev, &x, &y, &z))
+			break;
 
-	msleep(WAIT_ADC_COMPLETION);
+		mrstouch_report_event(tsdev->input, x, y, z);
+	} while (z > MRST_PRESSURE_NOMINAL);
 
-	/* read y+ and y- channels */
-	err = mrstouch_ts_chan_read(tsdev->asr, MRST_TS_CHAN12, &yp, &ym);
-	if (err)
-		goto ipc_error;
+	tsdev->read_finish(tsdev);
 
-	/* configure z bias for x and y channels */
-	err = mrstouch_ts_bias_set(tsdev->asr, ZBIAS);
-	if (err)
-		goto ipc_error;
+out:
+	return IRQ_HANDLED;
+}
 
-	msleep(WAIT_ADC_COMPLETION);
+/* Utility to read PMIC ID */
+static int __devinit mrstouch_read_pmic_id(uint *vendor, uint *rev)
+{
+	int err;
+	u8 r;
 
-	/* read z+ and z- channels */
-	err = mrstouch_ts_chan_read(tsdev->asr, MRST_TS_CHAN10, &zp, &zm);
+	err = intel_scu_ipc_ioread8(PMIC_REG_ID1, &r);
 	if (err)
-		goto ipc_error;
-
-#if defined(MRSTOUCH_PRINT_XYZP)
-	printk(KERN_INFO "X+: %d, Y+: %d, Z+: %d\n", xp, yp, zp);
-#endif
-
-#if defined(MRSTOUCH_PRINT_XYZM)
-	printk(KERN_INFO "X-: %d, Y-: %d, Z-: %d\n", xm, ym, zm);
-#endif
-
-	mrstouch_report_xy(tsdev, xp, yp, zp); /* report x and y to eventX */
-
-	return zp;
-
-ipc_error:
-	dev_err(&tsdev->spi->dev, "ipc error during adc read\n");
-	return err;
-}
+		return err;
 
-/* PENDET interrupt handler function for NEC and MAXIM */
-static void pmic12_pendet(void *data)
-{
-	unsigned int touched;
-	struct mrstouch_dev *tsdev = (struct mrstouch_dev *)data;
+	*vendor = r & 0x7;
+	*rev = (r >> 3) & 0x7;
 
-	/* read touch screen channels till pen removed */
-	do {
-		touched = mrstouch_adc_read(tsdev);
-	} while (touched > TOUCH_PRESSURE);
+	return 0;
 }
 
-/* Handler to process PENDET interrupt */
-int mrstouch_pendet(void *data)
+/*
+ * Parse ADC channels to find end of the channel configured by other ADC user
+ * NEC and MAXIM requires 4 channels and FreeScale needs 18 channels
+ */
+static int __devinit mrstouch_chan_parse(struct mrstouch_dev *tsdev)
 {
-	struct mrstouch_dev *tsdev = (struct mrstouch_dev *)data;
-	while (1) {
-		/* Wait for PENDET interrupt */
-		if (mutex_lock_interruptible(&tsdev->lock)) {
-			msleep(WAIT_ADC_COMPLETION);
-			continue;
-		}
+	int err, i, found;
+	u8 r8;
 
-		if (tsdev->busy)
-			return 0;
+	found = -1;
 
-		tsdev->busy = true;
+	for (i = 0; i < MRSTOUCH_MAX_CHANNELS; i++) {
+		if (found >= 0)
+			break;
 
-		if (tsdev->vendor == PMIC_VENDOR_NEC ||
-			tsdev->vendor == PMIC_VENDOR_MAXIM) {
-			/* PENDET must be disabled in NEC before reading ADC */
-			pendet_enable(tsdev,false); /* Disbale PENDET */
-			pmic12_pendet(tsdev);
-			pendet_enable(tsdev, true); /*Enable PENDET */
-		} else if (tsdev->vendor == PMIC_VENDOR_FS) {
-			pendet_umask(); /* Stop ADC */
-			pmic0_pendet(tsdev);
-			pendet_mask(); /* Stop ADC */
-		} else
-		dev_err(&tsdev->spi->dev, "Unsupported touchscreen: %d\n",
-				tsdev->vendor);
+		err = intel_scu_ipc_ioread8(PMICADDR0 + i, &r8);
+		if (err)
+			return err;
 
-		tsdev->busy = false;
+		if (r8 == END_OF_CHANNEL) {
+			found = i;
+			break;
+		}
+	}
+	if (found < 0)
+		return 0;
 
+	if (tsdev->vendor == PMIC_VENDOR_FS) {
+		if (found && found > (MRSTOUCH_MAX_CHANNELS - 18))
+			return -ENOSPC;
+	} else {
+		if (found && found > (MRSTOUCH_MAX_CHANNELS - 4))
+			return -ENOSPC;
 	}
-	return 0;
+	return found;
 }
 
-/* PENDET interrupt handler */
-static irqreturn_t pendet_intr_handler(int irq, void *handle)
+
+/*
+ * Writes touch screen channels to ADC address selection registers
+ */
+static int __devinit mrstouch_ts_chan_set(uint offset)
 {
-	struct mrstouch_dev *tsdev = (struct mrstouch_dev *)handle;
+	u16 chan;
 
-	mutex_unlock(&tsdev->lock);
-	return IRQ_HANDLED;
+	int ret, count;
+
+	chan = PMICADDR0 + offset;
+	for (count = 0; count <= 3; count++) {
+		ret = intel_scu_ipc_iowrite8(chan++, MRST_TS_CHAN10 + count);
+		if (ret)
+			return ret;
+	}
+	return intel_scu_ipc_iowrite8(chan++, END_OF_CHANNEL);
 }
 
-/* Intializes input device and registers with input subsystem */
-static int ts_input_dev_init(struct mrstouch_dev *tsdev, struct spi_device *spi)
+/* Initialize ADC */
+static int __devinit mrstouch_adc_init(struct mrstouch_dev *tsdev)
 {
-	int err = 0;
+	int err, start;
+	u8 ra, rm;
 
-	mrstouch_debug("%s", __func__);
+	err = mrstouch_read_pmic_id(&tsdev->vendor, &tsdev->rev);
+	if (err) {
+		dev_err(tsdev->dev, "Unable to read PMIC id\n");
+		return err;
+	}
 
-	tsdev->input = input_allocate_device();
-	if (!tsdev->input) {
-		dev_err(&tsdev->spi->dev, "Unable to allocate input device.\n");
-		return -EINVAL;
+	switch (tsdev->vendor) {
+	case PMIC_VENDOR_NEC:
+	case PMIC_VENDOR_MAXIM:
+		tsdev->read_prepare = mrstouch_nec_adc_read_prepare;
+		tsdev->read = mrstouch_nec_adc_read;
+		tsdev->read_finish = mrstouch_nec_adc_read_finish;
+		break;
+
+	case PMIC_VENDOR_FS:
+		tsdev->read_prepare = mrstouch_fs_adc_read_prepare;
+		tsdev->read = mrstouch_fs_adc_read;
+		tsdev->read_finish = mrstouch_fs_adc_read_finish;
+		break;
+
+	default:
+		dev_err(tsdev->dev,
+			"Unsupported touchscreen: %d\n", tsdev->vendor);
+		return -ENXIO;
 	}
 
-	tsdev->input->name = "mrst_touchscreen";
-	snprintf(tsdev->phys, sizeof(tsdev->phys),
-			"%s/input0", dev_name(&spi->dev));
-	tsdev->input->phys = tsdev->phys;
-	tsdev->input->dev.parent = &spi->dev;
+	start = mrstouch_chan_parse(tsdev);
+	if (start < 0) {
+		dev_err(tsdev->dev, "Unable to parse channels\n");
+		return start;
+	}
 
-	tsdev->input->id.vendor = tsdev->vendor;
-	tsdev->input->id.version = tsdev->rev;
+	tsdev->asr = start;
+
+	/*
+	 * ADC power on, start, enable PENDET and set loop delay
+	 * ADC loop delay is set to 4.5 ms approximately
+	 * Loop delay more than this results in jitter in adc readings
+	 * Setting loop delay to 0 (continous loop) in MAXIM stops PENDET
+	 * interrupt generation sometimes.
+	 */
 
-	tsdev->input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
-	tsdev->input->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+	if (tsdev->vendor == PMIC_VENDOR_FS) {
+		ra = 0xE0 | ADC_LOOP_DELAY0;
+		rm = 0x5;
+	} else {
+		/* NEC and MAXIm not consistent with loop delay 0 */
+		ra = 0xE0 | ADC_LOOP_DELAY1;
+		rm = 0x0;
 
-	input_set_abs_params(tsdev->input, ABS_X, MIN_X, MIN_Y, 0, 0);
-	input_set_abs_params(tsdev->input, ABS_Y, MIN_X, MIN_Y, 0, 0);
+		/* configure touch screen channels */
+		err = mrstouch_ts_chan_set(tsdev->asr);
+		if (err)
+			return err;
+	}
 
-	err = input_register_device(tsdev->input);
-	if (err) {
-		dev_err(&tsdev->spi->dev, "unable to register input device\n");
-		input_free_device(tsdev->input);
+	err = intel_scu_ipc_update_register(PMIC_REG_ADCCNTL1, ra, 0xE7);
+	if (err)
 		return err;
-	}
 
-	mrstouch_debug("%s", "mrstouch initialized");
+	err = intel_scu_ipc_update_register(PMIC_REG_MADCINT, rm, 0x03);
+	if (err)
+		return err;
 
 	return 0;
-
 }
 
+
 /* Probe function for touch screen driver */
-static int __devinit mrstouch_probe(struct spi_device *mrstouch_spi)
+static int __devinit mrstouch_probe(struct platform_device *pdev)
 {
-	int err;
-	unsigned int myirq;
 	struct mrstouch_dev *tsdev;
+	struct input_dev *input;
+	int err;
+	int irq;
 
-	mrstouch_debug("%s(%p)", __func__, mrstouch_spi);
-
-	mrstouchdevp = NULL;
-	myirq = mrstouch_spi->irq;
-
-	if (!mrstouch_spi->irq) {
-		dev_err(&mrstouch_spi->dev, "no interrupt assigned\n");
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "no interrupt assigned\n");
 		return -EINVAL;
 	}
 
 	tsdev = kzalloc(sizeof(struct mrstouch_dev), GFP_KERNEL);
-	if (!tsdev) {
-		dev_err(&mrstouch_spi->dev, "unable to allocate memory\n");
-		return -ENOMEM;
+	input = input_allocate_device();
+	if (!tsdev || !input) {
+		dev_err(&pdev->dev, "unable to allocate memory\n");
+		err = -ENOMEM;
+		goto err_free_mem;
 	}
 
-	tsdev->irq = myirq;
-	mrstouchdevp = tsdev;
+	tsdev->dev = &pdev->dev;
+	tsdev->input = input;
+	tsdev->irq = irq;
 
-	tsdev->spi = mrstouch_spi;
+	snprintf(tsdev->phys, sizeof(tsdev->phys),
+		 "%s/input0", dev_name(tsdev->dev));
 
 	err = mrstouch_adc_init(tsdev);
 	if (err) {
-		dev_err(&mrstouch_spi->dev, "ADC init failed\n");
-		goto mrstouch_err_free_mem;
+		dev_err(&pdev->dev, "ADC initialization failed\n");
+		goto err_free_mem;
 	}
 
-	dev_set_drvdata(&mrstouch_spi->dev, tsdev);
-	tsdev->spi = mrstouch_spi;
+	input->name = "mrst_touchscreen";
+	input->phys = tsdev->phys;
+	input->dev.parent = tsdev->dev;
 
-	err = ts_input_dev_init(tsdev, mrstouch_spi);
-	if (err) {
-		dev_err(&tsdev->spi->dev, "ts_input_dev_init failed");
-		goto mrstouch_err_free_mem;
-	}
+	input->id.vendor = tsdev->vendor;
+	input->id.version = tsdev->rev;
 
-	mutex_init(&tsdev->lock);
-	mutex_lock(&tsdev->lock)
+	input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+	input->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
 
-	mrstouch_debug("Requesting IRQ-%d", myirq);
-	err = request_irq(myirq, pendet_intr_handler,
-				0, "mrstouch", tsdev);
+	input_set_abs_params(tsdev->input, ABS_X,
+			     MRST_X_MIN, MRST_X_MAX, MRST_X_FUZZ, 0);
+	input_set_abs_params(tsdev->input, ABS_Y,
+			     MRST_Y_MIN, MRST_Y_MAX, MRST_Y_FUZZ, 0);
+	input_set_abs_params(tsdev->input, ABS_PRESSURE,
+			     MRST_PRESSURE_MIN, MRST_PRESSURE_MAX, 0, 0);
+
+	err = request_threaded_irq(tsdev->irq, NULL, mrstouch_pendet_irq,
+				   0, "mrstouch", tsdev);
 	if (err) {
-		dev_err(&tsdev->spi->dev, "unable to allocate irq\n");
-		goto mrstouch_err_free_mem;
+		dev_err(tsdev->dev, "unable to allocate irq\n");
+		goto err_free_mem;
 	}
 
-	tsdev->pendet_thrd = kthread_run(mrstouch_pendet,
-				(void *)tsdev, "pendet handler");
-	if (IS_ERR(tsdev->pendet_thrd)) {
-		dev_err(&tsdev->spi->dev, "kthread_run failed\n");
-		err = PTR_ERR(tsdev->pendet_thrd);
-		goto mrstouch_err_free_mem;
+	err = input_register_device(tsdev->input);
+	if (err) {
+		dev_err(tsdev->dev, "unable to register input device\n");
+		goto err_free_irq;
 	}
-	mrstouch_debug("%s", "Driver initialized");
+
+	dev_set_drvdata(tsdev->dev, tsdev);
 	return 0;
 
-mrstouch_err_free_mem:
+err_free_irq:
+	free_irq(tsdev->irq, tsdev);
+err_free_mem:
+	input_free_device(input);
 	kfree(tsdev);
 	return err;
 }
 
-static int mrstouch_suspend(struct spi_device *spi, pm_message_t msg)
-{
-	mrstouch_debug("%s", __func__);
-	mrstouchdevp->suspended = 1;
-	return 0;
-}
-
-static int mrstouch_resume(struct spi_device *spi)
+static int __devexit mrstouch_remove(struct platform_device *pdev)
 {
-	mrstouch_debug("%s", __func__);
-	mrstouchdevp->suspended = 0;
-	return 0;
-}
+	struct mrstouch_dev *tsdev = dev_get_drvdata(&pdev->dev);
 
-static int mrstouch_remove(struct spi_device *spi)
-{
-	mrstouch_debug("%s", __func__);
-	free_irq(mrstouchdevp->irq, mrstouchdevp);
-	input_unregister_device(mrstouchdevp->input);
-	input_free_device(mrstouchdevp->input);
-	if (mrstouchdevp->pendet_thrd)
-		kthread_stop(mrstouchdevp->pendet_thrd);
-	kfree(mrstouchdevp);
+	free_irq(tsdev->irq, tsdev);
+	input_unregister_device(tsdev->input);
+	kfree(tsdev);
 	return 0;
 }
 
-static struct spi_driver mrstouch_driver = {
+static struct platform_driver mrstouch_driver = {
 	.driver = {
 		.name   = "pmic_touch",
-		.bus    = &spi_bus_type,
 		.owner  = THIS_MODULE,
 	},
 	.probe          = mrstouch_probe,
-	.suspend        = mrstouch_suspend,
-	.resume         = mrstouch_resume,
-	.remove         = mrstouch_remove,
+	.remove         = __devexit_p(mrstouch_remove),
 };
 
-static int __init mrstouch_module_init(void)
+static int __init mrstouch_init(void)
 {
-	int err;
-
-	mrstouch_debug("%s", __func__);
-	err = spi_register_driver(&mrstouch_driver);
-	if (err) {
-		mrstouch_debug("%s(%d)", "SPI PENDET failed", err);
-		return -1;
-	}
-
-	return 0;
+	return platform_driver_register(&mrstouch_driver);
 }
+module_init(mrstouch_init);
 
-static void __exit mrstouch_module_exit(void)
+static void __exit mrstouch_exit(void)
 {
-	mrstouch_debug("%s", __func__);
-	spi_unregister_driver(&mrstouch_driver);
-	return;
+	platform_driver_unregister(&mrstouch_driver);
 }
-
-module_init(mrstouch_module_init);
-module_exit(mrstouch_module_exit);
+module_exit(mrstouch_exit);
 
 MODULE_AUTHOR("Sreedhara Murthy. D.S, sreedhara.ds@intel.com");
 MODULE_DESCRIPTION("Intel Moorestown Resistive Touch Screen Driver");

