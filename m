From: Andy Isaacson <adi@hexapodia.org>
Subject: Re: ALPS input driver problem with DualPoint on Dell E6400/E6500 [patch]
Date: Mon, 23 Feb 2009 16:16:12 -0800
Message-ID: <20090224001612.GA18077@hexapodia.org>
References: <1227638742.5353.5.camel@mobian> <20081208141438.GA30462@cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from straum.hexapodia.org ([64.81.70.185]:5379 "EHLO
	straum.hexapodia.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758568AbZBXAW6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Feb 2009 19:22:58 -0500
Content-Disposition: inline
In-Reply-To: <20081208141438.GA30462@cse.unsw.EDU.AU>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Chapman <matthewc@cse.unsw.edu.au>
Cc: Alexander Hofbauer <alex@derhofbauer.at>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Tue, Dec 09, 2008 at 01:14:38AM +1100, Matthew Chapman wrote:
> Hi,
> 
> Here's a patch that implements the 9-byte packet format, which solves
> the problem for me.
> 
> Matt

Matt,

Your patch fixes http://bugzilla.kernel.org/show_bug.cgi?id=12577 for
me.  Would you consider resending it to linux-input@ with your
Signed-off-by?

Thanks,
-andy

> --- linux-2.6.27/drivers/input/mouse/alps.c	2008-12-09 00:31:48.000000000 +1100
> +++ linux-2.6.27.alps/drivers/input/mouse/alps.c	2008-12-09 01:08:09.000000000 +1100
> @@ -100,6 +100,19 @@
>  		return;
>  	}
>  
> +	if ((packet[3] & 0xf) == 0xf) {
> +		/* 9-byte packet format seen on some DualPoints */
> +		/* handle relative update and then fall through for remainder */
> +		input_report_rel(dev2, REL_X,
> +			packet[4] ? packet[4] - ((packet[3] << 4) & 0x100) : 0);
> +		input_report_rel(dev2, REL_Y,
> +			packet[5] ? ((packet[3] << 3) & 0x100) - packet[5] : 0);
> +		input_sync(dev2);
> +		packet[3] = packet[6];
> +		packet[4] = packet[7];
> +		packet[5] = packet[8];
> +	}
> +
>  	if (priv->i->flags & ALPS_OLDPROTO) {
>  		left = packet[2] & 0x10;
>  		right = packet[2] & 0x08;
> @@ -197,6 +210,21 @@
>  	if ((psmouse->packet[0] & priv->i->mask0) != priv->i->byte0)
>  		return PSMOUSE_BAD_DATA;
>  
> +	if ((psmouse->pktcnt >= 4) && ((psmouse->packet[3] & 0xf) == 0xf))
> +	{
> +		/* 9-byte packet format seen on some DualPoints */
> +		/* Bytes 7 - 9 should have 0 in the highest bit */
> +		if ((psmouse->pktcnt >= 7) && (psmouse->pktcnt <= 9) &&
> +		    (psmouse->packet[psmouse->pktcnt - 1] & 0x80))
> +			return PSMOUSE_BAD_DATA;
> +
> +		if (psmouse->pktcnt == 9) {
> +			alps_process_packet(psmouse);
> +			return PSMOUSE_FULL_PACKET;
> +		}
> +		return PSMOUSE_GOOD_DATA;
> +	}
> +
>  	/* Bytes 2 - 6 should have 0 in the highest bit */
>  	if (psmouse->pktcnt >= 2 && psmouse->pktcnt <= 6 &&
>  	    (psmouse->packet[psmouse->pktcnt - 1] & 0x80))
> --- linux-2.6.27/drivers/input/mouse/psmouse.h	2008-10-10 09:13:53.000000000 +1100
> +++ linux-2.6.27.alps/drivers/input/mouse/psmouse.h	2008-11-06 02:32:45.000000000 +1100
> @@ -42,7 +42,7 @@
>  	struct work_struct resync_work;
>  	char *vendor;
>  	char *name;
> -	unsigned char packet[8];
> +	unsigned char packet[9];
>  	unsigned char badbyte;
>  	unsigned char pktcnt;
>  	unsigned char pktsize;

