From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC v2] Another approach to IR
Date: Wed, 2 Dec 2009 10:23:29 -0800
Message-ID: <20091202182329.GA20530@core.coreip.homeip.net>
References: <829197380912010909m59cb1078q5bd2e00af0368aaf@mail.gmail.com> <4B155288.1060509@redhat.com> <20091201175400.GA19259@core.coreip.homeip.net> <4B1567D8.7080007@redhat.com> <20091201201158.GA20335@core.coreip.homeip.net> <4B15852D.4050505@redhat.com> <20091202093803.GA8656@core.coreip.homeip.net> <4B16614A.3000208@redhat.com> <20091202171059.GC17839@core.coreip.homeip.net> <9e4733910912020930t3c9fe973k16fd353e916531a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9e4733910912020930t3c9fe973k16fd353e916531a4@mail.gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, Devin Heitmueller <dheitmueller@kernellabs.com>, Maxim Levitsky <maximlevitsky@gmail.com>, awalls@radix.net, j@jannau.net, jarod@redhat.com, jarod@wilsonet.com, khc@pm.waw.pl, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, lirc-list@lists.sourceforge.net, superm1@ubuntu.com, Christoph Bartelmus <lirc@bartelmus.de>
List-Id: linux-input@vger.kernel.org

On Wed, Dec 02, 2009 at 12:30:29PM -0500, Jon Smirl wrote:
> On Wed, Dec 2, 2009 at 12:10 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Wed, Dec 02, 2009 at 10:44:58AM -0200, Mauro Carvalho Chehab wro=
te:
> >> Dmitry Torokhov wrote:
> >> > On Tue, Dec 01, 2009 at 07:05:49PM -0200, Mauro Carvalho Chehab =
wrote:
> >> >> Dmitry Torokhov wrote:
> >> >>> On Tue, Dec 01, 2009 at 05:00:40PM -0200, Mauro Carvalho Cheha=
b wrote:
> >> >>>> Dmitry Torokhov wrote:
> >> >>>>> On Tue, Dec 01, 2009 at 03:29:44PM -0200, Mauro Carvalho Che=
hab wrote:
> >> >>>>>> For sure we need to add an EVIOSETPROTO ioctl to allow the =
driver
> >> >>>>>> to change the protocol in runtime.
> >> >>>>>>
> >> >>>>> Mauro,
> >> >>>>>
> >> >>>>> I think this kind of confuguration belongs to lirc device sp=
ace,
> >> >>>>> not input/evdev. This is the same as protocol selection for =
psmouse
> >> >>>>> module: while it is normally auto-detected we have sysfs att=
ribute to
> >> >>>>> force one or another and it is tied to serio device, not inp=
ut
> >> >>>>> device.
> >> >>>> Dmitry,
> >> >>>>
> >> >>>> This has nothing to do with the raw interface nor with lirc. =
This problem
> >> >>>> happens with the evdev interface and already affects the in-k=
ernel drivers.
> >> >>>>
> >> >>>> In this case, psmouse is not a good example. With a mouse, wh=
en a movement
> >> >>>> occurs, you'll receive some data from its port. So, a softwar=
e can autodetect
> >> >>>> the protocol. The same principle can be used also with a raw =
pulse/space
> >> >>>> interface, where software can autodetect the protocol.
> >> >>> Or, in certain cases, it can not.
> >> >>>
> >> >>> [... skipped rationale for adding a way to control protocol (w=
ith which
> >> >>> I agree) ...]
> >> >>>
> >> >>>> To solve this, we really need to extend evdev API to do 3 thi=
ngs: enumberate the
> >> >>>> supported protocols, get the current protocol(s), and select =
the protocol(s) that
> >> >>>> will be used by a newer table.
> >> >>>>
> >> >>> And here we start disagreeing. My preference would be for addi=
ng this
> >> >>> API on lirc device level (i.e. /syc/class/lirc/lircX/blah name=
space),
> >> >>> since it only applicable to IR, not to input devices in genera=
l.
> >> >>>
> >> >>> Once you selected proper protocol(s) and maybe instantiated se=
veral
> >> >>> input devices then udev (by examining input device capabilitie=
s and
> >> >>> optionally looking up at the parent device properties) would u=
se
> >> >>> input evdev API to load proper keymap. Because translation of
> >> >>> driver-specific codes into standard key definitions is in the =
input
> >> >>> realm. Reading these driver-specific codes from hardware is ou=
tside of
> >> >>> input layer domain.
> >> >>>
> >> >>> Just as psmouse ability to specify protocol is not shoved into=
 evdev;
> >> >>> just as atkbd quirks (force release key list and other driver-=
specific
> >> >>> options) are not in evdev either; we should not overload evdev=
 interface
