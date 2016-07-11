From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/2] HID: logitech-hidpp: add battery support for HID++
 2.0 devices
Date: Mon, 11 Jul 2016 13:03:01 +0200
Message-ID: <20160711110300.GB4663@mail.corp.redhat.com>
References: <1467192482-2723-1-git-send-email-peter.hutterer@who-t.net>
 <1467988545.2317.4.camel@hadess.net>
 <1467999483.2277.19.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40330 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758106AbcGKLDG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jul 2016 07:03:06 -0400
Content-Disposition: inline
In-Reply-To: <1467999483.2277.19.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>

On Jul 08 2016 or thereabouts, Bastien Nocera wrote:
> On Fri, 2016-07-08 at 16:35 +0200, Bastien Nocera wrote:
> > On Wed, 2016-06-29 at 19:28 +1000, Peter Hutterer wrote:
> > > +static int hidpp_battery_get_property(struct power_supply *psy,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 enum power_supply_property
> > > psp,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 union power_supply_propval
> > > *val)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct hidpp_device *h=
idpp =3D power_supply_get_drvdata(psy);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret =3D 0;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0switch(psp) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0case POWER_SUPPLY_PROP_STATUS:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
val->intval =3D hidpp->battery.status;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0case POWER_SUPPLY_PROP_CAPACITY:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
val->intval =3D hidpp->battery.level;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0default:
> >=20
> > You forgot to handle POWER_SUPPLY_PROP_SCOPE. This means that UPowe=
r
> > thinks it's supplying power to the computer to which it is connecte=
d.
> >=20
> > Should be set to "POWER_SUPPLY_SCOPE_DEVICE". This should fix it.
>=20
> I've also noticed that my keyboard appears 4 times:
> $ cat /sys/class/power_supply/*/device/input/input*/name
> Logitech K750
> Logitech K750
> Logitech Rechargeable Touchpad T650
> Logitech K750
> Logitech K750

I just tested it again, and it appears we create a power_supply node at
each connect event. Switching the device off and on creates a lot of
those :)

That's easy to fix

>=20
> By the way, instead of giving fake values when starting up, you shoul=
d
> use the ONLINE property instead. That way, when the property changes =
to
> 1, UPower can start taking the capacity value into account. In the
> meanwhile, it would be ignored.

I couldn't managed to get this working. I played with ONLINE and
PRESENT, but each time the battery was reported with the fake values.

The problem we also see with the Logitech devices is that they do not
provide the battery capacity at all while charging. I think UPower
caches the last known value, and we should probably do the same (and us=
e
the provided hints to give a rough idea depending on the charging
status).

>=20
> Finally, things like the serial number and model name and manufacture=
r
> should be replicated in the power_supply, so that UPower can use them
> too.

That should be easy enough to do.

>=20
> Fixing UPower to not do its user-space poking when a device appears
> would be quite complicated. First, the unifier device will show up,
> then as a child, the power_supply subsystem device, so we cannot just
> probe when devices appear, as it would be in the wrong order for us.
>=20
> Would it be possible to add a sysfs file that's there in those newer
> versions of the kernel with this patch included? That way, I'd change
> the lines in:
> http://cgit.freedesktop.org/upower/tree/rules/95-upower-csr.rules
>=20
> From:
> ATTRS{idVendor}=3D=3D"046d", ATTRS{idProduct}=3D=3D"c52b", DRIVER=3D=3D=
"logitech-
> hidpp-device", ENV{UPOWER_BATTERY_TYPE}=3D"unifying"
> to:
> ATTRS{idVendor}=3D=3D"046d", ATTRS{idProduct}=3D=3D"c52b", DRIVER=3D=3D=
"logitech-
> hidpp-device", TEST!=3D"builtin_power_supply",
> ENV{UPOWER_BATTERY_TYPE}=3D"unifying"
>=20
> For example.

Seems like a reasonable thing to do. Especially because the power_suppl=
y
node is created when the device first gets connected, which means that
you'll see the input node first and then the power supply at some point=
,
later, or maybe never.

Cheers,
Benjamin

>=20
> Sorry about not being able to test this before it was merged for
> inclusion.
>=20
> Cheers
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
