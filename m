Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF3518AFE
	for <linux-input@vger.kernel.org>; Tue, 14 Apr 2026 21:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776203478; cv=none; b=oS29vCgDP4llPjKORlgEXLXTJNIRfI/P7l/KA93i7HtwI3F2oeJ0qWOWJOYQFKGV2IMOaW/TU5LbRHvzNEHJXWet7acpI5paaaj2QW0rovsvl9SboDNgv+wF8RGYd7gP3K7a5xg+eD+98TbzWrYpHZoB0HdQQOWtRlEXM41hWSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776203478; c=relaxed/simple;
	bh=hsAiR0p5Gc0eugbDgz3d2NtyvAxwO6pmhRSUjklaXAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LkJ31o6WI32tMiu6PKNGzzF1jU+macHRiDOdMqaV6Ptp2GyOYCOA4vg4bekEeOEbhI3Z7ywzjR1VhrFyEyRDsxz/q03r7fPXXGQK4RreYM5DvPDQrGDvKDvRnM4W5n6mYE3X4386hTVh+vgpeC8uT+9CQBExhRydtI0fwlqEw4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=nihHYP7K; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="nihHYP7K"
Received: from spock.localnet (unknown [212.20.115.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id E0523635B040;
	Tue, 14 Apr 2026 23:51:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1776203473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ke0ZO9uXHi3guNI8rFvB5NwivqVhkHxCnkYx7vlh97Q=;
	b=nihHYP7Kdl7hieHyl9U0RDSwjdPbgr7U9DzToGsoVtOia6ZAbWAeSVy6wsaAellnhgs9/F
	IA+1CLu7pf7/O3IGT4Rr/3nSTRPavVZtE9GFjfUZJmSsP6qB5Hjw9K3mrrlo6h+oqpZ0dI
	VsjKgKeFRbufo+sgG9czdK4JjBjqU5E=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-input@vger.kernel.org, Anj Duvnjak <avian@extremenerds.net>
Cc: benjamin.tissoires@redhat.com, lee@kernel.org, jikos@kernel.org
Subject: Re: [PATCH] HID: core: downgrade short report warning to debug level
Date: Tue, 14 Apr 2026 23:50:56 +0200
Message-ID: <5062517.GXAFRqVoOG@natalenko.name>
In-Reply-To: <20260414214143.23796-1-avian@extremenerds.net>
References: <20260414214143.23796-1-avian@extremenerds.net>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1951838.tdWV9SEqCh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
x-ms-reactions: disallow

--nextPart1951838.tdWV9SEqCh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-input@vger.kernel.org, Anj Duvnjak <avian@extremenerds.net>
Cc: benjamin.tissoires@redhat.com, lee@kernel.org, jikos@kernel.org
Date: Tue, 14 Apr 2026 23:50:56 +0200
Message-ID: <5062517.GXAFRqVoOG@natalenko.name>
In-Reply-To: <20260414214143.23796-1-avian@extremenerds.net>
References: <20260414214143.23796-1-avian@extremenerds.net>
MIME-Version: 1.0

Hello.

Thank you for the submission. Please see comments inline.

On =C3=BAter=C3=BD 14. dubna 2026 23:41:43, st=C5=99edoevropsk=C3=BD letn=
=C3=AD =C4=8Das Anj Duvnjak wrote:
> Commit 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus
> memset()") replaced the silent memset() with hid_warn_ratelimited(), which
> causes dmesg flooding on devices that legitimately send short reports,
> such as the APC UPS (051D:0002).
>=20
> Downgrade to dbg_hid() to restore the previous behaviour of only
> reporting under HID_DEBUG, while preserving the security fix of
> removing the bogus memset().
>=20
> Reported-by: Anj Duvnjak <avian@extremenerds.net>
> Closes: https://lore.kernel.org/linux-input/MW5PR84MB135613E7947113897DD9=
=46DA4C7272@MW5PR84MB1356.NAMPRD84.PROD.OUTLOOK.COM/
> Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Closes: https://lore.kernel.org/linux-input/6256259.lOV4Wx5bFT@natalenko.=
name/

I think these Closes: should be Link: instead. And probably Fixes: should b=
e added as follows:

=46ixes: 0a3fe972a7cb14 ("HID: core: Mitigate potential OOB by removing bog=
us memset()")

> Signed-off-by: Anj Duvnjak <avian@extremenerds.net>
> ---
>  drivers/hid/hid-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 833df14ef68f..de8a179347ec 100644
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
> +		dbg_hid("Event data for report %d was too short (%d vs %d)\n",
> +			report->id, rsize, csize);

Ratelimiting is good to keep, IMO. There's a separate macro for that, hid_d=
bg_ratelimited(), which is surprisingly not used anywhere at the moment as =
far as I can grep, but it should do the job.

>  		ret =3D -EINVAL;
>  		goto out;
>  	}
>=20


=2D-=20
Oleksandr Natalenko, MSE
--nextPart1951838.tdWV9SEqCh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmnetsAACgkQil/iNcg8
M0sduBAA21lhMktnzAYk+VfeKdxPN6hIFa2dd7JyHXjnnjmNenZ7D9fYvULgEGAT
vAlT5+RV48vCeHSsn6hAVzyBaewbNUxNTmIBi7a5ZGtbTHyEKGW0+ucD2RKOC3bW
08CcRc3Ob59yCtpkulJwv/f8hfzNgPrzs16H1OHAyFp7rv+3R7i0E8j/YU2DoJvv
nTGeiZmrMpBzoHxkCLDUIUS+GUamo7sgOZADPaTqTAdVQNI/nnLUSLpHBJuT3Obi
ps3+dGUSPP+z6aRZA2wPsFjVZ7spnWloQN3otvPZJaLmnfx2Wnbq2FTJ8zA62eOX
ksTlSs7WrQKqf/jCtYMHeMW1BmmRHEadQWTN2nwpEuinLveawwNtLUxP46/fEWqk
KilDvmFAz0TjU3IHbNx/Wczy7tut/DLalNopeYv7w2bUWbCkbRF7dluY7ChnylJY
o5M/zGXF9K+F0ylI0c0hB7W7gzOaK8DcAlkKrqbuf7EZ/Wr5VQJnE3rHolTQyWpY
mpkcDl9gAQzLbnjDT7OGDZ666sPp9QUoLKj8Ma7DLta5sBAbjv1ApLBq6iQ1pJ+M
VSUjUQMBo0aa8FpFMYf6QPPKXcTbg1UtS5rr9OvFbl71+pObdE5RKG6BOVhjowam
pUYUhMHKtOSD17uxe13ZcVKqO13lESdNG0XyLZ4c7HYckb5oKow=
=jiZ5
-----END PGP SIGNATURE-----

--nextPart1951838.tdWV9SEqCh--



