From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH 02/11] Input: synaptics-rmi4 - remove unused rmi_f01_remove()
Date: Thu, 13 Feb 2014 11:11:47 -0800
Message-ID: <52FD18F3.6010707@synaptics.com>
References: <1392269277-16391-1-git-send-email-dmitry.torokhov@gmail.com> <1392269277-16391-2-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:55511 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbaBMTLt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Feb 2014 14:11:49 -0500
In-Reply-To: <1392269277-16391-2-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Courtney Cavin <courtney.cavin@sonymobile.com>, Linux Input <linux-input@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

On 02/12/2014 09:27 PM, Dmitry Torokhov wrote:
> It is an empty stub and is not needed.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>

> ---
>   drivers/input/rmi4/rmi_f01.c | 6 ------
>   1 file changed, 6 deletions(-)
>
> diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
> index 92b90d1..897d8ac 100644
> --- a/drivers/input/rmi4/rmi_f01.c
> +++ b/drivers/input/rmi4/rmi_f01.c
> @@ -451,11 +451,6 @@ static int rmi_f01_probe(struct rmi_function *fn)
>   	return 0;
>   }
>
> -static void rmi_f01_remove(struct rmi_function *fn)
> -{
> -	/* Placeholder for now. */
> -}
> -
>   #ifdef CONFIG_PM_SLEEP
>   static int rmi_f01_suspend(struct device *dev)
>   {
> @@ -554,7 +549,6 @@ static struct rmi_function_handler rmi_f01_handler = {
>   	},
>   	.func		= 0x01,
>   	.probe		= rmi_f01_probe,
> -	.remove		= rmi_f01_remove,
>   	.config		= rmi_f01_config,
>   	.attention	= rmi_f01_attention,
>   };
>


-- 

Christopher Heiny
Senior Staff Firmware Engineer
Synaptics Incorporated
