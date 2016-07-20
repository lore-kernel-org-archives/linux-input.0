From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 2/2] HID: wacom: Replace 'oVid' and 'oPid' with heuristics
Date: Wed, 20 Jul 2016 09:36:35 -0700
Message-ID: <c2cab4aa-d677-a213-df23-64f7d5840cd5@gmail.com>
References: <20160711180711.17537-1-killertofu@gmail.com>
 <20160711180711.17537-2-killertofu@gmail.com>
 <20160712090510.GG4663@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35958 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388AbcGTQgi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jul 2016 12:36:38 -0400
Received: by mail-pa0-f67.google.com with SMTP id ez1so3587344pab.3
        for <linux-input@vger.kernel.org>; Wed, 20 Jul 2016 09:36:38 -0700 (PDT)
In-Reply-To: <20160712090510.GG4663@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On 07/12/2016 02:05 AM, Benjamin Tissoires wrote:
> On Jul 11 2016 or thereabouts, Jason Gerecke wrote:
>> The 'oVid' and 'oPid' variables used by wacom_are_sibling are a hack=
y
>> solution to the problem of the driver having few good heuristics to =
use
>> to determine if two devices should be considered siblings or not. Th=
is
>> commit replaces them with heuristics that leverage the information w=
e
>> have available to determine if two devices are likely siblings or no=
t.
>=20
> I agree it's nicer to have a better heuristic for sibling matching,
> but I wonder if this heuristic is reliable enough when talking about
> future devices. It might be, but I know from experience that the
> firmware team can be very original and find a way that screws up us a=
ll
> :/
>=20
> Keeping the safety net of reducing the checks with ovid/opid might co=
me
> handy in the future.
>=20

The biggest problem with oVid/oPid is that they're kinda antithetical t=
o
the HID_GENERIC codepath. If a device is split between two PIDs then
arbitration is broken for any kernel that doesn't include specific
support for the device.

I agree that heuristics aren't as confidence-inspiring as explicit
notation, but if they can be made to work well enough then I'd prefer
using them. Either way, I suppose as userspace starts taking over
arbitration duties it will become a more and more moot issue.

>>
>> Written out, the new heuristics are basically:
>>
>>   * If a device with the same VID/PID as that being probed already e=
xists,
>>     it should be preferentially checked for siblingship.
>=20
> That's assuming you don't have 2 27QHD connected as 2 monitors (if yo=
u
> really have a lot of money to spend) :)
>=20
> I think the code is OK, just not the comment above (mostly the
> "preferentially" word itches me)
>=20

I'll try to come up with better / more clear wording (see my later
comments on the "Try to find an already-probed interface from the same
device" hunk for more detail).

>>
>>   * Two HID devices which have the same VID/PID are not siblings if =
they
>>     are not part of the same logical hardware device.
>>
>>   * Two HID devices which have different VID/PIDs are not siblings i=
f
>>     they have different parent (e.g. USB hub) devices.
>>
>>   * Devices without the WACOM_DEVICETYPE_DIRECT flag set may only be
>>     siblings of devies with the same VID/PID (Wacom often splits the=
ir
>>     direct input tablets into two devices to make it easier to meet
>>     Microsoft's touchscreen requirements).
>=20
> That's a strong assumption on the future. If you are forced to use th=
e
> Precision Touchpad protocol for Intuos, this will just blow up.
>=20

I originally didn't include this condition in my checks since I was
similarly wary. Leaving it out does open two small corner cases though.

1) A pen-only tablet connected to the same hub as a touch-only tablet.
Touch-only Wacom tablets aren't particularly common and it would
be a little strange to have one paired with a pen-only tablet, but it
could conceivably happen. Although pairing the devices shouldn't
normally be an issue since a user isn't likely to use both
simultaneously, it might cause problems for multi-seat setups.

2) A pen-only tablet connected to the same hub as a pen-and-touch table=
t
which has the *touch* interface probed first. As far as I'm aware, ther=
e
aren't any Wacom devices that have the USB interfaces ordered
touch-then-pen, but as you point out, who knows what those tricksy
firmware engineers will do in the future to ruin your day.

I'm open to leaving the check in or out depending on your feelings. If
you've got thoughts on how to close these corner cases as well, I'm all
ears :)

