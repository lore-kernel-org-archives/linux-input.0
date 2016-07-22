From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/2] HID: wacom: Add WACOM_DEVICETYPE_DIRECT for Cintiqs
 and similar
Date: Fri, 22 Jul 2016 11:09:17 +0200
Message-ID: <20160722090917.GB19383@mail.corp.redhat.com>
References: <20160711180711.17537-1-killertofu@gmail.com>
 <20160712073653.GF4663@mail.corp.redhat.com>
 <70d3efd5-0e6c-743d-e962-967210ecd753@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57340 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752452AbcGVJJW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jul 2016 05:09:22 -0400
Content-Disposition: inline
In-Reply-To: <70d3efd5-0e6c-743d-e962-967210ecd753@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Jul 20 2016 or thereabouts, Jason Gerecke wrote:
> On 07/12/2016 12:36 AM, Benjamin Tissoires wrote:
> > On Jul 11 2016 or thereabouts, Jason Gerecke wrote:
> >> "Direct" input deviecs like Cintiqs and Tablet PCs set the INPUT_P=
ROP_DIRECT
> >> property to notify userspace that the sensor and screen are overla=
yed. This
> >> information can also be useful elsewhere within the kernel driver,=
 however,
> >> so we introduce a new WACOM_DEVICETYPE_DIRECT that signals this to=
 other
