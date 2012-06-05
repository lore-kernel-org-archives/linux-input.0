From: Prashant Gaikwad <pgaikwad@nvidia.com>
Subject: [PATCH v2 5/9] Input: tegra-kbc - add clk_prepare/clk_unprepare
Date: Tue, 5 Jun 2012 09:49:22 +0530
Message-ID: <1338869966-8430-6-git-send-email-pgaikwad@nvidia.com>
References: <1338869966-8430-1-git-send-email-pgaikwad@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:9301 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978Ab2FEETH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jun 2012 00:19:07 -0400
In-Reply-To: <1338869966-8430-1-git-send-email-pgaikwad@nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: pgaikwad@nvidia.com
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Use clk_prepare/clk_unprepare as required by the generic clk framework.

Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
---
This patch should go through Tegra tree since other patches to port tegra
to generic clock framework are dependent on it. Posting here to get ack from
the maintainers.

 drivers/input/keyboard/tegra-kbc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index 4ffe64d..2c1c9ed 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -492,7 +492,7 @@ static int tegra_kbc_start(struct tegra_kbc *kbc)
 	unsigned int debounce_cnt;
 	u32 val = 0;
 
-	clk_enable(kbc->clk);
+	clk_prepare_enable(kbc->clk);
 
 	/* Reset the KBC controller to clear all previous status.*/
 	tegra_periph_reset_assert(kbc->clk);
@@ -556,7 +556,7 @@ static void tegra_kbc_stop(struct tegra_kbc *kbc)
 	disable_irq(kbc->irq);
 	del_timer_sync(&kbc->timer);
 
-	clk_disable(kbc->clk);
+	clk_disable_unprepare(kbc->clk);
 }
 
 static int tegra_kbc_open(struct input_dev *dev)
-- 
1.7.4.1

