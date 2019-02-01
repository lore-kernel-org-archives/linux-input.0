From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] Input: gpio-keys - Add shutdown callback
Date: Fri,  1 Feb 2019 11:24:15 -0800
Message-ID: <20190201192417.15037-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, Rob Herring <robh@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "open list:INPUT KEYBOARD, MOUSE, JOYSTICK
        , TOUCHSCREEN..." <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On some platforms (e.g.: ARCH_BRCMSTB) it is possible to enter
"poweroff" while leaving some wake-up sources enabled such as key
presses in order to allow for the system to wake-up.

Wire up a .shutdown() callback which calls into the existing
gpio_keys_suspend() since the logic is essentially the same.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/input/keyboard/gpio_keys.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 492a971b95b5..6cd199e8a370 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -1015,8 +1015,18 @@ static int __maybe_unused gpio_keys_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(gpio_keys_pm_ops, gpio_keys_suspend, gpio_keys_resume);
 
+static void gpio_keys_shutdown(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = gpio_keys_suspend(&pdev->dev);
+	if (ret)
+		dev_err(&pdev->dev, "failed to shutdown\n");
+}
+
 static struct platform_driver gpio_keys_device_driver = {
 	.probe		= gpio_keys_probe,
+	.shutdown	= gpio_keys_shutdown,
 	.driver		= {
 		.name	= "gpio-keys",
 		.pm	= &gpio_keys_pm_ops,
-- 
2.17.1
