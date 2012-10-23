From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: [PATCH 2/2] input: gpio_keys: add pinctrl consumer
Date: Tue, 23 Oct 2012 15:29:02 +0200
Message-ID: <1350998942-713-2-git-send-email-plagnioj@jcrosoft.com>
References: <20121023131627.GE18964@game.jcrosoft.org>
 <1350998942-713-1-git-send-email-plagnioj@jcrosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1350998942-713-1-git-send-email-plagnioj@jcrosoft.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

If no pinctrl available just report a warning as some architecture may not
need to do anything.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-input@vger.kernel.org
---
 drivers/input/keyboard/gpio_keys.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 6a68041..c0432fe 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -29,6 +29,7 @@
 #include <linux/of_platform.h>
 #include <linux/of_gpio.h>
 #include <linux/spinlock.h>
+#include <linux/pinctrl/consumer.h>
 
 struct gpio_button_data {
 	const struct gpio_keys_button *button;
@@ -666,6 +667,7 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 	struct input_dev *input;
 	int i, error;
 	int wakeup = 0;
+	struct pinctrl *pinctrl;
 
 	if (!pdata) {
 		pdata = gpio_keys_get_devtree_pdata(dev);
@@ -673,6 +675,15 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 			return PTR_ERR(pdata);
 	}
 
+	pinctrl = devm_pinctrl_get_select_default(dev);
+	if (IS_ERR(pinctrl)) {
+		error = PTR_ERR(pinctrl);
+		if (error == -EPROBE_DEFER)
+			return error;
+
+		dev_warn(dev, "No pinctrl provided\n");
+	}
+
 	ddata = kzalloc(sizeof(struct gpio_keys_drvdata) +
 			pdata->nbuttons * sizeof(struct gpio_button_data),
 			GFP_KERNEL);
-- 
1.7.10.4
