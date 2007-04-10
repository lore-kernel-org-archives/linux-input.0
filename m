From: Roman Moravcik <roman.moravcik@gmail.com>
Subject: [PATCH] gpio_keys ev_sw support
Date: Tue, 10 Apr 2007 18:53:48 +0200
Message-ID: <461BC11C.7020401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
Cc: kernel-discuss@handhelds.org
List-Id: linux-input@vger.kernel.org

This patch adds software event support to gpio_keys driver.

Signed-off-by: Roman Moravcik <roman.moravcik@gmail.com>

diff -Naur a/drivers/input/keyboard/gpio_keys.c 
b/drivers/input/keyboard/gpio_keys.c
--- a/drivers/input/keyboard/gpio_keys.c    2007-02-25 
19:50:43.000000000 +0100
+++ b/drivers/input/keyboard/gpio_keys.c    2007-04-05 
22:53:02.000000000 +0200
@@ -39,7 +39,10 @@
         if (irq == gpio_to_irq(gpio)) {
             int state = (gpio_get_value(gpio) ? 1 : 0) ^ 
(pdata->buttons[i].active_low);
 
-            input_report_key(input, pdata->buttons[i].keycode, state);
+            if (pdata->buttons[i].type == EV_SW)
+                input_report_switch(input, pdata->buttons[i].keycode, 
state);
+            else
+                input_report_key(input, pdata->buttons[i].keycode, state);
             input_sync(input);
         }
     }
@@ -59,7 +62,7 @@
 
     platform_set_drvdata(pdev, input);
 
-    input->evbit[0] = BIT(EV_KEY);
+    input->evbit[0] = BIT(EV_KEY) | BIT(EV_SW);
 
     input->name = pdev->name;
     input->phys = "gpio-keys/input0";
@@ -84,7 +87,10 @@
                 irq, error);
             goto fail;
         }
-        set_bit(code, input->keybit);
+        if (pdata->buttons[i].type == EV_SW)
+            set_bit(code, input->swbit);
+        else
+            set_bit(code, input->keybit);
     }
 
     error = input_register_device(input);
diff -Naur a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
--- a/include/linux/gpio_keys.h    2007-02-25 16:21:52.000000000 +0100
+++ b/include/linux/gpio_keys.h    2007-04-05 20:23:31.000000000 +0200
@@ -6,6 +6,7 @@
     int gpio;
     int active_low;
     char *desc;
+    int type;
 };
 
 struct gpio_keys_platform_data {
