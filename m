From: Philippe Schenker <dev@pschenker.ch>
Subject: [PATCH v5 2/8] mfd: stmpe: Move ADC related defines to header of mfd
Date: Fri, 21 Dec 2018 14:46:31 +0100
Message-ID: <20181221134638.20600-3-dev@pschenker.ch>
References: <20181221134638.20600-1-dev@pschenker.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181221134638.20600-1-dev@pschenker.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: jic23@kernel.org, marcel.ziswiler@toradex.com, stefan@agner.ch
Cc: robh@kernel.org, alexandre.torgue@st.com, shawnguo@kernel.org, dmitry.torokhov@gmail.com, thierry.reding@gmail.com, digetx@gmail.com, lee.jones@linaro.org, coquelin.stm32@gmail.com, Philippe Schenker <philippe.schenker@toradex.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Move defines that are ADC related to the header of the overlying mfd,
so they can be used from multiple sub-devices.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

---

Changes in v5:
 - Changed author of commit to use correct email

Changes in v4:
 - Added Lee Jone's Ack
 - Added Dmitry Torokhov's Ack

Changes in v3: None
Changes in v2:
 - This is a new added commit. Separate commit for moving the defines
   out of drivers/input/touchscreen/stmpe-ts.c to overlying mfd-device
   drivers/mfd/stmpe.c
 - Pre-fix defines with STMPE_

 drivers/input/touchscreen/stmpe-ts.c | 34 +++++++++++-----------------
 include/linux/mfd/stmpe.h            | 11 +++++++++
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
index 2a78e27b4495..c5d9006588a2 100644
--- a/drivers/input/touchscreen/stmpe-ts.c
+++ b/drivers/input/touchscreen/stmpe-ts.c
@@ -49,17 +49,6 @@
 
 #define STMPE_IRQ_TOUCH_DET		0
 
-#define SAMPLE_TIME(x)			((x & 0xf) << 4)
-#define MOD_12B(x)			((x & 0x1) << 3)
-#define REF_SEL(x)			((x & 0x1) << 1)
-#define ADC_FREQ(x)			(x & 0x3)
-#define AVE_CTRL(x)			((x & 0x3) << 6)
-#define DET_DELAY(x)			((x & 0x7) << 3)
-#define SETTLING(x)			(x & 0x7)
-#define FRACTION_Z(x)			(x & 0x7)
-#define I_DRIVE(x)			(x & 0x1)
-#define OP_MODE(x)			((x & 0x7) << 1)
-
 #define STMPE_TS_NAME			"stmpe-ts"
 #define XY_MASK				0xfff
 
@@ -213,9 +202,10 @@ static int stmpe_init_hw(struct stmpe_touch *ts)
 		return ret;
 	}
 
-	adc_ctrl1 = SAMPLE_TIME(ts->sample_time) | MOD_12B(ts->mod_12b) |
-		REF_SEL(ts->ref_sel);
-	adc_ctrl1_mask = SAMPLE_TIME(0xff) | MOD_12B(0xff) | REF_SEL(0xff);
+	adc_ctrl1 = STMPE_SAMPLE_TIME(ts->sample_time) |
+		    STMPE_MOD_12B(ts->mod_12b) | STMPE_REF_SEL(ts->ref_sel);
+	adc_ctrl1_mask = STMPE_SAMPLE_TIME(0xff) | STMPE_MOD_12B(0xff) |
+			 STMPE_REF_SEL(0xff);
 
 	ret = stmpe_set_bits(stmpe, STMPE_REG_ADC_CTRL1,
 			adc_ctrl1_mask, adc_ctrl1);
@@ -225,15 +215,17 @@ static int stmpe_init_hw(struct stmpe_touch *ts)
 	}
 
 	ret = stmpe_set_bits(stmpe, STMPE_REG_ADC_CTRL2,
-			ADC_FREQ(0xff), ADC_FREQ(ts->adc_freq));
+			STMPE_ADC_FREQ(0xff), STMPE_ADC_FREQ(ts->adc_freq));
 	if (ret) {
 		dev_err(dev, "Could not setup ADC\n");
 		return ret;
 	}
 
-	tsc_cfg = AVE_CTRL(ts->ave_ctrl) | DET_DELAY(ts->touch_det_delay) |
-			SETTLING(ts->settling);
-	tsc_cfg_mask = AVE_CTRL(0xff) | DET_DELAY(0xff) | SETTLING(0xff);
+	tsc_cfg = STMPE_AVE_CTRL(ts->ave_ctrl) |
+		  STMPE_DET_DELAY(ts->touch_det_delay) |
+		  STMPE_SETTLING(ts->settling);
+	tsc_cfg_mask = STMPE_AVE_CTRL(0xff) | STMPE_DET_DELAY(0xff) |
+		       STMPE_SETTLING(0xff);
 
 	ret = stmpe_set_bits(stmpe, STMPE_REG_TSC_CFG, tsc_cfg_mask, tsc_cfg);
 	if (ret) {
@@ -242,14 +234,14 @@ static int stmpe_init_hw(struct stmpe_touch *ts)
 	}
 
 	ret = stmpe_set_bits(stmpe, STMPE_REG_TSC_FRACTION_Z,
-			FRACTION_Z(0xff), FRACTION_Z(ts->fraction_z));
+			STMPE_FRACTION_Z(0xff), STMPE_FRACTION_Z(ts->fraction_z));
 	if (ret) {
 		dev_err(dev, "Could not config touch\n");
 		return ret;
 	}
 
 	ret = stmpe_set_bits(stmpe, STMPE_REG_TSC_I_DRIVE,
-			I_DRIVE(0xff), I_DRIVE(ts->i_drive));
+			STMPE_I_DRIVE(0xff), STMPE_I_DRIVE(ts->i_drive));
 	if (ret) {
 		dev_err(dev, "Could not config touch\n");
 		return ret;
@@ -263,7 +255,7 @@ static int stmpe_init_hw(struct stmpe_touch *ts)
 	}
 
 	ret = stmpe_set_bits(stmpe, STMPE_REG_TSC_CTRL,
-			OP_MODE(0xff), OP_MODE(OP_MOD_XYZ));
+			STMPE_OP_MODE(0xff), STMPE_OP_MODE(OP_MOD_XYZ));
 	if (ret) {
 		dev_err(dev, "Could not set mode\n");
 		return ret;
diff --git a/include/linux/mfd/stmpe.h b/include/linux/mfd/stmpe.h
index 4a827af17e59..c0353f6431f9 100644
--- a/include/linux/mfd/stmpe.h
+++ b/include/linux/mfd/stmpe.h
@@ -10,6 +10,17 @@
 
 #include <linux/mutex.h>
 
+#define STMPE_SAMPLE_TIME(x)	((x & 0xf) << 4)
+#define STMPE_MOD_12B(x)	((x & 0x1) << 3)
+#define STMPE_REF_SEL(x)	((x & 0x1) << 1)
+#define STMPE_ADC_FREQ(x)	(x & 0x3)
+#define STMPE_AVE_CTRL(x)	((x & 0x3) << 6)
+#define STMPE_DET_DELAY(x)	((x & 0x7) << 3)
+#define STMPE_SETTLING(x)	(x & 0x7)
+#define STMPE_FRACTION_Z(x)	(x & 0x7)
+#define STMPE_I_DRIVE(x)	(x & 0x1)
+#define STMPE_OP_MODE(x)	((x & 0x7) << 1)
+
 struct device;
 struct regulator;
 
-- 
2.19.2
