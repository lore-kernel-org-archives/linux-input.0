From: "Peter M. Petrakis" <peter.petrakis@canonical.com>
Subject: Re: [PATCH] Reset ps/2 port should	psmouse_probe	fail	before	retrying
Date: Thu, 22 Apr 2010 17:48:21 -0400
Message-ID: <4BD0C425.5030609@canonical.com>
References: <1271502098.4155.27.camel@lovely>	 <4BC9D444.3090802@canonical.com> <1271523195.3676.5.camel@lovely>	 <4BCC77B4.5030703@canonical.com> <1271723857.6652.6.camel@lovely>	 <4BCE17CC.8020804@canonical.com>	 <20100421063328.GJ4364@core.coreip.homeip.net>	 <4BCF2263.40306@canonical.com>	 <20100421171055.GB10566@core.coreip.homeip.net>	 <4BCF5453.5060703@canonical.com>	 <20100421195238.GA10641@core.coreip.homeip.net>	 <4BCF69CB.7010000@canonical.com> <1271953731.4566.27.camel@lovely>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:52913 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611Ab0DVVsW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Apr 2010 17:48:22 -0400
In-Reply-To: <1271953731.4566.27.camel@lovely>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, rubini@cvml.unipv.it

Hi,

This one is a winner. with regards to your follow up. I wouldn't
want to reset something unless we have cause to. This code
seems to be doing the right thing e.g. I see "unable to query
synaptics hardware" followed by it's (re)discovery on return
from S3.

When it's fully supported by the Synaptics driver, the initial
reconnect will succeed and we'll never get to this additional
failsafe code which is essentially a catch all for the bleeding
edge.

Peter

On 04/22/2010 12:28 PM, Christoph Fritz wrote:
> Hi,
> 
> to quote 4d368456808c977b8e9782dbe9542cf8ddedbab8 :
> 
> Input: synaptics - ensure we reset the device on resume
>     
>     When resuming from suspend newer Synaptics touchpads do not recover
>     correctly.  Analysis of the resume sequence as applied in Linux was
>     compared to that of other operating systems.  This indicated that the
>     other OSs were resetting the mouse before attempting to detect it (for
>     all Synaptics touchpads, old and new).  Applying this same modification
>     fixes these newer Synaptics touchpads and brings the driver into line
>     with common OS reset behaviour.
> <quote end>
> 
> 
> So Synaptics touchpads which are not not yet covered by their
> driver need to be resetted when resuming from suspend.
> 
> But the device we are actually talking about will be sooner or later supported
> by the synaptics driver, and should all other devices who act normal be resetted
> too?
> 
> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
> index d8c0c8d..6877371 100644
> --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c
> @@ -1383,6 +1383,7 @@ static int psmouse_reconnect(struct serio *serio)
>  	struct psmouse *parent = NULL;
>  	struct serio_driver *drv = serio->drv;
>  	int rc = -1;
> +	int retries = 0;
>  
>  	if (!drv || !psmouse) {
>  		printk(KERN_DEBUG "psmouse: reconnect request, but serio is disconnected, ignoring...\n");
> @@ -1401,10 +1402,14 @@ static int psmouse_reconnect(struct serio *serio)
>  	if (psmouse->reconnect) {
>  		if (psmouse->reconnect(psmouse))
>  			goto out;
> -	} else if (psmouse_probe(psmouse) < 0 ||
> +	} else {
> +		while ((retries++ < 3) && psmouse_reset(psmouse))
> +			/* empty */;
> +		if (psmouse_probe(psmouse) < 0 ||
>  		   psmouse->type != psmouse_extensions(psmouse,
>  						psmouse_max_proto, false)) {
> -		goto out;
> +			goto out;
> +		}
>  	}
>  
>  	/* ok, the device type (and capabilities) match the old one,
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
