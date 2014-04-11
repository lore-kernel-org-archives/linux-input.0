From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 6/9] regulator: AXP20x: Add support for
 regulators subsystem
Date: Fri, 11 Apr 2014 13:23:45 +0100
Message-ID: <20140411122345.GD28800@sirena.org.uk>
References: <1397209093-10077-1-git-send-email-carlo@caione.org>
 <1397209093-10077-7-git-send-email-carlo@caione.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n2Pv11Ogg/Ox8ay5"
Return-path: <linux-sunxi+bncBDQ2L75W5QGBB5F5T6NAKGQE4AE3EBY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1397209093-10077-7-git-send-email-carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-input@vger.kernel.org


--n2Pv11Ogg/Ox8ay5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 11, 2014 at 11:38:10AM +0200, Carlo Caione wrote:
> AXP202 and AXP209 come with two synchronous step-down DC-DCs and five
> LDOs. This patch introduces basic support for those regulators.

Applied, thanks, but I had to resolve some trivial add/add conflicts
with the Broadcom regulator driver Makefile and Kconfig additions -
please remember to submit patches against current code.

--n2Pv11Ogg/Ox8ay5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTR97OAAoJELSic+t+oim9LBEP/00tQwURJhKQy5egnZKWABcd
t/7sNlRxZZis90ZTUZexI/lzqqdht+j21v9EsKi4yDgXVOaSASWvQtR6SYMj6FeX
2z1F4IV7lcsFgpJfrN0bUYbBZrezHc+PpVnkN37dScu5Y6F9gP84a1nwYjUZQRU+
p//ZSllh3idkYkMMi9b4WUy6CrEP762P25KTO4kjUNoIFrBNAEqZxhC6do1aMsak
VCLSROIhSSlRrCmPun7lm5Qvd8iNVJz848SIoo89+gqCLCyS+XGTEunwF6c/uqDl
svr8jiAgm+oMaFobZyA7XqnXpVCNAyT+lJQJ1Zfjit3tWp7vLqF/mzK5J0cUzW3f
U+g/NztJgrS4wbv+hpJdH09BfUMyHL8a5DzlQAOjIEL1CGK2Ko/VyqkYDLfFTL1u
Korbk7wgMX53VhW7kHKAbGSE0kEHHXqBxkmuj0m9G+5ZY3FkXKZTMVsFlEJ4obRO
BF/Kd2wbFnIyL28GMNZaCQPRZacCg6N5PG4nq7C8tlT9LLztWnBj5YML2e0DvFUT
a4Uxg4Efy8OqB7NzXvbhewRECmufXrSCcQAgr+VnKW06Ri/s/pUUlUblpcl3vhWg
iqbRoOteDcfG7+dketcuvC9TO7EdoakUpdoar7ORM/kzKXNicqTse2hC26HsrlAK
PWmttQDU0i3nwI2+eHmz
=5eYH
-----END PGP SIGNATURE-----

--n2Pv11Ogg/Ox8ay5--
