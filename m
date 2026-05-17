Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E966286430
	for <linux-input@vger.kernel.org>; Sun, 17 May 2026 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779031165; cv=none; b=SC84ZJUYQ4jflc5MsA6UpIOz+7zgJLdIdb2T57KRfmU+wLooiR+4eV4v9obeAqVYYn2s5c8ZPcb36HoAEJk7r1X9+5WOACuOlnjduwa+gL6f4ZeFq4mwNgEbc/vuvt3amyDscQF5OFEMk5d02aoPHoHGwD958+EHXVppMk/7dlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779031165; c=relaxed/simple;
	bh=tv0Vi//r4EE+ukuWqgBC1s0J9d1wo2Kv88+5tDuUAM4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oYHBO5zab44OaGzNDjjAd9I2a9JcKtCaQ2QtXrf/bbGAZIbDUhYHPQYq7GSUMRsbnIVyRwoo18l6ygFbqkZ6XesIWMwyFHDpaTDhZTyXBImbYBhfF5AG0wkTAMvKcr1wZ9LCx4JiULAwKokZdh4S27SRMeQRvYPuhQM7JuvUfrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIQ3lbAA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIQ3lbAA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8CBC2BCB0;
	Sun, 17 May 2026 15:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779031164;
	bh=tv0Vi//r4EE+ukuWqgBC1s0J9d1wo2Kv88+5tDuUAM4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=fIQ3lbAAISR60PEWnJNqcyqhXEtr8AeJgM8VECfZl0+YKH5558tzzEvNkf2OC051a
	 X4UDJW7+N8jUTsNcr+sQPUKp36WQWmLDTQxiw6Yt0wFQdO6gLVmmgKDw6aGHX3KSpw
	 QCqyKTc5rw7I6Tzvkn9EOdK8NJjnD6sKPLJ88HyDzdkoxErfRnTLUQPxKIuixLybUG
	 gi1KC9/2AWJToe1VtnzN1dHYUrVwOiGjhqqK3CqeqiB1OyLQEdsF4bt/uEi4joRY01
	 Ac4UhbFlrURGWxkKA6s3+c/R1c4HlToFonUfVI7AvL2cGAeLxdoZv3sklu5GhOGaWO
	 H3B91cZcfoW2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] HID: wacom: validate report length for DTUS handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinmo Yang" <jinmo44.yang@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260517135215.2220117-4-jinmo44.yang@gmail.com>
References: <20260517135215.2220117-4-jinmo44.yang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 15:19:24 +0000
Message-Id: <20260517151924.BC8CBC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The global `if (len < 7)` check in `wacom_wac_irq()` for DTUS/DTUS=
X devices drops valid short reports, breaking the DTUSPAD (pad buttons) fun=
ctionality.
- [High] Incomplete fix leaving other device types vulnerable to slab-out-o=
f-bounds reads.
- [High] NULL pointer dereference in `wacom_dtus_irq` for DTUSX devices.
--

commit bbe438798c1e7006b14d3fc0a92585f47e3776e2
Author: Jinmo Yang <jinmo44.yang@gmail.com>

HID: wacom: validate report length for DTUS handler

This commit adds a minimum length check in wacom_wac_irq() for DTUS and DTU=
SX
devices before dispatching to wacom_dtus_irq() to prevent out-of-bounds rea=
ds.

> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 873d58a6d5a3b..269e8318f79af 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -3479,6 +3479,8 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, siz=
e_t len)
> =20
>  	case DTUS:
>  	case DTUSX:
> +		if (len < 7)
> +			return;

Does this global length check drop valid short reports for pad buttons?

Looking at wacom_dtus_irq(), it processes two different reports:
WACOM_REPORT_DTUS which accesses up to data[6], and WACOM_REPORT_DTUSPAD
which only accesses data[0] and data[1].

If the pad report is sent as a 2-byte transfer, this check will drop it bef=
ore
it reaches the handler, breaking the ExpressKeys functionality.

Should the validation first check the report ID (ensuring len >=3D 1) and t=
hen
enforce the minimum length specific to the report type?

Also, while this patch adds a check for DTUS/DTUSX, does it leave other dev=
ice
types vulnerable to similar out-of-bounds reads?

Other branches in wacom_wac_irq() such as PENPARTNER (which accesses up to
data[6]) and GRAPHIRE (which accesses up to data[7]) do not appear to have
length checks before calling their respective handlers.

Lastly, looking at wacom_dtus_irq(), it handles WACOM_REPORT_DTUSPAD by usi=
ng
wacom->pad_input:

drivers/hid/wacom_wac.c:wacom_dtus_irq() {
	...
	} else if (data[0] =3D=3D WACOM_REPORT_DTUSPAD) {
		input =3D wacom->pad_input;
		input_report_key(input, BTN_0, (data[1] & 0x01));
	...
}

Since DTUSX does not receive the WACOM_DEVICETYPE_PAD capability flag during
initialization, wacom->pad_input remains NULL.

If a spoofed DTUSX device sends a WACOM_REPORT_DTUSPAD report, does this ca=
use
a NULL pointer dereference when calling input_report_key()?

>  		sync =3D wacom_dtus_irq(wacom_wac);
>  		break;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517135215.2220=
117-1-jinmo44.yang@gmail.com?part=3D3
