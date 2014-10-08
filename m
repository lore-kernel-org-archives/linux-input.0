From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: avoid negative input device numbers
Date: Wed, 8 Oct 2014 14:25:38 -0700
Message-ID: <20141008212538.GB15198@dtor-ws>
References: <20141008224245.601a1339@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141008224245.601a1339@frodo>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Leitner <me@g0hl1n.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, richard.leitner@skidata.com
List-Id: linux-input@vger.kernel.org

On Wed, Oct 08, 2014 at 10:42:45PM +0200, Richard Leitner wrote:
> From: Richard Leitner <richard.leitner@skidata.com>
> 
> Fix the format string for input device name generation to avoid negative
> device numbers when the id exceeds the maximum signed integer value.

Well, it is going to take us a while to get there :)

Applied, thank you.


> 
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> ---
>  drivers/input/input.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 236bc56..6be6982 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -1791,7 +1791,7 @@ struct input_dev *input_allocate_device(void)
>  		INIT_LIST_HEAD(&dev->h_list);
>  		INIT_LIST_HEAD(&dev->node);
>  
> -		dev_set_name(&dev->dev, "input%ld",
> +		dev_set_name(&dev->dev, "input%lu",
>  			     (unsigned long) atomic_inc_return(&input_no) - 1);
>  
>  		__module_get(THIS_MODULE);
> -- 
> 2.1.1
> 

-- 
Dmitry
