From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: /input/mouse/elan_i2c_core.c
Date: Wed, 13 Jul 2016 12:08:14 -0700
Message-ID: <20160713190814.GA10821@dtor-ws>
References: <1468416629-4615-1-git-send-email-kt.liao@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36254 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbcGMTIY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jul 2016 15:08:24 -0400
Content-Disposition: inline
In-Reply-To: <1468416629-4615-1-git-send-email-kt.liao@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: KT Liao <ktalex.liao@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, phoenix@emc.com.tw, kt.liao@emc.com.tw, Benjamin Tissoires <benjamin.tissoires@gmail.com>

On Wed, Jul 13, 2016 at 09:30:29PM +0800, KT Liao wrote:
> Fix some Asus touchapod which casue TP no funciton sometimes, the pat=
ch detect some specific touchpad and run a special initialize
>=20
> Signed-off-by: KT Liao <kt.liao@emc.com.tw>
> ---
>  drivers/input/mouse/elan_i2c_core.c | 93 +++++++++++++++++++++++++++=
+---------
>  1 file changed, 71 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mous=
e/elan_i2c_core.c
> index 2f58985..36a69d2 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -3,8 +3,8 @@
>   *
>   * Copyright (c) 2013 ELAN Microelectronics Corp.
>   *
> - * Author: =E6=9E=97=E6=94=BF=E7=B6=AD (Duson Lin) <dusonlin@emc.com=
=2Etw>

Let's not remove Duson's name, he did quite a bit of work on the driver=
=2E

