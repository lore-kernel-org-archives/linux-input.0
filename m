From: Benson Leung <bleung@google.com>
Subject: Re: [PATCH] HID: i2c-hid: allocate hid buffers for real worst case
Date: Wed, 13 Sep 2017 08:00:36 -0700
Message-ID: <20170913150036.GA66089@decatoncale.mtv.corp.google.com>
References: <20170908175527.GA19720@dtor-ws>
 <nycvar.YFH.7.76.1709130701170.4703@jbgna.fhfr.qr>
 <20170913144950.GA1122@dtor-ws>
 <nycvar.YFH.7.76.1709130751380.4703@jbgna.fhfr.qr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1709130751380.4703@jbgna.fhfr.qr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Guenter Roeck <groeck@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, bleung@chromium.org
List-Id: linux-input@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

On Wed, Sep 13, 2017 at 07:52:20AM -0700, Jiri Kosina wrote:
> > Oops, I must have cut it off on accident while removing ChromeOS
> > specific tags, the original commit is here:
> >=20
> > https://chromium-review.googlesource.com/c/chromiumos/third_party/kerne=
l/+/475212
>=20
> Ok, thanks, will use that one. How about=20
>=20
> 	Reviewed-by: Benson Leung <bleung@chromium.org>
>=20
> which is missing in the mail you've sent, but is there in the above=20
> reference commit?

Submission looks good to me. Go ahead and add.
Reviewed-by: Benson Leung <bleung@chromium.org>

Thanks,
Benson
--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJZuUgUAAoJEB8J9XsKL+ZY23EQAIfbcRAXDbzwCbA3l6xk+FV1
YLcMz8RJyUOerSJatJQ4WOCEgfLpuTY+y3jRujNDygC+oarTFWP/+LKe0TKWl8tX
HkHckUyVRSAvBr5DdbwlEWdtmnahiEeI0GNmMyggUXW+ULPe0jjpS5VedqlTbPqG
VybrWQ4SMjIeVrBq5j+qozkm7unIz1qnSUJyAZaCEx03HXzZ0xZX319buTD/ATvE
+lnD++QmTocuBnF8GGHcsWE1v5QtmTv+7TpLH7IJl7tsUP5TWdQSE1ukM5vjCIx7
vCjDPo2as/VqjjX7BH/L4YOaT7B/zzp0RzoXreGgxh0DcwDcpFaw/Nf+wTLQ4QJu
YvMHMySOpDDjFQ+hyy4LzdaBjf2L56V5xxVBKaufbPCp1PJab6WeDB/khWwzMo7g
yt9SK6K6WUlcc+oMslpnoVKMMZxXEPVOai07fISmq0bxlpPPNFGc+FsohB1aHqwT
7ZOd9F+a3zrbU0l27RYRuvIUIPDYL96sZFQgUr0pqaJTukg1g6r+uMI70k+b9v6e
wTTv3woeaFb3/KbpVq5UNwoOiUAdz4eN8ggvN/+1c+GRHbk7OivSpwi1HGpz4veF
ez94uC2GKoMngQyd+J/0EaBh9BuAiska9FrOGDyd5HO5Im8M8FZqWYGldR60pf+c
8izcm1rc3ZTJQkLnA70M
=GF0u
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
