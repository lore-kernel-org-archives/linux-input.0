From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 1/3] HID: wacom: remove hardcoded WACOM_QUIRK_MULTI_INPUT
Date: Wed, 01 Apr 2015 11:59:27 -0700
Message-ID: <551C400F.8010907@gmail.com>
References: <1426888620-8643-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36186 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190AbbDAS7b (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Apr 2015 14:59:31 -0400
Received: by padcy3 with SMTP id cy3so60184055pad.3
        for <linux-input@vger.kernel.org>; Wed, 01 Apr 2015 11:59:30 -0700 (PDT)
In-Reply-To: <1426888620-8643-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>, benjamin.tissoires@gmail.com, jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On 3/20/2015 2:57 PM, Ping Cheng wrote:
> The quirk was added for devices that support both pen and touch.
> It decides if a device supports multiple inputs by hardcoded
> feature type. However, for some devices, we do not know if they
> support both before accessing their HID descriptors.
>
> This patch relies on dynamically assigned device_type to make
> the decision. Also, we make it certain that wacom_wac->shared
> is always created. That is, the driver will not be loaded if
> it fails to create wacom_wac->shared.
>
> Signed-off-by: Ping Cheng <pingc@wacom.com>

Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>

---
Now instead of four in the eights place /
you=92ve got three, =91Cause you added one /
(That is to say, eight) to the two, /
But you can=92t take seven from three, /
So you look at the sixty-fours....

> ---
>   drivers/hid/wacom_sys.c | 24 +++++++++++-------------
>   drivers/hid/wacom_wac.c | 18 ++++--------------
>   drivers/hid/wacom_wac.h |  9 ++++-----
>   3 files changed, 19 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index f0568a7..a99e66f 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -1462,19 +1462,17 @@ static int wacom_probe(struct hid_device *hde=
v,
>   	snprintf(wacom_wac->pad_name, sizeof(wacom_wac->pad_name),
>   		"%s Pad", features->name);
>
> -	if (features->quirks & WACOM_QUIRK_MULTI_INPUT) {
> -		/* Append the device type to the name */
> -		if (features->device_type !=3D BTN_TOOL_FINGER)
> -			strlcat(wacom_wac->name, " Pen", WACOM_NAME_MAX);
> -		else if (features->touch_max)
> -			strlcat(wacom_wac->name, " Finger", WACOM_NAME_MAX);
> -		else
> -			strlcat(wacom_wac->name, " Pad", WACOM_NAME_MAX);
> -
> -		error =3D wacom_add_shared_data(hdev);
> -		if (error)
> -			goto fail_shared_data;
> -	}
> +	/* Append the device type to the name */
> +	if (features->device_type !=3D BTN_TOOL_FINGER)
> +		strlcat(wacom_wac->name, " Pen", WACOM_NAME_MAX);
> +	else if (features->touch_max)
> +		strlcat(wacom_wac->name, " Finger", WACOM_NAME_MAX);
> +	else
> +		strlcat(wacom_wac->name, " Pad", WACOM_NAME_MAX);
> +
> +	error =3D wacom_add_shared_data(hdev);
> +	if (error)
> +		goto fail_shared_data;
>
>   	if (!(features->quirks & WACOM_QUIRK_MONITOR) &&
>   	     (features->quirks & WACOM_QUIRK_BATTERY)) {
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index bbe32d6..3b01dc9 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -551,12 +551,9 @@ static int wacom_intuos_inout(struct wacom_wac *=
wacom)
>   	   (features->type =3D=3D CINTIQ && !(data[1] & 0x40)))
>   		return 1;
>
> -	if (wacom->shared) {
> -		wacom->shared->stylus_in_proximity =3D true;
> -
> -		if (wacom->shared->touch_down)
> -			return 1;
> -	}
> +	wacom->shared->stylus_in_proximity =3D true;
> +	if (wacom->shared->touch_down)
> +		return 1;
>
>   	/* in Range while exiting */
>   	if (((data[1] & 0xfe) =3D=3D 0x20) && wacom->reporting_data) {
> @@ -568,8 +565,7 @@ static int wacom_intuos_inout(struct wacom_wac *w=
acom)
>
>   	/* Exit report */
>   	if ((data[1] & 0xfe) =3D=3D 0x80) {
> -		if (features->quirks & WACOM_QUIRK_MULTI_INPUT)
> -			wacom->shared->stylus_in_proximity =3D false;
> +		wacom->shared->stylus_in_proximity =3D false;
>   		wacom->reporting_data =3D false;
>
>   		/* don't report exit if we don't know the ID */
> @@ -2054,12 +2050,6 @@ void wacom_setup_device_quirks(struct wacom_fe=
atures *features)
>   		features->y_max =3D 1023;
>   	}
>
> -	/* these device have multiple inputs */
> -	if (features->type >=3D WIRELESS ||
> -	    (features->type >=3D INTUOS5S && features->type <=3D INTUOSHT) =
||
> -	    (features->oVid && features->oPid))
> -		features->quirks |=3D WACOM_QUIRK_MULTI_INPUT;
> -
>   	/* quirk for bamboo touch with 2 low res touches */
>   	if (features->type =3D=3D BAMBOO_PT &&
>   	    features->pktlen =3D=3D WACOM_PKGLEN_BBTOUCH) {
> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
> index 021ee1c..309f219 100644
> --- a/drivers/hid/wacom_wac.h
> +++ b/drivers/hid/wacom_wac.h
> @@ -69,11 +69,10 @@
>   #define WACOM_REPORT_USB		192
>
>   /* device quirks */
> -#define WACOM_QUIRK_MULTI_INPUT		0x0001
> -#define WACOM_QUIRK_BBTOUCH_LOWRES	0x0002
> -#define WACOM_QUIRK_NO_INPUT		0x0004
> -#define WACOM_QUIRK_MONITOR		0x0008
> -#define WACOM_QUIRK_BATTERY		0x0010
> +#define WACOM_QUIRK_BBTOUCH_LOWRES	0x0001
> +#define WACOM_QUIRK_NO_INPUT		0x0002
> +#define WACOM_QUIRK_MONITOR		0x0004
> +#define WACOM_QUIRK_BATTERY		0x0008
>
>   #define WACOM_PEN_FIELD(f)	(((f)->logical =3D=3D HID_DG_STYLUS) || =
\
>   				 ((f)->physical =3D=3D HID_DG_STYLUS) || \
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
