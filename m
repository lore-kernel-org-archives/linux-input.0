From: Anson Huang <anson.huang@nxp.com>
Subject: [PATCH V2] input: keyboard: snvs: initialize necessary driver data
 before enabling IRQ
Date: Wed, 27 Mar 2019 06:07:06 +0000
Message-ID: <1553666514-21505-1-git-send-email-Anson.Huang@nxp.com>
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
scenario, just initialize necessary driver data before enabling
IRQ. This patch is inspired by NXP's internal kernel tree.

Fixes: d3dc6e232215 ("input: keyboard: imx: add snvs power key driver")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- move the platform data initialization to before IRQ enable instead of mo=
ving the IRQ enable
	  to the end of probe function.
---
 drivers/input/keyboard/snvs_pwrkey.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/=
snvs_pwrkey.c
index effb632..4c67cf3 100644
--- a/drivers/input/keyboard/snvs_pwrkey.c
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -148,6 +148,9 @@ static int imx_snvs_pwrkey_probe(struct platform_device=
 *pdev)
 		return error;
 	}
=20
+	pdata->input =3D input;
+	platform_set_drvdata(pdev, pdata);
+
 	error =3D devm_request_irq(&pdev->dev, pdata->irq,
 			       imx_snvs_pwrkey_interrupt,
 			       0, pdev->name, pdev);
@@ -163,9 +166,6 @@ static int imx_snvs_pwrkey_probe(struct platform_device=
 *pdev)
 		return error;
 	}
=20
-	pdata->input =3D input;
-	platform_set_drvdata(pdev, pdata);
-
 	device_init_wakeup(&pdev->dev, pdata->wakeup);
=20
 	return 0;
--=20
2.7.4
