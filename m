From: =?utf-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>
Subject: [PATCH v2] input/imx_keypad: add PM support
Date: Thu, 17 Jun 2010 20:59:01 +0200
Message-ID: <1276801147-4103-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:60066 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757354Ab0FQS7P (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Jun 2010 14:59:15 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: maramaopercheseimorto@gmail.com, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-arm-kernel@lists.infradead.org

We use keypad_data to enable wakeup from platform data

suspend/resume is tested on an i.MX27 when keypad is not
in use and when it's is in use (in which case we immediatly
get the key pressed at wakeup)

Signed-off-by: Eric B=C3=A9nard <eric@eukrea.com>
Cc: maramaopercheseimorto@gmail.com
Cc: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
Cc: linux-arm-kernel@lists.infradead.org
---
v2 :
	- simplify suspend & resume functions
	- convert to pm_ops

 drivers/input/keyboard/imx_keypad.c |   40 +++++++++++++++++++++++++++=
++++++-
 1 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboa=
rd/imx_keypad.c
index d92c15c..9aa0005 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -364,6 +364,38 @@ static void imx_keypad_inhibit(struct imx_keypad *=
keypad)
 	writew(0xff00, keypad->mmio_base + KPCR);
 }
=20
+#ifdef CONFIG_PM
+static int mxc_kpp_suspend(struct device *dev)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct imx_keypad *keypad =3D platform_get_drvdata(pdev);
+
+	keypad->enabled =3D false;
+	synchronize_irq(keypad->irq);
+	disable_irq(keypad->irq);
+	clk_disable(keypad->clk);
+
+	return 0;
+}
+
+static int mxc_kpp_resume(struct device *dev)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct imx_keypad *keypad =3D platform_get_drvdata(pdev);
+
+	keypad->enabled =3D true;
+	clk_enable(keypad->clk);
+	enable_irq(keypad->irq);
+
+	return 0;
+}
+
+static const struct dev_pm_ops mxc_kpp_pm_ops =3D {
+	.suspend	=3D mxc_kpp_suspend,
+	.resume		=3D mxc_kpp_resume,
+};
+#endif
+
 static void imx_keypad_close(struct input_dev *dev)
 {
 	struct imx_keypad *keypad =3D input_get_drvdata(dev);
@@ -410,7 +442,8 @@ open_err:
=20
 static int __devinit imx_keypad_probe(struct platform_device *pdev)
 {
-	const struct matrix_keymap_data *keymap_data =3D pdev->dev.platform_d=
ata;
+	const struct matrix_keypad_platform_data *keypad_data =3D pdev->dev.p=
latform_data;
+	const struct matrix_keymap_data *keymap_data =3D keypad_data->keymap_=
data;
 	struct imx_keypad *keypad;
 	struct input_dev *input_dev;
 	struct resource *res;
@@ -525,7 +558,7 @@ static int __devinit imx_keypad_probe(struct platfo=
rm_device *pdev)
 	}
=20
 	platform_set_drvdata(pdev, keypad);
-	device_init_wakeup(&pdev->dev, 1);
+	device_init_wakeup(&pdev->dev, keypad_data->wakeup);
=20
 	return 0;
=20
@@ -571,6 +604,9 @@ static struct platform_driver imx_keypad_driver =3D=
 {
 	.driver		=3D {
 		.name	=3D "imx-keypad",
 		.owner	=3D THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm	=3D &mxc_kpp_pm_ops,
+#endif
 	},
 	.probe		=3D imx_keypad_probe,
 	.remove		=3D __devexit_p(imx_keypad_remove),
--=20
1.6.3.3

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
