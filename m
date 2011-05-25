From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: Losing events from USB barcode reader
Date: Wed, 25 May 2011 17:38:32 +0200
Message-ID: <20110525173832.237e7ac7@surf>
References: <20110523210228.7738801f@surf>
	<20110524095556.GA6805@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:44745 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119Ab1EYPin convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 May 2011 11:38:43 -0400
In-Reply-To: <20110524095556.GA6805@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org

Hello Henrik,

Thanks for your feedback.

On Tue, 24 May 2011 11:55:56 +0200
"Henrik Rydberg" <rydberg@euromail.se> wrote:

> With 2.6.39, it is possible to tell if events are dropped by looking
> for the (EV_SYN, SYN_DROPPED) event in the stream, for instance using
> evtest.

Yes, I've seen that. Unfortunately, I can hardly recover even if I'm
notified of lost events: a barcode is scanned as a series of
characters, which ends by a newline. If some are lost in the middle,
there's no way to detect them, so I'd prefer not to loose events.

However, I'll upgrade my kernel to 2.6.39 and use the new SYN_DROPPED
feature at least to be able to log the fact that events were lost.

> The buffer size can be set by the driver in question, which may
> utilize information about the device. Is your device exactly a
> keyboard, except it has a higher event rate, or are there perhaps
> other ques?

My device acts just like a keyboard, and appears to be recognized as
such (see logs below).

> > There are even worse cases: I have an USB barcode reader which is
> > connected by Bluetooth with the barcode reader itself. When the
> > barcode reader is far away from the base station, it just buffers
> > the scanned barcodes, and when the barcode reader is again within
> > the Bluetooth range from the base station, it sends all the
> > buffered scanned barcode in a row. Potentially hundreds and
> > hundreds of Linux input events coming in.
>=20
> Assuming we talk about a hid device, knowing the specification would
> help.

What kind of specification are you interested in ?

Here is what I have in dmesg when the device is plugged in:

[31786.703736] usb 2-1.4: new full speed USB device using ehci_hcd and =
address 13
[31786.804559] input: Symbol Technologies, Inc, 2002 Symbol Bar Code Sc=
anner as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.4/2-1.4:1.0/inpu=
t/input19
[31786.804699] generic-usb 0003:05E0:1200.000B: input,hidraw2: USB HID =
v1.10 Keyboard [Symbol Technologies, Inc, 2002 Symbol Bar Code Scanner]=
 on usb-0000:00:1d.0-1.4/input0

Here is what I have in sysfs :

thomas@surf:/sys/class/input/input19$ ls
capabilities  device  event13  id  modalias  name  phys  power  subsyst=
em  uevent  uniq
thomas@surf:/sys/class/input/input19$ cat phys=20
usb-0000:00:1d.0-1.4/input0
thomas@surf:/sys/class/input/input19$ cat name=20
=EF=BE=A9Symbol Technologies, Inc, 2002 Symbol Bar Code Scanner
thomas@surf:/sys/class/input/input19$ cat uniq=20
S/N:A1B8593E4C748F4C8BD5052D9E29AE11 Rev:NBRMSAAEDM:12JAN113
thomas@surf:/sys/class/input/input19$ cat capabilities/
abs  ev   ff   key  led  msc  rel  snd  sw  =20
thomas@surf:/sys/class/input/input19$ cat capabilities/abs=20
0
thomas@surf:/sys/class/input/input19$ cat capabilities/ev=20
120013
thomas@surf:/sys/class/input/input19$ cat capabilities/ff=20
0
thomas@surf:/sys/class/input/input19$ cat capabilities/key=20
10000 7 ff9f207a c14057ff febeffdf ffefffff ffffffff fffffffe
thomas@surf:/sys/class/input/input19$ cat capabilities/led=20
1f
thomas@surf:/sys/class/input/input19$ cat capabilities/msc=20
10
thomas@surf:/sys/class/input/input19$ cat capabilities/rel=20
0
thomas@surf:/sys/class/input/input19$ cat capabilities/snd=20
0
thomas@surf:/sys/class/input/input19$ cat capabilities/sw=20
0

What other informations would be needed to better understand what the
device is ?

> > As far as I could see, it doesn't seem to be possible to adjust the
> > size of the in-kernel buffer from userspace (through some ioctl()
> > call, for example). Did I miss something ?
>=20
> Adjusting internal kernel buffers from userspace seems like the wrong
> level of interaction. The kernel should be able to resolve this
> internally, either dynamically or using information such as productio=
n
> rate and consumption rate.

Agreed. However, I don't know on which criteria should the kernel
decide what the size of the internal buffer should be, in this
particular case.

Regards,

Thomas
--=20
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
