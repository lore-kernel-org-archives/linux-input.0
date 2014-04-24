From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 7/9] ARM: sun7i/sun4i: dt: Add AXP209
 support to various boards
Date: Thu, 24 Apr 2014 18:12:52 +0100
Message-ID: <20140424171252.GD12304@sirena.org.uk>
References: <1397209093-10077-8-git-send-email-carlo@caione.org>
 <20140411122901.GE28800@sirena.org.uk>
 <CAOQ7t2Y2B7f+eZApDHKiKm9=bOXo6oUA2RLY7ENn7qPLQEboMA@mail.gmail.com>
 <20140411161813.GF28800@sirena.org.uk>
 <CAOQ7t2YO_MjUZkkoEe1Grft+fVttWoOro85Sru2P3LXbx8Kjbg@mail.gmail.com>
 <20140418151551.GZ12304@sirena.org.uk>
 <20140423202546.GA3890@nuc.fastwebnet.it>
 <20140424133036.GY12304@sirena.org.uk>
 <20140424163523.GB25663@opensource.wolfsonmicro.com>
 <20140424165847.GC25663@opensource.wolfsonmicro.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="af9HaG2/jgryHGZC"
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBNUM4WNAKGQEKF4QVXQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140424165847.GC25663-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org


--af9HaG2/jgryHGZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 24, 2014 at 05:58:47PM +0100, Charles Keepax wrote:

> Ah ok seems I am getting an error but for some reason for me it
> shows up looking very unrelated to the supply mapping. In that it
> shows up much later in the log and doesn't seem to mention the
> MFD at all:

If you look at the warning you'll see that it's complaining that it's
trying to probe a device which has devres stuff attached to it which is
happens at the time the function driver gets loaded.

--af9HaG2/jgryHGZC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTWUYRAAoJELSic+t+oim9NTEQAI38FIKHdSxq9Mxwborhdlnb
MtJCmIOjhQndiCAtT9nvkNd6S55WpDe5Vt3xKMK59DPq1KwVmwil0cD1e4n+V5kc
9Hs5bmFMrSpUahh07klj4B1CIAIXSu062ddnDmFmJRmrm1JBlkeoCrR4BFPv4/Il
XcKahRGj0HPj5o1tp173A7Qbs/IgX50Ra98VwyQPKeQxBYUZjU+vnbuRRi7fyI4C
WA5t7tTYxm10n28rg0bdlsmGLp0dqR09lh6v1RgNY3LXidFW4hYJzllIWN0kadvE
pIomodsZNPv1u8gUPWJ8neZz1R1XsoNuOP11yc5q3xKWdQpPfepAQxU3WgxebwLM
PZs2PnXuP93R5C4vDD8NSSt3QDvgOzPRPBC1n6MSgI8oCWW8HJtE3+aGHBvFdW97
iBIZo3YhnBYU/4+XBnjtM5XDFqG0CuoPegLDl50CgOQMSuYRd+n9tASG7g/fzN7o
8HdABrHlAQrqfH10VSZAlqtU8pTbBgontgyMyi8FqLVnA/uBcwaN/jeKtoVYWZfF
VNgcXqlasnSNRl0GzcYIKpY12v37H0swUWgTDY5cWhbNaslmu1u2/7TdYG4nFueF
UvWSfGyXskmumb+zigTSYW49sqQnZO/zX36v67I5v2fRnrtlXJNMQnEgUNRs2jWi
pktY8zVN0b4LP3EyfLNt
=04Xd
-----END PGP SIGNATURE-----

--af9HaG2/jgryHGZC--
