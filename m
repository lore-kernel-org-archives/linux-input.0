Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F374C2F7F19;
	Sat, 12 Sep 2026 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789204743; cv=none; b=f/tbCrWBHpxal82oxgnvkiTs4awCrpun2D00mDll+AXqkMeSlOdvOoNYaEN/MS8i3nGSvjwx9NPAIPNq9QRlcYLBZztxRG7PD0l6ppaqO15gZ+ml1vY30ad5u9ws+pU4CDjRlo6xVsb3XZIIJVPRmUguSIn7PebXrVS6atk64z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789204743; c=relaxed/simple;
	bh=5QkPjsmyDhVoyR4w2ZV6txQxEc5lKnvTib5OvDc00c8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=okaNHFWhakWac6wG1zm8arWqf1AkagWE/BHiusq+2wmERO1arpJ6unbdyzcgjUCr88foPnMXSmhCaD4nJtbXIYrArj8+h0VsYaY15HAA+/T1FSeTSEzrjQ1n1Iu4NdRTfu2KPBoIo01x4vrAQqLz9z/CmUIRnS/i0hDE2/vjHr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgvxPJoM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgvxPJoM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A01C1F00893;
	Sat, 12 Sep 2026 09:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789204741;
	bh=lAsIpe806HlPTUSZ5kaRH5I/tDePjdmxr4OhX7PnnO8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FgvxPJoMZ2rV4b5CcrBvyYOtxy9O6Pm2TC7vFv5d+i3fL7sgTZCrkP3LPdt7wIDRX
	 v+rHQvRBYBgYMEiOajkDbGCWBadIGhD3QbbPg2PA0VuNApThauf1JJ8ljESxJ8C2Yb
	 F140PAXLMm1VoJJV2It8n92E8UNC1jRLTCqreUfUFk3FSijJgsnE9Yyps3+FfqxMCz
	 XedMjP+Nph2LV52SYhane6WpDgTIxWwtaN1z53CXkNyyi/HXGetFv3XL+XQztK5sw6
	 VWl382hMQaroIyITY8Hs6QQGXnEl6IXsNhJYLu7Cm0NSu4hmoU4Os+dhfWZeofBSPJ
	 Vn4w3Il1oNDFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 14/20] drm: msm: mdp5: Add MDP5 configuration for
 MSM8952
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-input@vger.kernel.org, robh@kernel.org, lee@kernel.org, dri-devel@lists.freedesktop.org, mfd@lists.linux.dev, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260912-msm8952-initial-support-v1-14-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-14-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 09:19:00 +0000
Message-Id: <20260912091901.4A01C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Missing designated initializers in the lm.base array maps the =
LM3 base address to the wrong index, causing register corruption.
- [Critical] Defining `.pipe_cursor` with a Layer Mixer offset (`0x440DC`) =
causes the driver to incorrectly program LM cursor registers as if they wer=
e a standard SSPP pipe, trashing the configuration.
- [High] Inconsistent MDP_PIPE_CAP_SW_PIX_EXT capability between pipe_curso=
r and main pipes.
--

commit fb5220e24e57b56379d9ec75eb6d29f391529a7b
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

drm: msm: mdp5: Add MDP5 configuration for MSM8952

Add the mdp5_cfg_hw entry for MDP5 version v1.12 found on MSM8952.

> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c b/drivers/gpu/drm/m=
sm/disp/mdp5/mdp5_cfg.c
> index 7c91fc1915f39..d34c94d6f7e2e 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
> @@ -744,6 +744,86 @@ static const struct mdp5_cfg_hw msm8x76_config =3D {

[ ... ]

> +static const struct mdp5_cfg_hw msm8952_config =3D {
> +	.name =3D "msm8952",

[ ... ]

> +	.pipe_cursor =3D {
> +		.count =3D 1,
> +		.base =3D { 0x440DC },

[Severity: Critical]
This isn't a bug introduced by this patch, but copying this configuration
defines a Layer Mixer offset (0x440DC) for an SSPP pipe.

Does this cause the driver to incorrectly program LM cursor registers as if
they were a standard SSPP pipe?

During cursor plane updates via mdp5_hwpipe_mode_set(), standard SSPP macros
like REG_MDP5_PIPE_* will treat 0x440DC as the SSPP base.
REG_MDP5_PIPE_OUT_XY (offset 0x10) will write to 0x440DC + 0x10 =3D 0x440EC
(LM_CURSOR_FORMAT), and REG_MDP5_PIPE_SRC_SIZE (offset 0x0) overwrites
LM_CURSOR_STRIDE. This misalignment destroys the LM cursor configurations
and causes hardware faults.

> +		.caps =3D MDP_PIPE_CAP_HFLIP	|
> +			MDP_PIPE_CAP_VFLIP	|
> +			MDP_PIPE_CAP_SW_PIX_EXT	|
> +			MDP_PIPE_CAP_CURSOR	|
> +			0,
> +	},

[Severity: High]
This isn't a bug introduced by this patch, but copying this configuration
leaves an inconsistent MDP_PIPE_CAP_SW_PIX_EXT capability between
pipe_cursor and the main pipes.

Are we exposing Software Pixel Extension capabilities on the cursor pipe
while main pipes lack it?

If the SoC does not support Software Pixel Extension,
mdp5_plane_atomic_update() will call mdp5_write_pixel_ext() and write to
non-existent SW_PIX_EXT registers when programming the cursor pipe,
triggering a Synchronous External Abort. If it does support it, the main
planes are underutilizing the hardware.

> +	.lm =3D {
> +		.count =3D 2,
> +		.base =3D { 0x44000, 0x47000 },
> +		.instances =3D {
> +				{ .id =3D 0, .pp =3D 0, .dspp =3D 0,
> +				  .caps =3D MDP_LM_CAP_DISPLAY, },
> +				{ .id =3D 3, .pp =3D -1, .dspp =3D -1,
> +				  .caps =3D MDP_LM_CAP_WB },
> +			     },

[Severity: Critical]
This isn't a bug introduced by this patch, but copying this configuration
leaves the lm.base array initialized sequentially without designated
initializers.

Will this map the LM3 base address to the wrong index and cause register
corruption?

Because lm.base is initialized sequentially as { 0x44000, 0x47000 },
base[0] becomes 0x44000 and base[1] becomes 0x47000. The remaining indices,
including base[3], are implicitly initialized to 0.

When the driver creates a mixer for LM3 (since its .id is 3), atomic commits
will cause REG_MDP5_LM_OUT_SIZE(3) to resolve to __offset_LM(3). This
returns mdp5_cfg->lm.base[3], which evaluates to 0x0. Writes to LM3
registers will thus write to SOC offset 0x0, corrupting the global MDP
configuration registers.

Should this use designated initializers for the base array to ensure base[3]
is mapped correctly?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D14
