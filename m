From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH v3 2/3] bfin_rotary: Move peripheral pinmux definition into platform data of bf527
Date: Wed, 4 Feb 2015 15:58:04 +0800
Message-ID: <1423036686-31891-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bn1on0079.outbound.protection.outlook.com ([157.56.110.79]:19534
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751287AbbBDIAm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Feb 2015 03:00:42 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>, adi-buildroot-devel@lists.sourceforge.net, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

v3-changes:
- Pinctrl API is used to set up counter pinmux on bf548 and bf609. Pinmux list is use less on bf548 and bf609.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 arch/blackfin/mach-bf527/boards/ad7160eval.c |    8 ++++++++
 arch/blackfin/mach-bf527/boards/ezkit.c      |    8 ++++++++
 drivers/input/misc/bfin_rotary.c             |   12 +++---------
 include/linux/platform_data/bfin_rotary.h    |    1 +
 4 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/blackfin/mach-bf527/boards/ad7160eval.c b/arch/blackfin/mach-bf527/boards/ad7160eval.c
index beb011b..029a050 100644
--- a/arch/blackfin/mach-bf527/boards/ad7160eval.c
+++ b/arch/blackfin/mach-bf527/boards/ad7160eval.c
@@ -668,6 +668,13 @@ static struct platform_device bfin_sport1_uart_device = {
 #if IS_ENABLED(CONFIG_INPUT_BFIN_ROTARY)
 #include <linux/platform_data/bfin_rotary.h>
 
+static const u16 per_cnt[] = {
+	P_CNT_CUD,
+	P_CNT_CDG,
+	P_CNT_CZM,
+	0
+};
+
 static struct bfin_rotary_platform_data bfin_rotary_data = {
 	/*.rotary_up_key     = KEY_UP,*/
 	/*.rotary_down_key   = KEY_DOWN,*/
@@ -676,6 +683,7 @@ static struct bfin_rotary_platform_data bfin_rotary_data = {
 	.debounce	   = 10,	/* 0..17 */
 	.mode		   = ROT_QUAD_ENC | ROT_DEBE,
 	.pm_wakeup	   = 1,
+	.pin_list	   = per_cnt,
 };
 
 static struct resource bfin_rotary_resources[] = {
diff --git a/arch/blackfin/mach-bf527/boards/ezkit.c b/arch/blackfin/mach-bf527/boards/ezkit.c
index 728cda4..cc80c5b 100644
--- a/arch/blackfin/mach-bf527/boards/ezkit.c
+++ b/arch/blackfin/mach-bf527/boards/ezkit.c
@@ -1094,6 +1094,13 @@ static struct platform_device bfin_device_gpiokeys = {
 #if IS_ENABLED(CONFIG_INPUT_BFIN_ROTARY)
 #include <linux/platform_data/bfin_rotary.h>
 
+static const u16 per_cnt[] = {
+	P_CNT_CUD,
+	P_CNT_CDG,
+	P_CNT_CZM,
+	0
+};
+
 static struct bfin_rotary_platform_data bfin_rotary_data = {
 	/*.rotary_up_key     = KEY_UP,*/
 	/*.rotary_down_key   = KEY_DOWN,*/
@@ -1102,6 +1109,7 @@ static struct bfin_rotary_platform_data bfin_rotary_data = {
 	.debounce	   = 10,	/* 0..17 */
 	.mode		   = ROT_QUAD_ENC | ROT_DEBE,
 	.pm_wakeup	   = 1,
+	.pin_list	   = per_cnt,
 };
 
 static struct resource bfin_rotary_resources[] = {
diff --git a/drivers/input/misc/bfin_rotary.c b/drivers/input/misc/bfin_rotary.c
index 8f6c7cd..dd62fc9 100644
--- a/drivers/input/misc/bfin_rotary.c
+++ b/drivers/input/misc/bfin_rotary.c
@@ -16,13 +16,6 @@
 
 #include <asm/portmux.h>
 
-static const u16 per_cnt[] = {
-	P_CNT_CUD,
-	P_CNT_CDG,
-	P_CNT_CZM,
-	0
-};
-
 struct bfin_rot {
 	struct input_dev *input;
 	int irq;
@@ -102,7 +95,7 @@ static int bfin_rotary_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	error = peripheral_request_list(per_cnt, dev_name(&pdev->dev));
+	error = peripheral_request_list(pdata->pin_list, dev_name(&pdev->dev));
 	if (error) {
 		dev_err(&pdev->dev, "requesting peripherals failed\n");
 		return error;
@@ -197,6 +190,7 @@ out1:
 
 static int bfin_rotary_remove(struct platform_device *pdev)
 {
+	struct bfin_rotary_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct bfin_rot *rotary = platform_get_drvdata(pdev);
 
 	bfin_write_CNT_CONFIG(0);
@@ -204,7 +198,7 @@ static int bfin_rotary_remove(struct platform_device *pdev)
 
 	free_irq(rotary->irq, pdev);
 	input_unregister_device(rotary->input);
-	peripheral_free_list(per_cnt);
+	peripheral_free_list(pdata->pin_list);
 
 	kfree(rotary);
 
diff --git a/include/linux/platform_data/bfin_rotary.h b/include/linux/platform_data/bfin_rotary.h
index 8895a75..9882937 100644
--- a/include/linux/platform_data/bfin_rotary.h
+++ b/include/linux/platform_data/bfin_rotary.h
@@ -40,6 +40,7 @@ struct bfin_rotary_platform_data {
 	unsigned short debounce;	/* 0..17 */
 	unsigned short mode;
 	unsigned short pm_wakeup;
+	unsigned short *pin_list;
 };
 
 /* CNT_CONFIG bitmasks */
-- 
1.7.9.5

