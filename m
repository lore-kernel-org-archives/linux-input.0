From: Daniel Nicoletti <dantti12@gmail.com>
Subject: Re: [PATCH RFC] hid-input: add support for HID devices reporting
 Battery Strength
Date: Fri, 2 Dec 2011 16:29:47 -0200
Message-ID: <CACo8zOcvKwr0wDkytvJfqyx4kV0ceYyCt+qnDqiSgxNywpzeHg@mail.gmail.com>
References: <4EC75224.7070207@goop.org>
	<alpine.LNX.2.00.1111191212140.15187@pobox.suse.cz>
	<4EC820F8.4070900@goop.org>
	<alpine.LNX.2.00.1111201110480.15187@pobox.suse.cz>
	<4ECA7E7D.80207@goop.org>
	<alpine.LNX.2.00.1111220028130.28728@pobox.suse.cz>
	<4ECAE019.4000409@goop.org>
	<alpine.LNX.2.00.1111220049470.28728@pobox.suse.cz>
	<4ECCB38A.8000503@goop.org>
	<alpine.LNX.2.00.1111281111510.15446@pobox.suse.cz>
	<CACo8zOd45i3EnCVMyJoDPP4bx2AnD9mEjDiC=bJKvmX=TWfXGg@mail.gmail.com>
	<4ED90E6D.8090402@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37214 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694Ab1LBS3s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Dec 2011 13:29:48 -0500
Received: by iage36 with SMTP id e36so4529805iag.19
        for <linux-input@vger.kernel.org>; Fri, 02 Dec 2011 10:29:47 -0800 (PST)
In-Reply-To: <4ED90E6D.8090402@goop.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, vojtech@ucw.cz, Przemo Firszt <przemo@firszt.eu>, Richard Hughes <richard@hughsie.com>

Thanks for the reply,

2011/12/2 Jeremy Fitzhardinge <jeremy@goop.org>:
>> If I understood correctly when talking to Jeremy he said his device
>> never actually
>> reported the status as an input event (sorry if I didn't understand =
it
>> correctly),
>
> No, it does. =A0When the mouse first connects it reports the battery =
level
> as an Input event. =A0Without my patch, X sees the battery level as a
> strange little absolute axis on the mouse, which it ignores.
>
> I don't know if the mouse also reports the battery later on
> spontaneously; I haven't observed it, so I suspect you may be right t=
hat
> you have to poll it to get further updates.

Right, my devices don't send any data if not asked, even if the battery=
 change
it's status (what did happen because I've put some old batteries.
So in this case we will need to keep your code on the raw event and pro=
bably
check that into the get_properties part.

>
>> =A0and
>> after reading HID specs I believe it's really because it was meant t=
o be probed,
>> I have an Apple Keyboard and Magic Trackpad both bluetooth batteries=
 operated,
>> so using PacketLogger I saw that Mac OSX always ask the battery stat=
us using
>> the so called GetFeature.
>
> Could you cite a specific reference? =A0I don't see any references to
> "GetFeature" in HID spec I have. =A0The closest I see is
> "Get_Report(INPUT/OUTPUT/FEATURE)", which specifically says "This
> request is not intended to be used for polling the device state on a
> regular basis". =A0Though I'm not at all surprised if device manufact=
urers
> ignore this, or that it is contradictory with some other part of the =
spec.

Sure, HUT1_12v2.pdf section 4.8 Feature Notifications, at the end you
will see GetReport(Feature) (sorry it was GetReport() not GetFeature())=
=2E
Also when I run my code hcidump shows this, which means it knows what
a GetReport is: (and Mac OSX PackatLogger.app too)
HIDP: Get report: Feature report

>> What my patch does is basically:
>> - store the report id that matches the battery_strength
>> - setup the battery if 0x6.0x20 is found, even if that is reported a=
s a feature
>> =A0 (as it was meant to be but only the MagicTrackpad does)
>> - when upower or someone access /sys/class/power_supply/hid-*/capaci=
ty it
>> =A0 will probe the device and return it's status.
>
> How often does usermode read this file? =A0Does it/can it select on t=
he
> file to wait for changes.
>
> Given that battery level shouldn't change that quickly, I wonder if
> having a timer poll the device every minute or something of that orde=
r
> might be useful?

Yes, this is concerning but imo the /sys.../capacity file should return
the current value, and to do that it need to probe, it the probe timer
is too often then upower needs fixing, we have done our part into the
kernel...

