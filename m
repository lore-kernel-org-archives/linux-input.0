From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [PATCH v2 1/8] mfd: AXP20x: Add mfd driver for
 AXP20x PMIC
Date: Sat, 22 Mar 2014 17:33:13 +0000
Message-ID: <20140322173313.GU552@sirena.org.uk>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
 <1394898225-28452-2-git-send-email-carlo@caione.org>
 <20140318155919.GS25478@lee--X1>
 <20140322165132.GC20668@localhost.fastwebnet.it>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xku3GkZTJumTa1rO"
Return-path: <linux-sunxi+bncBDQ2L75W5QGBB5USW6MQKGQEKUPKFSQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140322165132.GC20668-bi+AKbBUZKZeIdyRz4JgOMwOAu8XWILU@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org


--xku3GkZTJumTa1rO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 22, 2014 at 05:51:32PM +0100, Carlo Caione wrote:
> On Tue, Mar 18, 2014 at 03:59:19PM +0000, Lee Jones wrote:

> > > +	of_id = of_match_device(axp20x_of_match, &i2c->dev);
> > > +	if (!of_id) {
> > > +		dev_err(&i2c->dev, "Unable to setup AXP20X data\n");
> > > +		return -ENODEV;
> > > +	}
> > > +	axp20x->variant = (int) of_id->data;

> > No need to cast from void *.

> My compiler says otherwise :)

Are you sure your compiler isn't correctly telling you not to cast away
const?  If the compiler is complaining about a cast on void then it's
spotted a definite bug.

--xku3GkZTJumTa1rO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTLclWAAoJELSic+t+oim9fjEQAI41viLYjrA+bNWAgALS4P5b
SXdUbcTT65G70QShWbpfSQnWjgLIygmejAsUrmFlyGiRVoqsj1k10C6e4peOvLVJ
L4uU216k/DHiYweNb3vTzuXxyyng64CKbZTpwhAoak67j/PvC2XGbrceyEisIYmv
uaIB1GqmRbzvsVmCTa1pUbwUESDRmcGg4KjiiqY7aeS33M8lbSKsO/895jxP6fb+
pL5L7xq4uhTc/au4EONayn9EYYpezi3is97mD3iDX3fQnqO8YCfKlLpt1agzj7jZ
OKojDVHRt8yqHMggRe4JZ8eUVk2dz8pWtt5qI9/lfFACubU1voUbh9ujLCuN7vPk
n5aT7oJEL/SlWKd12PSrUTGKwUdPRRC1YNWCJ47G8Ws6MzfZuNSbTWLPoivcZNCi
hZUjhdsV+ORl9GfDXo0GitEI3xj2KOdzyKzh6R/nXm1PmaFk1yvakhbtqy0K5bJl
AIipXUd20LwbOfd48+1zDRbrQFgmZl2tapGhS/A8fgdx/ys9ul41k5PivOx0P8E7
KA44Kv5U19AKBzdsMD70frNr14o+lQhfcQ4DGhEUATvK4M3qK6zRgys4ejX9wzIU
EPEUEaTVebSu+GWu0fZiirI6y4uY9eWu/HReztqd1Jfh5PrG5GzZHYkBiukzfUhN
uW9pJizeDQx0C0s+yNgs
=QzrO
-----END PGP SIGNATURE-----

--xku3GkZTJumTa1rO--
