From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 2/4] input: twl4030-vibra: Use system workqueue
Date: Fri, 11 Jan 2013 09:06:24 -0800
Message-ID: <20130111170623.GD11224@core.coreip.homeip.net>
References: <1357896483-20764-1-git-send-email-peter.ujfalusi@ti.com>
 <1357896483-20764-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1357896483-20764-3-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jan 11, 2013 at 10:28:01AM +0100, Peter Ujfalusi wrote:
> It is time to switch to system wq instead creating a queue for the driver.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Applied, thank you.

> ---
>  drivers/input/misc/twl4030-vibra.c | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/drivers/input/misc/twl4030-vibra.c b/drivers/input/misc/twl4030-vibra.c
> index e2e2a26..68a5f33 100644
> --- a/drivers/input/misc/twl4030-vibra.c
> +++ b/drivers/input/misc/twl4030-vibra.c
> @@ -43,7 +43,6 @@ struct vibra_info {
>  	struct device		*dev;
>  	struct input_dev	*input_dev;
>  
> -	struct workqueue_struct *workqueue;
>  	struct work_struct	play_work;
>  
>  	bool			enabled;
> @@ -143,19 +142,7 @@ static int vibra_play(struct input_dev *input, void *data,
>  	if (!info->speed)
>  		info->speed = effect->u.rumble.weak_magnitude >> 9;
>  	info->direction = effect->direction < EFFECT_DIR_180_DEG ? 0 : 1;
> -	queue_work(info->workqueue, &info->play_work);
> -	return 0;
> -}
> -
> -static int twl4030_vibra_open(struct input_dev *input)
> -{
> -	struct vibra_info *info = input_get_drvdata(input);
> -
> -	info->workqueue = create_singlethread_workqueue("vibra");
> -	if (info->workqueue == NULL) {
> -		dev_err(&input->dev, "couldn't create workqueue\n");
> -		return -ENOMEM;
> -	}
> +	schedule_work(&info->play_work);
>  	return 0;
>  }
>  
> @@ -164,9 +151,6 @@ static void twl4030_vibra_close(struct input_dev *input)
>  	struct vibra_info *info = input_get_drvdata(input);
>  
>  	cancel_work_sync(&info->play_work);
> -	INIT_WORK(&info->play_work, vibra_play_work); /* cleanup */
> -	destroy_workqueue(info->workqueue);
> -	info->workqueue = NULL;
>  
>  	if (info->enabled)
>  		vibra_disable(info);
> @@ -238,7 +222,6 @@ static int twl4030_vibra_probe(struct platform_device *pdev)
>  	info->input_dev->name = "twl4030:vibrator";
>  	info->input_dev->id.version = 1;
>  	info->input_dev->dev.parent = pdev->dev.parent;
> -	info->input_dev->open = twl4030_vibra_open;
>  	info->input_dev->close = twl4030_vibra_close;
>  	__set_bit(FF_RUMBLE, info->input_dev->ffbit);
>  
> -- 
> 1.8.1
> 

-- 
Dmitry
