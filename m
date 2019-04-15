From: Bogdan Togorean <bogdan.togorean@analog.com>
Subject: [PATCH 1/1] input: adp5589: Add gpio_set_multiple interface
Date: Mon, 15 Apr 2019 15:25:25 +0300
Message-ID: <20190415122525.2576-1-bogdan.togorean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, gustavo@embeddedor.com, linux-kernel@vger.kernel.org, Bogdan Togorean <bogdan.togorean@analog.com>
List-Id: linux-input@vger.kernel.org

This patch implements the gpio_set_multiple interface for ADP558x chip.

Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
---
 drivers/input/keyboard/adp5589-keys.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/input/keyboard/adp5589-keys.c b/drivers/input/keyboard/adp5589-keys.c
index 2835fba71c33..143871bd60ef 100644
--- a/drivers/input/keyboard/adp5589-keys.c
+++ b/drivers/input/keyboard/adp5589-keys.c
@@ -416,6 +416,30 @@ static void adp5589_gpio_set_value(struct gpio_chip *chip,
 	mutex_unlock(&kpad->gpio_lock);
 }
 
+static void adp5589_gpio_set_multiple(struct gpio_chip *chip,
+				      unsigned long *mask, unsigned long *bits)
+{
+	struct adp5589_kpad *kpad = container_of(chip, struct adp5589_kpad, gc);
+	u8 bank, reg_mask, reg_bits;
+
+	mutex_lock(&kpad->gpio_lock);
+
+	for (bank = 0; bank <= kpad->var->bank(kpad->var->maxgpio); bank++) {
+		if (bank > kpad->var->bank(get_bitmask_order(*mask) - 1))
+			break;
+		reg_mask = mask[bank / sizeof(*mask)] >>
+			   ((bank % sizeof(*mask)) * BITS_PER_BYTE);
+		reg_bits = bits[bank / sizeof(*bits)] >>
+			   ((bank % sizeof(*bits)) * BITS_PER_BYTE);
+		kpad->dat_out[bank] &= ~reg_mask;
+		kpad->dat_out[bank] |= reg_bits & reg_mask;
+		adp5589_write(kpad->client, kpad->var->reg(ADP5589_GPO_DATA_OUT_A) + bank,
+			      kpad->dat_out[bank]);
+	}
+
+	mutex_unlock(&kpad->gpio_lock);
+}
+
 static int adp5589_gpio_direction_input(struct gpio_chip *chip, unsigned off)
 {
 	struct adp5589_kpad *kpad = gpiochip_get_data(chip);
@@ -517,6 +541,7 @@ static int adp5589_gpio_add(struct adp5589_kpad *kpad)
 	kpad->gc.direction_output = adp5589_gpio_direction_output;
 	kpad->gc.get = adp5589_gpio_get_value;
 	kpad->gc.set = adp5589_gpio_set_value;
+	kpad->gc.set_multiple = adp5589_gpio_set_multiple;
 	kpad->gc.can_sleep = 1;
 
 	kpad->gc.base = gpio_data->gpio_start;
-- 
2.21.0
