From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 22/33] Input: at32psif - Drop unnecessary error messages and other changes
Date: Wed, 18 Jan 2017 09:46:43 -0800
Message-ID: <1484761614-12225-23-git-send-email-linux@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-input@vger.kernel.org

Error messages after memory allocation failures are unnecessary and
can be dropped.

This conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Drop unnecessary braces around conditional return statements
- Drop error message after devm_kzalloc() failure
- Replace 'goto l; ... l: return e;' with 'return e;'
- Replace 'val = e; return val;' with 'return e;'

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/serio/at32psif.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/input/serio/at32psif.c b/drivers/input/serio/at32psif.c
index 2e4ff5bac754..e420fd781d44 100644
--- a/drivers/input/serio/at32psif.c
+++ b/drivers/input/serio/at32psif.c
@@ -159,13 +159,12 @@ static int psif_open(struct serio *io)
 
 	retval = clk_enable(psif->pclk);
 	if (retval)
-		goto out;
+		return retval;
 
 	psif_writel(psif, CR, PSIF_BIT(CR_TXEN) | PSIF_BIT(CR_RXEN));
 	psif_writel(psif, IER, PSIF_BIT(RXRDY));
 
 	psif->open = true;
-out:
 	return retval;
 }
 
@@ -210,16 +209,12 @@ static int __init psif_probe(struct platform_device *pdev)
 	int ret;
 
 	psif = kzalloc(sizeof(struct psif), GFP_KERNEL);
-	if (!psif) {
-		dev_dbg(&pdev->dev, "out of memory\n");
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!psif)
+		return -ENOMEM;
 	psif->pdev = pdev;
 
 	io = kzalloc(sizeof(struct serio), GFP_KERNEL);
 	if (!io) {
-		dev_dbg(&pdev->dev, "out of memory\n");
 		ret = -ENOMEM;
 		goto out_free_psif;
 	}
@@ -297,7 +292,6 @@ static int __init psif_probe(struct platform_device *pdev)
 	kfree(io);
 out_free_psif:
 	kfree(psif);
-out:
 	return ret;
 }
 
-- 
2.7.4
