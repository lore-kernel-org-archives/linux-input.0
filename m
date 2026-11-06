Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794001496;
	b=LIka4BP5BPWMtMt3QPV+bAjIxp4b6vAtXZveJBDUH/7QPFhp2rKRgsrRGmHWJXHPiZiE
	 QAIOyWT0wra1e4jVCo2IyMelOVDS6SOzYPqFu2yOAbN8oGH2TOEkB2cl642TNffO0uuNF
	 0zT4Y4RMwL4+WzRMXD53OLgbry2uxBoJ0eLyFGDD3s7WfPAtKv4lMOn9QX7FgHGrso7GY
	 V9JI4AF9MgzG2RBs69dHshmZ+78I64T+S68+Q2DA5yXWJ3atKEEewbkiZuIR20tev8D6H
	 PjqTZqEogC6e6eGTP81l0uvlB4NyRHnkMQIr6GgetpC5rpHuMGPwmW9uo7/5lSnRTeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794001496;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lkmoFebkq8nWZ703QgOvJICk62q8cvcRQsXB9NPKHgY=;
	b=bzqd7LactfhEt12ReU8iIme8kbdM9uNg+gB+Q8OX94Lgy07aof1HM81fe1/3ih8XUCET
	 1+AaE0fdBiXetD58VScOS53eang6IMM7exJ6FUJHEC0G3MIpp8rm8z5oCaUYH5sBYEXTT
	 mVtz9rYuzETYla1JcgSfDCFzzuKa4tcgtEGDF1GX8R5d1gUXzyOso05wVWa1EgcnMiyKq
	 jlmgXY4ZpePQyr8SEM1u8CM942JpdvDcBjZxzksqPG0BenDDC+AgRx+m4pHo6EoSFVnLd
	 WqFXKKzD9IVCcNt64fSVwcdifG9gMgZQLDOLONahsk4ow5pKHVlwDddKx2mncKnAJwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FheKNWik;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0254606A326
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FheKNWik
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297F91F0089F;
	Fri,  6 Nov 2026 21:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794001495;
	bh=lkmoFebkq8nWZ703QgOvJICk62q8cvcRQsXB9NPKHgY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FheKNWikxaxcOtzTFaQNaHzBSxNdh6GTMnfCHQwrpQEGJcbFXQslnmN4sy23IvGpd
	 VVp4VNXeLk4nZCjOv7vmhTH/5TOrRdFkQOkZvsrKC3Tgwc/dkMhw1kNqF/+YzEr6sX
	 9Sh65IyYFb1jj4u5TEY6sqTRfIyccU7ieKvMyJoCaUAuoyNSts4iNX+0GT/ktWKNo3
	 WHOZTmGNY4ZD2e07eK1S5/BXzBBu9J9kkbpu/O6L9pAFxSWH4l10L/nHAeS+OYUekt
	 aVoKb2u9G4rD9Yl2J4kFKaJG+5VfaLI26HL+K1TUon+E9Mv9RiXLaZ2rgQpoq8d70v
	 JGEzP/f+aDkLA==
Message-ID: <sashiko-outbox-202297@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] HID: wacom: validate battery range before scaling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261106213526.3393779-1-qwe.aldo@gmail.com>
References: <CANRwn3Tt0VguzG=_azEZAP8vfxr0BbyWj=Nu-R3a0TA1nNGqog@mail.gmail.com>
 <20261106213526.3393779-1-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 21:44:54 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] HID: wacom: out-of-range battery values dropped in
  wacom_wac_event()
--

commit d917c200b45c05631d5073d9e5d68f13f31acf
Author: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

HID: wacom: validate battery range before scaling

This commit moves battery percentage scaling into a helper that checks for
a non-positive logical range, subtracts the logical minimum, and clamps the
computed percentage to [0, 100].

> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 361738bb87253..36bab07a72dba 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1960,6 +1960,16 @@ static void wacom_wac_battery_usage_mapping(struct=
 hid_device *hdev,
>  	return;
>  }
> =20
> +static __s32 wacom_wac_battery_percentage(struct hid_field *field, __s32=
 value)
> +{
> +	__s32 range =3D field->logical_maximum - field->logical_minimum;
> +
> +	if (range <=3D 0)
> +		return 0;
> +
> +	return clamp_val((value - field->logical_minimum) * 100 / range, 0, 100=
);
> +}

[Severity: Medium]
Can an out-of-range battery reading ever reach this clamp_val()?

wacom_wac_battery_percentage() is only called from wacom_wac_battery_event(=
),
whose sole caller wacom_wac_event() drops any value outside the logical
limits before checking WACOM_BATTERY_USAGE():

drivers/hid/wacom_wac.c:wacom_wac_event() {
    ...
	if (value > field->logical_maximum || value < field->logical_minimum)
		return;

	/* usage tests must precede field tests */
	if (WACOM_BATTERY_USAGE(usage))
		wacom_wac_battery_event(hdev, field, usage, value);
    ...
}

As a result, battery reports outside [field->logical_minimum,
field->logical_maximum] are still discarded in wacom_wac_event() without
setting WACOM_QUIRK_BATTERY or updating battery_capacity, and value is
already within bounds whenever wacom_wac_battery_percentage() runs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106213526.3393=
779-1-qwe.aldo@gmail.com?part=3D1
