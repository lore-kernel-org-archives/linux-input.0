From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH] Input: Adding 2 bytes ahead of the input report which
 describes the length of the packet meeting HID-over-I2C spec
Date: Thu, 9 Jun 2016 14:44:55 -0700
Message-ID: <e0a1b792-de63-f687-b08b-1f1ea2dc425d@gmail.com>
References: <1465458818-14104-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36846 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705AbcFIVpE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jun 2016 17:45:04 -0400
Received: by mail-pf0-f194.google.com with SMTP id 62so3582618pfd.3
        for <linux-input@vger.kernel.org>; Thu, 09 Jun 2016 14:45:03 -0700 (PDT)
In-Reply-To: <1465458818-14104-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tatsunosuke Tobita <junkpainting@gmail.com>, Linux Input <linux-input@vger.kernel.org>
Cc: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Ping Cheng <pinglinux@gmail.com>

On 06/09/2016 12:53 AM, Tatsunosuke Tobita wrote:
> HID-over-I2C requires data at the first two bytes for describing
> the input report length, but the current wacom.ko doesn't have
> such space and this makes the input outcome messed.
> Also, another report ID for Wacom AES type device is defined.
>=20
> Signed-off-by: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
> ---

I must admit I'm confused by this patch...

=46irstly, I2C devices should be using the HID_GENERIC codepath, but no=
ne
of the changes here are to that codepath, so I don't see how this would
fix anything. Secondly, the HID subsystem itself should already be
taking into account the two byte header for I2C devices (see the
i2c_hid_get_input function in  drivers/hid/i2c-hid/i2c-hid.c); at least=
,
I haven't seen any strange behavior with the I2C devices I've used with
wacom.ko...

Jason
---
Now instead of four in the eights place /
you=92ve got three, =91Cause you added one /
(That is to say, eight) to the two, /
But you can=92t take seven from three, /
So you look at the sixty-fours....


