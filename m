From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [BUG] object: is not initialized, yet kobject_put() is being
 called
Date: Thu, 12 Aug 2010 14:07:21 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008121401580.2702@pobox.suse.cz>
References: <20100810210941.GA7938@fritha.org> <20100810223215.GA1609@arch.tripp.de> <alpine.LNX.2.00.1008121108540.2702@pobox.suse.cz> <20100812091659.GA1591@arch.tripp.de> <alpine.LNX.2.00.1008121148100.2702@pobox.suse.cz> <20100812113624.GB1591@arch.tripp.de>
 <20100812114513.GA1584@arch.tripp.de> <20100812115657.GA1611@arch.tripp.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100812115657.GA1611-joY5NpejW+Hx3b7vapvTcQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Markus Trippelsdorf <markus-xp2qqqlHh3xzoYq+O6RWwA@public.gmane.org>
Cc: Heinz Diehl <htd-iEI8Y0CNJBYdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, 12 Aug 2010, Markus Trippelsdorf wrote:

> > > > > > Guys, could you please send me your .config with which you are 
> > > > > > experiencing the problem, so that I can try to reproduce it with it?
> > > > > 
> > > > > Attached.
> > > > 
> > > > So I had to add support for HW of mine (SATA_VIA, PATA_VIA, disabled the 
> > > > radeon firmware stuff, and, most importantly, enabled UHCI, which is what 
> > > > is on machine I am using now for testing), and disconnect-connect cycle 
> > > > works nicely:
> > > > 
> > > > usb 3-2: USB disconnect, address 3
> > > > usb 3-2: new low speed USB device using uhci_hcd and address 4
> > > > input: mouse USB mouse with wheel as /devices/pci0000:00/0000:00:10.1/usb3/3-2/3-2:1.0/input/input6
> > > > generic-usb 0003:05B8:3091.0004: input,hidraw0: USB HID v1.10 Mouse [mouse USB mouse with wheel] on usb-0000:00:10.1-2/input0
> > > > input: mouse USB mouse with wheel as /devices/pci0000:00/0000:00:10.1/usb3/3-2/3-2:1.1/input/input7
> > > > generic-usb 0003:05B8:3091.0005: input,hidraw1: USB HID v1.10 Keyboard [mouse USB mouse with wheel] on usb-0000:00:10.1-2/input1
> > > > 
> > > > so still no BUG from kobject refcounting, and the hidraw numbers are the 
> > > > same. The major difference seems to be that I am using UHCI and you have 
> > > > your HID devices connected through OHCI, is that correct?
> > > 
> > > Correct. And I should add that it very easy to reproduce here; just
> > > disconnecting the usb receiver triggers the WARNING.
> > 
> > Disabling USB_HIDDEV in my .config solves the problem (there is no
> > WARNING anymore when disconnecting the receiver).
> 
> Reverting bd25f4dd6972755579d0ea50d1a5ace2e9b00d1a with USB_HIDDEV
> enabled also solves the problem. So there must be a bug in that patch:
> 
> commit bd25f4dd6972755579d0ea50d1a5ace2e9b00d1a
> Author: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> Date:   Sun Jul 11 15:34:05 2010 +0200
> 
>     HID: hiddev: use usb_find_interface, get rid of BKL
>     
>     This removes the private hiddev_table in the usbhid
>     driver and changes it to use usb_find_interface
>     instead.
>     
>     The advantage is that we can avoid the race between
>     usb_register_dev and usb_open and no longer need the
>     big kernel lock.
>     
>     This doesn't introduce race condition -- the intf pointer could be
>     invalidated only in hiddev_disconnect() through usb_deregister_dev(),
>     but that will block on minor_rwsem and not actually remove the device
>     until usb_open().
>     
>     Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
>     Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
>     Cc: "Greg Kroah-Hartman" <gregkh-l3A5Bk7waGM@public.gmane.org>
>     Signed-off-by: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>

Thanks, I had my suspicion about this commit (that's why I asked to you 
verify with CONFIG_USB_HIDDEV turned off as well).

Adding Arnd to CC and will look into it myself as well soon.

Arnd, the complete thread can be found at 
http://lkml.org/lkml/2010/8/10/280

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
