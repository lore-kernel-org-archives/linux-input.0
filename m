From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [PATCH v4 7/9] ARM: sun7i/sun4i: dt: Add AXP209
 support to various boards
Date: Mon, 14 Apr 2014 12:16:07 +0100
Message-ID: <20140414111607.GL28800@sirena.org.uk>
References: <1397209093-10077-1-git-send-email-carlo@caione.org>
 <1397209093-10077-8-git-send-email-carlo@caione.org>
 <20140414095256.GA28585@lukather>
 <CAOQ7t2ZybF=dm-NBQ3niN7gb-Asgwz5CW-VSkOzWR6t2NCaA8w@mail.gmail.com>
 <534BB670.8030102@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dpynvXbW/eW9Tpc3"
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBEUHV6NAKGQEZ7WURRA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <534BB670.8030102-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-input@vger.kernel.org


--dpynvXbW/eW9Tpc3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 14, 2014 at 12:20:32PM +0200, Hans de Goede wrote:

Please fix your mailer to word wrap at less than 80 columns.

> As Mark has also mentioned we should probably pin the regulators to a
> certain voltage, except for those which we expect to be controlled by
> a driver, so basically all of them should be pinned to a certain
> voltage except for DCDC2 which gets used for the cpu voltage which we
> will want to scale as soon as we've a cpufreq driver.

If you don't know what to do with the regulators and don't have any
information on what's safe then you shouldn't be specifying a voltage at
all.

> While testing the latest revision of your code I also noticed that the
> kernel ends up disabling LDO3 and LDO4, which could be fine on some
> boards and a problem on other boards.

> I think we need to be careful here. For now it may be best to only add
> the DCDC2 regulator to the dts, as we know that dcdc2 is used for the
> cpu voltage everywhere, and we will actually want to control that
> later on.

You need to at least specify that regulators that need to be kept on are
always-on.

> For the others, for the boards where we've schematics (*) it would be
> good to add the other regulators with fixed voltages as specified in
> the schematics. For the rest it may be best to simply leave the
> regulators alone / at their default settings.

If everyone has been running the board at a voltage different to that in
the schematic then I'd not assume that everything has been validated at
the voltage in the schematic, if production firmware is available that's
going to be a more reliable guide than the schematic but it sounds like
all these boards have just been left to run at their default voltages.

--dpynvXbW/eW9Tpc3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTS8N0AAoJELSic+t+oim9jtgQAIy6O5hUxYaTZBMneZ8j9UWN
fxiOX7MlWPKhyCIQA/+ggdm0rnutsZnjifYL9gNBoJPbp3Ief445ZscFxcY1xeiZ
2wzIt1OQ1uVzZFHvitbNrTPDhQeqo59t5WAexfrSr5JhkqU/L0cxZIM3Qmc3zCx7
NxSJ7AWDvwfdvE7mdmT9DCeEXhqQVqOQq2OXxSXSrGbxr6V7Y8V3POzwTA6rk+4D
etJRyO5GOZRTGg/XRUGO0Hy3qNFj6AeqzKfRQLRuXN8rYN/fwueIk9FXczVH2cVh
Rhzat9A9+ScMGTsxD+54ycNhvblaYS0C/ICdmydX/O60V3oHQd733GCSp1O1z1fx
K7IbxBUcVxd4Kw1C2Xz/dmigiqJVF2UZZHeHa2V4qMulxnrM6fEQb6Lm1MevOAve
BIlkNnC7BMgpHF7SsCTksnKHtc6HsV+jtNR6qLu9dblNGOC2vtDnLnhF9e5NfUqc
ewsAnNj48fw3UfdZEdrwGVNyyrOIwlbuE+0TisnAEpoZi4of3oPymaigcELoZ5tP
0pGdxLuYHzSVj7R/1iZfXvNyYGMCenJ6ipv+0/euqk/8I118TCkdkO6zn4/eE7On
Bm88ENld3DdALs6K5CQhWFs21UqbudbvgsUhMtt+c+1l9DMI6Pcgmglhcs8Fid1i
oTcD+RJ5QuMD/57hmnsL
=kjE2
-----END PGP SIGNATURE-----

--dpynvXbW/eW9Tpc3--
