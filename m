From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 7/9] ARM: sun7i/sun4i: dt: Add AXP209
 support to various boards
Date: Fri, 11 Apr 2014 13:29:02 +0100
Message-ID: <20140411122901.GE28800@sirena.org.uk>
References: <1397209093-10077-8-git-send-email-carlo@caione.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2hMgfIw2X+zgXrFs"
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBKOAT6NAKGQE6ZMHHWI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1397209093-10077-8-git-send-email-carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-input@vger.kernel.org


--2hMgfIw2X+zgXrFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2014 at 11:38:11AM +0200, Carlo Caione wrote:

> In all the DTs the min and max microvolt allowed for each regulator are a=
ctually
> the min and max voltage possible for the regulator itself. This is not sa=
fe but
> we do not have the ranges allowed for each board and the original Allwinn=
er=20
> driver does exactly this way.

Is there any code in their kernel which varies the supply voltages?  If
there isn't then simply omitting the voltage ranges is the best option,
leaving the supplies fixed.  If there is then the range it uses is a
good starting point.  In general supplies will be fixed voltage on a
given board unless there is a specific reason to vary them.

> +				regulators {
> +					compatible =3D "x-powers,axp20x-reg";

This compatible isn't part of the driver.

--2hMgfIw2X+zgXrFs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTR+AKAAoJELSic+t+oim9feAP/09sxPPcrpoKg37SzgglBir8
mVpQfnl0w5VkIsHiFbWLq2ezdngH/ThyBxwTeQfc4mX4DIvcFgT5ikCwIBAdolHZ
nI9p6UH44Of1+msGNBAeoTfd1c0vrK+ehsDdA3gnYjMZ8vZ/nyNjY4Nm6sLg7mTj
6u5UtYe8S9C9OW85PQQp7qP+3JrNclrPAIrTG2VZJdxmx0cMvKpSmyk4A7W6NRsX
/hMgXDGOqM/Wc3LN3cJol3uDstZJrmosXM9Vba6ofBBrfD0x3PvSaVJQcyTef0zB
XwZ4BAMZVjFwPCFVGIndWP0+bdOX/Amg+sBUkyJZL1i2wdHquhrYBDH5u/QHrx0u
G4jqgdWLzrBpX23emVQ9L4MZG/kMUNaKTPPFKS5qT0YkkcOj5gtaYtXlkOhx0D/B
nzRH130SEscbX6WVXp+NbIaVuCnryM4X+vvk5N0w0CbrTSaJh7xOiiDHy0I1mCf6
x8YzVJJMz10P7U9yZ7ApCYBPB6Mxi8/UbmPv23Is18gLdTAW7xMm31/amlnfeeYe
bGD/ozy7qZUSGDNg/2EIbk23Det3kZRyYV6QdsOLUBuNL3PVgSEfPo3abTWJVldS
lmYAqkD2MFZ4TNmxsF7CjY5zPRu3C5mfARyff7xFEB00jZ53kZfqgSxyIqe2Qss4
XCXiXZC5QUkUwtCfnSVV
=Tltg
-----END PGP SIGNATURE-----

--2hMgfIw2X+zgXrFs--
