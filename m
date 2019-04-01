From: Anson Huang <anson.huang@nxp.com>
Subject: [PATCH] input: keyboard: imx: use devm_platform_ioremap_resource() to
 simplify code
Date: Mon, 1 Apr 2019 05:28:12 +0000
Message-ID: <1554096209-17870-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-input@vger.kernel.org

Use the new helper devm_platform_ioremap_resource() which wraps the
platform_get_resource() and devm_ioremap_resource() together, to
simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/input/keyboard/imx_keypad.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/i=
mx_keypad.c
index 539cb67..cf08f4a 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -422,7 +422,6 @@ static int imx_keypad_probe(struct platform_device *pde=
v)
 			dev_get_platdata(&pdev->dev);
 	struct imx_keypad *keypad;
 	struct input_dev *input_dev;
-	struct resource *res;
 	int irq, error, i, row, col;
=20
 	if (!keymap_data && !pdev->dev.of_node) {
@@ -455,8 +454,7 @@ static int imx_keypad_probe(struct platform_device *pde=
v)
 	timer_setup(&keypad->check_matrix_timer,
 		    imx_keypad_check_for_events, 0);
=20
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	keypad->mmio_base =3D devm_ioremap_resource(&pdev->dev, res);
+	keypad->mmio_base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(keypad->mmio_base))
 		return PTR_ERR(keypad->mmio_base);
=20
--=20
2.7.4
