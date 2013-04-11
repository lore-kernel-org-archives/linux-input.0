From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] Input: imx_keypad - Place SIMPLE_DEV_PM_OPS inside
 CONFIG_PM_SLEEP if block
Date: Thu, 11 Apr 2013 11:17:54 -0300
Message-ID: <CAOMZO5C_QW_BWCqNufs7BT5Cx4OZMULp0vvqOUfL3Y5nME14GQ@mail.gmail.com>
References: <1365657360-877-1-git-send-email-festevam@gmail.com>
	<a9c28a66-b5e7-4e83-9d6a-d2c680d0ca1a@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vb0-f49.google.com ([209.85.212.49]:57794 "EHLO
	mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513Ab3DKOR4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Apr 2013 10:17:56 -0400
Received: by mail-vb0-f49.google.com with SMTP id 11so1277477vbf.8
        for <linux-input@vger.kernel.org>; Thu, 11 Apr 2013 07:17:55 -0700 (PDT)
In-Reply-To: <a9c28a66-b5e7-4e83-9d6a-d2c680d0ca1a@email.android.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kernel@pengutronix.de, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Hi Dmitry,

On Thu, Apr 11, 2013 at 2:28 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Fabio Estevam <festevam@gmail.com> wrote:
>
>>From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>>SIMPLE_DEV_PM_OPS should be inside the CONFIG_PM_SLEEP 'if' block
>>because
>>imx_kbd_suspend and imx_kbd_resume definitions are inside this block.
>
> No, it does not. It compiles just fine if CONFIG_PM_SLEEP is not defined.

I am not sure how to disable CONFIG_PM_SLEEP properly in the
defconfig, but I did this quick test to simulate it:

--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -536,7 +536,7 @@ static int imx_keypad_probe(struct platform_device *pdev)
        return 0;
 }

-#ifdef CONFIG_PM_SLEEP
+#if 0
 static int imx_kbd_suspend(struct device *dev)
 {
        struct platform_device *pdev = to_platform_device(dev);


and then I see:

  CC      drivers/input/keyboard/imx_keypad.o
drivers/input/keyboard/imx_keypad.c:585: error: 'imx_kbd_suspend'
undeclared here (not in a function)
drivers/input/keyboard/imx_keypad.c:585: error: 'imx_kbd_resume'
undeclared here (not in a function)
make[3]: *** [drivers/input/keyboard/imx_keypad.o] Error 1
make[2]: *** [drivers/input/keyboard] Error 2
