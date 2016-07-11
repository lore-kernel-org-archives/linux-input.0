From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/2] HID: logitech-hidpp: add battery support for HID++
 2.0 devices
Date: Mon, 11 Jul 2016 12:54:56 +0200
Message-ID: <20160711105456.GA4663@mail.corp.redhat.com>
References: <1467192482-2723-1-git-send-email-peter.hutterer@who-t.net>
 <1467988545.2317.4.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40765 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752821AbcGKKzC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jul 2016 06:55:02 -0400
Content-Disposition: inline
In-Reply-To: <1467988545.2317.4.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>

On Jul 08 2016 or thereabouts, Bastien Nocera wrote:
> On Wed, 2016-06-29 at 19:28 +1000, Peter Hutterer wrote:
> > +static int hidpp_battery_get_property(struct power_supply *psy,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 enum power_supply_property psp,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 union power_supply_propval
> > *val)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct hidpp_device *hid=
pp =3D power_supply_get_drvdata(psy);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret =3D 0;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0switch(psp) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0case POWER_SUPPLY_PROP_STATUS:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
val->intval =3D hidpp->battery.status;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0case POWER_SUPPLY_PROP_CAPACITY:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
val->intval =3D hidpp->battery.level;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0default:
>=20
> You forgot to handle POWER_SUPPLY_PROP_SCOPE. This means that UPower
> thinks it's supplying power to the computer to which it is connected.
>=20
> Should be set to "POWER_SUPPLY_SCOPE_DEVICE". This should fix it.
>=20
> From 8fbfcfd411a4b2c55ec24adc8b8ecc0bca2db5e3 Mon Sep 17 00:00:00 200=
1
> From: Bastien Nocera <hadess@hadess.net>
> Date: Fri, 8 Jul 2016 16:34:18 +0200
> Subject: [PATCH] HID: logitech-hidpp: Add scope to battery
>=20
> Without a scope defined, UPower assumes that the battery is provide
> power to the computer it's connected to, like a laptop battery or a U=
PS.
>=20
> Signed-off-by: Bastien Nocera <hadess@hadess.net>

=46WIW, the following patch is:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

> ---
>  drivers/hid/hid-logitech-hidpp.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logit=
ech-hidpp.c
> index 4eeb550..4aaf237 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -761,6 +761,7 @@ static int hidpp20_battery_event(struct hidpp_dev=
ice *hidpp,
>  static enum power_supply_property hidpp_battery_props[] =3D {
>         POWER_SUPPLY_PROP_STATUS,
>         POWER_SUPPLY_PROP_CAPACITY,
> +       POWER_SUPPLY_PROP_SCOPE,
>  };
> =20
>  static int hidpp_battery_get_property(struct power_supply *psy,
> @@ -777,6 +778,9 @@ static int hidpp_battery_get_property(struct powe=
r_supply *psy,
>                 case POWER_SUPPLY_PROP_CAPACITY:
>                         val->intval =3D hidpp->battery.level;
>                         break;
> +               case POWER_SUPPLY_PROP_SCOPE:
> +                       val->intval =3D POWER_SUPPLY_SCOPE_DEVICE;
> +                       break;
>                 default:
>                         ret =3D -EINVAL;
>                         break;
> --=20
> 2.7.4
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
