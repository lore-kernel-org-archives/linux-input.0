From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC][PATCH] input: Introduce device information ioctl
Date: Tue, 7 Dec 2010 11:37:37 -0800
Message-ID: <20101207193736.GB31411@core.coreip.homeip.net>
References: <1291706726-8835-1-git-send-email-rydberg@euromail.se>
 <AANLkTi=JcekxsbUXXUmxkUug_+hwiYkDxbCEKEe-DWDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f172.google.com ([209.85.214.172]:54907 "EHLO
	mail-iw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518Ab0LGTpU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Dec 2010 14:45:20 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=JcekxsbUXXUmxkUug_+hwiYkDxbCEKEe-DWDg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Tue, Dec 07, 2010 at 01:18:41PM -0600, Chris Bagwell wrote:
> On Tue, Dec 7, 2010 at 1:25 AM, Henrik Rydberg <rydberg@euromail.se> =
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
> > + */
> > +struct input_devinfo {
> > + =A0 =A0 =A0 __u32 types;
> > + =A0 =A0 =A0 __u32 capabilities;
> > +};
> > +
>=20
> "types" sounds like it can support being more then one thing at a tim=
e
> but I don't think that is intent from below names.  Should rename to
> "type"?

I'd be wary of restricting device to be only one type. There are some
that are mutually exclusive (toucscreen/touchpad/tablet) but I'd leave
option of mixed-type devices open.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
