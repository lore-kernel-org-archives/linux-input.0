From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH] input: mtk-pmic-keys: Fix probe when no DT node present
Date: Fri, 22 Jun 2018 13:42:28 +0200
Message-ID: <20180622114228.8619-1-matthias.bgg@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, chen.zhong@mediatek.com, lee.jones@linaro.org
Cc: matthias.bgg@gmail.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>
List-Id: linux-input@vger.kernel.org

The drivers gets probed from a mfd devices. So the driver runs
probe although no DT node exists. This leads to a NULL pointer
dereference in the probe function. Check if a node exists and
error out in case none is present.

Fixes: 3e9f0b3e2b27 ("input: Add MediaTek PMIC keys support")
Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index 02c67a1749fc..388043e1939c 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -257,6 +257,9 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
 	const struct of_device_id *of_id =
 		of_match_device(of_mtk_pmic_keys_match_tbl, &pdev->dev);
 
+	if (of_id == NULL)
+		return -ENODEV;
+
 	keys = devm_kzalloc(&pdev->dev, sizeof(*keys), GFP_KERNEL);
 	if (!keys)
 		return -ENOMEM;
-- 
2.17.1
