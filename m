From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/3] Input: 88pm860x-ts: fix child-node lookup
Date: Sat, 11 Nov 2017 16:43:39 +0100
Message-ID: <20171111154339.16875-3-johan@kernel.org>
References: <20171111154339.16875-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171111154339.16875-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: linux-input@vger.kernel.org

Fix child node-lookup during probe, which ended up searching the whole
device tree depth-first starting at parent rather than just matching on
its children.

To make things worse, the parent node was prematurely freed, while the
child node was leaked.

Fixes: 2e57d56747e6 ("mfd: 88pm860x: Device tree support")
Cc: stable <stable@vger.kernel.org>     # 3.7
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/input/touchscreen/88pm860x-ts.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/88pm860x-ts.c b/drivers/input/touchscreen/88pm860x-ts.c
index 7ed828a51f4c..3486d9403805 100644
--- a/drivers/input/touchscreen/88pm860x-ts.c
+++ b/drivers/input/touchscreen/88pm860x-ts.c
@@ -126,7 +126,7 @@ static int pm860x_touch_dt_init(struct platform_device *pdev,
 	int data, n, ret;
 	if (!np)
 		return -ENODEV;
-	np = of_find_node_by_name(np, "touch");
+	np = of_get_child_by_name(np, "touch");
 	if (!np) {
 		dev_err(&pdev->dev, "Can't find touch node\n");
 		return -EINVAL;
@@ -144,13 +144,13 @@ static int pm860x_touch_dt_init(struct platform_device *pdev,
 	if (data) {
 		ret = pm860x_reg_write(i2c, PM8607_GPADC_MISC1, data);
 		if (ret < 0)
-			return -EINVAL;
+			goto err_put_node;
 	}
 	/* set tsi prebias time */
 	if (!of_property_read_u32(np, "marvell,88pm860x-tsi-prebias", &data)) {
 		ret = pm860x_reg_write(i2c, PM8607_TSI_PREBIAS, data);
 		if (ret < 0)
-			return -EINVAL;
+			goto err_put_node;
 	}
 	/* set prebias & prechg time of pen detect */
 	data = 0;
@@ -161,10 +161,18 @@ static int pm860x_touch_dt_init(struct platform_device *pdev,
 	if (data) {
 		ret = pm860x_reg_write(i2c, PM8607_PD_PREBIAS, data);
 		if (ret < 0)
-			return -EINVAL;
+			goto err_put_node;
 	}
 	of_property_read_u32(np, "marvell,88pm860x-resistor-X", res_x);
+
+	of_node_put(np);
+
 	return 0;
+
+err_put_node:
+	of_node_put(np);
+
+	return -EINVAL;
 }
 #else
 #define pm860x_touch_dt_init(x, y, z)	(-1)
-- 
2.15.0
