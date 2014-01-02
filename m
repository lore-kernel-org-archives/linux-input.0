From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/7] Input: pmic8xxx-pwrkey - Migrate to regmap APIs
Date: Thu, 2 Jan 2014 18:49:59 +0000
Message-ID: <20140102184959.GI31886@sirena.org.uk>
References: <1386718996-3733-1-git-send-email-sboyd@codeaurora.org>
 <1386718996-3733-3-git-send-email-sboyd@codeaurora.org>
 <20131215113337.GB14818@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/dHhfKPS6kpMPPhT"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131215113337.GB14818@core.coreip.homeip.net>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--/dHhfKPS6kpMPPhT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 15, 2013 at 03:33:37AM -0800, Dmitry Torokhov wrote:
> On Tue, Dec 10, 2013 at 03:43:11PM -0800, Stephen Boyd wrote:

> > +	regmap = dev_get_regmap(pdev->dev.parent, NULL);
> > +	if (!regmap)
> > +		return -ENODEV;

> And you are leaking memory here...

He's not, dev_get_regmap() just gets a pointer to an existing regmap -
no reference is taken and nothing is allocated.  It's a helper that's
mainly there so that generic code can be written without needing the
regmap to be passed around.  The caller is responsible for ensuring that
it will stick around for as long as it's used (generally by having it
lifetime managed with the device).

--/dHhfKPS6kpMPPhT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSxbTUAAoJELSic+t+oim9o4oP/RIh2uLG4+BXSthcSYsyI+Id
YQTx3WPGsD5E+8fKeBzN2u3nelU1uFmC21merUz2oQCNewz++CZ7F4r/4zDa6OJE
ozbtLcLTL9K2kU7GoQiEe3dQ45C0izP9cwztsv2FL8vQvi/RrlzQnzs9GUhK6cF6
SjN3OQIHuNOwiGICStETkOOplp1TyFyVq5ATGU47Wv8/kK+7cpApBipZddHIePzf
wjV7yY4AIk0PcZGgEw8yMbS3V9g0RM11VzezMwtx5VXzuchHW44LzcfnQC/nQnkH
pKN/7o9kA8sEbR5y8rrjBKLX3ZhTnGvzGU62+psYhVwqb60fQjsJNWMTmTtSkrbW
JlzDrlwGHb0UMcJjPGMDXeWOmbhtvEWai4Nlv9K/XBT15gaHMvmCj6+TVVWK1rEZ
NTOZObsrEnx8OwmU+6c4Zf3CQucU21nijLk2aGapIkOJ53UMYkCqqlDTi/m3K8pw
1f/JbOthIc09w+ekulm9RNzVJuUBaSk493C3KXdmYvemygDVkx7EyMOwp073ZkR5
oec01e0rmpCVvR5UBKEcZw1I7JuQOKWWkdX028/leZpFB4UZn9l1oRaa3Tsjg+JN
qYwh79iBcpb4sxQueaB8FFtgsbuF/4RTEetmzp2ouVBII1WM4l4KItfqOHfIMbCR
CeGOpr/i3Y7/IUXvF26f
=eCpS
-----END PGP SIGNATURE-----

--/dHhfKPS6kpMPPhT--
