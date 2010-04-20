From: "Peter M. Petrakis" <peter.petrakis@canonical.com>
Subject: Re: [PATCH] Reset ps/2 port should psmouse_probe	fail	before	retrying
Date: Tue, 20 Apr 2010 17:08:28 -0400
Message-ID: <4BCE17CC.8020804@canonical.com>
References: <4BC8EA42.6030507@canonical.com>	 <1271502098.4155.27.camel@lovely>  <4BC9D444.3090802@canonical.com>	 <1271523195.3676.5.camel@lovely>  <4BCC77B4.5030703@canonical.com> <1271723857.6652.6.camel@lovely>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:33390 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146Ab0DTVIb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Apr 2010 17:08:31 -0400
In-Reply-To: <1271723857.6652.6.camel@lovely>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: linux-input@vger.kernel.org, rubini@cvml.unipv.it

Ugh... I never get out of suspend with this patch, also
tried i8042_toggle_aux(false) followed by ... (true) with the
same result. Any other ideas? Thanks.

Peter

On 04/19/2010 08:37 PM, Christoph Fritz wrote:
> Hi Peter,
> 
>  does this work for you?
> 
> I8042_CMD_AUX_ENABLE gets now triggered during pm_restore.
> 
> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
> index 6440a8f..1af5a58 100644
> --- a/drivers/input/serio/i8042.c
> +++ b/drivers/input/serio/i8042.c
> @@ -1151,8 +1151,10 @@ static int i8042_pm_restore(struct device *dev)
>  			printk(KERN_WARNING
>  				"i8042: failed to resume active multiplexor, "
>  				"mouse won't work.\n");
> -	} else if (i8042_ports[I8042_AUX_PORT_NO].serio)
> +	} else if (i8042_ports[I8042_AUX_PORT_NO].serio) {
> +		i8042_toggle_aux(true);
>  		i8042_enable_aux_port();
> +	}
>  
>  	if (i8042_ports[I8042_KBD_PORT_NO].serio)
>  		i8042_enable_kbd_port();
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
