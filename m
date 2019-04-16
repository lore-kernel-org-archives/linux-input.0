From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 4/4] input: keyboard: gpio-keys-polled: skip oftree code when CONFIG_OF disabled
Date: Tue, 16 Apr 2019 21:57:25 +0200
Message-ID: <1555444645-15156-5-git-send-email-info@metux.net>
References: <1555444645-15156-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555444645-15156-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

we don't need to build in oftree probing stuff when oftree isn't
enabled at all.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/input/keyboard/gpio_keys_polled.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index 3f773b2..fbccb89 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -147,6 +147,7 @@ static void gpio_keys_polled_close(struct input_polled_dev *dev)
 static struct gpio_keys_platform_data *
 gpio_keys_polled_get_devtree_pdata(struct device *dev)
 {
+#ifdef CONFIG_OF
 	struct gpio_keys_platform_data *pdata;
 	struct gpio_keys_button *button;
 	struct fwnode_handle *child;
@@ -200,6 +201,9 @@ static void gpio_keys_polled_close(struct input_polled_dev *dev)
 	}
 
 	return pdata;
+#else /* CONFIG_OF */
+	return ERR_PTR(-ENOENT);
+#endif /* CONFIG_OF */
 }
 
 static void gpio_keys_polled_set_abs_params(struct input_dev *input,
@@ -226,7 +230,7 @@ static void gpio_keys_polled_set_abs_params(struct input_dev *input,
 	{ .compatible = "gpio-keys-polled", },
 	{ },
 };
-MODULE_DEVICE_TABLE(of, gpio_keys_polled_of_match);
+MODULE_DEVICE_TABLE_OF(gpio_keys_polled_of_match);
 
 static struct gpio_desc *gpio_keys_polled_get_gpiod_fwnode(
 	struct device *dev,
@@ -452,7 +456,9 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 	.probe	= gpio_keys_polled_probe,
 	.driver	= {
 		.name	= DRV_NAME,
+#ifdef CONFIG_OF
 		.of_match_table = gpio_keys_polled_of_match,
+#endif /* CONFIG_OF */
 	},
 };
 module_platform_driver(gpio_keys_polled_driver);
-- 
1.9.1