>>
>>   * Two devices which have different "directness" are not siblings.
>>
>>   * Two devices which do not serve complementary roles (i.e. pen/tou=
ch)
>>     are not siblings.
>=20
> I think it would be useful to have these write outs as comments in th=
e
> code. It's quite tricky to understand the actual code without these
> explanations.
>=20

Ack.

>>
>> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
>> ---
>>  drivers/hid/wacom_sys.c | 58 ++++++++++++++++++++++++++++++++++++++=
+----------
>>  drivers/hid/wacom_wac.c | 41 ++++++++++++++--------------------
>>  drivers/hid/wacom_wac.h |  2 --
>>  3 files changed, 62 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
>> index 4a0bb6f..a5bc038 100644
>> --- a/drivers/hid/wacom_sys.c
>> +++ b/drivers/hid/wacom_sys.c
>> @@ -532,31 +532,65 @@ static bool wacom_are_sibling(struct hid_devic=
e *hdev,
>>  {
>>  	struct wacom *wacom =3D hid_get_drvdata(hdev);
>>  	struct wacom_features *features =3D &wacom->wacom_wac.features;
>> -	int vid =3D features->oVid;
>> -	int pid =3D features->oPid;
>> -	int n1,n2;
>> +	struct wacom *sibling_wacom =3D hid_get_drvdata(sibling);
>> +	struct wacom_features *sibling_features =3D &sibling_wacom->wacom_=
wac.features;
>> +	int n1, n2;
>> =20
>> -	if (vid =3D=3D 0 && pid =3D=3D 0) {
>> -		vid =3D hdev->vendor;
>> -		pid =3D hdev->product;
>> +	/* Compare the physical path. Require devices with the same
>> +	 * PID to share the same device, and devices with different
>> +	 * PIDs to share parent devices.
>> +	 */
>=20
> I stumbled this morning upon:
> http://www.theregister.co.uk/2016/07/11/linus_torvalds_in_sweary_rant=
_about_punctuation_in_kernel_comments/
>=20
> Please make sure to follow the comments style guidelines :)
>=20

Whatever makes the style gods happy :)

>> +	if (hdev->vendor =3D=3D sibling->vendor && hdev->product =3D=3D si=
bling->product) {
>> +		n1 =3D strrchr(hdev->phys, '/') - hdev->phys;
>> +		n2 =3D strrchr(sibling->phys, '/') - sibling->phys;
>> +	}
>> +	else {
>> +		n1 =3D strrchr(hdev->phys, '.') - hdev->phys;
>> +		n2 =3D strrchr(sibling->phys, '.') - sibling->phys;
>>  	}
>> =20
>> -	if (vid !=3D sibling->vendor || pid !=3D sibling->product)
>> +	if (n1 !=3D n2 || n1 <=3D 0 || n2 <=3D 0)
>>  		return false;
>> =20
>> -	/* Compare the physical path. */
>> -	n1 =3D strrchr(hdev->phys, '.') - hdev->phys;
>> -	n2 =3D strrchr(sibling->phys, '.') - sibling->phys;
>> -	if (n1 !=3D n2 || n1 <=3D 0 || n2 <=3D 0)
>> +	if (strncmp(hdev->phys, sibling->phys, n1))
>> +		return false;
>> +
>> +	if (hdev->vendor !=3D sibling->vendor || hdev->product !=3D siblin=
g->product) {
>> +		if(!(features->device_type & WACOM_DEVICETYPE_DIRECT))
>> +			return false;
>> +	}
>=20
> As mentioned in the commit log, I am not sure it's such a good idea t=
o
> have this check. Does it really remove a false positive or can this j=
ust
> be considered as an extra check that can be safely removed?
>=20

See comment above.

>> +
>> +	if ((features->device_type & WACOM_DEVICETYPE_DIRECT) !=3D
>> +	    (sibling_features->device_type & WACOM_DEVICETYPE_DIRECT))
>>  		return false;
>=20
> unless I am mistaken, you might as well need {if indirect and sibling
> is not indirect, than false }.
>=20

That case should be covered since we're comparing the actual values of
each device's "direct" flag for equality (direct/indirect and
indirect/direct will return false).

