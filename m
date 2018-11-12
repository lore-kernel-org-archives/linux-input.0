From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 6/6] Input: olpc_apsp: enable the SP clock
Date: Mon, 12 Nov 2018 03:30:29 +0100
Message-ID: <20181112023029.648408-7-lkundrak@v3.sk>
References: <20181112023029.648408-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181112023029.648408-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-input@vger.kernel.org

Without the clock, the keyboard controller won't operate.
Tested on an OLPC XO 1.75.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v1:
- Disable the clock in error handling path

 drivers/input/serio/olpc_apsp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/input/serio/olpc_apsp.c b/drivers/input/serio/olpc_a=
psp.c
index 8b19a47dfa46..91d6fb8d7d8d 100644
--- a/drivers/input/serio/olpc_apsp.c
+++ b/drivers/input/serio/olpc_apsp.c
@@ -23,6 +23,7 @@
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/clk.h>
=20
 /*
  * The OLPC XO-1.75 and XO-4 laptops do not have a hardware PS/2 control=
ler.
@@ -74,6 +75,7 @@ struct olpc_apsp {
 	struct serio *kbio;
 	struct serio *padio;
 	void __iomem *base;
+	struct clk *clk;
 	int open_count;
 	int irq;
 };
@@ -146,11 +148,17 @@ static int olpc_apsp_open(struct serio *port)
 	struct olpc_apsp *priv =3D port->port_data;
 	unsigned int tmp;
 	unsigned long l;
+	int error;
=20
 	if (priv->open_count++ =3D=3D 0) {
+		error =3D clk_prepare_enable(priv->clk);
+		if (error)
+			return error;
+
 		l =3D readl(priv->base + COMMAND_FIFO_STATUS);
 		if (!(l & CMD_STS_MASK)) {
 			dev_err(priv->dev, "SP cannot accept commands.\n");
+			clk_disable_unprepare(priv->clk);
 			return -EIO;
 		}
=20
@@ -171,6 +179,8 @@ static void olpc_apsp_close(struct serio *port)
 		/* Disable interrupt 0 */
 		tmp =3D readl(priv->base + PJ_INTERRUPT_MASK);
 		writel(tmp | INT_0, priv->base + PJ_INTERRUPT_MASK);
+
+		clk_disable_unprepare(priv->clk);
 	}
 }
=20
@@ -198,6 +208,10 @@ static int olpc_apsp_probe(struct platform_device *p=
dev)
 	if (priv->irq < 0)
 		return priv->irq;
=20
+	priv->clk =3D devm_clk_get(&pdev->dev, "sp");
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
 	/* KEYBOARD */
 	kb_serio =3D kzalloc(sizeof(struct serio), GFP_KERNEL);
 	if (!kb_serio)
--=20
2.19.1
