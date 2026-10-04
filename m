Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021F53EC835;
	Sun,  4 Oct 2026 09:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791107163; cv=none; b=i4qxA7m7DgzmCa3s5zEjOuKpZjeSMSKzuO4upbula5TDelUN2W9QEAfQQi6ZwGhuTG65usp0ttBadh3GLB+qDYnKjBp8BJjLBFPib2nleNCtXeVIv96XM0sMYInHmfJhaVYbhQ+Bx7tvNGBGnAqTpl9m6lT4ntJ7JzbGKlwLqM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791107163; c=relaxed/simple;
	bh=LCjR8kHb3/DvvlKP90Fsg2iVQDSg5biaBsAgz3qs0NA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hd4uE9X3Ci9Z0crQX5LUyd1rlmsHlrYV9Ma2l7/MNPgBdMh4bIy4Vwhp4n4UHO6YAOro6JwaqILytaLLZzxaM68le2luScxora+6GPyCMAP+A9rUvQht5AiJet7ebSojAdHXjPfVnu7mDRQx/M/SroWclPY2xnd0GizKtsQM9/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doI785/j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doI785/j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6041F000FF;
	Sun,  4 Oct 2026 09:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791107157;
	bh=talQ5R0YHiA4L9gG+lDHB+kBMAhwiJtMCcHfu8Nn+oY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=doI785/jOJaVstewP+hZLvcaux19iY75uOkphpRSnTgkBDtgJDycPUfOyl4ykJqHb
	 N7diJDnGSb+noIZYPL8aPbHpshsY5D8MJ1+16SOWu9sIsRSsjhooGrSAJrGKV3De+L
	 4T+p/muFEVbvE2amgv+uCJ9MjI7TA5ko/ukY/MWf2w5fsKMjlQo6UVU6TQLm3/Wbbu
	 7/k7+Wa74PiA0cxaw91yQe/g7NQkzLaccllxulmdcslTkuhld2Gt8l3RmAcWget3fF
	 C+hyr801GnJLolWOtJy1j2/L7Wml7iPpOe3zVIulsCtvfUpSqoS086SWpAGSLo8rVQ
	 F84ET1VXeF6uQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] Input: hynitron-cst816x: release gesture keys
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: conor+dt@kernel.org, robh@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <8c20e53cd026e04774164f869b2be2c5982bdbe0.1791103511.git.daniel@makrotopia.org>
References: <cover.1791103511.git.daniel@makrotopia.org>
 <8c20e53cd026e04774164f869b2be2c5982bdbe0.1791103511.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 09:45:57 +0000
Message-Id: <20261004094557.8B6041F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] input: TOCTOU race in cst816x_release_keys() due to lockless dou=
ble-read
--

commit 0b6af957c2d032170de5ed337fe23bb294db578d
Author: Daniel Golle <daniel@makrotopia.org>

Input: hynitron-cst816x: release gesture keys

This commit fixes an issue where gesture keys stay pressed when the
gesture stops but the finger remains down. It adds logic to explicitly
release keys held by the input core on the first non-gesture report.

> diff --git a/drivers/input/touchscreen/hynitron-cst816x.c b/drivers/input=
/touchscreen/hynitron-cst816x.c
> --- a/drivers/input/touchscreen/hynitron-cst816x.c
> +++ b/drivers/input/touchscreen/hynitron-cst816x.c

[ ... ]

> @@ -168,6 +180,18 @@ static void cst816x_reset(struct cst816x_priv *priv)
>  	msleep(100);
>  }
> =20
> +static void cst816x_release_keys(struct cst816x_priv *priv)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < priv->keycodemax; i++) {
> +		if (!test_bit(priv->keycode[i], priv->input->key))
> +			continue;
> +
> +		input_report_key(priv->input, priv->keycode[i], 0);

[Severity: Medium]
Is there a race condition here due to reading priv->keycode array elements
twice?

Because the priv->keycode array is shared with the input core and
cst816x_release_keys() does not hold the event_lock, a concurrent
EVIOCSKEYCODE ioctl could modify the array between the test_bit() check
and the input_report_key() call.

If this occurs, could the driver spuriously release a completely different
keycode than the one it just tested?

Would it be safer to read the array element into a local variable first to
ensure the exact same keycode is both evaluated and reported?

> +	}
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791103511.gi=
t.daniel@makrotopia.org?part=3D3