If its not immediately clear though, I could decompose it into
independent checks for each case. E.g.:

  if ((features->device_type & WACOM_DEVICETYPE_DIRECT) &&
      !(sibling_features->device_type & WACOM_DEVICETYPE_DIRECT))
          return false;

  if (!(features->device_type & WACOM_DEVICETYPE_DIRECT) &&
       (sibling_features->device_type & WACOM_DEVICETYPE_DIRECT))
          return false;

>> =20
>> -	return !strncmp(hdev->phys, sibling->phys, n1);
>> +	if ((features->device_type & WACOM_DEVICETYPE_PEN) &&
>> +	    !(sibling_features->device_type & WACOM_DEVICETYPE_TOUCH))
>> +		return false;
>> +
>> +	if ((features->device_type & WACOM_DEVICETYPE_TOUCH) &&
>> +	    !(sibling_features->device_type & WACOM_DEVICETYPE_PEN))
>> +		return false;
>=20
> I think it would be better to have those last 3 (plus mine) tests at =
the
> beginning, before doing string lookouts. They seem to be the most
> reliable ones and able to exclude a lot of false positive.
>=20

Reasonable enough.

>> +
>> +	return true;
>>  }
>> =20
>>  static struct wacom_hdev_data *wacom_get_hdev_data(struct hid_devic=
e *hdev)
>>  {
>>  	struct wacom_hdev_data *data;
>> =20
>> +	/* Try to find an already-probed interface from the same device */
>> +	list_for_each_entry(data, &wacom_udev_list, list) {
>> +		int n1, n2;
>> +		n1 =3D strrchr(hdev->phys, '/') - hdev->phys;
>> +		n2 =3D strrchr(data->dev->phys, '/') - data->dev->phys;
>> +		if (n1 !=3D n2 || n1 <=3D 0 || n2 <=3D 0)
>> +			continue;
>> +		if (!strncmp(hdev->phys, data->dev->phys, n1))
>> +			return data;
>> +	}
>=20
> I can't see the benefit of having this here, while it seems to be
> already tested in wacom_are_sibling().
>=20

There's a subtle issue with not performing this search before proceedin=
g
to trying to pair arbitrary devices in wacom_are_sibling. Imagine that
you've already got a pen-only device connected to your system. Now,
connect a (non-split) pen+touch device to the same hub. When the touch
interface is probed, the first device checked its checked against in
wacom_are_sibling is that pen-only device, and provided it passes all
the checks then it will be incorrectly paired with it.

This is actually probably a leftover from before I added the requiremen=
t
that only direct devices can have different PIDs and might not be
strictly necessary in the patch's current state, but I'd feel better
keeping it in either way.

> Also, if there is a need for it, there is a common pattern used 3 tim=
es
> here:
>         int n1, n2;
>         n1 =3D strrchr(hdev->phys, separator) - hdev->phys;
>         n2 =3D strrchr(other->dev->phys, separator) - other->dev->phy=
s;
>         if (n1 !=3D n2 || n1 <=3D 0 || n2 <=3D 0)
>                  continue;
>         return !strncmp(hdev->phys, other->dev->phys, n1);
>=20
> It would make sense to put a name on it and have a separate function.
>=20
> Cheers,
> Benjamin
>=20

Good call, if the block remains necessary.

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one /
(That is to say, eight) to the two, /
But you can=E2=80=99t take seven from three, /
So you look at the sixty-fours....

>> +
>> +	/* Fallback to finding devices that appear to be "siblings" */
>>  	list_for_each_entry(data, &wacom_udev_list, list) {
>>  		if (wacom_are_sibling(hdev, data->dev)) {
>>  			kref_get(&data->kref);
>> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
>> index 2523a29..cb6fc63 100644
>> --- a/drivers/hid/wacom_wac.c
>> +++ b/drivers/hid/wacom_wac.c
>> @@ -3229,11 +3229,10 @@ static const struct wacom_features wacom_fea=
tures_0xF4 =3D
>>  static const struct wacom_features wacom_features_0xF8 =3D
>>  	{ "Wacom Cintiq 24HD touch", 104080, 65200, 2047, 63, /* Pen */
>>  	  WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 16,
>> -	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
>> -	  .oVid =3D USB_VENDOR_ID_WACOM, .oPid =3D 0xf6 };
>> +	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
>>  static const struct wacom_features wacom_features_0xF6 =3D
>>  	{ "Wacom Cintiq 24HD touch", .type =3D WACOM_24HDT, /* Touch */
>> -	  .oVid =3D USB_VENDOR_ID_WACOM, .oPid =3D 0xf8, .touch_max =3D 10=
,
>> +	  .touch_max =3D 10,
>>  	  .check_for_hid_type =3D true, .hid_type =3D HID_TYPE_USBNONE };
>>  static const struct wacom_features wacom_features_0x32A =3D
>>  	{ "Wacom Cintiq 27QHD", 119740, 67520, 2047, 63,
>> @@ -3242,11 +3241,10 @@ static const struct wacom_features wacom_fea=
tures_0x32A =3D
>>  static const struct wacom_features wacom_features_0x32B =3D
>>  	{ "Wacom Cintiq 27QHD touch", 119740, 67520, 2047, 63,
>>  	  WACOM_27QHD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 0,
>> -	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
>> -	  .oVid =3D USB_VENDOR_ID_WACOM, .oPid =3D 0x32C };
>> +	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
>>  static const struct wacom_features wacom_features_0x32C =3D
>>  	{ "Wacom Cintiq 27QHD touch", .type =3D WACOM_27QHDT,
>> -	  .oVid =3D USB_VENDOR_ID_WACOM, .oPid =3D 0x32B, .touch_max =3D 1=
0 };
>> +	  .touch_max =3D 10 };
>>  static const struct wacom_features wacom_features_0x3F =3D
>>  	{ "Wacom Cintiq 21UX", 87200, 65600, 1023, 63,
>>  	  CINTIQ, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 8 };
>> @@ -3263,11 +3261,10 @@ static const struct wacom_features wacom_fea=
tures_0x304 =3D
>>  static const struct wacom_features wacom_features_0x333 =3D
>>  	{ "Wacom Cintiq 13HD touch", 59152, 33448, 2047, 63,
>>  	  WACOM_13HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 9,
>> -	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
>> -	  .oVid =3D USB_VENDOR_ID_WACOM, .oPid =3D 0x335 };
>> +	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
>>  static const struct wacom_features wacom_features_0x335 =3D
>>  	{ "Wacom Cintiq 13HD touch", .type =3D WACOM_24HDT, /* Touch */
>> -	  .oVid =3D USB_VENDOR_ID_WACOM, .oPid =3D 0x333, .touch_max =3D 1=
0,
>> +	  .touch_max =3D 10,
>>  	  .check_for_hid_type =3D true, .hid_type =3D HID_TYPE_USBNONE };
>>  static const struct wacom_features wacom_features_0xC7 =3D
>>  	{ "Wacom DTU1931", 37832, 30305, 511, 0,
>> @@ -3298,11 +3295,10 @@ static const struct wacom_features wacom_fea=
tures_0x57 =3D
>>  static const struct wacom_features wacom_features_0x59 =3D /* Pen *=
/
>>  	{ "Wacom DTH2242", 95640, 54060, 2047, 63,
>>  	  DTK, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 6,
>> -	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
>> -	  .oVid =3D USB_VENDOR_ID_WACOM, .oPid =3D 0x5D };
>> +	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
>>  static const struct wacom_features wacom_features_0x5D =3D /* Touch=
 */
>>  	{ "Wacom DTH2242",       .type =3D WACOM_24HDT,
>> -	  .oVid =3D USB_VENDOR_ID_WACOM, .oPid =3D 0x59, .touch_max =3D 10=
,
>> +	  .touch_max =3D 10,
>>  	  .check_for_hid_type =3D true, .hid_type =3D HID_TYPE_USBNONE };
>>  static const struct wacom_features wacom_features_0xCC =3D
>>  	{ "Wacom Cintiq 21UX2", 86800, 65200, 2047, 63,
>> @@ -3315,11 +3311,10 @@ static const struct wacom_features wacom_fea=
tures_0xFA =3D
>>  static const struct wacom_features wacom_features_0x5B =3D
>>  	{ "Wacom Cintiq 22HDT", 95440, 53860, 2047, 63,
>>  	  WACOM_22HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 18,
>> -	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
>> -	  .oVid =3D USB_VENDOR_ID_WACOM, .oPid =3D 0x5e };
>> +	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
>>  static const struct wacom_features wacom_features_0x5E =3D
>>  	{ "Wacom Cintiq 22HDT", .type =3D WACOM_24HDT,
>> -	  .oVid =3D USB_VENDOR_ID_WACOM, .oPid =3D 0x5b, .touch_max =3D 10=
,
>> +	  .touch_max =3D 10,
>>  	  .check_for_hid_type =3D true, .hid_type =3D HID_TYPE_USBNONE };
>>  static const struct wacom_features wacom_features_0x90 =3D
>>  	{ "Wacom ISDv4 90", 26202, 16325, 255, 0,
>> @@ -3461,20 +3456,18 @@ static const struct wacom_features wacom_fea=
tures_0x6004 =3D
>>  static const struct wacom_features wacom_features_0x307 =3D
>>  	{ "Wacom ISDv5 307", 59152, 33448, 2047, 63,
>>  	  CINTIQ_HYBRID, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 9,
>> -	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
>> -	  .oVid =3D USB_VENDOR_ID_WACOM, .oPid =3D 0x309 };
>> +	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
>>  static const struct wacom_features wacom_features_0x309 =3D
>>  	{ "Wacom ISDv5 309", .type =3D WACOM_24HDT, /* Touch */
>> -	  .oVid =3D USB_VENDOR_ID_WACOM, .oPid =3D 0x0307, .touch_max =3D =
10,
>> +	  .touch_max =3D 10,
>>  	  .check_for_hid_type =3D true, .hid_type =3D HID_TYPE_USBNONE };
>>  static const struct wacom_features wacom_features_0x30A =3D
>>  	{ "Wacom ISDv5 30A", 59152, 33448, 2047, 63,
>>  	  CINTIQ_HYBRID, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 9,
>> -	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
>> -	  .oVid =3D USB_VENDOR_ID_WACOM, .oPid =3D 0x30C };
>> +	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
>>  static const struct wacom_features wacom_features_0x30C =3D
>>  	{ "Wacom ISDv5 30C", .type =3D WACOM_24HDT, /* Touch */
>> -	  .oVid =3D USB_VENDOR_ID_WACOM, .oPid =3D 0x30A, .touch_max =3D 1=
0,
>> +	  .touch_max =3D 10,
>>  	  .check_for_hid_type =3D true, .hid_type =3D HID_TYPE_USBNONE };
>>  static const struct wacom_features wacom_features_0x318 =3D
>>  	{ "Wacom USB Bamboo PAD", 4095, 4095, /* Touch */
>> @@ -3485,11 +3478,9 @@ static const struct wacom_features wacom_feat=
ures_0x319 =3D
>>  static const struct wacom_features wacom_features_0x325 =3D
>>  	{ "Wacom ISDv5 325", 59552, 33848, 2047, 63,
>>  	  CINTIQ_COMPANION_2, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 11,
>> -	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
>> -	  .oVid =3D USB_VENDOR_ID_WACOM, .oPid =3D 0x326 };
>> +	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
>>  static const struct wacom_features wacom_features_0x326 =3D /* Touc=
h */
>> -	{ "Wacom ISDv5 326", .type =3D HID_GENERIC, .oVid =3D USB_VENDOR_I=
D_WACOM,
>> -	  .oPid =3D 0x325 };
>> +	{ "Wacom ISDv5 326", .type =3D HID_GENERIC };
>>  static const struct wacom_features wacom_features_0x323 =3D
>>  	{ "Wacom Intuos P M", 21600, 13500, 1023, 31,
>>  	  INTUOSHT, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
>> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
>> index 7ad6273..a5bd05a 100644
>> --- a/drivers/hid/wacom_wac.h
>> +++ b/drivers/hid/wacom_wac.h
>> @@ -181,8 +181,6 @@ struct wacom_features {
>>  	int tilt_fuzz;
>>  	unsigned quirks;
>>  	unsigned touch_max;
>> -	int oVid;
>> -	int oPid;
>>  	int pktlen;
>>  	bool check_for_hid_type;
>>  	int hid_type;
>> --=20
>> 2.9.0
>>

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
