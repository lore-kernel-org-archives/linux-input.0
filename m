From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH v2 1/3] input: appletouch: parametrize and set saner defaults
 for fuzz and threshold
Date: Sun, 09 Feb 2014 13:01:23 +0100
Message-ID: <52F76E13.3060408@euromail.se>
References: <52D9DE7A.7040509@gmail.com> <52F42AEE.3040505@gmail.com> <52F42B68.9010905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:32976 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbaBIMRK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 9 Feb 2014 07:17:10 -0500
Received: from ipb5.telenor.se (ipb5.telenor.se [195.54.127.168])
	by smtprelay-b21.telenor.se (Postfix) with ESMTP id 993FFEB2CC
	for <linux-input@vger.kernel.org>; Sun,  9 Feb 2014 12:59:28 +0100 (CET)
In-Reply-To: <52F42B68.9010905@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Clinton Sprain <clintonsprain@gmail.com>, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Clinton,

On 02/07/2014 01:40 AM, Clinton Sprain wrote:
> Dials back the default fuzz and threshold settings for most devices using this driver, based on user input from forums and bug reports, increasing sensitivity. These two settings can also now both be overridden as module parameters in the event that users have hardware that does not respond well to the new defaults, or there is a desire to change the values for devices that do not have new defaults.
> 
> Signed-off-by: Clinton Sprain <clintonsprain@gmail.com>
> ---
>  drivers/input/mouse/appletouch.c |   48 ++++++++++++++++++++++++--------------
>  1 file changed, 31 insertions(+), 17 deletions(-)

Thanks for the patches, they seem like a good improvement. There are still some
comments, though, you will find them inline.

> diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
> index 800ca7d..d48181b 100644
> --- a/drivers/input/mouse/appletouch.c
> +++ b/drivers/input/mouse/appletouch.c
> @@ -48,6 +48,8 @@ struct atp_info {
>  	int yfact;				/* Y multiplication factor */
>  	int datalen;				/* size of USB transfers */
>  	void (*callback)(struct urb *);		/* callback function */
> +	int fuzz;				/* fuzz touchpad generates */
> +	int threshold;				/* sensitivity threshold */
>  };
>  
>  static void atp_complete_geyser_1_2(struct urb *urb);
> @@ -61,6 +63,8 @@ static const struct atp_info fountain_info = {
>  	.yfact		= 43,
>  	.datalen	= 81,
>  	.callback	= atp_complete_geyser_1_2,
> +	.fuzz		= 16,
> +	.threshold	= 5,
>  };
>  
>  static const struct atp_info geyser1_info = {
> @@ -71,6 +75,8 @@ static const struct atp_info geyser1_info = {
>  	.yfact		= 43,
>  	.datalen	= 81,
>  	.callback	= atp_complete_geyser_1_2,
> +	.fuzz		= 16,
> +	.threshold	= 5,
>  };
>  
>  static const struct atp_info geyser2_info = {
> @@ -81,6 +87,8 @@ static const struct atp_info geyser2_info = {
>  	.yfact		= 43,
>  	.datalen	= 64,
>  	.callback	= atp_complete_geyser_1_2,
> +	.fuzz		= 0,
> +	.threshold	= 3,
>  };
>  
>  static const struct atp_info geyser3_info = {
> @@ -90,6 +98,8 @@ static const struct atp_info geyser3_info = {
>  	.yfact		= 64,
>  	.datalen	= 64,
>  	.callback	= atp_complete_geyser_3_4,
> +	.fuzz		= 0,
> +	.threshold	= 3,
>  };
>  
>  static const struct atp_info geyser4_info = {
> @@ -99,6 +109,8 @@ static const struct atp_info geyser4_info = {
>  	.yfact		= 64,
>  	.datalen	= 64,
>  	.callback	= atp_complete_geyser_3_4,
> +	.fuzz		= 0,
> +	.threshold	= 3,
>  };
>  
>  #define ATP_DEVICE(prod, info)					\
> @@ -155,18 +167,9 @@ MODULE_DEVICE_TABLE(usb, atp_table);
>  #define ATP_XSENSORS	26
>  #define ATP_YSENSORS	16
>  
> -/* amount of fuzz this touchpad generates */
> -#define ATP_FUZZ	16
> -
>  /* maximum pressure this driver will report */
>  #define ATP_PRESSURE	300
>  
> -/*
> - * Threshold for the touchpad sensors. Any change less than ATP_THRESHOLD is
> - * ignored.
> - */
> -#define ATP_THRESHOLD	 5
> -
>  /* Geyser initialization constants */
>  #define ATP_GEYSER_MODE_READ_REQUEST_ID		1
>  #define ATP_GEYSER_MODE_WRITE_REQUEST_ID	9
> @@ -235,14 +238,20 @@ MODULE_AUTHOR("Sven Anders");
>  MODULE_DESCRIPTION("Apple PowerBook and MacBook USB touchpad driver");
>  MODULE_LICENSE("GPL");
>  
> -/*
> - * Make the threshold a module parameter
> - */
> -static int threshold = ATP_THRESHOLD;
> +static int threshold = -1;
>  module_param(threshold, int, 0644);
>  MODULE_PARM_DESC(threshold, "Discard any change in data from a sensor"
>  			    " (the trackpad has many of these sensors)"
> -			    " less than this value.");
> +			    " less than this value. Devices have defaults;"
> +			    " this parameter overrides them.");
> +static int fuzz = -1;
> +
> +module_param(fuzz, int, 0644);
> +MODULE_PARM_DESC(fuzz, "Fuzz the trackpad generates. The higher"
> +		       " this is, the less sensitive the trackpad"
> +		       " will feel, but values too low may generate"
> +		       " random movement. Devices have defaults;"
> +		       " this parameter overrides them.");

Given that there already is a userland interface for the fuzz parameter - and it
is indeed in frequent use - this one does not seem warranted. If we are unsure
if the changes to the default are not all good, perhaps they should not be
changed at all?

>  
>  static int debug;
>  module_param(debug, int, 0644);
> @@ -455,7 +464,7 @@ static void atp_detect_size(struct atp *dev)
>  			input_set_abs_params(dev->input, ABS_X, 0,
>  					     (dev->info->xsensors_17 - 1) *
>  							dev->info->xfact - 1,
> -					     ATP_FUZZ, 0);
> +					     fuzz, 0);
>  			break;
>  		}
>  	}
> @@ -808,6 +817,11 @@ static int atp_probe(struct usb_interface *iface,
>  	dev->info = info;
>  	dev->overflow_warned = false;
>  
> +	if (fuzz < 0)
> +		fuzz = dev->info->fuzz;
> +	if (threshold < 0)
> +		threshold = dev->info->threshold;
> +
>  	dev->urb = usb_alloc_urb(0, GFP_KERNEL);
>  	if (!dev->urb)
>  		goto err_free_devs;
> @@ -843,10 +857,10 @@ static int atp_probe(struct usb_interface *iface,
>  
>  	input_set_abs_params(input_dev, ABS_X, 0,
>  			     (dev->info->xsensors - 1) * dev->info->xfact - 1,
> -			     ATP_FUZZ, 0);
> +			     fuzz, 0);
>  	input_set_abs_params(input_dev, ABS_Y, 0,
>  			     (dev->info->ysensors - 1) * dev->info->yfact - 1,
> -			     ATP_FUZZ, 0);
> +			     fuzz, 0);
>  	input_set_abs_params(input_dev, ABS_PRESSURE, 0, ATP_PRESSURE, 0, 0);
>  
>  	set_bit(EV_KEY, input_dev->evbit);
> 

Thanks,
Henrik

