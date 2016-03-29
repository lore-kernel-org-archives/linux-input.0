From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH] HID: wacom: Support switching from vendor-defined input
 format on G9 and G11
Date: Tue, 29 Mar 2016 10:15:55 -0700
Message-ID: <56FAB84B.2010802@gmail.com>
References: <1459195850-11128-1-git-send-email-killertofu@gmail.com>
 <20160329070506.GB20424@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36562 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757737AbcC2RP7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Mar 2016 13:15:59 -0400
Received: by mail-pa0-f41.google.com with SMTP id tt10so18658627pab.3
        for <linux-input@vger.kernel.org>; Tue, 29 Mar 2016 10:15:58 -0700 (PDT)
In-Reply-To: <20160329070506.GB20424@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Jason Gerecke <jason.gerecke@wacom.com>

On 03/29/2016 12:05 AM, Benjamin Tissoires wrote:
> Hi Jason,
>=20
> On Mar 28 2016 or thereabouts, Jason Gerecke wrote:
>> A tablet PC booted into Windows may have its pen/touch hardware swit=
ched
>> into "Wacom mode" similar to what we do with explicitly-supported ha=
rdware.
>> Some devices appear to maintain this state across reboots, preventin=
g their
>> use with the generic HID driver. This patch adds support for the ven=
dor-
>> defined "input format" feature report of G9 and G11 chips and has th=
e HID
>> codepath always attempt to reset the device back to an appropriate f=
ormat.
>>
>> Fixes: https://sourceforge.net/p/linuxwacom/bugs/307/
>> Fixes: https://sourceforge.net/p/linuxwacom/bugs/310/
>> Fixes: https://github.com/linuxwacom/input-wacom/issues/15
>>
>> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
>> ---
>>  drivers/hid/wacom_sys.c | 55 ++++++++++++++++++++++++++++++++++++++=
+++++++++--
>>  drivers/hid/wacom_wac.h | 13 ++++++++++--
>>  2 files changed, 64 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
>> index 68a5609..d7ef7b0 100644
>> --- a/drivers/hid/wacom_sys.c
>> +++ b/drivers/hid/wacom_sys.c
>> @@ -152,6 +152,32 @@ static void wacom_feature_mapping(struct hid_de=
vice *hdev,
>>  		hid_data->inputmode =3D field->report->id;
>>  		hid_data->inputmode_index =3D usage->usage_index;
>>  		break;
>> +
>> +	/* The vendor-defined application collections leave most usages
>> +	 * as null (0x0000), making them much more difficult to match...
>> +	 */
>=20
> Not so sure this comments adds anything to the code. The application
> usage is well defined, so there is no need to worry I think.
>=20
> (Plus the coding style should be:
> /*
>  * multi lines
>  * comment.
>  */
> )
>=20
>> +	case HID_UP_DIGITIZER:
>> +		if (field->application =3D=3D WACOM_G9_DIGITIZER ||
>> +		    field->application =3D=3D WACOM_G11_DIGITIZER) {
>> +			if (field->report->id =3D=3D 0x0B) {
>=20
> I'd rather have the test on the report id first, and have only one if
> (with id && (app || app). This way, you'll keep the extra tab below.
>=20
>> +				hid_data->inputformat =3D field->report->id;
>> +				hid_data->inputformat_index =3D 0;
>=20
> Shouldn't this be usage->usage_index instead? Unless it's defined
> several times, which would make the use of usage_index moot.
>=20

The field is the entire contents of one of Wacom's infamous "n
vendor-defined bytes" reports, so although the usage itself isn't
defined multiple times it does have a report count associated with it
(with the same net effect).

>> +				hid_data->inputformat_value =3D 0; /* 0: HID; 1: Vendor-defined=
 */
>=20
> Looks like both usages are requesting this to be set at 0. I think it=
's
> fine to keep it, but I don't know if it's that important to keep then=
=2E
>=20
>> +			}
>> +		}
>> +		break;
>> +
>> +	case WACOM_G9_PAGE:
>> +	case WACOM_G11_PAGE:
>> +		if (field->application =3D=3D WACOM_G9_TOUCHSCREEN ||
>> +		    field->application =3D=3D WACOM_G11_TOUCHSCREEN) {
>> +			if (field->report->id =3D=3D 0x03) {
>=20
> Same three comments above apply here.
>=20
>> +				hid_data->inputformat =3D field->report->id;
>> +				hid_data->inputformat_index =3D 0;
>> +				hid_data->inputformat_value =3D 0; /* 0: HID; 4: Vendor-defined=
 */
>> +			}
>> +		}
>> +		break;
>>  	}
>>  }
>> =20
>> @@ -322,6 +348,25 @@ static int wacom_hid_set_device_mode(struct hid=
_device *hdev)
>>  	return 0;
>>  }
>> =20
>> +static int wacom_hid_set_device_format(struct hid_device *hdev)
>> +{
>> +	struct wacom *wacom =3D hid_get_drvdata(hdev);
>> +	struct hid_data *hid_data =3D &wacom->wacom_wac.hid_data;
>> +	struct hid_report *r;
>> +	struct hid_report_enum *re;
>> +
>> +	if (hid_data->inputformat < 0)
>> +		return 0;
>> +
>> +	re =3D &(hdev->report_enum[HID_FEATURE_REPORT]);
>> +	r =3D re->report_id_hash[hid_data->inputformat];
>> +	if (r) {
>> +		r->field[0]->value[hid_data->inputformat_index] =3D hid_data->inp=
utformat_value;
>> +		hid_hw_request(hdev, r, HID_REQ_SET_REPORT);
>> +	}
>> +	return 0;
>> +}
>> +
>>  static int wacom_set_device_mode(struct hid_device *hdev, int repor=
t_id,
>>  		int length, int mode)
>>  {
>> @@ -414,8 +459,14 @@ static int wacom_query_tablet_data(struct hid_d=
evice *hdev,
>>  	if (hdev->bus =3D=3D BUS_BLUETOOTH)
>>  		return wacom_bt_query_tablet_data(hdev, 1, features);
>> =20
>> -	if (features->type =3D=3D HID_GENERIC)
>> -		return wacom_hid_set_device_mode(hdev);
>> +	if (features->type =3D=3D HID_GENERIC) {
>> +		int err;
>> +		err =3D wacom_hid_set_device_mode(hdev);
>> +		if (err)
>> +			return err;
>> +		err =3D wacom_hid_set_device_format(hdev);
>=20
> I don't really see the difference between "input mode" and "input
> format". Does the device needs both to be set? If not, couldn't we
> extend the input mode feature for these usages?
>=20
> Cheers,
> Benjamin
>=20

Device / Input mode is a standard HID feature expected to be present on
Windows 7-compatible touch devices which is used to switch a device
between sending mouse, single, or multi-touch reports[1]. The
'wacom_hid_set_device_mode' function right now takes care of switching
into multi-touch mode provided the hid_data->inputmode field has been s=
et.

Input format on the other hand is a vendor-defined feature that is used
to switch Wacom devices (both touchscreens and tablets) between sending
standard HID reports or vendor-defined reports. Devices are supposed to
start up sending the former, but at least two tablet PCs have had
hardware that seems to remember being switched to the vendor-defined fo=
rmat.

If the format is explicitly switched to HID standard, we still should
probably set the mode as well since I don't think there's anything
implied about which mode the tablet should use after switching.

Relatedly, it's probably a good idea to rename 'wacom_set_device_mode'
or 'wacom_hid_set_device_mode' since they each set different a differen=
t
kind of "mode". It _might_ also be reasonable to rework
'wacom_set_device_mode' to be compatible with HID_GENERIC devices
(rather than introducing 'wacom_hid_set_device_format'), but keeping
compatibility the explicit devices might be tricky...

Off to work on V2...

[1]:
https://msdn.microsoft.com/en-us/library/windows/hardware/ff553739%28v=3D=
vs.85%29.aspx

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one /
(That is to say, eight) to the two, /
But you can=E2=80=99t take seven from three, /
So you look at the sixty-fours....

>> +		return err;
>> +	}
>> =20
>>  	if (features->device_type & WACOM_DEVICETYPE_TOUCH) {
>>  		if (features->type > TABLETPC) {
>> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
>> index 25baa7f..37d5dec 100644
>> --- a/drivers/hid/wacom_wac.h
>> +++ b/drivers/hid/wacom_wac.h
>> @@ -84,6 +84,12 @@
>>  #define WACOM_DEVICETYPE_WL_MONITOR     0x0008
>> =20
>>  #define WACOM_VENDORDEFINED_PEN		0xff0d0001
>> +#define WACOM_G9_PAGE			0xff090000
>> +#define WACOM_G9_DIGITIZER		(WACOM_G9_PAGE | 0x02)
>> +#define WACOM_G9_TOUCHSCREEN		(WACOM_G9_PAGE | 0x11)
>> +#define WACOM_G11_PAGE			0xff110000
>> +#define WACOM_G11_DIGITIZER		(WACOM_G11_PAGE | 0x02)
>> +#define WACOM_G11_TOUCHSCREEN		(WACOM_G11_PAGE | 0x11)
>> =20
>>  #define WACOM_PEN_FIELD(f)	(((f)->logical =3D=3D HID_DG_STYLUS) || =
\
>>  				 ((f)->physical =3D=3D HID_DG_STYLUS) || \
>> @@ -193,8 +199,11 @@ struct wacom_shared {
>>  };
>> =20
>>  struct hid_data {
>> -	__s16 inputmode;	/* InputMode HID feature, -1 if non-existent */
>> -	__s16 inputmode_index;	/* InputMode HID feature index in the repor=
t */
>> +	__s16 inputmode;		/* InputMode HID feature, -1 if non-existent */
>> +	__s16 inputmode_index;		/* InputMode HID feature index in the repo=
rt */
>> +	__s16 inputformat;		/* Vendor-defined "input format" feature, -1 i=
f non-existent */
>> +	__s16 inputformat_index;	/* Vendor-defined "input format" feature =
index in the report */
>> +	__u8  inputformat_value;	/* Value expected by device to switch to =
HID mode */
>>  	bool inrange_state;
>>  	bool invert_state;
>>  	bool tipswitch;
>> --=20
>> 2.7.3
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
