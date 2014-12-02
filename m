From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input : Initialize input_no by -1
Date: Tue, 2 Dec 2014 15:29:23 -0800
Message-ID: <20141202232923.GC6207@localhost>
References: <1417538729-2751-1-git-send-email-aniroop.mathur@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:53023 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbaLCF0i (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Dec 2014 00:26:38 -0500
Received: by mail-pa0-f46.google.com with SMTP id lj1so14948764pab.19
        for <linux-input@vger.kernel.org>; Tue, 02 Dec 2014 21:26:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1417538729-2751-1-git-send-email-aniroop.mathur@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <aniroop.mathur@gmail.com>
Cc: linux-input@vger.kernel.org, a.mathur@samsung.com

On Tue, Dec 02, 2014 at 10:15:29PM +0530, Aniroop Mathur wrote:
> This patch initializes input_no by -1 in order to avoid extra subtraction
> operation performed everytime for allocation of an input device.
> 
> Signed-off-by: Aniroop Mathur <aniroop.mathur@gmail.com>

Applied, thank you.

By the way, we have a few more places in drivers/input that count from 0, we
may want to change them as well.

> ---
>  drivers/input/input.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 29ca0bb..01fe49e 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -1774,7 +1774,7 @@ EXPORT_SYMBOL_GPL(input_class);
>   */
>  struct input_dev *input_allocate_device(void)
>  {
> -	static atomic_t input_no = ATOMIC_INIT(0);
> +	static atomic_t input_no = ATOMIC_INIT(-1);
>  	struct input_dev *dev;
>  
>  	dev = kzalloc(sizeof(struct input_dev), GFP_KERNEL);
> @@ -1789,7 +1789,7 @@ struct input_dev *input_allocate_device(void)
>  		INIT_LIST_HEAD(&dev->node);
>  
>  		dev_set_name(&dev->dev, "input%ld",
> -			     (unsigned long) atomic_inc_return(&input_no) - 1);
> +			     (unsigned long) atomic_inc_return(&input_no));
>  
>  		__module_get(THIS_MODULE);
>  	}
> -- 
> 1.9.1
> 

Thanks.

-- 
Dmitry
