From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Evdev: Fix bug in checking duplicate clock change request
Date: Fri, 30 Oct 2015 04:15:26 -0700
Message-ID: <20151030111526.GA29775@dtor-pixel>
References: <1446062912-9181-1-git-send-email-aniroop.mathur@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1446062912-9181-1-git-send-email-aniroop.mathur@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aniroop Mathur <a.mathur@samsung.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, aniroop.mathur@gmail.com
List-Id: linux-input@vger.kernel.org

Hi Aniroop,

On Thu, Oct 29, 2015 at 01:38:32AM +0530, Aniroop Mathur wrote:
> From: Aniroop Mathur <a.mathur@samsung.com>
> 
> clk_type and clkid stores different predefined clock identification
> values so they cannot be compared for checking duplicate clock change
> request. Therefore, lets fix it to avoid unexpected results.

Good catch!

> 
> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
> Signed-off-by: Aniroop Mathur <aniroop.mathur@gmail.com>

You only need one signoff, which one should I keep? The Samsung one?

> ---
>  drivers/input/evdev.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index 08d4964..0d40f6f 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -56,7 +56,7 @@ struct evdev_client {
>  	struct fasync_struct *fasync;
>  	struct evdev *evdev;
>  	struct list_head node;
> -	int clk_type;
> +	unsigned int clk_type;
>  	bool revoked;
>  	unsigned int bufsize;
>  	struct input_event buffer[];
> @@ -146,9 +146,7 @@ static void evdev_queue_syn_dropped(struct evdev_client *client)
>  static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
>  {
>  	unsigned long flags;
> -
> -	if (client->clk_type == clkid)
> -		return 0;
> +	unsigned int prev_clk_type = client->clk_type;

I prefer the other way around: convert to a temp and then compare. I;ll
fix it up on my side.

>  
>  	switch (clkid) {
>  
> @@ -165,6 +163,10 @@ static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
>  		return -EINVAL;
>  	}
>  
> +	/* No need to flush if clk_type is same as before */
> +	if (client->clk_type == prev_clk_type)
> +		return 0;
> +
>  	/*
>  	 * Flush pending events and queue SYN_DROPPED event,
>  	 * but only if the queue is not empty.
> -- 
> 2.6.2
> 

Thanks.

-- 
Dmitry
