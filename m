From: Sundar R IYER <sundar.iyer@stericsson.com>
Subject: [RFC] input: syfs switches for SKE keypad
Date: Tue, 5 Oct 2010 18:54:42 +0200
Message-ID: <33A307AF30D7BF4F811B1568FE7A9B180460D32FE2@EXDCVYMBSTM006.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:47292 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754880Ab0JEQyz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 5 Oct 2010 12:54:55 -0400
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>

Hi Dmitry,

Meego folks have a requirement for dynamic sysfs switches
for input drivers. I saw a patch from Samu (Nokia) for the same but which
lost its way out.  Here is a small modified patch set for the SKE
driver *only* which completes this requirement and hence a question for
you. (The idea is only a sysfs implemention; its not yet synced in with the
mainline code)

Would you be okay to accept a stand-alone patch like the below for all the
input drivers that we would be pushing in or do you have some comments
or improvements suggested to be folded in the original patch set from Nokia,
so that it can get through into the generic tree?

Regards,
Sundar

--- a/drivers/input/keyboard/nomadik-ske-keypad.c
+++ b/drivers/input/keyboard/nomadik-ske-keypad.c
@@ -47,6 +47,7 @@
  * @board:     keypad platform device
  * @keymap:    matrix scan code table for keycodes
  * @clk:       clock structure pointer
+ * @enable:    flag to enable the driver event
  */
 struct ske_keypad {
        int irq;
@@ -55,9 +56,11 @@ struct ske_keypad {
        struct ske_keypad_platform_data *board;
        unsigned short keymap[SKE_KPD_KEYMAP_SIZE];
        struct clk *clk;
+       bool enable;
 };
 
+static ssize_t ske_show_attr_enable(struct device *dev,
+                       struct device_attribute *attr, char *buf)
+{
+       struct platform_device *pdev = to_platform_device(dev);
+       struct ske_keypad *keypad = platform_get_drvdata(pdev);
+       return sprintf(buf, "%d\n", keypad->enable);
+}
+
+static ssize_t ske_store_attr_enable(struct device *dev,
+               struct device_attribute *attr, const char *buf, size_t count)
+{
+       struct platform_device *pdev = to_platform_device(dev);
+       struct ske_keypad *keypad = platform_get_drvdata(pdev);
+       unsigned long val;
+
+       if (strict_strtoul(buf, 0, &val))
+               return -EINVAL;
+
+       if (keypad->enable != val) {
+               keypad->enable = val;
+               if (!val) {
+                       disable_irq(keypad->irq);
+                       ske_keypad_set_bits(keypad, SKE_IMSC, ~SKE_KPIMA, 0x0);
+                       clk_disable(keypad->clk);
+               } else {
+                       clk_enable(keypad->clk);
+                       enable_irq(keypad->irq);
+                       ske_keypad_set_bits(keypad, SKE_IMSC, 0x0, SKE_KPIMA);
+               }
+       }
+       return count;
+}
+
+static DEVICE_ATTR(enable, S_IWUSR | S_IRUGO,
+       ske_show_attr_enable, ske_store_attr_enable);
+
+static struct attribute *ske_keypad_attrs[] = {
+       &dev_attr_enable.attr,
+       NULL,
+};
+
+static struct attribute_group ske_attr_group = {
+       .attrs = ske_keypad_attrs,
+};
+
 /*
  * ske_keypad_chip_init : init keypad controller configuration
  *
@@ -186,7 +234,7 @@ static int __devinit ske_keypad_probe(struct platform_device *pdev)
        struct input_dev *input;
        struct clk *clk;
        void __iomem *reg_base;
-       int ret;
+       int ret = 0;
        int irq;
        struct ske_keypad_platform_data *plat = pdev->dev.platform_data;
 
@@ -250,6 +298,7 @@ static int __devinit ske_keypad_probe(struct platform_device *pdev)
        input->keycodemax = ARRAY_SIZE(keypad->keymap);
 
        input_set_capability(input, EV_MSC, MSC_SCAN);
+       input_set_drvdata(input, keypad);
 
        __set_bit(EV_KEY, input->evbit);
        if (!plat->no_autorepeat)
@@ -271,6 +320,7 @@ static int __devinit ske_keypad_probe(struct platform_device *pdev)
        keypad->input   = input;
        keypad->reg_base = reg_base;
        keypad->clk     = clk;
+       keypad->enable  = 1;
 
        /* allocations are sane, we begin HW initialization */
        clk_enable(keypad->clk);
@@ -300,12 +350,21 @@ static int __devinit ske_keypad_probe(struct platform_device *pdev)
                goto out_unregisterinput;
        }
 
+       /* sysfs implementation for dynamic enable/disable the input event */
+       ret = sysfs_create_group(&pdev->dev.kobj, &ske_attr_group);
+       if (ret) {
+               dev_err(&pdev->dev, "failed to create sysfs entries\n");
+               goto out_free_irq;
+       }
+
        device_init_wakeup(&pdev->dev, true);
 
        platform_set_drvdata(pdev, keypad);
 
        return 0;
 
+out_free_irq:
+       free_irq(keypad->irq, keypad);
 out_unregisterinput:
        input_unregister_device(input);
        input = NULL;
@@ -330,6 +389,7 @@ static int __devexit ske_keypad_remove(struct platform_device *pdev)
 
        input_unregister_device(keypad->input);
 
+       sysfs_remove_group(&pdev->dev.kobj, &ske_attr_group);
        free_irq(keypad->irq, keypad);
 
        clk_disable(keypad->clk);
