From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4/6] Input: gpio_keys - fix leaking DT node references
Date: Fri, 28 Oct 2016 16:14:42 -0700
Message-ID: <1477696485-6995-4-git-send-email-dmitry.torokhov@gmail.com>
References: <1477696485-6995-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33246 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034432AbcJ1XOu (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 28 Oct 2016 19:14:50 -0400
In-Reply-To: <1477696485-6995-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org

for_each_available_child_of_node(node, pp) takes reference to 'pp' and
drops it when attempting next iteration. However if we exit the loop early
we need to drop the reference ourselves.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/gpio_keys.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 8f7c20b..d75a25c 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -659,6 +659,7 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 					dev_err(dev,
 						"Failed to get gpio flags, error: %d\n",
 						error);
+				of_node_put(pp);
 				return ERR_PTR(error);
 			}
 		} else {
@@ -669,12 +670,14 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 
 		if (!gpio_is_valid(button->gpio) && !button->irq) {
 			dev_err(dev, "Found button without gpios or irqs\n");
+			of_node_put(pp);
 			return ERR_PTR(-EINVAL);
 		}
 
 		if (of_property_read_u32(pp, "linux,code", &button->code)) {
 			dev_err(dev, "Button without keycode: 0x%x\n",
 				button->gpio);
+			of_node_put(pp);
 			return ERR_PTR(-EINVAL);
 		}
 
-- 
2.8.0.rc3.226.g39d4020

