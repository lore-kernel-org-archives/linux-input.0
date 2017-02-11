From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/3] Input: tsc2004/5 - fix regulator handling
Date: Fri, 10 Feb 2017 16:06:22 -0800
Message-ID: <20170211000623.33663-2-dmitry.torokhov@gmail.com>
References: <20170211000623.33663-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170211000623.33663-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Michael Welling <mwelling@ieee.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

In case of an optional regulator missing regulator core will return
ERR_PTR(-ENOENT) and not NULL, so the check for missing regulator is
incorrect. Also, the regulator is not optional, it may simply be missing
from platform decsription, so let's use devm_regulator_get() and rely on
regulator core to give us dummy supply when real one is not available.

Fixes: d257f2980feb ("Input: tsc2005 - convert to gpiod")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Sebastian, I am wondering, what regulator this is. If it is IO VDD,
then I think we activate it too late (i.e. we are truing to shut off
the controller before we turn the regulator on. If it is sensor VDD,
then we probably need to mention it, and also add IO VVD supply as
well.

 drivers/input/touchscreen/tsc200x-core.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/tsc200x-core.c b/drivers/input/touchscreen/tsc200x-core.c
index b7059ed8872e..1c14a38e3748 100644
--- a/drivers/input/touchscreen/tsc200x-core.c
+++ b/drivers/input/touchscreen/tsc200x-core.c
@@ -527,10 +527,10 @@ int tsc200x_probe(struct device *dev, int irq, const struct input_id *tsc_id,
 		return error;
 	}
 
-	ts->vio = devm_regulator_get_optional(dev, "vio");
+	ts->vio = devm_regulator_get(dev, "vio");
 	if (IS_ERR(ts->vio)) {
 		error = PTR_ERR(ts->vio);
-		dev_err(dev, "vio regulator missing (%d)", error);
+		dev_err(dev, "error acquiring vio regulator: %d", error);
 		return error;
 	}
 
@@ -587,12 +587,9 @@ int tsc200x_probe(struct device *dev, int irq, const struct input_id *tsc_id,
 		return error;
 	}
 
-	/* enable regulator for DT */
-	if (ts->vio) {
-		error = regulator_enable(ts->vio);
-		if (error)
-			return error;
-	}
+	error = regulator_enable(ts->vio);
+	if (error)
+		return error;
 
 	dev_set_drvdata(dev, ts);
 	error = sysfs_create_group(&dev->kobj, &tsc200x_attr_group);
@@ -615,8 +612,7 @@ int tsc200x_probe(struct device *dev, int irq, const struct input_id *tsc_id,
 err_remove_sysfs:
 	sysfs_remove_group(&dev->kobj, &tsc200x_attr_group);
 disable_regulator:
-	if (ts->vio)
-		regulator_disable(ts->vio);
+	regulator_disable(ts->vio);
 	return error;
 }
 EXPORT_SYMBOL_GPL(tsc200x_probe);
@@ -627,8 +623,7 @@ int tsc200x_remove(struct device *dev)
 
 	sysfs_remove_group(&dev->kobj, &tsc200x_attr_group);
 
-	if (ts->vio)
-		regulator_disable(ts->vio);
+	regulator_disable(ts->vio);
 
 	return 0;
 }
-- 
2.11.0.483.g087da7b7c-goog
