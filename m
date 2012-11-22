From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/2] input: gpio-keys: Disable hardware on suspend
Date: Thu, 22 Nov 2012 13:23:36 +0000
Message-ID: <1353590617-11466-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linus.walleij@stericsson.com, Jonas Aaberg <jonas.aberg@stericsson.com>, Philippe Langlais <philippe.langlais@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, arnd@arndb.de, linux-input@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-input@vger.kernel.org

From: Jonas Aaberg <jonas.aberg@stericsson.com>

Disable hardware if active when suspending if the hw can not
wake the system from suspend.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
Signed-off-by: Philippe Langlais <philippe.langlais@linaro.org>
Reviewed-by: Bengt Jonsson <bengt.g.jonsson@stericsson.com>
---
 drivers/input/keyboard/gpio_keys.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 6a68041..2cf6757 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -46,6 +46,8 @@ struct gpio_keys_drvdata {
 	const struct gpio_keys_platform_data *pdata;
 	struct input_dev *input;
 	struct mutex disable_lock;
+	bool enabled;
+	bool enable_after_suspend;
 	struct gpio_button_data data[0];
 };
 
@@ -531,6 +533,8 @@ static int gpio_keys_open(struct input_dev *input)
 	struct gpio_keys_drvdata *ddata = input_get_drvdata(input);
 	const struct gpio_keys_platform_data *pdata = ddata->pdata;
 
+	ddata->enabled = true;
+
 	return pdata->enable ? pdata->enable(input->dev.parent) : 0;
 }
 
@@ -539,6 +543,8 @@ static void gpio_keys_close(struct input_dev *input)
 	struct gpio_keys_drvdata *ddata = input_get_drvdata(input);
 	const struct gpio_keys_platform_data *pdata = ddata->pdata;
 
+	ddata->enabled = false;
+
 	if (pdata->disable)
 		pdata->disable(input->dev.parent);
 }
@@ -685,6 +691,7 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 
 	ddata->pdata = pdata;
 	ddata->input = input;
+	ddata->enabled = false;
 	mutex_init(&ddata->disable_lock);
 
 	platform_set_drvdata(pdev, ddata);
@@ -796,6 +803,10 @@ static int gpio_keys_suspend(struct device *dev)
 			if (bdata->button->wakeup)
 				enable_irq_wake(bdata->irq);
 		}
+	} else {
+		ddata->enable_after_suspend = ddata->enabled;
+		if (ddata->enabled)
+			gpio_keys_close(ddata->input);
 	}
 
 	return 0;
@@ -814,6 +825,10 @@ static int gpio_keys_resume(struct device *dev)
 		if (gpio_is_valid(bdata->button->gpio))
 			gpio_keys_gpio_report_event(bdata);
 	}
+
+	if (!device_may_wakeup(dev) && ddata->enable_after_suspend)
+		gpio_keys_open(ddata->input);
+
 	input_sync(ddata->input);
 
 	return 0;
-- 
1.7.9.5
