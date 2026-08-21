Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B649A3AFD0E;
	Fri, 21 Aug 2026 21:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787348274; cv=none; b=JJxsY9Db4rEhAUUxYMHRFl6m3SXP8n+ealR1II4JK4bbvfo/cZJG3jC6yNLFgpNLNVrq6YcftwSYBCGPqZUs5kRRO3NUpj7h8L2qxFOPXocJhaEwy+Zz72La/tz4Z0vWla8GDm7izMgx0eZnjUB56XE2pyDNSIs40a4ir9ZZqI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787348274; c=relaxed/simple;
	bh=41fTmYoO7DMP8ZEr6XW/iktUqnMBFUYjXK8NsUigP08=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZxVVnNEDYr2JEmn37+rI23EVpxcfhL2fdLBnbZj/r/hjmgLW+zXfg4TVIhDg7U0DUU3raIPSzcVKOBLriwvNAeaZmikKw/He1sdimeGGSR+aOJ1HUDgwfSj6y7q7IEqVCsXpgwJoaHvlxCOK5iQHHEP9G4FpY6PR/axOiRNuSQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QY9rZNqU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QY9rZNqU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB641F000E9;
	Fri, 21 Aug 2026 21:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787348271;
	bh=exZPqroxlWCkpZA/pY3DmtZLYkbJd0nIF4NfUd6wHKo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QY9rZNqUecF6OZ1STR0hgvztaeYDtUE4vDU0PO4VdlwGoCKIRLd3u7nE20IxsYgaB
	 +4ggMjURxevFjoNmGSMMwnYZMvOXOzS/6XxL0Y8oyHjfXcppVXbC9o6XwsXGABNqzF
	 2h5Bu4dPoTeMoSl6/v7d/ITg3y9qnHtgSq21t7P6+xRfE5Zxe+upAOl4cbFRBTV8LF
	 g3IgsQpNYb/vntVwtEdZuyiXEXpMrwMJW3qA8YZCZhK/5DzqcQY8SgsbAZrex5RYZ1
	 YUB0Dx3ZtfKT1oXyGeWs8nQUPCoD1jmDHJwu87cw9eOGJ7Wwuen3HOGtzsZomBOSrc
	 5wqmmAzC3hl+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] Input: imagis - replace the protocol_b flag with a
 protocol enum
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markuss Broks" <markuss.broks@gmail.com>
Cc: linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260822-imagis-40xx-v1-3-73e6d6cdf110@gmail.com>
References: <20260822-imagis-40xx-v1-0-73e6d6cdf110@gmail.com>
 <20260822-imagis-40xx-v1-3-73e6d6cdf110@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 21:37:50 +0000
Message-Id: <20260821213750.EAB641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing i2c_set_clientdata() in probe leads to a NULL pointer dere=
ference during system suspend and resume.
--

--- Patch [3]: [PATCH 3/5] Input: imagis - replace the protocol_b flag with=
 a protocol enum ---
commit 83084be7bf2e640e645cd6ac0416107ab34ef58c
Author: Markuss Broks <markuss.broks@gmail.com>
Subject: Input: imagis - replace the protocol_b flag with a protocol enum

This commit replaces the protocol_b flag in the imagis driver with a protoc=
ol
enum to describe each reporting format. The change clarifies the naming
convention and prevents a confusing collection of booleans as new chip form=
ats
are added. No functional changes are intended.

> diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscre=
en/imagis.c
> index 7cc91f97c06e0..6552d97efe32e 100644
> --- a/drivers/input/touchscreen/imagis.c
> +++ b/drivers/input/touchscreen/imagis.c
[ ... ]
> @@ -442,6 +451,7 @@ static const struct imagis_properties imagis_3038h_da=
ta =3D {
>  	.touch_coord_cmd =3D IST3038C_REG_TOUCH_COORD,
>  	.whoami_cmd =3D IST3038C_REG_CHIPID,
>  	.whoami_val =3D IST3038H_WHOAMI,
> +	.protocol =3D IMAGIS_PROTOCOL_SHARED_REGISTER,
>  };
> =20
>  static const struct of_device_id imagis_of_match[] =3D {

[Severity: High]
This isn't a bug introduced by this patch, but could a missing
i2c_set_clientdata() in probe lead to a NULL pointer dereference during sys=
tem
suspend and resume?

The imagis_probe() function dynamically allocates the imagis_ts structure b=
ut
never stores it in the device's driver data via i2c_set_clientdata().

When the system later suspends or resumes, imagis_suspend() and imagis_resu=
me()
retrieve the client data using i2c_get_clientdata(), which would return NUL=
L.
The code then immediately dereferences this NULL pointer:

drivers/input/touchscreen/imagis.c:imagis_suspend() {
	struct i2c_client *client =3D to_i2c_client(dev);
	struct imagis_ts *ts =3D i2c_get_clientdata(client);
	int error;

	guard(mutex)(&ts->input_dev->mutex);
...

Will this cause a kernel panic during suspend and resume cycles?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822-imagis-40x=
x-v1-0-73e6d6cdf110@gmail.com?part=3D3
