From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: gpio-keys: add support for disable button
 from DT
Date: Tue, 12 Jan 2016 13:19:24 -0800
Message-ID: <20160112211924.GE32064@dtor-ws>
References: <1452598370-28509-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35434 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbcALVT1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jan 2016 16:19:27 -0500
Content-Disposition: inline
In-Reply-To: <1452598370-28509-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linus.walleij@linaro.org, bjorn.andersson@sonymobile.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Tue, Jan 12, 2016 at 05:02:49PM +0530, Laxman Dewangan wrote:
> Add support to disable the button from DT via status property
> if given button is not supporting on given platforms.
> 
> This will help to re-use the existing dtsi file with status
> enable/disable across platforms.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
>  drivers/input/keyboard/gpio_keys.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index bef317f..cf068cb 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -632,6 +632,14 @@ gpio_keys_get_devtree_pdata(struct device *dev)
>  	for_each_child_of_node(node, pp) {
>  		enum of_gpio_flags flags;
>  
> +		/* Ignore the button if status of node is disabled */
> +		error = of_device_is_available(pp);
> +		if (!error) {
> +			dev_info(dev, "Button %s is ignored\n", pp->name);

I'd rather have it as dev_dbg() please.

> +			pdata->nbuttons--;
> +			continue;
> +		}
> +
>  		button = &pdata->buttons[i++];
>  
>  		button->gpio = of_get_gpio_flags(pp, 0, &flags);
> -- 
> 2.1.4
> 

-- 
Dmitry
