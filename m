From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 19/19 v2] mfd/ti_am335x_tscadc: add private lock/unlock
 function for regmap read/write
Date: Wed, 29 May 2013 12:12:53 +0100
Message-ID: <20130529111253.GR3660@sirena.org.uk>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
 <1369681926-22185-20-git-send-email-bigeasy@linutronix.de>
 <20130529084642.GA18273@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2D20dG0OqTzqkNh7"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130529084642.GA18273-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--2D20dG0OqTzqkNh7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 29, 2013 at 10:46:42AM +0200, Sebastian Andrzej Siewior wrote:
> Without this, devm_regmap_init_mmio() creates & uses a simple
> spin_lock() and this should be enough. Within the probe function the
> registers are read and written in process context. Later they are
> accessed from the ISR and lockdep complains because now the lock is
> taken suddenly with IRQs enabled. Currently I don't see any other way to
> keep lockdep quiet than doing this.

This is not a good place to make this change, there's nothing specific
to the device here and in actual fact there's already a change in the
works from Lars-Peter Clausen converting the spinlock to always use
spin_lock_irqsave() so it should be resolved soon.  The thread was on
lkml in the past few days.

--2D20dG0OqTzqkNh7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRpeKyAAoJELSic+t+oim9N4kP/258Zv7HSI7fy+bdO6a75yZG
R24iFMWMvolGBamoJ+DM0o0/7bEg9C7CJA8fIBddEV+7jMDvoOASdc7rChGMq0Su
5MqQmx+hosticY0P8lYV13v6n66/fXZmr3VQJ/IRzSAKtoNgPMCxjoXcJZ+qHSA6
vwXvyN1KOFXec16PBdG+XNT6VS0YefwW7/RJ0uJYPsX49WLMeszMGwScIWc661pL
nPV+g2gJG1OpCwVcXUdcmgsrxydXH4yWCsx5UBuccd8hViFH2fVJ9tM9g/wsp4oj
8G6yOvZoIw08IvVLWn22rM+5SyyOB9UZMG+H2K/qJQ45lU5jz6DWXxA9P+5Be6V+
NvqNSxHWYJT4f/4b+Haw1Ip1MwruX1A1sTuoAtCz3uGc+5/K5t8+BnfsaKxL99Ga
VP2mg7BfdUF2Wsc/tlTW597SF/2qZw92pNNjk51BnTOZi2zPLUrDPrxFMc/vBJiY
JHzZ0LiAP/tui/yhJXFj9cooWJsohVO9eIJLIlq8hI0N264TVk3oDW+E6u2cyNx0
hNNGcblMfXdV90HJJm/7hzuXWYbCnlr3MJl+Gq2zoMau1mHM+bJ6QVKl2jW2Pv3A
jYAgIFs8goqAIEAzTSy+GP2AtvQG7ElQGYjdgNNzEhAZxiVGmEjX9B7+njhLRon/
YBD8FPhDd97AyFcyd+Cg
=gnFO
-----END PGP SIGNATURE-----

--2D20dG0OqTzqkNh7--
