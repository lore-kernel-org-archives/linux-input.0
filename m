From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: i8042-x86ia64io.h: Add Pegatron touchpad to
 noloop table
Date: Sun, 18 Dec 2016 15:26:52 -0800
Message-ID: <20161218232652.GA31941@dtor-ws>
References: <20161217022031.6073-1-marcos.souza.org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35732 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbcLRX0z (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 18 Dec 2016 18:26:55 -0500
Content-Disposition: inline
In-Reply-To: <20161217022031.6073-1-marcos.souza.org@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc: Patrick Scheuring <patrick.scheuring.dev@gmail.com>, =?iso-8859-1?Q?Aur=E9lien?= Francillon <aurelien@francillon.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Dec 17, 2016 at 12:19:34AM -0200, Marcos Paulo de Souza wrote:
> Avoid AUX loopback in Pegatron C15B touchpad, so input subsystem is able
> to recognize a synaptics touchpad in the AUX port.
> 
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=93791
> (Touchpad is not detected on DNS 0801480 notebook (PEGATRON C15B))
> 
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>

Applied, thank you.

> ---
>  drivers/input/serio/i8042-x86ia64io.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index ddd3132..1776dc6 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -211,6 +211,12 @@ static const struct dmi_system_id __initconst i8042_dmi_noloop_table[] = {
>  			DMI_MATCH(DMI_PRODUCT_VERSION, "Rev 1"),
>  		},
>  	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "PEGATRON CORPORATION"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "C15B"),
> +		},
> +	},
>  	{ }
>  };
>  
> -- 
> 2.9.3
> 

-- 
Dmitry
