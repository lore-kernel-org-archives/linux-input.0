From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] [v5]Input: evdev: fix bug of dropping full valid packet
 after syn_dropped
Date: Wed, 13 Jan 2016 10:52:39 -0800
Message-ID: <20160113185239.GC39593@dtor-ws>
References: <1452686262-6684-1-git-send-email-a.mathur@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33626 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756455AbcAMSwm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2016 13:52:42 -0500
Content-Disposition: inline
In-Reply-To: <1452686262-6684-1-git-send-email-a.mathur@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <a.mathur@samsung.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, aniroop.mathur@gmail.com, s.samuel@samsung.com, r.mahale@samsung.com

On Wed, Jan 13, 2016 at 05:27:41PM +0530, Aniroop Mathur wrote:
> If last event in old queue that was dropped was EV_SYN/SYN_REPORT, then
> lets generate EV_SYN/SYN_REPORT immediately after queing EV_SYN/SYN_DROPPED
> so that clients would not ignore next valid full packet events.
> 
> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
> ---
>  drivers/input/evdev.c |   45 +++++++++++++++++++++++++++++++++------------
>  1 file changed, 33 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index e9ae3d5..0bc7b98 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -156,7 +156,12 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
>  static void __evdev_queue_syn_dropped(struct evdev_client *client)
>  {
>  	struct input_event ev;
> +	struct input_event *prev_ev;
>  	ktime_t time;
> +	unsigned int mask = client->bufsize - 1;
> +
> +	/* store previous event */
> +	prev_ev = &client->buffer[(client->head - 1) & mask];

How do you know that previous event is valid/exists? In fact, when we
are dropping events due to the full queue, you will be referencing the
newest event being processed, not the previous event.

I also wonder if this code is safe with regard to __evdev_flush_queue()
that is dropping bunch of events and possible empty SYN_REPORT groups.

Thanks.

-- 
Dmitry
