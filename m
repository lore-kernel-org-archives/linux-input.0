From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Enable addition function keys
Date: Tue, 24 May 2011 10:52:38 -0700
Message-ID: <20110524175238.GA16908@core.coreip.homeip.net>
References: <000001cc1403$1e0ede10$5a2c9a30$@com>
 <20110524062256.GA20829@core.coreip.homeip.net>
 <BANLkTinh4Ssnv16t9wp79D82XekiQMZguQ@mail.gmail.com>
 <BANLkTikFxR_xzZV6WNce+HBDVwc5QZc9yQ@mail.gmail.com>
 <20110524164931.GA16841@core.coreip.homeip.net>
 <BANLkTikH1kzGVqnqF=9uyZHRkWEK3ErURA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64762 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755298Ab1EXRwo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 May 2011 13:52:44 -0400
Received: by pvg12 with SMTP id 12so3072883pvg.19
        for <linux-input@vger.kernel.org>; Tue, 24 May 2011 10:52:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTikH1kzGVqnqF=9uyZHRkWEK3ErURA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Christen <davidchristen@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, May 24, 2011 at 07:39:22PM +0200, David Christen wrote:
> >>
> >> Dear Dmitry,
> >>
> >> I'm starting to feel stupid. I tried a simple code doing some ioct=
l
> >> calls using EVIOCSKEYCODE =A0and EVIOCGKEYCODE. But it does not ap=
pear
> >> to work. If I run it using ./ioctl-test /dev/input/event0 I get lo=
ts
> >> of complains about wrong arguments:
> >>
> >> =3D=3D=3D=3D
> >> evdev ioctl: Invalid argument
> >> [0]=3D 125, [1] =3D 0
> >> evdev ioctl: Invalid argument
> >> [0]=3D 126, [1] =3D 0
> >> evdev ioctl: Invalid argument
> >> [0]=3D 127, [1] =3D 0
> >> evdev ioctl: Invalid argument
> >> [0]=3D 128, [1] =3D 0
> >> evdev ioctl: Invalid argument
> >> [0]=3D 129, [1] =3D 0
> >> evdev ioctl: Invalid argument
> >> Testing changes
> >> evdev ioctl: Invalid argument
> >> [0]=3D 49, [1] =3D 49
> >> evdev ioctl: Invalid argument
> >> [0]=3D 50, [1] =3D 49
> >
> > The "scancode" for USB HID devices is full usage code (32 bit), so =
to
> > remap 'M' to 'N' I think you need to issue EVIOCSKEYCODE for
> > usage 0x00070010 (I think) and keycode 49 (KEY_N).
> >
> > BTW, this requires somewhat recent kernel. What kernel are you usin=
g?
> >
> Dear Dmitry,
>=20
> So you mean it should say:
>=20
> 	codes[0] =3D 0x00070010 ; /* M keycap */
> 	codes[1] =3D 49; /* assign to N */

Yes.

>=20
> 	if(ioctl(fd, EVIOCSKEYCODE, codes)) {
> 		perror("evdev ioctl");
> 	}
>=20
>=20
> > P.S. In your program you call EVIOCSKEYCODE twice. I believe the 2n=
d
> > time, when you test, you want to call EVIOCGKEYCODE.
> >
> >
>=20
> Yes, you were right. Please find the corrected file attached.
>=20
> But it seems that the behavior is exactly the same.
>=20
> The kernel I use is 2.6.33 . It's a debian distro running on a risc p=
rocessor.

I am afraid you need 2.6.38. Or you'll have to backport the following
commits:

8613e4c Input: add support for large scancodes
ab4e019 Input: define separate EVIOCGKEYCODE_V2/EVIOCSKEYCODE_V2
de391d1 Input: fix typo in keycode validation supporting large scancode=
s
a0bf0ea Input: hid-input - switch to using new keycode interface
f5854fa Input: hid-input - allow mapping unknown usages

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
