From: Philippe Langlais <philippe.langlais@stericsson.com>
Subject: [PATCH] input: replace request_irq by request_any_context_irq in keyboard GPIO driver
Date: Wed, 12 Jan 2011 10:41:32 +0100
Message-ID: <1294825292-24134-2-git-send-email-philippe.langlais@stericsson.com>
References: <1294825292-24134-1-git-send-email-philippe.langlais@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:52404 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751322Ab1ALJnk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Jan 2011 04:43:40 -0500
In-Reply-To: <1294825292-24134-1-git-send-email-philippe.langlais@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, Philippe Langlais <philippe.langlais@stericsson.com>

Signed-off-by: Philippe Langlais <philippe.langlais@stericsson.com>
---
 drivers/input/keyboard/gpio_keys.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 6069abe..eb30063 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -322,7 +322,7 @@ static void gpio_keys_report_event(struct gpio_button_data *bdata)
 	struct gpio_keys_button *button = bdata->button;
 	struct input_dev *input = bdata->input;
 	unsigned int type = button->type ?: EV_KEY;
-	int state = (gpio_get_value(button->gpio) ? 1 : 0) ^ button->active_low;
+	int state = (gpio_get_value_cansleep(button->gpio) ? 1 : 0) ^ button->active_low;
 
 	input_event(input, type, button->code, !!state);
 	input_sync(input);
@@ -410,8 +410,8 @@ static int __devinit gpio_keys_setup_key(struct platform_device *pdev,
 	if (!button->can_disable)
 		irqflags |= IRQF_SHARED;
 
-	error = request_irq(irq, gpio_keys_isr, irqflags, desc, bdata);
-	if (error) {
+	error = request_any_context_irq(irq, gpio_keys_isr, irqflags, desc, bdata);
+	if (error < 0) {
 		dev_err(dev, "Unable to claim irq %d; error %d\n",
 			irq, error);
 		goto fail3;
-- 
1.7.3.1

