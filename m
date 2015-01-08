From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Optimize Event Filter functionality
Date: Thu, 8 Jan 2015 13:51:02 -0800
Message-ID: <20150108215102.GF23256@dtor-ws>
References: <aksgarg1989@gmail.com>
 <1420724384-54188-1-git-send-email-aksgarg1989@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36339 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbbAHVvH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Jan 2015 16:51:07 -0500
Received: by mail-ig0-f181.google.com with SMTP id a13so5203528igq.2
        for <linux-input@vger.kernel.org>; Thu, 08 Jan 2015 13:51:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1420724384-54188-1-git-send-email-aksgarg1989@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anshul Garg <aksgarg1989@gmail.com>
Cc: linux-input@vger.kernel.org, anshul.g@samsung.com

On Thu, Jan 08, 2015 at 05:39:44AM -0800, Anshul Garg wrote:
> From: Anshul Garg <aksgarg1989@gmail.com>
> 
> As input_pass_values function is called everytime when EV_SYN is sent
> from input driver or input event buffer becomes full.
> So in case of regular handler event filter code should not run so added
> check whether handler supports filter or not.
> 
> Signed-off-by: Anshul Garg <anshul.g@samsung.com>

Applied, thank you.

> ---
>  drivers/input/input.c |   24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 213e3a1..de55279 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -100,23 +100,24 @@ static unsigned int input_to_handler(struct input_handle *handle,
>  	struct input_value *end = vals;
>  	struct input_value *v;
>  
> -	for (v = vals; v != vals + count; v++) {
> -		if (handler->filter &&
> -		    handler->filter(handle, v->type, v->code, v->value))
> -			continue;
> -		if (end != v)
> -			*end = *v;
> -		end++;
> +	if (handler->filter) {
> +		for (v = vals; v != vals + count; v++) {
> +			if (handler->filter(handle, v->type, v->code, v->value))
> +				continue;
> +			if (end != v)
> +				*end = *v;
> +			end++;
> +		}
> +		count = end - vals;
>  	}
>  
> -	count = end - vals;
>  	if (!count)
>  		return 0;
>  
>  	if (handler->events)
>  		handler->events(handle, vals, count);
>  	else if (handler->event)
> -		for (v = vals; v != end; v++)
> +		for (v = vals; v != vals + count; v++)
>  			handler->event(handle, v->type, v->code, v->value);
>  
>  	return count;
> @@ -143,8 +144,11 @@ static void input_pass_values(struct input_dev *dev,
>  		count = input_to_handler(handle, vals, count);
>  	} else {
>  		list_for_each_entry_rcu(handle, &dev->h_list, d_node)
> -			if (handle->open)
> +			if (handle->open) {
>  				count = input_to_handler(handle, vals, count);
> +				if (!count)
> +					break;
> +			}
>  	}
>  
>  	rcu_read_unlock();
> -- 
> 1.7.9.5
> 
> 
> ---
> This email has been checked for viruses by Avast antivirus software.
> http://www.avast.com
> 

-- 
Dmitry
