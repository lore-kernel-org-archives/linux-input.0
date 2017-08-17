From: =?gb2312?B?wc6z55hz?= <kt.liao@emc.com.tw>
Subject: RE: [PATCH] Input: elan_i2c - Make hardware buttons work properly on Asus ROG G752xx
Date: Thu, 17 Aug 2017 22:38:32 +0800
Message-ID: <003901d31766$80099110$801cb330$@emc.com.tw>
References: <20170816114513.9967-1-maxime.bellenge@gmail.com> <20170816182704.GA25491@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----=_NextPart_000_003A_01D317A9.8E2D9460"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170816182704.GA25491@dtor-ws>
Content-Language: zh-tw
Sender: linux-kernel-owner@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, =?gb2312?B?J01heGltZSBCZWxsZW5nqKYn?= <maxime.bellenge@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?gb2312?B?/FPKwPlpIL2bwO0=?= <phoenix@emc.com.tw>
List-Id: linux-input@vger.kernel.org

This is a multipart message in MIME format.

------=_NextPart_000_003A_01D317A9.8E2D9460
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable



-----Original Message-----
From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]=20
Sent: Thursday, August 17, 2017 2:27 AM
To: Maxime Belleng=A8=A6; KT Liao
Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: elan_i2c - Make hardware buttons work =
properly
on Asus ROG G752xx

On Wed, Aug 16, 2017 at 01:45:13PM +0200, Maxime Belleng=A8=A6 wrote:
> Asus ROG G752xx laptops have hardware buttons. Currently only the left =

> button works if a finger touches the pad which is not very convenient.
>=20
> I couldn't find a clear pattern based on ic type and product id to=20
> determine if the device has hardware buttons or if it is a clickpad as =

> it is vendor dependant. So I chose to base the patch on dmi as I=20
> couldn't find any other laptop based on elan i2c and having hardware=20
> buttons.
>=20

KT, any feedback here?
Basically, I think it's ok to use DMI_MATCH because=20
(1) It's rare to see such kind of platform.
(2) Only one file need to be modified

We have a command to get button type.
I quickly make a patch as attached file but I don't have the platform to
test it now.
It would be great if Maxime can help to try it. Or I will test it and
upstream next week.

thanks

> Signed-off-by: Maxime Belleng=A8=A6 <maxime.bellenge@gmail.com>
> ---
>  drivers/input/mouse/elan_i2c_core.c | 40=20
> ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/input/mouse/elan_i2c_core.c=20
> b/drivers/input/mouse/elan_i2c_core.c
> index 3b616cb7c67f..fa417105898f 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -37,6 +37,7 @@
>  #include <linux/of.h>
>  #include <linux/regulator/consumer.h>  #include <asm/unaligned.h>
> +#include <linux/dmi.h>
> =20
>  #include "elan_i2c.h"
> =20
> @@ -923,6 +924,7 @@ static void elan_report_absolute(struct =
elan_tp_data
*data, u8 *packet)
>  	}
> =20
>  	input_report_key(input, BTN_LEFT, tp_info & 0x01);
> +        input_report_key(input, BTN_RIGHT, tp_info & 0x02);
>  	input_report_abs(input, ABS_DISTANCE, hover_event !=3D 0);
>  	input_mt_report_pointer_emulation(input, true);
>  	input_sync(input);
> @@ -960,6 +962,39 @@ static irqreturn_t elan_isr(int irq, void=20
> *dev_id)  }
> =20
>  /*
> + * Asus ROG G752xx have hardware buttons */ static const struct=20
> + dmi_system_id elan_dmi_has_hw_buttons[] =3D { #if =
defined(CONFIG_DMI)=20
> + && defined(CONFIG_X86)
> + 	{
> + 		.matches =3D {
> + 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> + 			DMI_MATCH(DMI_PRODUCT_NAME, "G752VT"),
> + 		},
> + 	},
> + 	{
> + 		.matches =3D {
> + 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> + 			DMI_MATCH(DMI_PRODUCT_NAME, "G752VS"),
> + 		},
> + 	},
> +        {
> + 		.matches =3D {
> + 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> + 			DMI_MATCH(DMI_PRODUCT_NAME, "G752VY"),
> + 		},
> + 	},
> +        {
> + 		.matches =3D {
> + 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> + 			DMI_MATCH(DMI_PRODUCT_NAME, "G752VL"),
> + 		},
> + 	},
> + #endif
> + 	{ }
> + };
> +
> +/*
>   ******************************************************************
>   * Elan initialization functions
>   ******************************************************************
> @@ -991,7 +1026,10 @@ static int elan_setup_input_device(struct=20
> elan_tp_data *data)
> =20
>  	__set_bit(EV_ABS, input->evbit);
>  	__set_bit(INPUT_PROP_POINTER, input->propbit);
> -	__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
> +        if (dmi_check_system(elan_dmi_has_hw_buttons)) {
> +                __set_bit(BTN_RIGHT, input->keybit);
> +        } else
> +	       __set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
>  	__set_bit(BTN_LEFT, input->keybit);
> =20
>  	/* Set up ST parameters */
> --
> 2.13.5
>=20

