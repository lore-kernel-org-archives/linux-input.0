From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [PATCH v3 06/10] regulator: AXP20x: Add support
 for regulators subsystem
Date: Sun, 30 Mar 2014 00:47:03 +0000
Message-ID: <20140330004703.GL21628@sirena.org.uk>
References: <1395955764-18103-1-git-send-email-carlo@caione.org>
 <1395955764-18103-7-git-send-email-carlo@caione.org>
 <20140328133934.GQ30768@sirena.org.uk>
 <20140329175201.GD3952@localhost.fastwebnet.it>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fDERRRNgB4on1jOB"
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBN6T3WMQKGQEYT2R5EY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140329175201.GD3952-bi+AKbBUZKZeIdyRz4JgOMwOAu8XWILU@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org


--fDERRRNgB4on1jOB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 29, 2014 at 06:52:01PM +0100, Carlo Caione wrote:
> On Fri, Mar 28, 2014 at 01:39:34PM +0000, Mark Brown wrote:

> > This is fairly obviously broken - it's overwriting the normal runtime
> > value, this will disrupt the running system if we want the value we use
> > on suspend is different to the value we want at runtime.

> Ok, silly question: isn't it exactly what we want? Set the voltage for
> the regulator when the system is suspended?

This needs to be done without affecting the current system state - many
PMICs are aware of system suspend and have support for transitioning
into a separate suspend state, this should only be configuring that.  We
may call this function separately to the actual suspend.

> > Think about it - if this was a sane thing to do the core would just do
> > it without needing driver specific code, we already know how to set the
> > voltage for the device.

> I thought it was because some regulators can have specific regs for
> managing the suspend mode.

Right, but if the PMIC doesn't have that feature then it should indicate
that by not implementing the operation and letting the core worry about
how to handle the situation.

> BTW, but then what is the difference between my code and (i.e.) the same
> routine in da9055-regulator.c?

> http://lxr.linux.no/linux+v3.13.5/drivers/regulator/da9055-regulator.c#L276

That's updating the B register set which IIRC is used only in suspend
mode.

--fDERRRNgB4on1jOB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTN2mDAAoJELSic+t+oim9Hv0P/0yl/CeyNRkYogXhcYB75ocd
IdShKYbPPSzYhLNNab97A2GC4yi983+Y9S2DevBXNuWmsJDpwl1n0yzDaNYPJu0S
oKjNH1R5qQ7YjWZoU5Bwh7MzGH0dnZs4t6N/eJntYcQqx7OAxbVMi1MXEWJYrVOi
/YrmaPM8OGvcbSgRrplR5+2p3zXFCHXYPghiOEcHpjTsdao5Mhfc+5fBXLhXn4lJ
xTXonxV+ZgUXPca3i7FEYHSI4l4lhKuutrtD+TbgjCYNdZXuIVUiTFdp6ciu+7PD
4vvORBqSaDt5fHiYctpoURarTJrgsNunujFvf0knhtaEXEkSpnbbV1dDEccfTdPY
JixXjjQ7JG2fjLpfkDZ33BoJyeuD5ZNrQrC+h0b6a2sM3PsjWi1xKrUwl6+yo+5x
+9vdhAxWY1dQjYdR1Wid6O+j8dj7+mTsoneeJGOWiiU7Aoml6EczkaXr3XZg+vJF
1ai4ENMxs7nDz43WuW9luRV5Du31MOKP2GEGEZdq8ujjLZINFsN+YIr34AuouW1x
d19yIMtnATrtVMMjeynS+MpNhZcB4dsFOiVXRDeB4MkqaJsGDLe4TXhL5abrSR+i
T+IJBcIxa9RcnoljlfuAa7eN1nuMeCR3uWG/UNBdX+e2G0hyFyhnZ9MWAxWZJC9d
EvL3PiO63nPFsX3K3ZVO
=O7F0
-----END PGP SIGNATURE-----

--fDERRRNgB4on1jOB--
