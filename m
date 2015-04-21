From: duson <dusonlin@emc.com.tw>
Subject: Re: [PATCH 6/6] Input: elan_i2c - Add hover detection flag
Date: Tue, 21 Apr 2015 08:45:07 +0800
Message-ID: <B2EA2005-9997-4780-9ABA-5083EB8E84CA@emc.com.tw>
References: <E46C75D2-89DF-4483-9225-5817706F6EAC@emc.com.tw>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from elanic.emc.com.tw ([192.72.220.188]:60143 "EHLO
	elanic.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbbDUApo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Apr 2015 20:45:44 -0400
In-Reply-To: <E46C75D2-89DF-4483-9225-5817706F6EAC@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?utf-8?B?6buD5LiW6bWs?= <phoenix@emc.com.tw>

Hi Dmitry,

Is this patch looks good for you?
If you have any advice, please let me know.

----------------------------------------------
Thank you
ELAN Duson
=E2=9C=89 Email: dusonlin@emc.com.tw
----------------------------------------------





> duson <dusonlin@emc.com.tw> =E6=96=BC 2015=E5=B9=B44=E6=9C=8817=E6=97=
=A5 =E4=B8=8A=E5=8D=889:56 =E5=AF=AB=E9=81=93=EF=BC=9A
>=20
> When hover event coming, set ABS_MT_DISTANCE as 1, otherwise clear to=
 0.
>=20
> Signed-off-by: Duson Lin <dusonlin@emc.com.tw>
> ---
> drivers/input/mouse/elan_i2c_core.c |   15 +++++++++++----
> 1 file changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mous=
e/elan_i2c_core.c
> index 6333ba6..da7893f 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -52,6 +52,7 @@
> #define ETP_REPORT_ID_OFFSET	2
> #define ETP_TOUCH_INFO_OFFSET	3
> #define ETP_FINGER_DATA_OFFSET	4
> +#define ETP_HOVER_INFO_OFFSET	30
> #define ETP_MAX_REPORT_LEN	34
>=20
> /* The main device structure */
> @@ -725,7 +726,7 @@ static const struct attribute_group *elan_sysfs_g=
roups[] =3D {
>  */
> static void elan_report_contact(struct elan_tp_data *data,
> 				int contact_num, bool contact_valid,
> -				u8 *finger_data)
> +				bool hover_event, u8 *finger_data)
> {
> 	struct input_dev *input =3D data->input;
> 	unsigned int pos_x, pos_y;
> @@ -769,7 +770,9 @@ static void elan_report_contact(struct elan_tp_da=
ta *data,
> 		input_mt_report_slot_state(input, MT_TOOL_FINGER, true);
> 		input_report_abs(input, ABS_MT_POSITION_X, pos_x);
> 		input_report_abs(input, ABS_MT_POSITION_Y, data->max_y - pos_y);
> -		input_report_abs(input, ABS_MT_PRESSURE, scaled_pressure);
> +		input_report_abs(input, ABS_MT_DISTANCE, hover_event);
> +		input_report_abs(input, ABS_MT_PRESSURE,
> +				 hover_event ? 0 : scaled_pressure);
> 		input_report_abs(input, ABS_TOOL_WIDTH, mk_x);
> 		input_report_abs(input, ABS_MT_TOUCH_MAJOR, major);
> 		input_report_abs(input, ABS_MT_TOUCH_MINOR, minor);
> @@ -785,11 +788,14 @@ static void elan_report_absolute(struct elan_tp=
_data *data, u8 *packet)
> 	u8 *finger_data =3D &packet[ETP_FINGER_DATA_OFFSET];
> 	int i;
> 	u8 tp_info =3D packet[ETP_TOUCH_INFO_OFFSET];
> -	bool contact_valid;
> +	u8 hover_info =3D packet[ETP_HOVER_INFO_OFFSET];
> +	bool contact_valid, hover_event;
>=20
> +	hover_event =3D hover_info & 0x40;
> 	for (i =3D 0; i < ETP_MAX_FINGERS; i++) {
> 		contact_valid =3D tp_info & (1U << (3 + i));
> -		elan_report_contact(data, i, contact_valid, finger_data);
> +		elan_report_contact(data, i, contact_valid, hover_event,
> +				    finger_data);
>=20
> 		if (contact_valid)
> 			finger_data +=3D ETP_FINGER_DATA_LEN;
> @@ -883,6 +889,7 @@ static int elan_setup_input_device(struct elan_tp=
_data *data)
> 			     ETP_FINGER_WIDTH * max_width, 0, 0);
> 	input_set_abs_params(input, ABS_MT_TOUCH_MINOR, 0,
> 			     ETP_FINGER_WIDTH * min_width, 0, 0);
> +	input_set_abs_params(input, ABS_MT_DISTANCE, 0, 1, 0, 0);
>=20
> 	data->input =3D input;
>=20
>=20
>=20
>=20
>=20
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
