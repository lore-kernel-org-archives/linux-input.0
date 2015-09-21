From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 03/17] input: tegra-kbc: drop use of IRQF_NO_SUSPEND flag
Date: Mon, 21 Sep 2015 16:46:59 +0100
Message-ID: <1442850433-5903-4-git-send-email-sudeep.holla@arm.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Laxman Dewangan <ldewangan@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linux-input@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The driver handles wakeup irq correctly using device_init_wakeup and
enable_irq_wake. There's no need to use IRQF_NO_SUSPEND while registering
the interrupt.

This patch removes the use of IRQF_NO_SUSPEND flag.

Cc: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-input@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/input/keyboard/tegra-kbc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index f97c73bd14f8..5f5dbbd51991 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -705,7 +705,7 @@ static int tegra_kbc_probe(struct platform_device *pdev)
 	input_set_drvdata(kbc->idev, kbc);
 
 	err = devm_request_irq(&pdev->dev, kbc->irq, tegra_kbc_isr,
-			  IRQF_NO_SUSPEND | IRQF_TRIGGER_HIGH, pdev->name, kbc);
+			       IRQF_TRIGGER_HIGH, pdev->name, kbc);
 	if (err) {
 		dev_err(&pdev->dev, "failed to request keyboard IRQ\n");
 		return err;
-- 
1.9.1
