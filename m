From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: Two regressions on BYT/T ASUS T100TA 4.12-rc: #2 Keyboard no
 longer works
Date: Wed, 7 Jun 2017 16:45:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1706071642230.1751-100000@iolanthe.rowland.org>
References: <20170607192158.1eb9db3a@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170607192158.1eb9db3a-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 7 Jun 2017, Alan Cox wrote:

> On Wed, 7 Jun 2017 18:07:44 +0200
> Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org> wrote:
> 
> > On Wed, Jun 07, 2017 at 04:27:30PM +0100, Alan Cox wrote:
> > > Booting 4.12-rc gives you a machine where neither the keyboard or the
> > > mouse of the base-station work.
> > > 
> > > Other USB devices work - including plugging in an external USB keyboard
> > > and mouse.
> > > 
> > > Removing the basestation and replugging it has no effect.
> > > 
> > > The base station is seen in lsusb.  
> > 
> > What is the "basestation"?  A USB hub?  Something else?
> 
> It's mostly USB. It has a non standard connector that plugs into the
> T100TA in tablet form. The non standard connector unfortunately means it
> can't be plugged into a standard USB hub to detect.
> 
> On unplug it logs the expected
> 
> usb-1-3: USB disconnect, device number 14
> 
> on reconnect I see
> 
> usb 1-3: new full-speed USB device number 16 using xhci_hcd
> usb 1-3: New USB device found, idVendor=0b05, idProduct=17e0
> usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> usb 1-3: Product: ASUS Base Station(T100)
> usb 1-3: Manufacturer: ASUSTek COMPUTER INC.
> 
> It's a USB keyboard, touchpad, storage and USB connector for external
> device.
> 
> The external device connected through it removes and reconnects just fine.
> 
> On older kernels it's coupled with a message 
> 
> input: ASUSTek COMPUTER INC. ASUS Base Station (T100) as /devices/..... /
> input# and binds to a HID Keyboard, HID device and HID mouse as 3 input
> devices.

Normally in this situation I'd recommend bisection.  However, this case
may be simple enough for a usbmon trace to provide the answer.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
