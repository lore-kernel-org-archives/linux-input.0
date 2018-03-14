From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: appletouch - use true and false for boolean values
Date: Wed, 14 Mar 2018 10:09:15 -0700
Message-ID: <20180314170915.GA126464@dtor-ws>
References: <20180306000043.GA1603@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180306000043.GA1603@embeddedgus>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: linux-input@vger.kernel.org

On Mon, Mar 05, 2018 at 06:00:43PM -0600, Gustavo A. R. Silva wrote:
> Assign true or false to boolean variables instead of an integer value.
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied, thank you.

> ---
>  drivers/input/mouse/appletouch.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
> index 81a695d..032d279 100644
> --- a/drivers/input/mouse/appletouch.c
> +++ b/drivers/input/mouse/appletouch.c
> @@ -587,7 +587,7 @@ static void atp_complete_geyser_1_2(struct urb *urb)
>  		/* Perform size detection, if not done already */
>  		if (unlikely(!dev->size_detect_done)) {
>  			atp_detect_size(dev);
> -			dev->size_detect_done = 1;
> +			dev->size_detect_done = true;
>  			goto exit;
>  		}
>  	}
> @@ -813,7 +813,7 @@ static int atp_open(struct input_dev *input)
>  	if (usb_submit_urb(dev->urb, GFP_ATOMIC))
>  		return -EIO;
>  
> -	dev->open = 1;
> +	dev->open = true;
>  	return 0;
>  }
>  
> @@ -823,7 +823,7 @@ static void atp_close(struct input_dev *input)
>  
>  	usb_kill_urb(dev->urb);
>  	cancel_work_sync(&dev->work);
> -	dev->open = 0;
> +	dev->open = false;
>  }
>  
>  static int atp_handle_geyser(struct atp *dev)
> -- 
> 2.7.4
> 

-- 
Dmitry
