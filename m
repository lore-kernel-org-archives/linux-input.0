From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH] Input: keyboard - add device tree bindings for simple
 key matrixes
Date: Wed, 28 Dec 2011 23:01:50 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17755DC8DB@HQMAIL01.nvidia.com>
References: <1325112771-31941-1-git-send-email-olof@lixom.net>
	<74CDBE0F657A3D45AFBB94109FB122FF17755DC8D2@HQMAIL01.nvidia.com>
 <CAOesGMiNuW3mexN_8PtunZkaVX4Uph-OgZFr5zLhaB1nih_EEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOesGMiNuW3mexN_8PtunZkaVX4Uph-OgZFr5zLhaB1nih_EEw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "Simon Glass (sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org)" <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rakesh Iyer <riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Olof Johansson wrote at Wednesday, December 28, 2011 11:34 PM:
> On Wed, Dec 28, 2011 at 10:16 PM, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>=
 wrote:
> > Olof Johansson wrote at Wednesday, December 28, 2011 3:53 PM:
> >> From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>
> >> This adds a basic device tree binding for simple key matrix data.
> >>
> >> Signed-off-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
> >> ---
> >>
> >> Based on email exchange this morning, this is a first cut at a sha=
red
> >> definition and helper function to parse and fill in the keymap dat=
a.
> >>
> >> Instead of doing the direct parsing into the final keymap format, =
I
> >> chose to fill in the pdata-equivalent since that is how the OF pda=
ta
> >> fillers work right now if code is to be kept common with the legac=
y
> >> platform_device probe interface.
> >>
> >> This is a prerequisite for a revised version of the tegra-kbc devi=
ce
> >> tree support that I will repost separately once this interface is =
stable.
> > ...
> >> diff --git a/Documentation/devicetree/bindings/input/matrix-keymap=
=2Etxt
> > ...
> >> +For simple keyboards with just a few buttons, you can specify eac=
h key
> >> +as a subnode of the keyboard controller, with the following
> >> +properties:
> >> +
> >> +- keypad,row: the row number to which the key is connected.
> >> +- keypad,column: the column number to which the key is connected.
> >> +- linux,code: the key-code to be reported when the key is pressed
> >> + =A0and released.
> >> +
> >> +Example:
> >> +
> >> + =A0 =A0 key_1 {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 keypad,row =3D <0>;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 keypad,column =3D <3>;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 linux,code =3D <2>;
> >> + =A0 =A0 };
> >> +
> >> +
> >> +For a more complex keyboard, such as a full laptop, a more compac=
t
> >> +binding can be used instead, with the following property directly=
 in
> >> +the keyboard controller node:
> >> +
> >> +- linux,keymap: an array of 3-cell entries containing the equival=
ent
> >> + =A0of the three separate properties above: row, column and linux
> >> + =A0key-code.
> >
> > Why allow two completely different bindings? Is there some deficien=
cy
> > to the compact binding that means it isn't suitable for all cases?
>=20
> The main reason is that the samsung keyboard driver already implement=
s
> the more verbose one, and allowing that binding to coexist while also
> providing a more compact one seems like the right thing to do.

Can we deprecate the Samsung format, and only allow it for that Samsung
device (and allow both there), and require a single format for any othe=
r
keyboard?

The issue here is that U-Boot wants to stay small, and having to allow
two alternative methods to specify a keyboard is going to bloat the cod=
e;
I expect some pushback adding DT support for just one binding by the ti=
me
they see all the DT parsing code that's needed to do it all right.

--=20
nvpublic
