From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: Re: ABS_PRESSURE and 0 ranges
Date: Thu, 25 Oct 2012 23:45:18 +0200
Message-ID: <2136905.J2mg6vAfqB@donald.sf-tec.de>
References: <2119530.D54ZbrWB3u@devpool02> <2331954.qazEWXyvNO@donald.sf-tec.de> <2450762.pYR3zhxxMr@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3724624.PPlCqgHSuW"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.sf-mail.de ([62.27.20.61]:57933 "EHLO mail.sf-mail.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751474Ab2JYVpe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Oct 2012 17:45:34 -0400
In-Reply-To: <2450762.pYR3zhxxMr@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org


--nextPart3724624.PPlCqgHSuW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

You wrote:
> On Thursday, October 25, 2012 10:11:27 PM Rolf Eike Beer wrote:
> > You wrote:
> > > Hi Rolf,
> > > 
> > > On Thu, Oct 25, 2012 at 02:59:49PM +0200, Rolf Eike Beer wrote:
> > > > Hi all,
> > > > 
> > > > as I found out the hard way tslib does the detection if a touchscreen
> > > > has
> > > > been "clicked" if the kernel driver says it does not support
> > > > ABS_PRESSURE. But when the kernel says it can do ABS_PRESSURE tslib
> > > > will
> > > > not do it's emulation and just pass on whatever pressure value the
> > > > kernel
> > > > sends.
> > > > 
> > > > So far, so good. Sadly there are some drivers that do:
> > > > 
> > > > input_set_abs_params(dev, ABS_PRESSURE, 0, 0, 0, 0);
> > > 
> > > What drivers are doing this?
> > 
> > git grep 'ABS_PRESSURE, 0, 0, 0, 0' drivers/input/
> > 
> > > > Guess what happens: no clicks at all. The question I have is: does the
> > > > above line make any sense to be in a kernel driver at all? Or is that
> > > > some voodoo that must be there and it's all tslib fault?
> > > > 
> > > > Now that I know where the problem is coming from the problem is easily
> > > > fixable, I'm just wondering which patch to make.
> > > 
> > > Well, the limits are strictly advisory for userspace, input core does
> > > not perform any clamping or discarding the data that falls outside the
> > > limits, so tslib probably should not do that either.
> > 
> > My main concern is that if the driver says it will only ever give pressure
> > values from 0 to 0, what useful stuff may that ever be? And since the
> > driver says it supports presure touchscreen will wait for the driver to
> > report it. Since it will never do it (or could at most return a 0), then
> > there is nothing that could ever become a valid click event.
> 
> Once again, the limits are simply advisory and can even be adjusted from
> userspace (EVIOCSABS).
> 
> So ucb1400_ts does report true pressure so all is good there, but tsc40 is
> not. I think the claim for ABS_PRESSURE is left over from time when tslib
> did not think that device without ABS_PRESSURE was a touchscreen. I'll
> remove it from the driver.

Thanks, so I know what part to patch. Please backport that to stable, too, so 
tslib will work with that driver even on stable kernels.

Eike
--nextPart3724624.PPlCqgHSuW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEABECAAYFAlCJsvYACgkQXKSJPmm5/E47IACdE5Rleib2ukwXF0DpsRl4oV1w
NIIAoJ/RL2E1w3ZLXHw+Tx6RWBupFGOc
=Dims
-----END PGP SIGNATURE-----

--nextPart3724624.PPlCqgHSuW--

