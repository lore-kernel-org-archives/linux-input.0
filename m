From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 2/4] HID: wacom: move all quirks to wacom_setup_device_quirks
Date: Thu, 16 Apr 2015 16:52:56 -0700
Message-ID: <55304B58.2030800@gmail.com>
References: <1429142034-16832-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33878 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbbDPXw7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Apr 2015 19:52:59 -0400
Received: by pacyx8 with SMTP id yx8so105930836pac.1
        for <linux-input@vger.kernel.org>; Thu, 16 Apr 2015 16:52:59 -0700 (PDT)
In-Reply-To: <1429142034-16832-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>, jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On 4/15/2015 4:53 PM, Ping Cheng wrote:
> It makes probe routine easy to follow.
>=20
> Signed-off-by: Ping Cheng <pingc@wacom.com>

=46or patches 2-4, Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>

Jason
---
Now instead of four in the eights place /
you=92ve got three, =91Cause you added one /
(That is to say, eight) to the two, /
But you can=92t take seven from three, /
So you look at the sixty-fours....

> ---
>  drivers/hid/wacom.h     |  2 +-
>  drivers/hid/wacom_sys.c | 39 +--------------------------------------
>  drivers/hid/wacom_wac.c | 30 +++++++++++++++++++++++++++++-
>  3 files changed, 31 insertions(+), 40 deletions(-)
>=20
> diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
> index ad7318d..0f189c2 100644
> --- a/drivers/hid/wacom.h
> +++ b/drivers/hid/wacom.h
> @@ -132,7 +132,7 @@ static inline void wacom_schedule_work(struct wac=
om_wac *wacom_wac)
>  extern const struct hid_device_id wacom_ids[];
> =20
>  void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len);
> -void wacom_setup_device_quirks(struct wacom_features *features);
> +void wacom_setup_device_quirks(struct wacom *wacom);
>  int wacom_setup_pentouch_input_capabilities(struct input_dev *input_=
dev,
>  				   struct wacom_wac *wacom_wac);
>  int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 4c5d924..ca30eab 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -1504,44 +1504,7 @@ static int wacom_probe(struct hid_device *hdev=
,
>  	/* Retrieve the physical and logical size for touch devices */
>  	wacom_retrieve_hid_descriptor(hdev, features);
> =20
> -	/*
> -	 * Intuos5 has no useful data about its touch interface in its
> -	 * HID descriptor. If this is the touch interface (PacketSize
> -	 * of WACOM_PKGLEN_BBTOUCH3), override the table values.
> -	 */
> -	if (features->type >=3D INTUOS5S && features->type <=3D INTUOSHT) {
> -		if (features->pktlen =3D=3D WACOM_PKGLEN_BBTOUCH3) {
> -			features->device_type =3D BTN_TOOL_FINGER;
> -
> -			features->x_max =3D 4096;
> -			features->y_max =3D 4096;
> -		} else {
> -			features->device_type =3D BTN_TOOL_PEN;
> -		}
> -	}
> -
> -	/*
> -	 * Same thing for Bamboo 3rd gen.
> -	 */
> -	if ((features->type =3D=3D BAMBOO_PT) &&
> -	    (features->pktlen =3D=3D WACOM_PKGLEN_BBTOUCH3) &&
> -	    (features->device_type =3D=3D BTN_TOOL_PEN)) {
> -		features->device_type =3D BTN_TOOL_FINGER;
> -
> -		features->x_max =3D 4096;
> -		features->y_max =3D 4096;
> -	}
> -
> -	/*
> -	 * Same thing for Bamboo PAD
> -	 */
> -	if (features->type =3D=3D BAMBOO_PAD)
> -		features->device_type =3D BTN_TOOL_FINGER;
> -
> -	if (hdev->bus =3D=3D BUS_BLUETOOTH)
> -		features->quirks |=3D WACOM_QUIRK_BATTERY;
> -
> -	wacom_setup_device_quirks(features);
> +	wacom_setup_device_quirks(wacom);
> =20
>  	/* set unit to "100th of a mm" for devices not reported by HID */
>  	if (!features->unit) {
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 69c7df7..952ed4c 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -2164,8 +2164,9 @@ static void wacom_setup_intuos(struct wacom_wac=
 *wacom_wac)
>  	input_set_abs_params(input_dev, ABS_THROTTLE, -1023, 1023, 0, 0);
>  }
> =20
> -void wacom_setup_device_quirks(struct wacom_features *features)
> +void wacom_setup_device_quirks(struct wacom *wacom)
>  {
> +	struct wacom_features *features =3D &wacom->wacom_wac.features;
> =20
>  	/* touch device found but size is not defined. use default */
>  	if (features->device_type =3D=3D BTN_TOOL_FINGER && !features->x_ma=
x) {
> @@ -2173,6 +2174,33 @@ void wacom_setup_device_quirks(struct wacom_fe=
atures *features)
>  		features->y_max =3D 1023;
>  	}
> =20
> +	/*
> +	 * Intuos5/Pro and Bamboo 3rd gen have no useful data about its
> +	 * touch interface in its HID descriptor. If this is the touch
> +	 * interface (PacketSize of WACOM_PKGLEN_BBTOUCH3), override the
> +	 * tablet values.
> +	 */
> +	if ((features->type >=3D INTUOS5S && features->type <=3D INTUOSHT) =
||
> +		(features->type =3D=3D BAMBOO_PT)) {
> +		if (features->pktlen =3D=3D WACOM_PKGLEN_BBTOUCH3) {
> +			features->device_type =3D BTN_TOOL_FINGER;
> +
> +			features->x_max =3D 4096;
> +			features->y_max =3D 4096;
> +		} else {
> +			features->device_type =3D BTN_TOOL_PEN;
> +		}
> +	}
> +
> +	/*
> +	 * Same thing for Bamboo PAD
> +	 */
> +	if (features->type =3D=3D BAMBOO_PAD)
> +		features->device_type =3D BTN_TOOL_FINGER;
> +
> +	if (wacom->hdev->bus =3D=3D BUS_BLUETOOTH)
> +		features->quirks |=3D WACOM_QUIRK_BATTERY;
> +
>  	/* quirk for bamboo touch with 2 low res touches */
>  	if (features->type =3D=3D BAMBOO_PT &&
>  	    features->pktlen =3D=3D WACOM_PKGLEN_BBTOUCH) {
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
