From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: Keyboard LED state after suspend
Date: Thu, 13 Nov 2008 22:08:37 +0100
Message-ID: <200811132208.37874.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0811131501250.3036-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.0811131501250.3036-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Jiri Kosina <jikos-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Am Donnerstag, 13. November 2008 21:05:39 schrieb Alan Stern:
> Jiri and Oliver:
> 
> I tried the experiment of turning off NumLock and all the other 
> keyboard LED settings before hibernating.  After resuming, the LEDs on 
> my PS/2 keyboard remained off but the NumLock LED on my USB keyboard 
> was on.  Probably the BIOS turned it on during the restart and Linux 
> never turned it back off.
> 
> Should we set the keyboard LED state whenever a keyboard is resumed?  
> Is this handled already in the new autosuspend work?

No, as this is no autosuspend problem. In fact it is not a driver problem
at all. This suggests that the HID layer should have hooks in resumption.

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
