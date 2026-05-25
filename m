Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD07126C02
	for <linux-input@vger.kernel.org>; Mon, 25 May 2026 04:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779682660; cv=none; b=mXlecm+SXjWZ0G9tknTBemVJj+0Wp3t4KedATYTci9XqHXH4QEzHBLp7JBIhrBfUe9TUbTtQRuhg9UyOsjyYWjXKwEBSYFtwNhyhVJExh1eua5LVfUsDMSTi2FOXz5AXu3OqgpVWXLv9aUWrSHKxN4Y4nIDIaPPvgVbgyGD/+BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779682660; c=relaxed/simple;
	bh=lIrbCrSHDXBKJPnsGy0cUfyQNvXffUGPVQl5OwVHgfs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NNGpQJAxHrIAyZphQWh2B3VINomqxfOgvD7+pzja2BYflxnEl/ZTEWtO7hT23WAj+CsW7LLdNm18QNRGW4L3FSvZPqZjuXON5U/JXb++PtRuwbYCNHbjHsVSjabD6Bc4r8qfMsXo1bbad3w5ezY6GnGPc68NYKHJDOQFmFXJDRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdfzjBlw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdfzjBlw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EC21F000E9;
	Mon, 25 May 2026 04:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779682658;
	bh=vCsywREkGzPWM7Fw11jMO56tnhLL7xdp4MlmyR3WIho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jdfzjBlwPmpACl54gGlEB1nyfpGGgUx3sQZuusaouz4AKtD8OVtxnDq0opiZjctMd
	 m+vIWa+VE5OR9shhoX955h4Kjrk8GWcjLJ0KFIvq6odPBDdOs3PAKkaJg57EbNh5Zx
	 1iliSIlAuTHdzDLv1IPlxQDdZG5PA61jBp06v30PJkCLns1IPOciue0/4WGOBHLYDg
	 IAwaZ2YQwZsSuh0qTfhez4X2VaCX27+kc2Yj6a7OS1UsJ32s72nftCo8Mk2DMX9DQk
	 iQaYdp5LhOvkKRuacgdeJFSaN6OkFhMYSWNvacfYEicCHXeLnQN1PMR6jZu1nw1MjO
	 XLAsa9EfB6p8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/4] HID: hid-msi: Add Rumble Intensity Attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260525020543.519082-5-derekjohn.clark@gmail.com>
References: <20260525020543.519082-5-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 04:17:38 +0000
Message-Id: <20260525041738.B2EC21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Mixing goto-based error handling with scope-based cleanup (__free/=
guard) in claw_hw_output_report().
--

commit a152767539ab279fa2750588503cc5a77a8522da
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add Rumble Intensity Attributes

Adds intensity adjustment for the left and right rumble motors. It introduc=
es
new sysfs attributes for reading and writing rumble intensity.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index 96710d80543d4..f5c54cd62f3bb 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c
[ ... ]
> @@ -930,6 +962,162 @@ static ssize_t button_mapping_options_show(struct d=
evice *dev,
[ ... ]
> +static ssize_t rumble_intensity_left_store(struct device *dev,
> +					   struct device_attribute *attr,
> +					   const char *buf, size_t count)
> +{
[ ... ]
> +	guard(mutex)(&drvdata->rom_mutex);
> +	ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_WRITE_PROFILE_DAT=
A,
> +				    (u8 *)&report, sizeof(report), 25);

[Severity: High]
This is a pre-existing issue, but does claw_hw_output_report() mix goto-bas=
ed
error handling with scope-based cleanup?

Looking at claw_hw_output_report(), it defines dmabuf with __free(kfree)
and uses guard(mutex), but also relies on explicit goto err_clear_state
jumps for error handling:

    unsigned char *dmabuf __free(kfree) =3D NULL;
    ...
    if (ret < 0)
        goto err_clear_state;
    ...
    err_clear_state:

According to the cleanup guidelines, functions should either convert all
resources to scope-based cleanup, or convert none of them to avoid confusing
ownership semantics. Could this function be updated to strictly use one
approach?

> +	if (ret)
> +		return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525020543.5190=
82-1-derekjohn.clark@gmail.com?part=3D4
