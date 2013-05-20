From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/7] input: pmic8xxx-pwrkey: Pass correct pointer to free_irq()
Date: Mon, 20 May 2013 16:51:25 +0200
Message-ID: <1369061486-28226-6-git-send-email-lars@metafoo.de>
References: <1369061486-28226-1-git-send-email-lars@metafoo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1369061486-28226-1-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Trilok Soni <tsoni@codeaurora.org>
List-Id: linux-input@vger.kernel.org

free_irq() expects the same pointer that was passed to request_irq(), otherwise
the IRQ is not freed.

The issue was found using the following coccinelle script:

<smpl>
@r1@
type T;
T devid;
@@
request_irq(..., devid)

@r2@
type r1.T;
T devid;
position p;
@@
free_irq@p(..., devid)

@@
position p != r2.p;
@@
*free_irq@p(...)
</smpl>

Cc: Trilok Soni <tsoni@codeaurora.org>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/input/misc/pmic8xxx-pwrkey.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/pmic8xxx-pwrkey.c b/drivers/input/misc/pmic8xxx-pwrkey.c
index afd0af9..b49b738 100644
--- a/drivers/input/misc/pmic8xxx-pwrkey.c
+++ b/drivers/input/misc/pmic8xxx-pwrkey.c
@@ -175,7 +175,7 @@ static int pmic8xxx_pwrkey_probe(struct platform_device *pdev)
 	return 0;
 
 free_press_irq:
-	free_irq(key_press_irq, NULL);
+	free_irq(key_press_irq, pwrkey);
 unreg_input_dev:
 	input_unregister_device(pwr);
 	pwr = NULL;
-- 
1.8.0
