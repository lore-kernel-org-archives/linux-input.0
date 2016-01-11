From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH] [v4]Input: evdev - drop partial events after emptying
 the buffer
Date: Mon, 11 Jan 2016 14:11:34 +1000
Message-ID: <20160111041134.GA24860@jelly.redhat.com>
References: <1451944601-1376-1-git-send-email-a.mathur@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1451944601-1376-1-git-send-email-a.mathur@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aniroop Mathur <a.mathur@samsung.com>
Cc: dmitry.torokhov@gmail.com, benjamin.tissoires@gmail.com, dh.herrmann@gmail.com, rydberg@bitmath.org, aniroop.mathur@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Jan 05, 2016 at 03:26:41AM +0530, Aniroop Mathur wrote:
> This patch introduces concept to drop partial events in evdev handler
> itself after emptying the buffer which are dropped by all evdev
> clients in userspace after SYN_DROPPED occurs and this in turn reduces
> evdev client reading requests plus saves memory space filled by partial
> events in evdev handler buffer.
> Also, this patch prevents dropping of full packet by evdev client after
> SYN_DROPPED occurs in case last stored event was SYN_REPORT.
> (like after clock change request)

this patch looks technically correct now, thanks. but tbh, especially after
reading the EVIOCGBUFSIZE patch I'm wondering why you need to optimise this
path. ignoring events after a SYN_DROPPED is easy in userspace, and you'll
need the code to do so anyway because even with your patch, there is no API
guarantee that this will always happen - if you rely on it, your code may
break on a future kernel.

>From userland, this patch has no real effect, it only slightly reduces the
chance that you get a SYN_DROPPED while reading events after a SYN_DROPPED
has already occured. And if that's a problem, fixing the kernel is likely
the wrong solution anyway. so yeah, still in doubt about whether this patch
provides any real benefit.

Cheers,
   Peter

> --
> Please ignore v3.
> 
> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
> ---
>  drivers/input/evdev.c | 53 ++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 40 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index e9ae3d5..15b6eb2 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -58,6 +58,7 @@ struct evdev_client {
>  	struct list_head node;
>  	unsigned int clk_type;
>  	bool revoked;
> +	bool drop_pevent; /* specifies if partial events need to be dropped */
>  	unsigned long *evmasks[EV_CNT];
>  	unsigned int bufsize;
>  	struct input_event buffer[];
> @@ -156,7 +157,12 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
>  static void __evdev_queue_syn_dropped(struct evdev_client *client)
>  {
>  	struct input_event ev;
> +	struct input_event *prev_ev;
>  	ktime_t time;
> +	unsigned int mask = client->bufsize - 1;
> +
> +	/* Store previous event */
> +	prev_ev = &client->buffer[(client->head - 1) & mask];
>  
>  	time = client->clk_type == EV_CLK_REAL ?
>  			ktime_get_real() :
> @@ -170,13 +176,33 @@ static void __evdev_queue_syn_dropped(struct evdev_client *client)
>  	ev.value = 0;
>  
>  	client->buffer[client->head++] = ev;
> -	client->head &= client->bufsize - 1;
> +	client->head &= mask;
>  
>  	if (unlikely(client->head == client->tail)) {
>  		/* drop queue but keep our SYN_DROPPED event */
> -		client->tail = (client->head - 1) & (client->bufsize - 1);
> +		client->tail = (client->head - 1) & mask;
>  		client->packet_head = client->tail;
>  	}
> +
> +	/*
> +	 * If last packet is NOT fully stored, set drop_pevent to true to
> +	 * ignore partial events and if last packet is fully stored, queue
> +	 * SYN_REPORT so that clients would not ignore next full packet.
> +	 */
> +	if (prev_ev->type != EV_SYN && prev_ev->code != SYN_REPORT) {
> +		client->drop_pevent = true;
> +	} else if (prev_ev->type == EV_SYN && prev_ev->code == SYN_REPORT) {
> +		prev_ev->time = ev.time;
> +		client->buffer[client->head++] = *prev_ev;
> +		client->head &= mask;
> +		client->packet_head = client->head;
> +
> +		/* drop queue but keep our SYN_DROPPED & SYN_REPORT event */
> +		if (unlikely(client->head == client->tail)) {
> +			client->tail = (client->head - 2) & mask;
> +			client->packet_head = client->tail;
> +		}
> +	}
>  }
>  
>  static void evdev_queue_syn_dropped(struct evdev_client *client)
> @@ -235,18 +261,8 @@ static void __pass_event(struct evdev_client *client,
>  	client->head &= client->bufsize - 1;
>  
>  	if (unlikely(client->head == client->tail)) {
> -		/*
> -		 * This effectively "drops" all unconsumed events, leaving
> -		 * EV_SYN/SYN_DROPPED plus the newest event in the queue.
> -		 */
> -		client->tail = (client->head - 2) & (client->bufsize - 1);
> -
> -		client->buffer[client->tail].time = event->time;
> -		client->buffer[client->tail].type = EV_SYN;
> -		client->buffer[client->tail].code = SYN_DROPPED;
> -		client->buffer[client->tail].value = 0;
> -
>  		client->packet_head = client->tail;
> +		__evdev_queue_syn_dropped(client);
>  	}
>  
>  	if (event->type == EV_SYN && event->code == SYN_REPORT) {
> @@ -284,6 +300,17 @@ static void evdev_pass_values(struct evdev_client *client,
>  			wakeup = true;
>  		}
>  
> +		/*
> +		 * drop partial events of last packet but queue SYN_REPORT
> +		 * so that clients would not ignore extra full packet.
> +		 */
> +		if (client->drop_pevent) {
> +			if (v->type == EV_SYN && v->code == SYN_REPORT)
> +				client->drop_pevent = false;
> +			else
> +				continue;
> +		}
> +
>  		event.type = v->type;
>  		event.code = v->code;
>  		event.value = v->value;
> -- 
> 2.6.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