> - * Version: 1.6.0
> + * Author: KT Liao <kt.liao@emc.com.tw>
> + * Version: 1.6.2
>   *
>   * Based on cyapa driver:
>   * copyright (c) 2011-2012 Cypress Semiconductor, Inc.
> @@ -40,7 +40,7 @@
>  #include "elan_i2c.h"
> =20
>  #define DRIVER_NAME		"elan_i2c"
> -#define ELAN_DRIVER_VERSION	"1.6.1"
> +#define ELAN_DRIVER_VERSION	"1.6.2"
>  #define ELAN_VENDOR_ID		0x04f3
>  #define ETP_MAX_PRESSURE	255
>  #define ETP_FWIDTH_REDUCE	90
> @@ -95,6 +95,8 @@ struct elan_tp_data {
>  	bool			baseline_ready;
>  };
> =20
> +static int check_ASUS_special_fw(struct elan_tp_data *data);
> +
>  static int elan_get_fwinfo(u8 iap_version, u16 *validpage_count,
>  			   u16 *signature_address)
>  {
> @@ -210,21 +212,40 @@ static int __elan_initialize(struct elan_tp_dat=
a *data)
>  		return error;
>  	}
> =20
> -	data->mode |=3D ETP_ENABLE_ABS;
> -	error =3D data->ops->set_mode(client, data->mode);
> -	if (error) {
> -		dev_err(&client->dev,
> -			"failed to switch to absolute mode: %d\n", error);
> -		return error;
> -	}
> +	/* If it's the special FW, it need a different flow for mode change=
=2E*/
> +	if (check_ASUS_special_fw(data)) {
> +		error =3D data->ops->sleep_control(client, false);
> +		if (error) {
> +			dev_err(&client->dev,
> +				"failed to wake device up: %d\n", error);
> +			return error;
> +		}
> =20
> -	error =3D data->ops->sleep_control(client, false);
> -	if (error) {
> -		dev_err(&client->dev,
> -			"failed to wake device up: %d\n", error);
> -		return error;
> -	}
> +		msleep(200);
> =20
> +		data->mode |=3D ETP_ENABLE_ABS;
> +		error =3D data->ops->set_mode(client, data->mode);
> +		if (error) {
> +			dev_err(&client->dev,
> +				"failed to switch to absolute mode: %d\n", error);
> +			return error;
> +		}
> +	} else {
> +		data->mode |=3D ETP_ENABLE_ABS;
> +		error =3D data->ops->set_mode(client, data->mode);
> +		if (error) {
> +			dev_err(&client->dev,
> +				"failed to switch to absolute mode: %d\n", error);
> +			return error;
> +		}
> +
> +		error =3D data->ops->sleep_control(client, false);
> +		if (error) {
> +			dev_err(&client->dev,
> +				"failed to wake device up: %d\n", error);
> +			return error;
> +		}
> +	}
>  	return 0;
>  }
> =20
> @@ -244,7 +265,7 @@ static int elan_initialize(struct elan_tp_data *d=
ata)
>  	return error;
>  }
> =20
> -static int elan_query_device_info(struct elan_tp_data *data)
> +static int elan_query_device_pid_smver(struct elan_tp_data *data)
>  {
>  	int error;
> =20
> @@ -252,17 +273,24 @@ static int elan_query_device_info(struct elan_t=
p_data *data)
>  	if (error)
>  		return error;
> =20
> -	error =3D data->ops->get_version(data->client, false, &data->fw_ver=
sion);
> +	error =3D data->ops->get_sm_version(data->client, &data->ic_type,
> +					  &data->sm_version);
>  	if (error)
>  		return error;
> =20
> -	error =3D data->ops->get_checksum(data->client, false,
> -					&data->fw_checksum);
> +	return 0;
> +}
> +
> +static int elan_query_device_info(struct elan_tp_data *data)
> +{
> +	int error;
> +
> +	error =3D data->ops->get_version(data->client, false, &data->fw_ver=
sion);
>  	if (error)
>  		return error;
> =20
> -	error =3D data->ops->get_sm_version(data->client, &data->ic_type,
> -					  &data->sm_version);
> +	error =3D data->ops->get_checksum(data->client, false,
> +					&data->fw_checksum);
>  	if (error)
>  		return error;
> =20
> @@ -419,6 +447,7 @@ static int elan_update_firmware(struct elan_tp_da=
ta *data,
>  		data->ops->iap_reset(client);
>  	} else {
>  		/* Reinitialize TP after fw is updated */
> +		elan_query_device_pid_smver(data);
>  		elan_initialize(data);
>  		elan_query_device_info(data);
>  	}
> @@ -757,6 +786,22 @@ out:
>  	return retval;
>  }
> =20
> +static int check_ASUS_special_fw(struct elan_tp_data *data)
> +{
> +	if (data->ic_type !=3D 0x0E)
> +		return false;
> +
> +	switch (data->product_id) {
> +	case 0x05:
> +	case 0x06:
> +	case 0x07:
> +	case 0x09:
> +	case 0x013:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> =20
>  static DEVICE_ATTR_WO(acquire);
>  static DEVICE_ATTR_RO(min);
> @@ -1033,6 +1078,10 @@ static int elan_probe(struct i2c_client *clien=
t,
>  		return error;
>  	}
> =20
> +	error =3D elan_query_device_pid_smver(data);
> +	if (error)
> +		return error;

The original code was fetching product ID and IC type after calling the
transport "initialize" function; I'd prefer if we kept this order.

Could you tell me if the following version of the patch looks OK to you=
?

Vlad, Chris, Jonathan, could you please tell me if this version of the
patch fixes your touchpad issue?

Thanks!

--=20
Dmitry


Input: elan_i2c - properly wake up touchpad on ASUS laptops

=46rom: KT Liao <kt.liao@emc.com.tw>

Some ASUS laptops were shipped with touchpads that require to be woken =
up
first, before trying to switch them into absolute reporting mode, other=
wise
touchpad would fail to work while flooding the logs with:

	elan_i2c i2c-ELAN1000:00: invalid report id data (1)

Among affected devices are Asus E202SA, N552VW, X456UF, UX305CA, and
others. We detect such devices by checking the IC type and product ID
numbers and adjusting order of operations accordingly.

Signed-off-by: KT Liao <kt.liao@emc.com.tw>
Reported-by: Chris Chiu <chiu@endlessm.com>
Reported-by: Vlad Glagolev <stealth@vaygr.net>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/elan_i2c_core.c |   79 +++++++++++++++++++++++++++=
+-------
 1 file changed, 63 insertions(+), 16 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/=
elan_i2c_core.c
index 2f58985..d15b338 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -4,7 +4,8 @@
  * Copyright (c) 2013 ELAN Microelectronics Corp.
  *
  * Author: =E6=9E=97=E6=94=BF=E7=B6=AD (Duson Lin) <dusonlin@emc.com.t=
w>
- * Version: 1.6.0
+ * Author: KT Liao <kt.liao@emc.com.tw>
+ * Version: 1.6.2
  *
  * Based on cyapa driver:
  * copyright (c) 2011-2012 Cypress Semiconductor, Inc.
@@ -40,7 +41,7 @@
 #include "elan_i2c.h"
=20
 #define DRIVER_NAME		"elan_i2c"
-#define ELAN_DRIVER_VERSION	"1.6.1"
+#define ELAN_DRIVER_VERSION	"1.6.2"
 #define ELAN_VENDOR_ID		0x04f3
 #define ETP_MAX_PRESSURE	255
 #define ETP_FWIDTH_REDUCE	90
@@ -199,9 +200,41 @@ static int elan_sleep(struct elan_tp_data *data)
 	return error;
 }
=20
+static int elan_query_product(struct elan_tp_data *data)
+{
+	int error;
+
+	error =3D data->ops->get_product_id(data->client, &data->product_id);
+	if (error)
+		return error;
+
+	error =3D data->ops->get_sm_version(data->client, &data->ic_type,
+					  &data->sm_version);
+	if (error)
+		return error;
+
+	return 0;
+}
+
+static int elan_check_ASUS_special_fw(struct elan_tp_data *data)
+{
+	if (data->ic_type !=3D 0x0E)
+		return false;
+
+	switch (data->product_id) {
+	case 0x05 ... 0x07:
+	case 0x09:
+	case 0x13:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int __elan_initialize(struct elan_tp_data *data)
 {
 	struct i2c_client *client =3D data->client;
+	bool woken_up =3D false;
 	int error;
=20
 	error =3D data->ops->initialize(client);
@@ -210,6 +243,27 @@ static int __elan_initialize(struct elan_tp_data *=
data)
 		return error;
 	}
=20
+	error =3D elan_query_product(data);
+	if (error)
+		return error;
+
+	/*
+	 * Some ASUS devices were shipped with firmware that requires
+	 * touchpads to be woken up first, before attempting to switch
+	 * them into absolute reporting mode.
+	 */
+	if (elan_check_ASUS_special_fw(data)) {
+		error =3D data->ops->sleep_control(client, false);
+		if (error) {
+			dev_err(&client->dev,
+				"failed to wake device up: %d\n", error);
+			return error;
+		}
+
+		msleep(200);
+		woken_up =3D true;
+	}
+
 	data->mode |=3D ETP_ENABLE_ABS;
 	error =3D data->ops->set_mode(client, data->mode);
 	if (error) {
@@ -218,11 +272,13 @@ static int __elan_initialize(struct elan_tp_data =
*data)
 		return error;
 	}
=20
-	error =3D data->ops->sleep_control(client, false);
-	if (error) {
-		dev_err(&client->dev,
-			"failed to wake device up: %d\n", error);
-		return error;
+	if (!woken_up) {
+		error =3D data->ops->sleep_control(client, false);
+		if (error) {
+			dev_err(&client->dev,
+				"failed to wake device up: %d\n", error);
+			return error;
+		}
 	}
=20
 	return 0;
@@ -248,10 +304,6 @@ static int elan_query_device_info(struct elan_tp_d=
ata *data)
 {
 	int error;
=20
-	error =3D data->ops->get_product_id(data->client, &data->product_id);
-	if (error)
-		return error;
-
 	error =3D data->ops->get_version(data->client, false, &data->fw_versi=
on);
 	if (error)
 		return error;
@@ -261,11 +313,6 @@ static int elan_query_device_info(struct elan_tp_d=
ata *data)
 	if (error)
 		return error;
=20
-	error =3D data->ops->get_sm_version(data->client, &data->ic_type,
-					  &data->sm_version);
-	if (error)
-		return error;
-
 	error =3D data->ops->get_version(data->client, true, &data->iap_versi=
on);
 	if (error)
 		return error;
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
