From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] input: touchscreen: wm97xx-core: Fix possible null-pointer dereferences in wm97xx_ts_input_open()
Date: Fri, 26 Jul 2019 16:48:16 +0800
Message-ID: <20190726084816.8487-1-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org, tglx@linutronix.de, allison@lohutok.net, rdunlap@infradead.org
Cc: patches@opensource.cirrus.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: linux-input@vger.kernel.org

In wm97xx_ts_input_open(), there is an if statement on line 507 to check
whether wm->mach_ops is NULL:
    if (wm->mach_ops && wm->mach_ops->acc_enabled)

When wm->mach_ops is NULL, it is used on line 521:
    wm97xx_init_pen_irq(wm);
        BUG_ON(!wm->mach_ops->irq_enable);
        BUG_ON(!wm->mach_ops->irq_gpio);
        wm97xx_reg_write(..., reg & ~(wm->mach_ops->irq_gpio))

Thus, possible null-pointer dereferences may occur.

To fix these bugs, wm->mach_ops is checked before calling
wm97xx_init_pen_irq().

These bugs found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/input/touchscreen/wm97xx-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index 0a174bd82915..f7bd0726a577 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -517,7 +517,7 @@ static int wm97xx_ts_input_open(struct input_dev *idev)
 	wm->ts_reader_interval = wm->ts_reader_min_interval;
 
 	wm->pen_is_down = 0;
-	if (wm->pen_irq)
+	if (wm->pen_irq && wm->mach_ops)
 		wm97xx_init_pen_irq(wm);
 	else
 		dev_err(wm->dev, "No IRQ specified\n");
-- 
2.17.0
