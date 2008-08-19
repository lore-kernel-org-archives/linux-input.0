From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: PROBLEM: USB keyboards works only 4 per PC host port
Date: Tue, 19 Aug 2008 17:23:07 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0808191721560.18058@jikos.suse.cz>
References: <200808080702.24969.aivils@latnet.lv> <200808181642.49489.aivils@latnet.lv> <20080818081432.782d9632.rdunlap@xenotime.net> <200808191527.06945.aivils@latnet.lv> <20080819081936.37fef673.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080819081936.37fef673.rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Cc: Aivils Stoss <aivils-zFrTw0b2IqLyG1zEObXtfA@public.gmane.org>, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, lud <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Samuel Thibault <samuel.thibault-vYW+cPY1g1pg9hUCZPvPmw@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxconsole-dev-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, 19 Aug 2008, Randy Dunlap wrote:

> > 2.6.22-1-mepis-smp
> > Quite stable. Have oops sometime inside evdev. Support up to 16 
> > USB keyboards, where 4 hubs are plugged into PC and 4 keyboards on
> > each hub. Any hub cascade support only 4 keyboards, where 5th or more
> > is registered but don't send input events. Oops inside evdev , when
> > USB keyboard unplugged. No slow down even all USB keyboards does
> > not work properly. My be this one support more than 16 keyboards, but
> > i don't have PC USB ports enough.
> Has the evdev oops been reported and/or fixed? I think that we would 
> prefer to fix that soonish.

We haven't seen the respective oops yet, or have I missed it?

I'd bet it is fixed in newer kernels by patches that introduce proper 
locking into evdev code.

-- 
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
