From: Anson Huang <anson.huang@nxp.com>
Subject: [PATCH] input: keyboard: snvs: make sure irq is handled correctly
Date: Wed, 27 Mar 2019 02:47:06 +0000
Message-ID: <1553654517-7810-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-input@vger.kernel.org

SNVS IRQ is requested before necessary driver data initialized,
if there is a pending IRQ during driver probe phase, kernel
NULL pointer panic will occur in IRQ handler. To avoid such
scenario, need to move the IRQ request to after driver data
initialization done. This patch is inspired by NXP's internal
kernel tree.

Fixes: d3dc6e232215 ("input: keyboard: imx: add snvs power key driver")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/input/keyboard/snvs_pwrkey.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/=
snvs_pwrkey.c
index effb632..6ff41fd 100644
--- a/drivers/input/keyboard/snvs_pwrkey.c
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -148,15 +148,6 @@ static int imx_snvs_pwrkey_probe(struct platform_devic=
e *pdev)
 		return error;
 	}
=20
-	error =3D devm_request_irq(&pdev->dev, pdata->irq,
-			       imx_snvs_pwrkey_interrupt,
-			       0, pdev->name, pdev);
-
-	if (error) {
-		dev_err(&pdev->dev, "interrupt not available.\n");
-		return error;
-	}
-
 	error =3D input_register_device(input);
 	if (error < 0) {
 		dev_err(&pdev->dev, "failed to register input device\n");
@@ -166,6 +157,14 @@ static int imx_snvs_pwrkey_probe(struct platform_devic=
e *pdev)
 	pdata->input =3D input;
 	platform_set_drvdata(pdev, pdata);
=20
+	error =3D devm_request_irq(&pdev->dev, pdata->irq,
+				 imx_snvs_pwrkey_interrupt,
+				 0, pdev->name, pdev);
+	if (error) {
+		dev_err(&pdev->dev, "interrupt not available.\n");
+		return error;
+	}
+
 	device_init_wakeup(&pdev->dev, pdata->wakeup);
=20
 	return 0;
--=20
2.7.4