>> It works great for both devices, but I have two concerns:
>> - the report_features function has a duplicated code
>
> Yes, but that's easy to fix.
>
>> - it would be nice if it was possible for specific drivers to provid=
e their own
>> =A0 probe as there might be some strange devices... (but maybe it's
>> already possible)
> I'd wait until there's a device which can't be handled by this mechan=
ism
> before trying to generalize it. =A0Unless we can unify the wacom driv=
er,
> but that seems to be in its own little world.

sounds like a better idea.

>> I've talked to the upower dev and he fixed it to be able to show the
>> right percentage.
>
> Cool, but I have some concerns about that (see below).
>
>> Here how the uevent file (in /sys/class/power_supply/hid-*/) looks l=
ike:
>> POWER_SUPPLY_NAME=3Dhid-00:22:41:D9:18:E7-battery
>> POWER_SUPPLY_PRESENT=3D1
>> POWER_SUPPLY_ONLINE=3D1
>> POWER_SUPPLY_CAPACITY=3D66
>> POWER_SUPPLY_MODEL_NAME=3DMacAdmin=92s keyboard
>> POWER_SUPPLY_STATUS=3DDischarging
>>
>> POWER_SUPPLY_NAME=3Dhid-70:CD:60:F5:FF:3F-battery
>> POWER_SUPPLY_PRESENT=3D1
>> POWER_SUPPLY_ONLINE=3D1
>> POWER_SUPPLY_CAPACITY=3D62
>> POWER_SUPPLY_MODEL_NAME=3Dnexx=92s Trackpad
>> POWER_SUPPLY_STATUS=3DDischarging
>>
>> and the patch (note that this is my first kernel patch so sorry if
>> formatting is not ok, should I attach it?):
>> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
>> index b9b8c75..8fac47c 100644
>> --- a/drivers/hid/hid-input.c
>> +++ b/drivers/hid/hid-input.c
>> @@ -277,6 +277,7 @@ static enum power_supply_property
>> hidinput_battery_props[] =3D {
>> =A0 =A0 =A0 POWER_SUPPLY_PROP_ONLINE,
>> =A0 =A0 =A0 POWER_SUPPLY_PROP_CAPACITY,
>> =A0 =A0 =A0 POWER_SUPPLY_PROP_MODEL_NAME,
>> + =A0 =A0 POWER_SUPPLY_PROP_STATUS
>> =A0};
>>
>> =A0static int hidinput_get_battery_property(struct power_supply *psy=
,
>> @@ -285,6 +286,9 @@ static int hidinput_get_battery_property(struct
>> power_supply *psy,
>> =A0{
>> =A0 =A0 =A0 struct hid_device *dev =3D container_of(psy, struct hid_=
device, battery);
>> =A0 =A0 =A0 int ret =3D 0;
>> + =A0 =A0 int ret_rep;
>> + =A0 =A0 __u8 *buf =3D NULL;
>> + =A0 =A0 unsigned char report_number =3D dev->battery_report_id;
>>
>> =A0 =A0 =A0 switch (prop) {
>> =A0 =A0 =A0 case POWER_SUPPLY_PROP_PRESENT:
>> @@ -293,28 +297,45 @@ static int hidinput_get_battery_property(struc=
t
>> power_supply *psy,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>
>> =A0 =A0 =A0 case POWER_SUPPLY_PROP_CAPACITY:
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (dev->battery_min < dev->battery_max &&
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->battery_val >=3D dev->battery=
_min &&
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->battery_val <=3D dev->battery=
_max)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val->intval =3D (100 * (de=
v->battery_val - dev->battery_min)) /
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (dev->batt=
ery_max - dev->battery_min);
>> - =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 buf =3D kmalloc(2 * sizeof(__u8), GFP_KERN=
EL);
>
> Why allocate a two byte buffer? =A0Why not just put it on the stack? =
=A0How
> do you know that's the right size?

Sorry I'm not kernel expert I just saw some other code working like thi=
s..
I know the size because the first byte is the report_id (in my case 0x4=
7 or 71),
but the following bytes are reported by Report Size(8) and Report Count=
(1)
as the raw function calculates the count by the buf size.
(note that I might be wrong, but for my devices it works like this).

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!buf) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 memset(buf, 0, sizeof(buf));
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret_rep =3D dev->hid_get_raw_report(dev, r=
eport_number, buf,
>> sizeof(buf), HID_FEATURE_REPORT);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret_rep !=3D 2) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* store the returned value */
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* I'm not calculating this using the logi=
cal_minimum and maximum */
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* because my device returns 0-100 even th=
ough the min and max are 0-255 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 val->intval =3D buf[1];
>
> That's definitely not the case for my mouse. =A0I'm not sure what the
> range actually is, but I've seen values reported > 100 with fresh
> alkaline batteries. =A0Initially I also thought it was using a 0-100 =
range
> despite the min/max, and I added a per-device quirk mechanism - but
> since my device didn't need it, I did't include it in the patch
> posting. =A0I'd reinstate it if there are devices that report 0-100.

Sure, then we need some quirks... As even the keyboar that reports the =
max as
255 actually returns in 0-100 interval..

>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>
>> =A0 =A0 =A0 case POWER_SUPPLY_PROP_MODEL_NAME:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 val->strval =3D dev->name;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>
>> + =A0 =A0 case POWER_SUPPLY_PROP_STATUS:
>> + =A0 =A0 =A0 =A0 =A0 =A0 val->intval =3D POWER_SUPPLY_STATUS_DISCHA=
RGING;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> =A0 =A0 =A0 default:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 if (buf) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(buf);
>> + =A0 =A0 }
>> =A0 =A0 =A0 return ret;
>> =A0}
>>
>> -static void hidinput_setup_battery(struct hid_device *dev, s32 min,=
 s32 max)
>> +static void hidinput_setup_battery(struct hid_device *dev, unsigned
>> id, s32 min, s32 max)
>> =A0{
>> =A0 =A0 =A0 struct power_supply *battery =3D &dev->battery;
>> =A0 =A0 =A0 int ret;
>> @@ -326,7 +347,7 @@ static void hidinput_setup_battery(struct
>> hid_device *dev, s32 min, s32 max)
>> =A0 =A0 =A0 if (battery->name =3D=3D NULL)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>
>> - =A0 =A0 battery->type =3D POWER_SUPPLY_TYPE_BATTERY;
>> + =A0 =A0 battery->type =3D POWER_SUPPLY_TYPE_USB;
>
> What's the purpose of this? =A0Is it to make upower behave in a
> different/better way? =A0My reading is that this means that it's powe=
red
> by USB ("Standard Downstream Port"). =A0A bluetooth device doesn't ha=
ve
> any USB involved at all (except if the BT adapter itself is USB, whic=
h
> is moot).
>
> If upower is getting confused thinking that a "battery" is necessaril=
y a
> laptop battery, then I think it needs to be fixed to pay closer
> attention to the device tree topology.
>
> (looks up upower) Ah, I see.
>
> The changes in the current upower.git look very suspect to me, if
> nothing else because of the hard-coded "magicmouse" and "wacom", and =
the
> use of POWER_SUPPLY_TYPE_USB. =A0Can upower not look to see if there'=
s a
> power-supply hanging off a HID device and report that as peripheral p=
ower?

I have to talk to Richard (ah you CC him in this email..), but tbh I th=
ink the
change in upower should just look at what properties the battery is
capable of providing,
I changed it to USB since IIRC using it as BATTERY made it think it was=
 a power
supply of the computer..

>
>> - =A0 =A0 if (!drv->feature_mapping)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return;
>> -
>> =A0 =A0 =A0 rep_enum =3D &hid->report_enum[HID_FEATURE_REPORT];
>> =A0 =A0 =A0 list_for_each_entry(rep, &rep_enum->report_list, list)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < rep->maxfield; i++)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j < rep->fie=
ld[i]->maxusage; j++)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv->featu=
re_mapping(hid, rep->field[i],
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rep->field[i]->usage + j);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j < rep->fie=
ld[i]->maxusage; j++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Verify =
if Battery Strength feature is available */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (((rep-=
>field[i]->usage + j)->hid & HID_USAGE_PAGE) =3D=3D
>> HID_UP_GENDEVCTRLS &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ((rep->field[i]->usage + j)->hid & HID_USAGE) =3D=3D 0x20) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 hidinput_setup_battery(hid,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rep->id,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rep->field[i]->logi=
cal_minimum,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rep->field[i]->logi=
cal_maximum);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (drv->f=
eature_mapping)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 drv->feature_mapping(hid, rep->field[i],
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rep->field[i]->usage + =
j);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> I'd be inclined to split all this out into a separate function, so th=
at
> you can make it common with the code on the input path.

Yes, might be better I couldn't think of a nice way to share this part.=
=2E
But in the end does my Patch probes your device? :D

Best,
Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
