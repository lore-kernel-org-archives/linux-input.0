From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: gpio_keys - initialize the 'irq' variable
Date: Sun, 7 Dec 2014 22:48:50 -0800
Message-ID: <20141208064850.GA29729@dtor-ws>
References: <1417880632-13559-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:42931 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbaLHGsz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Dec 2014 01:48:55 -0500
Received: by mail-ig0-f181.google.com with SMTP id l13so2447279iga.14
        for <linux-input@vger.kernel.org>; Sun, 07 Dec 2014 22:48:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1417880632-13559-1-git-send-email-festevam@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: alexander.stein@systec-electronic.com, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Hi Fabio,

On Sat, Dec 06, 2014 at 01:43:52PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Commit f2d347ff70be453e ("Input: gpio_keys - add device tree support for
> interrupt only keys") caused the following build warning:
> 
> drivers/input/keyboard/gpio_keys.c: In function 'gpio_keys_probe':
> drivers/input/keyboard/gpio_keys.c:647:15: warning: 'irq' may be used uninitialized in this function [-Wmaybe-uninitialized]
> drivers/input/keyboard/gpio_keys.c:622:7: note: 'irq' was declared here
> 
> Initialize 'irq' with a default value to fix it.
> 
> Reported-by: Olof's autobuilder <build@lixom.net>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/input/keyboard/gpio_keys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index aa13055..70e89d1 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -619,7 +619,7 @@ gpio_keys_get_devtree_pdata(struct device *dev)
>  	i = 0;
>  	for_each_child_of_node(node, pp) {
>  		int gpio = -1;
> -		int irq;
> +		int irq = -EINVAL;

No, this is not good as we'll end up with button->irq, which is unsigned
int, having nonsense value.

I'd rather move assignment into the proper branch.

Thanks.

-- 
Dmitry
