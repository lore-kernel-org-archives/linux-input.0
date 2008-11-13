From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Keyboard LED state after suspend
Date: Thu, 13 Nov 2008 16:52:53 -0500
Message-ID: <20081113165230.ZZRA012@mailhub.coreip.homeip.net>
References: <Pine.LNX.4.44L0.0811131501250.3036-100000@iolanthe.rowland.org> <200811132208.37874.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200811132208.37874.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Jiri Kosina <jikos-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Nov 13, 2008 at 10:08:37PM +0100, Oliver Neukum wrote:
> Am Donnerstag, 13. November 2008 21:05:39 schrieb Alan Stern:
> > Jiri and Oliver:
> > 
> > I tried the experiment of turning off NumLock and all the other 
> > keyboard LED settings before hibernating.  After resuming, the LEDs on 
> > my PS/2 keyboard remained off but the NumLock LED on my USB keyboard 
> > was on.  Probably the BIOS turned it on during the restart and Linux 
> > never turned it back off.
> > 
> > Should we set the keyboard LED state whenever a keyboard is resumed?  
> > Is this handled already in the new autosuspend work?
> 
> No, as this is no autosuspend problem. In fact it is not a driver problem
> at all. This suggests that the HID layer should have hooks in resumption.
> 

Actually I have patches that do that in input layer.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
