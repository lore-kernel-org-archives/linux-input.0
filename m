Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2769BF;
	Mon, 11 Dec 2023 08:57:19 -0800 (PST)
X-IronPort-AV: E=Sophos;i="6.04,268,1695654000"; 
   d="scan'208";a="186065626"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 12 Dec 2023 01:57:19 +0900
Received: from localhost.localdomain (unknown [10.226.92.141])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id ED3E1400A8A6;
	Tue, 12 Dec 2023 01:57:16 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Support Opensource <support.opensource@diasemi.com>,
	linux-input@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/3] Input: da9063 - Use dev_err_probe()
Date: Mon, 11 Dec 2023 16:57:07 +0000
Message-Id: <20231211165708.161808-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211165708.161808-1-biju.das.jz@bp.renesas.com>
References: <20231211165708.161808-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace dev_err()->dev_err_probe() to simpilfy probe().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/input/misc/da9063_onkey.c | 46 ++++++++++++-------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/drivers/input/misc/da9063_onkey.c b/drivers/input/misc/da9063_onkey.c
index 9351ce0bb405..536220662b38 100644
--- a/drivers/input/misc/da9063_onkey.c
+++ b/drivers/input/misc/da9063_onkey.c
@@ -185,10 +185,9 @@ static int da9063_onkey_probe(struct platform_device *pdev)
 
 	onkey = devm_kzalloc(&pdev->dev, sizeof(struct da9063_onkey),
 			     GFP_KERNEL);
-	if (!onkey) {
-		dev_err(&pdev->dev, "Failed to allocate memory.\n");
-		return -ENOMEM;
-	}
+	if (!onkey)
+		return dev_err_probe(&pdev->dev, -ENOMEM,
+				     "Failed to allocate memory.\n");
 
 	onkey->config = device_get_match_data(&pdev->dev);
 	if (!onkey->config)
@@ -197,19 +196,17 @@ static int da9063_onkey_probe(struct platform_device *pdev)
 	onkey->dev = &pdev->dev;
 
 	onkey->regmap = dev_get_regmap(pdev->dev.parent, NULL);
-	if (!onkey->regmap) {
-		dev_err(&pdev->dev, "Parent regmap unavailable.\n");
-		return -ENXIO;
-	}
+	if (!onkey->regmap)
+		return dev_err_probe(&pdev->dev, -ENXIO,
+				     "Parent regmap unavailable.\n");
 
 	onkey->key_power = !of_property_read_bool(pdev->dev.of_node,
 						  "dlg,disable-key-power");
 
 	onkey->input = devm_input_allocate_device(&pdev->dev);
-	if (!onkey->input) {
-		dev_err(&pdev->dev, "Failed to allocated input device.\n");
-		return -ENOMEM;
-	}
+	if (!onkey->input)
+		return dev_err_probe(&pdev->dev, -ENOMEM,
+				     "Failed to allocated input device.\n");
 
 	onkey->input->name = onkey->config->name;
 	snprintf(onkey->phys, sizeof(onkey->phys), "%s/input0",
@@ -221,12 +218,9 @@ static int da9063_onkey_probe(struct platform_device *pdev)
 
 	error = devm_delayed_work_autocancel(&pdev->dev, &onkey->work,
 					     da9063_poll_on);
-	if (error) {
-		dev_err(&pdev->dev,
-			"Failed to add cancel poll action: %d\n",
-			error);
-		return error;
-	}
+	if (error)
+		return dev_err_probe(&pdev->dev, error,
+				     "Failed to add cancel poll action\n");
 
 	irq = platform_get_irq_byname(pdev, "ONKEY");
 	if (irq < 0)
@@ -236,11 +230,9 @@ static int da9063_onkey_probe(struct platform_device *pdev)
 					  NULL, da9063_onkey_irq_handler,
 					  IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 					  "ONKEY", onkey);
-	if (error) {
-		dev_err(&pdev->dev,
-			"Failed to request IRQ %d: %d\n", irq, error);
-		return error;
-	}
+	if (error)
+		return dev_err_probe(&pdev->dev, error,
+				     "Failed to request IRQ %d\n", irq);
 
 	error = dev_pm_set_wake_irq(&pdev->dev, irq);
 	if (error)
@@ -251,11 +243,9 @@ static int da9063_onkey_probe(struct platform_device *pdev)
 		device_init_wakeup(&pdev->dev, true);
 
 	error = input_register_device(onkey->input);
-	if (error) {
-		dev_err(&pdev->dev,
-			"Failed to register input device: %d\n", error);
-		return error;
-	}
+	if (error)
+		return dev_err_probe(&pdev->dev, error,
+				     "Failed to register input device\n");
 
 	return 0;
 }
-- 
2.25.1

