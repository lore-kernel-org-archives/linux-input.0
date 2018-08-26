From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH V4 2/3] dt-bindings: input: Add document bindings for
 DA7280
Date: Sun, 26 Aug 2018 08:51:57 +0200
Message-ID: <20180826065157.GA25309@amd>
References: <cover.1534830272.git.Roy.Im@diasemi.com>
 <0d2a3c034a567d3a3ccd2e965f40e9af28f7e4d3.1534830272.git.Roy.Im@diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0d2a3c034a567d3a3ccd2e965f40e9af28f7e4d3.1534830272.git.Roy.Im@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roy Im <roy.im.opensource@diasemi.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Support Opensource <support.opensource@diasemi.com>, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +++ b/Documentation/devicetree/bindings/input/dlg,da7280.txt
> @@ -0,0 +1,101 @@
> +Dialog Semiconductor DA7280 Haptics bindings
> +
> +Required properties:
> +- compatible: Should be "dlg,da7280".
> +- reg: Specifies the I2C slave address.
> +
> +- interrupt-parent : Specifies the phandle of the interrupt controller to
> +  which the IRQs from DA7280 are delivered to.
> +
> +- dlg,vib-mode:
> +  "LRA-MODE" - Linear Resonance Actuator mode.
> +  "ERM-BAR" - Bar type Eccentric Rotating Mass mode.
> +  "ERM-COIN" - Coin type Eccentric Rotating Mass mode.

So this is some kind of "vibration motor" on steroids)?

> +- dlg,op-mode: Haptic operation mode.
> +  Possible values:
> +	1 - Direct register override mode triggered by i2c(default),
> +	2 - PWM data source mode setting duty to 0 - 0xffff(0% - 100%),

Space after 0xffff?

> +	3 - Register triggered waveform memory mode, the pattern assigned
> +	    to the PS_SEQ_ID played as much times as PS_SEQ_LOOP,
> +	4 - Edge triggered waveform memory mode, external GPI(N) condtrol

"control"

> +	    are required to enable/disable and it needs to keep
> +	    device enabled by sending magnitude (X > 0),
> +	    the pattern is assigned to the GPI(N)_SEQUENCE_ID below

"below."

> +- dlg,imax-microamp: Actuator max current rating.
> +  Valid values: 0 - 252000.
> +  Default: 130000.
> +- dlg,impd-micro-ohms: the impedance of the actuator in micro ohm,

"ohms"

> +  as read from its datasheet.

"as read" does not sound english.

> +- dlg,mem-array: use in case that memory registers should be updated,
> +  Please fill the whole buffers(100 bytes) to avoid any error in driver.
> +  For example,
> +	dlg,mem-array =3D <
> +		0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x08 0x09 0x0A
> +		...
> +		0x71 0x72 0x73 0x74 0x75 0x76 0x77 0x78 0x79 0x7A
> +		0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> +		0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> +	>;

I'd not understand what this is from this description. (And I'd put
example below... in the exampls section).


> +For further information, see device datasheet.
> +
> +=3D=3D=3D=3D=3D=3D
> +
> +Example:
> +
> +	haptics: da7280-haptics@4a {
> +		compatible =3D "dlg,da7280";
> +		reg =3D <0x4a>;
> +		interrupt-parent =3D <&gpio6>;
> +		interrupts =3D <11 IRQ_TYPE_LEVEL_LOW>;
> +		dlg,vib-mode =3D "LRA-MODE";
> +		dlg,op-mode =3D <1>;
> +		dlg,nom-microvolt =3D <2000000>;
> +		dlg,abs-max-microvolt =3D <2000000>;
> +		dlg,imax-microamp =3D <170000>;
> +		dlg,resonant-freq-hz =3D <180>;
> +		dlg,impd-micro-ohms =3D <10500000>;
> +		dlg,freq-track-enable;
> +		dlg,rapid-stop-enable;
> +	};

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluCTg0ACgkQMOfwapXb+vLEugCePH2QGVdcJ3n9Xwb6xqiURfDY
vUYAn3QgIbvCp/GnbX2ikcazMuOSFvtB
=o7Xp
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
