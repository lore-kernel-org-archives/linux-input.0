From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: USB keyboard recognized as HID keyboard but doesn't work
Date: Mon, 2 May 2011 10:04:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1105021001490.2106-100000@iolanthe.rowland.org>
References: <4DBD9D0D.1080503@sieker.io>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4DBD9D0D.1080503-D1akFU9K7Sphl2p70BpVqQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Adi J. Sieker" <adi-D1akFU9K7Sphl2p70BpVqQ@public.gmane.org>
Cc: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sun, 1 May 2011, Adi J. Sieker wrote:

> On 01/05/11 09:53, Oliver Neukum wrote:
> > Am Samstag, 30. April 2011, 22:23:05 schrieb Adi J. Sieker:
> >> Hello,
> >>
> >> the lovely folks from #kernelnewbies suggested I write this mail since
> >> they are at a loss.
> >> I recently got a new USB keyboard which works fine in the BIOS and also
> >> in VBox Windows guests, but not on the host.
> >>
> >> The keyboard is a Keysonic KSK-8003 UX product details here:
> >> http://maxpoint.de/de/products/keyboards.php?pid=1_3_7&we_objectID=1220
> >>
> >> The menu key and the backspace keys do work. The num lock led is on,
> >> though I can't switch num lock off.
> >> If I attch the keyboard to a VirtualBox VM running WindowsXP as a guest,
> >> it works as expected in the VM.
> > This indicates that it is working on the USB level.
> >
> >> I'm running 2.6.32-27-generic #49-Ubuntu. I tried the Ubuntu 10.10
> >> LiveCD and that also didn't work. I haven't tried 11.04 yet though.
> > Do you get anything on the event device? What does udev say when you
> > plug in the device?

...

> one thing I found out is that this keyboard has some special anti 
> ghosting function for some keys. Where you can press multiple keys 
> simultaneously
> and they are all recognized. This is apparently great for gaming. Which 
> I'm not interested in...

Something else that might help is a usbmon trace showing what happens 
when you plug in the keyboard.  Instructions are in the kernel source 
file Documentation/usb/usbmon.txt.  In particular, while running the 
test try pressing some of the normal keys that don't work.

Also, it would help to see the output from "lsusb -v" for this device 
-- but you'll have to unbind it from the usbhid driver first.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