--=20
Dmitry

------=_NextPart_000_003A_01D317A9.8E2D9460
Content-Type: application/octet-stream;
	name="0001-Input-elan_i2c-Add-support-for-two-physical-button.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Input-elan_i2c-Add-support-for-two-physical-button.patch"

>From 5182667893b96dbc8bb91808d9582b4d4c45b6ce Mon Sep 17 00:00:00 2001=0A=
From: KT Liao <kt.liao@emc.com.tw>=0A=
Date: Thu, 17 Aug 2017 21:55:45 +0800=0A=
Subject: [PATCH] Input: elan_i2c - Add support for two physical button=0A=
=0A=
Extend infomation accessing to judge and support L/R button-pad=0A=
Signed-off-by: KT Liao <kt.liao@emc.com.tw>=0A=
---=0A=
 drivers/input/mouse/elan_i2c.h       |  2 +-=0A=
 drivers/input/mouse/elan_i2c_core.c  |  9 +++++++--=0A=
 drivers/input/mouse/elan_i2c_i2c.c   | 13 ++++++++++++-=0A=
 drivers/input/mouse/elan_i2c_smbus.c |  4 +++-=0A=
 4 files changed, 23 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/drivers/input/mouse/elan_i2c.h =
b/drivers/input/mouse/elan_i2c.h=0A=
index 61c2024..599544c 100644=0A=
--- a/drivers/input/mouse/elan_i2c.h=0A=
+++ b/drivers/input/mouse/elan_i2c.h=0A=
@@ -58,7 +58,7 @@ struct elan_transport_ops {=0A=
 =0A=
 	int (*get_version)(struct i2c_client *client, bool iap, u8 *version);=0A=
 	int (*get_sm_version)(struct i2c_client *client,=0A=
-			      u16 *ic_type, u8 *version);=0A=
+			      u16 *ic_type, u8 *version, u8 *clickpad);=0A=
 	int (*get_checksum)(struct i2c_client *client, bool iap, u16 *csum);=0A=
 	int (*get_product_id)(struct i2c_client *client, u16 *id);=0A=
 =0A=
diff --git a/drivers/input/mouse/elan_i2c_core.c =
b/drivers/input/mouse/elan_i2c_core.c=0A=
index 0d111322..59baced 100644=0A=
--- a/drivers/input/mouse/elan_i2c_core.c=0A=
+++ b/drivers/input/mouse/elan_i2c_core.c=0A=
@@ -95,6 +95,7 @@ struct elan_tp_data {=0A=
 	u8			min_baseline;=0A=
 	u8			max_baseline;=0A=
 	bool			baseline_ready;=0A=
+	u8			clickpad;=0A=
 };=0A=
 =0A=
 static int elan_get_fwinfo(u16 ic_type, u16 *validpage_count,=0A=
@@ -213,7 +214,7 @@ static int elan_query_product(struct elan_tp_data =
*data)=0A=
 		return error;=0A=
 =0A=
 	error =3D data->ops->get_sm_version(data->client, &data->ic_type,=0A=
-					  &data->sm_version);=0A=
+					  &data->sm_version, &data->clickpad);=0A=
 	if (error)=0A=
 		return error;=0A=
 =0A=
@@ -923,6 +924,7 @@ static void elan_report_absolute(struct elan_tp_data =
*data, u8 *packet)=0A=
 	}=0A=
 =0A=
 	input_report_key(input, BTN_LEFT, tp_info & 0x01);=0A=
