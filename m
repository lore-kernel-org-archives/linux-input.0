From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] Input: olpc_apsp - assign priv->dev earlier
Date: Wed, 16 Jan 2019 10:44:38 +0100
Message-ID: <20190116094438.1921667-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The dev field needs to be set when serio_register_port() is called,
because the open callback may use it (in the error handling path).

Cc: stable@vger.kernel.org # v4.18+
Fixes: commit af518342effd ("Input: olpc_apsp - check FIFO status on open=
(), not probe()")
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/input/serio/olpc_apsp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/serio/olpc_apsp.c b/drivers/input/serio/olpc_a=
psp.c
index 0aece9777087..554f4b8228d2 100644
--- a/drivers/input/serio/olpc_apsp.c
+++ b/drivers/input/serio/olpc_apsp.c
@@ -198,6 +198,8 @@ static int olpc_apsp_probe(struct platform_device *pd=
ev)
 	if (!priv)
 		return -ENOMEM;
=20
+	priv->dev =3D &pdev->dev;
+
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->base =3D devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(priv->base)) {
@@ -261,7 +263,6 @@ static int olpc_apsp_probe(struct platform_device *pd=
ev)
 		goto err_irq;
 	}
=20
-	priv->dev =3D &pdev->dev;
 	device_init_wakeup(priv->dev, 1);
 	platform_set_drvdata(pdev, priv);
=20
--=20
2.20.1
