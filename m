From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
Subject: [PATCH v4 2/3] Input: edt-ft5x06 - Set wake/reset values on resume/suspend
Date: Wed, 25 Jul 2018 09:34:09 +0200
Message-ID: <20180725073410.730-3-mylene.josserand@bootlin.com>
References: <20180725073410.730-1-mylene.josserand@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725073410.730-1-mylene.josserand@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@bootlin.com, mylene.josserand@bootlin.com
List-Id: linux-input@vger.kernel.org

On resume and suspend, set the value of wake and reset gpios
to be sure that we are in a know state after suspending/resuming.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index dcde719094f7..dad2f1f8bf89 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1158,6 +1158,12 @@ static int __maybe_unused edt_ft5x06_ts_suspend(struct device *dev)
 	else
 		regulator_disable(tsdata->vcc);
 
+	if (tsdata->wake_gpio)
+		gpiod_set_value(tsdata->wake_gpio, 0);
+
+	if (tsdata->reset_gpio)
+		gpiod_set_value(tsdata->reset_gpio, 1);
+
 	return 0;
 }
 
@@ -1177,6 +1183,12 @@ static int __maybe_unused edt_ft5x06_ts_resume(struct device *dev)
 		}
 	}
 
+	if (tsdata->wake_gpio)
+		gpiod_set_value(tsdata->wake_gpio, 1);
+
+	if (tsdata->reset_gpio)
+		gpiod_set_value(tsdata->reset_gpio, 0);
+
 	return 0;
 }
 
-- 
2.11.0
