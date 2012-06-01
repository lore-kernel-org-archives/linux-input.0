From: Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 5/9] Input: tegra-kbc - add clk_prepare/clk_unprepare
Date: Fri, 1 Jun 2012 14:42:44 +0530
Message-ID: <1338541968-7961-6-git-send-email-pgaikwad@nvidia.com>
References: <1338541968-7961-1-git-send-email-pgaikwad@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1338541968-7961-1-git-send-email-pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Use clk_prepare/clk_unprepare as required by the generic clk framework.

This patch should go through Tegra tree since other patches to port tegra
to generic clock framework are dependent on it. Posting here to get ack from
the maintainers.

Signed-off-by: Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
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
