From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: gpio_keys_polled - fix DT node reference leak
Date: Thu, 20 Oct 2016 15:06:36 -0700
Message-ID: <20161020220636.GA17948@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32807 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754657AbcJTWGk (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 20 Oct 2016 18:06:40 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org

When someone requests button with wakeup (which this driver does not
support) we should drop reference to the current child device node before
returning error.

Note that when we using legacy platform data 'child' stays NULL which
fwnode_handle_put() handles just fine.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/gpio_keys_polled.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index 270dcf7..72b3503 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -291,6 +291,7 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 
 		if (button->wakeup) {
 			dev_err(dev, DRV_NAME " does not support wakeup\n");
+			fwnode_handle_put(child);
 			return -EINVAL;
 		}
 
-- 
2.8.0.rc3.226.g39d4020


-- 
Dmitry
