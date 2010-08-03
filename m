From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: RE: [RFC][PATCH] GPIO keys
Date: Tue, 3 Aug 2010 21:24:28 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003B3871D43@dbde02.ent.ti.com>
References: <1280300530-17096-1-git-send-email-shubhrajyoti@ti.com>
 <20100803081551.GA16029@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41371 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756543Ab0HCPyd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Aug 2010 11:54:33 -0400
In-Reply-To: <20100803081551.GA16029@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>


Hi,
> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Tuesday, August 03, 2010 1:46 PM
> To: Datta, Shubhrajyoti
> Cc: linux-input@vger.kernel.org
> Subject: Re: [RFC][PATCH] GPIO keys
> 
> Hi,
> 
> On Wed, Jul 28, 2010 at 12:32:10PM +0530, Shubhrajyoti D wrote:
> > Allowing the call of open and close functions.
> > If the gpio-keys device has some initialization
> > to be done allow the call of platform functions.
> > An example would be to enable the device.
> > - Having seperate functions for open and close
> >
> 
> I think the patch can be improved still:
> 
>  - enable() should be allowed to fail and stop the device from
>    being opened;
> 
>  - Pass the parent device into the callbacks so that they can
>    differentiate in case there are 2 sets of gpio keys (or maybe
>    you share the callbacks beween drivers, etc.
I agree. Yes missed that case earlier.
> 
> Does the following work for you?
Yes it does 

Thanks and regards,
Shubhrajyoti
> 
> Thanks.
> 
> --
> Dmitry
> 
> Input: gpio_keys - add hooks to enable/disable device
> 
> From: Shubhrajyoti D <shubhrajyoti@ti.com>
> 
> Allow platform code to specify callbcks that will be invoked when
> input device is opened or closed, allowing, for example, to enable
> the device.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
>  drivers/input/keyboard/gpio_keys.c |   22 ++++++++++++++++++++++
>  include/linux/gpio_keys.h          |    2 ++
>  2 files changed, 24 insertions(+), 0 deletions(-)
> 
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c
> b/drivers/input/keyboard/gpio_keys.c
> index a9fd147..6069abe 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -39,6 +39,8 @@ struct gpio_keys_drvdata {
>  	struct input_dev *input;
>  	struct mutex disable_lock;
>  	unsigned int n_buttons;
> +	int (*enable)(struct device *dev);
> +	void (*disable)(struct device *dev);
>  	struct gpio_button_data data[0];
>  };
> 
> @@ -423,6 +425,21 @@ fail2:
>  	return error;
>  }
> 
> +static int gpio_keys_open(struct input_dev *input)
> +{
> +	struct gpio_keys_drvdata *ddata = input_get_drvdata(input);
> +
> +	return ddata->enable ? ddata->enable(input->dev.parent) : 0;
> +}
> +
> +static void gpio_keys_close(struct input_dev *input)
> +{
> +	struct gpio_keys_drvdata *ddata = input_get_drvdata(input);
> +
> +	if (ddata->disable)
> +		ddata->disable(input->dev.parent);
> +}
> +
>  static int __devinit gpio_keys_probe(struct platform_device *pdev)
>  {
>  	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
> @@ -444,13 +461,18 @@ static int __devinit gpio_keys_probe(struct
> platform_device *pdev)
> 
>  	ddata->input = input;
>  	ddata->n_buttons = pdata->nbuttons;
> +	ddata->enable = pdata->enable;
> +	ddata->disable = pdata->disable;
>  	mutex_init(&ddata->disable_lock);
> 
>  	platform_set_drvdata(pdev, ddata);
> +	input_set_drvdata(input, ddata);
> 
>  	input->name = pdev->name;
>  	input->phys = "gpio-keys/input0";
>  	input->dev.parent = &pdev->dev;
> +	input->open = gpio_keys_open;
> +	input->close = gpio_keys_close;
> 
>  	input->id.bustype = BUS_HOST;
>  	input->id.vendor = 0x0001;
> diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
> index cd0b3f3..ce73a30 100644
> --- a/include/linux/gpio_keys.h
> +++ b/include/linux/gpio_keys.h
> @@ -17,6 +17,8 @@ struct gpio_keys_platform_data {
>  	struct gpio_keys_button *buttons;
>  	int nbuttons;
>  	unsigned int rep:1;		/* enable input subsystem auto repeat
> */
> +	int (*enable)(struct device *dev);
> +	void (*disable)(struct device *dev);
>  };
> 
>  #endif
