From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [BUG] capslock works across all keyboards but LED does not
Date: Wed, 24 Oct 2012 08:39:51 +0800
Message-ID: <CACVXFVNpYrET-2GoLsKEmds2Ua0QnCNwN-q+31hewNDnmdpN9w@mail.gmail.com>
References: <CACVXFVM8soazSixttzDBq-zLAxCpVNBDsDoz4Hc9gdsU8WQniA@mail.gmail.com>
	<21783709.sVZtM4k8zF@dtor-d630.eng.vmware.com>
	<CACVXFVN8s52UiSF0Q98sXNZzR9srnZ9aUjNYcZU6hDPfNzRGgA@mail.gmail.com>
	<20121022155446.GB13791@core.coreip.homeip.net>
	<CACVXFVMbc3eBMj4gcAVDZjB4SJYwbLeVzUi13C62FMVYymgFug@mail.gmail.com>
	<20121023174834.GB649@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:49608 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933700Ab2JXAjx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Oct 2012 20:39:53 -0400
Received: from mail-ea0-f174.google.com ([209.85.215.174])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1TQp0h-0001am-WF
	for linux-input@vger.kernel.org; Wed, 24 Oct 2012 00:39:52 +0000
Received: by mail-ea0-f174.google.com with SMTP id c13so1343617eaa.19
        for <linux-input@vger.kernel.org>; Tue, 23 Oct 2012 17:39:51 -0700 (PDT)
In-Reply-To: <20121023174834.GB649@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, Oct 24, 2012 at 1:48 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hmm, this looks correct. Do you have similar issues on any other boxes
> or only your laptop? Does the LED state propagate between 2 USB

I only have one laptop at hand, :-(

> keyboards if you plug in both of them? What does /proc/bus/input/devices

I only have one usb keyboard too, :-(

The LED state becomes off once I switched to console via pressing 'ctrl+alt+F1',
and it will keep off even though CAPSLOCK is pressed on either usb keyboard
or ps/2 keyboard.

The above can be observed on 3.6 kernel and several precious kernel.
(distribution is Ubuntu 12.04)

> show?

[tom@linux-2.6-omap]$cat /proc/bus/input/devices
I: Bus=0019 Vendor=0000 Product=0005 Version=0000
N: Name="Lid Switch"
P: Phys=PNP0C0D/button/input0
S: Sysfs=/devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input0
U: Uniq=
H: Handlers=event0
B: PROP=0
B: EV=21
B: SW=1

I: Bus=0019 Vendor=0000 Product=0003 Version=0000
N: Name="Sleep Button"
P: Phys=PNP0C0E/button/input0
S: Sysfs=/devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input1
U: Uniq=
H: Handlers=kbd event1
B: PROP=0
B: EV=3
B: KEY=4000 0 0

I: Bus=0019 Vendor=0000 Product=0001 Version=0000
N: Name="Power Button"
P: Phys=LNXPWRBN/button/input0
S: Sysfs=/devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
U: Uniq=
H: Handlers=kbd event2
B: PROP=0
B: EV=3
B: KEY=10000000000000 0

I: Bus=0011 Vendor=0001 Product=0001 Version=ab54
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
S: Sysfs=/devices/platform/i8042/serio0/input/input3
U: Uniq=
H: Handlers=sysrq kbd event3
B: PROP=0
B: EV=120013
B: KEY=402000000 3803078f800d001 feffffdfffefffff fffffffffffffffe
B: MSC=10
B: LED=7

I: Bus=0003 Vendor=046d Product=c045 Version=0110
N: Name="Logitech USB-PS/2 Optical Mouse"
P: Phys=usb-0000:00:1a.0-1.1/input0
S: Sysfs=/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.0/input/input4
U: Uniq=
H: Handlers=mouse0 event4
B: PROP=0
B: EV=17
B: KEY=ff0000 0 0 0 0
B: REL=143
B: MSC=10

I: Bus=0019 Vendor=0000 Product=0006 Version=0000
N: Name="Video Bus"
P: Phys=LNXVIDEO/video/input0
S: Sysfs=/devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:00/input/input5
U: Uniq=
H: Handlers=kbd event5
B: PROP=0
B: EV=3
B: KEY=3e000b00000000 0 0 0

I: Bus=0019 Vendor=17aa Product=5054 Version=4101
N: Name="ThinkPad Extra Buttons"
P: Phys=thinkpad_acpi/input0
S: Sysfs=/devices/platform/thinkpad_acpi/input/input6
U: Uniq=
H: Handlers=rfkill kbd event6
B: PROP=0
B: EV=33
B: KEY=18040000 0 10000000000000 0 101501b00102004 8000000001104000
e000000000000 0
B: MSC=10
B: SW=8

I: Bus=0011 Vendor=0002 Product=0007 Version=01b1
N: Name="SynPS/2 Synaptics TouchPad"
P: Phys=isa0060/serio1/input0
S: Sysfs=/devices/platform/i8042/serio1/input/input7
U: Uniq=
H: Handlers=mouse1 event7
B: PROP=9
B: EV=b
B: KEY=6420 30000 0 0 0 0
B: ABS=260800011000003

I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name="HDA Intel HDMI/DP,pcm=3"
P: Phys=ALSA
S: Sysfs=/devices/pci0000:00/0000:00:1b.0/sound/card0/input8
U: Uniq=
H: Handlers=event8
B: PROP=0
B: EV=21
B: SW=140

I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name="HDA Intel Mic"
P: Phys=ALSA
S: Sysfs=/devices/pci0000:00/0000:00:1b.0/sound/card0/input9
U: Uniq=
H: Handlers=event9
B: PROP=0
B: EV=21
B: SW=10

I: Bus=0000 Vendor=0000 Product=0000 Version=0000
N: Name="HDA Intel Headphone"
P: Phys=ALSA
S: Sysfs=/devices/pci0000:00/0000:00:1b.0/sound/card0/input10
U: Uniq=
H: Handlers=event10
B: PROP=0
B: EV=21
B: SW=4

I: Bus=0003 Vendor=17ef Product=480f Version=2345
N: Name="Integrated Camera"
P: Phys=usb-0000:00:1a.0-1.6/button
S: Sysfs=/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.6/1-1.6:1.0/input/input11
U: Uniq=
H: Handlers=kbd event11
B: PROP=0
B: EV=3
B: KEY=100000 0 0 0

I: Bus=0011 Vendor=0002 Product=000a Version=0000
N: Name="TPPS/2 IBM TrackPoint"
P: Phys=synaptics-pt/serio0/input0
S: Sysfs=/devices/platform/i8042/serio1/serio2/input/input12
U: Uniq=
H: Handlers=mouse2 event12
B: PROP=0
B: EV=7
B: KEY=70000 0 0 0 0
B: REL=3


Thanks,
--
Ming Lei
