From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] usbhid: add quirk for another PIXART OEM mouse used by HP
Date: Mon, 27 Nov 2017 17:15:41 +0800
Message-ID: <20171127091541.GA23299@dhcp-128-65.nay.redhat.com>
References: <20171125055054.GA2139@dhcp-128-65.nay.redhat.com>
 <20171127081631.GB30708@mail.corp.redhat.com>
 <20171127083242.GA17756@kroah.com>
 <20171127084951.GF30708@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171127084951.GF30708@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 11/27/17 at 09:49am, Benjamin Tissoires wrote:
> On Nov 27 2017 or thereabouts, Greg KH wrote:
> > On Mon, Nov 27, 2017 at 09:16:31AM +0100, Benjamin Tissoires wrote:
> > > On Nov 25 2017 or thereabouts, Dave Young wrote:
> > > > This mouse keep disconnecting in runleve 3 like below, add it needs the
> > > > quirk to mute the anoying messages.
> > > > 
> > > > [  111.230555] usb 2-2: USB disconnect, device number 6
> > > > [  112.718156] usb 2-2: new low-speed USB device number 7 using xhci_hcd
> > > > [  112.941594] usb 2-2: New USB device found, idVendor=03f0, idProduct=094a
> > > > [  112.984866] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> > > > [  113.027731] usb 2-2: Product: HP USB Optical Mouse
> > > > [  113.069977] usb 2-2: Manufacturer: PixArt
> > > > [  113.113500] input: PixArt HP USB Optical Mouse as /devices/pci0000:00/0000:00:14.0/usb2/2-2/2-2:1.0/0003:03F0:094A.0002/input/input14
> > > > [  113.156787] hid-generic 0003:03F0:094A.0002: input: USB HID v1.11 Mouse [PixArt HP USB Optical Mouse] on usb-0000:00:14.0-2/input0
> > > > [  173.262642] usb 2-2: USB disconnect, device number 7
> > > > [  174.750244] usb 2-2: new low-speed USB device number 8 using xhci_hcd
> > > > [  174.935740] usb 2-2: New USB device found, idVendor=03f0, idProduct=094a
> > > > [  174.990435] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> > > > [  175.014984] usb 2-2: Product: HP USB Optical Mouse
> > > > [  175.037886] usb 2-2: Manufacturer: PixArt
> > > > [  175.061794] input: PixArt HP USB Optical Mouse as /devices/pci0000:00/0000:00:14.0/usb2/2-2/2-2:1.0/0003:03F0:094A.0003/input/input15
> > > > [  175.084946] hid-generic 0003:03F0:094A.0003: input: USB HID v1.11 Mouse [PixArt HP USB Optical Mouse] on usb-0000:00:14.0-2/input0
> > > > 
> > > > Signed-off-by: Dave Young <dyoung@redhat.com>
> > > > ---
> > > >  drivers/hid/hid-ids.h           |    1 +
> > > >  drivers/hid/usbhid/hid-quirks.c |    1 +
> > > 
> > > Patch looks good and should be good for stable too, but in the file
> > > hid-quirks.c file has been moved one folder up. Please rebase the patch
> > > on top of https://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git/log/?h=for-4.16/hid-quirks-cleanup/_base
> > > It should be merged in linux-next in the next few days normally.
> > > 
> > > Jiri, how can we deal with such stable-ish patches?
> > 
> > I can almost always handle things as simple as file movements, don't
> > worry about that.  If there's a problem, I'll be sure to let people know
> > :)
> > 
> 
> OK, thanks Greg.
> 
> Dave, please rebase on top of the branch I mentioned before, and add
> also the stable@ tag.

Benjamin, will do.

I posted this when I was in my daughter's class last weekend, maybe I
can retest and repost it next Saturday at Dec 4th or earlier if
I can find free time before that :)

> 
> Cheers,
> Benjamin

Thanks
Dave
