From: Mikael Pettersson <mikpelinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: v4.13-rc2: usb mouse stopped working?
Date: Tue, 25 Jul 2017 10:54:22 +0200
Message-ID: <22903.1854.100968.989965@gargle.gargle.HOWL>
References: <20170724200056.GA3997@amd>
        <alpine.LSU.2.20.1707242203510.4705@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LSU.2.20.1707242203510.4705-YHPUNQjx9ReKbouaWp301Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Jiri Kosina writes:
 > On Mon, 24 Jul 2017, Pavel Machek wrote:
 > 
 > > On thinkpad x220, USB mouse stopped working in v4.13-rc2. v4.12 was
 > > ok, iirc.
 > > 
 > > Now, USB mouse is so common hw that I may have something wrong in my
 > > config...? But I did not change anything there.
 > 
 > Well, your particular USB mouse requires an always-poll quirk, so it's not 
 > *that* common; therefore ...
 > 
 > > In v4.9:
 > > 
 > > [   87.064408] input: Logitech USB Optical Mouse as
 > > /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.1/2-1.1.1/2-1.1.1.1/2-1.1.1.1:1.0/0003:046D:C05A.0005/input/input18
 > > [   87.065951] hid-generic 0003:046D:C05A.0005: input,hidraw0: USB HID
 > > v1.11 Mouse [Logitech USB Optical Mouse] on
 > > usb-0000:00:1d.0-1.1.1.1/input0
 > > pavel@duo:~$
 > > 
 > > v4.13-rc2:
 > > 
 > > [   87.886810] usb 2-1.1.1.1: new low-speed USB device number 10 using ehci-pci
 > > [   88.019543] usb 2-1.1.1.1: New USB device found, idVendor=046d, idProduct=c05a
 > > [   88.019561] usb 2-1.1.1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
 > > [   88.019572] usb 2-1.1.1.1: Product: USB Optical Mouse
 > > [   88.019581] usb 2-1.1.1.1: Manufacturer: Logitech
 > > [   88.027276] input: Logitech USB Optical Mouse as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.1/2-1.1.1/2-1.1.1.1/2-1.1.1.1:1.0/0003:046D:C05A.0005/input/input18
 > > [   88.027825] hid-generic 0003:046D:C05A.0005: input,hidraw1: USB HID
 > > v1.11 Mouse [Logitech USB Optical Mouse] on
 > > usb-0000:00:1d.0-1.1.1.1/input0
 > 
 > ... this is most likely caused by e399396a6b0, and fix for that is queued 
 > in hid.git as cf601774c9f ("HID: usbhid: fix "always poll" quirk"); I'm 
 > planning to send it to Linus' tomorrow, but if you can double-check that 
 > it does fix your issue as well, that'd be appreciated.

I had a similar problem (a Logitech USB Optical Mouse being completely dead
with 4.13-rc[12]), and cf601774c9f fixed it.

/Mikael
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
