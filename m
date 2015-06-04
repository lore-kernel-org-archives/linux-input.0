From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 2/5] HID: wacom: Treat features->device_type values as
 flags
Date: Thu, 04 Jun 2015 14:04:38 -0700
Message-ID: <5570BD66.8020102@gmail.com>
References: <1433380697-28612-1-git-send-email-killertofu@gmail.com> <1433380697-28612-3-git-send-email-killertofu@gmail.com> <20150604185914.GF2495@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:34593 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753609AbbFDVEl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Jun 2015 17:04:41 -0400
Received: by pdbki1 with SMTP id ki1so38409338pdb.1
        for <linux-input@vger.kernel.org>; Thu, 04 Jun 2015 14:04:41 -0700 (PDT)
In-Reply-To: <20150604185914.GF2495@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>

On 6/4/2015 11:59 AM, Benjamin Tissoires wrote:
> On Jun 03 2015 or thereabouts, Jason Gerecke wrote:
>> The USB devices that this driver has historically supported segregat=
e the
>> pen and touch portions of the tablet. Oftentimes the segregation wou=
ld be
>> done at the interface level, though on occasion (e.g. Cintiq 24HDT) =
the
>> tablet would combine two totally independent USB devices behind an i=
nternal
>> USB hub. Because pen and touch never shared the same interface, it m=
ade
>> sense for the 'device_type' to store a single value: "pen" or "touch=
".
>>
>> Recently, however, some I2C devices have been created which combine =
the
>> two. A first step to accomodating this is to expand 'device_type' so=
 that
