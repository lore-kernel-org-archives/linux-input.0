From: stephen lu <lumotuwe@gmail.com>
Subject: [PATCH] input: gpio-keys: Convert timers to use timer_setup()
Date: Mon, 23 Oct 2017 16:21:51 +0800
Message-ID: <CABCPcVWqeiJNWfow34ouSwvtKoDF+egFQjXtqt+iPwNUKwgc7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:53658 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbdJWIVw (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 23 Oct 2017 04:21:52 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linus.walleij@linaro.org, linux@roeck-us.net, jacek.anaszewski@gmail.com, boris.brezillon@free-electrons.com, andriy.shevchenko@linux.intel.com, alexander.stein@systec-electronic.com, hdegoede@redhat.com, geert+renesas@glider.be, josephl@nvidia.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Signed-off-by: Stephen Lu <lumotuwe@gmail.com>

---
 drivers/input/keyboard/gpio_keys.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c
b/drivers/input/keyboard/gpio_keys.c
index e9f0ebf..25ddc33 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -419,9 +419,9 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
        return IRQ_HANDLED;
 }

-static void gpio_keys_irq_timer(unsigned long _data)
+static void gpio_keys_irq_timer(struct timer_list *t)
 {
-       struct gpio_button_data *bdata = (struct gpio_button_data *)_data;
+       struct gpio_button_data *bdata = from_timer(bdata, t, release_timer);
        struct input_dev *input = bdata->input;
        unsigned long flags;

@@ -584,6 +584,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
                bdata->release_delay = button->debounce_interval;
                setup_timer(&bdata->release_timer,
                            gpio_keys_irq_timer, (unsigned long)bdata);
+               timer_setup(&bdata->release_timer,
+                           gpio_keys_irq_timer, 0);

                isr = gpio_keys_irq_isr;
                irqflags = 0;
-- 
1.9.1
