From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch 22/22] input: ads7846: introduce platform specific way
	to synchronize sampling
Date: Thu, 12 Mar 2009 19:34:01 -0700
Message-ID: <20090313023400.GA16163@dtor-d630.eng.vmware.com>
References: <200903041959.n24JxDIQ028495@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f122.google.com ([209.85.221.122]:56375 "EHLO
	mail-qy0-f122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbZCMCeL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Mar 2009 22:34:11 -0400
Received: by qyk28 with SMTP id 28so2724452qyk.33
        for <linux-input@vger.kernel.org>; Thu, 12 Mar 2009 19:34:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200903041959.n24JxDIQ028495@imap1.linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-input@vger.kernel.org, eric.miao@marvell.com, david-b@pacbell.net

Hi,

On Wed, Mar 04, 2009 at 11:59:13AM -0800, akpm@linux-foundation.org wrote:
> From: Eric Miao <eric.miao@marvell.com>
> 
> Noises can be introduced when LCD signals are being driven, some platforms
> provide a signal to assist the synchronization of this sampling procedure.
> 
> Signed-off-by: Eric Miao <eric.miao@marvell.com>
> Cc: David Brownell <david-b@pacbell.net>
> Cc: Dmitry Torokhov <dtor@mail.ru>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/input/touchscreen/ads7846.c |   10 ++++++++++
>  include/linux/spi/ads7846.h         |    2 ++
>  2 files changed, 12 insertions(+)
> 
> diff -puN drivers/input/touchscreen/ads7846.c~input-ads7846-introduce-platform-specific-way-to-synchronize-sampling drivers/input/touchscreen/ads7846.c
> --- a/drivers/input/touchscreen/ads7846.c~input-ads7846-introduce-platform-specific-way-to-synchronize-sampling
> +++ a/drivers/input/touchscreen/ads7846.c
> @@ -127,6 +127,8 @@ struct ads7846 {
>  	void			(*filter_cleanup)(void *data);
>  	int			(*get_pendown_state)(void);
>  	int			gpio_pendown;
> +
> +	void			(*wait_for_sync)(void);
>  };
>  
>  /* leave chip selected when we're done, for quicker re-select? */
> @@ -511,6 +513,10 @@ static int get_pendown_state(struct ads7
>  	return !gpio_get_value(ts->gpio_pendown);
>  }
>  
> +static void null_wait_for_sync(void)
> +{
> +}
> +
>  /*
>   * PENIRQ only kicks the timer.  The timer only reissues the SPI transfer,
>   * to retrieve touchscreen status.
> @@ -686,6 +692,7 @@ static void ads7846_rx_val(void *ads)
>  	default:
>  		BUG();
>  	}
> +	ts->wait_for_sync();
>  	status = spi_async(ts->spi, m);
>  	if (status)
>  		dev_err(&ts->spi->dev, "spi_async --> %d\n",
> @@ -723,6 +730,7 @@ static enum hrtimer_restart ads7846_time
>  	} else {
>  		/* pen is still down, continue with the measurement */
>  		ts->msg_idx = 0;
> +		ts->wait_for_sync();

We are in hard IRQ context here. What is the expectation of
wait_for_sync()? How long are we waiting here?

-- 
Dmitry
