From: Tai-hwa Liang <avatar@sentelic.com>
Subject: Re: [PATCH] only assign psmouse handlers on successful return from
 fsp_init()
Date: Thu, 29 Dec 2011 09:40:30 +0800 (CST)
Message-ID: <111229093848B.21736@cnaqrzbavhz.fragryvp.pbz>
References: <2424.1325103106@foxharp.boston.ma.us>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hermod.sentelic.com ([203.69.18.19]:32121 "EHLO
	hermod.sentelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754458Ab1L2Bl1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Dec 2011 20:41:27 -0500
In-Reply-To: <2424.1325103106@foxharp.boston.ma.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Fox <pgf@laptop.org>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Wed, 28 Dec 2011, Paul Fox wrote:
> the psmouse action routines were being initialized before all
> possible error conditions had been considered.  a subsequent
> failure would leave these handlers set, and later touchpad
> traffic or psmouse driver actions could cause them to be called,
> even though fsp_init() had failed.
>
> Signed-off-by: Paul Fox <pgf@laptop.org>

Acked-by: Tai-hwa Liang <avatar@sentelic.com>

> ---
> drivers/input/mouse/sentelic.c |   12 ++++++------
> 1 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/input/mouse/sentelic.c b/drivers/input/mouse/sentelic.c
> index 2fc887a..3539ca6 100644
> --- a/drivers/input/mouse/sentelic.c
> +++ b/drivers/input/mouse/sentelic.c
> @@ -842,12 +842,6 @@ int fsp_init(struct psmouse *psmouse)
> 	__set_bit(REL_WHEEL, psmouse->dev->relbit);
> 	__set_bit(REL_HWHEEL, psmouse->dev->relbit);
>
> -	psmouse->protocol_handler = fsp_process_byte;
> -	psmouse->disconnect = fsp_disconnect;
> -	psmouse->reconnect = fsp_reconnect;
> -	psmouse->cleanup = fsp_reset;
> -	psmouse->pktsize = 4;
> -
> 	/* set default packet output based on number of buttons we found */
> 	error = fsp_activate_protocol(psmouse);
> 	if (error)
> @@ -861,6 +855,12 @@ int fsp_init(struct psmouse *psmouse)
> 		goto err_out;
> 	}
>
> +	psmouse->protocol_handler = fsp_process_byte;
> +	psmouse->disconnect = fsp_disconnect;
> +	psmouse->reconnect = fsp_reconnect;
> +	psmouse->cleanup = fsp_reset;
> +	psmouse->pktsize = 4;
> +
> 	return 0;
>
>  err_out:
>
