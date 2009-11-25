From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] input_ gpio_keys: scan gpio state at probe time
Date: Wed, 25 Nov 2009 11:53:36 +0100
Message-ID: <1259146416-6713-1-git-send-email-daniel@caiaq.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:58368 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934121AbZKYKxk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Nov 2009 05:53:40 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Daniel Mack <daniel@caiaq.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jani Nikula <ext-jani.1.nikula@nokia.com>, Mike Rapoport <mike@compulab.co.il>

gpio_keys.c registers interrupts at both edges of all given gpio lines
and updates the input device when they change. However, the driver fails
to check the current line state at probe time.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jani Nikula <ext-jani.1.nikula@nokia.com>
Cc: Mike Rapoport <mike@compulab.co.il>
---
 drivers/input/keyboard/gpio_keys.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 77d1309..cb5f862 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -171,6 +171,18 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 		goto fail2;
 	}
 
+	/* get current state of buttons */
+	for (i = 0; i < pdata->nbuttons; i++) {
+		struct gpio_keys_button *button = &pdata->buttons[i];
+		int state = !!gpio_get_value(button->gpio) ^ button->active_low;
+
+		if (state) {
+			unsigned int type = button->type ?: EV_KEY;
+			input_event(input, type, button->code, !!state);
+			input_sync(input);
+		}
+	}
+
 	device_init_wakeup(&pdev->dev, wakeup);
 
 	return 0;
-- 
1.6.5.2

