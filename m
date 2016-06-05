From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7 2/4] i2c-smbus: add SMBus Host Notify support
Date: Sun, 5 Jun 2016 09:23:15 +0200
Message-ID: <20160605072315.GD2722@katana>
References: <1464688985-19102-1-git-send-email-benjamin.tissoires@redhat.com>
 <1464688985-19102-3-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xm/fll+QQv+hsKip"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464688985-19102-3-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Corey Minyard <minyard@acm.org>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--Xm/fll+QQv+hsKip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> diff --git a/Documentation/i2c/smbus-protocol b/Documentation/i2c/smbus-p=
rotocol
> index 6012b12..4e07848 100644
> --- a/Documentation/i2c/smbus-protocol
> +++ b/Documentation/i2c/smbus-protocol
> @@ -199,6 +199,9 @@ alerting device's address.
> =20
>  [S] [HostAddr] [Wr] A [DevAddr] A [DataLow] A [DataHigh] A [P]
> =20
> +I2C drivers for devices which can trigger SMBus Host Notify should imple=
ment
> +the optional alert() callback.
> +

I'd like a similar "This is implemented the following way in the Linux
kernel:" paragraph here as in the alert section. The item what bus
drivers should do is missing.

> +	if (host_notify->pending) {
> +		spin_unlock_irqrestore(&host_notify->lock, flags);
> +		dev_warn(&adapter->dev, "Host Notify already scheduled.\n");
> +		return -EFAULT;

Very minor nit: -EBUSY?

> +#if defined(CONFIG_I2C_SMBUS) || defined(CONFIG_I2C_SMBUS_MODULE)

IS_ENABLED()?


--Xm/fll+QQv+hsKip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXU9NjAAoJEBQN5MwUoCm2iJkQAKNpc02aJr1fesuB8KnkQRIW
DutycDKXIj/0a+eRLDj7kA0dCoq9vHJ2nbSRtPV89LYSdZ8SHPOcR6CzJM0eSckb
4Aqgw0AUtZYsCjPYb4hvyNXkxJOknIhblvdfBAkWUS9zRakezl0N1H18MuTs8GVv
5hHT/8NAa7knvfmTjdp1krW5gOBZ2bo4OS8jqFa+7sAtzEQaJsMwinwt508b6k0x
kguBeibNC8sjrxH9mbLEmAgVG9b3WXM66WNSiU9Rb3so4ICYBApgQu95/FEP+7us
nRE3VYdXbuTy5PGI8l0UVetCixEIliRwXYd8WljLFXdGJdem5Zps60H5QekC6c0v
ho1jbSLIf9UKILkAa2T0wCTJZqugbn+vRJcxL9I63XpYzE0Y4+JSFjXNaUa1dI/b
+3n+UlZQlPJMWdTXcxONARpzkTc/e70L59se2Co/iaMCBekN/D4GyYoxAd58CnYF
gCcRy4Vzi8dBkSVtqwKmfeB47x1ODTfo2OtQt1cPVvPSn/IkyGLz2PMMGy7lN7VS
hLYycrt/PVZxKmd9PsuGJxDiNWpA2KqUU5u7DtT9sQywuPMPOUJravISQlt6bpPY
sfBfvnOH1LnOVKkOD4QhCfnq1Tfn4pM6SDRDi6LtQngxjv+Rkhw4uByxrG/FB7r/
n0PHNc4d+TSw310Sf3z9
=syEy
-----END PGP SIGNATURE-----

--Xm/fll+QQv+hsKip--
