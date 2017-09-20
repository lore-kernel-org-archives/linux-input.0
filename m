From: Benson Leung <bleung@google.com>
Subject: Re: [PATCH] HID: hidraw: fix power sequence when closing device
Date: Tue, 19 Sep 2017 23:37:38 -0700
Message-ID: <20170920063738.GA153422@decatoncale.mtv.corp.google.com>
References: <20170920013746.GA33367@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:54631 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdITGhm (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 20 Sep 2017 02:37:42 -0400
Received: by mail-pf0-f181.google.com with SMTP id d187so1073193pfg.11
        for <linux-input@vger.kernel.org>; Tue, 19 Sep 2017 23:37:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170920013746.GA33367@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Benson Leung <bleung@chromium.org>, Oliver Neukum <oneukum@suse.com>, Guenter Roeck <groeck@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Tue, Sep 19, 2017 at 06:37:46PM -0700, Dmitry Torokhov wrote:
> We should not try to bring HID device out of full power state before
> calling hid_hw_close(), so that transport driver operates on powered up
> device (making this inverse of the opening sequence).
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Benson Leung <bleung@chromium.org>

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJZwgyyAAoJEB8J9XsKL+ZYO+4P/1joB2LbFoc9hoGgDz/rJoGb
ZuRehmMpz3ueWoxxcZCJAa/mybAD/8zLP7h/R5lu0n6I6HnRp2ERNndJGGpJtrg1
KTQd8JFOMQJdo4nyrVwUp2AoR0ek/+G4yLpBfI+nUg1W5kPpNnkcknveCMQDKj1u
bIkNATMLg/YgCAJc6eW4XJkudNbY0ULFf+dOjOyhTzQ4HYsLXdaiZXqp0aoV8a/X
5nza3psEuyobC3hOZbuMu4K9DQwYbnvS6oPhxkmo+akpOF34Y9z0kXvScwBTUF73
WiNiTC109RCQkZaYEGlJfPWbmyd4zSgh0IpxUFI5ajs+E1rNLtNCUB4DquA3y3WM
EcU5lQzw9K9v1/pW7zrobYdOyOiaRm+Fup/thiU3fq6mpTbUAKtmjzoKvCNi7XOo
O65Hpie/pwGQ2CS1EEYhQxkOx5ODfdUS3TcoMZ6/NN7f4wnXC05hcOKTnoTaObff
rxkGNaGDbhcP2aLdH1LsJpR0wkrJK7Qf5AZybZjNoK4GQ2F/NBrbTrqMRNuxjXB0
b2/PJGIH++j9U/wQdzuI5s4wnhzV5YcdNJit5qwHA05GCKNDFIUXQUH1Jea8CojX
AqVqMo+d0AsLOreIQfNYnvNV3TTnlU6y5h4PfcEj6ZcyU2J4YSO+MF7ZBnJzW8mm
VVrDqxCcBeVv3RJJM1Sa
=1NLR
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
