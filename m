From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH 3/3] Input: tsc2007 - add a property "ti,report-resistance" to restore the old pressure reporting state if needed.
Date: Tue, 21 Feb 2017 12:43:28 +0100
Message-ID: <FE6FEEC7-65B8-4C20-9C15-C641A8A8E4CA@goldelico.com>
References: <cover.1487609795.git.hns@goldelico.com> <991a09fb874c07b03c21a5b38ebade187134539d.1487609795.git.hns@goldelico.com> <20170221110708.GA5021@amd>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_A31398BE-69F6-41BA-8E85-2280B2B21214"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170221110708.GA5021@amd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org
List-Id: linux-input@vger.kernel.org


--Apple-Mail=_A31398BE-69F6-41BA-8E85-2280B2B21214
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

Hi Pavel,

> Am 21.02.2017 um 12:07 schrieb Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>:
> 
> On Mon 2017-02-20 17:56:36, H. Nikolaus Schaller wrote:
>> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> 
> No. device tree is for hardware description, not kernel configuration.

Yes, I agree. A new Kernel CONFIG would be better in this case.
I just did copy&paste from the old patch set without thinking that far.

Would

CONFIG_TSC2007_REPORT_RAW_RESISTANCE_AS_PRESSURE

be ok?

BR and thanks,
Nikolaus


--Apple-Mail=_A31398BE-69F6-41BA-8E85-2280B2B21214
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYrCfgAAoJEIl79TGLgAm6kSAP/1g0xgNyujvK3Bp/32lAkkVX
wU4w2siekWrIB3rOGAM1bimsvbd7MxfkXQD7uHrJdREsquX5mEkTXuP+W22mRuPe
C7v/Ina1RtAApQ5fgwPWYGDLiSLatPX9ODuTSStfswNLsKdAoNX86mIUVYTVR6mO
sqYVC4zVC2j5uwqSSqB1ZzPi2zCXtyOlFELHXiF7vlp2JrJ6TCh6lyygeJHKD1uU
pwQOSWfI8T7HJ4EhvTcYFaYKZK9imzB/IUWSprKKOGSxem07OL5uNEC1Ifsky//P
o5+TKH7d1j9muhH+70QnlAh3myEqFYvvEJ/Wi9QYYyM/v4/wuY2+pZElk2BfVoaw
1DTGH1k6PrxS4We3U5+TUacexzIJhiemfeDVt/2rLFIuVOOgtZRuPyZc5ABxY7Vy
mNBNGLL5LPMzqulwFSRACSVRGQfxNZ7ErCyA+tSo5xpdxKNXx7V2jDdcb0PvR/q7
wj3FUE5h28oRkakAoRk8qa4+SeqhkXX0JLswY7iGig3mQUH+mHx3YoUYifx+zkpP
huROgo+DsTJRWb1oi+PgFuHCsTJsec2o/qkW+CyI+i/z0lny6i6N4yrXD9cTZkgY
xaawHFqcL0+DgSgVTvfW7ozAUE+nQUYyQHZSMUyf609w+NqQhI/kbopH8gIjcDpK
WZSav1gnaAuWzzAVZamq
=MkPM
-----END PGP SIGNATURE-----

--Apple-Mail=_A31398BE-69F6-41BA-8E85-2280B2B21214--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
