From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: imx_keypad - Place SIMPLE_DEV_PM_OPS inside CONFIG_PM_SLEEP if block
Date: Wed, 10 Apr 2013 23:15:11 -0700
Message-ID: <5412835.Erh16vVI5Q@dtor-d630.eng.vmware.com>
References: <1365657360-877-1-git-send-email-festevam@gmail.com> <a9c28a66-b5e7-4e83-9d6a-d2c680d0ca1a@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:44490 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721Ab3DKGPP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Apr 2013 02:15:15 -0400
Received: by mail-pa0-f46.google.com with SMTP id lb1so734766pab.19
        for <linux-input@vger.kernel.org>; Wed, 10 Apr 2013 23:15:15 -0700 (PDT)
In-Reply-To: <a9c28a66-b5e7-4e83-9d6a-d2c680d0ca1a@email.android.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: kernel@pengutronix.de, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Wednesday, April 10, 2013 10:28:22 PM Dmitry Torokhov wrote:
> Fabio Estevam <festevam@gmail.com> wrote:
> >From: Fabio Estevam <fabio.estevam@freescale.com>
> >
> >SIMPLE_DEV_PM_OPS should be inside the CONFIG_PM_SLEEP 'if' block
> >because
> >imx_kbd_suspend and imx_kbd_resume definitions are inside this block.
> 
> No, it does not. It compiles just fine if CONFIG_PM_SLEEP is not defined.
> 
> >While at it, also add a definition for IMX_KBD_PM_OPS, which can handle
> >the case
> >when CONFIG_PM_SLEEP is not selected.
> >
> >Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> >---
> >
> > drivers/input/keyboard/imx_keypad.c |    8 +++++---
> > 1 file changed, 5 insertions(+), 3 deletions(-)
> >
> >diff --git a/drivers/input/keyboard/imx_keypad.c
> >b/drivers/input/keyboard/imx_keypad.c
> >index 03c8cc5..2663c91 100644
> >--- a/drivers/input/keyboard/imx_keypad.c
> >+++ b/drivers/input/keyboard/imx_keypad.c
> >
> >@@ -580,15 +580,17 @@ err_clk:
> > 	return ret;
> > 
> > }
> >
> >-#endif
> >-
> >static SIMPLE_DEV_PM_OPS(imx_kbd_pm_ops, imx_kbd_suspend,
> >imx_kbd_resume);
> >+#define IMX_KBD_PM_OPS (&imx_kbd_pm_ops)
> >+#else
> >+#define IMX_KBD_PM_OPS NULL
> >+#endif /* CONFIG_PM_SLEEP */
> >
> > static struct platform_driver imx_keypad_driver = {
> > 
> > 	.driver		= {
> > 	
> > 		.name	= "imx-keypad",
> > 		.owner	= THIS_MODULE,
> >
> >-		.pm	= &imx_kbd_pm_ops,
> >+		.pm	= IMX_KBD_PM_OPS,
> >
> > 		.of_match_table = of_match_ptr(imx_keypad_of_match),
> > 	
> > 	},
> > 	.probe		= imx_keypad_probe,
> 
> Hi Fabio,
> Thanks.

Hmm, K-9's quoting style is really peculiar...

-- 
Dmitry
