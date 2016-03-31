From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH] HID: wacom: Support switching from vendor-defined input
 format on G9 and G11
Date: Thu, 31 Mar 2016 13:13:40 -0700
Message-ID: <56FD84F4.6060707@gmail.com>
References: <1459195850-11128-1-git-send-email-killertofu@gmail.com>
 <20160329070506.GB20424@mail.corp.redhat.com> <56FAB84B.2010802@gmail.com>
 <20160330092436.GF20424@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:32930 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757138AbcCaUNm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Mar 2016 16:13:42 -0400
Received: by mail-pa0-f53.google.com with SMTP id zm5so73432325pac.0
        for <linux-input@vger.kernel.org>; Thu, 31 Mar 2016 13:13:42 -0700 (PDT)
In-Reply-To: <20160330092436.GF20424@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Jason Gerecke <jason.gerecke@wacom.com>

On 03/30/2016 02:24 AM, Benjamin Tissoires wrote:
> On Mar 29 2016 or thereabouts, Jason Gerecke wrote:
>> On 03/29/2016 12:05 AM, Benjamin Tissoires wrote:
>>> Hi Jason,
>>>
>>> On Mar 28 2016 or thereabouts, Jason Gerecke wrote:
>>>> A tablet PC booted into Windows may have its pen/touch hardware sw=
itched
>>>> into "Wacom mode" similar to what we do with explicitly-supported =
hardware.
>>>> Some devices appear to maintain this state across reboots, prevent=
ing their
>>>> use with the generic HID driver. This patch adds support for the v=
endor-
>>>> defined "input format" feature report of G9 and G11 chips and has =
the HID
>>>> codepath always attempt to reset the device back to an appropriate=
 format.
