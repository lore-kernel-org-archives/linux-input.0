From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: [PATCH] input: gpio_keys: Don't report events on gpio failure
Date: Mon, 27 Jul 2015 18:50:04 -0700
Message-ID: <1438048204-632-1-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-input@vger.kernel.org

In the cases where the gpio chip fails to acquire the current state an
error is reported back to gpio_keys. This is currently interpreted as if
the line went high, which just confuses the developer.

This patch introduces an error print in this case and skipps the
reporting of a input event; to aid in debugging this issue.

Reported-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 drivers/input/keyboard/gpio_keys.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index ddf4045de084..3ce3298ac09e 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -336,8 +336,14 @@ static void gpio_keys_gpio_report_event(struct gpio_button_data *bdata)
 	const struct gpio_keys_button *button = bdata->button;
 	struct input_dev *input = bdata->input;
 	unsigned int type = button->type ?: EV_KEY;
-	int state = (gpio_get_value_cansleep(button->gpio) ? 1 : 0) ^ button->active_low;
+	int state = gpio_get_value_cansleep(button->gpio);
 
+	if (state < 0) {
+		dev_err(input->dev.parent, "failed to get gpio state\n");
+		return;
+	}
+
+	state = (state ? 1 : 0) ^ button->active_low;
 	if (type == EV_ABS) {
 		if (state)
 			input_event(input, type, button->code, button->value);
-- 
1.8.2.2
