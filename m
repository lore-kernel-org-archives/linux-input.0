Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B480D3DD849
	for <linux-input@vger.kernel.org>; Wed,  9 Sep 2026 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949176; cv=none; b=qBJH14EikzzqlxBtd1XNHPwNwmvfs8sSXtKXyu/UdYAUqD7jDNjKyPM9gyGN8sCfQsxRm6TK22Oe9v8x2rjley2bXU+5DehW115SgTzpqU+bDv9T23XlQab94qqQl/KT0I3KXXs0PJPVpXSUsSF6Bi1QEpqYj4hDErP0J/VQjSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949176; c=relaxed/simple;
	bh=zuCP2xE7LESS8cUy9X3zAc79NiJ1zH0/tpR5llVgrTg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DKCSjxw2I/totQ6oMaDaXpaQygnaIYTZbDs1a/zavrHs8rSgzfiU6VqHlGX0n6NquqemUVpF/rIE/L09w5tAHW+sLflm47GJy7LEXmE48ht+kFH0s+Flp0ZQjM/RiAECxwor1Nq2tEGyEAnNvyj+LDVv+DRXrv8BdCws7xzMmBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFAzHQqK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFAzHQqK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578E31F00A3A;
	Wed,  9 Sep 2026 10:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788949175;
	bh=GTvke0l5FFkmqmbitYtppQGgX28YKLwVvfV64xaFne4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MFAzHQqK5FQBoxSjt7A64enGsn+LhHTVawgua3BvMaiQh0i9vkXSabdDmEI66Tz+F
	 q/2uPbVwTA0DsAuMvUbNPV34CV3Dv8Zq0MUtZpb3scg+rE+uiGxzyrBajHcj3W1/8M
	 8oLcZ8buaSJRjLbYqxd2F3XUfpdpzZXlKKuDQoNTNG+74kvEHTZ3XntJiULkGBYr4u
	 RMTdMlrmm+YWAsjg7HkdcXpYqdPwRRlIVAipATMtYo54G7FLkQmcY+m23tRuhPmiXm
	 x4s7Ac3Hv2BzvNt+PeCPgf1GLkahnISUmbpShWrjAayPjs2ZsOJntir1U38Im0ByXu
	 dp3LHNUpvauxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: matrix-keymap - reject keycodes above KEY_MAX
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linmao Li" <lilinmao@kylinos.cn>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260909100739.3107556-1-lilinmao@kylinos.cn>
References: <20260909100739.3107556-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 10:19:34 +0000
Message-Id: <20260909101935.578E31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds checks on matrix dimensions causes an integer overf=
low when calculating max_keys, leading to an undersized heap allocation and=
 a subsequent out-of-bounds write.
--

commit 821b9503dcfef31a275bc1fec44950b4eda55e94
Author: Linmao Li <lilinmao@kylinos.cn>

Input: matrix-keymap - reject keycodes above KEY_MAX

This commit adds bounds checking for keycodes in matrix_keypad_map_key() to
ensure they do not exceed KEY_MAX. This prevents a malformed firmware or
platform keymap from writing past the bounds of the capability bitmap.

> diff --git a/drivers/input/matrix-keymap.c b/drivers/input/matrix-keymap.c
> index 3bea3575a0a94..e4227e96aa4e7 100644
> --- a/drivers/input/matrix-keymap.c
> +++ b/drivers/input/matrix-keymap.c
> @@ -35,6 +35,13 @@ static bool matrix_keypad_map_key(struct input_dev *in=
put_dev,
>  		return false;
>  	}
> =20
> +	if (code > KEY_MAX) {
> +		dev_err(input_dev->dev.parent,
> +			"%s: invalid keycode %u in keymap entry 0x%x\n",
> +			__func__, code, key);
> +		return false;
> +	}
> +
>  	keymap[MATRIX_SCAN_CODE(row, col, row_shift)] =3D code;

[Severity: High]
This is a pre-existing issue, but since this patch aims to mitigate malform=
ed
firmware and keymaps causing out-of-bounds writes, does the bounds check
earlier in this function fully protect against integer overflow?

If a maliciously crafted Device Tree provides a large value for
keypad,num-rows (e.g., 0x80000001), it is read without bounds checking. When
matrix_keypad_build_keymap() computes max_keys:

drivers/input/matrix-keymap.c:matrix_keypad_build_keymap() {
    ...
    size_t max_keys =3D rows << row_shift;
    ...
    keymap =3D devm_kcalloc(&input_dev->dev, max_keys, sizeof(*keymap),
                          GFP_KERNEL);
}

The 32-bit shift overflows, resulting in a tiny allocation for keymap.

Then in matrix_keypad_map_key(), the earlier bounds check:

    if (row >=3D rows || col >=3D cols) {
        return false;
    }

compares the extracted 8-bit row against the large unshifted rows value
(0x80000001), completely bypassing the safety check.

This allows MATRIX_SCAN_CODE to calculate an index far outside the tiny
buffer, causing an out-of-bounds heap write when assigning the keycode here.
Should rows and cols be validated against a maximum sane value before the
shift to prevent this overflow?

>  	__set_bit(code, input_dev->keybit);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909100739.3107=
556-1-lilinmao@kylinos.cn?part=3D1
