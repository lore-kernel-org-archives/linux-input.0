From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: Re: ET1602 Touchscreen doesn't work
Date: Fri, 3 Jun 2011 09:44:29 -0300
Message-ID: <20110603124428.GA2379@nautilus.holoscopio.com>
References: <BANLkTikX9njth-jP6PpQuwL9sTUciu1nQA@mail.gmail.com>
 <20110602144146.GB3508@nautilus.holoscopio.com>
 <BANLkTimen=6OXOTww48CAn-ULaRVP_7zUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from liberdade2.minaslivre.org ([74.50.53.203]:39622 "EHLO
	liberdade.minaslivre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172Ab1FCMoj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Jun 2011 08:44:39 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimen=6OXOTww48CAn-ULaRVP_7zUw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chih-Wei Huang <cwhuang@android-x86.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 03, 2011 at 12:02:09PM +0800, Chih-Wei Huang wrote:
> 2011/6/2 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>:
> > It depends on your userspace. It should work properly with X.org drivers
> > evdev and evtouch. Are you trying this with Android?
>=20
> Yes, exactly.
>=20
> Actually the touchscreen is detected, but it appears twice:
>=20
> [    3.408922] input: HID TOUCH HID Touch Panel as
> /devices/pci0000:00/0000:00:1d.3/usb5/5-2/5-2:1.0/input/input6
> [    3.412345] input: HID TOUCH HID Touch Panel as
> /devices/pci0000:00/0000:00:1d.3/usb5/5-2/5-2:1.0/input/input7
> [    3.415386] generic-usb 0003:1BFD:1688.0003: input: USB HID v1.01
> Mouse [HID TOUCH HID Touch Panel] on usb-0000:00:1d.3-2/input0
>=20
> I tried to use getevent, a debug tool of android,
> to get the touch events.
> I found touch events appear in /dev/event7,
> not in /dev/event6.
> Is it the desired behavior?
>=20
> But the Android framework seems only detect
> /dev/event6 and ignore /dev/event7,
> probably because they have the same name.
>=20
> Any suggestion how to solve the problem?
>=20
> Regards,
> --=20
> Chih-Wei
> Android-x86 project
> http://www.android-x86.org

You should use the device capabilities, like what events it does
generate. If it does generate X and Y axis events, that's the right
device.

Best regards,
Cascardo.

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJN6NcrAAoJEEWxSg7udFZId44QAJLHgQ7BwXnAFqV2wWH5OmUE
MUoaQpkoEOzb6JYhesew5UaBpvZNrC9nbDdI4TQtDv+55rcynIf2hfz7CutXhReF
v+uJFAoPonMB++qOgfV249niiwEYreP9h0KVIgs/pCWdAAzufhPj1BjWWEL7/MEs
aEnw/4BWqjde/mzy9cMDX6xZG0XUnmibM5AF2fl6Yr6dkUwNokE9D0Cq08gOXMX4
bH/1gLoCM8h4PiHH4Z+28HgEEUgvsaQABY+RLmv0JKfukS9WLKmhp3xZ+e1db5Ws
qLldJFZ+lEQUnUy3HfvvnDTC7CFUB4grDVZAa6UpoPtGzBMUE6fufpyYhDWSc0LF
AiT2YH8Ek0BiSQHveir2uzNaVYJfqh8Yh+1aSPzm9WFQ1hphdYqKcXdjGZiVLmJx
Mg4aznlq1pt8s/kawbFtzn7gEfT5PwCGFOGmSCa5N0F8tOpTHCAiDM66AWLZinPc
OE+KY04nd2Lq+obbZ7R9cu22t0dIfpidaxxiywMagfxYCkLPuv3xaGcyXohCkek4
6xDFKngGXegauY9YVetWxhV//yGQe+aRbCujKf28B+ZcIaGUxTudV0wekag565Ez
L8Xfayulu/sqqekqH67dekfEOqCq5Or0q3IFe1F1UMc5eLHBket1oWSnYlUgCmxH
KVqZQczkW/RRmw4N180b
=MDf0
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
