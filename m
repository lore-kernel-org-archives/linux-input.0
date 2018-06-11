From: Zhouyang Jia <jiazhouyang09@gmail.com>
Subject: [PATCH] Input: add error handling for da9052_reg_write
Date: Mon, 11 Jun 2018 13:23:39 +0800
Message-ID: <1528694619-31889-1-git-send-email-jiazhouyang09@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Zhouyang Jia <jiazhouyang09@gmail.com>, Support Opensource <support.opensource@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

When da9052_reg_write fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling da9052_reg_write.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/input/touchscreen/da9052_tsi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/da9052_tsi.c b/drivers/input/touchscreen/da9052_tsi.c
index b5dfd594..60c82a0 100644
--- a/drivers/input/touchscreen/da9052_tsi.c
+++ b/drivers/input/touchscreen/da9052_tsi.c
@@ -319,8 +319,11 @@ static int da9052_ts_probe(struct platform_device *pdev)
 static int  da9052_ts_remove(struct platform_device *pdev)
 {
 	struct da9052_tsi *tsi = platform_get_drvdata(pdev);
+	int error;
 
-	da9052_reg_write(tsi->da9052, DA9052_LDO9_REG, 0x19);
+	error = da9052_reg_write(tsi->da9052, DA9052_LDO9_REG, 0x19);
+	if (error < 0)
+		return error;
 
 	da9052_free_irq(tsi->da9052, DA9052_IRQ_TSIREADY, tsi);
 	da9052_free_irq(tsi->da9052, DA9052_IRQ_PENDOWN, tsi);
-- 
2.7.4
