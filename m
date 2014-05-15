From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 6/9] regulator: AXP20x: Add support for
 regulators subsystem
Date: Thu, 15 May 2014 19:18:42 +0100
Message-ID: <20140515181842.GQ12304@sirena.org.uk>
References: <1397209093-10077-1-git-send-email-carlo@caione.org>
 <1397209093-10077-7-git-send-email-carlo@caione.org>
 <5375015A.10701@free-electrons.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="syxuOCWTdUxzfLBK"
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBI4K2SNQKGQEYPQ45BQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5375015A.10701-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-input@vger.kernel.org


--syxuOCWTdUxzfLBK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 15, 2014 at 08:03:06PM +0200, Boris BREZILLON wrote:

> I know I'm late, and this patch has already been applied, but shouldn't
> we use of_get_child_by_name instead of of_find_node_by_name.
> This might lead to wrong regulators node parsing if other regulators are
> defined in the DT after the axp20x node, because, AFAIK, this function
> searches for DT nodes defined after the specified np node, but not
> necessarely children of the np node.

Yes.

--syxuOCWTdUxzfLBK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTdQT/AAoJELSic+t+oim9JB4P/iXN9Ow23fu7QZKNYInzhrJt
XfMtHJOR6i69S1gWVJ/C+Ni3JmIjpF0RjrRRA+/HKc8D+/nnVzY3ittWaCJGpbPt
pWOoG2uK1BGNTB7FYRn6+tE7+UrcUQ8ih99uVR0S+bBZ0KCFcHwasje+1wkoCgb5
4TFGsX4WN0mz/+SYWgqcDkmbGT9Ivjrk9y17u3Z0DJHvJ5+1nLIg6/58K56/NUM3
YNhZ4BXrvfsaUvokKt4zUHkXNL5mIfTBBL0gkR/LmyZkM6MfpTnFKETkvqU2EfTw
TbJKXIaL8FWRaHooM/RWt8cQ5Vxc7gUBgzprCdgqlzZHbSXMVJNrk47hWBG9lCx0
75p2IlzAmwg4v6THM4NbllCED7RyvTFHVa1G6htjtQlnHHgUoDwMnfOdjSPN9fCi
LkSapnJuWJPFHOCuN5UtqTQyBPfvM/oFm1qDxU1p+pntaBfIQI2jBZUGUrH+3eV2
C2utNgdBcA/qsTvqdkajgmeCe0U8osYfEz9HdZfI2SXuG2MmFrFc380wcoBKsT3V
kvkpjDtAmTx+4vO14j+i4m4b6gNZJulQaidxdLVAJU+Es+AcoXulWx54AcUcnFtR
BcYjqQtTT8n2wxiGjaMpGDyZCOsLnPzAiFG6mWk9Fd9f7sYdIzt1vZVLn4kAumeh
HS/5ugbNJrZJLuuarkio
=WbOd
-----END PGP SIGNATURE-----

--syxuOCWTdUxzfLBK--
