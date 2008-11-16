From: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>
Subject: Re: USB hid blocks USB port in 2.6.28rc3
Date: Sun, 16 Nov 2008 23:12:23 +0100
Message-ID: <20081116221223.GA6703@one.firstfloor.org>
References: <20081111084132.GE3810@one.firstfloor.org> <Pine.LNX.4.44L0.0811111143050.29125-100000@netrider.rowland.org> <20081111210705.GG3810@one.firstfloor.org> <200811160058.14747.rjw@sisk.pl> <alpine.LNX.1.10.0811160053580.19853@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.10.0811160053580.19853-YCXOAqNspd+N3ZZ/Hiejyg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sun, Nov 16, 2008 at 12:54:28AM +0100, Jiri Kosina wrote:
> On Sun, 16 Nov 2008, Rafael J. Wysocki wrote:
> 
> > > Ok, but it worked in all kernels before. Why has that changed?
> > > Looks like a regression to me. Rafael, can you please add it to the list?
> > Done.
> 
> I already have a (verified) fix in my tree (not sent to Linus yet, will 
> happen in a day or two hopefully).

Yes confirmed. Jiri fixed the problem.

-Andi

-- 
ak-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
