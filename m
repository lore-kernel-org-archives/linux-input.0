From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: Re: ABS_PRESSURE and 0 ranges
Date: Thu, 25 Oct 2012 22:11:27 +0200
Message-ID: <2331954.qazEWXyvNO@donald.sf-tec.de>
References: <2119530.D54ZbrWB3u@devpool02> <20121025183452.GC24594@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart17781199.CICZXCk0hA"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.sf-mail.de ([62.27.20.61]:58837 "EHLO mail.sf-mail.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755951Ab2JYUPv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Oct 2012 16:15:51 -0400
In-Reply-To: <20121025183452.GC24594@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org


--nextPart17781199.CICZXCk0hA
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

You wrote:
> Hi Rolf,
> 
> On Thu, Oct 25, 2012 at 02:59:49PM +0200, Rolf Eike Beer wrote:
> > Hi all,
> > 
> > as I found out the hard way tslib does the detection if a touchscreen has
> > been "clicked" if the kernel driver says it does not support
> > ABS_PRESSURE. But when the kernel says it can do ABS_PRESSURE tslib will
> > not do it's emulation and just pass on whatever pressure value the kernel
> > sends.
> > 
> > So far, so good. Sadly there are some drivers that do:
> > 
> > input_set_abs_params(dev, ABS_PRESSURE, 0, 0, 0, 0);
> 
> What drivers are doing this?

git grep 'ABS_PRESSURE, 0, 0, 0, 0' drivers/input/

> > Guess what happens: no clicks at all. The question I have is: does the
> > above line make any sense to be in a kernel driver at all? Or is that
> > some voodoo that must be there and it's all tslib fault?
> > 
> > Now that I know where the problem is coming from the problem is easily
> > fixable, I'm just wondering which patch to make.
> 
> Well, the limits are strictly advisory for userspace, input core does
> not perform any clamping or discarding the data that falls outside the
> limits, so tslib probably should not do that either.

My main concern is that if the driver says it will only ever give pressure 
values from 0 to 0, what useful stuff may that ever be? And since the driver 
says it supports presure touchscreen will wait for the driver to report it. 
Since it will never do it (or could at most return a 0), then there is nothing 
that could ever become a valid click event.

Eike
--nextPart17781199.CICZXCk0hA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEABECAAYFAlCJnPYACgkQXKSJPmm5/E7bhACdHMhHNXeM7Ru450afjYvEeS5T
17UAn1eYmHIuXgHCFpvkAgqvYiB8uJE0
=cm4c
-----END PGP SIGNATURE-----

--nextPart17781199.CICZXCk0hA--