> >> kernel code.
> >>
> >> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> >> ---
> >>  drivers/hid/wacom_wac.c | 40 ++++++++++++++++++++++++------------=
----
> >>  drivers/hid/wacom_wac.h |  1 +
> >>  2 files changed, 25 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> >> index e499cdb..2523a29 100644
> >> --- a/drivers/hid/wacom_wac.c
> >> +++ b/drivers/hid/wacom_wac.c
> >> @@ -1757,8 +1757,10 @@ void wacom_wac_usage_mapping(struct hid_dev=
ice *hdev,
> >>  {
> >>  	struct wacom *wacom =3D hid_get_drvdata(hdev);
> >>  	struct wacom_wac *wacom_wac =3D &wacom->wacom_wac;
> >> +	struct wacom_features *features =3D &wacom_wac->features;
> >> =20
> >>  	/* currently, only direct devices have proper hid report descrip=
tors */
> >> +	features->device_type |=3D WACOM_DEVICETYPE_DIRECT;
> >>  	__set_bit(INPUT_PROP_DIRECT, wacom_wac->pen_input->propbit);
> >>  	__set_bit(INPUT_PROP_DIRECT, wacom_wac->touch_input->propbit);
> >=20
> > nitpick: you might as well remove these additions of INPUT_PROP_DIR=
ECT,
> > as you are handling the test later and adding them no matter what.
> >=20
>=20
> Are you seeing something I'm missing? The new calls in
> wacom_setup_{pen,touch}_input_capabilities that setup INPUT_PROP_DIRE=
CT
> won't be called for HID_GENERIC devices since we bail out at the top =
of

Oh, yes, you are right.

> the functions. Perhaps you'd prefer me to move their setting of
> INPUT_PROP_DIRECT to before the point we bail, letting me remove them
> from here?

I think it would be better to set the flag in wacom_wac_usage_mapping()
and rely on this flag to set INPUT_PROP_DIRECT (by moving up the
setting of INPUT_PROP_DIRECT). It feels weird to set the flag + the
consequences of the flag one after the other. This way, we could also
imagine that if indirect devices are around and use generic, we could
just remove the flag, and the INPUT_PROP will be removed without any
extra effort.

>=20
> Jason
> ---
> Now instead of four in the eights place /
> you=E2=80=99ve got three, =E2=80=98Cause you added one /
> (That is to say, eight) to the two, /
> But you can=E2=80=99t take seven from three, /
> So you look at the sixty-fours....
>=20
> > Rest looks good to me.
> >=20
> > Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >=20
> > Cheers,
> > Benjamin
> >=20
> >> =20
> >> @@ -2465,6 +2467,19 @@ void wacom_setup_device_quirks(struct wacom=
 *wacom)
> >>  	if (features->type =3D=3D REMOTE)
> >>  		features->device_type =3D WACOM_DEVICETYPE_PAD;
> >> =20
> >> +	if (features->type =3D=3D PL          || features->type =3D=3D D=
TU           ||
> >> +	    features->type =3D=3D DTUS        || features->type =3D=3D D=
TUSX         ||
> >> +	    features->type =3D=3D WACOM_21UX2 || features->type =3D=3D W=
ACOM_22HD    ||
> >> +	    features->type =3D=3D DTK         || features->type =3D=3D W=
ACOM_24HD    ||
> >> +	    features->type =3D=3D WACOM_27QHD || features->type =3D=3D C=
INTIQ_HYBRID ||
> >> +	    features->type =3D=3D CINTIQ_COMPANION_2 || features->type =3D=
=3D CINTIQ ||
> >> +	    features->type =3D=3D WACOM_BEE   || features->type =3D=3D W=
ACOM_13HD    ||
> >> +	    features->type =3D=3D WACOM_24HDT || features->type =3D=3D W=
ACOM_27QHDT  ||
> >> +	    features->type =3D=3D TABLETPC    || features->type =3D=3D T=
ABLETPCE     ||
> >> +	    features->type =3D=3D TABLETPC2FG || features->type =3D=3D M=
TSCREEN      ||
> >> +	    features->type =3D=3D MTTPC       || features->type =3D=3D M=
TTPC_B)
> >> +	    features->device_type |=3D WACOM_DEVICETYPE_DIRECT;

As Bastien said, this is ugly, and a switch/case fits better.

Cheers,
Benjamin

> >> +
> >>  	if (wacom->hdev->bus =3D=3D BUS_BLUETOOTH)
> >>  		features->quirks |=3D WACOM_QUIRK_BATTERY;
> >> =20
> >> @@ -2516,6 +2531,10 @@ int wacom_setup_pen_input_capabilities(stru=
ct input_dev *input_dev,
> >>  	input_abs_set_res(input_dev, ABS_X, features->x_resolution);
> >>  	input_abs_set_res(input_dev, ABS_Y, features->y_resolution);
> >> =20
> >> +	if (features->device_type & WACOM_DEVICETYPE_DIRECT)
> >> +		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
> >> +	else
> >> +		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
> >> =20
> >>  	switch (features->type) {
> >>  	case GRAPHIRE_BT:
> >> @@ -2540,8 +2559,6 @@ int wacom_setup_pen_input_capabilities(struc=
t input_dev *input_dev,
> >>  		__set_bit(BTN_TOOL_MOUSE, input_dev->keybit);
> >>  		__set_bit(BTN_STYLUS, input_dev->keybit);
> >>  		__set_bit(BTN_STYLUS2, input_dev->keybit);
> >> -
> >> -		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
> >>  		break;
> >> =20
> >>  	case WACOM_27QHD:
> >> @@ -2556,7 +2573,6 @@ int wacom_setup_pen_input_capabilities(struc=
t input_dev *input_dev,
> >>  	case CINTIQ_COMPANION_2:
> >>  		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
> >>  		input_abs_set_res(input_dev, ABS_Z, 287);
> >> -		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
> >>  		wacom_setup_cintiq(wacom_wac);
> >>  		break;
> >> =20
> >> @@ -2572,8 +2588,6 @@ int wacom_setup_pen_input_capabilities(struc=
t input_dev *input_dev,
> >>  		/* fall through */
> >> =20
> >>  	case INTUOS:
> >> -		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
> >> -
> >>  		wacom_setup_intuos(wacom_wac);
> >>  		break;
> >> =20
> >> @@ -2583,8 +2597,6 @@ int wacom_setup_pen_input_capabilities(struc=
t input_dev *input_dev,
> >>  	case INTUOSPL:
> >>  	case INTUOS5S:
> >>  	case INTUOSPS:
> >> -		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
> >> -
> >>  		input_set_abs_params(input_dev, ABS_DISTANCE, 0,
> >>  				      features->distance_max,
> >>  				      features->distance_fuzz, 0);
> >> @@ -2614,8 +2626,6 @@ int wacom_setup_pen_input_capabilities(struc=
t input_dev *input_dev,
> >>  		__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
> >>  		__set_bit(BTN_STYLUS, input_dev->keybit);
> >>  		__set_bit(BTN_STYLUS2, input_dev->keybit);
> >> -
> >> -		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
> >>  		break;
> >> =20
> >>  	case PTU:
> >> @@ -2626,16 +2636,12 @@ int wacom_setup_pen_input_capabilities(str=
uct input_dev *input_dev,
> >>  		__set_bit(BTN_TOOL_PEN, input_dev->keybit);
> >>  		__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
> >>  		__set_bit(BTN_STYLUS, input_dev->keybit);
> >> -
> >> -		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
> >>  		break;
> >> =20
> >>  	case INTUOSHT:
> >>  	case BAMBOO_PT:
> >>  	case BAMBOO_PEN:
> >>  	case INTUOSHT2:
> >> -		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
> >> -
> >>  		if (features->type =3D=3D INTUOSHT2) {
> >>  			wacom_setup_basic_pro_pen(wacom_wac);
> >>  		} else {
> >> @@ -2693,6 +2699,11 @@ int wacom_setup_touch_input_capabilities(st=
ruct input_dev *input_dev,
> >>  				  features->y_resolution);
> >>  	}
> >> =20
> >> +	if (features->device_type & WACOM_DEVICETYPE_DIRECT)
> >> +		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
> >> +	else
> >> +		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
> >> +
> >>  	switch (features->type) {
> >>  	case INTUOS5:
> >>  	case INTUOS5L:
> >> @@ -2700,8 +2711,6 @@ int wacom_setup_touch_input_capabilities(str=
uct input_dev *input_dev,
> >>  	case INTUOSPL:
> >>  	case INTUOS5S:
> >>  	case INTUOSPS:
> >> -		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
> >> -
> >>  		input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, features=
->x_max, 0, 0);
> >>  		input_set_abs_params(input_dev, ABS_MT_TOUCH_MINOR, 0, features=
->y_max, 0, 0);
> >>  		input_mt_init_slots(input_dev, features->touch_max, INPUT_MT_PO=
INTER);
> >> @@ -2724,7 +2733,6 @@ int wacom_setup_touch_input_capabilities(str=
uct input_dev *input_dev,
> >> =20
> >>  	case TABLETPC:
> >>  	case TABLETPCE:
> >> -		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
> >>  		break;
> >> =20
> >>  	case INTUOSHT:
> >> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
> >> index 8a8974c..7ad6273 100644
> >> --- a/drivers/hid/wacom_wac.h
> >> +++ b/drivers/hid/wacom_wac.h
> >> @@ -82,6 +82,7 @@
> >>  #define WACOM_DEVICETYPE_TOUCH          0x0002
> >>  #define WACOM_DEVICETYPE_PAD            0x0004
> >>  #define WACOM_DEVICETYPE_WL_MONITOR     0x0008
> >> +#define WACOM_DEVICETYPE_DIRECT         0x0010
> >> =20
> >>  #define WACOM_VENDORDEFINED_PEN		0xff0d0001
> >>  #define WACOM_G9_PAGE			0xff090000
> >> --=20
> >> 2.9.0
> >>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
