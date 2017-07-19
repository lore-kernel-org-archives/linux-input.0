From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 033/102] Input: tegra-kbc - request exclusive reset control
Date: Wed, 19 Jul 2017 17:25:37 +0200
Message-ID: <20170719152646.25903-34-p.zabel@pengutronix.de>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170719152646.25903-1-p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rakesh Iyer <riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
reset lines") started to transition the reset control request API calls
to explicitly state whether the driver needs exclusive or shared reset
control behavior. Convert all drivers requesting exclusive resets to the
explicit API call so the temporary transition helpers can be removed.

No functional changes.

Cc: Rakesh Iyer <riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/input/keyboard/tegra-kbc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index 0c07e1023a469..c42c825dd982b 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -665,7 +665,7 @@ static int tegra_kbc_probe(struct platform_device *pdev)
 		return PTR_ERR(kbc->clk);
 	}
 
-	kbc->rst = devm_reset_control_get(&pdev->dev, "kbc");
+	kbc->rst = devm_reset_control_get_exclusive(&pdev->dev, "kbc");
 	if (IS_ERR(kbc->rst)) {
 		dev_err(&pdev->dev, "failed to get keyboard reset\n");
 		return PTR_ERR(kbc->rst);
-- 
2.11.0
