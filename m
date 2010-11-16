From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 1/4] input: gpio_keys: polling mode support
Date: Tue, 16 Nov 2010 18:36:05 +0900
Message-ID: <20101116093605.GD1330@linux-sh.org>
References: <cover.1289835508.git.bengardiner@nanometrics.ca> <8891d088e9a16122c780f737b1b1ec35f9517c36.1289835508.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:41849 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934072Ab0KPJgk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Nov 2010 04:36:40 -0500
Content-Disposition: inline
In-Reply-To: <8891d088e9a16122c780f737b1b1ec35f9517c36.1289835508.git.bengardiner@nanometrics.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, davinci-linux-open-source@linux.davincidsp.com, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chris Cordahi <christophercordahi@nanometrics.ca>, Alexander Clouter <alex@digriz.org.uk>

On Mon, Nov 15, 2010 at 02:07:50PM -0500, Ben Gardiner wrote:
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 6069abe..477802a 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -44,6 +48,26 @@ struct gpio_keys_drvdata {
>  	struct gpio_button_data data[0];
>  };
>  
> +#if !defined(CONFIG_INPUT_POLLDEV) && !defined(CONFIG_INPUT_POLLDEV_MODULE)
> +inline struct input_polled_dev *input_allocate_polled_device(void)
> +{
> +	return NULL;
> +}
> +
> +inline void input_free_polled_device(struct input_polled_dev *poll_dev)
> +{
> +}
> +
> +inline int input_register_polled_device(struct input_polled_dev *dev)
> +{
> +	return -ENXIO;
> +}
> +
> +inline void input_unregister_polled_device(struct input_polled_dev *poll_dev)
> +{
> +}
> +#endif
> +

Wouldn't these be better off in linux/input-polldev.h?

> +#if !defined(CONFIG_INPUT_POLLDEV) && !defined(CONFIG_INPUT_POLLDEV_MODULE)
> +	if (pdata->poll_interval) {
> +		dev_err(dev, "device needs polling (enable INPUT_POLLDEV)\n");
> +		return -EINVAL;
> +	}
> +#endif
> +
This you could probably just shove in to..

>  	ddata = kzalloc(sizeof(struct gpio_keys_drvdata) +
>  			pdata->nbuttons * sizeof(struct gpio_button_data),
>  			GFP_KERNEL);
> -	input = input_allocate_device();
> +	if (pdata->poll_interval) {
> +		poll_dev = input_allocate_polled_device();
> +		input = poll_dev ? poll_dev->input : 0;
> +	} else
> +		input = input_allocate_device();
>  	if (!ddata || !input) {
>  		dev_err(dev, "failed to allocate state\n");
>  		error = -ENOMEM;
>  		goto fail1;

this. Then just get rid of the ifdefs, as the
input_allocate_polled_device() case will have already NULL'ed out.

The rest is obviously fine with me!