+	input_report_key(input, BTN_RIGHT, tp_info & 0x02);=0A=
 	input_report_abs(input, ABS_DISTANCE, hover_event !=3D 0);=0A=
 	input_mt_report_pointer_emulation(input, true);=0A=
 	input_sync(input);=0A=
@@ -991,7 +993,10 @@ static int elan_setup_input_device(struct =
elan_tp_data *data)=0A=
 =0A=
 	__set_bit(EV_ABS, input->evbit);=0A=
 	__set_bit(INPUT_PROP_POINTER, input->propbit);=0A=
-	__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);=0A=
+	if (data->clickpad)=0A=
+		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);=0A=
+	else=0A=
+		__set_bit(BTN_RIGHT, input->keybit);=0A=
 	__set_bit(BTN_LEFT, input->keybit);=0A=
 =0A=
 	/* Set up ST parameters */=0A=
diff --git a/drivers/input/mouse/elan_i2c_i2c.c =
b/drivers/input/mouse/elan_i2c_i2c.c=0A=
index 80172f2..15b1330 100644=0A=
--- a/drivers/input/mouse/elan_i2c_i2c.c=0A=
+++ b/drivers/input/mouse/elan_i2c_i2c.c=0A=
@@ -288,7 +288,8 @@ static int elan_i2c_get_version(struct i2c_client =
*client,=0A=
 }=0A=
 =0A=
 static int elan_i2c_get_sm_version(struct i2c_client *client,=0A=
-				   u16 *ic_type, u8 *version)=0A=
+				   u16 *ic_type, u8 *version,=0A=
+				   u8 *clickpad)=0A=
 {=0A=
 	int error;=0A=
 	u8 pattern_ver;=0A=
@@ -317,6 +318,7 @@ static int elan_i2c_get_sm_version(struct i2c_client =
*client,=0A=
 			return error;=0A=
 		}=0A=
 		*version =3D val[1];=0A=
+		*clickpad =3D val[0] & 0x10;=0A=
 	} else {=0A=
 		error =3D elan_i2c_read_cmd(client, ETP_I2C_OSM_VERSION_CMD, val);=0A=
 		if (error) {=0A=
@@ -326,6 +328,15 @@ static int elan_i2c_get_sm_version(struct =
i2c_client *client,=0A=
 		}=0A=
 		*version =3D val[0];=0A=
 		*ic_type =3D val[1];=0A=
+=0A=
+		error =3D elan_i2c_read_cmd(client, ETP_I2C_NSM_VERSION_CMD,=0A=
+					  val);=0A=
+		if (error) {=0A=
+			dev_err(&client->dev, "failed to get SM version: %d\n",=0A=
+				error);=0A=
+			return error;=0A=
+		}=0A=
+		*clickpad =3D val[0] & 0x10;=0A=
 	}=0A=
 =0A=
 	return 0;=0A=
diff --git a/drivers/input/mouse/elan_i2c_smbus.c =
b/drivers/input/mouse/elan_i2c_smbus.c=0A=
index df7a57c..29f9952 100644=0A=
--- a/drivers/input/mouse/elan_i2c_smbus.c=0A=
+++ b/drivers/input/mouse/elan_i2c_smbus.c=0A=
@@ -166,7 +166,8 @@ static int elan_smbus_get_version(struct i2c_client =
*client,=0A=
 }=0A=
 =0A=
 static int elan_smbus_get_sm_version(struct i2c_client *client,=0A=
-				     u16 *ic_type, u8 *version)=0A=
+				     u16 *ic_type, u8 *version,=0A=
+				     u8 *clickpad)=0A=
 {=0A=
 	int error;=0A=
 	u8 val[3];=0A=
@@ -180,6 +181,7 @@ static int elan_smbus_get_sm_version(struct =
i2c_client *client,=0A=
 =0A=
 	*version =3D val[0];=0A=
 	*ic_type =3D val[1];=0A=
+	*clickpad =3D val[0] & 0x10;=0A=
 	return 0;=0A=
 }=0A=
 =0A=
-- =0A=
2.7.4=0A=
=0A=

------=_NextPart_000_003A_01D317A9.8E2D9460--
