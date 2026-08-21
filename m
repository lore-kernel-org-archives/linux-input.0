Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAA1312825
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 02:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787280916; cv=none; b=WAgGdT+FWYkC7TEIqNys6LxsX/p5vFN6jutMSyvimGGI8inMFdwtA5M0tLTq032FSLOYow7Vgsw3EVlAegGeu2NVum3zxhewC0xaTEYEMeVdU8WWv/ilhydNw9lOcAaxzbnt4qqZe1VWntSk4pK8sfvjA4PLF6bjvEBjrmHb4vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787280916; c=relaxed/simple;
	bh=9eYbt39UAthU+qoqrblQ8jvBT0ZsOPmxI0cgXg3eEXE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y3Kil1WOzdoKwAwh3dVy8Ma2+1lv07LCQL3LvFLwqMU1PwRMPcJvY+A01Xoeop+9Yjcz57HtOKq+quof/VzE48yoXqFF0TX+Vz6gSeDerJ8eSzBYopwi8hbTMGaSKWh2ilJ1jdr594oRKYuoz2I3rTkCt7132b0hcZzf39WRQZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=en4xSm1J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="en4xSm1J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AE01F000E9;
	Fri, 21 Aug 2026 02:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787280914;
	bh=AEl57kzut5ECisiRAO0u3aS3bq3959gBiaES3PrwthY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=en4xSm1JDW8jBfS5cNhmWLdqeK1sj1qaWYi0H/R7/05mLoThwNzu9qAAtULlSBCfB
	 Wxyd+iEhXD4P2wNY6E7YQI/Ys2Pp36yWVIJnPKsY28qRmutuj9P+HsLsxcN6bvdX/3
	 NuZ5QAsD2RW1Wpe/Oc95sfSSAMkaOvO9/M7z+wCNoTFWzcyz3lN6UP3BQ915kLq7wN
	 uiA07O8E1jXHRisHdb23MbOCjSc7sQ8S9OVDLCe72SDiY9fbvyYQhWd+b3SKz/0x99
	 hZZlIn34n6HSENgm+z9bULSxgWaDBNXtNkTNGJZRax4WHfW9mwIkYtrtBXIIgm4kVS
	 Y+Qe3+7k7zlFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] input: touchscreen: Convert to
 DEFINE_SIMPLE_DEV_PM_OPS()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Triet Hoang" <triet.hoang.dev@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260821024450.57369-1-triet.hoang.dev@gmail.com>
References: <20260821024450.57369-1-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 02:55:13 +0000
Message-Id: <20260821025514.31AE01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces a strict C compiler redefinition error for `ad=
7879_pm_ops` when `CONFIG_PM_SLEEP` is enabled.
--

--- Patch [1]: [PATCH] input: touchscreen: Convert to DEFINE_SIMPLE_DEV_PM_=
OPS() ---
commit 44d9a5ca9f2aa03594a9658d8105747b57b227ba
Author: Triet Hoang <triet.hoang.dev@gmail.com>

input: touchscreen: Convert to DEFINE_SIMPLE_DEV_PM_OPS()

This commit updates several touchscreen drivers to use the newer
DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr() macros instead of the deprecated
SIMPLE_DEV_PM_OPS. This allows the removal of __maybe_unused annotations on
suspend and resume callbacks.

> diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscre=
en/ad7879.c
> index 31d2a3029d5f6..f686f028d4bc9 100644
> --- a/drivers/input/touchscreen/ad7879.c
> +++ b/drivers/input/touchscreen/ad7879.c
[ ... ]
> @@ -329,8 +329,8 @@ static int __maybe_unused ad7879_resume(struct device=
 *dev)
>  	return 0;
>  }
> =20
> -SIMPLE_DEV_PM_OPS(ad7879_pm_ops, ad7879_suspend, ad7879_resume);
> -EXPORT_SYMBOL(ad7879_pm_ops);
> +DEFINE_SIMPLE_DEV_PM_OPS(ad7879_pm_ops, ad7879_suspend, ad7879_resume);
> +EXPORT_SIMPLE_DEV_PM_OPS(ad7879_pm_ops, ad7879_suspend, ad7879_resume);

[Severity: Low]
Does this cause a compilation error when CONFIG_PM_SLEEP is enabled?

Both DEFINE_SIMPLE_DEV_PM_OPS and EXPORT_SIMPLE_DEV_PM_OPS expand to a
complete initialization of the ad7879_pm_ops struct. Using both sequentially
redefines the same global variable, which will result in a build failure.

Should this just be EXPORT_SIMPLE_DEV_PM_OPS by itself?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821024450.5736=
9-1-triet.hoang.dev@gmail.com?part=3D1
