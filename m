From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/2] Input: gpio_keys - Also send release events for ABS codes
Date: Tue,  1 Nov 2016 11:25:03 +0100
Message-ID: <20161101102504.3783-2-paul@crapouillou.net>
References: <20161101102504.3783-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161101102504.3783-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Laxman Dewangan <ldewangan@nvidia.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Maarten ter Huurne <maarten@treewalker.org>, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-input@vger.kernel.org

Right now, the gpio-keys driver is mostly used with EV_KEY event types.
However, this driver (and its devicetree bindings) support specifying
a different input type, like EV_ABS, even though this doesn't work in
practice: "key pressed" events are correctly received and treated, but
"key released" are silently ignored.

With this commit, keys configured as EV_ABS will inject an event with
the value 0 when released.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/input/keyboard/gpio_keys.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 2909365..7018c49 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -369,6 +369,8 @@ static void gpio_keys_gpio_report_event(struct gpio_button_data *bdata)
 	if (type == EV_ABS) {
 		if (state)
 			input_event(input, type, button->code, button->value);
+		else
+			input_event(input, type, button->code, 0);
 	} else {
 		input_event(input, type, button->code, !!state);
 	}
-- 
2.9.3
