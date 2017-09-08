From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: ALPS touchpad ot correctly recognized: GlidePoint vs DualPoint
Date: Fri, 8 Sep 2017 08:48:53 +0200
Message-ID: <201709080848.53286@pali>
References: <ada750eb-daeb-c9ae-2452-fcf027a4e704@posteo.net> <201709072354.02681@pali> <30e888e8-39a8-6d74-7610-e467ed96815e@posteo.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1657095.ru6jMM074h";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:36186 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753804AbdIHGs5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 8 Sep 2017 02:48:57 -0400
Received: by mail-wr0-f177.google.com with SMTP id o42so2783900wrb.3
        for <linux-input@vger.kernel.org>; Thu, 07 Sep 2017 23:48:56 -0700 (PDT)
In-Reply-To: <30e888e8-39a8-6d74-7610-e467ed96815e@posteo.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Juanito <juanitobananas@posteo.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Juanito <juam+kernel@posteo.net>, linux-input@vger.kernel.org, "masaki.ota@jp.alps.com" <masaki.ota@jp.alps.com>, Paul Donohue <linux-kernel@paulsd.com>

--nextPart1657095.ru6jMM074h
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 08 September 2017 07:00:34 Juanito wrote:
> Hi,
>=20
> Thanks for that!
>=20
> > ThinkPad with ALPS? Should not be it Synaptic? Maybe
> > miss-detection?
>=20
> Sorry, I forgot to mention this. The ThinkPad came with a clickpad I
> **really** disliked, so I bought this on the Internet.

So, here is a problem. ThinkPads works with Synaptic touchpads, not with=20
ALPS.

> > Anyway, for ALPS devices, buttons below touchpad area are reported
> > from touchpad device and buttons above touchpad are reported from
> > the trackstick device.
> >=20
> > ALPS DualPoint means device with touchpad + trackpoint
> >=20
> > ALPS GlidePoint means device with only touchpad (without
> > trackpoint)
> >=20
> > So error message "Rejected trackstick packet from non DualPoint
> > device" which is generated at time when you click at buttons,
> > would mean that those buttons are reported via trackstick. And if
> > kernel detected that ALPS device as GlidePoint, then events from
> > trackpoint (so also buttons) are dropped.
>=20
> Is the trackpoint the red thingie between G, H and B?

Yes.

> >>> I have noticed that the touchpad gets assigned different names on
> >>> both distros. On debian it is recognized as a GlidePoint and on
> >>> Ubuntu as a DualPoint. In an upstream kernel 4.13 which I just
> >>> built, it's also recognized as a GlidePoint. Unfortunately it
> >>> doesn't work either.
> >=20
> > Name is assigned based on detection if trackstick is present.
> > Different kernel versions is probably reasons, maybe one version
> > has wrong detection.
> >=20
> > Is trackstick movement working? This is probably important to know
> > as it looks like buttons are reported via trackstick, not via
> > touchpad.
>=20
> If by trackstick you mean the red thingie, it is **not** working.

Ok. And it is working with your patch?

