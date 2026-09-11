Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE713AC0ED;
	Fri, 11 Sep 2026 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117268; cv=none; b=L8q/E+S3pf2dqmPoHruPOUMSp+H/5qcME2QSFJu46dGwTtD6SZ2vw4D3H9Lrl133zTPkxUu5c5KmOET4htcKaShy7/bLTujlCk9iwzEZP3zFR10ZzUcRvTRtrP4hrih3ZrYdp/g5exoZP4zC38fSbbZOtUcPdsl8eynZe4ItudI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117268; c=relaxed/simple;
	bh=rK28yKckFI15fUtjTaV3c5XS+hsPiQtbtU+nF7ld7iE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tLtjcm8mCmx1dm1mylL07kgEXpgC5j7Bxtu0Enp9r36uigoqIGbyTTrFADFV6TRuysIzEfEEDu2Bhs+BJ174VniajsrhsZOEhN4kbdNHY0jGqPn6vyeMaVDjvfvAvpn4xu+2kDxGc5Bofhvy1t76B+OJRRhrKfhOhh3KF+FgazU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwY8I6YB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwY8I6YB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A031F000FF;
	Fri, 11 Sep 2026 09:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789117267;
	bh=sE9gnJui8R3Z58WQI7q2OGrr/Sor8lYNs0/EcAqCuDI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bwY8I6YB9XWplFeaJ8Q+F0Djn4ysPS8YBq1XUg5AYOA7R9j9xaNEKQukiIuyuIw3J
	 9xH24xT9FZMSJJ5FbbEldOT4VBRyWLOhWtepQn3ejeffv24bXQP1XSmr5sV4REb0Wn
	 7404pm/lHxZjCWKyu+wET6whCNYbzvt8MOECqvv/jfI1uPR2PXvy7oIIr5ZRKRg0ph
	 brYWOHOxB28M+vKKDQfe138MEh2n4tnFMPDTNvqOQ4t9vL5G2yARSfZzaUS0nkN42Y
	 4nSpb9bLWMWtQLBkqoMLlOkNUJFHdjY8FqActT7bOqCanMpCJ09F6vVNWsDo30/u8Z
	 IA8AzVGkxPjAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 07/10] drm/msm/dpu: describe SM6125
 programmable-fetch delayed-start quirk
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?WcSwxJ7EsFRDQU4gS0FWQUtMSQ==?= <kavakliyigitcan@gmail.com>
Cc: lee@kernel.org, dri-devel@lists.freedesktop.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org, robh@kernel.org, linux-leds@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260911-ginkgo-submission-final-v1-7-0e68e63a18d4@gmail.com>
References: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
 <20260911-ginkgo-submission-final-v1-7-0e68e63a18d4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 09:01:06 +0000
Message-Id: <20260911090106.94A031F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditional addition of `horiz_total` to `vfp_fetch_start_vsync_=
counter` can push the fetch trigger out of bounds, preventing it from firin=
g.
--

commit 2270768f2936b4e384a8e10940ee1267f2738202
Author: Y=C4=B0=C4=9E=C4=B0TCAN KAVAKLI <kavakliyigitcan@gmail.com>

drm/msm/dpu: describe SM6125 programmable-fetch delayed-start quirk

This commit introduces a workaround for the SM6125 DPU where the programmab=
le
prefetch start counter evaluating on the active-video to vertical front por=
ch
boundary causes FIFO overflows. It adds a has_prg_fetch_delay quirk to delay
the fetch start by one scanline by adding horiz_total to the counter.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drive=
rs/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> index ba810f26ea309..15445eaf9f3ba 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
[ ... ]
> @@ -237,10 +237,21 @@ static void programmable_fetch_config(struct dpu_en=
coder_phys *phys_enc,
> =20
>  	vfp_fetch_lines =3D programmable_fetch_get_num_lines(phys_enc, timing);
>  	if (vfp_fetch_lines) {
> +		const struct dpu_mdss_cfg *catalog =3D phys_enc->dpu_kms->catalog;
> +
>  		vert_total =3D get_vertical_total(timing);
>  		horiz_total =3D get_horizontal_total(timing);
>  		vfp_fetch_start_vsync_counter =3D
>  		    (vert_total - vfp_fetch_lines) * horiz_total + 1;
> +
> +		/*
> +		 * SM6125 (DPU 5.4 / Trinket) quirk matching downstream
> +		 * delay_prg_fetch_start =3D true. Throttle fetch start
> +		 * to the second line after active video (VFP line 1).
> +		 */
> +		if (catalog && catalog->caps && catalog->caps->has_prg_fetch_delay)
> +			vfp_fetch_start_vsync_counter +=3D horiz_total;

[Severity: High]
Could this unconditional addition push the fetch start counter out of bound=
s?

If a panel is configured such that vfp_fetch_lines evaluates to 1,
vfp_fetch_start_vsync_counter initially calculates to:
(vert_total - 1) * horiz_total + 1

Adding horiz_total then makes the counter evaluate to:
vert_total * horiz_total + 1

Since a full frame consists of exactly vert_total * horiz_total pixels, the
hardware vsync counter will wrap at the end of the frame before reaching th=
is
new value. Will this prevent the programmable fetch trigger from ever firing
and result in a complete loss of pixel output?

> +
>  		f.enable =3D 1;
>  		f.fetch_start =3D vfp_fetch_start_vsync_counter;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-ginkgo-sub=
mission-final-v1-0-0e68e63a18d4@gmail.com?part=3D7
