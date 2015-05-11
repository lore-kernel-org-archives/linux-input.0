From: Silvio Fricke <silvio.fricke@gmail.com>
Subject: [PATCH] Input: stmpe-ts: add chip threshold function
Date: Mon, 11 May 2015 13:08:38 +0200
Message-ID: <4b4fe04952a81dd2f3a59104db37d21b8bdd5180.1431338701.git.silvio.fricke@gmail.com>
References: <cover.1431338701.git.silvio.fricke@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1431338701.git.silvio.fricke@gmail.com>
In-Reply-To: <cover.1431338701.git.silvio.fricke@gmail.com>
References: <cover.1431338701.git.silvio.fricke@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc: Silvio Fricke <silvio.fricke@gmail.com>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Silvio Fricke <silvio.fricke@gmail.com>
---
 .../bindings/input/touchscreen/stmpe.txt           |  3 ++
 drivers/input/touchscreen/stmpe-ts.c               | 38 +++++++++++++++-------
 include/linux/mfd/stmpe.h                          |  1 +
 3 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt b/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
index 127baa3..586f1e7 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
@@ -23,6 +23,8 @@ Optional properties:
   the fractional part) recommended is 7
 - st,i-drive: current limit value of the touchscreen drivers (0 -> 20 mA typical 35
   mA max, 1 -> 50 mA typical 80 mA max)
+- st,fifo-threshold: size of samples in chip internal buffer. Needs to be
+  between 1 and 127, defaults to 1
 
 Node name must be stmpe_touchscreen and should be child node of stmpe node to
 which it belongs.
@@ -40,4 +42,5 @@ Example:
 		st,settling = <2>;
 		st,fraction-z = <7>;
 		st,i-drive = <1>;
+		st,fifo-threshold = <10>;
 	};
diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
index 2d5ff86..a40e573 100644
--- a/drivers/input/touchscreen/stmpe-ts.c
+++ b/drivers/input/touchscreen/stmpe-ts.c
@@ -37,8 +37,12 @@
 #define STMPE_REG_FIFO_TH		0x4A
 #define STMPE_REG_FIFO_STA		0x4B
 #define STMPE_REG_FIFO_SIZE		0x4C
+#define STMPE_REG_TSC_DATA_X		0x4d
+#define STMPE_REG_TSC_DATA_Y		0x4f
+#define STMPE_REG_TSC_DATA_Z		0x51
 #define STMPE_REG_TSC_DATA_XYZ		0x52
 #define STMPE_REG_TSC_FRACTION_Z	0x56
+#define STMPE_REG_TSC_DATA		0xD7
 #define STMPE_REG_TSC_I_DRIVE		0x58
 
 #define OP_MOD_XYZ			0
@@ -48,6 +52,7 @@
 #define STMPE_FIFO_STA_RESET		(1<<0)
 
 #define STMPE_IRQ_TOUCH_DET		0
+#define STMPE_IRQ_FIFO_TH		1
 
 #define SAMPLE_TIME(x)			((x & 0xf) << 4)
 #define MOD_12B(x)			((x & 0x1) << 3)
@@ -77,6 +82,7 @@ struct stmpe_touch {
 	u8 settling;
 	u8 fraction_z;
 	u8 i_drive;
+	u8 threshold;
 };
 
 static int __stmpe_reset_fifo(struct stmpe *stmpe)
@@ -126,7 +132,7 @@ static void stmpe_work(struct work_struct *work)
 static irqreturn_t stmpe_ts_handler(int irq, void *data)
 {
 	u8 data_set[4];
-	int x, y, z;
+	int x, y, z, i, fsize;
 	struct stmpe_touch *ts = data;
 
 	/*
@@ -144,17 +150,21 @@ static irqreturn_t stmpe_ts_handler(int irq, void *data)
 	stmpe_set_bits(ts->stmpe, STMPE_REG_TSC_CTRL,
 				STMPE_TSC_CTRL_TSC_EN, 0);
 
-	stmpe_block_read(ts->stmpe, STMPE_REG_TSC_DATA_XYZ, 4, data_set);
+	fsize = stmpe_reg_read(ts->stmpe, STMPE_REG_FIFO_SIZE);
 
-	x = (data_set[0] << 4) | (data_set[1] >> 4);
-	y = ((data_set[1] & 0xf) << 8) | data_set[2];
-	z = data_set[3];
+	for (i = 0; i < fsize; i++) {
+		stmpe_block_read(ts->stmpe, STMPE_REG_TSC_DATA, 4, data_set);
 
-	input_report_abs(ts->idev, ABS_X, x);
-	input_report_abs(ts->idev, ABS_Y, y);
-	input_report_abs(ts->idev, ABS_PRESSURE, z);
-	input_report_key(ts->idev, BTN_TOUCH, 1);
-	input_sync(ts->idev);
+		x = (data_set[0] << 4) | (data_set[1] >> 4);
+		y = ((data_set[1] & 0xf) << 8) | data_set[2];
+		z = data_set[3];
+
+		input_report_abs(ts->idev, ABS_X, x);
+		input_report_abs(ts->idev, ABS_Y, y);
+		input_report_abs(ts->idev, ABS_PRESSURE, z);
+		input_report_key(ts->idev, BTN_TOUCH, 1);
+		input_sync(ts->idev);
+	}
 
        /* flush the FIFO after we have read out our values. */
 	__stmpe_reset_fifo(ts->stmpe);
@@ -225,7 +235,7 @@ static int stmpe_init_hw(struct stmpe_touch *ts)
 	}
 
 	/* set FIFO to 1 for single point reading */
-	ret = stmpe_reg_write(stmpe, STMPE_REG_FIFO_TH, 1);
+	ret = stmpe_reg_write(stmpe, STMPE_REG_FIFO_TH, ts->threshold);
 	if (ret) {
 		dev_err(dev, "Could not set FIFO\n");
 		return ret;
@@ -285,6 +295,7 @@ static void stmpe_ts_get_platform_info(struct platform_device *pdev,
 		ts->settling = ts_pdata->settling;
 		ts->fraction_z = ts_pdata->fraction_z;
 		ts->i_drive = ts_pdata->i_drive;
+		ts->threshold = ts_pdata->threshold;
 	} else if (np) {
 		u32 val;
 
@@ -306,7 +317,12 @@ static void stmpe_ts_get_platform_info(struct platform_device *pdev,
 			ts->fraction_z = val;
 		if (!of_property_read_u32(np, "st,i-drive", &val))
 			ts->i_drive = val;
+		if (!of_property_read_u32(np, "st,threshold", &val))
+			ts->threshold = val;
 	}
+
+	if ((ts->threshold < 1) || (ts->threshold > 127))
+		ts->threshold = 1;
 }
 
 static int stmpe_input_probe(struct platform_device *pdev)
diff --git a/include/linux/mfd/stmpe.h b/include/linux/mfd/stmpe.h
index c9d8690..34efc28e 100644
--- a/include/linux/mfd/stmpe.h
+++ b/include/linux/mfd/stmpe.h
@@ -156,6 +156,7 @@ struct stmpe_ts_platform_data {
        u8 settling;
        u8 fraction_z;
        u8 i_drive;
+       u8 threshold;
 };
 
 /**
-- 
2.4.0
