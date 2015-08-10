From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH] HID: wacom: Report correct device resolution when using
 the wireless adapater
Date: Mon, 10 Aug 2015 11:02:12 -0700
Message-ID: <55C8E724.3030906@gmail.com>
References: <1438814693-12051-1-git-send-email-killertofu@gmail.com>
 <alpine.LNX.2.00.1508101045010.27871@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:36118 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932291AbbHJSCQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Aug 2015 14:02:16 -0400
Received: by pdco4 with SMTP id o4so74015300pdc.3
        for <linux-input@vger.kernel.org>; Mon, 10 Aug 2015 11:02:16 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1508101045010.27871@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On 8/10/2015 1:45 AM, Jiri Kosina wrote:
> On Wed, 5 Aug 2015, Jason Gerecke wrote:
>=20
>> The 'wacom_wireless_work' function does not recalculate the tablet's
>> resolution, causing the value contained in the 'features' struct to
>> always be reported to userspace. This value is valid only for the pe=
n
>> interface, meaning that the value will be incorrect for the touchpad=
 (if
>> present). This in particular causes problems for libinput which reli=
es
>> on the reported resolution being correct.
>>
>> This patch adds the necessary calls to recalculate the resolution fo=
r
>> each interface. This requires a little bit of code shuffling since b=
oth
>> the 'wacom_set_default_phy' and 'wacom_calculate_res' are declared b=
elow
>> their new first point of use in 'wacom_wireless_work'.
>>
>> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
>> ---
>> Jiri: Would it be possible to target this patch for 4.2?
>=20
> Just want to understand the context here -- is this a regression? If =
yes,=20
> since what version/commit?
>=20
> Thanks.
>=20
This bug was exposed by an update to libinput which makes it more
reliant on accurate resolution values. It is a regression in our code,
but one which has gone unnoticed for quite some time. I've tracked its
introduction to somewhere between 3.11 and 3.13, and having looked at
the commits in that range believe that 401d7d1 (merged in 3.12) is
likely the culprit. That commit replaced a function which calculated th=
e
resolution as part of the input device registration process with one
that calculates it as part of the probe process after the HID descripto=
r
is read (which doesn't do us any good in the wireless case).

=46ixing this in 4.2 ensures that this bug doesn't tickle libinput any
longer than necessary. It would also be nice to backport this patch to
stable, but I'm not sure if it quite meets the necessary severity stand=
ards.

Jason
---
Now instead of four in the eights place /
you=92ve got three, =91Cause you added one /
(That is to say, eight) to the two, /
But you can=92t take seven from three, /
So you look at the sixty-fours....

>>
>>  drivers/hid/wacom_sys.c | 70 ++++++++++++++++++++++++++------------=
-----------
>>  1 file changed, 37 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
>> index 4c0ffca..7e064b0 100644
>> --- a/drivers/hid/wacom_sys.c
>> +++ b/drivers/hid/wacom_sys.c
>> @@ -1282,6 +1282,39 @@ fail_register_pen_input:
>>  	return error;
>>  }
>> =20
>> +/*
>> + * Not all devices report physical dimensions from HID.
>> + * Compute the default from hardcoded logical dimension
>> + * and resolution before driver overwrites them.
>> + */
>> +static void wacom_set_default_phy(struct wacom_features *features)
>> +{
>> +	if (features->x_resolution) {
>> +		features->x_phy =3D (features->x_max * 100) /
>> +					features->x_resolution;
>> +		features->y_phy =3D (features->y_max * 100) /
>> +					features->y_resolution;
>> +	}
>> +}
>> +
>> +static void wacom_calculate_res(struct wacom_features *features)
>> +{
>> +	/* set unit to "100th of a mm" for devices not reported by HID */
>> +	if (!features->unit) {
>> +		features->unit =3D 0x11;
>> +		features->unitExpo =3D -3;
>> +	}
>> +
>> +	features->x_resolution =3D wacom_calc_hid_res(features->x_max,
>> +						    features->x_phy,
>> +						    features->unit,
>> +						    features->unitExpo);
>> +	features->y_resolution =3D wacom_calc_hid_res(features->y_max,
>> +						    features->y_phy,
>> +						    features->unit,
>> +						    features->unitExpo);
>> +}
>> +
>>  static void wacom_wireless_work(struct work_struct *work)
>>  {
>>  	struct wacom *wacom =3D container_of(work, struct wacom, work);
>> @@ -1339,6 +1372,8 @@ static void wacom_wireless_work(struct work_st=
ruct *work)
>>  		if (wacom_wac1->features.type !=3D INTUOSHT &&
>>  		    wacom_wac1->features.type !=3D BAMBOO_PT)
>>  			wacom_wac1->features.device_type |=3D WACOM_DEVICETYPE_PAD;
>> +		wacom_set_default_phy(&wacom_wac1->features);
>> +		wacom_calculate_res(&wacom_wac1->features);
>>  		snprintf(wacom_wac1->pen_name, WACOM_NAME_MAX, "%s (WL) Pen",
>>  			 wacom_wac1->features.name);
>>  		snprintf(wacom_wac1->pad_name, WACOM_NAME_MAX, "%s (WL) Pad",
>> @@ -1357,7 +1392,9 @@ static void wacom_wireless_work(struct work_st=
ruct *work)
>>  			wacom_wac2->features =3D
>>  				*((struct wacom_features *)id->driver_data);
>>  			wacom_wac2->features.pktlen =3D WACOM_PKGLEN_BBTOUCH3;
>> +			wacom_set_default_phy(&wacom_wac2->features);
>>  			wacom_wac2->features.x_max =3D wacom_wac2->features.y_max =3D 40=
96;
>> +			wacom_calculate_res(&wacom_wac2->features);
>>  			snprintf(wacom_wac2->touch_name, WACOM_NAME_MAX,
>>  				 "%s (WL) Finger",wacom_wac2->features.name);
>>  			snprintf(wacom_wac2->pad_name, WACOM_NAME_MAX,
>> @@ -1405,39 +1442,6 @@ void wacom_battery_work(struct work_struct *w=
ork)
>>  	}
>>  }
>> =20
>> -/*
>> - * Not all devices report physical dimensions from HID.
>> - * Compute the default from hardcoded logical dimension
>> - * and resolution before driver overwrites them.
>> - */
>> -static void wacom_set_default_phy(struct wacom_features *features)
>> -{
>> -	if (features->x_resolution) {
>> -		features->x_phy =3D (features->x_max * 100) /
>> -					features->x_resolution;
>> -		features->y_phy =3D (features->y_max * 100) /
>> -					features->y_resolution;
>> -	}
>> -}
>> -
>> -static void wacom_calculate_res(struct wacom_features *features)
>> -{
>> -	/* set unit to "100th of a mm" for devices not reported by HID */
>> -	if (!features->unit) {
>> -		features->unit =3D 0x11;
>> -		features->unitExpo =3D -3;
>> -	}
>> -
>> -	features->x_resolution =3D wacom_calc_hid_res(features->x_max,
>> -						    features->x_phy,
>> -						    features->unit,
>> -						    features->unitExpo);
>> -	features->y_resolution =3D wacom_calc_hid_res(features->y_max,
>> -						    features->y_phy,
>> -						    features->unit,
>> -						    features->unitExpo);
>> -}
>> -
>>  static size_t wacom_compute_pktlen(struct hid_device *hdev)
>>  {
>>  	struct hid_report_enum *report_enum;
>> --=20
>> 2.5.0
>>
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