>>>>
>>>> Fixes: https://sourceforge.net/p/linuxwacom/bugs/307/
>>>> Fixes: https://sourceforge.net/p/linuxwacom/bugs/310/
>>>> Fixes: https://github.com/linuxwacom/input-wacom/issues/15
>>>>
>>>> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
>>>> ---
>>>>  drivers/hid/wacom_sys.c | 55 ++++++++++++++++++++++++++++++++++++=
+++++++++++--
>>>>  drivers/hid/wacom_wac.h | 13 ++++++++++--
>>>>  2 files changed, 64 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
>>>> index 68a5609..d7ef7b0 100644
>>>> --- a/drivers/hid/wacom_sys.c
>>>> +++ b/drivers/hid/wacom_sys.c
>>>> @@ -152,6 +152,32 @@ static void wacom_feature_mapping(struct hid_=
device *hdev,
>>>>  		hid_data->inputmode =3D field->report->id;
>>>>  		hid_data->inputmode_index =3D usage->usage_index;
>>>>  		break;
>>>> +
>>>> +	/* The vendor-defined application collections leave most usages
>>>> +	 * as null (0x0000), making them much more difficult to match...
>>>> +	 */
>>>
>>> Not so sure this comments adds anything to the code. The applicatio=
n
>>> usage is well defined, so there is no need to worry I think.
>>>
>>> (Plus the coding style should be:
>>> /*
>>>  * multi lines
>>>  * comment.
>>>  */
>>> )
>>>
>>>> +	case HID_UP_DIGITIZER:
>>>> +		if (field->application =3D=3D WACOM_G9_DIGITIZER ||
>>>> +		    field->application =3D=3D WACOM_G11_DIGITIZER) {
>>>> +			if (field->report->id =3D=3D 0x0B) {
>>>
>>> I'd rather have the test on the report id first, and have only one =
if
>>> (with id && (app || app). This way, you'll keep the extra tab below=
=2E
>>>
>>>> +				hid_data->inputformat =3D field->report->id;
>>>> +				hid_data->inputformat_index =3D 0;
>>>
>>> Shouldn't this be usage->usage_index instead? Unless it's defined
>>> several times, which would make the use of usage_index moot.
>>>
>>
>> The field is the entire contents of one of Wacom's infamous "n
>> vendor-defined bytes" reports, so although the usage itself isn't
>> defined multiple times it does have a report count associated with i=
t
>> (with the same net effect).
>=20
> Fair enough. But I wonder if we need to keep the inputformat_index fi=
eld
> given that it will be always 0.
>=20
>>
>>>> +				hid_data->inputformat_value =3D 0; /* 0: HID; 1: Vendor-defin=
ed */
>>>
>>> Looks like both usages are requesting this to be set at 0. I think =
it's
>>> fine to keep it, but I don't know if it's that important to keep th=
en.
>>>
>>>> +			}
>>>> +		}
>>>> +		break;
>>>> +
>>>> +	case WACOM_G9_PAGE:
>>>> +	case WACOM_G11_PAGE:
>>>> +		if (field->application =3D=3D WACOM_G9_TOUCHSCREEN ||
>>>> +		    field->application =3D=3D WACOM_G11_TOUCHSCREEN) {
>>>> +			if (field->report->id =3D=3D 0x03) {
>>>
>>> Same three comments above apply here.
>>>
>>>> +				hid_data->inputformat =3D field->report->id;
>>>> +				hid_data->inputformat_index =3D 0;
>>>> +				hid_data->inputformat_value =3D 0; /* 0: HID; 4: Vendor-defin=
ed */
>>>> +			}
>>>> +		}
>>>> +		break;
>>>>  	}
>>>>  }
>>>> =20
>>>> @@ -322,6 +348,25 @@ static int wacom_hid_set_device_mode(struct h=
id_device *hdev)
>>>>  	return 0;
>>>>  }
>>>> =20
>>>> +static int wacom_hid_set_device_format(struct hid_device *hdev)
>>>> +{
>>>> +	struct wacom *wacom =3D hid_get_drvdata(hdev);
>>>> +	struct hid_data *hid_data =3D &wacom->wacom_wac.hid_data;
>>>> +	struct hid_report *r;
>>>> +	struct hid_report_enum *re;
>>>> +
>>>> +	if (hid_data->inputformat < 0)
>>>> +		return 0;
>>>> +
>>>> +	re =3D &(hdev->report_enum[HID_FEATURE_REPORT]);
>>>> +	r =3D re->report_id_hash[hid_data->inputformat];
>>>> +	if (r) {
>>>> +		r->field[0]->value[hid_data->inputformat_index] =3D hid_data->i=
nputformat_value;
>>>> +		hid_hw_request(hdev, r, HID_REQ_SET_REPORT);
>>>> +	}
>>>> +	return 0;
>>>> +}
>>>> +
>>>>  static int wacom_set_device_mode(struct hid_device *hdev, int rep=
ort_id,
>>>>  		int length, int mode)
>>>>  {
>>>> @@ -414,8 +459,14 @@ static int wacom_query_tablet_data(struct hid=
_device *hdev,
>>>>  	if (hdev->bus =3D=3D BUS_BLUETOOTH)
>>>>  		return wacom_bt_query_tablet_data(hdev, 1, features);
>>>> =20
>>>> -	if (features->type =3D=3D HID_GENERIC)
>>>> -		return wacom_hid_set_device_mode(hdev);
>>>> +	if (features->type =3D=3D HID_GENERIC) {
>>>> +		int err;
>>>> +		err =3D wacom_hid_set_device_mode(hdev);
>>>> +		if (err)
>>>> +			return err;
>>>> +		err =3D wacom_hid_set_device_format(hdev);
>>>
>>> I don't really see the difference between "input mode" and "input
>>> format". Does the device needs both to be set? If not, couldn't we
>>> extend the input mode feature for these usages?
>>>
>>> Cheers,
>>> Benjamin
>>>
>>
>> Device / Input mode is a standard HID feature expected to be present=
 on
>> Windows 7-compatible touch devices which is used to switch a device
>> between sending mouse, single, or multi-touch reports[1]. The
>> 'wacom_hid_set_device_mode' function right now takes care of switchi=
ng
>> into multi-touch mode provided the hid_data->inputmode field has bee=
n set.
>=20
> Well, "Device Mode" is also used by MS for Pen devices (values are 0 =
-
> Mouse, and 1 - Pen). So it's more a generic mode for the device than =
a
> multitouch mode.
>=20
>>
>> Input format on the other hand is a vendor-defined feature that is u=
sed
>> to switch Wacom devices (both touchscreens and tablets) between send=
ing
>> standard HID reports or vendor-defined reports. Devices are supposed=
 to
>> start up sending the former, but at least two tablet PCs have had
>> hardware that seems to remember being switched to the vendor-defined=
 format.
>>
>> If the format is explicitly switched to HID standard, we still shoul=
d
>> probably set the mode as well since I don't think there's anything
>> implied about which mode the tablet should use after switching.
>=20
> OK, then in that regard, it would make more sense to first switch the
> device back into the HID mode, and then switch it to multitouch.
>=20
>>
>> Relatedly, it's probably a good idea to rename 'wacom_set_device_mod=
e'
>> or 'wacom_hid_set_device_mode' since they each set different a diffe=
rent
>> kind of "mode". It _might_ also be reasonable to rework
>> 'wacom_set_device_mode' to be compatible with HID_GENERIC devices
>> (rather than introducing 'wacom_hid_set_device_format'), but keeping
>> compatibility the explicit devices might be tricky...
>=20
> OK, how about the following:
> we keep wacom_set_device_mode() for switching the proprietary mode, b=
ut
> add a mode_value and mode_report in wacom_wac. This way, we can detec=
t
> those proprietary mode changes in feature_mapping, and still keep the
> HID Device Mode bits in place.
>=20
> I tried to come up with the following, which seems to be working on t=
he
> Bamboo PAD, Intuos Pro S, Bamboo 16FG, and Cintiq 13HDT:
>=20
> ---
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 68a5609..90fa4d4 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -322,26 +322,41 @@ static int wacom_hid_set_device_mode(struct hid=
_device *hdev)
>  	return 0;
>  }
> =20
> -static int wacom_set_device_mode(struct hid_device *hdev, int report=
_id,
> -		int length, int mode)
> +static int wacom_set_device_mode(struct hid_device *hdev,
> +				 struct wacom_wac *wacom_wac)
>  {
> -	unsigned char *rep_data;
> +	u8 *rep_data;
> +	struct hid_report *r;
> +	struct hid_report_enum *re;
> +	int length;
>  	int error =3D -ENOMEM, limit =3D 0;
> =20
> -	rep_data =3D kzalloc(length, GFP_KERNEL);
> +	if (wacom_wac->mode_report < 0)
> +		return 0;
> +
> +	re =3D &(hdev->report_enum[HID_FEATURE_REPORT]);
> +	r =3D re->report_id_hash[wacom_wac->mode_report];
> +	if (!r)
> +		return -EINVAL;
> +
> +	rep_data =3D hid_alloc_report_buf(r, GFP_KERNEL);
>  	if (!rep_data)
> -		return error;
> +		return -ENOMEM;
> +
> +	length =3D hid_report_len(r);
> =20
>  	do {
> -		rep_data[0] =3D report_id;
> -		rep_data[1] =3D mode;
> +		rep_data[0] =3D wacom_wac->mode_report;
> +		rep_data[1] =3D wacom_wac->mode_value;
> =20
>  		error =3D wacom_set_report(hdev, HID_FEATURE_REPORT, rep_data,
>  					 length, 1);
>  		if (error >=3D 0)
>  			error =3D wacom_get_report(hdev, HID_FEATURE_REPORT,
>  			                         rep_data, length, 1);
> -	} while (error >=3D 0 && rep_data[1] !=3D mode && limit++ < WAC_MSG=
_RETRIES);
> +	} while (error >=3D 0 &&
> +		 rep_data[1] !=3D wacom_wac->mode_report &&
> +		 limit++ < WAC_MSG_RETRIES);
> =20
>  	kfree(rep_data);
> =20
> @@ -411,32 +426,41 @@ static int wacom_bt_query_tablet_data(struct hi=
d_device *hdev, u8 speed,
>  static int wacom_query_tablet_data(struct hid_device *hdev,
>  		struct wacom_features *features)
>  {
> +	struct wacom *wacom =3D hid_get_drvdata(hdev);
> +	struct wacom_wac *wacom_wac =3D &wacom->wacom_wac;
> +
>  	if (hdev->bus =3D=3D BUS_BLUETOOTH)
>  		return wacom_bt_query_tablet_data(hdev, 1, features);
> =20
> -	if (features->type =3D=3D HID_GENERIC)
> -		return wacom_hid_set_device_mode(hdev);
> -
> -	if (features->device_type & WACOM_DEVICETYPE_TOUCH) {
> -		if (features->type > TABLETPC) {
> -			/* MT Tablet PC touch */
> -			return wacom_set_device_mode(hdev, 3, 4, 4);
> -		}
> -		else if (features->type =3D=3D WACOM_24HDT) {
> -			return wacom_set_device_mode(hdev, 18, 3, 2);
> -		}
> -		else if (features->type =3D=3D WACOM_27QHDT) {
> -			return wacom_set_device_mode(hdev, 131, 3, 2);
> -		}
> -		else if (features->type =3D=3D BAMBOO_PAD) {
> -			return wacom_set_device_mode(hdev, 2, 2, 2);
> -		}
> -	} else if (features->device_type & WACOM_DEVICETYPE_PEN) {
> -		if (features->type <=3D BAMBOO_PT) {
> -			return wacom_set_device_mode(hdev, 2, 2, 2);
> +	if (features->type !=3D HID_GENERIC) {
> +		if (features->device_type & WACOM_DEVICETYPE_TOUCH) {
> +			if (features->type > TABLETPC) {
> +				/* MT Tablet PC touch */
> +				wacom_wac->mode_report =3D 3;
> +				wacom_wac->mode_value =3D 4;
> +			} else if (features->type =3D=3D WACOM_24HDT) {
> +				wacom_wac->mode_report =3D 18;
> +				wacom_wac->mode_value =3D 2;
> +			} else if (features->type =3D=3D WACOM_27QHDT) {
> +				wacom_wac->mode_report =3D 131;
> +				wacom_wac->mode_value =3D 2;
> +			} else if (features->type =3D=3D BAMBOO_PAD) {
> +				wacom_wac->mode_report =3D 2;
> +				wacom_wac->mode_value =3D 2;
> +			}
> +		} else if (features->device_type & WACOM_DEVICETYPE_PEN) {
> +			if (features->type <=3D BAMBOO_PT) {
> +				wacom_wac->mode_report =3D 2;
> +				wacom_wac->mode_value =3D 2;
> +			}
>  		}
>  	}
> =20
> +	wacom_set_device_mode(hdev, wacom_wac);
> +
> +	if (features->type =3D=3D HID_GENERIC)
> +		return wacom_hid_set_device_mode(hdev);
> +
>  	return 0;
>  }
> =20
> @@ -1817,6 +1841,9 @@ static int wacom_probe(struct hid_device *hdev,
>  		goto fail_type;
>  	}
> =20
> +	wacom_wac->hid_data.inputmode =3D -1;

I noticed this was missing the other day but then totally forgot to fix
it. Thanks for the reminder :)

> +	wacom_wac->mode_report =3D -1;
> +
>  	wacom->usbdev =3D dev;
>  	wacom->intf =3D intf;
>  	mutex_init(&wacom->lock);
> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
> index 25baa7f..8f40e45 100644
> --- a/drivers/hid/wacom_wac.h
> +++ b/drivers/hid/wacom_wac.h
> @@ -238,6 +238,8 @@ struct wacom_wac {
>  	int ps_connected;
>  	u8 bt_features;
>  	u8 bt_high_speed;
> +	int mode_report;
> +	int mode_value;
>  	struct hid_data hid_data;
>  };
>  =20
> ---
> =20
> This patch infers the length of the feature from the report descripto=
r,
> but I would expect this to be correct on all devices.
>=20
> Any tests/remarks would be appreciated :)
>=20
> Cheers,
> Benjamin
>=20

I think I like the look of this :) I'll do a bit more checking on my en=
d
and get back to you shortly.

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one /
(That is to say, eight) to the two, /
But you can=E2=80=99t take seven from three, /
So you look at the sixty-fours....

>>
>> Off to work on V2...
>>
>> [1]:
>> https://msdn.microsoft.com/en-us/library/windows/hardware/ff553739%2=
8v=3Dvs.85%29.aspx
>>
>> Jason
>> ---
>> Now instead of four in the eights place /
>> you=E2=80=99ve got three, =E2=80=98Cause you added one /
>> (That is to say, eight) to the two, /
>> But you can=E2=80=99t take seven from three, /
>> So you look at the sixty-fours....
>>
>>>> +		return err;
>>>> +	}
>>>> =20
>>>>  	if (features->device_type & WACOM_DEVICETYPE_TOUCH) {
>>>>  		if (features->type > TABLETPC) {
>>>> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
>>>> index 25baa7f..37d5dec 100644
>>>> --- a/drivers/hid/wacom_wac.h
>>>> +++ b/drivers/hid/wacom_wac.h
>>>> @@ -84,6 +84,12 @@
>>>>  #define WACOM_DEVICETYPE_WL_MONITOR     0x0008
>>>> =20
>>>>  #define WACOM_VENDORDEFINED_PEN		0xff0d0001
>>>> +#define WACOM_G9_PAGE			0xff090000
>>>> +#define WACOM_G9_DIGITIZER		(WACOM_G9_PAGE | 0x02)
>>>> +#define WACOM_G9_TOUCHSCREEN		(WACOM_G9_PAGE | 0x11)
>>>> +#define WACOM_G11_PAGE			0xff110000
>>>> +#define WACOM_G11_DIGITIZER		(WACOM_G11_PAGE | 0x02)
>>>> +#define WACOM_G11_TOUCHSCREEN		(WACOM_G11_PAGE | 0x11)
>>>> =20
>>>>  #define WACOM_PEN_FIELD(f)	(((f)->logical =3D=3D HID_DG_STYLUS) |=
| \
>>>>  				 ((f)->physical =3D=3D HID_DG_STYLUS) || \
>>>> @@ -193,8 +199,11 @@ struct wacom_shared {
>>>>  };
>>>> =20
>>>>  struct hid_data {
>>>> -	__s16 inputmode;	/* InputMode HID feature, -1 if non-existent */
>>>> -	__s16 inputmode_index;	/* InputMode HID feature index in the rep=
ort */
>>>> +	__s16 inputmode;		/* InputMode HID feature, -1 if non-existent *=
/
>>>> +	__s16 inputmode_index;		/* InputMode HID feature index in the re=
port */
>>>> +	__s16 inputformat;		/* Vendor-defined "input format" feature, -1=
 if non-existent */
>>>> +	__s16 inputformat_index;	/* Vendor-defined "input format" featur=
e index in the report */
>>>> +	__u8  inputformat_value;	/* Value expected by device to switch t=
o HID mode */
>>>>  	bool inrange_state;
>>>>  	bool invert_state;
>>>>  	bool tipswitch;
>>>> --=20
>>>> 2.7.3
>>>>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
