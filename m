From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] driver:gpio remove all usage of
 gpio_remove retval in driver
Date: Tue, 22 Jul 2014 16:11:25 +0100
Message-ID: <20140722151125.GS17528@sirena.org.uk>
References: <CACRpkda6mzVdaN0cvOxpbsxWyCv2nGyDXOjZg_5aT8u7SSQeUw@mail.gmail.com>
 <1405197014-25225-1-git-send-email-berthe.ab@gmail.com>
 <1405197014-25225-4-git-send-email-berthe.ab@gmail.com>
 <CACRpkdasp9bLULT7NJM9nYX58rRSsQKXFddOLz9Ah6kp-j-3=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6413639885557492536=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <CACRpkdasp9bLULT7NJM9nYX58rRSsQKXFddOLz9Ah6kp-j-3=Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mips@linux-mips.org, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Matthew Garrett <matthew.garrett@nebula.com>, Samuel Ortiz <sameo@linux.intel.com>, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, abdoulaye berthe <berthe.ab@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Bryan Wu <cooloney@gmail.com>, "arm@kernel.org" <arm@kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Michael Buesch <m@bues.ch>, Greg KH <gregkh>
List-Id: linux-input@vger.kernel.org


--===============6413639885557492536==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="11IAkegDWp8TRrA/"
Content-Disposition: inline


--11IAkegDWp8TRrA/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 22, 2014 at 05:08:13PM +0200, Linus Walleij wrote:

> Heads up. Requesting ACKs for this patch or I'm atleast warning that it will be
> applied. We're getting rid of the return value from gpiochip_remove().

Can someone send the patch please?  Splitting it up per-subsystem would
probably be easier...

--11IAkegDWp8TRrA/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTzn8aAAoJELSic+t+oim9qWYP/j2SOMQLkG2CavmmSFDKr57D
I8wsXXkl2SzMR1t1T8XQHH4/i1kTxROPWDX81ujrkwpEMcbMvQhM6Mewj+1BHgij
KGTeP2cMT97Oo0b6U2JRsumyLep0kVo/nheFLTUkD78Vp8abIyi1FuRdppKEjYts
Fu+jJIWQJEw/HKcmdZsTaeQawLXmJ4qOUVjB5+X/sspavG0Nji8JtSXN2MHyCr9j
t52GpALDSl4wctfIYg76S/TQxRCd150MKupuUhheMYsVtGfWjqay5fQWd9GACjhC
/74HdiFf1O6nSU2dwbGVntfmU+6CBmkD8XSI0PnyV/4GQR8zofnqzcsHrUXihkzd
TcgtL0CMizQ5kJPONMoZAFIoZwNHBTxmuFJgoUV2ChU/EyXTVsX9xLs6pgUtnd1E
Y7B23ErhwwTuXN0qG3Od6OIg2QhAMGKHzBA7HJgtSFVkvtXq1DdCZyYVfttUo+Xi
KcCZEnXPu/4Ore7cYhQmxqmoeC4Qm86iklGxLgW6jq7u5bRs9Y879NX3c6IZoJuO
6xIzE8ZtOdlMqpkBELCEZw8/1A9batmaMqEBRbtn4hTpyGouH4QUyypPy41kHC1H
uYEOJMmAwo51acA4PNGyNPxGclD+fHd+Y4GAfbjX+OoCFcyJIQ3e46F3BQlNs2bS
da/t3Z8Wx+xtFh0M1tdp
=XaZs
-----END PGP SIGNATURE-----

--11IAkegDWp8TRrA/--

--===============6413639885557492536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6413639885557492536==--
