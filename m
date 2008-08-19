From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: PROBLEM: USB keyboards works only 4 per PC host port
Date: Tue, 19 Aug 2008 11:03:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0808191049490.2669-100000@iolanthe.rowland.org>
References: <200808191527.06945.aivils@latnet.lv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200808191527.06945.aivils-zFrTw0b2IqLyG1zEObXtfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aivils Stoss <aivils-zFrTw0b2IqLyG1zEObXtfA@public.gmane.org>
Cc: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, lud <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Samuel Thibault <samuel.thibault-vYW+cPY1g1pg9hUCZPvPmw@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxconsole-dev-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, 19 Aug 2008, Aivils Stoss wrote:

> No problem is same. Older kernels have another troubles.
> 2.6.22-1-mepis-smp
> Quite stable. Have oops sometime inside evdev. Support up to 16 
> USB keyboards, where 4 hubs are plugged into PC and 4 keyboards on
> each hub. Any hub cascade support only 4 keyboards, where 5th or more
> is registered but don't send input events. Oops inside evdev , when
> USB keyboard unplugged. No slow down even all USB keyboards does
> not work properly. My be this one support more than 16 keyboards, but
> i don't have PC USB ports enough.
> 
> 2.6.24-7
> 4 keyboards per port. If plug in 5th tend to total slow down with this one:
> usb 2-1.1.1: reset low speed USB device using 
> uhci_hcd and address 17
> 5th - means 5th keyboard in USB hub's cascade, which is plugged into
> single PC USB port.
> 
> 2.6.26
> 4 keyboards per port. If plug in 5th tend to total slow down.
> 
> 2.6.27-rc3
> Sorry Randy i cannot repeat Your achievement. This worse of all tested
> kernels. I got working 3 USB keyboards, when i plug in 4th, all keyboards,
> include PS/2 stop working. Kernel does not hung up. I can reach box
> via net. dmesg , /proc/bus/input/devices attached. lsusb hung up.

Have you tried looking in your system log for error messages indicating 
the source of the problem?

uhci_hcd 0000:00:1d.1: bandwidth allocation failed: period 8, phase 4, 826 + 118 us
input: USB HID v1.10 Device [CHESEN USB Keyboard] on usb-0000:00:1d.1-2.2.4
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
uhci_hcd 0000:00:1d.1: bandwidth allocation failed: period 8, phase 4, 826 + 118 us
uhci_hcd 0000:00:1d.1: bandwidth allocation failed: period 8, phase 4, 826 + 118 us
uhci_hcd 0000:00:1d.1: bandwidth allocation failed: period 8, phase 4, 826 + 118 us
uhci_hcd 0000:00:1d.1: bandwidth allocation failed: period 8, phase 4, 826 + 118 us
uhci_hcd 0000:00:1d.1: bandwidth allocation failed: period 8, phase 4, 826 + 118 us
uhci_hcd 0000:00:1d.1: bandwidth allocation failed: period 8, phase 4, 826 + 118 us
uhci_hcd 0000:00:1d.1: bandwidth allocation failed: period 8, phase 4, 826 + 118 us
uhci_hcd 0000:00:1d.1: bandwidth allocation failed: period 8, phase 4, 826 + 118 us

Those messages seem pretty clear.  Each keyboard requires two interrupt 
transfers occupying 118 us of bandwidth apiece.  That's 236 us per 
keyboard.

Since there is only 900 us total available for interrupt transfers in
any frame, and since uhci-hcd isn't smart enough to allocate different
interrupt endpoints to different frames, you run out of bandwidth after
four keyboards.

Now if you plugged some of these keyboards into different UHCI 
controllers on the computer, then the problem wouldn't arise.  Each of 
your four UHCI controllers has two ports.  So without using any hubs at 
all, you can plug 8 keyboards into the computer and they will all work.

If you use some extra hubs as well then you can plug four keyboards 
into each controller, allowing you to use 16 keyboards total.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
