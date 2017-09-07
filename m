From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: ALPS touchpad ot correctly recognized: GlidePoint vs DualPoint
Date: Thu, 7 Sep 2017 23:54:02 +0200
Message-ID: <201709072354.02681@pali>
References: <ada750eb-daeb-c9ae-2452-fcf027a4e704@posteo.net> <20170907213123.GA19320@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1955499.b9nGaIkBjr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:44880 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbdIGVyG (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 7 Sep 2017 17:54:06 -0400
Received: by mail-wm0-f44.google.com with SMTP id 137so1870482wmj.1
        for <linux-input@vger.kernel.org>; Thu, 07 Sep 2017 14:54:05 -0700 (PDT)
In-Reply-To: <20170907213123.GA19320@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Juanito <juam+kernel@posteo.net>, linux-input@vger.kernel.org, "masaki.ota@jp.alps.com" <masaki.ota@jp.alps.com>, Paul Donohue <linux-kernel@paulsd.com>

--nextPart1955499.b9nGaIkBjr
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 07 September 2017 23:31:23 Dmitry Torokhov wrote:
> Hi Juanito,
>=20
> On Thu, Sep 07, 2017 at 09:05:14AM +0200, Juanito wrote:
> > Dear Kernel Hackers,
> >=20
> > I hope this is the correct place to post this. If not, please
> > forgive me and feel free to forward it to someplace else. Thank
> > you very much!
>=20
> Let's add a few more people who's been looking after ALPS...
>=20
> > I have a ThinkPad with a touchpad that looks exactly like this:
> > https://www.camerongray.me/wp-content/uploads/2015/02/SCotlGg.jpg
>=20
> > The three pyhsical buttons on top do not work on my debian stretch
> > (4.9). I think it isn't being recognized correctly. I see a
> > "Rejected trackstick packet from non DualPoint device" in my
> > syslog whenever I click on one of them. On the other hand on a
> > Ubuntu 16.04 (4.4 - patched by Ubuntu y guess) the buttons *do*
> > work. Interestingly enough, it doesn't work on 17.04 (4.10).

ThinkPad with ALPS? Should not be it Synaptic? Maybe miss-detection?

Anyway, for ALPS devices, buttons below touchpad area are reported from=20
touchpad device and buttons above touchpad are reported from the=20
trackstick device.

ALPS DualPoint means device with touchpad + trackpoint

ALPS GlidePoint means device with only touchpad (without trackpoint)

So error message "Rejected trackstick packet from non DualPoint device"=20
which is generated at time when you click at buttons, would mean that=20
those buttons are reported via trackstick. And if kernel detected that=20
ALPS device as GlidePoint, then events from trackpoint (so also buttons)=20
are dropped.

> > I have noticed that the touchpad gets assigned different names on
> > both distros. On debian it is recognized as a GlidePoint and on
> > Ubuntu as a DualPoint. In an upstream kernel 4.13 which I just
> > built, it's also recognized as a GlidePoint. Unfortunately it
> > doesn't work either.

Name is assigned based on detection if trackstick is present. Different=20
kernel versions is probably reasons, maybe one version has wrong=20
detection.

Is trackstick movement working? This is probably important to know as it=20
looks like buttons are reported via trackstick, not via touchpad.

> > I am not sure if the device is actually a DualPoint or not (I don't
> > really understand the terminology here), but the thing is that the
> > buttons work when the kernel believes it to be one.
> >=20
> > This is the info I have managed to find about the device while
> > running on the non-working debian:
> >=20
> > dmesg:
> > [    2.914806] input: AlpsPS/2 ALPS GlidePoint as
> > /devices/platform/i8042/serio1/input/input2
> >=20
> > lsinput:
> > /dev/input/event11
> >=20
> >    bustype : BUS_I8042
> >    vendor  : 0x2
> >    product : 0x8
> >    version : 1792
> >    name    : "AlpsPS/2 ALPS GlidePoint"
> >    phys    : "isa0060/serio1/input0"
> >    bits ev : (null) (null) (null)
> >=20
> > I have played around with the drivers/input/mouse/alps.c file and
> > found out the following:
> >=20
> > e7 and ec are important (although I don't know what these are
> > exactly) and have the following values:
> >=20
> > e7: 73 03 0a
> > ec: 88 b0 13

Masaki should know exact type of device...

> > This combination is recognized as an ALPS touchpad, but isn't
> > assigned the ALPS_DUALPOINT flag. As far as I can see, it is
> > actually being *removed* at this point:
> >=20
> > if (alps_probe_trackstick_v3_v7(psmouse, ALPS_REG_BASE_V7) < 0)
> >=20
> >             priv->flags &=3D ~ALPS_DUALPOINT;
> >=20
> > The bit that says it has a trackpoint (I don't know what this is)
> > is apparently saying my device doesn't have one and is removing
> > the ALPS_DUALPOINT flag.

At least for V3 protocol that function tells touchpad to enable pass-
thru mode to trackstick and detect if trackstick is there present. After=20
that leave pass-thru mode.

> > This flag makes the buttons work. I am not sure if it breaks other
> > stuff.

Is that picture of your laptop, do you really have trackstick working?

My idea is that alps_probe_trackstick_v3_v7 does not check presence of=20
trackstick correct and return information that trackstick is not present=20
(which contains also those buttons)...

Masaki, can you confirm if there can be problem with that function?

> > I have written a pretty dummy patch which actually adds the flag
> > again making the buttons work. Again, I am not sure if it breaks
> > other stuff but my system isn't whining. Here is the patch:
> >=20
> > diff --git a/drivers/input/mouse/alps.c
> > b/drivers/input/mouse/alps.c index 850b00e3ad8e..17aba42e846f
> > 100644
> > --- a/drivers/input/mouse/alps.c
> > +++ b/drivers/input/mouse/alps.c
> > @@ -2804,6 +2804,9 @@ static int alps_set_protocol(struct psmouse
> > *psmouse,
> >=20
> >                 if (alps_probe_trackstick_v3_v7(psmouse,
> >=20
> > ALPS_REG_BASE_V7) < 0)
> >=20
> >                         priv->flags &=3D ~ALPS_DUALPOINT;
> >=20
> > +               if (priv->fw_ver[1] =3D=3D 0xb0)
> > +                       priv->flags |=3D ALPS_DUALPOINT;
> > +
> >=20
> >                 break;
> >        =20
> >         case ALPS_PROTO_V8:
> > After applying this patch dmesg and lsinput say this:
> >=20
> > [    8.226543] input: AlpsPS/2 ALPS DualPoint Stick as
> > /devices/platform/i8042/serio1/input/input13
> > [    8.247595] input: AlpsPS/2 ALPS DualPoint TouchPad as
> > /devices/platform/i8042/serio1/input/input2
> >=20
> > /dev/input/event11
> >=20
> >    bustype : BUS_I8042
> >    vendor  : 0x2
> >    product : 0x8
> >    version : 1792
> >    name    : "AlpsPS/2 ALPS DualPoint Stick"
> >    phys    : "isa0060/serio1/input1"
> >    bits ev : (null) (null) (null)
> >=20
> > /dev/input/event12
> >=20
> >    bustype : BUS_I8042
> >    vendor  : 0x2
> >    product : 0x8
> >    version : 1792
> >    name    : "AlpsPS/2 ALPS DualPoint TouchPad"
> >    phys    : "isa0060/serio1/input0"
> >    bits ev : (null) (null) (null)
> >=20
> > I am a total newbie to kernels and drivers so it would be great if
> > somebody who actually had some idea could take a look at this and
> > probably create a patch in a better place. I'll be glad to post
> > more info if necessary.
> >=20
> > Thank you very much!
> >=20
> > Cheers,
> > Juanito
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-input" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1955499.b9nGaIkBjr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlmxv/oACgkQi/DJPQPkQ1JRSACfY2GeohvZZkAjD0uIq2JjHaTQ
p7wAnRarxY4StuVTpLNOZ9V79+zOCLhV
=V+Lt
-----END PGP SIGNATURE-----

--nextPart1955499.b9nGaIkBjr--
