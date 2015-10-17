From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH] input: lpc32xx_ts: fix warnings caused by enabling unprepared clock
Date: Sat, 17 Oct 2015 21:27:38 +0300
Message-ID: <1445106458-2000-1-git-send-email-vz@mleia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from li271-223.members.linode.com ([178.79.152.223]:57853 "EHLO
	mail.mleia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbbJQS1q (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Oct 2015 14:27:46 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

If common clock framework is configured, the driver generates a warning,
which is fixed by this change:

    root@devkit3250:~# cat /dev/input/touchscreen0
    ------------[ cut here ]------------
    WARNING: CPU: 0 PID: 720 at drivers/clk/clk.c:727 clk_core_enable+0x2c/0xa4()
    Modules linked in: sc16is7xx snd_soc_uda1380
    CPU: 0 PID: 720 Comm: cat Not tainted 4.3.0-rc2+ #199
    Hardware name: LPC32XX SoC (Flattened Device Tree)
    Backtrace:
    [<>] (dump_backtrace) from [<>] (show_stack+0x18/0x1c)
    [<>] (show_stack) from [<>] (dump_stack+0x20/0x28)
    [<>] (dump_stack) from [<>] (warn_slowpath_common+0x90/0xb8)
    [<>] (warn_slowpath_common) from [<>] (warn_slowpath_null+0x24/0x2c)
    [<>] (warn_slowpath_null) from [<>] (clk_core_enable+0x2c/0xa4)
    [<>] (clk_core_enable) from [<>] (clk_enable+0x24/0x38)
    [<>] (clk_enable) from [<>] (lpc32xx_setup_tsc+0x18/0xa0)
    [<>] (lpc32xx_setup_tsc) from [<>] (lpc32xx_ts_open+0x14/0x1c)
    [<>] (lpc32xx_ts_open) from [<>] (input_open_device+0x74/0xb0)
    [<>] (input_open_device) from [<>] (evdev_open+0x110/0x16c)
    [<>] (evdev_open) from [<>] (chrdev_open+0x1b4/0x1dc)
    [<>] (chrdev_open) from [<>] (do_dentry_open+0x1dc/0x2f4)
    [<>] (do_dentry_open) from [<>] (vfs_open+0x6c/0x70)
    [<>] (vfs_open) from [<>] (path_openat+0xb4c/0xddc)
    [<>] (path_openat) from [<>] (do_filp_open+0x40/0x8c)
    [<>] (do_filp_open) from [<>] (do_sys_open+0x124/0x1c4)
    [<>] (do_sys_open) from [<>] (SyS_open+0x2c/0x30)
    [<>] (SyS_open) from [<>] (ret_fast_syscall+0x0/0x38)

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/input/touchscreen/lpc32xx_ts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/lpc32xx_ts.c b/drivers/input/touchscreen/lpc32xx_ts.c
index 24d704c..7fbb3b0 100644
--- a/drivers/input/touchscreen/lpc32xx_ts.c
+++ b/drivers/input/touchscreen/lpc32xx_ts.c
@@ -139,14 +139,14 @@ static void lpc32xx_stop_tsc(struct lpc32xx_tsc *tsc)
 		   tsc_readl(tsc, LPC32XX_TSC_CON) &
 			     ~LPC32XX_TSC_ADCCON_AUTO_EN);
 
-	clk_disable(tsc->clk);
+	clk_disable_unprepare(tsc->clk);
 }
 
 static void lpc32xx_setup_tsc(struct lpc32xx_tsc *tsc)
 {
 	u32 tmp;
 
-	clk_enable(tsc->clk);
+	clk_prepare_enable(tsc->clk);
 
 	tmp = tsc_readl(tsc, LPC32XX_TSC_CON) & ~LPC32XX_TSC_ADCCON_POWER_UP;
 
-- 
2.1.4

