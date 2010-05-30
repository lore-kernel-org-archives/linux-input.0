From: =?utf-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>
Subject: [PATCH] imx_keypad: add PM support
Date: Sun, 30 May 2010 10:51:06 +0200
Message-ID: <1275209466-3899-1-git-send-email-eric@eukrea.com>
References: <1275135823.3128.15.camel@realization>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:56909 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751861Ab0E3IvP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 30 May 2010 04:51:15 -0400
In-Reply-To: <1275135823.3128.15.camel@realization>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, maramaopercheseimorto@gmail.com, linux-arm-kernel@lists.infradead.org

* add suspend/resume support
* use keypad_data to enable wakeup from platform data
* suspend/resume tested when keypad is not in use and when it's
is use (in which case we immediatly get the key pressed for
wakeup)

Signed-off-by: Eric B=C3=A9nard <eric@eukrea.com>
---
 drivers/input/keyboard/imx_keypad.c |   56 +++++++++++++++++++++++++++=
++++++-
 1 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboa=
rd/imx_keypad.c
index d92c15c..b303cc9 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -364,6 +364,55 @@ static void imx_keypad_inhibit(struct imx_keypad *=
keypad)
 	writew(0xff00, keypad->mmio_base + KPCR);
 }
=20
+static int mxc_kpp_suspend(struct platform_device *pdev, pm_message_t =
state)
+{
+	struct imx_keypad *keypad =3D platform_get_drvdata(pdev);
+	unsigned short reg_val;
+
+	clk_disable(keypad->clk);
+
+	if (device_may_wakeup(&pdev->dev)) {
+		reg_val =3D readw(keypad->mmio_base + KPSR);
+		if ((reg_val & KBD_STAT_KDIE) =3D=3D 0) {
+			/* If no depress interrupt enable the release interrupt */
+			reg_val |=3D KBD_STAT_KRIE;
+			writew(reg_val, keypad->mmio_base + KPSR);
+		}
+		enable_irq_wake(keypad->irq);
+	} else {
+		keypad->enabled =3D false;
+		synchronize_irq(keypad->irq);
+		disable_irq(keypad->irq);
+	}
+
+	return 0;
+}
+
+/*!
+ * This function brings the Keypad controller back from low-power stat=
e.
+ * If Keypad is enabled as a wake source(i.e. it can resume the system
+ * from suspend mode), the Keypad controller doesn't enter low-power s=
tate.
+ *
+ * @param   pdev  the device structure used to give information on Key=
pad
+ *                to resume
+ *
+ * @return  The function always returns 0.
+ */
+static int mxc_kpp_resume(struct platform_device *pdev)
+{
+	struct imx_keypad *keypad =3D platform_get_drvdata(pdev);
+
+	clk_enable(keypad->clk);
+	if (device_may_wakeup(&pdev->dev)) {
+		/* The irq routine already cleared KRIE if it was set */
+	} else {
+		keypad->enabled =3D true;
+		enable_irq(keypad->irq);
+	}
+
+	return 0;
+}
+
 static void imx_keypad_close(struct input_dev *dev)
 {
 	struct imx_keypad *keypad =3D input_get_drvdata(dev);
@@ -410,7 +459,8 @@ open_err:
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
@@ -525,7 +575,7 @@ static int __devinit imx_keypad_probe(struct platfo=
rm_device *pdev)
 	}
=20
 	platform_set_drvdata(pdev, keypad);
-	device_init_wakeup(&pdev->dev, 1);
+	device_init_wakeup(&pdev->dev, keypad_data->wakeup);
=20
 	return 0;
=20
@@ -574,6 +624,8 @@ static struct platform_driver imx_keypad_driver =3D=
 {
 	},
 	.probe		=3D imx_keypad_probe,
 	.remove		=3D __devexit_p(imx_keypad_remove),
+	.suspend =3D mxc_kpp_suspend,
+	.resume =3D mxc_kpp_resume,
 };
=20
 static int __init imx_keypad_init(void)
--=20
1.6.3.3

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
