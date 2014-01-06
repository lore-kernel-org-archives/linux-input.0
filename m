From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH] Input: twl4030 - convert to using managed resources
Date: Mon, 06 Jan 2014 11:25:54 +0900
Message-ID: <007901cf0a86$a0639550$e12abff0$%han@samsung.com>
References: <20140104090147.GA16680@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:28897 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594AbaAFCZ5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 Jan 2014 21:25:57 -0500
In-reply-to: <20140104090147.GA16680@core.coreip.homeip.net>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, 'Sebastian Reichel' <sre@debian.org>
Cc: linux-input@vger.kernel.org, 'Fugang Duan' <B38611@freescale.com>, 'Peter Ujfalusi' <peter.ujfalusi@ti.com>, ".linux-kernel"@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

On Saturday, January 04, 2014 6:02 PM, Dmitry Torokhov wrote:
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> Compile-tested only.
> 
> 
>  drivers/input/keyboard/twl4030_keypad.c | 70 +++++++++++----------------------
>  1 file changed, 22 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
> index f663c19..71eb041 100644
> --- a/drivers/input/keyboard/twl4030_keypad.c
> +++ b/drivers/input/keyboard/twl4030_keypad.c

[.....]

> -static int twl4030_kp_remove(struct platform_device *pdev)
> -{
> -	struct twl4030_keypad *kp = platform_get_drvdata(pdev);
> -
> -	free_irq(kp->irq, kp);
> -	input_unregister_device(kp->input);

Hi Dmitry Torokhov,

IMHO, input_unregister_device() seems to be necessary,
because input_register_device() is still used.
If I am wrong, please let me know kindly.

Sebastian Reichel,
Would you repeat insmod & rmmod 'twl4030_keypad.ko'?

Happy New Year! :-)

Best regards,
Jingoo Han

