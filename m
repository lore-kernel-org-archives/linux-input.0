From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 1/3] input: appletouch: parametrize and set saner defaults
 for fuzz and threshold
Date: Sat, 18 Jan 2014 08:07:28 +0100
Message-ID: <52DA2830.103@euromail.se>
References: <52D9DE7A.7040509@gmail.com> <52D9DF09.9090709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h31.telenor.se ([213.150.131.4]:38954 "EHLO
	smtprelay-h31.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbaARHDA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Jan 2014 02:03:00 -0500
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-h31.telenor.se (Postfix) with ESMTP id 4617FE9327
	for <linux-input@vger.kernel.org>; Sat, 18 Jan 2014 08:02:58 +0100 (CET)
In-Reply-To: <52D9DF09.9090709@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Clinton Sprain <clintonsprain@gmail.com>, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Clinton,

> Dials back the default fuzz and threshold settings for
> most devices using this driver, based on values from
> user feedback from forums and bug reports. This
> increases smoothness and movement granularity. No
> changes were made for the older devices that use the
> driver, as I did not find any user feedback for them
> regarding these settings; however, the two settings can
> also now both be specified as module parameters in case
> there is a desire to change the values for devices that
> do not have new defaults.
> 
> There are also a couple of style cleanups per checkpatch.pl.
> 
> Signed-off-by: Clinton Sprain <clintonsprain@gmail.com>
> ---
>  drivers/input/mouse/appletouch.c |   66 ++++++++++++++++++++++++--------------
>  1 file changed, 42 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
> index e42f1fa..f5a16ee 100644
> --- a/drivers/input/mouse/appletouch.c
> +++ b/drivers/input/mouse/appletouch.c
> @@ -43,12 +43,14 @@
>   */
>  struct atp_info {
>  	int xsensors;				/* number of X sensors */
> -	int xsensors_17;			/* 17" models have more sensors */
> +	int xsensors_17;			/* 17" model has more sensors */
>  	int ysensors;				/* number of Y sensors */
>  	int xfact;				/* X multiplication factor */
>  	int yfact;				/* Y multiplication factor */
>  	int datalen;				/* size of USB transfers */
>  	void (*callback)(struct urb *);		/* callback function */
> +	int fuzz;				/* fuzz touchpad generates */
> +	int threshold;				/* sensitivity threshold */
>  };
>  
>  static void atp_complete_geyser_1_2(struct urb *urb);
> @@ -62,6 +64,8 @@ static const struct atp_info fountain_info = {
>  	.yfact		= 43,
>  	.datalen	= 81,
>  	.callback	= atp_complete_geyser_1_2,
> +	.fuzz		= 16,
> +	.threshold	= 5,
>  };
>  
>  static const struct atp_info geyser1_info = {
> @@ -72,6 +76,8 @@ static const struct atp_info geyser1_info = {
>  	.yfact		= 43,
>  	.datalen	= 81,
>  	.callback	= atp_complete_geyser_1_2,
> +	.fuzz		= 16,
> +	.threshold	= 5,
>  };
>  
>  static const struct atp_info geyser2_info = {
> @@ -82,6 +88,8 @@ static const struct atp_info geyser2_info = {
>  	.yfact		= 43,
>  	.datalen	= 64,
>  	.callback	= atp_complete_geyser_1_2,
> +	.fuzz		= 0,
> +	.threshold	= 3,
>  };
>  
>  static const struct atp_info geyser3_info = {
> @@ -91,6 +99,8 @@ static const struct atp_info geyser3_info = {
>  	.yfact		= 64,
>  	.datalen	= 64,
>  	.callback	= atp_complete_geyser_3_4,
> +	.fuzz		= 0,
> +	.threshold	= 3,
>  };
>  
>  static const struct atp_info geyser4_info = {
> @@ -100,6 +110,8 @@ static const struct atp_info geyser4_info = {
>  	.yfact		= 64,
>  	.datalen	= 64,
>  	.callback	= atp_complete_geyser_3_4,
> +	.fuzz		= 0,
> +	.threshold	= 3,
>  };
>  
>  #define ATP_DEVICE(prod, info)					\
> @@ -156,18 +168,9 @@ MODULE_DEVICE_TABLE(usb, atp_table);
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
> @@ -213,14 +216,16 @@ struct atp {
>  	struct work_struct	work;
>  };
>  
> -#define dbg_dump(msg, tab) \
> +#define dbg_dump(msg, tab)						\
> +{									\
>  	if (debug > 1) {						\
>  		int __i;						\
>  		printk(KERN_DEBUG "appletouch: %s", msg);		\
>  		for (__i = 0; __i < ATP_XSENSORS + ATP_YSENSORS; __i++)	\
>  			printk(" %02x", tab[__i]);			\
>  		printk("\n");						\
> -	}
> +	}								\
> +}

Looks like the patch needs cleaning.

>  
>  #define dprintk(format, a...)						\
>  	do {								\
> @@ -236,14 +241,20 @@ MODULE_AUTHOR("Sven Anders");
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

The fuzz can be modified via the input subsystem ioctls (EVIOCSABS), so no need
to add a parameter here.

>  static int debug;
>  module_param(debug, int, 0644);
> @@ -363,7 +374,8 @@ static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
>  		    (!is_increasing && xy_sensors[i - 1] < xy_sensors[i])) {
>  			(*fingers)++;
>  			is_increasing = 1;
> -		} else if (i > 0 && (xy_sensors[i - 1] - xy_sensors[i] > threshold)) {
> +		} else if (i > 0 && (xy_sensors[i - 1] -
> +			xy_sensors[i] > threshold)) {
>  			is_increasing = 0;
>  		}

More noise, please clean the patchset.

> @@ -456,7 +468,7 @@ static void atp_detect_size(struct atp *dev)
>  			input_set_abs_params(dev->input, ABS_X, 0,
>  					     (dev->info->xsensors_17 - 1) *
>  							dev->info->xfact - 1,
> -					     ATP_FUZZ, 0);
> +					     fuzz, 0);

where is this variable defined?

>  			break;
>  		}
>  	}
> @@ -513,7 +525,8 @@ static void atp_complete_geyser_1_2(struct urb *urb)
>  
>  			/* Y values */
>  			dev->xy_cur[ATP_XSENSORS + i] = dev->data[5 * i +  1];
> -			dev->xy_cur[ATP_XSENSORS + i + 8] = dev->data[5 * i + 3];
> +			dev->xy_cur[ATP_XSENSORS + i + 8] =
> +				dev->data[5 * i + 3];
>  		}
>  	}
>  
> @@ -809,12 +822,17 @@ static int atp_probe(struct usb_interface *iface,
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
>  
> -	dev->data = usb_alloc_coherent(dev->udev, dev->info->datalen, GFP_KERNEL,
> -				       &dev->urb->transfer_dma);
> +	dev->data = usb_alloc_coherent(dev->udev, dev->info->datalen,
> +					GFP_KERNEL, &dev->urb->transfer_dma);
>  	if (!dev->data)
>  		goto err_free_urb;
>  
> @@ -844,10 +862,10 @@ static int atp_probe(struct usb_interface *iface,
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


