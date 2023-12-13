Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED280DB;
	Wed, 13 Dec 2023 13:48:20 -0800 (PST)
X-IronPort-AV: E=Sophos;i="6.04,273,1695654000"; 
   d="scan'208";a="190259917"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Dec 2023 06:48:20 +0900
Received: from localhost.localdomain (unknown [10.26.240.14])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id F286B40BB729;
	Thu, 14 Dec 2023 06:48:17 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Support Opensource <support.opensource@diasemi.com>,
	linux-input@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 3/4] Input: da9063 - Use dev_err_probe()
Date: Wed, 13 Dec 2023 21:48:02 +0000
Message-Id: <20231213214803.9931-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231213214803.9931-1-biju.das.jz@bp.renesas.com>
References: <20231213214803.9931-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace dev_err()->dev_err_probe() to simplify probe().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Fixed typo in commit description
 * Updated the print message for irq allocation failure.
---
 drivers/input/misc/da9063_onkey.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/input/misc/da9063_onkey.c b/drivers/input/misc/da9063_onkey.c
index 80878274204e..b18232e91844 100644
--- a/drivers/input/misc/da9063_onkey.c
+++ b/drivers/input/misc/da9063_onkey.c
@@ -195,10 +195,9 @@ static int da9063_onkey_probe(struct platform_device *pdev)
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
@@ -228,11 +227,9 @@ static int da9063_onkey_probe(struct platform_device *pdev)
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
+				     "Failed to allocate onkey IRQ\n");
 
 	error = dev_pm_set_wake_irq(&pdev->dev, irq);
 	if (error)
-- 
2.25.1

