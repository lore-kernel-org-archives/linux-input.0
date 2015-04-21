From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH v2] HID: wacom: retrieve name from HID descriptor for
 generic devices
Date: Mon, 20 Apr 2015 17:58:22 -0700
Message-ID: <5535A0AE.4080506@gmail.com>
References: <1429564199-16873-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35226 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807AbbDUA60 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Apr 2015 20:58:26 -0400
Received: by pabtp1 with SMTP id tp1so223789460pab.2
        for <linux-input@vger.kernel.org>; Mon, 20 Apr 2015 17:58:25 -0700 (PDT)
In-Reply-To: <1429564199-16873-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>, jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On 4/20/2015 2:09 PM, Ping Cheng wrote:
> HID generic devices share the same default name, "Wacom HID". This
> causes userland programs to show same device names for different
> devices, which would confuse end users with same device names for
> different devices too.
>=20
> This patch uses name retrieved from HID descriptor, if a meaningful
> name is reported. Otherwise, affix its product ID to "Wacom HID".
>=20
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
> v2: updated with Jason's pid affix and extract whitespace suggestions=
=2E
> ---
>  drivers/hid/wacom_sys.c | 53 +++++++++++++++++++++++++++++++++++++++=
----------
>  1 file changed, 42 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 1b00d8d..a857cd2 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -1392,6 +1392,47 @@ static size_t wacom_compute_pktlen(struct hid_=
device *hdev)
>  	return size;
>  }
> =20
> +static void wacom_update_name(struct wacom *wacom)
> +{
> +	struct wacom_wac *wacom_wac =3D &wacom->wacom_wac;
> +	struct wacom_features *features =3D &wacom_wac->features;
> +
> +	/* Generic devices name unspecified */
> +	if ((features->type =3D=3D HID_GENERIC) && !strcmp("Wacom HID", fea=
tures->name)) {
> +		if (strstr(wacom->hdev->name, "Wacom") ||
> +		    strstr(wacom->hdev->name, "wacom") ||
> +		    strstr(wacom->hdev->name, "WACOM")) {
> +			/* name is in HID descriptor, use it */
> +			strlcpy(wacom_wac->name, wacom->hdev->name,
> +				sizeof(wacom_wac->name));
> +
> +			/* strip out excess whitespaces */
> +			while (1) {
> +				char *gap =3D strstr(wacom_wac->name, "  ");
> +				if (gap =3D=3D NULL)
> +	 				break;
> +				memmove(gap, gap+1, strlen(gap));
> +			}

Alas, my snippet doesn't work as intended when placed here. It will
remove extra internal whitespace without issue, but will leave a single
trailing space at the end of the string if there were one or more space=
s
there originally. Because of this, a double space can be re-introduced
once you append the e.g. " Pen" suffix below. I suggested the loop be
placed at the bottom of the function because of this.

Alternatively, you could put a call to 'strim' immediately before or
after the loop to get rid of the extra trailing space (though I don't
particularly like how it smells):

    memmove(wacom_wac->name, strim(wacom_wac->name), \
            strlen(wacom_wac->name)+1);

Jason
---
Now instead of four in the eights place /
you=92ve got three, =91Cause you added one /
(That is to say, eight) to the two, /
But you can=92t take seven from three, /
So you look at the sixty-fours....

> +		} else {
> +			/* no meaningful name retrieved. use product ID */
> +			snprintf(wacom_wac->name, sizeof(wacom_wac->name),
> +				 "%s %x", features->name, wacom->hdev->product);
> +		}
> +	} else {
> +		strlcpy(wacom_wac->name, features->name, sizeof(wacom_wac->name));
> +	}
> +	snprintf(wacom_wac->pad_name, sizeof(wacom_wac->pad_name),
> +		"%s Pad", wacom_wac->name);
> +
> +	/* Append the device type to the name */
> +	if (features->device_type !=3D BTN_TOOL_FINGER)
> +		strlcat(wacom_wac->name, " Pen", WACOM_NAME_MAX);
> +	else if (features->touch_max)
> +		strlcat(wacom_wac->name, " Finger", WACOM_NAME_MAX);
> +	else
> +		strlcat(wacom_wac->name, " Pad", WACOM_NAME_MAX);
> +}
> +
>  static int wacom_probe(struct hid_device *hdev,
>  		const struct hid_device_id *id)
>  {
> @@ -1517,17 +1558,7 @@ static int wacom_probe(struct hid_device *hdev=
,
>  	}
>  	wacom_calculate_res(features);
> =20
> -	strlcpy(wacom_wac->name, features->name, sizeof(wacom_wac->name));
> -	snprintf(wacom_wac->pad_name, sizeof(wacom_wac->pad_name),
> -		"%s Pad", features->name);
> -
> -	/* Append the device type to the name */
> -	if (features->device_type !=3D BTN_TOOL_FINGER)
> -		strlcat(wacom_wac->name, " Pen", WACOM_NAME_MAX);
> -	else if (features->touch_max)
> -		strlcat(wacom_wac->name, " Finger", WACOM_NAME_MAX);
> -	else
> -		strlcat(wacom_wac->name, " Pad", WACOM_NAME_MAX);
> +	wacom_update_name(wacom);
> =20
>  	error =3D wacom_add_shared_data(hdev);
>  	if (error)
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
