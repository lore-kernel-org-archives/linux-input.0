From: Philippe Coval <philippe.coval@open.eurogiciel.org>
Subject: Re: [PATCH v2] usbtouchscreen: adds support for inverting X or Y
 axis (or both)
Date: Mon, 13 Jul 2015 12:41:13 +0200
Message-ID: <55A395C9.6040207@open.eurogiciel.org>
References: <1433720284-23342-1-git-send-email-rzr@gna.org>	 <1436782503-9749-1-git-send-email-rzr@gna.org> <1436783296.20249.37.camel@hadess.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="CBoF5oIc8W7t4PoAxjtwQibVxBWDnJma7"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:36443 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbbGMKl1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2015 06:41:27 -0400
Received: by widjy10 with SMTP id jy10so65386576wid.1
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2015 03:41:26 -0700 (PDT)
In-Reply-To: <1436783296.20249.37.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, poeschel@lemonage.de, dmitry.torokhov@gmail.com
Cc: Ondrej Zary <linux@rainbow-software.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Philippe Coval <philippe.coval@open.eurogiciel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CBoF5oIc8W7t4PoAxjtwQibVxBWDnJma7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/13/2015 12:28 PM, Bastien Nocera wrote:
> On Mon, 2015-07-13 at 12:15 +0200, Philippe Coval wrote:
>> Invert Y is needed (together with swap XY) for some touchscreens :
>> - LeadingTouch screens (at least for some of them)
>> - CarTft 8in4 (USB ID=3D0eef:0001)
>=20
> Wouldn't it be useful to force those settings for touchscreen devices
> which you can detect? That would make it work out-of-the-box on those
> devices.
>=20
Hi,

That's what I am doing, but userland (using udev rules),
since I am really unsure we can rely on USB id...

For now, I don't think it's a good idea to force any behaviour,
that can cause regressions on other ones.

In a longer term, it would be good to keep a list of all those screens
and see what should be the prefered behaviour per identification.

Note, I don't have any screen anymore.

Thanks for feedback


--=20
 mailto:philippe.coval@eurogiciel.fr  --  gpg:0x467094BC
 xmpp:philippe.coval.pro@gmail.com
 https://dockr.eurogiciel.fr/blogs/embedded/author/pcl/
                                                                      .



--CBoF5oIc8W7t4PoAxjtwQibVxBWDnJma7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlWjlc0ACgkQlNXo+kZwlLwf3wCfUOxeAvtGq1XcwI6q7Zz4b9EZ
M4EAnRTfGkH1+o1I9OwUwA9ExBz4O0lP
=rEaN
-----END PGP SIGNATURE-----

--CBoF5oIc8W7t4PoAxjtwQibVxBWDnJma7--
