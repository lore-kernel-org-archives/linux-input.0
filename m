From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: psmouse - disable automatic probing of BYD touchpads
Date: Sat, 12 Nov 2016 20:39:32 +0100
Message-ID: <201611122039.33245@pali>
References: <20161112191545.GA19531@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2066006.hKQSnr5iPu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35193 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966793AbcKLTjg (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 12 Nov 2016 14:39:36 -0500
In-Reply-To: <20161112191545.GA19531@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Chris Diamand <chris@diamand.org>, phonesyfreakies@gmail.com, Michael Shell <list1@michaelshell.org>, Eric Wong <normalperson@yhbt.net>, Ondrej Zary <linux@rainbow-software.org>, Christophe TORDEUX <christophe@tordeux.net>, Richard Pospesel <pospeselr@gmail.com>, linux-kernel@vger.kernel.org

--nextPart2066006.hKQSnr5iPu
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 12 November 2016 20:15:45 Dmitry Torokhov wrote:
> BYD automatic protocol detection is extremely unreliable and is often
> triggers false positives on regular mice, Sentelic touchpads, and
> other devices. BYD has several documents that have recommended
> detection sequence, but they conflict with each other and, as far as
> I can see, still would not produce unique enough output to reliably
> differentiate BYD from other PS/2 devices.
>=20
> OEMs sourcing BYD devices also do not do us any favors by not
> supplying any reasonable DMI data and instead leaving turds like "To
> Be Filled By O.E.M." in place of vendor data, or "System Serial
> Number" as serial number.
=2E..
> 	echo -n "byd" > /sys/bus/serio/devices/serio1/drvctl

I agree, if we cannot detect BYD devices correctly without breaking=20
other non-BYD devices then detection must be done by user...

So you can add my Reviewed-by: Pali Roh=C3=A1r to this patch.

Anyway, BYD show Linux as supported OS for their devices. It is really=20
rude from BYD that they show Linux as supported OS, but Linux driver is=20
reverse-engineered by community and they do not want to cooperate and at=20
least provide some useful documentation for detection...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2066006.hKQSnr5iPu
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlgnb/UACgkQi/DJPQPkQ1K4twCghQJAV65L9bVypvuCiAkGZ9Qf
mJ0An1/VkdUcxuaFXpHhV9C1GwLhIWeP
=g+iS
-----END PGP SIGNATURE-----

--nextPart2066006.hKQSnr5iPu--
