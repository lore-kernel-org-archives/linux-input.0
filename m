Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EAF390615
	for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 03:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789183407; cv=none; b=WQDI1Hg1Ddo8Ofo6RuFX1vGbgD4NWe4wDB++47YpOLxgA5v6la9t2c39RhDVKWHPgtmuMN2opm68+xAq5cGBVEpFcCmi/kn9cj7xNOnPshT0IhYCPHrFBAl0XxVTyKkG1gBSm8QWalV8Nntan0aVZtRl5nHYXEUssIELMKZhsHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789183407; c=relaxed/simple;
	bh=zB9Lbp3ZrLvLKoFvi403YLAaA2xro2ryzDk4We0Z8m4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tPbCrZka3NfTnm3QJH/hPUBSe9PrsoK2quGyAc00CpINO9A5W6N75EFpAl3PCguDoXX1r1vKv2poxkDpD9wqyOXpnxLyhAtW+ujvgnAMjtr9SadtMeueT2MxrQmwuhBG/ShSYfFpeqbvrZZQpS/hFl7m8y0RvjHkndaBzX8ZBac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWMO5qXw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWMO5qXw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4251A1F000FF;
	Sat, 12 Sep 2026 03:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789183404;
	bh=Nsc2d8O3hmKBi2TV2JreEMeW3/A/naIzi2G2oFygB5s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RWMO5qXwvTh2xLUEq4v39Xjr9WntwJ4wTyG3TDYWeZUdHay6ldQ0NRwvxHT3WAppQ
	 PIkPxzx1abnxFbdCOWgggWXwMyryMNs4M3eMf3xZK0zFI60kZTFetIfcks9ty+B7da
	 cwoWoMDInIRZSmAPwAqARnrijwYwQ7AxmeGQJjLYWrt9A2QkdD2WCRLEAOOrD/CeJg
	 kuRtcZzCr/QkVkmGwrJ9QpZMYTgnSYpQCD8+uIs7f2Y6Yke9WIGW3BPDRG2UDEizbV
	 PX7YAB+BgkWx4OxE7F14XyDXeyr/ph6cV3BukGadRYLizFMxRRwT7w8lmA8Hm7+S0v
	 pbNxwH0c7Os/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/12] Input: xbox_gip - Add support for PDP guitar
 controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260912030426.2997003-10-vi@endrift.com>
References: <20260912030426.2997003-1-vi@endrift.com>
 <20260912030426.2997003-10-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 03:23:23 +0000
Message-Id: <20260912032324.4251A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Payload-dependent format parsing causes inconsistent button mappin=
g and aliasing on the RiffMaster.
--

commit f157752e23d4ee774cfa5a7ee1c93ecfd2cc8d44
Author: Vicki Pfau <vi@endrift.com>

Input: xbox_gip - Add support for PDP guitar controllers

This commit adds support for the PDP guitar controllers (Fender Jaguar and
RiffMaster models) to the xbox_gip driver. It introduces custom input mappi=
ng
capabilities and specific report parsing for the two variants of the device.

> diff --git a/drivers/input/joystick/gip/gip-pdp-jaguar.c b/drivers/input/=
joystick/gip/gip-pdp-jaguar.c
> new file mode 100644
> index 0000000000000..ec0e9d811d125
> --- /dev/null
> +++ b/drivers/input/joystick/gip/gip-pdp-jaguar.c

[ ... ]

> +static int gip_handle_pdp_jaguar_report(struct gip_attachment *attachmen=
t,
> +	struct input_dev *input, const uint8_t *bytes, int num_bytes)
> +{

[ ... ]

> +	if (num_bytes >=3D 7 && (bytes[5] || bytes[6])) {

[Severity: High]
Does this payload-dependent condition break the RiffMaster layout when all
frets are released?

If a RiffMaster user releases all neck frets, bytes[5] and bytes[6]=20
become 0. This causes the condition to fail, dropping the driver into the
legacy Jaguar format in the else block below.

> +		/* Newer report version on the RiffMaster */
> +		input_report_key(input, BTN_TRIGGER_HAPPY1, bytes[5] & BIT(0));
> +		input_report_key(input, BTN_TRIGGER_HAPPY2, bytes[5] & BIT(1));

[ ... ]

> +		input_report_key(input, BTN_TRIGGER_HAPPY9, bytes[6] & BIT(3));
> +		input_report_key(input, BTN_TRIGGER_HAPPY10, bytes[6] & BIT(4));
> +	} else {
> +		lower =3D bytes[1] & BIT(6);

[Severity: High]
When falling back to this legacy path for the RiffMaster, doesn't it cause
unintended button aliasing?

On the RiffMaster, bytes[1] & BIT(6) is mapped to BTN_THUMBR.

If the driver falls back to this path because all frets were temporarily
released, and the user happens to be holding the right stick button (or oth=
er
standard buttons located in bytes[0]), won't those inputs falsely register =
as
fret presses (BTN_TRIGGER_HAPPY1 through 10)?

Could this layout format decision use the static hardware quirk
(attachment->quirks & GIP_QUIRK_PDP_HAS_RIGHT_STICK) instead of relying on
transient payload data to distinguish between the controller variants?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912030426.2997=
003-1-vi@endrift.com?part=3D9
