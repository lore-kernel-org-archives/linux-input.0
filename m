From: Pedro Vanzella <pedro@pedrovanzella.com>
Subject: Re: [PATCH 2/2] HID: hid-logitech-hidpp: subscribe to battery
 voltage change events
Date: Wed, 5 Jun 2019 12:40:56 -0400
Message-ID: <20190605164056.ofueguibhjknm5wm@Fenrir>
References: <20190604232827.26008-1-pedro@pedrovanzella.com>
 <20190604232827.26008-2-pedro@pedrovanzella.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lbwwonzdknit5xhi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190604232827.26008-2-pedro@pedrovanzella.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--lbwwonzdknit5xhi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sorry for littering the list, but please ignore this patch set. I'll
have one that uses a quirk to detect the right devices in a little
while.

On 06/04, Pedro Vanzella wrote:
> Same as with the other ways of reporting battery status,
> fetch the battery voltage on raw hidpp events.
>=20
> Signed-off-by: Pedro Vanzella <pedro@pedrovanzella.com>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index e68ea44b0d24..1eee206a0aed 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -1313,6 +1313,35 @@ static int hidpp20_query_battery_voltage_info(stru=
ct hidpp_device *hidpp)
>  	return 0;
>  }
> =20
> +static int hidpp20_battery_voltage_event(struct hidpp_device *hidpp,
> +					 u8 *data, int size)
> +{
> +	struct hidpp_report *report =3D (struct hidpp_report *)data;
> +	int status, voltage;
> +	bool changed;
> +
> +	if (report->fap.feature_index !=3D hidpp->battery.voltage_feature_index=
 ||
> +	    report->fap.funcindex_clientid !=3D
> +		    EVENT_BATTERY_LEVEL_STATUS_BROADCAST)
> +		return 0;
> +
> +	status =3D hidpp20_battery_map_status_voltage(report->fap.params,
> +						    &voltage);
> +
> +	hidpp->battery.online =3D status !=3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +
> +	changed =3D voltage !=3D hidpp->battery.voltage ||
> +		  status !=3D hidpp->battery.status;
> +
> +	if (changed) {
> +		hidpp->battery.voltage =3D voltage;
> +		hidpp->battery.status =3D status;
> +		if (hidpp->battery.ps)
> +			power_supply_changed(hidpp->battery.ps);
> +	}
> +	return 0;
> +}
> +
>  static enum power_supply_property hidpp_battery_props[] =3D {
>  	POWER_SUPPLY_PROP_ONLINE,
>  	POWER_SUPPLY_PROP_STATUS,
> @@ -3181,6 +3210,9 @@ static int hidpp_raw_hidpp_event(struct hidpp_devic=
e *hidpp, u8 *data,
>  		ret =3D hidpp_solar_battery_event(hidpp, data, size);
>  		if (ret !=3D 0)
>  			return ret;
> +		ret =3D hidpp20_battery_voltage_event(hidpp, data, size);
> +		if (ret !=3D 0)
> +			return ret;
>  	}
> =20
>  	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP10_BATTERY) {
> --=20
> 2.21.0
>=20

--=20
Pedro Vanzella
pedrovanzella.com
#include <paranoia.h>
Don't Panic

--lbwwonzdknit5xhi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEXrNKwhI/eDFBCGo3v5huqi4pBxkFAlz38JAACgkQv5huqi4p
BxnqRw/9GjTvjivcUXuKcQobp7jlpP4KnUiuNMmXPqQDi0kSADx+MCTbS/AnrXlC
NEQwWIpYOD8SqS/6JVUHvbeSWIZB2BK8DaLMqejK6FWAoPMGSDLZoxxSbcQZu9np
zExt2kiIy5+n5aHvJp4bPbELoYWVmXMKuD9sMAkmLElz4aefWF/WqJ31OfQ9re76
eMi9Cc2gQ+UCG6d0s0gLIq3POj0uWKpyXnbqrwO+T2l/8ZJrXMiBDKLMn2UW4Vgo
qrwDe+tS6GhTmLp3V+LsHF17s0CDLpHYL6LmgcNbEtw7pqsYJhyqH7y87B25Vcn8
cqv7HBst3BxaJASjb77Vr1WKObrqs23viBWBilyfyNxWpvTpZrivEjt0+ATh5TpD
DycgCeIA+HjoMLbHbYRDlwLSAiofxBkKXZ4YHs6aKRuxpiaXRE+2C8f4WuQyXrdH
R5pbcNkeSbKIeWe9wGzIJalmslRUvnBZSkNDFOTGliojTyPw0EWQf3uDgKnEBbNj
/xb4MuloTR8YX2x2K1u+8zkxghpQgkadukikMcm+WIWz8VamGevwFztwVUeVTX09
05aJT3wAM1iBdvE8pxvDNbybW4t+nz+HMdEXSlaaaLC2hJc7BYVJm2OSrjpLRYe3
J2cYYVXLvbOKyZFvszvvXbgb1NcnFYkJwDydAvl9Dz/l2Zyy3eg=
=xyZ3
-----END PGP SIGNATURE-----

--lbwwonzdknit5xhi--
