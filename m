From: Barry Song <21cnbao@gmail.com>
Subject: [RFC PATCH] Input: gpio_keys - trigger input event if key is pressed
 in boot stage
Date: Wed, 20 May 2015 18:02:36 +0800
Message-ID: <CAGsJ_4z-CZShfCQ2JNgOKX1dtfGksX+Naj++4tugPCriiY=ESg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33027 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453AbbETKC5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 May 2015 06:02:57 -0400
Received: by padbw4 with SMTP id bw4so61608697pad.0
        for <linux-input@vger.kernel.org>; Wed, 20 May 2015 03:02:56 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Andy.Sun@csr.com

sometimes we press a key to boot, and the boot stage need to get this
event.
the current codes use edge trigger, so we have no chance to report
the cold-touch event.
but our user sceneries like Linux navigator does need it.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 -RFC: for the moment, only an idea

 drivers/input/keyboard/gpio_keys.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c
b/drivers/input/keyboard/gpio_keys.c
index ddf4045..77fe0dd 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -766,6 +766,19 @@ static int gpio_keys_probe(struct platform_device *pdev)

     device_init_wakeup(&pdev->dev, wakeup);

+    /* if the key is pressed while system boot, force an interrupt */
+    for (i = 0; i < pdata->nbuttons; i++) {
+        const struct gpio_keys_button *button = &pdata->buttons[i];
+        struct gpio_button_data *bdata = &ddata->data[i];
+        int state;
+
+        if (gpio_is_valid(button->gpio)) {
+            state = (gpio_get_value_cansleep(button->gpio) ? 1 : 0) ^
button->active_low;
+            if (state)
+                gpio_keys_gpio_isr(bdata->irq, bdata);
+        }
+    }
+
     return 0;

 err_remove_group:
-- 
1.9.1
