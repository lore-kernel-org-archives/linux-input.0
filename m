From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/6] Input: gpio_keys - annotate PM methods as __maybe_unused
Date: Fri, 28 Oct 2016 16:14:41 -0700
Message-ID: <1477696485-6995-3-git-send-email-dmitry.torokhov@gmail.com>
References: <1477696485-6995-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477696485-6995-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Instead of using #ifdef, let's mark suspend and resume methods as
__maybe_unused to provide better compile coverage.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/gpio_keys.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 890eb39..8f7c20b 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -814,8 +814,7 @@ static int gpio_keys_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int gpio_keys_suspend(struct device *dev)
+static int __maybe_unused gpio_keys_suspend(struct device *dev)
 {
 	struct gpio_keys_drvdata *ddata = dev_get_drvdata(dev);
 	struct input_dev *input = ddata->input;
@@ -837,7 +836,7 @@ static int gpio_keys_suspend(struct device *dev)
 	return 0;
 }
 
-static int gpio_keys_resume(struct device *dev)
+static int __maybe_unused gpio_keys_resume(struct device *dev)
 {
 	struct gpio_keys_drvdata *ddata = dev_get_drvdata(dev);
 	struct input_dev *input = ddata->input;
@@ -863,7 +862,6 @@ static int gpio_keys_resume(struct device *dev)
 	gpio_keys_report_state(ddata);
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(gpio_keys_pm_ops, gpio_keys_suspend, gpio_keys_resume);
 
-- 
2.8.0.rc3.226.g39d4020
