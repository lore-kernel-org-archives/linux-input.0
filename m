Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A4E22083
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 08:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783759056; cv=none; b=Tr626fxrDFcn2tlg7mJI0KZOEmVMwidvVcxjh2MkugXWyEzv5TNZOHWXw0Wx7w0XdHZX/6No6FYIbY0W0jtUxenRaLy4guT/I2p9CKhZ1Zsw6Lzvnqj53r+ZOLnjdnIPLmRdSCENaGP7woTBnhJvPuKtWL3IsWWIQrIK+t0MDdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783759056; c=relaxed/simple;
	bh=X5GuRAkdaar5Fnkw+X8qybRwMevY7cLCc+RKriuCdlc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WmQnBe6JPsDTIxNg9KPpi+INfZxrcI0j+jUcYkTmccgtzvmh8BwOn5J2qy3Q8laTB0mKmH/a7dOAkxVW8IkHYWsXJqX3Xr1y6rq6M+dPQEEio9hpNE5D4/c+0N2ibQl3aHXPmGcZaQG4okBBkNYWRKjBBx+GheYe8ubqwS4BCx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvNC/uP/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvNC/uP/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EAF1F000E9;
	Sat, 11 Jul 2026 08:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783759055;
	bh=MspSWgBJlQWNUKutZ5QOsYLUqtuav2VjeKL+riZJ+CM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KvNC/uP/SD/1dNdh12lY6ostnHDJxLUqne6JvCSNXLcPNJJQZQrtv4Wbr+/c+Q+n5
	 e6AgXJwpkPn6NhPLRkQ8auFZ7oj6SBKxIhpw/JulBc/XCDSfbbbTe8oDm5XY4axPaY
	 dwvK6Ysk0h4GYE/zi5AP6Qkrc/mfqxhKC+SwK7cCe2vL3ml1ZeJtRuGswkC1705Y2x
	 rnfwbSfht8ciTIVaScRBPm4XVIUyVI/U/83ngkQqiUQ/n0C69OMCHWmsTiNIn+xfbQ
	 Zh5ndCE9KH6Fz84/6qUWEyZqniEuScH/ccbzjAQqoQvDB++6Ast5r4MB03Ath8WvYO
	 TnUKkHaadKMbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: uclogic: fix UAF on inrange_timer at teardown
 and probe error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Doruk Tan Ozturk" <doruk@0sec.ai>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260711080350.81108-1-doruk@0sec.ai>
References: <20260711073003.71012-1-doruk@0sec.ai>
 <20260711080350.81108-1-doruk@0sec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 08:37:34 +0000
Message-Id: <20260711083735.37EAF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing kfree(drvdata->desc_ptr) in the uclogic_probe error path l=
eads to a memory leak of the dynamically allocated replacement report descr=
iptor.
--

--- Patch [1]: [PATCH v2] HID: uclogic: fix UAF on inrange_timer at teardow=
n and probe error ---
commit 765009419dfdd98b6d556b9c30dc95cac5ee9252
Author: Doruk Tan Ozturk <doruk@0sec.ai>

HID: uclogic: fix UAF on inrange_timer at teardown and probe error

This commit replaces timer_delete_sync() with timer_shutdown_sync() to
prevent use-after-free bugs caused by the timer being re-armed during device
teardown. It also ensures the timer is properly shut down in the probe error
path.

> diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-cor=
e.c
> --- a/drivers/hid/hid-uclogic-core.c
> +++ b/drivers/hid/hid-uclogic-core.c
> @@ -267,6 +267,13 @@ static int uclogic_probe(struct hid_device *hdev,
>  	/* Assume "remove" might not be called if "probe" failed */
>  	if (params_initialized)
>  		uclogic_params_cleanup(&drvdata->params);
> +	/*
> +	 * If hid_hw_start() started I/O and then failed, raw_event may have
> +	 * armed the timer; shut it down so it cannot fire on the devm-freed
> +	 * drvdata after probe returns.
> +	 */
> +	if (drvdata)
> +		timer_shutdown_sync(&drvdata->inrange_timer);

[Severity: High]
This isn't a bug introduced by this patch, but does this error path leak
drvdata->desc_ptr?

If uclogic_probe() successfully allocates drvdata->desc_ptr via
uclogic_params_get_desc(), but a subsequent initialization step like
hid_parse() or hid_hw_start() fails, it jumps to the failure label. The
error path cleans up params and shuts down the timer, but it appears to miss
calling kfree(drvdata->desc_ptr) before returning.

>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711080350.8110=
8-1-doruk@0sec.ai?part=3D1