> >> >>> with IR-specific items.
> >> >> I'm not against mapping those features as sysfs atributes, but =
they don't belong
> >> >> to lirc, as far as I understand. From all we've discussed, we'l=
l create a lirc
> >> >> interface to allow the direct usage of raw IO. However, IR prot=
ocol is a property
> >> >> that is not related to raw IO mode but, instead, to evdev mode.
> >> >>
> >> >
> >> > Why would protocol relate to evdev node? Evdev does not really c=
are what
> >> > how the fact that a certain button was pressed was communicated =
to it.
> >> > It may be deliveretd through PS/2 port, or maybe it was Bluetoot=
h HID,
> >> > or USB HID or USB boot protocol or some custom protocol, or RC-5=
, NEC or
> >> > some custom IR protocol. It makes no difference _whatsoever_ to =
evdev
> >> > nor any users of evdev care about protocol used by underlying ha=
rdware
> >> > device to transmit the data.
> >> >
> >> >> We might add a /sys/class/IR and add IR specific stuff there, b=
ut it seems
> >> >> overkill to me and will hide the fact that those parameters are=
 part of the evdev
> >> >> interface.
> >> >>
> >> >> So, I would just add the IR sysfs parameters at the /sys/class/=
input, if
> >> >> the device is an IR (or create it is /sys/class/input/IR).
> >> >>
> >> >> I agree that the code to implement the IR specific sysfs parame=
ter should be kept
> >> >> oustide input core, as they're specific to IR implementations.
> >> >>
> >> >> Would this work for you?
> >> >
> >> > I am seeing a little bit differently structured subsystem for IR=
 at the
> >> > moment. I think we should do something like this:
> >> >
> >> > - receivers create /sys/class/lirc devices. These devices provid=
e API
> >> > =A0 with a ring buffer (fifo) for the raw data stream coming fro=
m (and to)
> >> > =A0 them.
> >>
> >> The raw interface applies only to the devices that doesn't have a =
hardware decoder
> >> (something between 40%-60% of the currently supported devices).
> >
> > 50% is quite a number I think. But if driver does not allow access =
to
> > the raw stream - it will refuse binding to lirc_dev interface.
> >
> >>
> >> > - we allow registering several data interfaces/decoders that can=
 be bound
> >> > =A0 (manually or maybe automatically) to lirc devices. lirc devi=
ces may
> >> > =A0 provide hints as to which interface(s) better suited for han=
dling the
> >> > =A0 data coming form particular receiver. Several interfaces may=
 be bound
> >> > =A0 to one device at a time.
> >> > - one of the interfaces is interface implementing current lirc_d=
ev
> >> > - other interfaces may be in-kernel RC-5 decoder or other decode=
rs.
> >> > =A0 decoders will create instances of input devices
> >>
> >> I don't see why having more than one interface, especially for dev=
ices with
> >> hardware decoders.
> >>
> >> On IR remote receivers, internally, there's just one interface per=
 hardware.
> >>
> >> Considering the hardware decoding case, why to artificially create=
 other
> >> interfaces that can't be used simultaneously? No current hardware
> >> decoders can do that (or, at least, no current implementation allo=
ws).
> >> We're foreseen some cases where we'll have that (like Patrick's di=
b0700 driver),
> >> but for now, it is not possible to offer more than one interface t=
o userspace.
> >> Creating an arbitrary number of artificial interfaces just to pass=
 a parameter
> >> to the driver (the protocol), really seems overkill to me.
> >
> > We need to cater to the future cases as well. I don't want to redes=
ign
> > it in 2 years. But for devices that have only hardware decoders I
> > suppose we can short-curcuit "interfaces" and have a library-like m=
odule
> > creating input devices directly.
> >
> >>
> >> In the case of the cheap devices with just raw interfaces, running=
 in-kernel
> >> decoders, while it will work if you create one interface per proto=
col
> >> per IR receiver, this also seems overkill. Why to do that? It soun=
ds that it will
> >> just create additional complexity at the kernelspace and at the us=
erspace, since
> >> now userspace programs will need to open more than one device to r=
eceive the
> >> keycodes.
> >
> > _Yes_!!! You open as many event devices as there are devices you ar=
e
> > interested in receiving data from. Multiplexing devices are bad, ba=
d,
> > bad. Witness /dev/input/mouse and all the attempts at working aroun=
d the
> > fact that if you have a special driver for one of your devices you
> > receive events from the same device through 2 interfaces and all ki=
nd of
> > "grab", "super-grab", "smart-grab" schemes are born.
> >
> >>
> >> > (for each remote/substream that they can recognize).
> >>
> >> I'm assuming that, by remote, you're referring to a remote receive=
r (and not to
> >> the remote itself), right?
> >
> > If we could separate by remote transmitter that would be the best I
> > think, but I understand that it is rarely possible?
>=20
> The code I posted using configfs did that. Instead of making apps IR
> aware it mapped the vendor/device/command triplets into standard Linu=
x
> keycodes.  Each remote was its own evdev device.
>

That is what I liked about the patchset.
=20
> That scheme could be made to "just work" by building in a couple of
> mapping tables. The driver would pre-populate configfs entries for a
> some standard IR devices. Set the remote for Motorala DVR. Default
> Myth to look for the evdev device associated with Motorola DVR. The
> built-in mapping table would then map from pulse timing to Linux
> keycodes.
>=20
> If everyone hates configfs the same mapping can be done via the set
> keys IOCTL and making changes to the user space apps like loadkeys.
>=20

It is not the hate of configfs per se, but rather concern that configfs
takes too much resources and is not normally enabled.

--=20
Dmitry
