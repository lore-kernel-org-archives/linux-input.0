From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input:Flush client events after clk_type change
Date: Tue, 6 Jan 2015 16:41:33 -0800
Message-ID: <20150107004133.GC12798@dtor-ws>
References: <anshul.g>
 <1420552953-23932-1-git-send-email-aksgarg1989@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:56312 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbbAGAli (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Jan 2015 19:41:38 -0500
Received: by mail-ie0-f181.google.com with SMTP id rl12so1001642iec.12
        for <linux-input@vger.kernel.org>; Tue, 06 Jan 2015 16:41:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1420552953-23932-1-git-send-email-aksgarg1989@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anshul Garg <aksgarg1989@gmail.com>
Cc: linux-input@vger.kernel.org, anshul.g@samsung.com

On Tue, Jan 06, 2015 at 06:02:33AM -0800, Anshul Garg wrote:
> From: Anshul Garg <aksgarg1989@gmail.com>
> 
> Since the client clk_type is changed , flush pending
> events from client buffer and queue SYN_DROPPED event.
> Added check for duplicate clk_type change request.
> 
> Signed-off-by: Anshul Garg <anshul.g@samsung.com>
> ---
>  drivers/input/evdev.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index b1a52ab..91330e1 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -64,6 +64,9 @@ struct evdev_client {
>  
>  static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
>  {
> +	if (client->clk_type == clkid)
> +		return 0;
> +
>  	switch (clkid) {
>  
>  	case CLOCK_REALTIME:
> @@ -78,7 +81,11 @@ static int evdev_set_clk_type(struct evdev_client *client, unsigned int clkid)
>  	default:
>  		return -EINVAL;
>  	}
> -
> +
> +	/* Flush clients events after clk_type is changed
> +	 * and queue SYN_DROPPED event.*/
> +	client->packet_head = client->head = client->tail;
> +	evdev_queue_syn_dropped(client);

I am fairly certain this is racy wrt the new events coming from the
device.

Thanks.

-- 
Dmitry
