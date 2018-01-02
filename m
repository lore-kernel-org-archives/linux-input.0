From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 2/3] input: evdev: Replace timeval with timespec64
Date: Mon, 1 Jan 2018 22:46:17 -0800
Message-ID: <20180102064617.zmv6ospfkectaa37@dtor-ws>
References: <20171218051844.10193-1-deepa.kernel@gmail.com>
 <20171218051844.10193-3-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:41594 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbeABGqV (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 2 Jan 2018 01:46:21 -0500
Content-Disposition: inline
In-Reply-To: <20171218051844.10193-3-deepa.kernel@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, peter.hutterer@who-t.net, arnd@arndb.de, y2038@lists.linaro.org

Hi Deepa,

On Sun, Dec 17, 2017 at 09:18:43PM -0800, Deepa Dinamani wrote:
> struct timeval is not y2038 safe.
> 
> All references to timeval in the kernel will be replaced
> by y2038 safe structures.
> Replace all references to timeval with y2038 safe
> struct timespec64 here.
> 
> struct input_event will be changed in a different patch.
> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Peter Hutterer <peter.hutterer@who-t.net>
> ---
>  drivers/input/evdev.c | 37 +++++++++++++++++++++++--------------
>  1 file changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index 0193dd4f0452..3171c4882d80 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -156,15 +156,22 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
>  static void __evdev_queue_syn_dropped(struct evdev_client *client)
>  {
>  	struct input_event ev;
> -	ktime_t time;
> +	struct timespec64 ts;
>  
> -	time = client->clk_type == EV_CLK_REAL ?
> -			ktime_get_real() :
> -			client->clk_type == EV_CLK_MONO ?
> -				ktime_get() :
> -				ktime_get_boottime();
> +	switch (client->clk_type) {
> +	case EV_CLK_REAL:
> +		ktime_get_real_ts64(&ts);
> +		break;
> +	case EV_CLK_MONO:
> +		ktime_get_ts64(&ts);
> +		break;
> +	case EV_CLK_BOOT:
> +		get_monotonic_boottime64(&ts);
> +		break;
> +	}
>  
> -	ev.time = ktime_to_timeval(time);
> +	ev.time.tv_sec = ts.tv_sec;
> +	ev.time.tv_usec = ts.tv_nsec / NSEC_PER_USEC;
>  	ev.type = EV_SYN;
>  	ev.code = SYN_DROPPED;
>  	ev.value = 0;
> @@ -257,17 +264,20 @@ static void __pass_event(struct evdev_client *client,
>  
>  static void evdev_pass_values(struct evdev_client *client,
>  			const struct input_value *vals, unsigned int count,
> -			ktime_t *ev_time)
> +			struct timespec64 *ev_time)
>  {
>  	struct evdev *evdev = client->evdev;
>  	const struct input_value *v;
>  	struct input_event event;
> +	struct timespec64 ts;
>  	bool wakeup = false;
>  
>  	if (client->revoked)
>  		return;
>  
> -	event.time = ktime_to_timeval(ev_time[client->clk_type]);
> +	ts = ev_time[client->clk_type];
> +	event.time.tv_sec = ts.tv_sec;
> +	event.time.tv_usec = ts.tv_nsec / NSEC_PER_USEC;
>  
>  	/* Interrupts are disabled, just acquire the lock. */
>  	spin_lock(&client->buffer_lock);
> @@ -304,12 +314,11 @@ static void evdev_events(struct input_handle *handle,
>  {
>  	struct evdev *evdev = handle->private;
>  	struct evdev_client *client;
> -	ktime_t ev_time[EV_CLK_MAX];
> +	struct timespec64 ev_time[EV_CLK_MAX];
>  
> -	ev_time[EV_CLK_MONO] = ktime_get();
> -	ev_time[EV_CLK_REAL] = ktime_mono_to_real(ev_time[EV_CLK_MONO]);
> -	ev_time[EV_CLK_BOOT] = ktime_mono_to_any(ev_time[EV_CLK_MONO],
> -						 TK_OFFS_BOOT);
> +	ktime_get_ts64(&ev_time[EV_CLK_MONO]);
> +	ktime_get_real_ts64(&ev_time[EV_CLK_REAL]);
> +	get_monotonic_boottime64(&ev_time[EV_CLK_BOOT]);

This may result in different ev_time[] members holding different times,
whereas the original code would take one time sample and convert it to
different clocks.

Also, why can't we keep using ktime_t internally? It is y2038 safe,
right? I think you should drop this patch and adjust the 3rd one to
massage the input event timestamp patch to do ktime->timespec64->input
timestamp conversion.

Thanks.

-- 
Dmitry
