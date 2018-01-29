From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/8] Input: mms114 - replace mdelay with msleep
Date: Mon, 29 Jan 2018 11:46:43 -0800
Message-ID: <20180129194643.wwccgov65m7mcw5h@dtor-ws>
References: <20180129113323.18961-1-andi.shyti@samsung.com>
 <CGME20180129113331epcas2p3fab78689f5f00a3049ae675bbc8dee59@epcas2p3.samsung.com>
 <20180129113323.18961-4-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180129113323.18961-4-andi.shyti@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Shyti <andi.shyti@samsung.com>
Cc: Simon Shields <simon@lineageos.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

On Mon, Jan 29, 2018 at 08:33:18PM +0900, Andi Shyti wrote:
> 200ms seconds is a very long time to keep the CPU busy looping.
> Use msleep instead.
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/mms114.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
> index 94a97049d711..fb4435ae506b 100644
> --- a/drivers/input/touchscreen/mms114.c
> +++ b/drivers/input/touchscreen/mms114.c
> @@ -290,7 +290,7 @@ static int mms114_start(struct mms114_data *data)
>  		return error;
>  	}
>  
> -	mdelay(MMS114_POWERON_DELAY);
> +	msleep(MMS114_POWERON_DELAY);
>  
>  	error = mms114_setup_regs(data);
>  	if (error < 0) {
> -- 
> 2.15.1
> 

-- 
Dmitry
