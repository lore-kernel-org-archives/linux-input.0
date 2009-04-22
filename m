From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: Re: [PATCH 0/4] fix some improper uses of dev_set_name
Date: Wed, 22 Apr 2009 18:06:11 -0300
Message-ID: <20090422210610.GL4691@vespa.holoscopio.com>
References: <1240273036-5995-1-git-send-email-cascardo@holoscopio.com> <20090422054531.GD9009@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oplxJGu+Ee5xywIT"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from liberdade.minaslivre.org ([72.232.18.203]:37357 "EHLO
	liberdade.minaslivre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173AbZDVVGQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Apr 2009 17:06:16 -0400
Content-Disposition: inline
In-Reply-To: <20090422054531.GD9009@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de, linux-input@vger.kernel.org, kay.sievers@vrfy.org


--oplxJGu+Ee5xywIT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2009 at 10:45:31PM -0700, Greg KH wrote:
> On Mon, Apr 20, 2009 at 09:17:12PM -0300, Thadeu Lima de Souza Cascardo w=
rote:
> > dev_set_name expects a format string. Many of its uses, however, blindly
> > call it with a string variable that comes from some external, perhaps
> > unreliable source. Some of those uses are safe, like those in the third
> > patch in the series and most of those not fixed by any of them. Some few
> > remaining uses may require some more attention to decide if a patch is
> > really required. Perhaps converting all of them for safeness is a good
> > compromise.
> >=20
> > Thadeu Lima de Souza Cascardo (4):
> >   driver core: use string format when name is another device's name
> >   driver core: use string format when name is given to an exported
> >     function
>=20
> These two patches were a bit more than just the "driver core".  Care to
> split them up into the subsystem-proper sections and send them to the
> different subsystem maintainers?
>=20
> I don't see anything here that can come from a user supplied string, do
> you?  So it's a pretty low priority.
>=20
> thanks,
>=20
> greg k-h

OK. I will do the split by subsystem and send each one separately to the
maintainer and lkml.

Besides the fourth patch, I think. I will do some more check and,
perhaps, even send it to stable.

The third one will be sent to input subsystem and it is pretty much
2.6.31 material.

For the other two, I've separated them (and joined them) because the
situation is pretty much the same as well as the decision about applying
them into stable, rc, next or not at all.

The first one is when you set a device name using another device's name,
like this:

	dev_set_name(&idkp->dev, dev_name(&drive->gendev));

I've never seen a device name with a '%', but there's currently nothing
stopping any driver of doing that. Perhaps, it is a case-by-case thing,
as gendev may never be named like that. But we may as well decide that
no device may be named like that ever and document this properly or put
the code there that will prohibit that. Then, this patch is useless.

The second one is the case when the function is exported and an
out-of-tree driver may use it giving a name that contains a '%'. If we
don't care about out-of-tree drivers, I may even check every in-tree
user and fix the user instead of/besides the callee. If we DO care about
out-of-tree drivers TOO much, this may even be stable material.

Since I am not sure what the position/decision is about each one, I
would like some input while I work into splitting them into subsystems.

Regards,
Cascardo.

After this message, I think linux-input and Kay may be left out of the
loop.

--oplxJGu+Ee5xywIT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknvhsIACgkQyTpryRcqtS1tUACggKmDN8Y5d+GnNkfGIH+IIofE
GSQAn2SLq7399+Ke6kMSHf//MYjyyy53
=rvQi
-----END PGP SIGNATURE-----

--oplxJGu+Ee5xywIT--
