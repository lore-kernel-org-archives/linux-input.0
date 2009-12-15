From: Matthew Helsley <matt.helsley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: evdev and Trust TB-5300 tablet: wrong axis labels
Date: Mon, 14 Dec 2009 23:43:21 -0800
Message-ID: <6a12d2f30912142343j7d012bc0x91275c14630f83df@mail.gmail.com>
References: <200912130058.46220.dan@riga.lv> <200912131825.03872.dan@riga.lv>
	 <6a12d2f30912131835taa8086dic17562bb71543a68@mail.gmail.com>
	 <200912150106.07482.dan@riga.lv>
	 <20091214234652.GB23029@barra.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091214234652.GB23029-FGgOdbPLo1kAicBL8TP8PQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Hutterer <peter.hutterer-Pf4JEFdB4epeoWH0uzbU5w@public.gmane.org>
Cc: "Daniil V. Kolpakov" <dan-A/X3QuVk8WQ@public.gmane.org>, xorg-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, Dec 14, 2009 at 3:46 PM, Peter Hutterer
<peter.hutterer-Pf4JEFdB4epeoWH0uzbU5w@public.gmane.org> wrote:
> On Tue, Dec 15, 2009 at 01:06:07AM +0200, Daniil V. Kolpakov wrote:
>> =F7 =D3=CF=CF=C2=DD=C5=CE=C9=C9 =CF=D4 14 =C4=C5=CB=C1=C2=D2=D1 2009=
 Matthew Helsley =CE=C1=D0=C9=D3=C1=CC(a):
>> [...]
>> > Looks like they may have re-branded the "Genius MousePen 5x4 Table=
t"
>> > to your "Trust TB-5300".
>> [...]
>> > If you search for "Genius MousePen 5x4 Tablet" or something like i=
t
>> > then perhaps you'll find more ideas for fixing your tablet.
>>
>> Nothing interesting -- mostly I get howtos on installing some (propr=
ietary?)
>> driver called "wizardpen", and usually with xorg.conf instead of HAL=
 rules.
>>
>> I've tried enabling "MULTI_INPUT" quirk, as you've suggested:
>>
>> [root@shinestar:~]$ modprobe -r usbhid
>> [root@shinestar:~]$ modprobe usbhid "quirks=3D0x5543:0x0004:0x0040"
>>
>> It "splitted" the tablet to three devices, as in your case:
>>
>> I: Bus=3D0003 Vendor=3D5543 Product=3D0004 Version=3D0100
>> N: Name=3D"UC-LOGIC Tablet WP5540U"
>> P: Phys=3Dusb-0000:03:00.0-2/input0
>> S:
>> Sysfs=3D/devices/pci0000:00/0000:00:06.0/0000:03:00.0/usb1/1-2/1-2:1=
=2E0/input/input15
>> U: Uniq=3D
>> H: Handlers=3Dmouse2 event6
>> B: EV=3D1b
>> B: KEY=3Dc01 1 0 0 0 0
>> B: ABS=3D1000003
>> B: MSC=3D10
>>
>> I: Bus=3D0003 Vendor=3D5543 Product=3D0004 Version=3D0100
>> N: Name=3D"UC-LOGIC Tablet WP5540U"
>> P: Phys=3Dusb-0000:03:00.0-2/input0
>> S:
>> Sysfs=3D/devices/pci0000:00/0000:00:06.0/0000:03:00.0/usb1/1-2/1-2:1=
=2E0/input/input16
>> U: Uniq=3D
>> H: Handlers=3Dmouse3 event7
>> B: EV=3D17
>> B: KEY=3D70000 0 0 0 0
>> B: REL=3D303
>> B: MSC=3D10
>>
>> I: Bus=3D0003 Vendor=3D5543 Product=3D0004 Version=3D0100
>> N: Name=3D"UC-LOGIC Tablet WP5540U"
>> P: Phys=3Dusb-0000:03:00.0-2/input0
>> S:
>> Sysfs=3D/devices/pci0000:00/0000:00:06.0/0000:03:00.0/usb1/1-2/1-2:1=
=2E0/input/input17
>> U: Uniq=3D
>> H: Handlers=3Dmouse4 event8
>> B: EV=3D1b
>> B: KEY=3D400 70000 0 0 0 0
>> B: ABS=3D1000003
>> B: MSC=3D10
>>
>> But xinput only gets two of them. They don't send events (xinput tes=
t shows
>> this). But, looking at Xorg.0.log now, I see that the first device i=
s hooked
>> by synaptics driver which cannot init because hardware is unsupporte=
d. I know
>> why, I've seen overriding rules in hal config. I'll try to reconfigu=
re it to
>> use evdev driver.
>
> synaptics kicks in after the catchall evdev configuration and overwri=
tes it.
> the reason why it overrides for this device is that anything with abs=
olute
> x/y coordinates and buttons are labelled as touchpads by HAL and the =
default
> configurations then hook onto this label.
>
> easiest workaround is to drop in your custom configuration into
> /etc/hal/fdi/policies/ and (if you already have another one there) ma=
ke sure
> that it's loaded last.  HAL uses alphasort when reading the directori=
es.
>
> the match rule needed is something like this:
>
> <match key=3D"input.product" contains=3D"U-LOGIC">

Mine reports "UC-Logic Technology Corp." as the usb.vendor string. My
"input.product" for that device is exactly "    Tablet PF1209" (space
included). So the rule would have to check the usb.vendor_id of the
parent "node".

=46or my tablet I chose to be quite specific:

<match key=3D"info.capabilities" contains=3D"input.touchpad">
<match key=3D"info.product" contains=3D"Tablet PF1209">
<match key=3D"/org/freedesktop/Hal/devices/computer:system.kernel.name"
string=3D"Linux">

(I chose the last since evdev is a Linux driver and I didn't know
whether my changes to these .fdi files might eventually be useful on a
*BSD.)

>       <merge key=3D"input.x11_driver" type=3D"string">evdev</merge>
> </match>

Yes, I've hit this problem and I keep forgetting about it because it's
hidden in the .fdi files, waiting for whenever my distro "upgrades"
them. Sorry, Daniil, I completely forgot to mention this problem :(.

<tangent>
The .fdi file that assigns the synaptic driver to these devices based
solely on the "input.touchpad" capability seems quite wrong to me. My
guess is most tablets that rely on evdev will report absolute
coordinates. If anything, based on their comparably-small physical
size, I'd expect "touchpads" would report relative coordinates. Plus
synaptic can't be the only touchpad vendor/whatnot, can it? Why should
its driver try to claim them all?

Perhaps it should have it's own match key:

<match key=3D"info.product" contains=3D"Synaptics TouchPad">

(which works for my touchpad at least) rather than:

<match key=3D"info.capabilities" contains=3D"input.touchpad">

Sorry, I don't know: Who maintains the .fdi files -- the driver
developer, the distro, or HAL developers? In my distro they're in
/usr/share/hal/policy and the way its packaged suggests the driver
developers are responsible.

Peter am I way off here?
</tangent>

Cheers,
    -Matt Helsley
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
