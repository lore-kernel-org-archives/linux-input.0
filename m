Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E5A511230;
	Wed, 16 Sep 2026 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569821; cv=none; b=pnvO/IbXxKkTCj5mN10BRPwRzKsXmVwM/pPwGpL479RGVXiCitvkT0s8yXCmaqRJ2DJtI9EGqQAQ56ub640Yq39lYtgHIb8MCgRLmXjFHs/9sTS4nXiHkJFmcfuqRfCLY7F5TNNDw09mSFBOIF5fY/xL7sfnChf2HxYISoAp1rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569821; c=relaxed/simple;
	bh=lOFp8jYZ5MFne+3Lmtv6sZFk71edpvXO6mz5fSihSqs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=InowoPfsxDiQGV6e8Ag/NgrPvkhYAjT8Lvujv7kRrgjF3Mm7bqVjgvy5HGMYqVRn2elw9/pAvTSpP/z6IE1UvOXn639y0yfG30NmDvRf/8mAmWgvXfm+ys6ZyyqSHQBhuWQVfCcLeL+riMdM+B21c4+wZZ8LOGXsPdwAOgKF16s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9GfSJOx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9GfSJOx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104E41F000FF;
	Wed, 16 Sep 2026 14:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789569819;
	bh=A13kCcw9ArEt4WpVsX8DkVfrRV1kpvUki+/PUinst9M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l9GfSJOxK53P7MzywYkzh7dGNQHQrbwtAe9Z9RiQuoO7wO1qHjKrvgeA7lIaAslY/
	 3Lrfikc2K5g5hBsi65K5xnfD6a9XZSctiqOKsgci3UhyxhVrWU5AEemjqdxAKVpYgr
	 /knpyjgmiLoZJyiwWbGuiupxph7LWV9q7X1eHllvCF1cYb8daiiQ2/1Zfi6lwzFgTA
	 z1wKSghl6m9Hk/ZEh65INK0rh7GS4AraKji8Ez9PhFSXDI0sd5+RFxHUFozESIt1Mg
	 Jn0Gi6sW2MTIzrDmUx/itf7KyuUrLxwFt3cEEfgwpLMzq4Y0MuqcqL3xF89v6QeO9l
	 aNDlKWp7xotaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/19] drm: msm: mdp5: Add MDP5 configuration for
 MSM8952
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: mfd@lists.linux.dev, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, lee@kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org, linux-clk@vger.kernel.org, conor+dt@kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260916-msm8952-initial-support-v2-13-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-13-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:43:38 +0000
Message-Id: <20260916144339.104E41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/msm: hardware corruption due to zero-initialized LM3 base addr=
ess
--

commit f01ed8464ded4b4b827835f9551a26ed60e5dded
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

drm: msm: mdp5: Add MDP5 configuration for MSM8952

This commit adds the mdp5_cfg_hw entry for MDP5 version v1.12 found on
the MSM8952.

> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c b/drivers/gpu/drm/m=
sm/disp/mdp5/mdp5_cfg.c
> index 7c91fc1915f39..d34c94d6f7e2e 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
> @@ -744,6 +744,86 @@ static const struct mdp5_cfg_hw msm8x76_config =3D {
>  	.max_clk =3D 360000000,
>  };
> =20
> +static const struct mdp5_cfg_hw msm8952_config =3D {
> +	.name =3D "msm8952",

[ ... ]

> +	.lm =3D {
> +		.count =3D 2,
> +		.base =3D { 0x44000, 0x47000 },
> +		.instances =3D {
> +				{ .id =3D 0, .pp =3D 0, .dspp =3D 0,
> +				  .caps =3D MDP_LM_CAP_DISPLAY, },
> +				{ .id =3D 3, .pp =3D -1, .dspp =3D -1,
> +				  .caps =3D MDP_LM_CAP_WB },
> +			     },

[Severity: High]
Will this lead to hardware register corruption when LM3 is brought up?

In msm8952_config, the .lm.base array is initialized sequentially as
{ 0x44000, 0x47000 }, which assigns base[0] =3D 0x44000 and base[1] =3D 0x4=
7000.
This leaves base[3] implicitly zero-initialized.

However, the second LM instance is defined with .id =3D 3 (for LM3). When t=
he
driver configures this mixer, it uses lm->id to access the LM registers.
Because base[3] is 0, the driver will mistakenly perform writes to offset 0=
x0
of the MDP block (which corresponds to top-level registers).

Should designated initializers be used for the base array here, such as
{ [0] =3D 0x44000, [3] =3D 0x47000 }?

> +		.nb_stages =3D 8,
> +		.max_width =3D 2048,
> +		.max_height =3D 0xFFFF,
> +	},

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D13
