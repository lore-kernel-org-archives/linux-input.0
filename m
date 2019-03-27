From: Anson Huang <anson.huang@nxp.com>
Subject: [PATCH] input: keyboard: snvs: use dev_pm_set_wake_irq() to simplify
 code
Date: Wed, 27 Mar 2019 06:08:05 +0000
Message-ID: <1553666576-21621-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-input@vger.kernel.org

With calling dev_pm_set_wake_irq() to set SNVS ON/OFF button
as wakeup source for suspend, generic wake irq mechanism
will automatically enable it as wakeup source when suspend,
then the enable_irq_wake()/disable_irq_wake() can be removed
in suspend/resume callback, it simplifies the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/input/keyboard/snvs_pwrkey.c | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/=
snvs_pwrkey.c
index 4c67cf3..5342d8d 100644
--- a/drivers/input/keyboard/snvs_pwrkey.c
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
=20
@@ -167,28 +168,9 @@ static int imx_snvs_pwrkey_probe(struct platform_devic=
e *pdev)
 	}
=20
 	device_init_wakeup(&pdev->dev, pdata->wakeup);
-
-	return 0;
-}
-
-static int __maybe_unused imx_snvs_pwrkey_suspend(struct device *dev)
-{
-	struct platform_device *pdev =3D to_platform_device(dev);
-	struct pwrkey_drv_data *pdata =3D platform_get_drvdata(pdev);
-
-	if (device_may_wakeup(&pdev->dev))
-		enable_irq_wake(pdata->irq);
-
-	return 0;
-}
-
-static int __maybe_unused imx_snvs_pwrkey_resume(struct device *dev)
-{
-	struct platform_device *pdev =3D to_platform_device(dev);
-	struct pwrkey_drv_data *pdata =3D platform_get_drvdata(pdev);
-
-	if (device_may_wakeup(&pdev->dev))
-		disable_irq_wake(pdata->irq);
+	error =3D dev_pm_set_wake_irq(&pdev->dev, pdata->irq);
+	if (error)
+		dev_err(&pdev->dev, "irq wake enable failed.\n");
=20
 	return 0;
 }
@@ -199,13 +181,9 @@ static const struct of_device_id imx_snvs_pwrkey_ids[]=
 =3D {
 };
 MODULE_DEVICE_TABLE(of, imx_snvs_pwrkey_ids);
=20
-static SIMPLE_DEV_PM_OPS(imx_snvs_pwrkey_pm_ops, imx_snvs_pwrkey_suspend,
-				imx_snvs_pwrkey_resume);
-
 static struct platform_driver imx_snvs_pwrkey_driver =3D {
 	.driver =3D {
 		.name =3D "snvs_pwrkey",
-		.pm     =3D &imx_snvs_pwrkey_pm_ops,
 		.of_match_table =3D imx_snvs_pwrkey_ids,
 	},
 	.probe =3D imx_snvs_pwrkey_probe,
--=20
2.7.4
