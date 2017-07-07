From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] input: tegra-kbc: add NULL check on of_match_device() return
 value
Date: Fri, 7 Jul 2017 01:27:58 -0500
Message-ID: <20170707062758.GA17584@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Rakesh Iyer <riyer@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-input@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: linux-input@vger.kernel.org

Check return value from call to of_match_device()
in order to prevent a NULL pointer dereference.

In case of NULL print error message and return -ENODEV

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/input/keyboard/tegra-kbc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index 0c07e10..742c5ac 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -617,6 +617,10 @@ static int tegra_kbc_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 
 	match = of_match_device(tegra_kbc_of_match, &pdev->dev);
+	if (!match) {
+		dev_err(&pdev->dev, "failed to match device\n");
+		return -ENODEV;
+	}
 
 	kbc = devm_kzalloc(&pdev->dev, sizeof(*kbc), GFP_KERNEL);
 	if (!kbc) {
-- 
2.5.0
