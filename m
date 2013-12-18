From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/9] Input: pixcir_i2c_ts: Initialize interrupt mode and
 power mode
Date: Wed, 18 Dec 2013 06:14:08 -0800
Message-ID: <20131218141408.GC28504@core.coreip.homeip.net>
References: <1387358480-8313-1-git-send-email-rogerq@ti.com>
 <1387358480-8313-4-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1387358480-8313-4-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org, jcbian-mY6CKx1T+M6Pt1CcHtbs0g@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Dec 18, 2013 at 02:51:14PM +0530, Roger Quadros wrote:
> +
> +static int pixcir_stop(struct pixcir_i2c_ts_data *ts)
> +{
> +	struct device *dev = &ts->client->dev;
> +	int ret;
> +
> +	/* disable interrupt generation */
> +	ret = pixcir_int_enable(ts, 0);
> +	if (ret) {
> +		dev_err(dev, "Failed to disable interrupt generation\n");
> +		return ret;
> +	}
> +
> +	disable_irq(ts->client->irq);

Why do you need to disable IRQ? If you disable interrupt generation in
the chip I think you only need to call synchronize_irq() to make sure
it's completed if it happens to be running. Also you need to move the
code:

	tsdata->exiting = true;
	mb();

here from pixcir_i2c_ts_remove() to make sure handler exits promptly.

You will also need to reset tsdata->exiting in your start method.

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
