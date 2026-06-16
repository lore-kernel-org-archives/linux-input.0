Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCF43CF05D
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 05:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587208; cv=none; b=gJOAqR8E5UonJpXPyaagRrBvxzCi7QTzw3ZRyTgwcvycgczpiza1muXnGAkzjw0m1fVN1y5yRw+DShLdh1xPp8aWEZ9dXh9BE4ux+FW+W1fnoEsu8wcB7lkfJSJRNQzltjAgxErKth4w3Q7Jvxz/ibeTDu//T/C6dUd/jX+rXlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587208; c=relaxed/simple;
	bh=xuq6hPTKTNKp0mOnDT0aV1Au885/F3rHCk2W9KWr7H8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tGc33JsLzaEfKTzEuE0Ec9JB0U+IX843T1a3nj7do8w2IPGhcir2xTb08CRrr2KHDW1LR0DKqwqs1e5SevnCuF6qoXyG1nyRDyMgs57vJBOzCdmIEkGfM4c7ke5Jjnv5ppTbbN4S3uOyks6dVEKrzf9kkj1ds2DiPuVMvdl54hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4bKn0EM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4bKn0EM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE721F00A3A;
	Tue, 16 Jun 2026 05:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781587207;
	bh=G5RO6rfAOFRoxrtvNhuN9ijwCeVzd/aFG8ItifZiji4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f4bKn0EMmzWyv5Au3ul2F5Ls3A+nGjvS8SiSxYW8XfhA53k3uZtcUQ+ftJNY8x6Kk
	 /K2wRWLbWJzVqUp9+7XCW4lA4EaGIRm1zPcAhT74bOCWdnwI5nfaLzuBVu+mGFexk0
	 C/91+Dtff/VF0VHM8UHnerw6MvrsHhF/tCeaL4/dxCMMfnbhB0yuDnCwQd4DwM+eoU
	 sySuvR3Zv2k0JFy7WcG689GyTqBMcIflzOHiqrzc5w/xsVZ2UMpJmXzZ6nHDiSOzMs
	 vWL9SIFbM8mSh6guGF0KrRHlgTc+58kReD3PkYwU8qZZtpyW81blARlDeg5A+4uuFB
	 KJK1/h1c0Fx6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] Input: mms114 - refactor chip variant handling
 using descriptors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260616050912.1531241-6-dmitry.torokhov@gmail.com>
References: <20260616050912.1531241-6-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 05:20:06 +0000
Message-Id: <20260616052006.CEE721F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The input device name exposed to userspace has changed for the M=
MS134S and MMS345L variants, which risks breaking userspace configurations.
--

commit 6433e094b88447042b6bbde3852dd64f8e938510
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: mms114 - refactor chip variant handling using descriptors

This commit replaces enum-based chip variant checks with a descriptor
structure. It encapsulates variant-specific properties and callbacks into
per-chip descriptors mapped directly via device ID tables.

> diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscre=
en/mms114.c
> index bf01eee0560a1..006dded17eb80 100644
> --- a/drivers/input/touchscreen/mms114.c
> +++ b/drivers/input/touchscreen/mms114.c

[ ... ]

> @@ -579,8 +606,8 @@ static int mms114_probe(struct i2c_client *client)
>  	}
> =20
> -	input_dev->name =3D devm_kasprintf(&client->dev, GFP_KERNEL,
> -					 "MELFAS MMS%d Touchscreen",
> -					 data->type);
> +	input_dev->name =3D devm_kasprintf(&client->dev, GFP_KERNEL,
> +					 "MELFAS %s Touchscreen",
> +					 data->chip->name);

[Severity: Medium]
Could this string format change break userspace configurations that rely on
the exact input device name?

Previously, using the integer type, TYPE_MMS134S (134) resulted in the name
"MELFAS MMS134 Touchscreen", and TYPE_MMS345L (345) resulted in
"MELFAS MMS345 Touchscreen".=20

By switching to the descriptor name string, the names now include the trail=
ing
characters ("MELFAS MMS134S Touchscreen" and "MELFAS MMS345L Touchscreen").

Might this disrupt existing hwdb rules or udev scripts matching on the old
UAPI-visible names?

>  	if (!input_dev->name)
>  		return -ENOMEM;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616050912.1531=
241-1-dmitry.torokhov@gmail.com?part=3D6
