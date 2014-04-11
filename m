From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 1/9] mfd: AXP20x: Add mfd driver for
 AXP20x PMIC
Date: Fri, 11 Apr 2014 13:09:08 +0100
Message-ID: <20140411120908.GC28800@sirena.org.uk>
References: <1397209093-10077-1-git-send-email-carlo@caione.org>
 <1397209093-10077-2-git-send-email-carlo@caione.org>
 <235623053.nj0gFkxyW5@wuerfel>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oTHb8nViIGeoXxdp"
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBH5XT6NAKGQEDHQU3BI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <235623053.nj0gFkxyW5@wuerfel>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-input@vger.kernel.org


--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 11, 2014 at 01:25:03PM +0200, Arnd Bergmann wrote:

> Why do you have to enumerate the interrupts here? Can't you just
> put all the numbers into the DT nodes of the devices using them?

> In general, I would say that the mfd driver should not care about
> what is connected to it.

This then means that all the machines using the device need to define
the interrupt table and have the MFD cells represented in the DT which
means encoding Linux abstractions into the DT.

In cases where the device is also used with ACPI or platform data that's
a definite issue since they have different idioms.  That applies less to
PMICs tightly bound to particular SoCs but is an issue in general, not
all the world is DT.

There's also issues here with us changing our subsystems.  Things like
clocks are a bit indistinct at present, they're sort of floating between
clock and other subsystems.  We've also done things like invent extcon,
making completely new subdevices.  Keeping the data out of DT avoids
problems when this happens.  The balance changes a bit if there are
clearly reusable IPs within the device but sadly hardware designers
don't always give us that and even then sometimes we don't want to use
them like that.

--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTR9thAAoJELSic+t+oim9K4QP/RmczkLU7ga1V7rzondwkTBa
KVi2m4hBhnxOE9o2ec5L3k8utITyjyZ3H28CgIllBU4niF/mjBn4QwJin7uf/Wgn
dVHTO8CWNve4iT1u7Pu18OBvVkB6SiVhdO0NrodR8H/jq+XwHkhT36nesKzRVFi7
xEP8+PPJQKlyhnGSY9SDE61Hsfw65jICxeQpTtPnlzOK9n3NL21RsXmTehO0kmdE
333VmyEmkWiu4uvQRTC5hA5JyUKpkgZ67Z5lIzsq+vzMYKDPpVnpvAkf2ekZq7sS
+ETV6nOm+Y/Bf/nRRtatd/RXTAvtTCGDtegqtAUvDvFb92fdtDd8S3u5PGEyxini
Ixpc9OMvhoHdPspj/kwn/yRtc2TVA/An7Y1qHQvNi3g5c4H1MXECnwUce4HJ00y8
b9uMi5Sgd5iOSr5h3mZLmToorCNf422eWTpftsMipHdIcBuvcLXsdFWYxetmr5IJ
68NQAUZJKnKyzl3+fXwqH9eIevn47BnF4YkpQuW0Fy9Tqip10HIU3KW9TRd+9iN8
UWB0VDjgCADU612iQF6I8o1wOJGZll+W6zeETjCv/msweGJCWLZtqs1P2qQupDCZ
FYsP1r0UXt/ZYWUNbSaytM/wJsSvRgbEhEqfXeYAFY0xrb07h9tEwfhWQu2s0yUT
fYbsW8l9m7iayNnzNQvv
=h3W9
-----END PGP SIGNATURE-----

--oTHb8nViIGeoXxdp--
