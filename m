From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH] [v2]Input: evdev - drop partial events after emptying
 the buffer
Date: Fri, 8 Jan 2016 15:04:52 +1000
Message-ID: <20160108050452.GA7400@jelly.bne.redhat.com>
References: <1451924928-817-1-git-send-email-a.mathur@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1451924928-817-1-git-send-email-a.mathur@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aniroop Mathur <a.mathur@samsung.com>
Cc: dmitry.torokhov@gmail.com, benjamin.tissoires@gmail.com, dh.herrmann@gmail.com, rydberg@bitmath.org, aniroop.mathur@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jan 04, 2016 at 09:58:48PM +0530, Aniroop Mathur wrote:
> This patch introduces concept to drop partial events in evdev handler
> itself after emptying the buffer which are dropped by all evdev
> clients in userspace after SYN_DROPPED occurs.
> This in turn saves space of partial events in evdev handler buffer
> and reduces evdev client reading requests.
> 
> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
> ---
>  drivers/input/evdev.c | 56 ++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 47 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index e9ae3d5..0a5ead8 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -58,6 +58,7 @@ struct evdev_client {
>  	struct list_head node;
>  	unsigned int clk_type;
>  	bool revoked;
> +	bool drop_pevent; /* specifies whether partial events need to be dropped */
>  	unsigned long *evmasks[EV_CNT];
>  	unsigned int bufsize;
>  	struct input_event buffer[];
> @@ -192,6 +193,7 @@ static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
>  {
>  	unsigned long flags;
>  	unsigned int clk_type;
> +	struct input_event ev;
>  
>  	switch (clkid) {
>  
> @@ -218,8 +220,26 @@ static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
>  		spin_lock_irqsave(&client->buffer_lock, flags);
>  
>  		if (client->head != client->tail) {
> -			client->packet_head = client->head = client->tail;
> +
> +			/* Store previous event */
> +			client->head--;
> +			client->head &= client->bufsize - 1;
> +			ev = client->buffer[client->head];
> +
> +			client->packet_head = client->head = client->tail = 0;
>  			__evdev_queue_syn_dropped(client);
> +
> +			/*
> +			 * If last packet is fully stored, queue SYN_REPORT
> +			 * so that clients do not ignore next full packet.
> +			 * And if last packet is NOT fully stored,
> +			 * set drop_pevent to true to ignore partial events.
> +			 */
> +			if (ev.type == EV_SYN && ev.code == SYN_REPORT) {
> +				ev.time = client->buffer[client->head - 1].time;

if client->head happens to be 0, your index won't be what it should be :)
you need the &= here and again after the next line:

> +				client->buffer[client->head++] = ev;



> +			} else if (ev.type != EV_SYN && ev.code != SYN_REPORT)
> +				client->drop_pevent = true;
>  		}
>  
>  		spin_unlock_irqrestore(&client->buffer_lock, flags);
> @@ -236,17 +256,27 @@ static void __pass_event(struct evdev_client *client,
>  
>  	if (unlikely(client->head == client->tail)) {
>  		/*
> -		 * This effectively "drops" all unconsumed events, leaving
> -		 * EV_SYN/SYN_DROPPED plus the newest event in the queue.
> +		 * This effectively "drops" all unconsumed events, storing
> +		 * EV_SYN/SYN_DROPPED and the newest event in the queue but
> +		 * only if it is EV_SYN/SYN_REPORT so that clients can read
> +		 * the next full event packet. And set drop_pevent to true
> +		 * if last event packet is not stored completely in buffer
> +		 * to ignore upcoming partial events.
>  		 */
> -		client->tail = (client->head - 2) & (client->bufsize - 1);
>  
> -		client->buffer[client->tail].time = event->time;
> -		client->buffer[client->tail].type = EV_SYN;
> -		client->buffer[client->tail].code = SYN_DROPPED;
> -		client->buffer[client->tail].value = 0;
> +		client->tail = client->head = client->packet_head;
>  
> -		client->packet_head = client->tail;
> +		client->buffer[client->head].time = event->time;
> +		client->buffer[client->head].type = EV_SYN;
> +		client->buffer[client->head].code = SYN_DROPPED;
> +		client->buffer[client->head].value = 0;
> +		client->head = (client->head + 1) & (client->bufsize -1);
> +
> +		if (event->type == EV_SYN && event->code == SYN_REPORT) {
> +			client->buffer[client->head++] = *event;
> +			client->head &= client->bufsize - 1;
> +		} else if (event->type != EV_SYN && event->code != SYN_REPORT)
> +			client->drop_pevent = true;

given that this condition is almost exactly the same as above, you should
share the code. you should also look into checking whether this can be moved
to __evdev_queue_syn_dropped() anyway, it seems like it can with little
effort.

The protocol itself looks correct now though.

Cheers,
   Peter

>  	}
>  
>  	if (event->type == EV_SYN && event->code == SYN_REPORT) {
> @@ -284,6 +314,14 @@ static void evdev_pass_values(struct evdev_client *client,
>  			wakeup = true;
>  		}
>  
> +		/* drop partial events of last packet but queue SYN_REPORT */
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
