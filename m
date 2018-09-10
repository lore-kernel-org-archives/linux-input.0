From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 6/8] Input: olpc_apsp: check FIFO status on open(), not probe()
Date: Mon, 10 Sep 2018 13:26:52 +0200
Message-ID: <20180910112654.42061-7-lkundrak@v3.sk>
References: <20180910112654.42061-1-lkundrak@v3.sk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180910112654.42061-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-input@vger.kernel.org

Let's defer the FIFO status checking until open().

When we'll get a clk handle, this will allow us to defer clock enablement
until the device is actually used.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/input/serio/olpc_apsp.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/input/serio/olpc_apsp.c b/drivers/input/serio/olpc_apsp.c
index 8e9a4209fcad..8b19a47dfa46 100644
--- a/drivers/input/serio/olpc_apsp.c
+++ b/drivers/input/serio/olpc_apsp.c
@@ -145,8 +145,15 @@ static int olpc_apsp_open(struct serio *port)
 {
 	struct olpc_apsp *priv = port->port_data;
 	unsigned int tmp;
+	unsigned long l;
 
 	if (priv->open_count++ == 0) {
+		l = readl(priv->base + COMMAND_FIFO_STATUS);
+		if (!(l & CMD_STS_MASK)) {
+			dev_err(priv->dev, "SP cannot accept commands.\n");
+			return -EIO;
+		}
+
 		/* Enable interrupt 0 by clearing its bit */
 		tmp = readl(priv->base + PJ_INTERRUPT_MASK);
 		writel(tmp & ~INT_0, priv->base + PJ_INTERRUPT_MASK);
@@ -173,7 +180,6 @@ static int olpc_apsp_probe(struct platform_device *pdev)
 	struct olpc_apsp *priv;
 	struct resource *res;
 	struct device_node *np;
-	unsigned long l;
 	int error;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(struct olpc_apsp), GFP_KERNEL);
@@ -192,12 +198,6 @@ static int olpc_apsp_probe(struct platform_device *pdev)
 	if (priv->irq < 0)
 		return priv->irq;
 
-	l = readl(priv->base + COMMAND_FIFO_STATUS);
-	if (!(l & CMD_STS_MASK)) {
-		dev_err(&pdev->dev, "SP cannot accept commands.\n");
-		return -EIO;
-	}
-
 	/* KEYBOARD */
 	kb_serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
 	if (!kb_serio)
-- 
2.17.1
