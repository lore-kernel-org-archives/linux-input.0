From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 5/5] HID: wacom: Introduce new 'touch_input' device
Date: Thu, 04 Jun 2015 13:49:08 -0700
Message-ID: <5570B9C4.7080901@gmail.com>
References: <1433380697-28612-1-git-send-email-killertofu@gmail.com> <1433380697-28612-6-git-send-email-killertofu@gmail.com> <20150604185614.GE2495@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:33386 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591AbbFDUtM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Jun 2015 16:49:12 -0400
Received: by pdjn11 with SMTP id n11so343978pdj.0
        for <linux-input@vger.kernel.org>; Thu, 04 Jun 2015 13:49:12 -0700 (PDT)
In-Reply-To: <20150604185614.GE2495@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>

On 6/4/2015 11:56 AM, Benjamin Tissoires wrote:
> Hi Jason,
>=20
> On Jun 03 2015 or thereabouts, Jason Gerecke wrote:
>> Instead of having a single 'input_dev' device that will take either =
pen
>> or touch data depending on the type of the device, create seperate d=
evices
>> devices for each. By splitting things like this, we can support devi=
ces
>> (e.g. the I2C "AES" sensors in some newer tablet PCs) that send both=
 pen
>> and touch reports from a single endpoint.
>>
>> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
>> ---
>=20
> Besides the Wacom PAD problem already mentioned in the 0/5 thread (I
> will test it tomorrow and come with a following patch if need), I hav=
e 2
> nitpicks here:
>=20
>>  drivers/hid/wacom_sys.c | 118 +++++++++++++++++++++++++++++--------=
-----------
>>  drivers/hid/wacom_wac.c | 108 ++++++++++++++++++++++++-------------=
-------
>>  drivers/hid/wacom_wac.h |   9 ++--
>>  3 files changed, 135 insertions(+), 100 deletions(-)
>>
>> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
>> index a213a8a..a928c1d 100644
>> --- a/drivers/hid/wacom_sys.c
>> +++ b/drivers/hid/wacom_sys.c
>> @@ -253,7 +253,7 @@ static void wacom_post_parse_hid(struct hid_devi=
ce *hdev,
>>  	if (features->type =3D=3D HID_GENERIC) {
>>  		/* Any last-minute generic device setup */
>>  		if (features->touch_max > 1) {
>> -			input_mt_init_slots(wacom_wac->input, wacom_wac->features.touch_=
max,
>> +			input_mt_init_slots(wacom_wac->touch_input, wacom_wac->features.=
touch_max,
>>  				    INPUT_MT_DIRECT);
>>  		}
>>  	}
>> @@ -1130,7 +1130,7 @@ static struct input_dev *wacom_allocate_input(=
struct wacom *wacom)
>>  	if (!input_dev)
>>  		return NULL;
>> =20
>> -	input_dev->name =3D wacom_wac->name;
>> +	input_dev->name =3D wacom_wac->pen_name;
>>  	input_dev->phys =3D hdev->phys;
>>  	input_dev->dev.parent =3D &hdev->dev;
>>  	input_dev->open =3D wacom_open;
>> @@ -1149,27 +1149,33 @@ static void wacom_free_inputs(struct wacom *=
wacom)
>>  {
>>  	struct wacom_wac *wacom_wac =3D &(wacom->wacom_wac);
>> =20
>> -	if (wacom_wac->input)
>> -		input_free_device(wacom_wac->input);
>> +	if (wacom_wac->pen_input)
>> +		input_free_device(wacom_wac->pen_input);
>> +	if (wacom_wac->touch_input)
>> +		input_free_device(wacom_wac->touch_input);
>>  	if (wacom_wac->pad_input)
>>  		input_free_device(wacom_wac->pad_input);
>> -	wacom_wac->input =3D NULL;
>> +	wacom_wac->pen_input =3D NULL;
>> +	wacom_wac->touch_input =3D NULL;
>>  	wacom_wac->pad_input =3D NULL;
>>  }
>> =20
>>  static int wacom_allocate_inputs(struct wacom *wacom)
>>  {
>> -	struct input_dev *input_dev, *pad_input_dev;
>> +	struct input_dev *pen_input_dev, *touch_input_dev, *pad_input_dev;
>>  	struct wacom_wac *wacom_wac =3D &(wacom->wacom_wac);
>> =20
>> -	input_dev =3D wacom_allocate_input(wacom);
>> +	pen_input_dev =3D wacom_allocate_input(wacom);
>> +	touch_input_dev =3D wacom_allocate_input(wacom);
>>  	pad_input_dev =3D wacom_allocate_input(wacom);
>=20
> I know you are not introducing anything new here, but that means that
> now, we reserve 3 input devices, while we might not even use one.
>=20
> I just wonder if we should not start having a smarter input allocatio=
n
> in wacom.ko where we would create the inputs only if they are needed.
> IIRC, I came to use this extra pad input node to have all the bits in
> place while parsing the report descriptor, but maybe we could be
> smarter.
>=20
I've been considering this as well. I was thinking about creating some
kind of structure to allow us to better separate the individual tools
(e.g. a kind of tool-specific "wacom_wac" with name, input device, and
features [addressing your concerns in patch 2]) but haven't come up wit=
h
a good design yet. Its on my list of back-burner tasks, though we might
be able to do something about the excess allocations themselves without
quite as much work.

>> -	if (!input_dev || !pad_input_dev) {
>> +	if (!pen_input_dev || !touch_input_dev || !pad_input_dev) {
>>  		wacom_free_inputs(wacom);
>>  		return -ENOMEM;
>>  	}
>> =20
>> -	wacom_wac->input =3D input_dev;
>> +	wacom_wac->pen_input =3D pen_input_dev;
>> +	wacom_wac->touch_input =3D touch_input_dev;
>> +	wacom_wac->touch_input->name =3D wacom_wac->touch_name;
>>  	wacom_wac->pad_input =3D pad_input_dev;
>>  	wacom_wac->pad_input->name =3D wacom_wac->pad_name;
>> =20
>> @@ -1178,11 +1184,17 @@ static int wacom_allocate_inputs(struct waco=
m *wacom)
>> =20
>>  static void wacom_clean_inputs(struct wacom *wacom)
>>  {
>> -	if (wacom->wacom_wac.input) {
>> -		if (wacom->wacom_wac.input_registered)
>> -			input_unregister_device(wacom->wacom_wac.input);
>> +	if (wacom->wacom_wac.pen_input) {
>> +		if (wacom->wacom_wac.pen_registered)
>> +			input_unregister_device(wacom->wacom_wac.pen_input);
>>  		else
>> -			input_free_device(wacom->wacom_wac.input);
>> +			input_free_device(wacom->wacom_wac.pen_input);
>> +	}
>> +	if (wacom->wacom_wac.touch_input) {
>> +		if (wacom->wacom_wac.touch_registered)
>> +			input_unregister_device(wacom->wacom_wac.touch_input);
>> +		else
>> +			input_free_device(wacom->wacom_wac.touch_input);
>>  	}
>>  	if (wacom->wacom_wac.pad_input) {
>>  		if (wacom->wacom_wac.pad_registered)
>> @@ -1190,33 +1202,49 @@ static void wacom_clean_inputs(struct wacom =
*wacom)
>>  		else
>>  			input_free_device(wacom->wacom_wac.pad_input);
>>  	}
>> -	wacom->wacom_wac.input =3D NULL;
>> +	wacom->wacom_wac.pen_input =3D NULL;
>> +	wacom->wacom_wac.touch_input =3D NULL;
>>  	wacom->wacom_wac.pad_input =3D NULL;
>>  	wacom_destroy_leds(wacom);
>>  }
>> =20
>>  static int wacom_register_inputs(struct wacom *wacom)
>>  {
>> -	struct input_dev *input_dev, *pad_input_dev;
>> +	struct input_dev *pen_input_dev, *touch_input_dev, *pad_input_dev;
>>  	struct wacom_wac *wacom_wac =3D &(wacom->wacom_wac);
>> -	struct wacom_features *features =3D &wacom_wac->features;
>>  	int error =3D 0;
>> =20
>> -	input_dev =3D wacom_wac->input;
>> +	pen_input_dev =3D wacom_wac->pen_input;
>> +	touch_input_dev =3D wacom_wac->touch_input;
>>  	pad_input_dev =3D wacom_wac->pad_input;
>> =20
>> -	if (!input_dev || !pad_input_dev)
>> +	if (!pen_input_dev || !touch_input_dev || !pad_input_dev)
>>  		return -EINVAL;
>> =20
>> -	if (features->device_type & WACOM_DEVICETYPE_PEN)
>> -		error =3D wacom_setup_pen_input_capabilities(input_dev, wacom_wac=
);
>> -	if (!error && features->device_type & WACOM_DEVICETYPE_TOUCH)
>> -		error =3D wacom_setup_touch_input_capabilities(input_dev, wacom_w=
ac);
>> -	if (!error) {
>> -		error =3D input_register_device(input_dev);
>> +	error =3D wacom_setup_pen_input_capabilities(pen_input_dev, wacom_=
wac);
>> +	if (error) {
>> +		/* no pen in use on this interface */
>> +		input_free_device(pen_input_dev);
>> +		wacom_wac->pen_input =3D NULL;
>> +		pen_input_dev =3D NULL;
>> +	} else {
>> +		error =3D input_register_device(pen_input_dev);
>>  		if (error)
>> -			return error;
>> -		wacom_wac->input_registered =3D true;
>> +			goto fail_register_pen_input;
>> +		wacom_wac->pen_registered =3D true;
>> +	}
>> +
>> +	error =3D wacom_setup_touch_input_capabilities(touch_input_dev, wa=
com_wac);
>> +	if (error) {
>> +		/* no touch in use on this interface */
>> +		input_free_device(touch_input_dev);
>> +		wacom_wac->touch_input =3D NULL;
>> +		touch_input_dev =3D NULL;
>> +	} else {
>> +		error =3D input_register_device(touch_input_dev);
>> +		if (error)
>> +			goto fail_register_touch_input;
>> +		wacom_wac->touch_registered =3D true;
>>  	}
>> =20
>>  	error =3D wacom_setup_pad_input_capabilities(pad_input_dev, wacom_=
wac);
>> @@ -1243,9 +1271,14 @@ fail_leds:
>>  	pad_input_dev =3D NULL;
>>  	wacom_wac->pad_registered =3D false;
>>  fail_register_pad_input:
>> -	input_unregister_device(input_dev);
>> -	wacom_wac->input =3D NULL;
>> -	wacom_wac->input_registered =3D false;
>> +	input_unregister_device(touch_input_dev);
>> +	wacom_wac->touch_input =3D NULL;
>> +	wacom_wac->touch_registered =3D false;
>> +fail_register_touch_input:
>> +	input_unregister_device(pen_input_dev);
>> +	wacom_wac->pen_input =3D NULL;
>> +	wacom_wac->pen_registered =3D false;
>> +fail_register_pen_input:
>>  	return error;
>>  }
>> =20
>> @@ -1303,7 +1336,7 @@ static void wacom_wireless_work(struct work_st=
ruct *work)
>>  		wacom_wac1->features =3D
>>  			*((struct wacom_features *)id->driver_data);
>>  		wacom_wac1->features.device_type |=3D WACOM_DEVICETYPE_PEN;
>> -		snprintf(wacom_wac1->name, WACOM_NAME_MAX, "%s (WL) Pen",
>> +		snprintf(wacom_wac1->pen_name, WACOM_NAME_MAX, "%s (WL) Pen",
>>  			 wacom_wac1->features.name);
>>  		snprintf(wacom_wac1->pad_name, WACOM_NAME_MAX, "%s (WL) Pad",
>>  			 wacom_wac1->features.name);
>> @@ -1324,11 +1357,11 @@ static void wacom_wireless_work(struct work_=
struct *work)
>>  			wacom_wac2->features.x_max =3D wacom_wac2->features.y_max =3D 40=
96;
>>  			if (wacom_wac2->features.touch_max) {
>>  				wacom_wac2->features.device_type |=3D WACOM_DEVICETYPE_TOUCH;
>> -				snprintf(wacom_wac2->name, WACOM_NAME_MAX,
>> +				snprintf(wacom_wac2->touch_name, WACOM_NAME_MAX,
>>  					 "%s (WL) Finger",wacom_wac2->features.name);
>>  			} else {
>>  				wacom_wac2->features.device_type |=3D WACOM_DEVICETYPE_PAD;
>> -				snprintf(wacom_wac2->name, WACOM_NAME_MAX,
>> +				snprintf(wacom_wac2->pad_name, WACOM_NAME_MAX,
>>  					 "%s (WL) Pad",wacom_wac2->features.name);
>>  			}
>>  			snprintf(wacom_wac2->pad_name, WACOM_NAME_MAX,
>> @@ -1341,7 +1374,7 @@ static void wacom_wireless_work(struct work_st=
ruct *work)
>> =20
>>  			if (wacom_wac1->features.type =3D=3D INTUOSHT &&
>>  			    wacom_wac1->features.touch_max)
>> -				wacom_wac->shared->touch_input =3D wacom_wac2->input;
>> +				wacom_wac->shared->touch_input =3D wacom_wac2->pen_input;
>>  		}
>> =20
>>  		error =3D wacom_initialize_battery(wacom);
>> @@ -1456,21 +1489,12 @@ static void wacom_update_name(struct wacom *=
wacom)
>>  	}
>> =20
>>  	/* Append the device type to the name */
>> +	snprintf(wacom_wac->pen_name, sizeof(wacom_wac->pen_name),
>> +		"%s Pad", name);
>=20
> typo, this should be "%s Pen"
>=20
ACK. Will be fixed in v2 :)
>=20
> The rest of the series looks fine. I have one more comment to add in =
2/5
> but it does not change the whole behaviour. I will try to go a little
> bit deeper in the review tomorrow, but for now, this is a good start =
:)
>=20
> Cheers,
> Benjamin
>=20

Thanks. There's definitely a chance for subtle interactions, and while =
I
hope I've covered all my bases I'm glad to have the extra eyes and brai=
n
cells :D

--=20
Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one /
(That is to say, eight) to the two, /
But you can=E2=80=99t take seven from three, /
So you look at the sixty-fours....

>> +	snprintf(wacom_wac->touch_name, sizeof(wacom_wac->touch_name),
>> +		"%s Touch", name);
>>  	snprintf(wacom_wac->pad_name, sizeof(wacom_wac->pad_name),
>>  		"%s Pad", name);
>> -
>> -	if (features->device_type & WACOM_DEVICETYPE_PEN) {
>> -		snprintf(wacom_wac->name, sizeof(wacom_wac->name),
>> -			"%s Pen", name);
>> -	}
>> -	else if (features->device_type & WACOM_DEVICETYPE_TOUCH) {
>> -		snprintf(wacom_wac->name, sizeof(wacom_wac->name),
>> -			"%s Finger", name);
>> -	}
>> -	else if (features->device_type & WACOM_DEVICETYPE_PAD) {
>> -		snprintf(wacom_wac->name, sizeof(wacom_wac->name),
>> -			"%s Pad", name);
>> -	}
>>  }
>> =20
>>  static int wacom_probe(struct hid_device *hdev,
>> @@ -1614,7 +1638,7 @@ static int wacom_probe(struct hid_device *hdev=
,
>> =20
>>  	if (wacom_wac->features.type =3D=3D INTUOSHT &&=20
>>  	    wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH) {
>> -			wacom_wac->shared->touch_input =3D wacom_wac->input;
>> +			wacom_wac->shared->touch_input =3D wacom_wac->pen_input;
>>  	}
>> =20
>>  	return 0;
>> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
>> index 318d9d3..94334be 100644
>> --- a/drivers/hid/wacom_wac.c
>> +++ b/drivers/hid/wacom_wac.c
>> @@ -69,7 +69,7 @@ static void wacom_notify_battery(struct wacom_wac =
*wacom_wac,
>>  static int wacom_penpartner_irq(struct wacom_wac *wacom)
>>  {
>>  	unsigned char *data =3D wacom->data;
>> -	struct input_dev *input =3D wacom->input;
>> +	struct input_dev *input =3D wacom->pen_input;
>> =20
>>  	switch (data[0]) {
>>  	case 1:
>> @@ -114,7 +114,7 @@ static int wacom_pl_irq(struct wacom_wac *wacom)
>>  {
>>  	struct wacom_features *features =3D &wacom->features;
>>  	unsigned char *data =3D wacom->data;
>> -	struct input_dev *input =3D wacom->input;
>> +	struct input_dev *input =3D wacom->pen_input;
>>  	int prox, pressure;
>> =20
>>  	if (data[0] !=3D WACOM_REPORT_PENABLED) {
>> @@ -186,7 +186,7 @@ static int wacom_pl_irq(struct wacom_wac *wacom)
>>  static int wacom_ptu_irq(struct wacom_wac *wacom)
>>  {
>>  	unsigned char *data =3D wacom->data;
>> -	struct input_dev *input =3D wacom->input;
>> +	struct input_dev *input =3D wacom->pen_input;
>> =20
>>  	if (data[0] !=3D WACOM_REPORT_PENABLED) {
>>  		dev_dbg(input->dev.parent,
>> @@ -215,7 +215,7 @@ static int wacom_ptu_irq(struct wacom_wac *wacom=
)
>>  static int wacom_dtu_irq(struct wacom_wac *wacom)
>>  {
>>  	unsigned char *data =3D wacom->data;
>> -	struct input_dev *input =3D wacom->input;
>> +	struct input_dev *input =3D wacom->pen_input;
>>  	int prox =3D data[1] & 0x20;
>> =20
>>  	dev_dbg(input->dev.parent,
>> @@ -245,7 +245,7 @@ static int wacom_dtu_irq(struct wacom_wac *wacom=
)
>>  static int wacom_dtus_irq(struct wacom_wac *wacom)
>>  {
>>  	char *data =3D wacom->data;
>> -	struct input_dev *input =3D wacom->input;
>> +	struct input_dev *input =3D wacom->pen_input;
>>  	unsigned short prox, pressure =3D 0;
>> =20
>>  	if (data[0] !=3D WACOM_REPORT_DTUS && data[0] !=3D WACOM_REPORT_DT=
USPAD) {
>> @@ -297,7 +297,7 @@ static int wacom_graphire_irq(struct wacom_wac *=
wacom)
>>  {
>>  	struct wacom_features *features =3D &wacom->features;
>>  	unsigned char *data =3D wacom->data;
>> -	struct input_dev *input =3D wacom->input;
>> +	struct input_dev *input =3D wacom->pen_input;
>>  	struct input_dev *pad_input =3D wacom->pad_input;
>>  	int battery_capacity, ps_connected;
>>  	int prox;
>> @@ -464,7 +464,7 @@ static int wacom_intuos_inout(struct wacom_wac *=
wacom)
>>  {
>>  	struct wacom_features *features =3D &wacom->features;
>>  	unsigned char *data =3D wacom->data;
>> -	struct input_dev *input =3D wacom->input;
>> +	struct input_dev *input =3D wacom->pen_input;
>>  	int idx =3D 0;
>> =20
>>  	/* tool number */
>> @@ -649,7 +649,7 @@ static void wacom_intuos_general(struct wacom_wa=
c *wacom)
>>  {
>>  	struct wacom_features *features =3D &wacom->features;
>>  	unsigned char *data =3D wacom->data;
>> -	struct input_dev *input =3D wacom->input;
>> +	struct input_dev *input =3D wacom->pen_input;
>>  	unsigned int t;
>> =20
>>  	/* general pen packet */
>> @@ -681,7 +681,7 @@ static int wacom_intuos_irq(struct wacom_wac *wa=
com)
>>  {
>>  	struct wacom_features *features =3D &wacom->features;
>>  	unsigned char *data =3D wacom->data;
>> -	struct input_dev *input =3D wacom->input;
>> +	struct input_dev *input =3D wacom->pen_input;
>>  	unsigned int t;
>>  	int idx =3D 0, result;
>> =20
>> @@ -1025,7 +1025,7 @@ static void wacom_intuos_bt_process_data(struc=
t wacom_wac *wacom,
>>  	memcpy(wacom->data, data, 10);
>>  	wacom_intuos_irq(wacom);
>> =20
>> -	input_sync(wacom->input);
>> +	input_sync(wacom->pen_input);
>>  	if (wacom->pad_input)
>>  		input_sync(wacom->pad_input);
>>  }
>> @@ -1057,7 +1057,7 @@ static int wacom_intuos_bt_irq(struct wacom_wa=
c *wacom, size_t len)
>>  				     ps_connected);
>>  		break;
>>  	default:
>> -		dev_dbg(wacom->input->dev.parent,
>> +		dev_dbg(wacom->pen_input->dev.parent,
>>  				"Unknown report: %d,%d size:%zu\n",
>>  				data[0], data[1], len);
>>  		return 0;
>> @@ -1067,7 +1067,7 @@ static int wacom_intuos_bt_irq(struct wacom_wa=
c *wacom, size_t len)
>> =20
>>  static int wacom_wac_finger_count_touches(struct wacom_wac *wacom)
>>  {
>> -	struct input_dev *input =3D wacom->input;
>> +	struct input_dev *input =3D wacom->touch_input;
>>  	unsigned touch_max =3D wacom->features.touch_max;
>>  	int count =3D 0;
>>  	int i;
>> @@ -1088,7 +1088,7 @@ static int wacom_wac_finger_count_touches(stru=
ct wacom_wac *wacom)
>> =20
>>  static int wacom_24hdt_irq(struct wacom_wac *wacom)
>>  {
>> -	struct input_dev *input =3D wacom->input;
>> +	struct input_dev *input =3D wacom->touch_input;
>>  	unsigned char *data =3D wacom->data;
>>  	int i;
>>  	int current_num_contacts =3D data[61];
>> @@ -1156,7 +1156,7 @@ static int wacom_24hdt_irq(struct wacom_wac *w=
acom)
>> =20
>>  static int wacom_mt_touch(struct wacom_wac *wacom)
>>  {
>> -	struct input_dev *input =3D wacom->input;
>> +	struct input_dev *input =3D wacom->touch_input;
>>  	unsigned char *data =3D wacom->data;
>>  	int i;
>>  	int current_num_contacts =3D data[2];
>> @@ -1207,7 +1207,7 @@ static int wacom_mt_touch(struct wacom_wac *wa=
com)
>> =20
>>  static int wacom_tpc_mt_touch(struct wacom_wac *wacom)
>>  {
>> -	struct input_dev *input =3D wacom->input;
>> +	struct input_dev *input =3D wacom->touch_input;
>>  	unsigned char *data =3D wacom->data;
>>  	int i;
>> =20
>> @@ -1236,7 +1236,7 @@ static int wacom_tpc_mt_touch(struct wacom_wac=
 *wacom)
>>  static int wacom_tpc_single_touch(struct wacom_wac *wacom, size_t l=
en)
>>  {
>>  	unsigned char *data =3D wacom->data;
>> -	struct input_dev *input =3D wacom->input;
>> +	struct input_dev *input =3D wacom->touch_input;
>>  	bool prox =3D !wacom->shared->stylus_in_proximity;
>>  	int x =3D 0, y =3D 0;
>> =20
>> @@ -1272,7 +1272,7 @@ static int wacom_tpc_single_touch(struct wacom=
_wac *wacom, size_t len)
>>  static int wacom_tpc_pen(struct wacom_wac *wacom)
>>  {
>>  	unsigned char *data =3D wacom->data;
>> -	struct input_dev *input =3D wacom->input;
>> +	struct input_dev *input =3D wacom->pen_input;
>>  	bool prox =3D data[1] & 0x20;
>> =20
>>  	if (!wacom->shared->stylus_in_proximity) /* first in prox */
>> @@ -1301,8 +1301,12 @@ static int wacom_tpc_irq(struct wacom_wac *wa=
com, size_t len)
>>  {
>>  	unsigned char *data =3D wacom->data;
>> =20
>> -	dev_dbg(wacom->input->dev.parent,
>> -		"%s: received report #%d\n", __func__, data[0]);
>> +	if (wacom->pen_input)
>> +		dev_dbg(wacom->pen_input->dev.parent,
>> +			"%s: received report #%d\n", __func__, data[0]);
>> +	else if (wacom->touch_input)
>> +		dev_dbg(wacom->touch_input->dev.parent,
>> +			"%s: received report #%d\n", __func__, data[0]);
>> =20
>>  	switch (len) {
>>  	case WACOM_PKGLEN_TPC1FG:
>> @@ -1334,11 +1338,9 @@ static int wacom_tpc_irq(struct wacom_wac *wa=
com, size_t len)
>>  	return 0;
>>  }
>> =20
>> -static void wacom_map_usage(struct wacom *wacom, struct hid_usage *=
usage,
>> +static void wacom_map_usage(struct input_dev *input, struct hid_usa=
ge *usage,
>>  		struct hid_field *field, __u8 type, __u16 code, int fuzz)
>>  {
>> -	struct wacom_wac *wacom_wac =3D &wacom->wacom_wac;
>> -	struct input_dev *input =3D wacom_wac->input;
>>  	int fmin =3D field->logical_minimum;
>>  	int fmax =3D field->logical_maximum;
>> =20
>> @@ -1366,36 +1368,38 @@ static void wacom_wac_pen_usage_mapping(stru=
ct hid_device *hdev,
>>  		struct hid_field *field, struct hid_usage *usage)
>>  {
>>  	struct wacom *wacom =3D hid_get_drvdata(hdev);
>> +	struct wacom_wac *wacom_wac =3D &wacom->wacom_wac;
>> +	struct input_dev *input =3D wacom_wac->pen_input;
>> =20
>>  	switch (usage->hid) {
>>  	case HID_GD_X:
>> -		wacom_map_usage(wacom, usage, field, EV_ABS, ABS_X, 4);
>> +		wacom_map_usage(input, usage, field, EV_ABS, ABS_X, 4);
>>  		break;
>>  	case HID_GD_Y:
>> -		wacom_map_usage(wacom, usage, field, EV_ABS, ABS_Y, 4);
>> +		wacom_map_usage(input, usage, field, EV_ABS, ABS_Y, 4);
>>  		break;
>>  	case HID_DG_TIPPRESSURE:
>> -		wacom_map_usage(wacom, usage, field, EV_ABS, ABS_PRESSURE, 0);
>> +		wacom_map_usage(input, usage, field, EV_ABS, ABS_PRESSURE, 0);
>>  		break;
>>  	case HID_DG_INRANGE:
>> -		wacom_map_usage(wacom, usage, field, EV_KEY, BTN_TOOL_PEN, 0);
>> +		wacom_map_usage(input, usage, field, EV_KEY, BTN_TOOL_PEN, 0);
>>  		break;
>>  	case HID_DG_INVERT:
>> -		wacom_map_usage(wacom, usage, field, EV_KEY,
>> +		wacom_map_usage(input, usage, field, EV_KEY,
>>  				BTN_TOOL_RUBBER, 0);
>>  		break;
>>  	case HID_DG_ERASER:
>>  	case HID_DG_TIPSWITCH:
>> -		wacom_map_usage(wacom, usage, field, EV_KEY, BTN_TOUCH, 0);
>> +		wacom_map_usage(input, usage, field, EV_KEY, BTN_TOUCH, 0);
>>  		break;
>>  	case HID_DG_BARRELSWITCH:
>> -		wacom_map_usage(wacom, usage, field, EV_KEY, BTN_STYLUS, 0);
>> +		wacom_map_usage(input, usage, field, EV_KEY, BTN_STYLUS, 0);
>>  		break;
>>  	case HID_DG_BARRELSWITCH2:
>> -		wacom_map_usage(wacom, usage, field, EV_KEY, BTN_STYLUS2, 0);
>> +		wacom_map_usage(input, usage, field, EV_KEY, BTN_STYLUS2, 0);
>>  		break;
>>  	case HID_DG_TOOLSERIALNUMBER:
>> -		wacom_map_usage(wacom, usage, field, EV_MSC, MSC_SERIAL, 0);
>> +		wacom_map_usage(input, usage, field, EV_MSC, MSC_SERIAL, 0);
>>  		break;
>>  	}
>>  }
>> @@ -1405,7 +1409,7 @@ static int wacom_wac_pen_event(struct hid_devi=
ce *hdev, struct hid_field *field,
>>  {
>>  	struct wacom *wacom =3D hid_get_drvdata(hdev);
>>  	struct wacom_wac *wacom_wac =3D &wacom->wacom_wac;
>> -	struct input_dev *input =3D wacom_wac->input;
>> +	struct input_dev *input =3D wacom_wac->pen_input;
>> =20
>>  	/* checking which Tool / tip switch to send */
>>  	switch (usage->hid) {
>> @@ -1435,7 +1439,7 @@ static void wacom_wac_pen_report(struct hid_de=
vice *hdev,
>>  {
>>  	struct wacom *wacom =3D hid_get_drvdata(hdev);
>>  	struct wacom_wac *wacom_wac =3D &wacom->wacom_wac;
>> -	struct input_dev *input =3D wacom_wac->input;
>> +	struct input_dev *input =3D wacom_wac->pen_input;
>>  	bool prox =3D wacom_wac->hid_data.inrange_state;
>> =20
>>  	if (!wacom_wac->shared->stylus_in_proximity) /* first in prox */
>> @@ -1464,23 +1468,24 @@ static void wacom_wac_finger_usage_mapping(s=
truct hid_device *hdev,
>>  	struct wacom *wacom =3D hid_get_drvdata(hdev);
>>  	struct wacom_wac *wacom_wac =3D &wacom->wacom_wac;
>>  	struct wacom_features *features =3D &wacom_wac->features;
>> +	struct input_dev *input =3D wacom_wac->touch_input;
>>  	unsigned touch_max =3D wacom_wac->features.touch_max;
>> =20
>>  	switch (usage->hid) {
>>  	case HID_GD_X:
>>  		features->last_slot_field =3D usage->hid;
>>  		if (touch_max =3D=3D 1)
>> -			wacom_map_usage(wacom, usage, field, EV_ABS, ABS_X, 4);
>> +			wacom_map_usage(input, usage, field, EV_ABS, ABS_X, 4);
>>  		else
>> -			wacom_map_usage(wacom, usage, field, EV_ABS,
>> +			wacom_map_usage(input, usage, field, EV_ABS,
>>  					ABS_MT_POSITION_X, 4);
>>  		break;
>>  	case HID_GD_Y:
>>  		features->last_slot_field =3D usage->hid;
>>  		if (touch_max =3D=3D 1)
>> -			wacom_map_usage(wacom, usage, field, EV_ABS, ABS_Y, 4);
>> +			wacom_map_usage(input, usage, field, EV_ABS, ABS_Y, 4);
>>  		else
>> -			wacom_map_usage(wacom, usage, field, EV_ABS,
>> +			wacom_map_usage(input, usage, field, EV_ABS,
>>  					ABS_MT_POSITION_Y, 4);
>>  		break;
>>  	case HID_DG_CONTACTID:
>> @@ -1494,7 +1499,7 @@ static void wacom_wac_finger_usage_mapping(str=
uct hid_device *hdev,
>>  		break;
>>  	case HID_DG_TIPSWITCH:
>>  		features->last_slot_field =3D usage->hid;
>> -		wacom_map_usage(wacom, usage, field, EV_KEY, BTN_TOUCH, 0);
>> +		wacom_map_usage(input, usage, field, EV_KEY, BTN_TOUCH, 0);
>>  		break;
>>  	}
>>  }
>> @@ -1550,7 +1555,7 @@ static int wacom_wac_finger_event(struct hid_d=
evice *hdev,
>> =20
>>  	if (usage->usage_index + 1 =3D=3D field->report_count) {
>>  		if (usage->hid =3D=3D wacom_wac->features.last_slot_field)
>> -			wacom_wac_finger_slot(wacom_wac, wacom_wac->input);
>> +			wacom_wac_finger_slot(wacom_wac, wacom_wac->touch_input);
>>  	}
>> =20
>>  	return 0;
>> @@ -1561,7 +1566,7 @@ static void wacom_wac_finger_report(struct hid=
_device *hdev,
>>  {
>>  	struct wacom *wacom =3D hid_get_drvdata(hdev);
>>  	struct wacom_wac *wacom_wac =3D &wacom->wacom_wac;
>> -	struct input_dev *input =3D wacom_wac->input;
>> +	struct input_dev *input =3D wacom_wac->touch_input;
>>  	unsigned touch_max =3D wacom_wac->features.touch_max;
>> =20
>>  	if (touch_max > 1)
>> @@ -1578,10 +1583,10 @@ void wacom_wac_usage_mapping(struct hid_devi=
ce *hdev,
>>  {
>>  	struct wacom *wacom =3D hid_get_drvdata(hdev);
>>  	struct wacom_wac *wacom_wac =3D &wacom->wacom_wac;
>> -	struct input_dev *input =3D wacom_wac->input;
>> =20
>>  	/* currently, only direct devices have proper hid report descripto=
rs */
>> -	__set_bit(INPUT_PROP_DIRECT, input->propbit);
>> +	__set_bit(INPUT_PROP_DIRECT, wacom_wac->pen_input->propbit);
>> +	__set_bit(INPUT_PROP_DIRECT, wacom_wac->touch_input->propbit);
>> =20
>>  	if (WACOM_PEN_FIELD(field))
>>  		return wacom_wac_pen_usage_mapping(hdev, field, usage);
>> @@ -1626,7 +1631,7 @@ void wacom_wac_report(struct hid_device *hdev,=
 struct hid_report *report)
>>  static int wacom_bpt_touch(struct wacom_wac *wacom)
>>  {
>>  	struct wacom_features *features =3D &wacom->features;
>> -	struct input_dev *input =3D wacom->input;
>> +	struct input_dev *input =3D wacom->touch_input;
>>  	struct input_dev *pad_input =3D wacom->pad_input;
>>  	unsigned char *data =3D wacom->data;
>>  	int i;
>> @@ -1674,7 +1679,7 @@ static int wacom_bpt_touch(struct wacom_wac *w=
acom)
>>  static void wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned =
char *data)
>>  {
>>  	struct wacom_features *features =3D &wacom->features;
>> -	struct input_dev *input =3D wacom->input;
>> +	struct input_dev *input =3D wacom->touch_input;
>>  	bool touch =3D data[1] & 0x80;
>>  	int slot =3D input_mt_get_slot_by_key(input, data[0]);
>> =20
>> @@ -1732,7 +1737,7 @@ static void wacom_bpt3_button_msg(struct wacom=
_wac *wacom, unsigned char *data)
>> =20
>>  static int wacom_bpt3_touch(struct wacom_wac *wacom)
>>  {
>> -	struct input_dev *input =3D wacom->input;
>> +	struct input_dev *input =3D wacom->touch_input;
>>  	unsigned char *data =3D wacom->data;
>>  	int count =3D data[1] & 0x07;
>>  	int i;
>> @@ -1760,7 +1765,7 @@ static int wacom_bpt3_touch(struct wacom_wac *=
wacom)
>>  static int wacom_bpt_pen(struct wacom_wac *wacom)
>>  {
>>  	struct wacom_features *features =3D &wacom->features;
>> -	struct input_dev *input =3D wacom->input;
>> +	struct input_dev *input =3D wacom->pen_input;
>>  	unsigned char *data =3D wacom->data;
>>  	int prox =3D 0, x =3D 0, y =3D 0, p =3D 0, d =3D 0, pen =3D 0, btn=
1 =3D 0, btn2 =3D 0;
>> =20
>> @@ -1869,7 +1874,7 @@ static void wacom_bamboo_pad_pen_event(struct =
wacom_wac *wacom,
>>  static int wacom_bamboo_pad_touch_event(struct wacom_wac *wacom,
>>  		unsigned char *data)
>>  {
>> -	struct input_dev *input =3D wacom->input;
>> +	struct input_dev *input =3D wacom->touch_input;
>>  	unsigned char *finger_data, prefix;
>>  	unsigned id;
>>  	int x, y;
>> @@ -2113,7 +2118,10 @@ void wacom_wac_irq(struct wacom_wac *wacom_wa=
c, size_t len)
>>  	}
>> =20
>>  	if (sync) {
>> -		input_sync(wacom_wac->input);
>> +		if (wacom_wac->pen_input)
>> +			input_sync(wacom_wac->pen_input);
>> +		if (wacom_wac->touch_input)
>> +			input_sync(wacom_wac->touch_input);
>>  		if (wacom_wac->pad_input)
>>  			input_sync(wacom_wac->pad_input);
>>  	}
>> @@ -2121,7 +2129,7 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac=
, size_t len)
>> =20
>>  static void wacom_setup_cintiq(struct wacom_wac *wacom_wac)
>>  {
>> -	struct input_dev *input_dev =3D wacom_wac->input;
>> +	struct input_dev *input_dev =3D wacom_wac->pen_input;
>> =20
>>  	input_set_capability(input_dev, EV_MSC, MSC_SERIAL);
>> =20
>> @@ -2144,7 +2152,7 @@ static void wacom_setup_cintiq(struct wacom_wa=
c *wacom_wac)
>> =20
>>  static void wacom_setup_intuos(struct wacom_wac *wacom_wac)
>>  {
>> -	struct input_dev *input_dev =3D wacom_wac->input;
>> +	struct input_dev *input_dev =3D wacom_wac->pen_input;
>> =20
>>  	input_set_capability(input_dev, EV_REL, REL_WHEEL);
>> =20
>> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
>> index c873c9f..2978c30 100644
>> --- a/drivers/hid/wacom_wac.h
>> +++ b/drivers/hid/wacom_wac.h
>> @@ -196,7 +196,8 @@ struct hid_data {
>>  };
>> =20
>>  struct wacom_wac {
>> -	char name[WACOM_NAME_MAX];
>> +	char pen_name[WACOM_NAME_MAX];
>> +	char touch_name[WACOM_NAME_MAX];
>>  	char pad_name[WACOM_NAME_MAX];
>>  	char bat_name[WACOM_NAME_MAX];
>>  	char ac_name[WACOM_NAME_MAX];
>> @@ -207,9 +208,11 @@ struct wacom_wac {
>>  	bool reporting_data;
>>  	struct wacom_features features;
>>  	struct wacom_shared *shared;
>> -	struct input_dev *input;
>> +	struct input_dev *pen_input;
>> +	struct input_dev *touch_input;
>>  	struct input_dev *pad_input;
>> -	bool input_registered;
>> +	bool pen_registered;
>> +	bool touch_registered;
>>  	bool pad_registered;
>>  	int pid;
>>  	int battery_capacity;
>> --=20
>> 2.4.1
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
