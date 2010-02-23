From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 2/2] Input: TWL4030-vibra: use dynamic workqueue
Date: Tue, 23 Feb 2010 10:28:45 -0800
Message-ID: <20100223182845.GC11301@core.coreip.homeip.net>
References: <1266935279-331-1-git-send-email-ext-jari.vanhala@nokia.com>
 <1266935279-331-2-git-send-email-ext-jari.vanhala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:6047 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252Ab0BWS2x (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Feb 2010 13:28:53 -0500
Received: by fg-out-1718.google.com with SMTP id e12so14636fga.1
        for <linux-input@vger.kernel.org>; Tue, 23 Feb 2010 10:28:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1266935279-331-2-git-send-email-ext-jari.vanhala@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jari Vanhala <ext-jari.vanhala@nokia.com>
Cc: linux-input@vger.kernel.org

On Tue, Feb 23, 2010 at 04:27:59PM +0200, Jari Vanhala wrote:
> Change static workqueue to dynamically created &
> destroyed version.
> 
> Signed-off-by: Jari Vanhala <ext-jari.vanhala@nokia.com>
> ---
>  drivers/input/misc/twl4030-vibra.c |   69 ++++++++++++++++++++++++++----------
>  1 files changed, 50 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/input/misc/twl4030-vibra.c b/drivers/input/misc/twl4030-vibra.c
> index 50f7537..0d5be20 100644
> --- a/drivers/input/misc/twl4030-vibra.c
> +++ b/drivers/input/misc/twl4030-vibra.c
> @@ -45,6 +45,7 @@ struct vibra_info {
>  	struct workqueue_struct *workqueue;
>  	struct work_struct	play_work;
>  	spinlock_t		lock; /* for workqueue */
> +	int			users;
>  
>  	bool			enabled;
>  	int			speed;
> @@ -153,6 +154,49 @@ out:
>  	return 0;
>  }
>  
> +static int twl4030_vibra_open(struct input_dev *input)
> +{
> +	struct vibra_info *info = input_get_drvdata(input);
> +
> +	if (info->workqueue == NULL) {
> +		info->workqueue = create_singlethread_workqueue("vibra");
> +		if (info->workqueue == NULL) {
> +			dev_err(&input->dev, "couldn't create workqueue\n");
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	info->users++;
> +	return 0;
> +}
> +
> +static void twl4030_vibra_wq_destroy(struct vibra_info *info)
> +{
> +	struct workqueue_struct *wq;
> +
> +	spin_lock(&info->lock);
> +	wq = info->workqueue;
> +	info->workqueue = NULL;
> +	spin_unlock(&info->lock);

No need for this locking, input core provides needed serialiization.

> +
> +	if (wq) {
> +		cancel_work_sync(&info->play_work);
> +		INIT_WORK(&info->play_work, vibra_play_work); /* cleanup */
> +		destroy_workqueue(wq);
> +	}
> +
> +	if (info->enabled)
> +		vibra_disable(info);
> +}
> +
> +static void twl4030_vibra_close(struct input_dev *input)
> +{
> +	struct vibra_info *info = input_get_drvdata(input);
> +
> +	if (!(--info->users))
> +		twl4030_vibra_wq_destroy(info);

Your workqueue is per-device (and there is only one vibrator) so no need
to track users - input core will not call you more ofte than needed for
single device.

> +}
> +
>  /*** Module ***/
>  #if CONFIG_PM
>  static int twl4030_vibra_suspend(struct device *dev)
> @@ -197,12 +241,8 @@ static int __devinit twl4030_vibra_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, info);
>  
> -	info->workqueue = create_singlethread_workqueue("vibra");
> -	if (info->workqueue == NULL) {
> -		dev_err(&pdev->dev, "couldn't create workqueue\n");
> -		ret = -ENOMEM;
> -		goto err_kzalloc;
> -	}
> +	info->workqueue = NULL;
> +	info->users = 0;
>  	INIT_WORK(&info->play_work, vibra_play_work);
>  	spin_lock_init(&info->lock);
>  
> @@ -210,13 +250,15 @@ static int __devinit twl4030_vibra_probe(struct platform_device *pdev)
>  	if (info->input_dev == NULL) {
>  		dev_err(&pdev->dev, "couldn't allocate input device\n");
>  		ret = -ENOMEM;
> -		goto err_workq;
> +		goto err_kzalloc;
>  	}
>  	input_set_drvdata(info->input_dev, info);
>  
>  	info->input_dev->name = "twl4030:vibrator";
>  	info->input_dev->id.version = 1;
>  	info->input_dev->dev.parent = pdev->dev.parent;
> +	info->input_dev->open = twl4030_vibra_open;
> +	info->input_dev->close = twl4030_vibra_close;
>  	set_bit(FF_RUMBLE, info->input_dev->ffbit);
>  
>  	ret = input_register_device(info->input_dev);
> @@ -239,8 +281,6 @@ err_ireg:
>  	info->input_dev = NULL;
>  err_ialloc:
>  	input_free_device(info->input_dev);
> -err_workq:
> -	destroy_workqueue(info->workqueue);
>  err_kzalloc:
>  	kfree(info);
>  	return ret;
> @@ -249,17 +289,8 @@ err_kzalloc:
>  static int __devexit twl4030_vibra_remove(struct platform_device *pdev)
>  {
>  	struct vibra_info *info = platform_get_drvdata(pdev);
> -	struct workqueue_struct *wq;
> -
> -	spin_lock(&info->lock);
> -	wq = info->workqueue;
> -	info->workqueue = NULL;
> -	spin_unlock(&info->lock);
>  
> -	cancel_work_sync(&info->play_work);
> -	destroy_workqueue(wq);
> -	if (info->enabled)
> -		vibra_disable(info);
> +	twl4030_vibra_wq_destroy(info);

If device has not been opened there is no workqueue. If device has been
opened input core will call close for it. There is no need to try to
destroy workqueue here.

>  	/* this also free ff-memless which (in turn) kfree info */
>  	input_unregister_device(info->input_dev);
>  
> -- 
> 1.6.3.3
> 

-- 
Dmitry
