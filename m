From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Documentation: input - define INPUT_PROP_ACCELEROMETER
 behavior
Date: Fri, 27 Mar 2015 09:59:34 -0700
Message-ID: <20150327165934.GC17364@dtor-ws>
References: <20150327001106.GA16588@jelly.bne.redhat.com>
 <alpine.LNX.2.00.1503270112460.6781@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:34242 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753555AbbC0Q7j (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Mar 2015 12:59:39 -0400
Received: by igcau2 with SMTP id au2so35177452igc.1
        for <linux-input@vger.kernel.org>; Fri, 27 Mar 2015 09:59:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1503270112460.6781@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Ping Cheng <pingc@wacom.com>, Hans de Goede <hdegoede@redhat.com>, Bastien Nocera <hadess@hadess.net>

On Fri, Mar 27, 2015 at 01:17:20AM +0100, Jiri Kosina wrote:
> On Fri, 27 Mar 2015, Peter Hutterer wrote:
> 
> > Spell out what this property means to userspace. If the property is set, all
> > directional axes must be accelerometer axes, any other axes are left as-is.
> > This allows an accelerometer device to e.g. have an ABS_WHEEL.
> > 
> > It is not permitted to mix normal directional axes and accelerometer axes on
> > the same device node.
> > 
> > Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> > ---
> > I think this is the most sensible definition of what to expect when this
> > property is set on a device.
> 
> First, I am quilty here. I've let INPUT_PROP_ACCELEROMETER slip through my 
> tree without Dmitry's Ack, which is what I normally require for everything 
> touching input.h. Mea culpa maxima, I missed it, sorry for that.
> 
> This makes sense to me though. So
> 
> 	Acked-by: Jiri Kosina <jkosina@suse.cz>
> 
> but let's see what Dmitry has to say. 
> 
> Good thing is that this went only into 4.0-rc1, so if the whole 
> INPUT_PROP_ACCELEROMETER turns out to be absolute no-go for some reason, 
> we can still revert it.

No, I think that's fine. In the past I was hesitant of defining device
types, but at least for accelerometers, given that we state that we will
not be mixing them with regular directional axes, that should be fine.

I will apply this.

Thanks.

-- 
Dmitry
