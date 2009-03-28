From: Andrew Zabolotny <zap@homelink.ru>
Subject: Re: [PATCH] Wacom Graphire Bluetooth driver (updated with a few
 fixes)
Date: Sat, 28 Mar 2009 22:35:48 +0300
Message-ID: <20090328223548.1896fa41@zap.home.lan>
References: <1236988799.32264.6310.camel@cookie.hadess.net>
	<1237247755.32264.10664.camel@cookie.hadess.net>
	<1237335112.15346.118.camel@cookie.hadess.net>
	<20090319002838.5b0132b4@zap.home.lan>
	<1237416448.15346.1483.camel@cookie.hadess.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UYPS_kz28PcXVfTDBqIe2H7";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay.eltel.net ([81.9.101.72]:56328 "EHLO relay.eltel.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753291AbZC1TgH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Mar 2009 15:36:07 -0400
In-Reply-To: <1237416448.15346.1483.camel@cookie.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, linux-input <linux-input@vger.kernel.org>

--Sig_/UYPS_kz28PcXVfTDBqIe2H7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

=46rom Wed, 18 Mar 2009 22:47:28 +0000
Bastien Nocera <hadess@hadess.net> wrote:

> I think that the main problem was because, at that time, there was no
> such thing as the HID sub-system to avoid having to reimplement things
> twice for Bluetooth and USB devices.
Yes, that was the main problem and I hoped to discuss it with the
bluetooth stack developers... The solution, as I was seeing it, is to
make the bluetooth stack implement a "bluetooth bus": this would allow
to emit udev events when devices are connected/disconnected, thus using
the normal udev module autoloading stuff.

However, I see that the bluetooth stuff chose another path, by using a
user-space daemon. I'm very far from bluetooth developement to
understand why this choice was made, however I'm pretty sure there were
serious arguments in favour of that.

> And it's a patch to input plugin for bluetoothd, not hidd. hidd is the
> BlueZ 3.x daemon, we've been at BlueZ 4.x for a while.
Aha, it's the stuff for low-level tablet protocol initialization. Why
separating it from the driver itself? It's kind of tricky having
hardware initialization in a user-space daemon, and working with
hardware in the driver itself. Isn't there an analogue of the
hidp_send_ctrl_message() call for the new hid driver architecture?

--=20
Andrew

--Sig_/UYPS_kz28PcXVfTDBqIe2H7
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)

iEYEARECAAYFAknOfBUACgkQ6/fZ6v/j5feTtACdEf1IqWcQdHn1IUn/nryPfD1U
WwsAn0qZZb1w29IuvjIQP/sDGKFf1Ss5
=cjqK
-----END PGP SIGNATURE-----

--Sig_/UYPS_kz28PcXVfTDBqIe2H7--
