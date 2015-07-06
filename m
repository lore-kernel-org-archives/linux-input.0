From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input/evdev: Add 64bit timestamp support
Date: Mon, 6 Jul 2015 15:48:02 -0700
Message-ID: <20150706224802.GB32140@dtor-ws>
References: <aksgarg1989@gmail.com>
 <1436211224-59601-1-git-send-email-aksgarg1989@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:36423 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753687AbbGFWsG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jul 2015 18:48:06 -0400
Received: by iecvh10 with SMTP id vh10so123421040iec.3
        for <linux-input@vger.kernel.org>; Mon, 06 Jul 2015 15:48:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1436211224-59601-1-git-send-email-aksgarg1989@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anshul Garg <aksgarg1989@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Anshul,

On Mon, Jul 06, 2015 at 12:33:44PM -0700, Anshul Garg wrote:
> From: Anshul Garg <aksgarg1989@gmail.com>
> 
> As per current implementation input driver can only
> send ktime converted to timeval which user space again
> have to convert.

Why? ktime is kernel construct and thus userspace has no business using
it directly.

> In some cases input drivers need 64bit timestamp value
> from driver only so that same value can be used by upper
> layer without any manipulation.

Why do they need 64 bit value? What exactly is special about 64 bits? Do
they need to know number of seconds since beginning of the universe?

You need to specify the problem better instead of just saying we need 64
bits.

> Proposed implementation is placed under CONFIG flag which
> will not break any existing code.

Yes, it does. As soon as somebody enables this option their usersoace
will [potentially] break, because instead of timeval they will be
getting 64 bit values.

If we want to do this users will have to explicitly request such
timestamps.

> 
> Signed-off-by: Anshul Garg <aksgarg1989@gmail.com>
> ---
>  drivers/input/Kconfig      |    8 ++++++++
>  drivers/input/evdev.c      |   21 ++++++++++++++++++++-
>  include/uapi/linux/input.h |    3 +++
>  3 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/Kconfig b/drivers/input/Kconfig
> index a35532e..9bf9044 100644
> --- a/drivers/input/Kconfig
> +++ b/drivers/input/Kconfig
> @@ -161,6 +161,14 @@ config INPUT_EVDEV
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called evdev.
>  
> +config INPUT_EVDEV_64BIT_TIMESTAMP
> +       bool "64 Event timestamp"
> +	depends on INPUT_EVDEV
> +	default n
> +	help
> +          Say Y here if you need to send 64bit timestamp from input
> +	   drivers otherwise N.
> +
>  config INPUT_EVBUG
>  	tristate "Event debugging"
>  	help
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index 9d35499..396b60f 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -90,6 +90,9 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
>  			continue;
>  		} else if (head != i) {
>  			/* move entry to fill the gap */
> +#ifdef CONFIG_INPUT_EVDEV_64BIT_TIMESTAMP
> +			client->buffer[head].timestamp = ev->timestamp;
> +#endif
>  			client->buffer[head].time = ev->time;
>  			client->buffer[head].type = ev->type;
>  			client->buffer[head].code = ev->code;
> @@ -111,6 +114,9 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
>  static void __evdev_queue_syn_dropped(struct evdev_client *client)
>  {
>  	struct input_event ev;
> +#ifdef CONFIG_INPUT_EVDEV_64BIT_TIMESTAMP
> +	struct timespec64 ts;
> +#endif
>  	ktime_t time;
>  
>  	time = client->clk_type == EV_CLK_REAL ?
> @@ -118,7 +124,10 @@ static void __evdev_queue_syn_dropped(struct evdev_client *client)
>  			client->clk_type == EV_CLK_MONO ?
>  				ktime_get() :
>  				ktime_get_boottime();
> -
> +#ifdef CONFIG_INPUT_EVDEV_64BIT_TIMESTAMP
> +	ts = ktime_to_timespec64(time);
> +	ev.timestamp = ts.tv_sec*NSEC_PER_SEC + ts.tv_nsec;
> +#endif
>  	ev.time = ktime_to_timeval(time);
>  	ev.type = EV_SYN;
>  	ev.code = SYN_DROPPED;
> @@ -194,6 +203,9 @@ static void __pass_event(struct evdev_client *client,
>  		 */
>  		client->tail = (client->head - 2) & (client->bufsize - 1);
>  
> +#ifdef CONFIG_INPUT_EVDEV_64BIT_TIMESTAMP
> +		client->buffer[client->tail].timestamp = event->timestamp;
> +#endif
>  		client->buffer[client->tail].time = event->time;
>  		client->buffer[client->tail].type = EV_SYN;
>  		client->buffer[client->tail].code = SYN_DROPPED;
> @@ -215,6 +227,9 @@ static void evdev_pass_values(struct evdev_client *client,
>  	struct evdev *evdev = client->evdev;
>  	const struct input_value *v;
>  	struct input_event event;
> +#ifdef CONFIG_INPUT_EVDEV_64BIT_TIMESTAMP
> +	struct timespec64 ts;
> +#endif
>  	bool wakeup = false;
>  
>  	if (client->revoked)
> @@ -222,6 +237,10 @@ static void evdev_pass_values(struct evdev_client *client,
>  
>  	event.time = ktime_to_timeval(ev_time[client->clk_type]);
>  
> +#ifdef CONFIG_INPUT_EVDEV_64BIT_TIMESTAMP
> +	ts = ktime_to_timespec64(ev_time[client->clk_type]);
> +	event.timestamp = ts.tv_sec*NSEC_PER_SEC + ts.tv_nsec;

Won't this overflow?

> +#endif
>  	/* Interrupts are disabled, just acquire the lock. */
>  	spin_lock(&client->buffer_lock);
>  
> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index 905d90c..e0e47bb 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -26,6 +26,9 @@ struct input_event {
>  	__u16 type;
>  	__u16 code;
>  	__s32 value;
> +#ifdef CONFIG_INPUT_EVDEV_64BIT_TIMESTAMP
> +	__s64 timestamp;
> +#endif
>  };
>  
>  /*
> -- 
> 1.7.9.5
> 

Thanks.

-- 
Dmitry
