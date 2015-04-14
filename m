From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ff-core: use new debug macros
Date: Tue, 14 Apr 2015 14:24:51 -0700
Message-ID: <20150414212451.GE29874@dtor-ws>
References: <1429013170-15053-1-git-send-email-oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1429013170-15053-1-git-send-email-oneukum-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Cc: jkosina-AlSwsSmVLrQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Apr 14, 2015 at 02:06:10PM +0200, Oliver Neukum wrote:
> Replace old pr_* with dev_* debugging macros

Not so new anymore ;)

Applied, thank you.

> 
> Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/input/ff-core.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/ff-core.c b/drivers/input/ff-core.c
> index f50f6dd..b81c88c 100644
> --- a/drivers/input/ff-core.c
> +++ b/drivers/input/ff-core.c
> @@ -23,8 +23,6 @@
>  
>  /* #define DEBUG */
>  
> -#define pr_fmt(fmt) KBUILD_BASENAME ": " fmt
> -
>  #include <linux/input.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> @@ -116,7 +114,7 @@ int input_ff_upload(struct input_dev *dev, struct ff_effect *effect,
>  
>  	if (effect->type < FF_EFFECT_MIN || effect->type > FF_EFFECT_MAX ||
>  	    !test_bit(effect->type, dev->ffbit)) {
> -		pr_debug("invalid or not supported effect type in upload\n");
> +		dev_dbg(&dev->dev, "invalid or not supported effect type in upload\n");
>  		return -EINVAL;
>  	}
>  
> @@ -124,7 +122,7 @@ int input_ff_upload(struct input_dev *dev, struct ff_effect *effect,
>  	    (effect->u.periodic.waveform < FF_WAVEFORM_MIN ||
>  	     effect->u.periodic.waveform > FF_WAVEFORM_MAX ||
>  	     !test_bit(effect->u.periodic.waveform, dev->ffbit))) {
> -		pr_debug("invalid or not supported wave form in upload\n");
> +		dev_dbg(&dev->dev, "invalid or not supported wave form in upload\n");
>  		return -EINVAL;
>  	}
>  
> @@ -246,7 +244,7 @@ static int flush_effects(struct input_dev *dev, struct file *file)
>  	struct ff_device *ff = dev->ff;
>  	int i;
>  
> -	pr_debug("flushing now\n");
> +	dev_dbg(&dev->dev, "flushing now\n");
>  
>  	mutex_lock(&ff->mutex);
>  
> @@ -316,7 +314,7 @@ int input_ff_create(struct input_dev *dev, unsigned int max_effects)
>  	int i;
>  
>  	if (!max_effects) {
> -		pr_err("cannot allocate device without any effects\n");
> +		dev_err(&dev->dev, "cannot allocate device without any effects\n");
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