>  drivers/hid/wacom_sys.c |  6 +++++-
>  drivers/hid/wacom_wac.c | 28 ++++++++++++++++------------
>  drivers/hid/wacom_wac.h |  2 ++
>  3 files changed, 23 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 499cc82..95be318 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -1886,7 +1886,11 @@ static int wacom_probe(struct hid_device *hdev=
,
>  			hid_warn(hdev,
>  				 "can't create sysfs speed attribute err: %d\n",
>  				 error);
> -	}
> +
> +	/*HID Over I2C spec requires 2 bytes at the head of*/
> +	/*Input report for length description*/
> +	} else if (hdev->bus =3D=3D BUS_I2C)
> +		wacom_wac->data_head =3D 2;
> =20
>  	return 0;
> =20
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 1eae13c..c352d40 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1229,8 +1229,9 @@ static int wacom_mt_touch(struct wacom_wac *wac=
om)
>  {
>  	struct input_dev *input =3D wacom->touch_input;
>  	unsigned char *data =3D wacom->data;
> +	unsigned char data_head =3D wacom->data_head;
>  	int i;
> -	int current_num_contacts =3D data[2];
> +	int current_num_contacts =3D data[data_head + 2];
>  	int contacts_to_send =3D 0;
>  	int x_offset =3D 0;
> =20
> @@ -1249,7 +1250,8 @@ static int wacom_mt_touch(struct wacom_wac *wac=
om)
>  	contacts_to_send =3D min(5, wacom->num_contacts_left);
> =20
>  	for (i =3D 0; i < contacts_to_send; i++) {
> -		int offset =3D (WACOM_BYTES_PER_MT_PACKET + x_offset) * i + 3;
> +		int offset =3D (WACOM_BYTES_PER_MT_PACKET
> +				+ x_offset) * (data_head + i) + 3;
>  		bool touch =3D (data[offset] & 0x1) && !wacom->shared->stylus_in_p=
roximity;
>  		int id =3D get_unaligned_le16(&data[offset + 1]);
>  		int slot =3D input_mt_get_slot_by_key(input, id);
> @@ -1343,25 +1344,31 @@ static int wacom_tpc_single_touch(struct waco=
m_wac *wacom, size_t len)
>  static int wacom_tpc_pen(struct wacom_wac *wacom)
>  {
>  	unsigned char *data =3D wacom->data;
> +	unsigned char data_head =3D wacom->data_head;
>  	struct input_dev *input =3D wacom->pen_input;
> -	bool prox =3D data[1] & 0x20;
> +	bool prox =3D data[data_head + 1] & 0x20;
> =20
>  	if (!wacom->shared->stylus_in_proximity) /* first in prox */
>  		/* Going into proximity select tool */
> -		wacom->tool[0] =3D (data[1] & 0x0c) ? BTN_TOOL_RUBBER : BTN_TOOL_P=
EN;
> +		wacom->tool[data_head]
> +		=3D (data[data_head + 1] & 0x0c) ? BTN_TOOL_RUBBER : BTN_TOOL_PEN;
> =20
>  	/* keep pen state for touch events */
>  	wacom->shared->stylus_in_proximity =3D prox;
> =20
>  	/* send pen events only when touch is up or forced out */
>  	if (!wacom->shared->touch_down) {
> -		input_report_key(input, BTN_STYLUS, data[1] & 0x02);
> -		input_report_key(input, BTN_STYLUS2, data[1] & 0x10);
> -		input_report_abs(input, ABS_X, le16_to_cpup((__le16 *)&data[2]));
> -		input_report_abs(input, ABS_Y, le16_to_cpup((__le16 *)&data[4]));
> -		input_report_abs(input, ABS_PRESSURE, ((data[7] & 0x07) << 8) | da=
ta[6]);
> -		input_report_key(input, BTN_TOUCH, data[1] & 0x05);
> -		input_report_key(input, wacom->tool[0], prox);
> +		input_report_key(input, BTN_STYLUS, data[data_head + 1] & 0x02);
> +		input_report_key(input, BTN_STYLUS2,
> +					data[data_head + 1] & 0x10);
> +		input_report_abs(input, ABS_X,
> +					le16_to_cpup((__le16 *)&data[data_head + 2]));
> +		input_report_abs(input, ABS_Y,
> +					le16_to_cpup((__le16 *)&data[data_head + 4]));
> +		input_report_abs(input, ABS_PRESSURE, ((data[data_head + 7]
> +					& 0x07) << 8) | data[data_head + 6]);
> +		input_report_key(input, BTN_TOUCH, data[data_head + 1] & 0x05);
> +		input_report_key(input, wacom->tool[data_head], prox);
>  		return 1;
>  	}
> =20
> @@ -1371,6 +1373,7 @@ static int wacom_tpc_pen(struct wacom_wac *waco=
m)
>  static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
>  {
>  	unsigned char *data =3D wacom->data;
> +	unsigned char data_head =3D wacom->data_head;
> =20
>  	if (wacom->pen_input)
>  		dev_dbg(wacom->pen_input->dev.parent,
> @@ -1390,7 +1393,7 @@ static int wacom_tpc_irq(struct wacom_wac *waco=
m, size_t len)
>  		return wacom_tpc_pen(wacom);
> =20
>  	default:
> -		switch (data[0]) {
> +		switch (data[data_head]) {
>  		case WACOM_REPORT_TPC1FG:
>  		case WACOM_REPORT_TPCHID:
>  		case WACOM_REPORT_TPCST:
> @@ -1399,6 +1402,7 @@ static int wacom_tpc_irq(struct wacom_wac *waco=
m, size_t len)
> =20
>  		case WACOM_REPORT_TPCMT:
>  		case WACOM_REPORT_TPCMT2:
> +		case WACOM_REPORT_TPCMTHID:
>  			return wacom_mt_touch(wacom);
> =20
>  		case WACOM_REPORT_PENABLED:
> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
> index 53d1653..c992c2c 100644
> --- a/drivers/hid/wacom_wac.h
> +++ b/drivers/hid/wacom_wac.h
> @@ -71,6 +71,7 @@
>  #define WACOM_REPORT_INTUOS_PEN		16
>  #define WACOM_REPORT_REMOTE		17
>  #define WACOM_REPORT_INTUOSHT2_ID	8
> +#define WACOM_REPORT_TPCMTHID           12
> =20
>  /* device quirks */
>  #define WACOM_QUIRK_BBTOUCH_LOWRES	0x0001
> @@ -248,6 +249,7 @@ struct wacom_wac {
>  	int mode_report;
>  	int mode_value;
>  	struct hid_data hid_data;
> +	unsigned char data_head;
>  };
> =20
>  #endif
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
