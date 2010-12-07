From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC][PATCH] input: Introduce device information ioctl
Date: Tue, 7 Dec 2010 11:35:14 -0800
Message-ID: <20101207193513.GA31411@core.coreip.homeip.net>
References: <1291706726-8835-1-git-send-email-rydberg@euromail.se>
 <AANLkTi=dhFSrAnRHDB4Vcsxh8xqvztpg4Fxyorzu9q7u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f172.google.com ([209.85.214.172]:57248 "EHLO
	mail-iw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136Ab0LGTlO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Dec 2010 14:41:14 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=dhFSrAnRHDB4Vcsxh8xqvztpg4Fxyorzu9q7u@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ping Cheng <pingc@wacom.com>, Chris Bagwell <chris@cnpbagwell.com>

On Tue, Dec 07, 2010 at 10:48:04AM -0800, Ping Cheng wrote:
> On Mon, Dec 6, 2010 at 11:25 PM, Henrik Rydberg <rydberg@euromail.se>=
 wrote:
> > Today, userspace sets up an input device based on the data it emits=
=2E
> > This is not always enough; a tablet and a touchscreen may emit exac=
tly
> > the same data, for instance, but the former should be set up with a
> > pointer whereas the latter does not need to. Recently, a new type o=
f
> > touchpad has emerged where the buttons are under the pad, which cha=
nges
> > handling logic without changing the emitted data. This patch introd=
uces
> > a new ioctl, EVIOCGDEVINFO, which allows userspace to extract infor=
mation
> > about the device resulting in proper setup.
> >
> > Suggested-by: Dmitry Torokhov <dtor@mail.ru>
> > Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> > Cc: Ping Cheng <pingc@wacom.com>
> > Cc: Chris Bagwell <chris@cnpbagwell.com>
> > ---
> > Hi all,
> >
> > Here is a patch attempting to formulate Dmitry's device type idea. =
It
> > compiles, but further testing awaits a general consesus on the devi=
ce
> > types and capabilities to start out with. Are the ones listed here =
apt
> > for the job?
> >
> > Cheers,
> > Henrik
> >
> > =A0drivers/input/evdev.c | =A0 =A06 ++++++
> > =A0include/linux/input.h | =A0 34 +++++++++++++++++++++++++++++++++=
+
> > =A02 files changed, 40 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> > index e3f7fc6..db78592 100644
> > --- a/drivers/input/evdev.c
> > +++ b/drivers/input/evdev.c
> > @@ -632,6 +632,12 @@ static long evdev_do_ioctl(struct file *file, =
unsigned int cmd,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EFAULT;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> >
> > + =A0 =A0 =A0 case EVIOCGDEVINFO:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (copy_to_user(p, &dev->devinfo,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0si=
zeof(struct input_devinfo)))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> > +
> > =A0 =A0 =A0 =A0case EVIOCGREP:
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!test_bit(EV_REP, dev->evbit))
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOSYS;
> > diff --git a/include/linux/input.h b/include/linux/input.h
> > index 6ef4446..8c58d2a 100644
> > --- a/include/linux/input.h
> > +++ b/include/linux/input.h
> > @@ -57,6 +57,21 @@ struct input_absinfo {
> > =A0};
> >
> > =A0/**
> > + * struct input_devinfo - device information via EVIOCGDEVINFO ioc=
tl
> > + * @types: bitmask of types (DEVTYPE_*) matching this device
> > + * @capabilities: bitmask of capabilities (DEVCAPS_*) of this devi=
ce
> > + *
> > + * This struct provides information about the device needed for
> > + * automatic setup in userspace, such as if the device is direct
> > + * (touchscreen) or indirect (touchpad), and if there are other
> > + * special considerations, such as the touchpad also being a butto=
n.
>=20
> I guess you are talking about the pad is also a button. What about th=
e
> pad has buttons? And there could be more than one button on it. Can w=
e
> pass the number of buttons on the pad as well?
>=20
> > + */
> > +struct input_devinfo {
> > + =A0 =A0 =A0 __u32 types;
> > + =A0 =A0 =A0 __u32 capabilities;
> > +};
> > +
> > +/**
> > =A0* struct input_keymap_entry - used by EVIOCGKEYCODE/EVIOCSKEYCOD=
E ioctls
> > =A0* @scancode: scancode represented in machine-endian form.
> > =A0* @len: length of the scancode that resides in @scancode buffer.
> > @@ -91,6 +106,7 @@ struct input_keymap_entry {
> > =A0#define EVIOCGNAME(len) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_IOC(_IOC=
_READ, 'E', 0x06, len) =A0 =A0 =A0 =A0 /* get device name */
> > =A0#define EVIOCGPHYS(len) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_IOC(_IOC=
_READ, 'E', 0x07, len) =A0 =A0 =A0 =A0 /* get physical location */
> > =A0#define EVIOCGUNIQ(len) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_IOC(_IOC=
_READ, 'E', 0x08, len) =A0 =A0 =A0 =A0 /* get unique identifier */
> > +#define EVIOCGDEVINFO =A0 =A0 =A0 =A0 =A0_IOR('E', 0x09, struct in=
put_devinfo) =A0 /* get device information */
> >
> > =A0#define EVIOCGKEY(len) =A0 =A0 =A0 =A0 _IOC(_IOC_READ, 'E', 0x18=
, len) =A0 =A0 =A0 =A0 /* get global key state */
> > =A0#define EVIOCGLED(len) =A0 =A0 =A0 =A0 _IOC(_IOC_READ, 'E', 0x19=
, len) =A0 =A0 =A0 =A0 /* get all LEDs */
> > @@ -108,6 +124,23 @@ struct input_keymap_entry {
> > =A0#define EVIOCGRAB =A0 =A0 =A0 =A0 =A0 =A0 =A0_IOW('E', 0x90, int=
) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Grab/Release device */
> >
> > =A0/*
> > + * Device types
> > + */
> > +
> > +#define DEVTYPE_KEYBOARD =A0 =A0 =A0 0
> > +#define DEVTYPE_MOUSE =A0 =A0 =A0 =A0 =A01
> > +#define DEVTYPE_JOYSTICK =A0 =A0 =A0 2
> > +#define DEVTYPE_TOUCHPAD =A0 =A0 =A0 3
> > +#define DEVTYPE_TABLET =A0 =A0 =A0 =A0 4
> > +#define DEVTYPE_TOUCHSCREEN =A0 =A05
>=20
> TOUCHSCREEN can be finger touch screen and pen touch screen. They are
> different types for clients. Should we add one for pen touch screen,
> something like DEVTYPE_TABLETPC?

No, they are exactly the same as far as this classification is
concerned. No matter what you are touching the working surface with the
expected behavior is that, unlike tablet (which can also be handle
fingers and/or pen) you do not need to have on-screen pointer tracking
your movements.

>=20
> > +
> > +/*
> > + * Device capabilities
> > + */
> > +
> > +#define DEVCAPS_PAD_IS_BUTTON =A01
>=20
> Do we need the following:
>=20
> +#define DEVCAPS_PAD_HAS_BUTTONS           2
> +#define DEVCAPS_PAD_HAS_RINGS                  3
> +#define DEVCAPS_PAD_HAS_REL_WHEELS    4
> +#define DEVCAPS_PAD_HAS_ABS_WHEELS    5
> +#define DEVCAPS_PAD_HAS_STRIPS                6

No, you can get all this data from the XXXbits in the device (well, san=
s
rings/strips as we do not have such events yet). The
DEVCAPS_PAD_IS_BUTTON is to tell userspace that pad itself serves as a
button. The device still emits BTN_LEFT (primary button event) for such
devices but userspace needs to handle it a bit differently.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
