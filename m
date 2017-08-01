From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 1/2] Input: tegra-kbc: Handle return value of clk_prepare_enable.
Date: Tue,  1 Aug 2017 15:32:26 +0530
Message-ID: <e18b64df1c144ac6ac05bd16e0d5d0cd59a20d13.1501581502.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33073 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbdHAKCn (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 1 Aug 2017 06:02:43 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: riyer@nvidia.com, ldewangan@nvidia.com, dmitry.torokhov@gmail.com, thierry.reding@gmail.com, jonathanh@nvidia.com
Cc: linux-input@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/keyboard/tegra-kbc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index 0c07e10..edc1385 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -370,8 +370,11 @@ static int tegra_kbc_start(struct tegra_kbc *kbc)
 {
 	unsigned int debounce_cnt;
 	u32 val = 0;
+	int ret;
 
-	clk_prepare_enable(kbc->clk);
+	ret = clk_prepare_enable(kbc->clk);
+	if (ret)
+		return ret;
 
 	/* Reset the KBC controller to clear all previous status.*/
 	reset_control_assert(kbc->rst);
-- 
1.9.1