>> it can represent two (or potentially more) types simultaneously. To =
do
>> this, we treat it as a bitfield and set/check individual bits rather
>> than using the '=3D' and '=3D=3D' operators.
>>
>> This should not result in any functional change since no supported d=
evices
>> (that I'm aware of, at least) have HID descriptors that indicate bot=
h
>> pen and touch reports on a single interface.
>>
>> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
>> ---
>>  drivers/hid/wacom_sys.c | 35 ++++++++++++++++++-----------------
>>  drivers/hid/wacom_wac.c | 30 +++++++++++++++---------------
>>  drivers/hid/wacom_wac.h |  5 +++++
>>  3 files changed, 38 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
>> index bdf31c9..2b4cbd8 100644
>> --- a/drivers/hid/wacom_sys.c
>> +++ b/drivers/hid/wacom_sys.c
>> @@ -197,9 +197,9 @@ static void wacom_usage_mapping(struct hid_devic=
e *hdev,
>>  	* values commonly reported.
>>  	*/
>>  	if (pen)
>> -		features->device_type =3D BTN_TOOL_PEN;
>> +		features->device_type |=3D WACOM_DEVICETYPE_PEN;
>>  	else if (finger)
>> -		features->device_type =3D BTN_TOOL_FINGER;
>> +		features->device_type |=3D WACOM_DEVICETYPE_TOUCH;
>>  	else
>>  		return;
>> =20
>> @@ -411,7 +411,7 @@ static int wacom_query_tablet_data(struct hid_de=
vice *hdev,
>>  	if (features->type =3D=3D HID_GENERIC)
>>  		return wacom_hid_set_device_mode(hdev);
>> =20
>> -	if (features->device_type =3D=3D BTN_TOOL_FINGER) {
>> +	if (features->device_type & WACOM_DEVICETYPE_TOUCH) {
>>  		if (features->type > TABLETPC) {
>>  			/* MT Tablet PC touch */
>>  			return wacom_set_device_mode(hdev, 3, 4, 4);
>> @@ -425,7 +425,7 @@ static int wacom_query_tablet_data(struct hid_de=
vice *hdev,
>>  		else if (features->type =3D=3D BAMBOO_PAD) {
>>  			return wacom_set_device_mode(hdev, 2, 2, 2);
>>  		}
>> -	} else if (features->device_type =3D=3D BTN_TOOL_PEN) {
>> +	} else if (features->device_type & WACOM_DEVICETYPE_PEN) {
>>  		if (features->type <=3D BAMBOO_PT && features->type !=3D WIRELESS=
) {
>>  			return wacom_set_device_mode(hdev, 2, 2, 2);
>>  		}
>> @@ -454,9 +454,9 @@ static void wacom_retrieve_hid_descriptor(struct=
 hid_device *hdev,
>>  	 */
>>  	if (features->type =3D=3D WIRELESS) {
>>  		if (intf->cur_altsetting->desc.bInterfaceNumber =3D=3D 0) {
>> -			features->device_type =3D 0;
>> +			features->device_type =3D WACOM_DEVICETYPE_NONE;
>>  		} else if (intf->cur_altsetting->desc.bInterfaceNumber =3D=3D 2) =
{
>> -			features->device_type =3D BTN_TOOL_FINGER;
>> +			features->device_type |=3D WACOM_DEVICETYPE_TOUCH;
>>  			features->pktlen =3D WACOM_PKGLEN_BBTOUCH3;
>>  		}
>>  	}
>> @@ -538,9 +538,9 @@ static int wacom_add_shared_data(struct hid_devi=
ce *hdev)
>> =20
>>  	wacom_wac->shared =3D &data->shared;
>> =20
>> -	if (wacom_wac->features.device_type =3D=3D BTN_TOOL_FINGER)
>> +	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH)
>>  		wacom_wac->shared->touch =3D hdev;
>> -	else if (wacom_wac->features.device_type =3D=3D BTN_TOOL_PEN)
>> +	else if (wacom_wac->features.device_type & WACOM_DEVICETYPE_PEN)
>>  		wacom_wac->shared->pen =3D hdev;
>> =20
>>  out:
>> @@ -892,7 +892,7 @@ static int wacom_initialize_leds(struct wacom *w=
acom)
>>  	case INTUOSPS:
>>  	case INTUOSPM:
>>  	case INTUOSPL:
>> -		if (wacom->wacom_wac.features.device_type =3D=3D BTN_TOOL_PEN) {
>> +		if (wacom->wacom_wac.features.device_type & WACOM_DEVICETYPE_PEN)=
 {
>>  			wacom->led.select[0] =3D 0;
>>  			wacom->led.select[1] =3D 0;
>>  			wacom->led.llv =3D 32;
>> @@ -948,7 +948,7 @@ static void wacom_destroy_leds(struct wacom *wac=
om)
>>  	case INTUOSPS:
>>  	case INTUOSPM:
>>  	case INTUOSPL:
>> -		if (wacom->wacom_wac.features.device_type =3D=3D BTN_TOOL_PEN)
>> +		if (wacom->wacom_wac.features.device_type & WACOM_DEVICETYPE_PEN)
>>  			sysfs_remove_group(&wacom->hdev->dev.kobj,
>>  					   &intuos5_led_attr_group);
>>  		break;
>> @@ -1296,7 +1296,7 @@ static void wacom_wireless_work(struct work_st=
ruct *work)
>>  		/* Stylus interface */
>>  		wacom_wac1->features =3D
>>  			*((struct wacom_features *)id->driver_data);
>> -		wacom_wac1->features.device_type =3D BTN_TOOL_PEN;
>> +		wacom_wac1->features.device_type |=3D WACOM_DEVICETYPE_PEN;
>>  		snprintf(wacom_wac1->name, WACOM_NAME_MAX, "%s (WL) Pen",
>>  			 wacom_wac1->features.name);
>>  		snprintf(wacom_wac1->pad_name, WACOM_NAME_MAX, "%s (WL) Pad",
>> @@ -1315,7 +1315,7 @@ static void wacom_wireless_work(struct work_st=
ruct *work)
>>  			wacom_wac2->features =3D
>>  				*((struct wacom_features *)id->driver_data);
>>  			wacom_wac2->features.pktlen =3D WACOM_PKGLEN_BBTOUCH3;
>> -			wacom_wac2->features.device_type =3D BTN_TOOL_FINGER;
>> +			wacom_wac2->features.device_type |=3D WACOM_DEVICETYPE_TOUCH;
>>  			wacom_wac2->features.x_max =3D wacom_wac2->features.y_max =3D 40=
96;
>>  			if (wacom_wac2->features.touch_max)
>>  				snprintf(wacom_wac2->name, WACOM_NAME_MAX,
>> @@ -1451,11 +1451,11 @@ static void wacom_update_name(struct wacom *=
wacom)
>>  	snprintf(wacom_wac->pad_name, sizeof(wacom_wac->pad_name),
>>  		"%s Pad", name);
>> =20
>> -	if (features->device_type =3D=3D BTN_TOOL_PEN) {
>> +	if (features->device_type & WACOM_DEVICETYPE_PEN) {
>>  		snprintf(wacom_wac->name, sizeof(wacom_wac->name),
>>  			"%s Pen", name);
>>  	}
>> -	else if (features->device_type =3D=3D BTN_TOOL_FINGER) {
>> +	else if (features->device_type & WACOM_DEVICETYPE_TOUCH) {
>>  		if (features->touch_max)
>>  			snprintf(wacom_wac->name, sizeof(wacom_wac->name),
>>  				"%s Finger", name);
>> @@ -1545,7 +1545,8 @@ static int wacom_probe(struct hid_device *hdev=
,
>>  	wacom_retrieve_hid_descriptor(hdev, features);
>>  	wacom_setup_device_quirks(wacom);
>> =20
>> -	if (!features->device_type && features->type !=3D WIRELESS) {
>> +	if (features->device_type =3D=3D WACOM_DEVICETYPE_NONE &&
>> +	    features->type !=3D WIRELESS) {
>>  		error =3D features->type =3D=3D HID_GENERIC ? -ENODEV : 0;
>> =20
>>  		dev_warn(&hdev->dev, "Unknown device_type for '%s'. %s.",
>> @@ -1555,7 +1556,7 @@ static int wacom_probe(struct hid_device *hdev=
,
>>  		if (error)
>>  			goto fail_shared_data;
>> =20
>> -		features->device_type =3D BTN_TOOL_PEN;
>> +		features->device_type |=3D WACOM_DEVICETYPE_PEN;
>>  	}
>> =20
>>  	wacom_calculate_res(features);
>> @@ -1604,7 +1605,7 @@ static int wacom_probe(struct hid_device *hdev=
,
>>  		error =3D hid_hw_open(hdev);
>> =20
>>  	if (wacom_wac->features.type =3D=3D INTUOSHT && wacom_wac->feature=
s.touch_max) {
>> -		if (wacom_wac->features.device_type =3D=3D BTN_TOOL_FINGER)
>> +		if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH)
>>  			wacom_wac->shared->touch_input =3D wacom_wac->input;
>>  	}
>> =20
>> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
>> index a52fc25..5e7710d 100644
>> --- a/drivers/hid/wacom_wac.c
>> +++ b/drivers/hid/wacom_wac.c
>> @@ -2168,7 +2168,7 @@ void wacom_setup_device_quirks(struct wacom *w=
acom)
>>  	struct wacom_features *features =3D &wacom->wacom_wac.features;
>> =20
>>  	/* touch device found but size is not defined. use default */
>> -	if (features->device_type =3D=3D BTN_TOOL_FINGER && !features->x_m=
ax) {
>> +	if (features->device_type & WACOM_DEVICETYPE_TOUCH && !features->x=
_max) {
>>  		features->x_max =3D 1023;
>>  		features->y_max =3D 1023;
>=20
> As you mentioned, we are safe right now because there is no device th=
at
> shares both pen and touch on the same HID interface (expect the one y=
ou
> are making the patch series for).
>=20
> I am just wondering if this will not bite us back when we will have t=
o
> use a features->x_pen_max and features_x_touch_max for the same
> interface.
> No need to change it now (I guess we are fine with HID generic device=
s
> right now), but this is something we might want to have in our heads =
in
> the future.
>=20
> Cheers,
> Benjamin
>=20
See my comments on patch 5. I'm in complete agreement -- I don't think
it's an issue (thanks to HID_GENERIC), but the design is a little creak=
y
given the kinds of devices out there. I'd like to see the driver be mor=
e
tool-centric and not have to repeat myself three times in every functio=
n
to e.g. set the name of the pen, touch, and pad device.

--=20
Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one /
(That is to say, eight) to the two, /
But you can=E2=80=99t take seven from three, /
So you look at the sixty-fours....

>>  	}
>> @@ -2182,7 +2182,7 @@ void wacom_setup_device_quirks(struct wacom *w=
acom)
>>  	if ((features->type >=3D INTUOS5S && features->type <=3D INTUOSHT)=
 ||
>>  		(features->type =3D=3D BAMBOO_PT)) {
>>  		if (features->pktlen =3D=3D WACOM_PKGLEN_BBTOUCH3) {
>> -			features->device_type =3D BTN_TOOL_FINGER;
>> +			features->device_type |=3D WACOM_DEVICETYPE_TOUCH;
>> =20
>>  			features->x_max =3D 4096;
>>  			features->y_max =3D 4096;
>> @@ -2197,7 +2197,7 @@ void wacom_setup_device_quirks(struct wacom *w=
acom)
>>  	 * so rewrite this one to be of type BTN_TOOL_FINGER.
>>  	 */
>>  	if (features->type =3D=3D BAMBOO_PAD)
>> -		features->device_type =3D BTN_TOOL_FINGER;
>> +		features->device_type |=3D WACOM_DEVICETYPE_TOUCH;
>> =20
>>  	if (wacom->hdev->bus =3D=3D BUS_BLUETOOTH)
>>  		features->quirks |=3D WACOM_QUIRK_BATTERY;
>> @@ -2218,7 +2218,7 @@ void wacom_setup_device_quirks(struct wacom *w=
acom)
>>  		features->quirks |=3D WACOM_QUIRK_NO_INPUT;
>> =20
>>  		/* must be monitor interface if no device_type set */
>> -		if (!features->device_type) {
>> +		if (features->device_type =3D=3D WACOM_DEVICETYPE_NONE) {
>>  			features->quirks |=3D WACOM_QUIRK_MONITOR;
>>  			features->quirks |=3D WACOM_QUIRK_BATTERY;
>>  		}
>> @@ -2230,7 +2230,7 @@ static void wacom_abs_set_axis(struct input_de=
v *input_dev,
>>  {
>>  	struct wacom_features *features =3D &wacom_wac->features;
>> =20
>> -	if (features->device_type =3D=3D BTN_TOOL_PEN) {
>> +	if (features->device_type & WACOM_DEVICETYPE_PEN) {
>>  		input_set_abs_params(input_dev, ABS_X, features->x_min,
>>  				     features->x_max, features->x_fuzz, 0);
>>  		input_set_abs_params(input_dev, ABS_Y, features->y_min,
>> @@ -2349,7 +2349,7 @@ int wacom_setup_pentouch_input_capabilities(st=
ruct input_dev *input_dev,
>>  	case INTUOSPS:
>>  		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
>> =20
>> -		if (features->device_type =3D=3D BTN_TOOL_PEN) {
>> +		if (features->device_type & WACOM_DEVICETYPE_PEN) {
>>  			input_set_abs_params(input_dev, ABS_DISTANCE, 0,
>>  					      features->distance_max,
>>  					      0, 0);
>> @@ -2358,7 +2358,7 @@ int wacom_setup_pentouch_input_capabilities(st=
ruct input_dev *input_dev,
>>  			input_abs_set_res(input_dev, ABS_Z, 287);
>> =20
>>  			wacom_setup_intuos(wacom_wac);
>> -		} else if (features->device_type =3D=3D BTN_TOOL_FINGER) {
>> +		} else if (features->device_type & WACOM_DEVICETYPE_TOUCH) {
>>  			__clear_bit(ABS_MISC, input_dev->absbit);
>> =20
>>  			input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
>> @@ -2370,7 +2370,7 @@ int wacom_setup_pentouch_input_capabilities(st=
ruct input_dev *input_dev,
>>  		break;
>> =20
>>  	case WACOM_24HDT:
>> -		if (features->device_type =3D=3D BTN_TOOL_FINGER) {
>> +		if (features->device_type & WACOM_DEVICETYPE_TOUCH) {
>>  			input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, features-=
>x_max, 0, 0);
>>  			input_set_abs_params(input_dev, ABS_MT_WIDTH_MAJOR, 0, features-=
>x_max, 0, 0);
>>  			input_set_abs_params(input_dev, ABS_MT_WIDTH_MINOR, 0, features-=
>y_max, 0, 0);
>> @@ -2383,7 +2383,7 @@ int wacom_setup_pentouch_input_capabilities(st=
ruct input_dev *input_dev,
>>  	case MTTPC:
>>  	case MTTPC_B:
>>  	case TABLETPC2FG:
>> -		if (features->device_type =3D=3D BTN_TOOL_FINGER && features->tou=
ch_max > 1)
>> +		if (features->device_type & WACOM_DEVICETYPE_TOUCH && features->t=
ouch_max > 1)
>>  			input_mt_init_slots(input_dev, features->touch_max, INPUT_MT_DIR=
ECT);
>>  		/* fall through */
>> =20
>> @@ -2393,7 +2393,7 @@ int wacom_setup_pentouch_input_capabilities(st=
ruct input_dev *input_dev,
>> =20
>>  		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
>> =20
>> -		if (features->device_type !=3D BTN_TOOL_PEN)
>> +		if (!(features->device_type & WACOM_DEVICETYPE_PEN))
>>  			break;  /* no need to process stylus stuff */
>> =20
>>  		/* fall through */
>> @@ -2424,7 +2424,7 @@ int wacom_setup_pentouch_input_capabilities(st=
ruct input_dev *input_dev,
>> =20
>>  	case INTUOSHT:
>>  		if (features->touch_max &&
>> -		    features->device_type =3D=3D BTN_TOOL_FINGER) {
>> +		    features->device_type & WACOM_DEVICETYPE_TOUCH) {
>>  			input_dev->evbit[0] |=3D BIT_MASK(EV_SW);
>>  			__set_bit(SW_MUTE_DEVICE, input_dev->swbit);
>>  		}
>> @@ -2433,7 +2433,7 @@ int wacom_setup_pentouch_input_capabilities(st=
ruct input_dev *input_dev,
>>  	case BAMBOO_PT:
>>  		__clear_bit(ABS_MISC, input_dev->absbit);
>> =20
>> -		if (features->device_type =3D=3D BTN_TOOL_FINGER) {
>> +		if (features->device_type & WACOM_DEVICETYPE_TOUCH) {
>> =20
>>  			if (features->touch_max) {
>>  				if (features->pktlen =3D=3D WACOM_PKGLEN_BBTOUCH3) {
>> @@ -2454,7 +2454,7 @@ int wacom_setup_pentouch_input_capabilities(st=
ruct input_dev *input_dev,
>>  				/* PAD is setup by wacom_setup_pad_input_capabilities later */
>>  				return 1;
>>  			}
>> -		} else if (features->device_type =3D=3D BTN_TOOL_PEN) {
>> +		} else if (features->device_type & WACOM_DEVICETYPE_PEN) {
>>  			__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
>>  			__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
>>  			__set_bit(BTN_TOOL_PEN, input_dev->keybit);
>> @@ -2619,7 +2619,7 @@ int wacom_setup_pad_input_capabilities(struct =
input_dev *input_dev,
>>  	case INTUOS5S:
>>  	case INTUOSPS:
>>  		/* touch interface does not have the pad device */
>> -		if (features->device_type !=3D BTN_TOOL_PEN)
>> +		if (!(features->device_type & WACOM_DEVICETYPE_PEN))
>>  			return -ENODEV;
>> =20
>>  		for (i =3D 0; i < 7; i++)
>> @@ -2664,7 +2664,7 @@ int wacom_setup_pad_input_capabilities(struct =
input_dev *input_dev,
>>  	case INTUOSHT:
>>  	case BAMBOO_PT:
>>  		/* pad device is on the touch interface */
>> -		if ((features->device_type !=3D BTN_TOOL_FINGER) ||
>> +		if (!(features->device_type & WACOM_DEVICETYPE_TOUCH) ||
>>  		    /* Bamboo Pen only tablet does not have pad */
>>  		    ((features->type =3D=3D BAMBOO_PT) && !features->touch_max))
>>  			return -ENODEV;
>> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
>> index 9a5ee62..da2b309 100644
>> --- a/drivers/hid/wacom_wac.h
>> +++ b/drivers/hid/wacom_wac.h
>> @@ -72,6 +72,11 @@
>>  #define WACOM_QUIRK_MONITOR		0x0004
>>  #define WACOM_QUIRK_BATTERY		0x0008
>> =20
>> +/* device types */
>> +#define WACOM_DEVICETYPE_NONE           0x0000
>> +#define WACOM_DEVICETYPE_PEN            0x0001
>> +#define WACOM_DEVICETYPE_TOUCH          0x0002
>> +
>>  #define WACOM_VENDORDEFINED_PEN		0xff0d0001
>> =20
>>  #define WACOM_PEN_FIELD(f)	(((f)->logical =3D=3D HID_DG_STYLUS) || =
\
>> --=20
>> 2.4.1
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
