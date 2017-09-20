From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC PATCH v4 3/6] i2c: add docs to clarify DMA handling
Date: Wed, 20 Sep 2017 20:45:51 +0200
Message-ID: <20170920184551.wtlmlicflek6qz6n@ninjato>
References: <20170817141449.23958-1-wsa+renesas@sang-engineering.com>
 <20170817141449.23958-4-wsa+renesas@sang-engineering.com>
 <20170827083748.248e2430@vento.lan>
 <20170920171840.nrzyiasezxisvg5m@ninjato>
 <20170920152220.74bd43c3@recife.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0681314082=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170920152220.74bd43c3@recife.lan>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--===============0681314082==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qfh5wvgqzbsmj2zd"
Content-Disposition: inline


--qfh5wvgqzbsmj2zd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> In order to avoid that, and to place them into a box using monotonic fonts,
> I usually add "::" at the preceding line, e. g.:

Just in time: I added the '::' and will resubmit the new version in a
minute.

Thanks for the pointers!


--qfh5wvgqzbsmj2zd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnCt1sACgkQFA3kzBSg
KbaMhhAAsRuvzOlErYt8w0T3iytK/Mw8eMUj6X6GeNyy6DVXeiPbTPgt0p2GNMeE
/2VDuvMobxKqd0WapZWtrDct0YEgblGT+abpzVQNsqwoQUYiMR45gi9PPAB/gsOT
rL4Ck3sGa/1/3xgiOJjuIbB83o8k1tbfIe2a1T63P+HjSY9sr+/P6+/+vlgpA93A
l1Dt6NICWPTg5p07bssoK8nhnNQjKAgeh3Lu1K03RW2o3J+TOyobV8piXXMCwt/E
0ecNE3O1KrnB/huGfTZffudl7se/XcMuKZmuk93GKCA8CQX5JbTcAAFMtWEhQUE3
ETH+Sb5qEgUUcLYWD3BDE1nUNEl1kLK0KdA3utzL3ynZpQaqNKgHuZQG+ftcpFxr
n9darzx/kmAMINcr0jgrGlrZNuTPUfWwOzdtBKP1OPmQSgjDqliuYnnYeLN8QOlr
f9duGqYxFlvyDEB5B1ULhzpjYRY9G1rR6ybKzwAvpOZB/pIRK7lIVU0iIYqqjp/y
5RvAw4ZcC3Tugo+itrPqRkCCYukFMr82MP77ORhsd201e5paUSnkJAGr8HDQlNZV
gKtosRpBc+SvaWC0nNg3WnlWfi3jQHUvBSZSNra/lCEFmkZjwdlcUuTC46VYSq0z
fz5EErD5Jbd2l2JsGivmMiaOHESo3JThu3mEXXY3RWDvk6hIGh8=
=/uf5
-----END PGP SIGNATURE-----

--qfh5wvgqzbsmj2zd--

--===============0681314082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0681314082==--
