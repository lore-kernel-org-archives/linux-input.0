From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [patch]full autosuspend for USB HID
Date: Wed, 7 May 2008 12:06:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0805071204230.2174-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.64.0805071758240.11363@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0805071758240.11363-YCXOAqNspd+N3ZZ/Hiejyg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 7 May 2008, Jiri Kosina wrote:

> On Wed, 7 May 2008, Alan Stern wrote:
> 
> > > Unfortunately, I vaguely remember that some keyboards exposed the 
> > > behaviors only when connected to certain HCI controllers, so building 
> > > the whitelist might not be completely trivial.
> > Can we find out what Windows and OS-X do and copy them?
> 
> Actually I don't think they do runtime power management on USB HID 
> devices. At least I have never seen any windows machine to make the 
> USB keyboard LEDs to go off :)

I have a vague memory of seeing somewhere a list of keyboard types that 
one or the other of those OSs _would_ autosuspend.  It was pretty 
short, including only the Apple keyboard and a couple of others.

Unfortunately I don't remember _where_ I saw that list...

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
