From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Keyboard LED state after suspend
Date: Thu, 13 Nov 2008 15:05:39 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0811131501250.3036-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jikos-AlSwsSmVLrQ@public.gmane.org>, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Jiri and Oliver:

I tried the experiment of turning off NumLock and all the other 
keyboard LED settings before hibernating.  After resuming, the LEDs on 
my PS/2 keyboard remained off but the NumLock LED on my USB keyboard 
was on.  Probably the BIOS turned it on during the restart and Linux 
never turned it back off.

Should we set the keyboard LED state whenever a keyboard is resumed?  
Is this handled already in the new autosuspend work?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
