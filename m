From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] [v8]Input: evdev: fix bug of dropping valid packet after
 syn_dropped event
Date: Thu, 21 Jan 2016 11:17:25 -0800
Message-ID: <20160121191725.GA39970@dtor-ws>
References: <1453397839-942-1-git-send-email-a.mathur@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33603 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759572AbcAUTR3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jan 2016 14:17:29 -0500
Content-Disposition: inline
In-Reply-To: <1453397839-942-1-git-send-email-a.mathur@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <a.mathur@samsung.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, aniroop.mathur@gmail.com

Hi Anoroop,

On Thu, Jan 21, 2016 at 11:07:19PM +0530, Aniroop Mathur wrote:
> If last event dropped in the old queue was EVi_SYN/SYN_REPORT, then lets
> generate EV_SYN/SYN_REPORT immediately after queing EV_SYN/SYN_DROPPED
> so that clients would not ignore next valid full packet events.
> 
> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
> ---
>  drivers/input/evdev.c | 46 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 34 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index e9ae3d5..821b68a 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -156,7 +156,12 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
>  static void __evdev_queue_syn_dropped(struct evdev_client *client)
>  {
>  	struct input_event ev;
> +	struct input_event *last_ev;
>  	ktime_t time;
> +	unsigned int mask = client->bufsize - 1;
> +
> +	/* capture last event stored in the buffer */
> +	last_ev = &client->buffer[(client->head - 1) & mask];

I have still the same comment. How do you know that event at last_ev
position is in fact valid and unconsumed yet event. Also, you need to
figure out not only if queue contains last SYN event, but also to handle
the case where the queue is empty and client has consumed either full or
partial packet at the time you are queueing the drop.

Also please enumerate what changes you done between version n and n+1 so
I do not have to compare them line by line trying to figure it out
myself.

Thanks.

-- 
Dmitry
