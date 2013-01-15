From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH v2 2/4] input: keyboard: tegra: use devm_* for resource
 allocation
Date: Tue, 15 Jan 2013 16:44:23 +0100
Message-ID: <20130115154423.GA13871@avionic-0098.adnet.avionic-design.de>
References: <1357371910-3164-1-git-send-email-ldewangan@nvidia.com>
 <1357371910-3164-3-git-send-email-ldewangan@nvidia.com>
 <20130105080658.GA1315@core.coreip.homeip.net>
 <20130106192739.GA11566@avionic-0098.adnet.avionic-design.de>
 <20130106195748.GA28212@core.coreip.homeip.net>
 <20130109070745.GA12782@avionic-0098.adnet.avionic-design.de>
 <20130109091939.GA4369@core.coreip.homeip.net>
 <20130109092352.GA28037@avionic-0098.adnet.avionic-design.de>
 <20130114154959.GA25049@avionic-0098.adnet.avionic-design.de>
 <20130115130623.GC2625@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7052452495653836699=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130115130623.GC2625-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


--===============7052452495653836699==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2013 at 02:06:23PM +0100, Wolfram Sang wrote:
> Hi,
>=20
> > > > > > I am sorry, but I do not consider a function that was added a l=
ittle
> > > > > > over a year ago as a canon. If you look at the uses of EADDRNOT=
AVAIL it
> > > > > > is used predominantly in networking code to indicate that attem=
pted
> > > > > > _network_ address is not available.
> > > > >=20
> > > > > EBUSY might be misleading, though. devm_request_and_ioremap() can=
 fail
> > > > > in both the request_mem_region() and ioremap() calls. Furthermore=
 it'd
> > > > > be good to settle on a consistent error-code instead of doing it
> > > > > differently depending on subsystem and/or driver. Currently the v=
arious
> > > > > error codes used are:
> > > > >=20
> > > > > 	EBUSY, EADDRNOTAVAIL, ENXIO, ENOMEM, ENODEV, ENOENT, EINVAL,
> > > > > 	EIO, EFAULT, EADDRINUSE
> > > > >=20
> > > > > Also if we can settle on one error code we should follow up with =
a patch
> > > > > to make it consistent across the tree and also update that kernel=
doc
> > > > > comment. I volunteer to do that if nobody else steps up. I'm also=
 Cc'ing
> > > > > Wolfram (the original author), maybe he has some thoughts on this.
>=20
> Handling the error case was the biggest discussion back then. I
> initially did not want to use ERR_PTR, because I see already enough
> patches adding a forgotten ERR_PTR to drivers. My initial idea was to
> return a simple errno and have the pointer a function argument. I was
> convinced [1], however, that the dev_err printout is enough to make
> visible what actually went wrong and return a NULL pointer instead. So
> much for why the function does NOT return a PTR_ERR, and I still prefer
> that.
>=20
> Then, I added the example code in the documentation using EADDRNOTAVAIL.
> Yes, I was brave with this one. Yet, EINVAL, EBUSY, ENOENT, did not
> really cut it and are so heavily used in drivers that they turned into a
> generic "something is wrong" error. I tried here to use a not overloaded
> error code in order to be specific again. Since the patches were
> accepted, I assumed it wasn't seen as a namespace violation. (Then
> again, it probably would have been if that error code would go out to
> userspace) Naturally, I didn't have the resources to check all patches
> for a consistent error code.

The problem with the current approach is that people (me included) keep
telling people to use this or that error code in an attempt to achieve
some kind of consistency. Also using an error message to distinguish
between reasons for failure makes it impossible to handle the error
other than by visual inspection. Granted, there are currently no code
paths that require this.

One problem with the original patch was also that it didn't actually
convert any existing uses, so there was little chance of anyone noticing
potential problems. More than a year later this function is used by many
subsystems and a lot of drivers. It just so happened that I observed how
many people just didn't know what error codes to choose and often just
grabbing one randomly.

By adding devm_ioremap_resource() and having it return ERR_PTR()-encoded
error codes we get rid of all these problems and put the responsibility
for choosing the error code where, in my opinion, it belongs: the
failing function.

> > > > If you going to change all drivers make devm_request_and_ioremap()
> > > > return ERR_PTR()-encoded errors and then we can differentiate what
> > > > part of it failed.
> > >=20
> > > Yeah, that thought also crossed my mind. I'll give other people some
> > > time to comment before hurling myself into preparing patches.
>=20
> As said above, that was argued away when committing the patches.
>=20
> But there is more to that:
>=20
> When working with this function, there was also the idea to abstract
> getting the resource away. Which then gave Sascha Hauer and me the
> question, if drivers really have to do this or if this couldn't be done
> by the kernel somehow, i.e. giving the drivers already the resources
> they need, completely prepared.

I'm not sure I like that very much. That could possibly lead to a new
problem where drivers that need to do something special have to jump
through hoops to achieve something that may otherwise be simple.

Anyway, if people don't think this is a sensible conversion I should
waste no more time on it. On the other hand I have the patch series
ready so I might as well post it for broader review.

Thierry

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ9XlXAAoJEN0jrNd/PrOhh9UQAK0B8uBj+nhk8NTmPxVI65jv
8Zdt7CGm/lQF4gv+pNX07dQ21HQ298RcZEOxfciNRWqRYeS6vl2NUTDmyXK8SGBs
2llQPH/2MU7aRlxYhqZGJxtLOhV+J7LHQ1rHkVrtEXC+AsNfs+MzsrsOmaDpcFF7
WX6p14L0+AlCsctGHuIEWapgsDD1kZrdrPrUz694srUyMi0o9PMugE2JRtBi6ChU
UAePUOxQ91Lafht9xHOCJksoYWUNsfTVwkKXUKAIINJsJozu4CBHklTKSsyFJYSA
TkIHo5CBJI+cvMdkzveeyVvYWkUdHxbrWAiIS9sBnh659DcDVmTcIlHlBkFDl39s
Ynqx8+Um4F12259/z5pgJH5SQaDt5UNR67Ef434bLXqPyMX3QyLWPgZazvLCDosC
vWPK1YR7lC4b2gqePjqxe8RsJFo7KnNRfpU1lowl62Jz2pLLppTJwUm7OjCMaufr
fZSX0ghzzvzrIcjah91M6Ia9oEZMScGwIfMJ87TV25lbIeIR1tRVtWcG0UJ/WYIn
ZlDG1egRIdRVZT1OVB0KtTOooHZ5tci58GwLtSFaTfbPr0fgLsDl73gtq0FNse7z
jKve1yrPve37PFgX7ARaCJBhep02s7Gs5piasfnvqNWWUKBslZnYN+DTE2wFYOlY
Q3LIpORpa2YjVmbabBor
=x7DQ
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--

--===============7052452495653836699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============7052452495653836699==--
