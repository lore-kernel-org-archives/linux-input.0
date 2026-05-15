Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80EB2745E;
	Fri, 15 May 2026 06:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778824927; cv=none; b=aqcWPELgfQCVJuUfVeOmtjyUkwlai+KEtuo+F1k5ahI06vbCPWNENIYE4bEIKPmwERQtNaKR5ZXI8H4/H1ssZO8FEDCvaSlQ+iCeYtzRYZB9OT7hdW0u8TQwcCJw3w8dUYiU5Hs2Q9dUv7YJrxajYnsooJFPv2rKghqJVqDKZ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778824927; c=relaxed/simple;
	bh=14cqtNz8aiE8UM/nv/f4aw33+woFPGaAntFgInl1rnk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pniyWTr2Ff+rrGUEFDwdpuNYAKvwuoY+CjH6fcs3zG9+U6noAzWFiNKOyBDmQwo75kHPJn4i0bZ7yOaK93r2Xn3fvGk1bNacAA5FiK0zA/5y8jdErtOilII56gan3U+0JdQvxfNpWG8Gj3gMqK7mUXcODpQ+q7U2rtjCdW0sJuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gz4xdUMh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gz4xdUMh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B69C2BCB0;
	Fri, 15 May 2026 06:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778824927;
	bh=14cqtNz8aiE8UM/nv/f4aw33+woFPGaAntFgInl1rnk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Gz4xdUMhT4rW2JXWFKAYuKpBDbFMfhTK8gTLOUtTI5AjCDh4pSHFzCRNHlc3RytWe
	 G9E/2xV6B8zJwYzKmfYBRrxdIhBbnL4kNGu7YObuQcw5SKwPMAIR5GgASJA+o++lng
	 gEBZFu1ul2HlTQJrNaaarxBwq3FuIBP/pZmOHvdpKmGIzN5Rl7nGpR25fla6zAOTDn
	 vMVRRyvFCBSNa3rHP/lwlNwB/NO21h0v2JbyJl43OHP79g7bdRRMO61wxrAlATTp10
	 HJDdO44AgOLbvjsOTAPe7lpXJ15C2w2gUlXmNhKCDCEphN/0mVdP0RSmm3GtLzuOKP
	 k/MxpHcN/i+cg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/7] platform/surface: SAM: Add support for Surface
 Pro 12in
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harrison Vanderbyl" <harrison.vanderbyl@gmail.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <ab458aadea651396d9ea7629419a32dc7510c593.1778822464.git.harrison.vanderbyl@gmail.com>
References: <ab458aadea651396d9ea7629419a32dc7510c593.1778822464.git.harrison.vanderbyl@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 06:02:05 +0000
Message-Id: <20260515060206.56B69C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incorrect software node used for the pen stash device, breaking =
pen stash events.
--

commit 66a330e4ed95d1a03b167abb4b106aaef584a66f
Author: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>

platform/surface: SAM: Add support for Surface Pro 12in

This commit adds a SAM client device node group and registry entry for the
Microsoft Surface Pro 12-inch. It specifically mentions enabling the cover
keyboard, cover touchpad, and pen stash events.

> diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/dri=
vers/platform/surface/surface_aggregator_registry.c
> index 0599d5adf02e6..8840499614154 100644
> --- a/drivers/platform/surface/surface_aggregator_registry.c
> +++ b/drivers/platform/surface/surface_aggregator_registry.c
[ ... ]
> @@ -422,6 +422,19 @@ static const struct software_node *ssam_node_group_s=
p11[] =3D {
>  	NULL,
>  };
> =20
> +/* Devices for Surface Pro 12" first edition (ARM/QCOM) */
> +static const struct software_node *ssam_node_group_sp12in[] =3D {
> +	&ssam_node_root,
> +	&ssam_node_hub_kip,
> +	&ssam_node_tmp_sensors,
> +	&ssam_node_hid_kip_keyboard,
> +	&ssam_node_hid_sam_penstash,

Will this software node work correctly for the Surface Pro pen stash events?

Since the pen is typically stashed inside the detachable cover keyboard on
Surface Pro devices, its events are usually routed through the Keyboard
Interface Protocol (KIP) hub.

Other Surface Pro models, like the SP11, use ssam_node_hid_kip_penstash
instead. Should this use the KIP variant here as well? Using the SAM
variant might cause the driver to listen on the wrong target ID and miss
the pen stash events entirely.

> +	&ssam_node_hid_kip_touchpad,
> +	&ssam_node_hid_kip_fwupd,
> +	&ssam_node_pos_tablet_switch,
> +	NULL,
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1778822464.gi=
t.harrison.vanderbyl@gmail.com?part=3D3
