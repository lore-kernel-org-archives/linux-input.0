Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48608349CE4
	for <linux-input@vger.kernel.org>; Sat, 18 Jul 2026 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784401937; cv=none; b=PkMaOk8FP/ZewmU5+/SDxSzm+xC8CbYp4YrGta/d0td2hZzaQMjWWj2W98MVP0Qv7365WgfLcdKLLM4r/pbK755WlEtIwALG5pTQMCM5il6nutk1j9QMAYLH2Nn9osWQq2+UNrG0j1SbPJ74SnBEcxTdPa5MuMQUGljDriRbKVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784401937; c=relaxed/simple;
	bh=JhD2EN76mDbr2Bz2IuD0WufMXViEVFDw/wv9epCeQi0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J18FNfvnl9DVxh9IPgFUC9P7/6I8PSTXhWDDeMGQEd6BVrl3d3ubOrOsSdMJONZiJ4sOQZYrT/VadFB/1HokjW/X7KL3mE9gEtbvUmMqNjjBJShgiP9DQs12ZZw+fSvGP6WmWYDQJT4+cUv83fjFEeiqU/+mUKTBFRlWZaJgDFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAXSGBhA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAXSGBhA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6131F00A3A;
	Sat, 18 Jul 2026 19:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784401934;
	bh=neMkaFFWi2bCv2/yMcer79EwNcarAEBMfDdB9zKmxcU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XAXSGBhA2I9frEGN8w642cOVPj6pPuCs0PPlcaXXbd7GYfLXhf7/c65jr3/ijgMbs
	 niAW6/mY1CAFw635/38VIT0D876SU5HE+5+2Eaism0AvfK0A+O9CMt68U6+5wmX1jP
	 zeVYu3Z1jk4C9x6U96gmbGazdr2KjTn8lJnREicAxrHok6GsC9yfB8I6mnGpm9WCvA
	 fQZk0f3NqkVbwrdM3mPPmOhPf5fOGoQkx1FKQByVRH+25HbA+KhPPtcY/Ks14tIfm8
	 AH/8FaJGX9BNadOPppA05oFiK/+Hm8LQsZTy30Dy9j6UaN9ocbK1las11pIIwZ7vT/
	 4BZw1aDTCMKlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: gunze: replace deprecated APIs and fix warning
 style
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bivash Kumar Singh" <bivashraj750@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260718190040.10613-1-bivashraj750@gmail.com>
References: <20260718190040.10613-1-bivashraj750@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 19:12:13 +0000
Message-Id: <20260718191213.ED6131F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Replacing simple_strtoul() with kstrtoul() breaks packet parsing b=
y unconditionally returning an error, dropping all touch events.
--

--- Patch [1]: [PATCH] Input: gunze: replace deprecated APIs and fix warnin=
g style ---
commit c6cb2e487b7cdb132629587d8da300e20e580c31
Author: Bivash Kumar Singh <bivashraj750@gmail.com>

Input: gunze: replace deprecated APIs and fix warning style

This commit replaces deprecated simple_strtoul() calls with kstrtoul() and
adds an early return on parsing failures. It also updates the printk warning
to use dev_warn() with the serio device.

> diff --git a/drivers/input/touchscreen/gunze.c b/drivers/input/touchscree=
n/gunze.c
> index 2baeb4f3b941c..38450cabdd113 100644
> --- a/drivers/input/touchscreen/gunze.c
> +++ b/drivers/input/touchscreen/gunze.c
> @@ -41,15 +41,19 @@ struct gunze {
>  static void gunze_process_packet(struct gunze *gunze)
>  {
[ ... ]
> -	input_report_abs(dev, ABS_X, simple_strtoul(gunze->data + 1, NULL, 10));
> -	input_report_abs(dev, ABS_Y, 1024 - simple_strtoul(gunze->data + 6, NUL=
L, 10));
> +	if (kstrtoul(gunze->data + 1, 10, &x) || kstrtoul(gunze->data + 6, 10, =
&y))
> +		return;

[Severity: High]
Does this replacement break packet parsing by unconditionally returning an
error?

The kstrtoul() API strictly requires the parsed string to be NUL-terminated
and contain no trailing non-digit characters other than an optional newline.

Because the input data is a comma-separated string like "T1234,5678" and the
buffer is not NUL-terminated, kstrtoul() will encounter the comma when pars=
ing
the X coordinate and return -EINVAL. It will also fail when parsing the Y
coordinate due to the missing NUL terminator.

This early return will unconditionally trigger on every valid touch event,
causing all packets to be dropped and rendering the touchscreen unusable.

> +
> +	input_report_abs(dev, ABS_X, x);
> +	input_report_abs(dev, ABS_Y, 1024 - y);
>  	input_report_key(dev, BTN_TOUCH, gunze->data[0] =3D=3D 'T');
>  	input_sync(dev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718190040.1061=
3-1-bivashraj750@gmail.com?part=3D1
