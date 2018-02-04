From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: ALPS touchpad ot correctly recognized: GlidePoint vs DualPoint
Date: Sun, 4 Feb 2018 19:16:05 +0100
Message-ID: <20180204181605.eknruesqvvnncrqd@pali>
References: <ada750eb-daeb-c9ae-2452-fcf027a4e704@posteo.net>
 <201709080848.53286@pali>
 <52f87b68-8a6b-1d9c-f341-1e488ff43441@posteo.net>
 <201709091036.06899@pali>
 <20170909181218.GA29107@dtor-ws>
 <b3b06164-183b-d3f8-8de2-804eb1d343dd@posteo.net>
 <KAWPR01MB1092DDBF54FC34842384D3BBC7680@KAWPR01MB1092.jpnprd01.prod.outlook.com>
 <7d5d4e88-b6d2-ce7b-a529-18f2b131fa7f@posteo.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="eydtckdib3j4fr27"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:44852 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751577AbeBDSQJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 4 Feb 2018 13:16:09 -0500
Received: by mail-wr0-f170.google.com with SMTP id v31so27361686wrc.11
        for <linux-input@vger.kernel.org>; Sun, 04 Feb 2018 10:16:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7d5d4e88-b6d2-ce7b-a529-18f2b131fa7f@posteo.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Juanito <juam+kernel@posteo.net>
Cc: Masaki Ota <masaki.ota@jp.alps.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Paul Donohue <linux-kernel@paulsd.com>


--eydtckdib3j4fr27
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Monday 11 September 2017 13:26:30 Juanito wrote:
> Hi Masaki Ota,
>=20
> Thanks!
>=20
> On 11.09.2017 04:38, Masaki Ota wrote:
> > Hi, Juanito,
> >=20
> > In my information, ALPS Touchpad is used on Thinkpad E series and L ser=
ies.
> > I don't know the device that is ALPS Touchpad + other vendor TrackStick.
> > But Lenovo might use ALPS Touchpad on such a combination.
> >=20
>=20
> Well, that is probably my fault, as it is not the original touchpad that
> was delievered with the laptop. I bought the touchpad (that included
> the three buttons) separately because I didn't like the clickpad that
> came with my laptop.

Hi Juanito,

if you are still want to play with your touchpad hardware, I have a good
news for your.

It looks like that at least ALPS rushmore touchpads allow to receive RAW
PS/2 packets from trackstick to host kernel, without modifying them by
touchpad. Plus I was able to tell ALPS touchpad to start "mixing" those
RAW trackstick PS/2 packets with native touchpad packets.

On my configuration trackstick in RAW PS/2 mode by default talks with
standard bare 3 byte PS/2 protocol and touchpad in 6 byte ALPS protocol.
alps.c/psmouse.ko is already able to process and parse such mixed
packets. And trackstick can be switched to some extended 4 byte
protocol...

All this happen when passthrough mode is enabled.

=46rom my understanding it seems that in normal mode, touchpad and
trackstick communicate with that 4 byte protocol and touchpad converts
it into 6 byte ALPS protocol and then send to kernel.

On thinkpads trackstick communicate with TPPS/2 protcol and above 4
byte. So in my opinion ALPS touchpad by default cannot understand it.
But you should be able to enter passthrough mode and then you would
receive that TPPS/2 in alps kernel code.

