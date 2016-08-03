From: Vlad Glagolev <stealth@vaygr.net>
Subject: Re: Fix tuchpad wakeup on ASUS laptops (was [PATCH] Input:
 /input/mouse/elan_i2c_core.c)
Date: Tue, 2 Aug 2016 21:46:09 -0400
Message-ID: <20160802214609.319d6e588652339f672d149b@vaygr.net>
References: <1468416629-4615-1-git-send-email-kt.liao@emc.com.tw>
	<20160713192247.GB10821@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__2_Aug_2016_21_46_10_-0400_8jeA5GfjYXLl3Y_j"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bonobo.tulip.relay.mailchannels.net ([23.83.218.22]:5523 "EHLO
	bonobo.tulip.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750954AbcHCCDU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Aug 2016 22:03:20 -0400
In-Reply-To: <20160713192247.GB10821@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: KT Liao <ktalex.liao@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, phoenix@emc.com.tw, kt.liao@emc.com.tw, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jonathan Gradstein <jgradstein@gmail.com>, Chris Chiu <chiu@endlessm.com>

--Signature=_Tue__2_Aug_2016_21_46_10_-0400_8jeA5GfjYXLl3Y_j
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Dmitry!

Thanks, I've been testing it for 2+ weeks. Works like a charm so far.

On Wed, 13 Jul 2016 12:22:47 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> [ Resending to actually CC people I asked to try the patch ]
>=20
> On Wed, Jul 13, 2016 at 09:30:29PM +0800, KT Liao wrote:
> > Fix some Asus touchapod which casue TP no funciton sometimes, the patch=
 detect some specific touchpad and run a special initialize
