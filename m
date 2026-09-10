Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025A337A85E;
	Thu, 10 Sep 2026 03:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011260; cv=none; b=sFTDeZems7SzfPNh4/+ZGTVA2gYmaQANvaplz2niRiLJm4gOeBH3QsYkxym8MwGemABQ73XPuFc6Waq3HaA8DJmiOfaj7/luYTBIk/yL9WGl1XOxYfY2C3kZQIt0UyM/qMI4SH64HI3hgmrR2+qWFf1jdI5RUg+AbKV/vc+f6/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011260; c=relaxed/simple;
	bh=zwCbMvAFL/kQDF/M9fOUxYWzuv++SvG05IQb07WTwiE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XAvRWN4DPWoHUi9Bf0cA3IMWqc2pZAJi94sTv3tmrFSU8bWtw4OZdnDNQP6jzxgGrXqNwg02vERRIsRan0SEu+TaD+QOLUxXlitOrH1zAWaeybh7PyvslN2tbifm/+MCaABJyys2RDcLDmhA9K46C+oNBiWX4Bb+agHCL0rMOPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guOcaXVm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guOcaXVm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C167D1F000FF;
	Thu, 10 Sep 2026 03:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789011255;
	bh=mMYYIGKzbWboHJQbpG2Q2lns2UFcFV9k5evyTJhN7So=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=guOcaXVmZKdDsEVwDKPkNPau7Qqpnm4Aaae5bmAiTpWkXhTMb0xUwZ4N3j3gCSBiu
	 fnJduLyMLsHCjKVrx7KdSXioSgatTBVOMvDaii+Q6FXSTjfnSymn4pCwuNvT007TUr
	 bkJdAzxtBSbs/lzxKzjCH4vBIPNyCUZQnheZTN5ZS30snlmzBMsyQrpkKlw9I00nKF
	 cScStcjKhT0wUcgDsL+zL8lpxTEJwASW1LFHTSiT4geajJn37NXufZoMxoBPhqK2Sx
	 5f52xwr714rpOKUJG4JZvcX5p1ccxR2OQ0dnDQyIDp+N8wfPOiTPjhUnRIudT6qZQ9
	 wsiGCmF6V8m6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/15] HID: hid-oxp: validate input report lengths
 before decoding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrei Aldea" <andrei1998@gmail.com>
Cc: lee@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-leds@vger.kernel.org
In-Reply-To: <20260910032115.28669-3-andrei1998@gmail.com>
References: <20260910032115.28669-1-andrei1998@gmail.com>
 <20260910032115.28669-3-andrei1998@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 03:34:14 +0000
Message-Id: <20260910033414.C167D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Shared driver state variables are concurrently modified from atomi=
c context and read from process context without protection, enabling a TOCT=
OU out-of-bounds read.
--

commit c83e5978640f43b909fcea30940f12727c190fcd
Author: Andrei Aldea <andrei1998@gmail.com>
Subject: HID: hid-oxp: validate input report lengths before decoding

This commit adds length checks to ensure short USB reports do not result in
out-of-bounds reads when decoding RGB status and printing debug information.

> diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
> index 3f2be8059ddb1..0c895bd778bbf 100644
> --- a/drivers/hid/hid-oxp.c
> +++ b/drivers/hid/hid-oxp.c
[ ... ]
> @@ -404,6 +411,8 @@ static int oxp_hid_raw_event_gen_2(struct hid_device =
*hdev,
> =20
>  	if (data[3] !=3D OXP_GET_PROPERTY)
>  		return 0;
> +	if (size < sizeof(*rgb_rep))
> +		return 0;
> =20
>  	rgb_rep =3D (struct oxp_gen_2_rgb_report *)data;
>  	/* Ensure we save monocolor as the list value */

[Severity: High]
This isn't a bug introduced by this patch, but can the lockless assignment =
of
drvdata.rgb_effect here cause a Time-Of-Check to Time-Of-Use (TOCTOU)
out-of-bounds read in effect_show()?

In drivers/hid/hid-oxp.c, oxp_hid_raw_event_gen_2() updates the effect
locklessly from the raw event handler:

	drvdata.rgb_effect =3D rgb_rep->effect =3D=3D OXP_EFFECT_MONO_TRUE ?
			     OXP_EFFECT_MONO_LIST :
			     rgb_rep->effect;

Concurrently, a userspace process reading the effect sysfs attribute calls
effect_show(), which performs two separate lockless reads of
drvdata.rgb_effect:

static ssize_t effect_show(...)
{
    ...
	if (drvdata.rgb_effect >=3D ARRAY_SIZE(oxp_rgb_effect_text))
		return -EINVAL;

	return sysfs_emit(buf, "%s\n", oxp_rgb_effect_text[drvdata.rgb_effect]);
}

If a malicious device sends continuous status event reports, can the value =
of
drvdata.rgb_effect change to an out-of-bounds value immediately after the
bounds check but before the array access? This would cause sysfs_emit() to
dereference a garbage pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910032115.2866=
9-1-andrei1998@gmail.com?part=3D2
