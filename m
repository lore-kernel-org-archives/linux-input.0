From: Matthew Helsley <matt.helsley@gmail.com>
Subject: Re: evdev and Trust TB-5300 tablet: wrong axis labels
Date: Sat, 12 Dec 2009 17:27:34 -0800
Message-ID: <6a12d2f30912121727w2fbc8d19k35b55da8fcb9ffe1@mail.gmail.com>
References: <200912130058.46220.dan@riga.lv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f192.google.com ([209.85.221.192]:51923 "HELO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933392AbZLMB1g (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Dec 2009 20:27:36 -0500
In-Reply-To: <200912130058.46220.dan@riga.lv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniil Kolpakov <dan@riga.lv>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, xorg@lists.freedesktop.org

2009/12/12 Daniil Kolpakov <dan@riga.lv>:
> (Sorry, the email was send from wrong address. Resending it.)
>
> Hi,
>
> I'm playing with Trust TB-5300 tablet, which gets identified as "UC-LOGIC
> Tablet WP5540U" by HAL and xorg loads evdev driver for it on plug.
>
> I'm getting the following list of axes with xinput list --long:
> Abs X, Abs Y, Abs Z, Abs Rotary X, Abs Pressure (5 axes). xinput test shows
> output like this:
>
> motion a[0]=0 a[1]=0 a[2]=32045 a[3]=16538 a[4]=55
> motion a[0]=0 a[1]=0 a[2]=32072 a[3]=16575 a[4]=54
> motion a[0]=0 a[1]=0 a[2]=32114 a[3]=16596 a[4]=49
>
> a[0] and a[1] is always 0, a[2] is X, a[3] is Y and a[4] is pressure.

What does /proc/bus/input/devices say about your tablet? I've got a
UC-LOGIC "Genius Pensketch 12x9" which had (and still has) some USB
quirks. The worst was it reported the X axis as the Z axis. It turned
out that the hid descriptor was bad and thus the kernel hid parser got
confused. Specifying the "MULTI" quirk seemed to fix the axis
labelling problem. You can test it and other quirks out by writing to
a sysfs file -- though I'm looking and can't seem to find it on my
2.6.31 distro kernel :(.

(Cc'ing linux-input and linux-usb in case they can offer help with any
potential kernel-level workarounds/fixes/etc)

The rest of this email is my own experience with a UC-LOGIC tablet and
may or may not be useful to you.

Cheers,
    -Matt Helsley

For example, here's my tablet's description in /proc/bus/input/devices
before (circa 2.6.24) and after applying the quirk (circa 2.6.31)
respectively:

BEFORE (1 entry):

I: Bus=0003 Vendor=5543 Product=0042 Version=0100
N: Name="    Tablet PF1209"
P: Phys=usb-0000:00:02.0-8/input0
S: Sysfs=/devices/pci0000:00/0000:00:02.0/usb1/1-8/1-8:1.0/input/input9
U: Uniq=
H: Handlers=mouse1 event1
B: EV=1f
B: KEY=c01 3f0001 0 0 0 0
B: REL=303
B: ABS=100000f
B: MSC=10


AFTER (3 entries):

I: Bus=0003 Vendor=5543 Product=0042 Version=0100
N: Name="    Tablet PF1209"
P: Phys=usb-0000:00:1d.1-2/input0
S: Sysfs=/devices/pci0000:00/0000:00:1d.1/usb6/6-2/6-2:1.0/input/input6
U: Uniq=
H: Handlers=mouse2 event6 evbug
B: EV=1b
B: KEY=c01 1 0 0 0 0
B: ABS=1000003
B: MSC=10

I: Bus=0003 Vendor=5543 Product=0042 Version=0100
N: Name="    Tablet PF1209"
P: Phys=usb-0000:00:1d.1-2/input0
S: Sysfs=/devices/pci0000:00/0000:00:1d.1/usb6/6-2/6-2:1.0/input/input7
U: Uniq=
H: Handlers=mouse3 event7 evbug
B: EV=17
B: KEY=70000 0 0 0 0
B: REL=303
B: MSC=10

I: Bus=0003 Vendor=5543 Product=0042 Version=0100
N: Name="    Tablet PF1209"
P: Phys=usb-0000:00:1d.1-2/input0
S: Sysfs=/devices/pci0000:00/0000:00:1d.1/usb6/6-2/6-2:1.0/input/input8
U: Uniq=
H: Handlers=mouse4 event8 evbug
B: EV=1b
B: KEY=400 70000 0 0 0 0
B: ABS=1000003
B: MSC=10


Note how REL and ABS reports don't appear in the same entry anymore.
In the original entry, if you decode the bits, you can see that it was
claiming to report both relative and absolute axis. Of course this is
not, strictly speaking, an indicator of a bug either. However the fact
is the "puck" reports relative events while the pen reports absolute
events. I could determine this by running a test program on the
/dev/input/eventX device mentioned and seeing what kinds of events
each triggered. Now with the "MULTI" quirk it produces 3 entries.

Some other fun quirks you may look forward too:

Unfortunately, only two of the event devices actually emit events. The
resolutions and ranges of the axii aren't properly reported on every
device. Also the device occaisionally enters a state where all but a
thin border of the active area is disabled. "Fixing" this requires
hooking the tablet up to a windows box with a usb switch and then
"switching" it to the Linux box without powering off. So it seems
there are some magic commands the windows driver knows about which I
couldn't see in the HID descriptor table (would they be there?) which
re-enable/specify the active area. Since getting into the state never
happens with the computer/tablet powered on I can't debug this
problem.