> >=20
> > Signed-off-by: KT Liao <kt.liao@emc.com.tw>
> > ---
> >  drivers/input/mouse/elan_i2c_core.c | 93 ++++++++++++++++++++++++++++-=
--------
> >  1 file changed, 71 insertions(+), 22 deletions(-)
> >=20
> > diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/=
elan_i2c_core.c
> > index 2f58985..36a69d2 100644
> > --- a/drivers/input/mouse/elan_i2c_core.c
> > +++ b/drivers/input/mouse/elan_i2c_core.c
> > @@ -3,8 +3,8 @@
> >   *
> >   * Copyright (c) 2013 ELAN Microelectronics Corp.
> >   *
> > - * Author: =E6=9E=97=E6=94=BF=E7=B6=AD (Duson Lin) <dusonlin@emc.com.t=
w>
>=20
> Let's not remove Duson's name, he did quite a bit of work on the driver.
>=20
> > - * Version: 1.6.0
> > + * Author: KT Liao <kt.liao@emc.com.tw>
> > + * Version: 1.6.2
> >   *
> >   * Based on cyapa driver:
> >   * copyright (c) 2011-2012 Cypress Semiconductor, Inc.
> > @@ -40,7 +40,7 @@
> >  #include "elan_i2c.h"
> > =20
> >  #define DRIVER_NAME		"elan_i2c"
> > -#define ELAN_DRIVER_VERSION	"1.6.1"
> > +#define ELAN_DRIVER_VERSION	"1.6.2"
> >  #define ELAN_VENDOR_ID		0x04f3
> >  #define ETP_MAX_PRESSURE	255
> >  #define ETP_FWIDTH_REDUCE	90
> > @@ -95,6 +95,8 @@ struct elan_tp_data {
> >  	bool			baseline_ready;
> >  };
> > =20
> > +static int check_ASUS_special_fw(struct elan_tp_data *data);
> > +
> >  static int elan_get_fwinfo(u8 iap_version, u16 *validpage_count,
> >  			   u16 *signature_address)
> >  {
> > @@ -210,21 +212,40 @@ static int __elan_initialize(struct elan_tp_data =
*data)
> >  		return error;
> >  	}
> > =20
> > -	data->mode |=3D ETP_ENABLE_ABS;
> > -	error =3D data->ops->set_mode(client, data->mode);
> > -	if (error) {
> > -		dev_err(&client->dev,
> > -			"failed to switch to absolute mode: %d\n", error);
> > -		return error;
> > -	}
> > +	/* If it's the special FW, it need a different flow for mode change.*/
> > +	if (check_ASUS_special_fw(data)) {
> > +		error =3D data->ops->sleep_control(client, false);
> > +		if (error) {
> > +			dev_err(&client->dev,
> > +				"failed to wake device up: %d\n", error);
> > +			return error;
> > +		}
> > =20
> > -	error =3D data->ops->sleep_control(client, false);
> > -	if (error) {
> > -		dev_err(&client->dev,
> > -			"failed to wake device up: %d\n", error);
> > -		return error;
> > -	}
> > +		msleep(200);
> > =20
> > +		data->mode |=3D ETP_ENABLE_ABS;
> > +		error =3D data->ops->set_mode(client, data->mode);
> > +		if (error) {
> > +			dev_err(&client->dev,
> > +				"failed to switch to absolute mode: %d\n", error);
> > +			return error;
> > +		}
> > +	} else {
> > +		data->mode |=3D ETP_ENABLE_ABS;
> > +		error =3D data->ops->set_mode(client, data->mode);
> > +		if (error) {
> > +			dev_err(&client->dev,
> > +				"failed to switch to absolute mode: %d\n", error);
> > +			return error;
> > +		}
> > +
> > +		error =3D data->ops->sleep_control(client, false);
> > +		if (error) {
> > +			dev_err(&client->dev,
> > +				"failed to wake device up: %d\n", error);
> > +			return error;
> > +		}
> > +	}
> >  	return 0;
> >  }
> > =20
> > @@ -244,7 +265,7 @@ static int elan_initialize(struct elan_tp_data *dat=
a)
> >  	return error;
> >  }
> > =20
> > -static int elan_query_device_info(struct elan_tp_data *data)
> > +static int elan_query_device_pid_smver(struct elan_tp_data *data)
> >  {
> >  	int error;
> > =20
> > @@ -252,17 +273,24 @@ static int elan_query_device_info(struct elan_tp_=
data *data)
> >  	if (error)
> >  		return error;
> > =20
> > -	error =3D data->ops->get_version(data->client, false, &data->fw_versi=
on);
> > +	error =3D data->ops->get_sm_version(data->client, &data->ic_type,
> > +					  &data->sm_version);
> >  	if (error)
> >  		return error;
> > =20
> > -	error =3D data->ops->get_checksum(data->client, false,
> > -					&data->fw_checksum);
> > +	return 0;
> > +}
> > +
> > +static int elan_query_device_info(struct elan_tp_data *data)
> > +{
> > +	int error;
> > +
> > +	error =3D data->ops->get_version(data->client, false, &data->fw_versi=
on);
> >  	if (error)
> >  		return error;
> > =20
> > -	error =3D data->ops->get_sm_version(data->client, &data->ic_type,
> > -					  &data->sm_version);
> > +	error =3D data->ops->get_checksum(data->client, false,
> > +					&data->fw_checksum);
> >  	if (error)
> >  		return error;
> > =20
> > @@ -419,6 +447,7 @@ static int elan_update_firmware(struct elan_tp_data=
 *data,
> >  		data->ops->iap_reset(client);
> >  	} else {
> >  		/* Reinitialize TP after fw is updated */
> > +		elan_query_device_pid_smver(data);
> >  		elan_initialize(data);
> >  		elan_query_device_info(data);
> >  	}
> > @@ -757,6 +786,22 @@ out:
> >  	return retval;
> >  }
> > =20
> > +static int check_ASUS_special_fw(struct elan_tp_data *data)
> > +{
> > +	if (data->ic_type !=3D 0x0E)
> > +		return false;
> > +
> > +	switch (data->product_id) {
> > +	case 0x05:
> > +	case 0x06:
> > +	case 0x07:
> > +	case 0x09:
> > +	case 0x013:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > =20
> >  static DEVICE_ATTR_WO(acquire);
> >  static DEVICE_ATTR_RO(min);
> > @@ -1033,6 +1078,10 @@ static int elan_probe(struct i2c_client *client,
> >  		return error;
> >  	}
> > =20
> > +	error =3D elan_query_device_pid_smver(data);
> > +	if (error)
> > +		return error;
>=20
> The original code was fetching product ID and IC type after calling the
> transport "initialize" function; I'd prefer if we kept this order.
>=20
> Could you tell me if the following version of the patch looks OK to you?
>=20
> Vlad, Chris, Jonathan, could you please tell me if this version of the
> patch fixes your touchpad issue?
>=20
> Thanks!
>=20
> --=20
> Dmitry
>=20
>=20
> Input: elan_i2c - properly wake up touchpad on ASUS laptops
>=20
> From: KT Liao <kt.liao@emc.com.tw>
>=20
> Some ASUS laptops were shipped with touchpads that require to be woken up
> first, before trying to switch them into absolute reporting mode, otherwi=
se
> touchpad would fail to work while flooding the logs with:
>=20
> 	elan_i2c i2c-ELAN1000:00: invalid report id data (1)
>=20
> Among affected devices are Asus E202SA, N552VW, X456UF, UX305CA, and
> others. We detect such devices by checking the IC type and product ID
> numbers and adjusting order of operations accordingly.
>=20
> Signed-off-by: KT Liao <kt.liao@emc.com.tw>
> Reported-by: Chris Chiu <chiu@endlessm.com>
> Reported-by: Vlad Glagolev <stealth@vaygr.net>
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/mouse/elan_i2c_core.c |   79 ++++++++++++++++++++++++++++-=
------
>  1 file changed, 63 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/el=
an_i2c_core.c
> index 2f58985..d15b338 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -4,7 +4,8 @@
>   * Copyright (c) 2013 ELAN Microelectronics Corp.
>   *
>   * Author: =E6=9E=97=E6=94=BF=E7=B6=AD (Duson Lin) <dusonlin@emc.com.tw>
> - * Version: 1.6.0
> + * Author: KT Liao <kt.liao@emc.com.tw>
> + * Version: 1.6.2
>   *
>   * Based on cyapa driver:
>   * copyright (c) 2011-2012 Cypress Semiconductor, Inc.
> @@ -40,7 +41,7 @@
>  #include "elan_i2c.h"
> =20
>  #define DRIVER_NAME		"elan_i2c"
> -#define ELAN_DRIVER_VERSION	"1.6.1"
> +#define ELAN_DRIVER_VERSION	"1.6.2"
>  #define ELAN_VENDOR_ID		0x04f3
>  #define ETP_MAX_PRESSURE	255
>  #define ETP_FWIDTH_REDUCE	90
> @@ -199,9 +200,41 @@ static int elan_sleep(struct elan_tp_data *data)
>  	return error;
>  }
> =20
> +static int elan_query_product(struct elan_tp_data *data)
> +{
> +	int error;
> +
> +	error =3D data->ops->get_product_id(data->client, &data->product_id);
> +	if (error)
> +		return error;
> +
> +	error =3D data->ops->get_sm_version(data->client, &data->ic_type,
> +					  &data->sm_version);
> +	if (error)
> +		return error;
> +
> +	return 0;
> +}
> +
> +static int elan_check_ASUS_special_fw(struct elan_tp_data *data)
> +{
> +	if (data->ic_type !=3D 0x0E)
> +		return false;
> +
> +	switch (data->product_id) {
> +	case 0x05 ... 0x07:
> +	case 0x09:
> +	case 0x13:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  static int __elan_initialize(struct elan_tp_data *data)
>  {
>  	struct i2c_client *client =3D data->client;
> +	bool woken_up =3D false;
>  	int error;
> =20
>  	error =3D data->ops->initialize(client);
> @@ -210,6 +243,27 @@ static int __elan_initialize(struct elan_tp_data *da=
ta)
>  		return error;
>  	}
> =20
> +	error =3D elan_query_product(data);
> +	if (error)
> +		return error;
> +
> +	/*
> +	 * Some ASUS devices were shipped with firmware that requires
> +	 * touchpads to be woken up first, before attempting to switch
> +	 * them into absolute reporting mode.
> +	 */
> +	if (elan_check_ASUS_special_fw(data)) {
> +		error =3D data->ops->sleep_control(client, false);
> +		if (error) {
> +			dev_err(&client->dev,
> +				"failed to wake device up: %d\n", error);
> +			return error;
> +		}
> +
> +		msleep(200);
> +		woken_up =3D true;
> +	}
> +
>  	data->mode |=3D ETP_ENABLE_ABS;
>  	error =3D data->ops->set_mode(client, data->mode);
>  	if (error) {
> @@ -218,11 +272,13 @@ static int __elan_initialize(struct elan_tp_data *d=
ata)
>  		return error;
>  	}
> =20
> -	error =3D data->ops->sleep_control(client, false);
> -	if (error) {
> -		dev_err(&client->dev,
> -			"failed to wake device up: %d\n", error);
> -		return error;
> +	if (!woken_up) {
> +		error =3D data->ops->sleep_control(client, false);
> +		if (error) {
> +			dev_err(&client->dev,
> +				"failed to wake device up: %d\n", error);
> +			return error;
> +		}
>  	}
> =20
>  	return 0;
> @@ -248,10 +304,6 @@ static int elan_query_device_info(struct elan_tp_dat=
a *data)
>  {
>  	int error;
> =20
> -	error =3D data->ops->get_product_id(data->client, &data->product_id);
> -	if (error)
> -		return error;
> -
>  	error =3D data->ops->get_version(data->client, false, &data->fw_version=
);
>  	if (error)
>  		return error;
> @@ -261,11 +313,6 @@ static int elan_query_device_info(struct elan_tp_dat=
a *data)
>  	if (error)
>  		return error;
> =20
> -	error =3D data->ops->get_sm_version(data->client, &data->ic_type,
> -					  &data->sm_version);
> -	if (error)
> -		return error;
> -
>  	error =3D data->ops->get_version(data->client, true, &data->iap_version=
);
>  	if (error)
>  		return error;


--
Vlad Glagolev <stealth@vaygr.net>

--Signature=_Tue__2_Aug_2016_21_46_10_-0400_8jeA5GfjYXLl3Y_j
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Signed from node - Baserunner

iQIcBAEBAgAGBQJXoUziAAoJEKmAtRJWLDIl4SQQAKmYn+V89RKWG9Qp7vQe7gWi
01DrZsJspXspYhSkuhFhFzLL/FN3ilDTavPMGUa06ckWjd6VFIaSfKr1D1JUTOJg
QhOVUzs6LwWf+tl2nshZZMf6twCPyIGdYUfsvSVlyaG1i/WFUR7+e5OwS42LR2Om
JblPQAYXcT+vZYB7zBXISGI0bSL4y6a/5TaIrl40SNVbAH5uwG3HFVf6N7+CoX1C
2HYyJpM45CjvvcCDyo+I0vmhQm7dFM++U+zw7qd6OMYNjKrt1Hllh7hKbY2gpQ1A
idqFdKTe1sSRpTMmeAKME4Tcj5Nt7TweAK4bPUGXinVqgRmOY7J+uyhNrd0glGKn
/L+rtCU33SyXTMHGL8wPJ6GIMz4qRneVa42wB39Nsv6ICqK5abZax1Mwkm2NNfRU
pxrd2EQRX3iEX4+QrXKXrK0t1WMLdIsYtYlP62e6FwVIPWbhNzQcl+HWt7Nf0DSQ
By03NETGx7WTKaYMwjHE0rOG4/2kDKdWUZVyEaAmR7SiBcjcVJrpGaEHqoQNzGG3
ZZ1XJkGt3OeouipUEsvoMDSFsoKwfHqPyLNlS8/fO2EXBV6+3UnyVT7mzYghn6aD
YboaZ479R3j2M4Rcr+dmofcqbrLk74pNNDqhRN4lnzTOqauKyChEeIOEqoxOTM+D
elckKydm6sZNuiv37q/o
=qqeV
-----END PGP SIGNATURE-----

--Signature=_Tue__2_Aug_2016_21_46_10_-0400_8jeA5GfjYXLl3Y_j--
