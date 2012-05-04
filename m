From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] i2c: Split I2C_M_NOSTART support out of
 I2C_FUNC_PROTOCOL_MANGLING
Date: Fri, 4 May 2012 11:08:36 +0100
Message-ID: <20120504100835.GB14230@opensource.wolfsonmicro.com>
References: <1336042416-28330-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20120503203617.31179f9b@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:39201 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754538Ab2EDKIj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 4 May 2012 06:08:39 -0400
Content-Disposition: inline
In-Reply-To: <20120503203617.31179f9b@endymion.delvare>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-fbdev@vger.kernel.org


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 03, 2012 at 08:36:17PM +0200, Jean Delvare wrote:

> You must also update the description of I2C_FUNC_PROTOCOL_MANGLING to
> no longer mention I2C_M_NOSTART.

For backwards ABI compatibility _PROTCOL_MANGING still has to imply
_NOSTART, though it's unclear if that should be documented here.  For
drivers it should for the most part flow naturally as I'd expect they'll
end up implementing one or more of the mangling flags anyway.  For
applications I guess it means that they should fall back to checking for
_PROTOCOL_MANGLING if _NOSTART isn't there.

> > +#define I2C_FUNC_NOSTART		0x10000000 /* I2C_M_NOSTART */

> Sorry for nitpicking but wouldn't I2C_FUNC_GATHER be a better name?
> NOSTART is an implementation detail now, the high level feature is the
> ability to gather multiple messages into one.

I kept it this way mostly because it means that the capability flag has
the same name as the feature flag which seemed helpful from a usability
point of view.

There is also the fact you could in theory also implement gather support
in other ways (eg, using DMA) though at present there's no API level
support for this and the users do have to code this specific
implementation.

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPo6qdAAoJEBus8iNuMP3dfawP/1UiT5JzLnhdRgi21zkMQw2E
cJCvdvcJ9NUt4nQMBM5fcemy9GeU6CJR/LpmRnisMtfdaWIs3VstK+jySE7EEgx1
87KDsaT668ELYpoZWdgkfANhlVMx/TvOpv+UzFgrqj0BT0a7QVD8JOknIuzXStHl
6pXh26aTqAjdGIDJNy2i5cp80LjGC803YdK6A/6clOEwNHbQj7fFeKjvX84Z9bdu
AXFuMERmICkK1xI5lCMdg5OWJqMfWYwivNGTixg+8pfYenXxDNHpmWQQ5Zi4fLbi
AY/zIfxOgcpM7pHxgZ5u5xlknocG1IuDJvCYgQrmZgE/8QW74+THLpsY0maMZE+x
hPPezkEl89bcVd7YBeeykv6zIxNLqgjR3AuwXU5NkmZbWfXTrroXC3oiVEUb1tNq
wTtdPgTK+9KbIr08KHHHY4klecIvFL0KpjNdkDeejJw+ykiWft3+OaWil31O5WnX
BglnstKrKQ8fPvIMCi+kg8/hnEsOToggQ+6LI8qHWtYYRj8JJ4g22RTBBaLgY13i
wXk0viCrb3R1WSmh4zBv9j4PTwe5VS7Ii1F7/3JGWuvI5m+p+al7zrBG2QGKXPqp
25G6cGNIE9RaWbUllxckfW+39C5HytOwRPK9iHUUfDo1G1O/FgxEA9Tq6wzF1YEn
jCeYeTUMeDojQvrlARQm
=VXrh
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
