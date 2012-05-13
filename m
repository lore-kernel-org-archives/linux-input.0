From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 7/7] input/nomadik-ske: add sysfs file to enable/disble SKE keypad
Date: Sun, 13 May 2012 14:44:25 +0200
Message-ID: <1336913065-10224-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:59982 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752372Ab2EMMob (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 May 2012 08:44:31 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

From: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>

This sysfs file can force the SKE keypad into GPIO mode (low power)
from userspace if the device knows that it is going to go into
a mode where the keyboard is not going to be interactive.

Signed-off-by: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/input/keyboard/nomadik-ske-keypad.c |   62 +++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/input/keyboard/nomadik-ske-keypad.c
index d2cb4df..74ee59d 100644
--- a/drivers/input/keyboard/nomadik-ske-keypad.c
+++ b/drivers/input/keyboard/nomadik-ske-keypad.c
@@ -193,6 +193,58 @@ static void ske_mode_enable(struct ske_keypad *keypad, bool enable)
 	}
 }
 
+static void ske_enable(struct ske_keypad *keypad, bool enable)
+{
+	keypad->enable = enable;
+	if (keypad->enable) {
+		enable_irq(keypad->irq);
+		ske_mode_enable(keypad, true);
+	} else {
+		ske_mode_enable(keypad, false);
+		disable_irq(keypad->irq);
+	}
+}
+
+static ssize_t ske_show_attr_enable(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct ske_keypad *keypad = platform_get_drvdata(pdev);
+	return sprintf(buf, "%d\n", keypad->enable);
+}
+
+static ssize_t ske_store_attr_enable(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct ske_keypad *keypad = platform_get_drvdata(pdev);
+	unsigned long val;
+
+	if (strict_strtoul(buf, 0, &val))
+		return -EINVAL;
+
+	if ((val != 0) && (val != 1))
+		return -EINVAL;
+
+	if (keypad->enable != val) {
+		keypad->enable = val ? true : false;
+		ske_enable(keypad, keypad->enable);
+	}
+	return count;
+}
+
+static DEVICE_ATTR(enable, S_IWUSR | S_IRUGO,
+	ske_show_attr_enable, ske_store_attr_enable);
+
+static struct attribute *ske_keypad_attrs[] = {
+	&dev_attr_enable.attr,
+	NULL,
+};
+
+static struct attribute_group ske_attr_group = {
+	.attrs = ske_keypad_attrs,
+};
+
 static void ske_keypad_report(struct ske_keypad *keypad, u8 status, int col)
 {
 	int row = 0, code, pos;
@@ -634,10 +686,19 @@ no_wakeup:
 		goto out_unregisterinput;
 	}
 
+	/* sysfs implementation for dynamic enable/disable the input event */
+	ret = sysfs_create_group(&pdev->dev.kobj, &ske_attr_group);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to create sysfs entries\n");
+		goto out_free_irq;
+	}
+
 	platform_set_drvdata(pdev, keypad);
 
 	return 0;
 
+out_free_irq:
+	free_irq(keypad->irq, keypad);
 out_unregisterinput:
 	input_unregister_device(input);
 	input = NULL;
@@ -666,6 +727,7 @@ static int __devexit ske_keypad_remove(struct platform_device *pdev)
 	cancel_delayed_work_sync(&keypad->scan_work);
 
 	input_unregister_device(keypad->input);
+	sysfs_remove_group(&pdev->dev.kobj, &ske_attr_group);
 	if (keypad->enable)
 		clk_disable(keypad->clk);
 	clk_put(keypad->clk);
-- 
1.7.9.2

