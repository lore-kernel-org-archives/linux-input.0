Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90764471244;
	Thu,  1 Oct 2026 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790852411; cv=none; b=cqM7eJvgOsY2qrwd4WJ96dvtqxvsJVZbcdZTuHLe9IFCeeP5mfvc7jXi5HE3L9ZPj0tXfCsed0jxw8Xmx25z5Tryhb7HG/H/bbrWZ1pFWDkVofRqzjn1ufHxdHBjfW58EURl2QqIrjoraqQJb0k8W6OOAcbBk9lgRYs0xcGzOUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790852411; c=relaxed/simple;
	bh=tatj4hme3XHnJIospVnqX6kATrBX2wfAeUpeTN3WLqM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bRdliGS4tCg1XJCzILLtAlf/KqDt0lhLfOia/uxXwzIWYL0SCO1g9uFHCghWUErl9uwV9rd58tvHzU6oIqwHxb+VAutlOdpWOi0akpyM20RuG7OMVxFfI/61Y1Z4iHf7olkdwkD5bVpZoQeOPHuecogDPihGA+1oKMnv0xI23t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuEOmMoV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuEOmMoV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712101F000FF;
	Thu,  1 Oct 2026 11:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790852407;
	bh=7R0n7aR3t/s3IPaoeTNmWosZm1MdlcZoSF8jHiksjpY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kuEOmMoV+Mm5NoP1q9k9JjnjiehUeF6GVSRryLK79BmCdyvYWXzt/RFceHpYiZLXq
	 ha6/59KeiD0sQLkTZUF6ao5KhXF0xOSv6T2n7/hSqJkogfE6xn6NLMYsEoQvlZJtMk
	 i+xgPag2ZSD/7pjo72iCyTda1zal7w+U1skKOcmgDQkSGbjeWnKs0ZLv1IcEuhgxO9
	 YhRTNWLLEWv6pT56ZO5YBZ0Lu+5eG4EEtY+SpvCWofe9syUoiGyaYB/9QW5rMw1ua3
	 LaJNG+4p1uR4sWGeT3a/Bixbbv/lwrMkzdawWEWUStcxQaDciNDxQsm4dWg8vfMqBD
	 g/gki8xFos/Qw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] Input: hynitron-cst816x: release gesture keys
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, robh@kernel.org
In-Reply-To: <6f87a6c44555a0abb5d7f677250c28aacb230fbc.1790851590.git.daniel@makrotopia.org>
References: <cover.1790851590.git.daniel@makrotopia.org>
 <6f87a6c44555a0abb5d7f677250c28aacb230fbc.1790851590.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 11:00:06 +0000
Message-Id: <20261001110007.712101F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] input: OOB read in cst816x_release_keys() due to unvalidated DT =
keycodes
--

commit cb8390c95078c2f0098d2be4f937c758b29ad76d
Author: Daniel Golle <daniel@makrotopia.org>

Input: hynitron-cst816x: release gesture keys

The gesture key is reported with the value of the touch flag, so it stays
pressed once the controller stops reporting the gesture code while the
finger is still down. This commit reports the press on its own and releases
the keys the input core still holds down when the first report without a
gesture code arrives.

> diff --git a/drivers/input/touchscreen/hynitron-cst816x.c b/drivers/input=
/touchscreen/hynitron-cst816x.c
> index 865c5a767ba01..e2093518e8af1 100644
> --- a/drivers/input/touchscreen/hynitron-cst816x.c
> +++ b/drivers/input/touchscreen/hynitron-cst816x.c
[ ... ]
> @@ -168,6 +168,18 @@ static void cst816x_reset(struct cst816x_priv *priv)
>  	msleep(100);
>  }
> =20
> +static void cst816x_release_keys(struct cst816x_priv *priv)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < priv->keycodemax; i++) {
> +		if (!test_bit(priv->keycode[i], priv->input->key))

[Severity: Medium]
Can this read out of bounds on the priv->input->key bitmap?

If a keycode provided in the device tree property exceeds KEY_MAX,
input_set_capability() safely ignores it during registration, but the
invalid large value remains in the priv->keycode array.

When cst816x_release_keys() iterates over this array, it directly calls
test_bit(priv->keycode[i], priv->input->key). Since test_bit() doesn't
perform bounds checking like the input core's event handlers do, passing
an oversized keycode could result in a memory read past the end of the
bitmap structure during touch interrupts.

> +			continue;
> +
> +		input_report_key(priv->input, priv->keycode[i], 0);
> +	}
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/d18629ede3f2fd5a08d=
0cbdaf82f4254e89500ed.1790851590.git.daniel@makrotopia.org?part=3D3