> >>> I am not sure if the device is actually a DualPoint or not (I
> >>> don't really understand the terminology here), but the thing is
> >>> that the buttons work when the kernel believes it to be one.
> >>>=20
> >>> This is the info I have managed to find about the device while
> >>> running on the non-working debian:
> >>>=20
> >>> dmesg:
> >>> [    2.914806] input: AlpsPS/2 ALPS GlidePoint as
> >>> /devices/platform/i8042/serio1/input/input2
> >>>=20
> >>> lsinput:
> >>> /dev/input/event11
> >>>=20
> >>>    bustype : BUS_I8042
> >>>    vendor  : 0x2
> >>>    product : 0x8
> >>>    version : 1792
> >>>    name    : "AlpsPS/2 ALPS GlidePoint"
> >>>    phys    : "isa0060/serio1/input0"
> >>>    bits ev : (null) (null) (null)
> >>>=20
> >>> I have played around with the drivers/input/mouse/alps.c file and
> >>> found out the following:
> >>>=20
> >>> e7 and ec are important (although I don't know what these are
> >>> exactly) and have the following values:
> >>>=20
> >>> e7: 73 03 0a
> >>> ec: 88 b0 13
> >=20
> > Masaki should know exact type of device...
> >=20
> >>> This combination is recognized as an ALPS touchpad, but isn't
> >>> assigned the ALPS_DUALPOINT flag. As far as I can see, it is
> >>> actually being *removed* at this point:
> >>>=20
> >>> if (alps_probe_trackstick_v3_v7(psmouse, ALPS_REG_BASE_V7) < 0)
> >>>=20
> >>>             priv->flags &=3D ~ALPS_DUALPOINT;
> >>>=20
> >>> The bit that says it has a trackpoint (I don't know what this is)
> >>> is apparently saying my device doesn't have one and is removing
> >>> the ALPS_DUALPOINT flag.
> >=20
> > At least for V3 protocol that function tells touchpad to enable
> > pass- thru mode to trackstick and detect if trackstick is there
> > present. After that leave pass-thru mode.
> >=20
> >>> This flag makes the buttons work. I am not sure if it breaks
> >>> other stuff.
> >=20
> > Is that picture of your laptop, do you really have trackstick
> > working?
>=20
> The picture is not from my laptop, but it might as well just be: mine
> looks exactly the same. Actually it is from a blog which I read which
> inspired be to change my touchpad:
>=20
> https://www.camerongray.me/2015/02/fitting-physical-trackpoint-button
> s-to-a-lenovo-thinkpad-t440s/
>=20
> For the record, I don't have a T440 but an S440, should this be
> relevant.
>=20
> > My idea is that alps_probe_trackstick_v3_v7 does not check presence
> > of trackstick correct and return information that trackstick is
> > not present (which contains also those buttons)...
> >=20
> > Masaki, can you confirm if there can be problem with that function?
> >=20
> >>> I have written a pretty dummy patch which actually adds the flag
> >>> again making the buttons work. Again, I am not sure if it breaks
> >>> other stuff but my system isn't whining. Here is the patch:
> >>>=20
> >>> diff --git a/drivers/input/mouse/alps.c
> >>> b/drivers/input/mouse/alps.c index 850b00e3ad8e..17aba42e846f
> >>> 100644
> >>> --- a/drivers/input/mouse/alps.c
> >>> +++ b/drivers/input/mouse/alps.c
> >>> @@ -2804,6 +2804,9 @@ static int alps_set_protocol(struct psmouse
> >>> *psmouse,
> >>>=20
> >>>                 if (alps_probe_trackstick_v3_v7(psmouse,
> >>>=20
> >>> ALPS_REG_BASE_V7) < 0)
> >>>=20
> >>>                         priv->flags &=3D ~ALPS_DUALPOINT;
> >>>=20
> >>> +               if (priv->fw_ver[1] =3D=3D 0xb0)
> >>> +                       priv->flags |=3D ALPS_DUALPOINT;
> >>> +
> >>>=20
> >>>                 break;
> >>>        =20
> >>>         case ALPS_PROTO_V8:
> >>> After applying this patch dmesg and lsinput say this:
> >>>=20
> >>> [    8.226543] input: AlpsPS/2 ALPS DualPoint Stick as
> >>> /devices/platform/i8042/serio1/input/input13
> >>> [    8.247595] input: AlpsPS/2 ALPS DualPoint TouchPad as
> >>> /devices/platform/i8042/serio1/input/input2
> >>>=20
> >>> /dev/input/event11
> >>>=20
> >>>    bustype : BUS_I8042
> >>>    vendor  : 0x2
> >>>    product : 0x8
> >>>    version : 1792
> >>>    name    : "AlpsPS/2 ALPS DualPoint Stick"
> >>>    phys    : "isa0060/serio1/input1"
> >>>    bits ev : (null) (null) (null)
> >>>=20
> >>> /dev/input/event12
> >>>=20
> >>>    bustype : BUS_I8042
> >>>    vendor  : 0x2
> >>>    product : 0x8
> >>>    version : 1792
> >>>    name    : "AlpsPS/2 ALPS DualPoint TouchPad"
> >>>    phys    : "isa0060/serio1/input0"
> >>>    bits ev : (null) (null) (null)

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1657095.ru6jMM074h
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlmyPVUACgkQi/DJPQPkQ1LWHgCggh+F2cTc90OnJt78brldQvaV
NEQAmgP1PV4TKb8BwsM6t0y8d8R6VZ+w
=c8/i
-----END PGP SIGNATURE-----

--nextPart1657095.ru6jMM074h--
