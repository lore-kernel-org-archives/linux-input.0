Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9224625487C
	for <linux-input@vger.kernel.org>; Wed, 15 Apr 2026 07:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776238963; cv=none; b=r06/6C8N+0zca/vduXZ/TSb/j3QnsnHf9B54EZxgwfudStd3aRDHuSSes4Eu9vTV3TKzvynMnq4tu7csnACsFb7dnN858YYbIapdZMRaE7Qb17KF3BoZ7UcGX8YZIzlvP16NR5zCkRtPUbvN2R9ixv5K81YmB3GYJgiUpRRJaWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776238963; c=relaxed/simple;
	bh=6YS1zOuLJp9YJmDsnGpFBR4gtIfLOIWTn1vc5TiS+Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NYzpZ1+cYdouwae3bhKLRkVIiQTUUaZQOcEmuyin0BwYn5se/8DUFW7B3w0C1bLQUHGFTk+Q+RcRFOTlOysQ6FYjjA2eGlInHGux0bDYYxsBlS4SAZ2UqdFpLqGb50kRcSu2eIGfGAgdpW+IxR1B1pf9dYwySLPe7GIhkqGwipM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=JVtIL7zk; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="JVtIL7zk"
Received: from spock.localnet (unknown [212.20.115.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 79ACE635B040;
	Wed, 15 Apr 2026 09:42:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1776238956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B9AbCCZShPItwNWXiwSfzO10vz0+ozrktoDIaSPpnss=;
	b=JVtIL7zkxEGxjZyeZiAbwY/EXoHpjiiT9voHMEut6CKwiqeBTMPkk58l0u99YeUeRpS2Li
	KzsPKJSbJXJjZB/7rUbTIytWj4Nmozpwec2NO/4QlWCnh3Bc/sT8KHtm833sbA4eSmt0L0
	nbLOuxvW0s/UfzdubVEVHlNO9A3ECL0=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-input@vger.kernel.org, benjamin.tissoires@redhat.com
Cc: lee@kernel.org, jikos@kernel.org, Anj Duvnjak <avian@extremenerds.net>
Subject:
 Re: [PATCH v2] HID: core: downgrade short report warning to debug level
Date: Wed, 15 Apr 2026 09:42:22 +0200
Message-ID: <13988242.uLZWGnKmhe@natalenko.name>
In-Reply-To: <20260414230017.30217-1-avian@extremenerds.net>
References: <20260414230017.30217-1-avian@extremenerds.net>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3038414.e9J7NaK4W3";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
x-ms-reactions: disallow

--nextPart3038414.e9J7NaK4W3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-input@vger.kernel.org, benjamin.tissoires@redhat.com
Date: Wed, 15 Apr 2026 09:42:22 +0200
Message-ID: <13988242.uLZWGnKmhe@natalenko.name>
In-Reply-To: <20260414230017.30217-1-avian@extremenerds.net>
References: <20260414230017.30217-1-avian@extremenerds.net>
MIME-Version: 1.0

On st=C5=99eda 15. dubna 2026 1:00:17, st=C5=99edoevropsk=C3=BD letn=C3=AD =
=C4=8Das Anj Duvnjak wrote:
> Commit 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus
> memset()") replaced the silent memset() with hid_warn_ratelimited(), which
> causes dmesg flooding on devices that legitimately send short reports,
> such as the APC UPS (051D:0002).
>=20
> Downgrade to hid_dbg_ratelimited() to restore the previous behaviour of
> only reporting under HID_DEBUG, while preserving the security fix of
> removing the bogus memset() and keeping rate limiting in place.
>=20
> Fixes: 0a3fe972a7cb14 ("HID: core: Mitigate potential OOB by removing bog=
us memset()")
> Reported-by: Anj Duvnjak <avian@extremenerds.net>
> Link: https://lore.kernel.org/linux-input/MW5PR84MB135613E7947113897DD9FD=
A4C7272@MW5PR84MB1356.NAMPRD84.PROD.OUTLOOK.COM/
> Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Link: https://lore.kernel.org/linux-input/6256259.lOV4Wx5bFT@natalenko.na=
me/
> Signed-off-by: Anj Duvnjak <avian@extremenerds.net>
> ---
>  drivers/hid/hid-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 833df14ef68f..f30091509517 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2057,8 +2057,8 @@ int hid_report_raw_event(struct hid_device *hid, en=
um hid_report_type type, u8 *
>  		rsize =3D max_buffer_size;
> =20
>  	if (csize < rsize) {
> -		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d =
vs %d)\n",
> -				     report->id, rsize, csize);
> +		hid_dbg_ratelimited(hid, "Event data for report %d was too short (%d v=
s %d)\n",
> +				    report->id, rsize, csize);
>  		ret =3D -EINVAL;
>  		goto out;
>  	}
>=20

LGTM, although I'm not sure what plans do maintainers have on this. Replaci=
ng hid_warn_ratelimited() with hid_dbg_ratelimited() works for me personall=
y, so given that,

Reviewed-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Thank you.

=2D-=20
Oleksandr Natalenko, MSE
--nextPart3038414.e9J7NaK4W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmnfQV4ACgkQil/iNcg8
M0shOA//YW46OH4+zqI3GBjwArXzQQg/XPQCpka94X76PgaZOaK5Oi4Vi1oA6bRT
4DsriIjaZkmlUGtk35aPmhKv2R1A3Gn5UjOX5fItsseDDsxLn674eBuDrP4Tslpq
VA6VhrpGUsmYNko3m7jFjx4KnE7pVJPL6U/mGVL/mcYKhwhwrhHKmdonxCcIQDUz
LRLFo7ROp4Wmljy9ZnwpOBjusY+PeGZrClkTwKGNadxAmcDQ/25dVSsfaynR4+RL
AMiGUW+48FTrgvAIE5ARJIo3cML+AU4oFFZRGLr0dsT73ZqxfcjK12CIZmqOQTkc
bBE/2D6xkHPlNaLtdDQXCaJPX2ShrfSd93r31e9dS4lxfZYd13AtYEaLi/08B8qo
U7NZsotUAvluAxmMim8eRSx6taXBmEdxxQWSAsxwy0TaTHKlhKmbtmZyEj7KzH6z
ngPuNI3TyjPNU6mMu31FnvcxxyeangZtv5qyXafzibtzaGdeiwWk2jl5I8s3i3QD
w4lqtB4MALoqHg58ss7fLncF2spFNru7vf5Kusr6MaAvUyYGbYPVJrWPl0pXXtfB
fBJB9i9KyLygCFDKNmOWduxBpwtrL2PFdwppxy1x0/tCbZttkm6ZVrAAz15D4QHz
QpydSU5+aBDJZdr3lbAEYdqL5nlp5y6TyIG24NSsD6WXOcHWQXg=
=4T02
-----END PGP SIGNATURE-----

--nextPart3038414.e9J7NaK4W3--



