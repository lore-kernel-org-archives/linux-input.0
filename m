From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 07/27] drivers/input/serio: don't check resource with devm_ioremap_resource
Date: Tue, 23 Jul 2013 20:01:40 +0200
Message-ID: <1374602524-3398-8-git-send-email-wsa@the-dreams.de>
References: <1374602524-3398-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374602524-3398-1-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

devm_ioremap_resource does sanity checks on the given resource. No need to
duplicate this in the driver.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
Please apply via the subsystem-tree.

 drivers/input/serio/olpc_apsp.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/input/serio/olpc_apsp.c b/drivers/input/serio/olpc_apsp.c
index 818aa46..51b1d40 100644
--- a/drivers/input/serio/olpc_apsp.c
+++ b/drivers/input/serio/olpc_apsp.c
@@ -183,9 +183,6 @@ static int olpc_apsp_probe(struct platform_device *pdev)
 
 	np = pdev->dev.of_node;
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENOENT;
-
 	priv->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(priv->base)) {
 		dev_err(&pdev->dev, "Failed to map WTM registers\n");
-- 
1.7.10.4
