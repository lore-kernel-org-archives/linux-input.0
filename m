From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/8] i2c: export i2c_client_type structure
Date: Fri, 10 Mar 2017 00:12:46 +0100
Message-ID: <20170309231246.GA4300@tetsubishi>
References: <20170309221644.17035-1-dmitry.torokhov@gmail.com>
 <20170309221644.17035-2-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46667 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752233AbdCIXMv (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 9 Mar 2017 18:12:51 -0500
Content-Disposition: inline
In-Reply-To: <20170309221644.17035-2-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <jdelvare@suse.de>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dmitry,

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

I see. From a glimpse, I am fine with the patch. I'll add Jean Delvare
to CC, though, in case I missed some detail he still knows. Furthermore,
while I agree that testing for "not adapter" when one means "is client"
is not nice, is there a bigger benefit than being correct in your queue?

Regards,

   Wolfram

>=20
>  drivers/i2c/i2c-core.c | 4 ++--
>  include/linux/i2c.h    | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 34a5115484dd..446e341e9508 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -74,7 +74,6 @@
>  static DEFINE_MUTEX(core_lock);
>  static DEFINE_IDR(i2c_adapter_idr);
> =20
> -static struct device_type i2c_client_type;
>  static int i2c_detect(struct i2c_adapter *adapter, struct i2c_driver *dr=
iver);
> =20
>  static struct static_key i2c_trace_msg =3D STATIC_KEY_INIT_FALSE;
> @@ -1096,11 +1095,12 @@ struct bus_type i2c_bus_type =3D {
>  };
>  EXPORT_SYMBOL_GPL(i2c_bus_type);
> =20
> -static struct device_type i2c_client_type =3D {
> +struct device_type i2c_client_type =3D {
>  	.groups		=3D i2c_dev_groups,
>  	.uevent		=3D i2c_device_uevent,
>  	.release	=3D i2c_client_dev_release,
>  };
> +EXPORT_SYMBOL_GPL(i2c_client_type);
> =20
> =20
>  /**
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 2cc3988d127b..89ca5e56b433 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -37,6 +37,7 @@
> =20
>  extern struct bus_type i2c_bus_type;
>  extern struct device_type i2c_adapter_type;
> +extern struct device_type i2c_client_type;
> =20
>  /* --- General options ------------------------------------------------	=
*/
> =20
> --=20
> 2.12.0.246.ga2ecc84866-goog
>=20

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYweFuAAoJEBQN5MwUoCm2rK4P/2jTjDnQgVS9jOvqqEUgyCWI
pr7wZSBlXojEr9+blmGmX7tqR8ER7ztXCldEArHmt71Tbui7S2UMQmekVL8jT8lu
91wrbI97MMfFX/IlJB4ZHuaaE/04+plPfyJbcSYE5zX0n7HQGjmainPR56jsrUoE
FKyxFRXVf5fOdaCS2JZ+J73W2sSx+X9y5Bc6yljDAhKUQxNUsguKNR/K18qgrSTA
mMCS+INAHbpz+pFtctCNG47/pa8IKSB+sjxHE97ATZAyfKiP8MxZmt1H9CkKjVsk
0MQ0Aboj/cndmCtQK59FyZyaLikc9BrCLitRWjKM1rE45i5uiaUVZz0nq4eQAgVU
pQ7vLLb8dYdMoTqLxJe37UPtfFtbqKHDZAcif9Yz2a0CtEhjcbJtzPfymO64CoKn
vE4mh7nWzXHcb6PFvedUcLeDOnlm2MftrBEcD93cROVPDV83c+/arWCaWCn4Rn49
+kZ4MpN3FTX9XWGtVJfJ1F3HURXDHjcRTresBwcr9HwF8/0nY4IAEXsp5O03Qqh6
D+iObZq8b8MHD1phsf6+mXt1S6VDi/t1383sxX+6AT4mxccMzhgUT8IeaXKn4cgo
zIiF0l58o8wx9QoLDwryQqZBH4VEqVEkaZhUW/qjLzhZfcTgYf2FSrKdMyWqfC4W
fazuvSJ3CZDpXvNqfkIK
=c9yj
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
