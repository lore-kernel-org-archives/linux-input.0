From: Andrew Zabolotny <zap@homelink.ru>
Subject: Re: [PATCH] Wacom Graphire Bluetooth driver (updated with a few
 fixes)
Date: Thu, 19 Mar 2009 00:28:38 +0300
Message-ID: <20090319002838.5b0132b4@zap.home.lan>
References: <1236988799.32264.6310.camel@cookie.hadess.net>
	<1237247755.32264.10664.camel@cookie.hadess.net>
	<1237335112.15346.118.camel@cookie.hadess.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wXkGfS_7xauNadimz8KgS9j";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay.eltel.net ([81.9.101.72]:34284 "EHLO relay.eltel.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753371AbZCRXVR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Mar 2009 19:21:17 -0400
In-Reply-To: <1237335112.15346.118.camel@cookie.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input <linux-input@vger.kernel.org>, mjg <mjg@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, BlueZ development <linux-bluetooth@vger.kernel.org>

--Sig_/wXkGfS_7xauNadimz8KgS9j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

=46rom Wed, 18 Mar 2009 00:11:52 +0000
Bastien Nocera <hadess@hadess.net> wrote:

> Based on the work by Andrew Zabolotny, an HID driver for the Bluetooth
> Wacom tablet.
Great to see my old work was finally useful :) I tried in the past to
contact the bluetooth stack author to submit my patch, but got no answer
and gave up.

Also I like the fact that you have dropped my wicked out-of-active-area
pseudo-buttons support. Such kind of things should be implemented, if
needed, in the x11 driver (but the driver would need a way to report
out-of-active area stylus presses).

What's that "mode 2 patch" you're talking about? Should it be applied
to hidd, and is it available somewhere?

--=20
Andrew

--Sig_/wXkGfS_7xauNadimz8KgS9j
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)

iEYEARECAAYFAknBZ4YACgkQ6/fZ6v/j5fcFNACfXq44FCNOdIrU5hy4dpLBp8vT
vQMAniXm9nzAZiacX1B1llYSOwuluVf8
=e6Ur
-----END PGP SIGNATURE-----

--Sig_/wXkGfS_7xauNadimz8KgS9j--
