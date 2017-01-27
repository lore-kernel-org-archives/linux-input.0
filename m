From: Shailendra Verma <shailendra.v@samsung.com>
Subject: [PATCH] Input: tegra-kbc - Fix possible NULL derefrence.
Date: Fri, 27 Jan 2017 16:12:36 +0530
Message-ID: <1485513756-1854-1-git-send-email-shailendra.v@samsung.com>
References: <CGME20170127104250epcas1p4cf918f7e98f557ae65136f027f7556f1@epcas1p4.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rakesh Iyer <riyer@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-input@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, p.shailesh@samsung.com, ashish.kalra@samsung.com, Shailendra Verma <shailendra.v@samsung.com>, Shailendra Verma <shailendra.capricorn@gmail.com>
Cc: vidushi.koul@samsung.com
List-Id: linux-input@vger.kernel.org

of_match_device could return NULL, and so cause a NULL pointer
dereference later.

Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
---
 drivers/input/keyboard/tegra-kbc.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index 0c07e10..1f213ba 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -617,6 +617,11 @@ static int tegra_kbc_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 
 	match = of_match_device(tegra_kbc_of_match, &pdev->dev);
+
+	if (!match) {
+		dev_err(&pdev->dev, "Error: No device match found\n");
+		return -ENODEV;
+	}
 
 	kbc = devm_kzalloc(&pdev->dev, sizeof(*kbc), GFP_KERNEL);
 	if (!kbc) {
-- 
1.7.9.5
