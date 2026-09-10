Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D9139B94A;
	Thu, 10 Sep 2026 03:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011272; cv=none; b=Pdzv2sQfBFNB4lS5lYArYBCSmXBt2H6/x+yUEz0b11QMmSump5qG6wMmFcNqB2YoLv0Gs2YRa6XuTCu4RirhSNynRpfgc9Dup2RisetrecDK5eseTOuY0cwf7+iC/Wt72iH8A91WspRtxYJ/D1YJYTz08blaOm+T8e1080Z93Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011272; c=relaxed/simple;
	bh=d93JFTXNRtnEcvyz1ZLTQqGGNBOMhn/NbA1aioPnrMQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xtyq52a6sWYj9hgD4mk06zyBdAM3JubIpFuLGin9j+Sii+w74KlylS7G1V+qj2Q0Muph+FSMbW6/D3jlEMR0mszV+p8/t2kzUD5cjR7SiiSu1Oy/VjBkXx7T/pgL7lMkwPrSFwWyFmTTrt+k1By+tACtCgCsmwb1VzVvlvBMn0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXNVauYn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXNVauYn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F311F000FF;
	Thu, 10 Sep 2026 03:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789011265;
	bh=3um9qEMZmp0tRhHubXppc3gt+kHoI1Pyk/NfORm0TIg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PXNVauYn8LPkd6DMxMjSh1ZiLiGffECV0kHKLOgjHG2lqv/Tx8LZLgezprIN3fH3H
	 6pUGRjIcALQuw33bnZGVq776sTRhCsm3B3DiBs+QVi0VdlOCBQeRMnOkRoTTx3GCKj
	 X2wAIuYCwuIKD5ulY4p0yoWuLYG7VUcPs3hIgcPOPOm6gDjQAZC062QkMAmBPgpSjB
	 KcPqfzl543kg1rHL5OkKVSfZmNrH8rrrW7LEwZXeprRmDzT2L6my/DtIm2OuD5psdn
	 G5Mvt35tJPLej4Tt51rfyzW8Q/8zIYxiHAZu5W3phHYzf9RN1Wm8CCsDZU2HA43GbE
	 OOjLe4SY+eZig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/15] HID: hid-oxp: handle controller reinitialization
 across suspend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrei Aldea" <andrei1998@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260910032115.28669-11-andrei1998@gmail.com>
References: <20260910032115.28669-1-andrei1998@gmail.com>
 <20260910032115.28669-11-andrei1998@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 03:34:25 +0000
Message-Id: <20260910033425.97F311F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Late monocolor acknowledgments trigger spurious MCU reinitializa=
tions.
- [Low] Unnecessary 200ms delay when the transport write fails.
--

commit 0d410b2c1077d136f271fbc3070448d1e53eb0df
Author: Andrei Aldea <andrei1998@gmail.com>

HID: hid-oxp: handle controller reinitialization across suspend

This commit attempts to fix spurious MCU resets caused by confusing a monoc=
olor
acknowledgment with an asynchronous MCU reset notification. It tracks monoc=
olor
writes and consumes the matching acknowledgment. It also drains work queues=
 on
suspend and re-enables them on resume, and queues a fallback reinitializati=
on
after a set interval.

> diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
> index 7b366878fcb3e..e26e6a98294fe 100644
> --- a/drivers/hid/hid-oxp.c
> +++ b/drivers/hid/hid-oxp.c
[ ... ]
> @@ -417,11 +425,26 @@ static int oxp_hid_raw_event_gen_2(struct hid_devic=
e *hdev,
>  	if (data[0] !=3D OXP_FID_GEN2_STATUS_EVENT)
>  		return 0;
> =20
> +	/* A monocolor acknowledgment is not an MCU reset notification. */
> +	if (data[5] =3D=3D OXP_STATUS_ACK) {
> +		scoped_guard(spinlock_irqsave, &cfg->rgb_reply_lock) {
> +			if (cfg->rgb_reply_pending &&
> +			    data[3] =3D=3D cfg->rgb_reply_command &&
> +			    data[4] =3D=3D cfg->rgb_reply_zone) {
> +				cfg->rgb_reply_pending =3D false;
> +				solicited =3D true;
> +			}
> +		}
> +		if (solicited)
> +			return 0;
> +	}
> +
>  	/* Sent ~6s after resume event, indicating the MCU has fully reset.
>  	 * Re-apply our settings after this has been received.
>  	 */
>  	if (data[3] =3D=3D OXP_EFFECT_MONO_TRUE) {

[Severity: Medium]
Will this logic misidentify a late acknowledgment as a reset notification?

In mcu_property_out(), rgb_reply_pending is unconditionally cleared after
a strict 200ms timeout. If an acknowledgment from the MCU arrives after
that 200ms window, the solicited check above will fail because
cfg->rgb_reply_pending is already false. The late ACK will then fall
through to this check where data[3] =3D=3D OXP_EFFECT_MONO_TRUE matches,
mistaking the late reply for an MCU reset and scheduling a spurious
controller reinitialization.

[ ... ]
> @@ -509,12 +546,18 @@ static int mcu_property_out(struct oxp_hid_cfg *cfg=
, u8 *header, size_t header_s
>  	dev_dbg(&cfg->hdev->dev, "raw data: [%*ph]\n", OXP_PACKET_SIZE, dmabuf);
> =20
>  	ret =3D hid_hw_output_report(cfg->hdev, dmabuf, OXP_PACKET_SIZE);
> -	if (ret < 0)
> -		return ret;
> -
>  	/* MCU takes 200ms to be ready for another command. */
>  	msleep(200);

[Severity: Low]
Does this code unnecessarily delay 200ms on transport errors?

When hid_hw_output_report() returns a negative error code (e.g. if the
device is disconnected), this removed the early return but failed to
bypass the sleep, resulting in an unneeded 200ms delay.

> -	return ret =3D=3D OXP_PACKET_SIZE ? 0 : -EIO;
> +	if (ret >=3D 0)
> +		ret =3D ret =3D=3D OXP_PACKET_SIZE ? 0 : -EIO;
> +
> +	if (rgb_write) {
> +		scoped_guard(spinlock_irqsave, &cfg->rgb_reply_lock) {
> +			cfg->rgb_reply_pending =3D false;
> +		}
> +	}
> +
> +	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910032115.2866=
9-1-andrei1998@gmail.com?part=3D10
