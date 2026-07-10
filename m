Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45468388860
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783679756; cv=none; b=f5pODmMV2t9FeFwIL5HgMNF6BIs8PSlFhWPUEqcWgXzl4+0Qji5pPxm6XMvizjRugtbxnCinmznjwHW/82l5jblYIwJ/m4tS2xql072yKmvVV5lm9jpXJGVKO8ucfaWvNLR3LFJicR1p9GAjWdc1AyTXAXbSFIBBZiuE13oT+S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783679756; c=relaxed/simple;
	bh=FbcKk6E4kQNnzwBfya6xHxFlQhJhNmzqxR/4Wf9mjwA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R+ohlrwBkPfACAkYBRd87mN8op9/+KfvIPD1DU364/oyeHroBy4tItn0oCdXAcWIIePauZJLP89BqdVziOpQBK9TsiBp78bU2gPsB63/Ou3kV8/IOgUcCV+UAUsYa26UXzOdgxHQ0wtpY5CTm3XsMrTMId3onBs/e2UJnqOypgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6lD5VYc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6lD5VYc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C3A1F000E9;
	Fri, 10 Jul 2026 10:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783679754;
	bh=/EpNv3pgqULUW3VJmhCt2ol7L3qhNV4YOBdJ9j4pEMI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O6lD5VYcBy6APqHbFSlFCEArVjalvov81PDwOLAMXMNEULGsNmjnEIMWrvRPWY17J
	 ecL/XC0X4Jy9fGHEEpprAOiH/kzHcOK1kSLKQ4k/CH3XparjbABBVEYgUNRpb7xuf4
	 AEQcey9zvlNcvhbz/wSIIH+DDyCsq9dRhuOuejbfCaeSTuzKT2M8BJ+HYjI0mRhwKJ
	 3xw0IFs6ObT97Ph3rQFmzWAsSFMnQwn2X7BG52xF9ZCzXPpDwIqGELLVGXpSK929vH
	 jg6eTO9xF4lnCTi2Ysr+1smFvrxWFh4+XepBDy9Rv5o6JXMvMHT7DXFLvEsmkPuTWV
	 o2o8B74fK4nkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: tmff: Use 64-bit arithmetic for force feedback
 scaling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linmao Li" <lilinmao@kylinos.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260710102314.190094-1-lilinmao@kylinos.cn>
References: <20260710102314.190094-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 10:35:54 +0000
Message-Id: <20260710103554.A3C3A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Structural race condition leading to NULL pointer dereference in F=
orce Feedback initialization.
--

--- Patch [1]: [PATCH] HID: tmff: Use 64-bit arithmetic for force feedback =
scaling ---
commit b7654294b005de01aa2d8e34c8846bfff883d73f
Author: Linmao Li <lilinmao@kylinos.cn>

    HID: tmff: Use 64-bit arithmetic for force feedback scaling

This commit fixes an integer overflow in force feedback scaling calculations
by using 64-bit intermediate variables. It updates both tmff_scale_u16() and
tmff_scale_s8() helpers to use div_s64() to prevent incorrect values when
processing logical minimum and maximums from HID report descriptors.

> diff --git a/drivers/hid/hid-tmff.c b/drivers/hid/hid-tmff.c
> index 423f395d01ac5..319e7b6703846 100644
> --- a/drivers/hid/hid-tmff.c
> +++ b/drivers/hid/hid-tmff.c
> @@ -17,6 +17,7 @@
> =20
>  #include <linux/hid.h>
>  #include <linux/input.h>
> +#include <linux/math64.h>

[Severity: High]
This isn't a bug introduced by this patch, but does the force feedback
initialization in this driver have a structural race condition?

Looking at tm_probe(), hid_hw_start() fully registers the input device and
exposes the event node to userspace before tmff_init() configures force
feedback:

drivers/hid/hid-tmff.c:tm_probe() {
    ...
	ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_FF);
	if (ret) {
		hid_err(hdev, "hw start failed\n");
		goto err;
	}

	tmff_init(hdev, (void *)id->driver_data);
    ...
}

Inside tmff_init(), capability bits are set and the FF structures are
initialized:

drivers/hid/hid-tmff.c:tmff_init() {
    ...
				for (i =3D 0; ff_bits[i] >=3D 0; i++)
					set_bit(ff_bits[i], input_dev->ffbit);

				break;
    ...
	error =3D input_ff_create_memless(input_dev, tmff, tmff_play);
    ...
}

If a local user monitors for device creation, they might immediately open t=
he
event node and issue an EVIOCSFF ioctl.

This would execute input_ff_upload(), which checks that EV_FF and the effect
bits are set.  Since tmff_init() has already set the capabilities, could th=
is
unconditionally call an uninitialized ff->upload pointer before
input_ff_create_memless() finishes setting it up?

Would it be possible to encounter a NULL pointer dereference here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710102314.1900=
94-1-lilinmao@kylinos.cn?part=3D1
