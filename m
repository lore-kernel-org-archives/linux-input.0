From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: ALPS v4 Semi-mt Support
Date: Mon, 16 Apr 2012 16:24:07 -0500
Message-ID: <20120416212407.GE3959@thinkpad-t410>
References: <1364401.K99JIOKFyb@vaio>
 <20120410152113.GC21994@thinkpad-t410>
 <20120410215939.GE21994@thinkpad-t410>
 <1492453.bjpWEAk9kj@vaio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:41439 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023Ab2DPVYL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Apr 2012 17:24:11 -0400
Content-Disposition: inline
In-Reply-To: <1492453.bjpWEAk9kj@vaio>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: George Pantalos <gpantalos@gmail.com>
Cc: linux-input@vger.kernel.org

On Mon, Apr 16, 2012 at 05:24:55PM +0300, George Pantalos wrote:
>  I decided to try and improve upon your patch which has superior state 
> processing. I followed your proposal initially and stashed the first and 
> second packet ST data in alps_data and if bitmap fingers < 2 report all the ST 
> data.
> The problem with this approach is that it introduces a noticeable delay/lag in 
> mouse pointer movement.
> 
> I then tried using the last_fingers approach.  This way we report ST data as 
> they come but only if the last MT report had 1 finger present and we always 
> (as far as I can tell) must have calculated bitmap finger count before 
> reporting ST events. I have posted this patch below. I also observed jumpy 
> behavior with the xf86-input-multitouch driver when the MT report had 1 
> finger, so if bitmap fingers are 1 , it uses x,y instead of x1,y1.
> This approach has the benefit of producing smooth pointer movement and 
> accurately reporting MT events like the other approach.

If the latency really is noticible when you stash the ST points, here's
what I'd suggest trying instead. Stash away the last set of MT data you
saw and repeat it with each of the next two ST coordinates. I suspect
that will probably work well enough, and will allow every ST point to
still be reported. And it should significantly simplify the code as
well.

> To handle inconsistent data I used your patch to dump raw packets.  I noticed 
> ,as your documentation also states, that the condition (packet[6] & 0x40) 
> could also be triggered by the second MT packet and then reset 
> multi_packet to 0.
> So I used the fact that byte 5 of the MT data, priv->multi_data [4] must 
> always be 0x00. A kind of second sync byte to ensure we have correct MT 
> reports. Unless the MT data is consistent we report nothing.

You should keep in mind that the documentation is based purely on my
observations. I observed that the 4th byte of the assembled MT data
packet is alwyas 0, so that's how I documented it. That doesn't
necessarily mean that it really is always 0, just that I could never get
it to assume any other value.

> +	if ((packet[6] & 0x40) && (priv->multi_data[4] == 0x00)) {
> +		/* sync, reset position */
> +		priv->multi_packet = 0;
> +	}

If you see the sync bit set, it's _always_ the first fragment of the MT
data, so you shoule _always_ reset the position. Why should past data
have any effect on this decision?

> +	/*
> +	 * The 5th byte of the MT data must always be 0x00.
> +	 * Try to re-sync our position if MT data is inconsistent.
> +	 */
> +	if (priv->multi_data[4] != 0x00)
> +		return;

This doesn't really re-sync the position, and the sync bit is sufficient
for this purpose anyway. I'd propose that if you really think checking
multi_data[4] is beneficial, use it only for validating the MT packet
before parsing it.

> +	} else {
> +		if (priv->last_fingers == 1) {
> +			if (z >= 64)
> +				input_report_key(dev, BTN_TOUCH, 1);
> +			else
> +				input_report_key(dev, BTN_TOUCH, 0);
> +
> +			alps_report_semi_mt_data(dev, 1, x, y, 0, 0);
> +
> +			input_report_key(dev, BTN_TOOL_FINGER, z > 0);

Even if you use a separate case here you need to update the other
BTN_TOOL keys. The 1 to 0 transition is needed for userspace to know
that the situation has changed. Failing to report any value is not the
same as reporting a value of 0.

