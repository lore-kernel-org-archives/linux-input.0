From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] Input: tegra-kbc: Delete an error message for a failed memory
 allocation in tegra_kbc_probe()
Date: Thu, 25 Jan 2018 21:41:43 +0100
Message-ID: <4b9b77a1-e5af-21c9-f219-be72430fc76f@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-tegra@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, Rakesh Iyer <riyer@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 25 Jan 2018 21:36:46 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/keyboard/tegra-kbc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index 875205f445b5..a4d6eea7aebe 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -622,10 +622,8 @@ static int tegra_kbc_probe(struct platform_device *pdev)
 	match = of_match_device(tegra_kbc_of_match, &pdev->dev);
 
 	kbc = devm_kzalloc(&pdev->dev, sizeof(*kbc), GFP_KERNEL);
-	if (!kbc) {
-		dev_err(&pdev->dev, "failed to alloc memory for kbc\n");
+	if (!kbc)
 		return -ENOMEM;
-	}
 
 	kbc->dev = &pdev->dev;
 	kbc->hw_support = match->data;
-- 
2.16.1
