From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: imx_keypad - Place SIMPLE_DEV_PM_OPS inside CONFIG_PM_SLEEP if block
Date: Wed, 10 Apr 2013 22:28:22 -0700
Message-ID: <a9c28a66-b5e7-4e83-9d6a-d2c680d0ca1a@email.android.com>
References: <1365657360-877-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f53.google.com ([209.85.210.53]:37697 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879Ab3DKF21 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Apr 2013 01:28:27 -0400
Received: by mail-da0-f53.google.com with SMTP id n34so530435dal.12
        for <linux-input@vger.kernel.org>; Wed, 10 Apr 2013 22:28:27 -0700 (PDT)
In-Reply-To: <1365657360-877-1-git-send-email-festevam@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: kernel@pengutronix.de, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Fabio Estevam <festevam@gmail.com> wrote:

>From: Fabio Estevam <fabio.estevam@freescale.com>
>
>SIMPLE_DEV_PM_OPS should be inside the CONFIG_PM_SLEEP 'if' block
>because
>imx_kbd_suspend and imx_kbd_resume definitions are inside this block.

No, it does not. It compiles just fine if CONFIG_PM_SLEEP is not defined.

>
>While at it, also add a definition for IMX_KBD_PM_OPS, which can handle
>the case
>when CONFIG_PM_SLEEP is not selected.
>
>Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>---
> drivers/input/keyboard/imx_keypad.c |    8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/input/keyboard/imx_keypad.c
>b/drivers/input/keyboard/imx_keypad.c
>index 03c8cc5..2663c91 100644
>--- a/drivers/input/keyboard/imx_keypad.c
>+++ b/drivers/input/keyboard/imx_keypad.c
>@@ -580,15 +580,17 @@ err_clk:
> 
> 	return ret;
> }
>-#endif
>-
>static SIMPLE_DEV_PM_OPS(imx_kbd_pm_ops, imx_kbd_suspend,
>imx_kbd_resume);
>+#define IMX_KBD_PM_OPS (&imx_kbd_pm_ops)
>+#else
>+#define IMX_KBD_PM_OPS NULL
>+#endif /* CONFIG_PM_SLEEP */
> 
> static struct platform_driver imx_keypad_driver = {
> 	.driver		= {
> 		.name	= "imx-keypad",
> 		.owner	= THIS_MODULE,
>-		.pm	= &imx_kbd_pm_ops,
>+		.pm	= IMX_KBD_PM_OPS,
> 		.of_match_table = of_match_ptr(imx_keypad_of_match),
> 	},
> 	.probe		= imx_keypad_probe,

Hi Fabio,
Thanks.

-- 
Dmitry
