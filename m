From: walter harms <wharms@bfs.de>
Subject: Re: [patch v2] Input: force feedback - potential integer wrap in
 input_ff_create()
Date: Sat, 15 Oct 2011 16:24:28 +0200
Message-ID: <4E99979C.7010305@bfs.de>
References: <20111009162524.GA14049@elgon.mountain> <20111010050852.GA18794@core.coreip.homeip.net> <20111010204830.GV30887@longonot.mountain> <20111011211949.GB30887@longonot.mountain>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx01.sz.bfs.de ([194.94.69.103]:55757 "EHLO mx01.sz.bfs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752950Ab1JOOeN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 15 Oct 2011 10:34:13 -0400
In-Reply-To: <20111011211949.GB30887@longonot.mountain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org



Am 11.10.2011 23:19, schrieb Dan Carpenter:
> The problem here is that max_effects can wrap on 32 bits systems.
> We'd allocate a smaller amount of data than sizeof(struct ff_device).
> The call to kcalloc() on the next line would fail but it would write
> the NULL return outside of the memory we just allocated causing data
> corruption.
> 
> The call path is that uinput_setup_device() get ->ff_effects_max from
> the user and sets the value in the ->private_data struct.  From there
> it is:
> -> uinput_ioctl_handler()
>    -> uinput_create_device()
>       -> input_ff_create(dev, udev->ff_effects_max);
> 
> I've also changed ff_effects_max so it's an unsigned int instead of
> a signed int as a cleanup.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> V2: made max_effects unsigned
> 
> diff --git a/drivers/input/ff-core.c b/drivers/input/ff-core.c
> index 3367f76..3051c84 100644
> --- a/drivers/input/ff-core.c
> +++ b/drivers/input/ff-core.c
> @@ -309,7 +309,7 @@ EXPORT_SYMBOL_GPL(input_ff_event);
>   * Once ff device is created you need to setup its upload, erase,
>   * playback and other handlers before registering input device
>   */
> -int input_ff_create(struct input_dev *dev, int max_effects)
> +int input_ff_create(struct input_dev *dev, unsigned int max_effects)
>  {
>  	struct ff_device *ff;
>  	int i;
> @@ -319,6 +319,10 @@ int input_ff_create(struct input_dev *dev, int max_effects)
>  		return -EINVAL;
>  	}
>  
> +	if (sizeof(struct ff_device) + max_effects * sizeof(struct file *) <
> +			max_effects)
> +		return -EINVAL;
> +

i am not sure if that is the way to go.
the minimum size you need is sizeof(struct ff_device)+sizeof(struct file *)
(assuming that  max_effects>=1). If the input can be outside any useful boundaries
i would go for this:
	uint64_t tmp= sizeof(struct ff_device) + max_effects * sizeof(struct file *) ;

	if (tmp >= UINT_MAX )
              ......

Clearly it is better to have max_effects in a proper range.

re,
 wh


>  	ff = kzalloc(sizeof(struct ff_device) +
>  		     max_effects * sizeof(struct file *), GFP_KERNEL);
>  	if (!ff)
> diff --git a/include/linux/input.h b/include/linux/input.h
> index 57add32..6d5eddb 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -1610,7 +1610,7 @@ struct ff_device {
>  	struct file *effect_owners[];
>  };
>  
> -int input_ff_create(struct input_dev *dev, int max_effects);
> +int input_ff_create(struct input_dev *dev, unsigned int max_effects);
>  void input_ff_destroy(struct input_dev *dev);
>  
>  int input_ff_event(struct input_dev *dev, unsigned int type, unsigned int code, int value);
> diff --git a/include/linux/uinput.h b/include/linux/uinput.h
> index d28c726..2aa2881 100644
> --- a/include/linux/uinput.h
> +++ b/include/linux/uinput.h
> @@ -68,7 +68,7 @@ struct uinput_device {
>  	unsigned char		head;
>  	unsigned char		tail;
>  	struct input_event	buff[UINPUT_BUFFER_SIZE];
> -	int			ff_effects_max;
> +	unsigned int		ff_effects_max;
>  
>  	struct uinput_request	*requests[UINPUT_NUM_REQUESTS];
>  	wait_queue_head_t	requests_waitq;
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
