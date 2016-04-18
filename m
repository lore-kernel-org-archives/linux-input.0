From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 1/5] input: twl6040-vibra: fix DT node memory management
Date: Mon, 18 Apr 2016 21:55:37 +0200
Message-ID: <fa39d5e67bd71ba0cde980313747f5b4d2f9be94.1461009340.git.hns@goldelico.com>
References: <cover.1461009340.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461009340.git.hns@goldelico.com>
In-Reply-To: <cover.1461009340.git.hns@goldelico.com>
References: <cover.1461009340.git.hns@goldelico.com>
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
index ea63fad..7221a00 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -262,6 +262,7 @@ static int twl6040_vibra_probe(struct platform_device *pdev)
 	int vddvibr_uV = 0;
 	int error;
 
+	of_node_get(twl6040_core_dev->of_node);
 	twl6040_core_node = of_find_node_by_name(twl6040_core_dev->of_node,
 						 "vibra");
 	if (!twl6040_core_node) {
-- 
2.7.3
