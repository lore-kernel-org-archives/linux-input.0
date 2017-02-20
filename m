From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 3/3] Input: tsc2007 - add a property "ti,report-resistance" to restore the old pressure reporting state if needed.
Date: Mon, 20 Feb 2017 17:56:36 +0100
Message-ID: <991a09fb874c07b03c21a5b38ebade187134539d.1487609795.git.hns@goldelico.com>
References: <cover.1487609795.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1487609795.git.hns@goldelico.com>
In-Reply-To: <cover.1487609795.git.hns@goldelico.com>
References: <cover.1487609795.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Jonathan Cameron <jic23@kernel.org>, sre@kernel.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-input@vger.kernel.org

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt | 2 ++
 drivers/input/touchscreen/tsc2007.h                             | 1 +
 drivers/input/touchscreen/tsc2007_core.c                        | 6 +++++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
index ec365e1..9b686af 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
@@ -14,6 +14,8 @@ Optional properties:
 - interrupts: (gpio) interrupt to which the chip is connected
   (see interrupt binding[0]).
 - ti,max-rt: maximum pressure.
+- ti,report-resistance: report resistance (no pressure = max_rt) instead
+  of pressure (no pressure = 0).
 - ti,fuzzx: specifies the absolute input fuzz x value.
   If set, it will permit noise in the data up to +- the value given to the fuzz
   parameter, that is used to filter noise from the event stream.
diff --git a/drivers/input/touchscreen/tsc2007.h b/drivers/input/touchscreen/tsc2007.h
index 474bd29..81baabb 100644
--- a/drivers/input/touchscreen/tsc2007.h
+++ b/drivers/input/touchscreen/tsc2007.h
@@ -66,6 +66,7 @@ struct tsc2007 {
 
 	u16			model;
 	u16			x_plate_ohms;
+	bool			report_resistance;
 	u16			max_rt;
 	unsigned long		poll_period; /* in jiffies */
 	int			fuzzx;
diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
index fc73849..984710f 100644
--- a/drivers/input/touchscreen/tsc2007_core.c
+++ b/drivers/input/touchscreen/tsc2007_core.c
@@ -141,7 +141,8 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
 				"DOWN point(%4d,%4d), resistance (%4u)\n",
 				tc.x, tc.y, rt);
 
-			rt = ts->max_rt - rt;
+			if (!ts->report_resistance)
+				rt = ts->max_rt - rt;
 
 			input_report_key(input, BTN_TOUCH, 1);
 			input_report_abs(input, ABS_X, tc.x);
@@ -248,6 +249,9 @@ static int tsc2007_probe_dt(struct i2c_client *client, struct tsc2007 *ts)
 	else
 		ts->max_rt = MAX_12BIT;
 
+	ts->report_resistance =
+		of_property_read_bool(np, "ti,report-resistance");
+
 	if (!of_property_read_u32(np, "ti,fuzzx", &val32))
 		ts->fuzzx = val32;
 
-- 
2.7.3
