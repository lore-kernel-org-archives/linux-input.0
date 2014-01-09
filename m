From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH v2] input: synaptics-rmi4 - use snprintf instead of sprintf
 in rmi_i2c.c
Date: Thu, 9 Jan 2014 14:47:19 -0800
Message-ID: <52CF26F7.3020904@synaptics.com>
References: <1389230319-4737-1-git-send-email-cheiny@synaptics.com> <20140109080454.GA27160@core.coreip.homeip.net> <52CF1359.6080207@synaptics.com> <20140109212949.GA31257@core.coreip.homeip.net> <52CF16B8.7000409@synaptics.com> <52CF1E74.6060202@synaptics.com> <20140109222546.GA20994@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:34714 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454AbaAIWrX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jan 2014 17:47:23 -0500
In-Reply-To: <20140109222546.GA20994@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On 01/09/2014 02:25 PM, Dmitry Torokhov wrote:
> Input: synaptics-rmi4 - fix disabling gpio config in i2c transport
>
> From: Dmitry Torokhov<dmitry.torokhov@gmail.com>
>
> We need to pass into pdata->gpio_config() gpio_data which is already a
> pointer, and not its address.
>
> Signed-off-by: Dmitry Torokhov<dmitry.torokhov@gmail.com>
> ---
>   drivers/input/rmi4/rmi_i2c.c |    8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
> index ebe74ec..12aea8c 100644
> --- a/drivers/input/rmi4/rmi_i2c.c
> +++ b/drivers/input/rmi4/rmi_i2c.c
> @@ -168,7 +168,8 @@ exit:
>   static int rmi_i2c_probe(struct i2c_client *client,
>   			 const struct i2c_device_id *id)
>   {
> -	const struct rmi_device_platform_data *pdata = dev_get_platdata(&client->dev);
> +	const struct rmi_device_platform_data *pdata =
> +				dev_get_platdata(&client->dev);
>   	struct rmi_transport_dev *xport;
>   	struct rmi_i2c_data *data;
>   	int retval;
> @@ -250,12 +251,13 @@ err_gpio:
>   static int rmi_i2c_remove(struct i2c_client *client)
>   {
>   	struct rmi_transport_dev *xport = i2c_get_clientdata(client);
> -	struct rmi_device_platform_data *pdata = dev_get_platdata(&client->dev);
> +	const struct rmi_device_platform_data *pdata =
> +				dev_get_platdata(&client->dev);
>
>   	rmi_unregister_transport_device(xport);
>
>   	if (pdata->gpio_config)
> -		pdata->gpio_config(&pdata->gpio_data, false);
> +		pdata->gpio_config(pdata->gpio_data, false);
>
>   	return 0;
>   }

It's just plain freaky that no problem ever arose from that, but 
definitely it's a bug.

Acked-by: Christopher Heiny <cheiny@synaptics.com>
