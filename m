From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/8] i2c: export i2c_client_type structure
Date: Sat, 1 Apr 2017 18:06:46 +0200
Message-ID: <20170401160645.aunntbwuuvowsga4@ninjato>
References: <20170309221644.17035-1-dmitry.torokhov@gmail.com>
 <20170309221644.17035-2-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4ksv4nrag3uqof4b"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:48276 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbdDAQGt (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 1 Apr 2017 12:06:49 -0400
Content-Disposition: inline
In-Reply-To: <20170309221644.17035-2-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org


--4ksv4nrag3uqof4b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 09, 2017 at 02:16:37PM -0800, Dmitry Torokhov wrote:
> i2c bus has 2 different types of device belonging to the same bus and
> bus notifiers use device type to distinguish between adapters and clients.
> Previously we only had i2c_adapter_type exported, which made code wanting
> to work with i2c_client devices test for type not equal to adapter type.
> This unfortunately is not safe if we ever add another type to the bus,
> so let's export i2c_client_type as well.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>=20
> Wolfram, this is the patch I was talking about in the other mail.

Reviewed-by: Wolfram Sang <wsa@the-dreams.de>

You can add the above tag to all patches in your branch
'4.11-rc3-i2c-irq-resources' and after that we declare it immutable and
I'll pull it into my for-next. Sorry for the delay. I got side-tracked
and ill. But I am better now.

And to keep your heads up: We agreed yesterday that i2c_drivers will get
a flag to signal I2C core to skip all the irq assignment stuff and let
the driver do it itself [1]. Maybe this will become useful for you, too.

[1] http://www.spinics.net/lists/linux-acpi/msg73197.html


--4ksv4nrag3uqof4b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljf0BEACgkQFA3kzBSg
KbbW1A//Ye0R3yej3uNKYsQ9RCmbXJRLXZ8GzK+QZY1hHT56wp6+6QTJcLWJ6IpD
MeiSaikyRP4ESe9R7kqE5IneIvalUyTP0WCWmJXfLCRdU4UNjXD/XWz+5NC8z1ld
Cda71K947406vdYJK+RJ+MOVWrE7Cl8J74JD8nWjRhy76AEjwSBDwTtBMgh2kS2d
Y4FmDJpY3FdM0s9PsMGlHp2L6+d+6riA0O4Z+bY2KRGV/2xffiBminZY4OeI3lHD
3vZBSI7TvaVvSHSXmO1MastRY1650yTgAvj62ItUX5Lkthi/v9iWAknXN+7CANCb
2PBZI+COS8jAKsyd624xniOYWhLQqZVPwLI7gK3Paza6NhLxingWbcSC0GIPiEcZ
VwVefX1977SytAI1k6xTb7XbMbKQEC5jm59Jajvm0Z0NjQsYfhL+vH01PU10quRd
qfFBfeP26qs+Ixo27yGIGFWbGp2UVY8kO7NXQYdRUiiBfm8hs7GVhnL9+48F36Si
j+WVL4BFGbh5ASBYsWDHTzRA2pdZAtxhvSg5VnxZGFXQQBMozqKm4mQywpzRvFs+
WCJRKXQEQTCRz80qjoWRD9t0TRzuNU7qHY/+gXEMzI54L7MnNBRXMvFXfzIbXDFu
HkGByEZkROvmWEZHteDAAvQNnybZmkVYeQtBJLiXKyCAT+RpbuM=
=NTJe
-----END PGP SIGNATURE-----

--4ksv4nrag3uqof4b--