> > And I have found that the V7 protocol device has a special ID for Lenov=
o.
> > ALPS assigns the value that is the model type to 0xC399 address.
> >=20
> > Could you check 0xC399 address value such like a below code?
> > reg_val =3D alps_command_mode_read_reg(psmouse, 0xC399);
> >=20
> > If the value is 0x1 or 0x2 or 0x6 or 0x10 or 0xF, it has a Stick button=
s.
> >=20
>=20
> I will check this as soon as I can (I don't have access to the laptop
> right now).
>=20
> > Best Regards,
> > Masaki Ota
> > -----Original Message-----
> > From: Juanito [mailto:juam+kernel@posteo.net]=20
> > Sent: Sunday, September 10, 2017 3:22 AM
> > To: Dmitry Torokhov <dmitry.torokhov@gmail.com>; Pali Roh=C3=A1r <pali.=
rohar@gmail.com>
> > Cc: =E5=A4=AA=E7=94=B0 =E7=9C=9F=E5=96=9C Masaki Ota <masaki.ota@jp.alp=
s.com>; linux-input@vger.kernel.org; Paul Donohue <linux-kernel@paulsd.com>
> > Subject: Re: ALPS touchpad ot correctly recognized: GlidePoint vs DualP=
oint
> >=20
> > On 09/09/2017 08:12 PM, Dmitry Torokhov wrote:
> >> On Sat, Sep 09, 2017 at 10:36:06AM +0200, Pali Roh=C3=A1r wrote:
> >>> On Saturday 09 September 2017 10:12:42 Juanito wrote:
> >>>> Hello,
> >>>>
> >>>> On 09/08/2017 08:48 AM, Pali Roh=C3=A1r wrote:
> >>>>> On Friday 08 September 2017 07:00:34 Juanito wrote:
> >>>>>>> ThinkPad with ALPS? Should not be it Synaptic? Maybe=20
> >>>>>>> miss-detection?
> >>>>>>
> >>>>>> Sorry, I forgot to mention this. The ThinkPad came with a clickpad=
=20
> >>>>>> I **really** disliked, so I bought this on the Internet.
> >>>>>
> >>>>> So, here is a problem. ThinkPads works with Synaptic touchpads, not=
=20
> >>>>> with ALPS.
> >>>>
> >>>> There definitely seems to be a problem here :)
> >>>>
> >>>> Do you mean that the alps code might not be detecting the trackpoint=
=20
> >>>> because probably the red thingie works with synaptics?
> >>>>
> >>>> So could this be the situation:
> >>>> ALPS driver: Hey touchpad! Do you have a trackstick?
> >>>> ALPS touchpad: No, I don't.
> >>>> AD: Ok! (and thinks 'I am going to have to ignore all trackstick=20
> >>>> packets that might arrive')
> >>>>
> >>>> So the driver understands that there can't possibly be any buttons=
=20
> >>>> because there is no trackstick?
> >>>
> >>> IIRC ALPS touchpad hardware itself does not work with non-ALPS=20
> >>> trackpoint.
> >>>
> >>> Masaki, any comments?
> >>>
> >>>>>> If by trackstick you mean the red thingie, it is **not** working.
> >>>>>
> >>>>> Ok. And it is working with your patch?
> >>>>
> >>>> No, it isn't :(
> >>>
> >>> I expected... You just created franken-hardware.
> >>>
> >>> Looks like with your hack patch it is possible to make buttons=20
> >>> working, but I suspect that trackstick would.
> >>>
> >>> Maybe Masaki can provide more information about this fact if we can=
=20
> >>> do anything.
> >>>
> >>> Dmitry, what you as maintainer going to do with this problem?
> >>
> >> It really depends on Ota-san response. If ALPS needs a special version=
=20
> >> of firmware flashed for proper trackstick identification, then I guess=
=20
> >> Juanito will have to carry a local patch. I do not think we want to=20
> >> complicate the driver any further for supporting such after-market=20
> >> modification.
> >>
> >=20
> > If this only happens in this after-market (or franken-hardware...
> > hahaha), I'd totally understand if you didn't want to patch it upstream=
, although it would be nice for me :)
> >=20
> >> Does booting with psmouse.proto=3Dimps makes trackstick work?
> >>
> >=20
> > I am afraid I can't test it now as I don't have access to the laptop. I=
 won't be able to test until two weeks. Will definitely do as soon as I can.
> >=20
> >> Thanks.
> >>
> >=20
> > Thank **you** (Dmitry and everybody esle) for taking the time to look a=
t this.
> >=20
> > Juanito
> >=20
>=20
>=20
> Thank you very much!
>=20
> Best regards,
> Juanito
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--eydtckdib3j4fr27
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWndN4gAKCRCL8Mk9A+RD
UrbTAJkB7uL8lteFvuHg8rpZf8mnfT3eaQCfWXtDey83jJb+RyvExP7Mo1twm8w=
=Q8EP
-----END PGP SIGNATURE-----

--eydtckdib3j4fr27--
