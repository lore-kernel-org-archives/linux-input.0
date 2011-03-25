From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 3/4] input: evdev: Indicate buffer overrun with
 SYN_DROPPED.
Date: Fri, 25 Mar 2011 10:02:10 +0100
Message-ID: <20110325090210.GA5860@polaris.bitmath.org>
References: <1300842244-42723-1-git-send-email-jeffbrown@android.com>
 <1300842244-42723-4-git-send-email-jeffbrown@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1300842244-42723-4-git-send-email-jeffbrown@android.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Brown <jeffbrown@android.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff Brown <jeffbrown@google.com>
List-Id: linux-input@vger.kernel.org

> @@ -57,14 +57,20 @@ static void evdev_pass_event(struct evdev_client *client,
>  {
>  	/*
>  	 * Interrupts are disabled, just acquire the lock.
> -	 * Make sure we don't leave with the client buffer
> -	 * "empty" by having client->head == client->tail.
> +	 * When the client buffer is full, replace the tail with SYN_DROPPED
> +	 * to let the client know that events were dropped.  Ensure that the
> +	 * head and tail never coincide so the buffer does not appear "empty".
>  	 */
>  	spin_lock(&client->buffer_lock);
> -	do {
> -		client->buffer[client->head++] = *event;
> -		client->head &= client->bufsize - 1;
> -	} while (client->head == client->tail);
> +	client->buffer[client->head++] = *event;
> +	client->head &= client->bufsize - 1;
> +	if (client->head == client->tail) {
> +		client->tail = (client->tail + 1) & (client->bufsize - 1);
> +		client->buffer[client->tail].time = event->time;
> +		client->buffer[client->tail].type = EV_SYN;
> +		client->buffer[client->tail].code = SYN_DROPPED;
> +		client->buffer[client->tail].value = 0;
> +	}
>  	spin_unlock(&client->buffer_lock);

My last comment was not right, the SYN_DROPPED is pushed ahead in the
buffer, sorry about that. However, this change does not shrink the
number of buffered elements in case of an overrun, which has been
discussed before as a possibly important feature of the current
code. I would be more comfortable prepending the head with a
SYN_DROPPED, like this:

if (client->head == client->tail) {
	struct input_event drop;

	drop.time = event->time;
	drop.type = EV_SYN;
	drop.code = SYN_DROPPED;
	drop.value = 0;
	client->buffer[client->head++] = drop;
	client->head &= client->bufsize - 1;

	client->buffer[client->head++] = *event;
	client->head &= client->bufsize - 1;
}

The main point is that if we end up having to drop an event, it is
likely we will have to drop the next one, too.

Thanks,
Henrik
