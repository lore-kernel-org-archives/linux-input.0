From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: WM9712 GPIO
Date: Wed, 12 May 2010 13:47:12 +0200
Message-ID: <AANLkTikXR3vlUg-XX33LCrAiVxk0nJWNe__7SU7g1DuF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56422 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755570Ab0ELLrO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 May 2010 07:47:14 -0400
Received: by fxm15 with SMTP id 15so247231fxm.19
        for <linux-input@vger.kernel.org>; Wed, 12 May 2010 04:47:12 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org

Hi Mark,

I'm playing with the GPIO interface on a WM9712G, specifically GPIO1
and 2 of the chip.
However I'm unable to get the chip to toggle any of these pins.

Setup is:

[...]
	wm97xx_config_gpio(wm, WM97XX_GPIO_1, WM97XX_GPIO_OUT,
			   WM97XX_GPIO_POL_HIGH, WM97XX_GPIO_NOTSTICKY,
			   WM97XX_GPIO_NOWAKE);
	wm97xx_config_gpio(wm, WM97XX_GPIO_2, WM97XX_GPIO_OUT,
			   WM97XX_GPIO_POL_HIGH, WM97XX_GPIO_NOTSTICKY,
			   WM97XX_GPIO_NOWAKE);

	mutex_lock(&wm->codec_mutex);
	reg = wm97xx_reg_read(wm, 0x56);
	if (reg == -1)
		printk(KERN_ERR "WM97XX: register 0x56 rd fail\n");
	reg |= (1 << 2);	/* GPIO2 to GPIO logic */
	wm97xx_reg_write(wm, 0x56, reg);
	mutex_unlock(&wm->codec_mutex);
[...]

Setting a pin with
wm97xx_set_gpio(wm, WM97XX_GPIO_1, WM97XX_GPIO_HIGH);

reads back 0x0820 from GPIO status reg, sets bit 1,writes back 0x1044 (<<1),
but a read following immediately after yields 0x0820 again, and the pin
never changes.

Am I missing something?

Also I need this patch to get wm97xx_set_gpio() to actually set a bit in the
gpio register:

--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -200,7 +200,7 @@ void wm97xx_set_gpio(struct wm97xx *wm, u32 gpio,
        mutex_lock(&wm->codec_mutex);
        reg = wm97xx_reg_read(wm, AC97_GPIO_STATUS);

-       if (status & WM97XX_GPIO_HIGH)
+       if (status == WM97XX_GPIO_HIGH)
                reg |= gpio;
        else
                reg &= ~gpio;



Thanks!
      Manuel Lauss
