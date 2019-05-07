From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 17/99] Input: snvs_pwrkey - initialize necessary driver data before enabling IRQ
Date: Tue,  7 May 2019 01:31:11 -0400
Message-ID: <20190507053235.29900-17-sashal@kernel.org>
References: <20190507053235.29900-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190507053235.29900-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Anson Huang <anson.huang@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Anson Huang <anson.huang@nxp.com>

[ Upstream commit bf2a7ca39fd3ab47ef71c621a7ee69d1813b1f97 ]

SNVS IRQ is requested before necessary driver data initialized,
if there is a pending IRQ during driver probe phase, kernel
NULL pointer panic will occur in IRQ handler. To avoid such
scenario, just initialize necessary driver data before enabling
IRQ. This patch is inspired by NXP's internal kernel tree.

Fixes: d3dc6e232215 ("input: keyboard: imx: add snvs power key driver")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/snvs_pwrkey.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
index effb63205d3d..4c67cf30a5d9 100644
--- a/drivers/input/keyboard/snvs_pwrkey.c
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -148,6 +148,9 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 		return error;
 	}
 
+	pdata->input = input;
+	platform_set_drvdata(pdev, pdata);
+
 	error = devm_request_irq(&pdev->dev, pdata->irq,
 			       imx_snvs_pwrkey_interrupt,
 			       0, pdev->name, pdev);
@@ -163,9 +166,6 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	pdata->input = input;
-	platform_set_drvdata(pdev, pdata);
-
 	device_init_wakeup(&pdev->dev, pdata->wakeup);
 
 	return 0;
-- 
2.20.1
