From: simon@mungewell.org
Subject: Re: fftest: Force feedback doesn't work in native mode
Date: Thu, 19 Jan 2012 02:29:23 -0500
Message-ID: <07591daed833aaf50ea155c918cd04e0.squirrel@mungewell.org>
References: <CAM1yFZ8_VEhsY9qe6Rt_8Ojb89CUUMskQdGDv5GomEVGNBDvxQ@mail.gmail.com>
    <2a8f304621a47c9b8468f5aa0ae7f4c5.squirrel@mungewell.org>
    <CAM1yFZ82ZqJ+DAh2fU+Lqijcm=r6DE_EmCR8OX7M7ubNRMxyyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:55069 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535Ab2ASH3Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Jan 2012 02:29:25 -0500
In-Reply-To: <CAM1yFZ82ZqJ+DAh2fU+Lqijcm=r6DE_EmCR8OX7M7ubNRMxyyg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anisha Kaul <born.rebel.83@gmail.com>
Cc: linux-input@vger.kernel.org


> Sorry, I don't know how to use that git link which you gave. I'll try
> to figure that out.

It was just a web link to a gitweb page, which will give you some
information on how the file has changed over time.


Regarding SuSE's kernel, I'm not sure which version Michal changes got
into the mainline. It could be that you're looking at the early version of
'hid-lg4ff' which only supported the Logitech Wii Speedforce Wireless.

There are some 'bleeding edge' kernels packages here:
http://kernel.opensuse.org/packages
http://download.opensuse.org/repositories/Kernel:/HEAD/standard/i586/


Anyhow you caught me sitting next to my wheel.... the device will be
recognised when plug it in.
--
simon@drifter:~$ tail -f /var/log/syslog
Jan 19 00:09:27 drifter kernel: [ 9540.968028] usb 5-1: new low speed USB
device number 7 using uhci_hcd
Jan 19 00:09:27 drifter kernel: [ 9541.178081] logitech
0003:046D:C298.0006: fixing up Logitech Driving Force Pro report
descriptor
Jan 19 00:09:27 drifter kernel: [ 9541.179191] input: Logitech Logitech
Driving Force Pro as
/devices/pci0000:00/0000:00:1d.3/usb5/5-1/5-1:1.0/input/input9
Jan 19 00:09:27 drifter kernel: [ 9541.179530] logitech
0003:046D:C298.0006: input,hidraw0: USB HID v1.00 Joystick [Logitech
Logitech Driving Force Pro] on usb-0000:00:1d.3-1/input0
Jan 19 00:09:27 drifter kernel: [ 9541.179557] logitech
0003:046D:C298.0006: Force feedback for Logitech Speed Force Wireless by
Simon Wood <simon@mungewell.org>
--

And does it's turn to left/turn to right dance. Both LEDs will be lit and
it will have 900' rotation.

You can also affect the rotation range with (change ID for your USB device)
--
simon@drifter:~$ echo '450' >
/sys/bus/hid/devices/0003\:046D\:C298.0006/range
--

--
simon@drifter:~$ ffcfstress -d /dev/input/event4

        position                   center                     force
<----------*|-----------> <-----------|******----->
<-----------|******+---->^C
--

Simon.

