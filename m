From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH RFC] hid-input: add support for HID devices reporting
 Battery Strength
Date: Fri, 02 Dec 2011 09:44:13 -0800
Message-ID: <4ED90E6D.8090402@goop.org>
References: <4EC75224.7070207@goop.org> <alpine.LNX.2.00.1111191212140.15187@pobox.suse.cz> <4EC820F8.4070900@goop.org> <alpine.LNX.2.00.1111201110480.15187@pobox.suse.cz> <4ECA7E7D.80207@goop.org> <alpine.LNX.2.00.1111220028130.28728@pobox.suse.cz> <4ECAE019.4000409@goop.org> <alpine.LNX.2.00.1111220049470.28728@pobox.suse.cz> <4ECCB38A.8000503@goop.org> <alpine.LNX.2.00.1111281111510.15446@pobox.suse.cz> <CACo8zOd45i3EnCVMyJoDPP4bx2AnD9mEjDiC=bJKvmX=TWfXGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from claw.goop.org ([74.207.240.146]:46375 "EHLO claw.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757177Ab1LBRoQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 2 Dec 2011 12:44:16 -0500
In-Reply-To: <CACo8zOd45i3EnCVMyJoDPP4bx2AnD9mEjDiC=bJKvmX=TWfXGg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Nicoletti <dantti12@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, vojtech@ucw.cz, Przemo Firszt <przemo@firszt.eu>, Richard Hughes <richard@hughsie.com>

On 12/01/2011 09:52 PM, Daniel Nicoletti wrote:
> I've sent an email earlier asking for help with a GetFeature code, an=
d now I
> have a second patch on top of Jeremy's to provide the battery functio=
nality
> for devices that support reporting it.
>
> If I understood correctly when talking to Jeremy he said his device
> never actually
> reported the status as an input event (sorry if I didn't understand i=
t
> correctly),

No, it does.  When the mouse first connects it reports the battery leve=
l
as an Input event.  Without my patch, X sees the battery level as a
strange little absolute axis on the mouse, which it ignores.

I don't know if the mouse also reports the battery later on
spontaneously; I haven't observed it, so I suspect you may be right tha=
t
you have to poll it to get further updates.

>  and
> after reading HID specs I believe it's really because it was meant to=
 be probed,
> I have an Apple Keyboard and Magic Trackpad both bluetooth batteries =
operated,
> so using PacketLogger I saw that Mac OSX always ask the battery statu=
s using
> the so called GetFeature.

Could you cite a specific reference?  I don't see any references to
"GetFeature" in HID spec I have.  The closest I see is
"Get_Report(INPUT/OUTPUT/FEATURE)", which specifically says "This
request is not intended to be used for polling the device state on a
regular basis".  Though I'm not at all surprised if device manufacturer=
s
ignore this, or that it is contradictory with some other part of the sp=
ec.

> What my patch does is basically:
> - store the report id that matches the battery_strength
> - setup the battery if 0x6.0x20 is found, even if that is reported as=
 a feature
>   (as it was meant to be but only the MagicTrackpad does)
> - when upower or someone access /sys/class/power_supply/hid-*/capacit=
y it
>   will probe the device and return it's status.

How often does usermode read this file?  Does it/can it select on the
file to wait for changes.

Given that battery level shouldn't change that quickly, I wonder if
having a timer poll the device every minute or something of that order
might be useful?

>
> It works great for both devices, but I have two concerns:
> - the report_features function has a duplicated code

Yes, but that's easy to fix.

> - it would be nice if it was possible for specific drivers to provide=
 their own
>   probe as there might be some strange devices... (but maybe it's
> already possible)
I'd wait until there's a device which can't be handled by this mechanis=
m
before trying to generalize it.  Unless we can unify the wacom driver,
but that seems to be in its own little world.

> I've talked to the upower dev and he fixed it to be able to show the
> right percentage.

Cool, but I have some concerns about that (see below).

> Here how the uevent file (in /sys/class/power_supply/hid-*/) looks li=
ke:
> POWER_SUPPLY_NAME=3Dhid-00:22:41:D9:18:E7-battery
> POWER_SUPPLY_PRESENT=3D1
> POWER_SUPPLY_ONLINE=3D1
> POWER_SUPPLY_CAPACITY=3D66
> POWER_SUPPLY_MODEL_NAME=3DMacAdmin=92s keyboard
> POWER_SUPPLY_STATUS=3DDischarging
>
> POWER_SUPPLY_NAME=3Dhid-70:CD:60:F5:FF:3F-battery
> POWER_SUPPLY_PRESENT=3D1
> POWER_SUPPLY_ONLINE=3D1
> POWER_SUPPLY_CAPACITY=3D62
> POWER_SUPPLY_MODEL_NAME=3Dnexx=92s Trackpad
> POWER_SUPPLY_STATUS=3DDischarging
>
> and the patch (note that this is my first kernel patch so sorry if
> formatting is not ok, should I attach it?):
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index b9b8c75..8fac47c 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -277,6 +277,7 @@ static enum power_supply_property
> hidinput_battery_props[] =3D {
>  	POWER_SUPPLY_PROP_ONLINE,
>  	POWER_SUPPLY_PROP_CAPACITY,
>  	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_STATUS
>  };
>
>  static int hidinput_get_battery_property(struct power_supply *psy,
> @@ -285,6 +286,9 @@ static int hidinput_get_battery_property(struct
> power_supply *psy,
>  {
>  	struct hid_device *dev =3D container_of(psy, struct hid_device, bat=
tery);
>  	int ret =3D 0;
> +	int ret_rep;
> +	__u8 *buf =3D NULL;
> +	unsigned char report_number =3D dev->battery_report_id;
>
>  	switch (prop) {
>  	case POWER_SUPPLY_PROP_PRESENT:
> @@ -293,28 +297,45 @@ static int hidinput_get_battery_property(struct
> power_supply *psy,
>  		break;
>
>  	case POWER_SUPPLY_PROP_CAPACITY:
> -		if (dev->battery_min < dev->battery_max &&
> -		    dev->battery_val >=3D dev->battery_min &&
> -		    dev->battery_val <=3D dev->battery_max)
> -			val->intval =3D (100 * (dev->battery_val - dev->battery_min)) /
> -				(dev->battery_max - dev->battery_min);
> -		else
> +		buf =3D kmalloc(2 * sizeof(__u8), GFP_KERNEL);

Why allocate a two byte buffer?  Why not just put it on the stack?  How
do you know that's the right size?

> +		if (!buf) {
> +			ret =3D -ENOMEM;
> +			break;
> +		}
> +
> +		memset(buf, 0, sizeof(buf));
> +		ret_rep =3D dev->hid_get_raw_report(dev, report_number, buf,
> sizeof(buf), HID_FEATURE_REPORT);
> +		if (ret_rep !=3D 2) {
>  			ret =3D -EINVAL;
> +			break;
> +		}
> +
> +		/* store the returned value */
> +		/* I'm not calculating this using the logical_minimum and maximum =
*/
> +		/* because my device returns 0-100 even though the min and max are=
 0-255 */
> +		val->intval =3D buf[1];

That's definitely not the case for my mouse.  I'm not sure what the
range actually is, but I've seen values reported > 100 with fresh
alkaline batteries.  Initially I also thought it was using a 0-100 rang=
e
despite the min/max, and I added a per-device quirk mechanism - but
since my device didn't need it, I did't include it in the patch
posting.  I'd reinstate it if there are devices that report 0-100.

>  		break;
>
>  	case POWER_SUPPLY_PROP_MODEL_NAME:
>  		val->strval =3D dev->name;
>  		break;
>
> +	case POWER_SUPPLY_PROP_STATUS:
> +		val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +		break;
> +
>  	default:
>  		ret =3D -EINVAL;
>  		break;
>  	}
>
> +	if (buf) {
> +		kfree(buf);
> +	}
>  	return ret;
>  }
>
> -static void hidinput_setup_battery(struct hid_device *dev, s32 min, =
s32 max)
> +static void hidinput_setup_battery(struct hid_device *dev, unsigned
> id, s32 min, s32 max)
>  {
>  	struct power_supply *battery =3D &dev->battery;
>  	int ret;
> @@ -326,7 +347,7 @@ static void hidinput_setup_battery(struct
> hid_device *dev, s32 min, s32 max)
>  	if (battery->name =3D=3D NULL)
>  		return;
>
> -	battery->type =3D POWER_SUPPLY_TYPE_BATTERY;
> +	battery->type =3D POWER_SUPPLY_TYPE_USB;

What's the purpose of this?  Is it to make upower behave in a
different/better way?  My reading is that this means that it's powered
by USB ("Standard Downstream Port").  A bluetooth device doesn't have
any USB involved at all (except if the BT adapter itself is USB, which
is moot).

If upower is getting confused thinking that a "battery" is necessarily =
a
laptop battery, then I think it needs to be fixed to pay closer
attention to the device tree topology.

(looks up upower) Ah, I see.

The changes in the current upower.git look very suspect to me, if
nothing else because of the hard-coded "magicmouse" and "wacom", and th=
e
use of POWER_SUPPLY_TYPE_USB.  Can upower not look to see if there's a
power-supply hanging off a HID device and report that as peripheral pow=
er?

> -	if (!drv->feature_mapping)
> -		return;
> -
>  	rep_enum =3D &hid->report_enum[HID_FEATURE_REPORT];
>  	list_for_each_entry(rep, &rep_enum->report_list, list)
>  		for (i =3D 0; i < rep->maxfield; i++)
> -			for (j =3D 0; j < rep->field[i]->maxusage; j++)
> -				drv->feature_mapping(hid, rep->field[i],
> -						     rep->field[i]->usage + j);
> +			for (j =3D 0; j < rep->field[i]->maxusage; j++) {
> +				/* Verify if Battery Strength feature is available */
> +				if (((rep->field[i]->usage + j)->hid & HID_USAGE_PAGE) =3D=3D
> HID_UP_GENDEVCTRLS &&
> +					((rep->field[i]->usage + j)->hid & HID_USAGE) =3D=3D 0x20) {
> +					hidinput_setup_battery(hid,
> +							       rep->id,
> +							       rep->field[i]->logical_minimum,
> +							       rep->field[i]->logical_maximum);
> +				}
> +
> +				if (drv->feature_mapping)
> +					drv->feature_mapping(hid, rep->field[i],
> +							     rep->field[i]->usage + j);
> +			}
I'd be inclined to split all this out into a separate function, so that
you can make it common with the code on the input path.

    J
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
