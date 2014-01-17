From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: [PATCHv2 3/3] Input: edt-ft5x06: Add DT support
Date: Fri, 17 Jan 2014 02:46:22 +0100
Message-ID: <52D88B6E.6010709@kernelconcepts.de>
References: <1389859338-11685-1-git-send-email-LW@KARO-electronics.de> <1389859338-11685-4-git-send-email-LW@KARO-electronics.de> <20140117002649.GA837@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="BALh93kiskoxb6g728lvuBjJemlgJjl5R"
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140117002649.GA837@core.coreip.homeip.net>
Sender: linux-doc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?ISO-8859-1?Q?Lothar_Wa=DFmann?= <LW@KARO-electronics.de>, linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Thierry Reding <thierry.reding@gmail.com>, Grant Likely <grant.likely@linaro.org>, Jonathan Cameron <jic23@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Silvio F <silvio.fricke@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Jingoo Han <jg1.han@samsung.com>, Fugang Duan <B38611@freescale.com>, Sachin Kamat <sachin.kamat@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BALh93kiskoxb6g728lvuBjJemlgJjl5R
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Dmitry

On 17/01/14 01:26, Dmitry Torokhov wrote:
>> +  The following properties provide default values for the
>> +  corresponding parameters (see Documentation/input/edt-ft5x06.txt)
>> +- edt,threshold: allows setting the "click"-threshold in the range fr=
om 20 to 80.
>> +- edt,gain: sensitivity (0..31) (lower value -> higher sensitivity)
>> +- edt,offset: edge compensation (0..31)
>> +- edt,report-rate: report rate (3..14)
>=20
> I wonder if we really need to have it in device tree? Can users needing=

> top tweak the settings do it via udev rules?

IMO it makes sense to have these in the device tree. These values need
to be adjusted if you have glass or acrylics in front of the touch
glass. The defaults are tailored to the touchscreen without any
(additional) material in front of it.

So manufacturers need to provide different defaults depending on the way
a specific device is built. So these properties can be viewed in the
same way you specify display resolution or display type in the device tre=
e.

Bye,
         Simon


--=20
       Simon Budig                        kernel concepts GmbH
       simon.budig@kernelconcepts.de      Sieghuetter Hauptweg 48
       +49-271-771091-17                  D-57072 Siegen



--BALh93kiskoxb6g728lvuBjJemlgJjl5R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLYi24ACgkQO2O/RXesiHAlCgCglXbccRZKZoEn4WzdUpJ35ZtU
DjkAn2w6BsHgr66lFkpu7k6/QyWW3err
=iVxg
-----END PGP SIGNATURE-----

--BALh93kiskoxb6g728lvuBjJemlgJjl5R--
