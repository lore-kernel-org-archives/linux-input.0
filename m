From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] input: touchscreen: ar1021_i2c: coding style fixes
Date: Wed, 12 Apr 2017 08:41:31 -0700
Message-ID: <20170412154131.GC6297@dtor-ws>
References: <1491906479-17639-1-git-send-email-martin.kepplinger@ginzinger.com>
 <1491906479-17639-3-git-send-email-martin.kepplinger@ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1491906479-17639-3-git-send-email-martin.kepplinger-hfTNJOUbDMh54TAoqtyWWQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Kepplinger <martin.kepplinger-hfTNJOUbDMh54TAoqtyWWQ@public.gmane.org>
Cc: christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Apr 11, 2017 at 12:27:59PM +0200, Martin Kepplinger wrote:
> Use the common kernel coding style and corrently align parameters with
> open parenthesis.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger-hfTNJOUbDMh54TAoqtyWWQ@public.gmane.org>

Applied, thank you.

> ---
>  drivers/input/touchscreen/ar1021_i2c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ar1021_i2c.c b/drivers/input/touchscreen/ar1021_i2c.c
> index 1767257..cac7eeb 100644
> --- a/drivers/input/touchscreen/ar1021_i2c.c
> +++ b/drivers/input/touchscreen/ar1021_i2c.c
> @@ -38,7 +38,7 @@ static irqreturn_t ar1021_i2c_irq(int irq, void *dev_id)
>  	int retval;
>  
>  	retval = i2c_master_recv(ar1021->client,
> -				ar1021->data, sizeof(ar1021->data));
> +				 ar1021->data, sizeof(ar1021->data));
>  	if (retval != sizeof(ar1021->data))
>  		goto out;
>  
> @@ -78,7 +78,7 @@ static void ar1021_i2c_close(struct input_dev *dev)
>  }
>  
>  static int ar1021_i2c_probe(struct i2c_client *client,
> -				     const struct i2c_device_id *id)
> +			    const struct i2c_device_id *id)
>  {
>  	struct ar1021_i2c *ar1021;
>  	struct input_dev *input;
> -- 
> 2.1.4
> 

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
