From: "Simon Wood" <simon@mungewell.org>
Subject: Re: [Patch-V2 1/6] INPUT: xpad: Add minimal support for Logitech
 G920 Wheel
Date: Wed, 6 Jan 2016 21:25:44 -0700
Message-ID: <9e5fd1510809a1b291e449e8e8070c8f.squirrel@mungewell.org>
References: <1447345535-2912-1-git-send-email-simon@mungewell.org>
    <1447345535-2912-2-git-send-email-simon@mungewell.org>
    <alpine.LNX.2.00.1511191449130.20111@pobox.suse.cz>
    <20151119183106.GC24773@dtor-ws>
    <CAKdAkRTaTA8KFQripYP0ZcFb+5G7OC_Ecnhrwum4L9hsQ-PVxg@mail.gmail.com>
    <CAKdAkRRBtVfTss9AV+DgTtCXf8PVks5pCB4VnR5sQvgW=S3HyA@mail.gmail.com>
    <20151210170853.GC16026@mail.corp.redhat.com>
    <CAKdAkRSBTBTW8ma79hh+0sr4izJ70SnvUb1gmPFy3MoVWYaUbA@mail.gmail.com>
    <20160104095524.GB20222@mail.corp.redhat.com>
    <alpine.LNX.2.00.1601061535440.3402@cbobk.fhfr.pm>
    <20160107014721.GA35823@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host18.canaca.com ([66.49.204.205]:43817 "EHLO
	host18.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbcAGEZo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Jan 2016 23:25:44 -0500
In-Reply-To: <20160107014721.GA35823@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Edwin <edwin@velds.nl>, =?iso-8859-1?Q?=22Michal_Mal=FD=22?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>

On Wed, January 6, 2016 6:47 pm, Dmitry Torokhov wrote:

> It is wrong. Aside form the fact that IMO xpad.c is the wrong place for
> this code to be in, why are we waiting for the input device to be opened by
> userspace before we do the switch instead of doing it immediately?

The 'send magic' might be better in a probe() call, but I don't believe
that it requires userspace interaction as it stands. The wheel will
disconnect almost immediately without me doing anything other than plug it
in.
--
Jan  6 21:18:50 speedster kernel: [  439.604037] usb 5-1: new full-speed
USB device number 2 using uhci_hcd
Jan  6 21:18:50 speedster kernel: [  439.791153] usb 5-1: New USB device
found, idVendor=046d, idProduct=c261
Jan  6 21:18:50 speedster kernel: [  439.791160] usb 5-1: New USB device
strings: Mfr=1, Product=2, SerialNumber=3
Jan  6 21:18:50 speedster kernel: [  439.791164] usb 5-1: Product: G920
Driving Force Racing Wheel for Xbox One
Jan  6 21:18:50 speedster kernel: [  439.791167] usb 5-1: Manufacturer:
Logitech
Jan  6 21:18:50 speedster kernel: [  439.791170] usb 5-1: SerialNumber:
00005d1d5129cebe
Jan  6 21:18:50 speedster mtp-probe: checking bus 5, device 2:
"/sys/devices/pci0000:00/0000:00:1d.3/usb5/5-1"
Jan  6 21:18:50 speedster mtp-probe: bus: 5, device: 2 was not an MTP device
Jan  6 21:18:51 speedster kernel: [  440.815191] input: Logitech G920
Driving Force Racing Wheel as
/devices/pci0000:00/0000:00:1d.3/usb5/5-1/5-1:1.0/input/input4
Jan  6 21:18:51 speedster kernel: [  440.815310] usbcore: registered new
interface driver xpad
Jan  6 21:18:52 speedster kernel: [  441.340093] usb 5-1: USB disconnect,
device number 2
Jan  6 21:18:52 speedster kernel: [  442.052037] usb 5-1: new full-speed
USB device number 3 using uhci_hcd
Jan  6 21:18:52 speedster kernel: [  442.239129] usb 5-1: New USB device
found, idVendor=046d, idProduct=c262
Jan  6 21:18:52 speedster kernel: [  442.239136] usb 5-1: New USB device
strings: Mfr=1, Product=2, SerialNumber=3
Jan  6 21:18:52 speedster kernel: [  442.239139] usb 5-1: Product: G920
Driving Force Racing Wheel for Xbox One
Jan  6 21:18:52 speedster kernel: [  442.239142] usb 5-1: Manufacturer:
Logitech
Jan  6 21:18:52 speedster kernel: [  442.239145] usb 5-1: SerialNumber:
00005d1d5129cebe
Jan  6 21:18:52 speedster mtp-probe: checking bus 5, device 3:
"/sys/devices/pci0000:00/0000:00:1d.3/usb5/5-1"
Jan  6 21:18:52 speedster mtp-probe: bus: 5, device: 3 was not an MTP device
Jan  6 21:18:52 speedster kernel: [  442.267248] input: Logitech G920
Driving Force Racing Wheel for Xbox One as
/devices/pci0000:00/0000:00:1d.3/usb5/5-1/5-1:1.0/0003:046D:C262.0002/input/input5
Jan  6 21:18:52 speedster kernel: [  442.267510] logitech-hidpp-device
0003:046D:C262.0002: input,hiddev0,hidraw1: USB HID v1.11 Joystick
[Logitech G920 Driving Force Racing Wheel for Xbox One] on
usb-0000:00:1d.3-1/input0
Jan  6 21:18:53 speedster kernel: [  442.322160] logitech-hidpp-device
0003:046D:C262.0002: HID++ 4.2 device connected.
--

I also did a quick check with the 'send magic' disabled. Xpad creates the
js0 and populates buttons, but pressing buttons/turning wheel does not
result in any change in js0.

I don't disagree to it being a seperate module, but don't have the time to
implement/test at the moment. If some else does that would be good, can we
make sure that the kconfig/makefile stuff uses same/sensible HID_CONFIGs?
Simon


