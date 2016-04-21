From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 1/4] input: twl6040-vibra: fix DT node memory management
Date: Thu, 21 Apr 2016 13:43:47 +0200
Message-ID: <c2392b32fb29d82ca99833cd90132c9a7865d6ec.1461239029.git.hns@goldelico.com>
References: <cover.1461239029.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461239029.git.hns@goldelico.com>
In-Reply-To: <cover.1461239029.git.hns@goldelico.com>
References: <cover.1461239029.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pyra-handheld.com, letux-kernel@openphoenux.org
List-Id: linux-input@vger.kernel.org

commit e7ec014a47e4 ("Input: twl6040-vibra - update for device tree support")

made the separate vibra DT node to a subnode of the twl6040.

It now calls of_find_node_by_name() to locate the "vibra" subnode.
This function has a side effect to call of_node_put on() for the twl6040
parent node passed in as a parameter. This causes trouble later on.

Solution: we must call of_node_get() before of_find_node_by_name()

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/input/misc/twl6040-vibra.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index 0c853c2..ad15498 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -257,6 +257,7 @@ static int twl6040_vibra_probe(struct platform_device *pdev)
 	int vddvibr_uV = 0;
 	int error;
 
+	of_node_get(twl6040_core_dev->of_node);
 	twl6040_core_node = of_find_node_by_name(twl6040_core_dev->of_node,
 						 "vibra");
 	if (!twl6040_core_node) {
-- 
2.7.3
