Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4FF1EB5CE
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 06:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779517508; cv=none; b=jQqg3K/vfKcJLoWlbQBDxvhQxNRdS7yo1ZjloRAHei/kXWmCitkZL2CYQ/1h3gCL31xwdYla6R4vP1GSxha0d66pcrYJKsOwPLMHkNPbSlB9AqbMB/umL+bIczzLFqjQwe3g+oGpzSexoUI+WunStrhqc5BldNee7guDGlEIL9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779517508; c=relaxed/simple;
	bh=ZMbxw4DJPUJTgeRI+iCVa0W7jhkDeQ0HZGYkgbPkKKE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N/lkz8ivvksxlS+Hbt5T84pCj4jUfX2j9XHT1PLEac1taktCEivNCYqX3xTPBm3gLgq3V/EUr1bcYlacw2g9DH3N0DQ+DticW6PEdXACJDIIliTyNUYK86dpPWAi13Mx4+zyEfgzQAYRVosGySjlBcDEvHdBgW1R5vrfHCpbEA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3g6H6Dp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3g6H6Dp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B639D1F000E9;
	Sat, 23 May 2026 06:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779517507;
	bh=qHudibblTc+AVb41rk2e/bb5G7crYdV8D9dq2Ajw8PQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e3g6H6Dp4X8MvJdLy9cJS9hdbnHdO4WenbkKkR2f22T2KCBS1HfFzF/jIJLavwIRh
	 ChDP/GaAvA/rR3rpjEGBa1Su54JW+iE/RUprAKVfRBfBZuc9MMXTji5r3Bhvpw3yBQ
	 R81Sy/oX0WDKgbtTmKbAvgQzrsDOLNvrkIZkCcrUlxln2owbwvN62sRK+VnApBJqtZ
	 Dx5xnHzbocW856t+2+RV+B8rRMxWdqwEZFyKbupaktSUwbeaAcJUTbYnn89L6OFeFh
	 cNYH6UNIBpbDjWDam4JW5FKFzP7Z0mKhq2jEbMNEs2XfoN3c9oyqI21sbtY9+FRDGe
	 49MQRRosJcqrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/11] Input: ims-pcu - fix logic error in packet reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260523050634.501509-7-dmitry.torokhov@gmail.com>
References: <20260523050634.501509-7-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 06:25:06 +0000
Message-Id: <20260523062506.B639D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect DMA Buffer Free Size in ims_pcu_buffers_free
--

commit dc91d6796d4d3cd53758e89df06633851a88ea55
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

    Input: ims-pcu - fix logic error in packet reset

    ims_pcu_reset_packet() incorrectly sets have_stx to true, which implies
    that the start-of-packet delimiter has already been received. This
    causes the protocol parser to skip waiting for the next STX byte and
    potentially process garbage data.

    Correctly set have_stx to false when resetting the packet state.

> diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
> index 51b1cdc226e65..55e5599cf5107 100644
> --- a/drivers/input/misc/ims-pcu.c
> +++ b/drivers/input/misc/ims-pcu.c
> @@ -440,7 +440,7 @@ static void ims_pcu_handle_response(struct ims_pcu *p=
cu)
> =20
>  static void ims_pcu_reset_packet(struct ims_pcu *pcu)
>  {
> -	pcu->have_stx =3D true;
> +	pcu->have_stx =3D false;
>  	pcu->have_dle =3D false;
>  	pcu->read_pos =3D 0;
>  	pcu->check_sum =3D 0;

[Severity: High]
This is a pre-existing issue, but I noticed a potential DMA API violation in
the ims_pcu_buffers_free() function.

Looking at drivers/input/misc/ims-pcu.c:ims_pcu_buffers_free():

static void ims_pcu_buffers_free(struct ims_pcu *pcu)
{
	usb_kill_urb(pcu->urb_in);
	usb_free_urb(pcu->urb_in);

	usb_free_coherent(pcu->udev, pcu->max_out_size,
			  pcu->urb_in_buf, pcu->read_dma);

Should this use pcu->max_in_size instead of pcu->max_out_size when
freeing pcu->urb_in_buf? Using the incorrect length could cause memory
leaks or memory corruption within the DMA allocator.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523050634.5015=
09-1-dmitry.torokhov@gmail.com?part=3D7
