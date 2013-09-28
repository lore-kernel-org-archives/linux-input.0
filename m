From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/6] Input: tegra-kbc - Remove redundant of_match_ptr
Date: Sat, 28 Sep 2013 17:58:11 +0530
Message-ID: <1380371294-10289-3-git-send-email-sachin.kamat@linaro.org>
References: <1380371294-10289-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:61851 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064Ab3I1M20 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Sep 2013 08:28:26 -0400
Received: by mail-pd0-f175.google.com with SMTP id q10so3687586pdj.6
        for <linux-input@vger.kernel.org>; Sat, 28 Sep 2013 05:28:26 -0700 (PDT)
In-Reply-To: <1380371294-10289-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

The data structure of_match_ptr() protects is always compiled in.
Hence of_match_ptr() is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/keyboard/tegra-kbc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index 9cd20e6..8508879 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -614,7 +614,7 @@ static int tegra_kbc_probe(struct platform_device *pdev)
 	unsigned int keymap_rows;
 	const struct of_device_id *match;
 
-	match = of_match_device(of_match_ptr(tegra_kbc_of_match), &pdev->dev);
+	match = of_match_device(tegra_kbc_of_match, &pdev->dev);
 
 	kbc = devm_kzalloc(&pdev->dev, sizeof(*kbc), GFP_KERNEL);
 	if (!kbc) {
-- 
1.7.9.5

