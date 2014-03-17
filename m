From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 5/8] regulator: AXP20x: Add support for
 regulators subsystem
Date: Mon, 17 Mar 2014 17:33:07 +0000
Message-ID: <20140317173307.GX11706@sirena.org.uk>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
 <1394898225-28452-6-git-send-email-carlo@caione.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5FFaGRZUwcpbKFrw"
Return-path: <linux-sunxi+bncBDQ2L75W5QGBB3XDTSMQKGQEZXF2BSQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394898225-28452-6-git-send-email-carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org


--5FFaGRZUwcpbKFrw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 15, 2014 at 04:43:42PM +0100, Carlo Caione wrote:
> AXP202 and AXP209 come with two synchronous step-down DC-DCs and five
> LDOs. This patch introduces basic support for those regulators.

This is mostly fine apart from the things Krzysztof mentioned and...

> +static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
> +{
> +	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
> +
> +	if (dcdcfreq < 750)
> +		dcdcfreq = 750;
> +
> +	if (dcdcfreq > 1875)
> +		dcdcfreq = 1875;

I'd expect at least a warning on out of spec values being specified
here.

--5FFaGRZUwcpbKFrw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTJzHQAAoJELSic+t+oim9kboQAJ35OxlOtD6lEQoSOmRZP6In
zxPccnmam12tid7Pb7zWdYzwTUmiMKNeWeAavU58plKnNqC8qyW2n5lr3WIE5fue
ARPpOolPSntEme8wAZ1Bj/QP+Ztur08c69dVx/E4Z5kAH6UdH056fsEoxjEVSjsv
AVe9i44eq02PY0ui5P00VGu4oftk60Fr01qWiXLqqnJzVs7fYsR0Sh3O1EdsjWcI
QNfaWOzE1EBU+4XegAjJlp+RYb3tdx6l0MXi6O309s4bDzVx4btDjDd+PLy5uPSz
0TaecECOPWaQcU5FDIoMbWOZ+vbF5epM8GlFeBlt6a7GrzLD5+mAAByCY1D9d8SD
FAIlSV7Cd01fqBDU1cN9yQgjDiIDaQrYt0h/WfkSpBuDaHWogb2HriGM1V8x6Qic
5xSUHL9On3dNtj+YhAImYBylYzcx2cWgnLMF/dv8JZI5gxGsEdIAPDMYm0sNZ03Z
y/v3L1hAiotd7Y+S14NWCsBO10T3YnEtLMJZug5LAAsBHaDcRniF9Ac0ez31ymBR
EqujHtaWf/wGvzDIqswKtGmAXabvwApEy2VQnE9L5ZxeuHhewiZGLJoerqPvDfhN
Ux9uS0/oZCziCD6DGp0hrP+FmUSuk9LhTk36aoZoLqD07WOOa1s6dm5wgin0vKB3
OCtkTDMXzcWQYmMnIfRB
=9ub5
-----END PGP SIGNATURE-----

--5FFaGRZUwcpbKFrw--
