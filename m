From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3 3/3] devicetree: da9062: Add device tree bindings for
 DA9062 OnKey
Date: Tue, 28 Jul 2015 09:40:19 +0100
Message-ID: <20150728084019.GM14943@x1>
References: <cover.1437668261.git.stwiss.opensource@diasemi.com>
 <6bfae9b4f5475b59bddc4b71091121f1c0697a2d.1437668261.git.stwiss.opensource@diasemi.com>
 <20150727224300.GG3613@dtor-ws>
 <20150728054024.GA4558@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150728054024.GA4558@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, LINUXINPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUXKERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, RTCLINUX <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Dajun Chen <david.chen-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, 27 Jul 2015, Dmitry Torokhov wrote:

> On Mon, Jul 27, 2015 at 03:43:00PM -0700, Dmitry Torokhov wrote:
> > On Thu, Jul 23, 2015 at 05:17:41PM +0100, S Twiss wrote:
> > > From: S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
> > >=20
> > > Add device tree bindings for the DA9062 OnKey driver component
> > >=20
> > > Signed-off-by: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
> > >=20
> > > ---
> > > Changes in V3:
> > >  - Child driver specifics separated out into separate document
> > >    in this case ../input/da9062-onkey.txt
> > > Changes in V2:
> > >  - No change
> > >=20
> > > This patch applies against linux-next and next-20150708=20
> > >=20
> > >=20
> > >  .../devicetree/bindings/input/da9062-onkey.txt     | 36 ++++++++=
++++++++++++++
> > >  Documentation/devicetree/bindings/mfd/da9062.txt   |  3 ++
> >=20
> > I dropped bits for mfd/da9062.txt, changed to mention both 9062 and
> > 9063, folded into the onkey patch and applied.
>=20
> Argh, da9062 core is not in mainline yet... OK, below is the patch I
> had; if Lee does not pick it up I'll re-apply it when da9062 core hit=
s
> mainline.

Hmm... that's annoying.  You've put the patch below your signature
'--', so my mailer cuts it off.

[pasting]

> Input: add DA9062 OnKey capability to DA9063 OnKey driver
>=20
> From: S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
>=20
> Add DA9062 OnKey support into the existing DA9063 OnKey driver compon=
ent by
> using generic access tables for common register and bit mask definiti=
ons.
>=20
> The following change will add generic register and bit mask support t=
o the
> DA9063 OnKey.
>=20
> The following alterations have been made to the DA9063 OnKey:
>=20
> - Addition of a da906x_chip_config structure to hold all
>   generic registers and bitmasks for this type of OnKey component.
> - Addition of an struct of_device_id table for DA9063 and DA9062
>   defaults
> - Refactoring functions to use struct da9063_onkey accesses to generi=
c
>   registers/masks instead of using defines from registers.h
> - Re-work of da9063_onkey_probe() to use of_match_node() and
>   dev_get_regmap() to provide initialisation of generic registers and
>   masks and access to regmap
>=20
> Signed-off-by: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  .../devicetree/bindings/input/da9062-onkey.txt     |   32 +++++
>  drivers/input/misc/Kconfig                         |    8 +
>  drivers/input/misc/da9063_onkey.c                  |  129 ++++++++++=
++++++----
>  3 files changed, 140 insertions(+), 29 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/da9062-on=
key.txt
=20
I'm confused.  What's the dependency?

There shouldn't be any issue applying input patches, just because
there isn't an MFD counterpart.  In fact, I would take prior
acceptance of the child into consideration (would be like a +1 vote)
when reviewing the MFD part.

One suggestion however, I would ask for the DT binding and the driver
to be separated, as per [0].

[0] Documentation/devicetree/bindings/submitting-patches.txt

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
