Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E820A18FC97
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 21:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781301526; cv=none; b=qm3x/MoIJxcSiE/5SksPGh18Xm5oRS3rnCvf8EWBSqY3n0Ze9uZ89LplgFxDoPPDH7S7ckvEd4PoTRS5fdahqOJuvsWBnJn2NHFwNjaD5kCcN7T4BVzDZC5EqY0qfLYhHMRnYUBeIkzRK6r+xlY9SxUerMrcTPLGjOu14hWc2uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781301526; c=relaxed/simple;
	bh=xaYhk4Mg0fL3PlfMwEtLeI3lcZjA/h5t+zIsK4NINNk=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KXs0No1KTtFXWEWWuArNL5k63bq3uwjFuAvwcudqGdgXKZJbiSUPusfB100gC4wbW1fRjSrPqcTdDMExw1jEiWml6ZbhhHcn6fVkunhN11wTwAk2QamrEgq1SN1ilZO1qdxe1slyDFJ8XUDBBz8XAWx7an3/AWYnZNNcHzXhpNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D32fH6Gp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D32fH6Gp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD37E1F000E9;
	Fri, 12 Jun 2026 21:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781301525;
	bh=LROeeub/LuFrsHcmCgzDG8h3E+EX8MHr35JDXBd4kJM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=D32fH6GpALvNcgZtn5S/rShAeIVlg+TlKHk7UVxUrUewK/JbWLE4jfRkr3/6JdeAt
	 Lwq2jsii+iIjcYB6GJSSekiAkxF48T/bNinAe/rTpzWZeoELNALNq+UDB6SFyH8Ej+
	 phdA4ls35FZQ34EZfU/6dozwimOXXgBp32V1nd2BlhFLCnSaLw/KVRdqf1QcNwYQyf
	 NGL/9SGXcE4PxHf/5GhNoqexlQHrlQdX04mCeUkd/frCMFH+h5OatrtCLCFXphGsoF
	 xvCgMyK1Voz5JkVHADM1hNdl7chj/Sgdo7hZRjkA4SACyInhwYWPoasQKmdgnR8LjI
	 DP6JRk+dw6p1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: tsc2007 - Read "ti,poll-period" as u32
Reply-To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260612215033.1885245-1-robh@kernel.org>
References: <20260612215033.1885245-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 21:58:44 +0000
Message-Id: <20260612215845.AD37E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] A 'ti,poll-period' value of 0 causes an infinite polling loop in t=
sc2007_soft_irq().
--

commit dfcc8705b785de318165f57112a4d5c957e4ec74
Author: Rob Herring (Arm) <robh@kernel.org>

Input: tsc2007 - Read "ti,poll-period" as u32

The "ti,poll-period" property is documented as a normal uint32 cell.
The driver used a u64 helper, which makes the helper type disagree with
the schema even though the stored value is still small.

Read "ti,poll-period" with the u32 helper matching the documented DT
cell size.

> diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/tou=
chscreen/tsc2007_core.c
> --- a/drivers/input/touchscreen/tsc2007_core.c
> +++ b/drivers/input/touchscreen/tsc2007_core.c

[ ... ]

> @@ -238,8 +237,8 @@ static int tsc2007_probe_properties(struct device *de=
v, struct tsc2007 *ts)
>  	if (!device_property_read_u32(dev, "ti,fuzzz", &val32))
>  		ts->fuzzz =3D val32;
> =20
> -	if (!device_property_read_u64(dev, "ti,poll-period", &val64))
> -		ts->poll_period =3D msecs_to_jiffies(val64);
> +	if (!device_property_read_u32(dev, "ti,poll-period", &val32))
> +		ts->poll_period =3D msecs_to_jiffies(val32);

[Severity: High]
Does this change unintentionally allow ts->poll_period to become 0, leading=
 to
an infinite loop in tsc2007_soft_irq()?

Previously, if a 32-bit zero value was provided in the device tree,
device_property_read_u64() would fail due to a length mismatch, triggering
the fallback to a safe 1 jiffy (ts->poll_period =3D msecs_to_jiffies(1)).

With this fix, a 32-bit zero is successfully parsed, setting
ts->poll_period =3D 0.

If ts->poll_period is 0, wait_event_timeout(ts->wait, ts->stopped,
ts->poll_period) in tsc2007_soft_irq() evaluates the timeout as 0 and retur=
ns
immediately without sleeping. This results in the thread spinning in a tight
loop as long as the touchscreen is pressed.

Should we sanitize a 0 value here so it defaults to 1?

>  	else
>  		ts->poll_period =3D msecs_to_jiffies(1);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612215033.1885=
245-1-robh@kernel.org?part=3D1
