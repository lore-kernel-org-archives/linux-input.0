From: Mukesh Sharma <mukesh.sharma091@gmail.com>
Subject: [PATCH] Input:Avoid extra comparision in report_event api
Date: Thu, 29 Jan 2015 10:56:38 -0800
Message-ID: <1422557798-106138-1-git-send-email-mukesh.sharma091@gmail.com>
References: <mukesh.sharma091@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:54977 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838AbbA2S5H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Jan 2015 13:57:07 -0500
Received: by mail-wi0-f182.google.com with SMTP id n3so28558341wiv.3
        for <linux-input@vger.kernel.org>; Thu, 29 Jan 2015 10:57:05 -0800 (PST)
In-Reply-To: <mukesh.sharma091@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru, linux-input@vger.kernel.org
Cc: aksgarg1989@gmail.com, mukesh.sharma091@gmail.com

From: Mukesh Sharma <mukesh.sharma091@gmail.com>

Set button->type to EV_KEY if no type is defined by platform or device
tree structure hence we can remove the extra comparision operation from
gpio_keys_gpio_report_event.

Signed-off-by: Mukesh Sharma <mukesh.sharma091@gmail.com>
---
 drivers/input/keyboard/gpio_keys.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 883d6ae..9256ff9 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -335,14 +335,13 @@ static void gpio_keys_gpio_report_event(struct gpio_button_data *bdata)
 {
 	const struct gpio_keys_button *button = bdata->button;
 	struct input_dev *input = bdata->input;
-	unsigned int type = button->type ?: EV_KEY;
 	int state = (gpio_get_value_cansleep(button->gpio) ? 1 : 0) ^ button->active_low;
 
-	if (type == EV_ABS) {
+	if (button->type == EV_ABS) {
 		if (state)
-			input_event(input, type, button->code, button->value);
+			input_event(input, button->type, button->code, button->value);
 	} else {
-		input_event(input, type, button->code, !!state);
+		input_event(input, button->type, button->code, !!state);
 	}
 	input_sync(input);
 }
@@ -507,8 +506,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 		isr = gpio_keys_irq_isr;
 		irqflags = 0;
 	}
-
-	input_set_capability(input, button->type ?: EV_KEY, button->code);
+	button->type = button->type ?: EV_KEY;
+	input_set_capability(input, button->type, button->code);
 
 	/*
 	 * Install custom action to cancel release timer and
-- 
1.7.9.5


---
This email has been checked for viruses by Avast antivirus software.
http://www.avast.com

