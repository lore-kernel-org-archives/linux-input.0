From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: evdev - Avoid duplicate checking of empty
 SYN_REPORT
Date: Sat, 2 Jan 2016 20:31:06 -0800
Message-ID: <20160103043106.GA23680@dtor-ws>
References: <1451517958-2173-1-git-send-email-a.mathur@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:32777 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbcACEbL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 2 Jan 2016 23:31:11 -0500
Content-Disposition: inline
In-Reply-To: <1451517958-2173-1-git-send-email-a.mathur@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <a.mathur@samsung.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, aniroop.mathur@gmail.com

Hi Aniroop,

On Thu, Dec 31, 2015 at 04:55:58AM +0530, Aniroop Mathur wrote:
> Input core already drops empty syn_report event so there is no need
> to check again for dropping empty syn_report event in evdev handler
> for all clients on every new event.

This reasoning is flawed: if all events from the packet are filtered out
for the given client we should be suppressing EV_SYN/SYN_REPORT pair as
well.

Thanks.

> 
> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
> ---
>  drivers/input/evdev.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index e9ae3d5..6e242b7 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -276,13 +276,8 @@ static void evdev_pass_values(struct evdev_client *client,
>  		if (__evdev_is_filtered(client, v->type, v->code))
>  			continue;
>  
> -		if (v->type == EV_SYN && v->code == SYN_REPORT) {
> -			/* drop empty SYN_REPORT */
> -			if (client->packet_head == client->head)
> -				continue;
> -
> +		if (v->type == EV_SYN && v->code == SYN_REPORT)
>  			wakeup = true;
> -		}
>  
>  		event.type = v->type;
>  		event.code = v->code;
> -- 
> 2.6.2
> 

-- 
Dmitry
