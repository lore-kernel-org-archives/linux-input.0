From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input:Flush client events on clk_type change
Date: Wed, 7 Jan 2015 11:32:07 -0800
Message-ID: <20150107193207.GA3508@dtor-ws>
References: <aksgarg1989@gmail.com>
 <1420656963-44602-1-git-send-email-aksgarg1989@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:43322 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbbAGTcM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Jan 2015 14:32:12 -0500
Received: by mail-ig0-f182.google.com with SMTP id hn15so1865707igb.3
        for <linux-input@vger.kernel.org>; Wed, 07 Jan 2015 11:32:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1420656963-44602-1-git-send-email-aksgarg1989@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anshul Garg <aksgarg1989@gmail.com>
Cc: linux-input@vger.kernel.org, anshul.g@samsung.com

On Wed, Jan 07, 2015 at 10:56:03AM -0800, Anshul Garg wrote:
> From: Anshul Garg <aksgarg1989@gmail.com>
> 
> Since the client clk_type is changed , flush pending
> events from client buffer and queue SYN_DROPPED event.
> Added check for duplicate clk_type change request.
> 
> Signed-off-by: Anshul Garg <anshul.g@samsung.com>
> ---
>  drivers/input/evdev.c |   58 ++++++++++++++++++++++++++++++-------------------
>  1 file changed, 36 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index b1a52ab..223367e 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -62,27 +62,6 @@ struct evdev_client {
>  	struct input_event buffer[];
>  };
>  
> -static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
> -{
> -	switch (clkid) {
> -
> -	case CLOCK_REALTIME:
> -		client->clk_type = EV_CLK_REAL;
> -		break;
> -	case CLOCK_MONOTONIC:
> -		client->clk_type = EV_CLK_MONO;
> -		break;
> -	case CLOCK_BOOTTIME:
> -		client->clk_type = EV_CLK_BOOT;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -/* flush queued events of type @type, caller must hold client->buffer_lock */
>  static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
>  {
>  	unsigned int i, head, num;
> @@ -160,6 +139,41 @@ static void evdev_queue_syn_dropped(struct evdev_client *client)
>  	spin_unlock_irqrestore(&client->buffer_lock, flags);
>  }
>  
> +static int evdev_set_clk_type(struct evdev_client *client,
> +			struct input_dev *dev, unsigned int clkid)
> +{
> +	if (client->clk_type == clkid)
> +		return 0;
> +
> +	switch (clkid) {
> +
> +	case CLOCK_REALTIME:
> +		client->clk_type = EV_CLK_REAL;
> +		break;
> +	case CLOCK_MONOTONIC:
> +		client->clk_type = EV_CLK_MONO;
> +		break;
> +	case CLOCK_BOOTTIME:
> +		client->clk_type = EV_CLK_BOOT;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	spin_lock_irq(&dev->event_lock);
> +	spin_lock(&client->buffer_lock);
> +	spin_unlock(&dev->event_lock);

Umm, why?

> +
> +	/* Flush clients events after clk_type is changed
> +	 * and queue SYN_DROPPED event.*/
> +	client->packet_head = client->head = client->tail;
> +	spin_unlock_irq(&client->buffer_lock);
> +
> +	evdev_queue_syn_dropped(client);

This is still racy. I'd rather we passed a flag to
evdev_queue_syn_dropped() to indicate it should also clear queue.

Thanks.

-- 
Dmitry
