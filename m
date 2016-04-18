From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 2/5] input: twl6040-vibra: add handler to unregister input if module is removed
Date: Mon, 18 Apr 2016 21:55:38 +0200
Message-ID: <89f53877b821049c789256dd1b0c0b1dbb604de9.1461009340.git.hns@goldelico.com>
References: <cover.1461009340.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461009340.git.hns@goldelico.com>
In-Reply-To: <cover.1461009340.git.hns@goldelico.com>
References: <cover.1461009340.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pyra-handheld.com, letux-kernel@openphoenux.org
List-Id: linux-input@vger.kernel.org

commit 1f9e1470ab34 ("Input: twl6040-vibra - use devm functions")

converted everything to devm but we still need to call
input_unregister_device(info->input_dev)

Solution: add back twl6040_vibra_remove to call input_unregister_device

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/input/misc/twl6040-vibra.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index 7221a00..1e9902d 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -384,8 +384,18 @@ static int twl6040_vibra_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int twl6040_vibra_remove(struct platform_device *pdev)
+{
+	struct vibra_info *info = platform_get_drvdata(pdev);
+
+	input_unregister_device(info->input_dev);
+
+	return 0;
+	}
+
 static struct platform_driver twl6040_vibra_driver = {
 	.probe		= twl6040_vibra_probe,
+	.remove		= twl6040_vibra_remove,
 	.driver		= {
 		.name	= "twl6040-vibra",
 		.pm	= &twl6040_vibra_pm_ops,
-- 
2.7.3
