From: Hugo Osvaldo Barrera <hugo@osvaldobarrera.com.ar>
Subject: Re: [bug?] [powerpc] hid_logitech_dj: Wireless mouse does not work
 in xorg or gpm
Date: Fri, 11 May 2012 02:06:40 -0300
Message-ID: <20120511050639.GA13777@hugoo.com.ar>
References: <20120503052000.GC15205@burratino>
 <20120503052420.GD15205@burratino>
 <4FA217B7.7070908@osvaldobarrera.com.ar>
 <20120503055051.GA15960@burratino>
 <CAE7qMrqtmu+bYYYp43s7Ek=UxfUG8HzwQSQBsdCGcVCBzCMQQw@mail.gmail.com>
 <20120506031428.GA20044@hugoo.com.ar>
 <20120506055508.GA21209@burratino>
 <4FA6162F.1020408@osvaldobarrera.com.ar>
 <20120506062309.GB26002@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from customer-static-210-108-249.iplannetworks.net ([190.210.108.249]:34411
	"EHLO hyperion.ubertech.com.ar" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752079Ab2EKFGT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 May 2012 01:06:19 -0400
Content-Disposition: inline
In-Reply-To: <20120506062309.GB26002@burratino>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@enac.fr>, 671292@bugs.debian.org

On 2012.05.06 01:23, Jonathan Nieder wrote:
> Hugo Osvaldo Barrera wrote:
> > On 2012-05-06 02:55, Jonathan Nieder wrote:
> 
> >> The pairing (...add_djhid_device) happens during initialization,
> >> before the mouse is turned on...
> >
> > I don't think I quite follow there.  By "pairing" I though you meant
> > when the receiver connects to the mouse.  How can the pairing be done
> > while the device is off?  Or what am I missing here?
> 
> I'm guessing the actual pairing happens without Linux being involved.
> Then the driver sends a "get paired devices" request during
> initialization and the device sends the "device paired" notifications
> I'm interested in in response.
> 
> > Do I need to apply only this patch, or both the previous one and this one?
> 
> Only this patch.
> 
> Cheers,
> Jonathan

Hi!
I apologize for the really (really) long delay in replying.  I've had a
really busy week. I rebuilt the kernel with the patch (rebuilding the
module did't work because I'd updated the kernel tree, and the re-built
module wasn't recognized):

# uname -a
Linux athena 3.4.0-rc5+ #1 Fri May 4 19:14:24 ART 2012 ppc GNU/Linux

And I captured the dmesg from before plugging in the mouse (after a
clean reboot).
The good news is there's a "41" event this time! :)

/sys/kernel/debug/hid/ is empty at this point, so I can't cat /sys/... .../events



[  365.757237] usbcore: registered new interface driver usbhid
[  365.757448] usbhid: USB HID core driver
[  365.761458] drivers/hid/hid-logitech-dj.c: Logitech-DJ:logi_dj_init
[  528.822188] usb 4-1: new full-speed USB device number 2 using ohci_hcd
[  529.044194] usb 4-1: New USB device found, idVendor=046d, idProduct=c52b
[  529.044417] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[  529.044646] usb 4-1: Product: USB Receiver
[  529.044783] usb 4-1: Manufacturer: Logitech
[  529.054294] drivers/hid/usbhid/hid-core.c: HID probe called for ifnum 0
[  529.054436] drivers/hid/hid-logitech-dj.c: logi_dj_probe called for ifnum 0
[  529.054442] drivers/hid/hid-logitech-dj.c: logi_dj_probe: ignoring ifnum 0
[  529.054561] drivers/hid/usbhid/hid-core.c: HID probe called for ifnum 1
[  529.054658] drivers/hid/hid-logitech-dj.c: logi_dj_probe called for ifnum 1
[  529.054664] drivers/hid/hid-logitech-dj.c: logi_dj_probe: ignoring ifnum 1
[  529.054754] drivers/hid/usbhid/hid-core.c: HID probe called for ifnum 2
[  529.054852] drivers/hid/hid-logitech-dj.c: logi_dj_probe called for ifnum 2
[  529.061218] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=0x1001 wIndex=0x0200 wLength=1792
[  529.063218] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=0x1101 wIndex=0x0200 wLength=5120
[  529.064204] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=0x2001 wIndex=0x0200 wLength=3840
[  529.065199] drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=0x2101 wIndex=0x0200 wLength=8192
[  529.066942] logitech-djreceiver 0003:046D:C52B.0003: hiddev0,hidraw0: USB HID v1.11 Device [Logitech USB Receiver] on usb-0001:10:1b.1-1/input2
[  529.073214] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:15
[  529.073230] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event: report =  20 01 41 01 1a 10 04 00 00 00 00 00 00 00 00
[  529.073277] drivers/hid/hid-logitech-dj.c: delayedwork_callback
[  529.073447] drivers/hid/hid-logitech-dj.c: logi_dj_ll_parse
[  529.073453] drivers/hid/hid-logitech-dj.c: logi_dj_ll_parse: sending a mouse descriptor, reports_supported: 4
[  529.074068] drivers/hid/hid-logitech-dj.c: logi_dj_ll_start
[  529.074276] input: Logitech Unifying Device. Wireless PID:101a as /devices/pci0001:10/0001:10:1b.1/usb4/4-1/4-1:1.2/0003:046D:C52B.0003/input/input5
[  529.075216] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:15
[  529.075229] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event: report =  20 00 41 02 00 00 00 00 00 00 00 00 00 00 00
[  529.075854] drivers/hid/hid-logitech-dj.c: logi_dj_ll_open:usb-0001:10:1b.1-1:1
[  529.075887] drivers/hid/hid-logitech-dj.c: logi_dj_ll_close:usb-0001:10:1b.1-1:1
[  529.075929] drivers/hid/hid-logitech-dj.c: logi_dj_ll_open:usb-0001:10:1b.1-1:1
[  529.075966] drivers/hid/hid-logitech-dj.c: logi_dj_ll_close:usb-0001:10:1b.1-1:1
[  529.076072] logitech-djdevice 0003:046D:C52B.0004: input,hidraw1: USB HID v1.11 Mouse [Logitech Unifying Device. Wireless PID:101a] on usb-0001:10:1b.1-1:1
[  529.076547] drivers/hid/hid-logitech-dj.c: delayedwork_callback
[  529.076554] drivers/hid/hid-logitech-dj.c: logi_dj_recv_add_djhid_device: device list is empty

<receiver plugged in>

[  593.872745] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:15
[  593.872760] drivers/hid/hid-logitech-dj.c: logi_dj_raw_event: report =  20 01 42 00 00 00 00 00 00 00 00 00 00 00 00
<mouse turned on>


Since /sys/kernel/debug/hid/ is empty until I plug in the receiver, I
can't cat the events until then. The output of the events is the same 
as before when I turned on the mouse (I'm thinking you won't need this,
but I'd rather be sure).

# cat /sys/kernel/debug/hid/0003\:046D\:C52B.0003/events 
report (size 15) (numbered) =  20 01 42 00 00 00 00 00 00 00 00 00 00 00 00

-----

JUST as I was about to send this e-mail, I was reading the output of
that dmesg and noticed that a few more /inputX devices were mentioned,
so I decided to actually try the mouse, something that I'd neglected
to do this last round (I though this patch only added debuging output).

The mouse actually works now on Xorg just fine. :)

A big thanks (truly) for all your effort on this.  I'm still including
the above info because I'm not sure if it's of use to you or not.

Cheers,

Hugo
