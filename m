From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Documentation: input - define INPUT_PROP_ACCELEROMETER
 behavior
Date: Fri, 27 Mar 2015 01:17:20 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1503270112460.6781@pobox.suse.cz>
References: <20150327001106.GA16588@jelly.bne.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51790 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752342AbbC0ARY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Mar 2015 20:17:24 -0400
In-Reply-To: <20150327001106.GA16588@jelly.bne.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Ping Cheng <pingc@wacom.com>, Hans de Goede <hdegoede@redhat.com>, Bastien Nocera <hadess@hadess.net>

On Fri, 27 Mar 2015, Peter Hutterer wrote:

> Spell out what this property means to userspace. If the property is set, all
> directional axes must be accelerometer axes, any other axes are left as-is.
> This allows an accelerometer device to e.g. have an ABS_WHEEL.
> 
> It is not permitted to mix normal directional axes and accelerometer axes on
> the same device node.
> 
> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> ---
> I think this is the most sensible definition of what to expect when this
> property is set on a device.

First, I am quilty here. I've let INPUT_PROP_ACCELEROMETER slip through my 
tree without Dmitry's Ack, which is what I normally require for everything 
touching input.h. Mea culpa maxima, I missed it, sorry for that.

This makes sense to me though. So

	Acked-by: Jiri Kosina <jkosina@suse.cz>

but let's see what Dmitry has to say. 

Good thing is that this went only into 4.0-rc1, so if the whole 
INPUT_PROP_ACCELEROMETER turns out to be absolute no-go for some reason, 
we can still revert it.

Thanks, and sorry again.

>  Documentation/input/event-codes.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/input/event-codes.txt b/Documentation/input/event-codes.txt
> index 9d13600..1756b97 100644
> --- a/Documentation/input/event-codes.txt
> +++ b/Documentation/input/event-codes.txt
> @@ -294,6 +294,12 @@ accordingly. This property does not affect kernel behavior.
>  The kernel does not provide button emulation for such devices but treats
>  them as any other INPUT_PROP_BUTTONPAD device.
>  
> +INPUT_PROP_ACCELEROMETER
> +-------------------------
> +Directional axes on this device (absolute and/or relative x, y, z) represent
> +accelerometer data. All other axes retain their meaning. A device must not mix
> +regular directional axes and accelerometer axes on the same event node.
> +
>  Guidelines:
>  ==========
>  The guidelines below ensure proper single-touch and multi-finger functionality.
> -- 
> 2.3.3
> 

-- 
Jiri Kosina
SUSE Labs
