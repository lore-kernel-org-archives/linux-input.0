Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C679A8287E
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 05:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779514768; cv=none; b=EXGXMobPRc0C54cGr8K2ynMVlce/zjchv4fmUJn9Q7PcOkCW/ai1nSqgpNAi2i7N4fTLZJTQnQ1821c68KK9ct5gffIHVsdXL5m1I4M0f2IK8qfflN2CAmYgdLhjD6lWuPZSMksG5i3d479imQXUePHdpgj7fvY+o6UgqQ3jCNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779514768; c=relaxed/simple;
	bh=rs3Xl3qYNxGkWQVdCPWClIpYAVXRS3VxDIpazyL/di0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jcj42FBOcSmVGDbxeW4nbetF3lPUZEvkmfDu+4Q+BfCVEbui89Eb9oXNbHlyObWm+4WV64VdNxcgHesaCJFlNMRBxXgQmo5XNcOIWv3Z/7qqZ0avy3Q6QhsP05JVx8xDEpks00ghVlhOYuyTOuSc9DloGBFSg8Ryp0YhmosEcR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrlWs5PG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrlWs5PG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FAE11F000E9;
	Sat, 23 May 2026 05:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779514767;
	bh=PAGkTN39UrduYhnlZ50eXMZd8rdPRGnbWsPNsIDgnA0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YrlWs5PGvCYtfI8EmkjsUsN33gzFlWE0T1V0Ewpi4wVKes/hxsXro61y6zYR0DD6b
	 zyPdrjUbXSIVJS9ZKrCL22wdsuLqeTr8evpayPt0M/z2Ov1r1rtpe9Apz4zrCM2Zef
	 ezvIrMTf482HVNTwSg9Yw3Wc3khowYoi+QuPAqR7Jxc9Dlj4fWJ6myRWsCaMR92Kuu
	 xzyqxIgVUA/JtpZAZlm9Pq+l6ZIZbYiQ1Wo+NLkiTSm6j/9qXdeH8vpuCjOzkVfY1G
	 fp09Ro07NLIdWzZeucK8TYdrGjmCKdbOuVuSKmV6LlIbC8OPAW1wfibsOGF4U+LgQ1
	 ngS/oW6U0jQDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/11] Input: ims-pcu - fix out-of-bounds read in
 ims_pcu_irq() debug logging
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260523050634.501509-8-dmitry.torokhov@gmail.com>
References: <20260523050634.501509-8-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 05:39:26 +0000
Message-Id: <20260523053927.3FAE11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The coherent DMA memory for the IN URB buffer is freed using the O=
UT endpoint's maximum packet size (`max_out_size`) instead of the IN endpoi=
nt's size (`max_in_size`).
--

commit 17e5a8f2368ac7dba16afa9f23358b3fa3dba6de
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: ims-pcu - fix out-of-bounds read in ims_pcu_irq() debug logging

This commit fixes an out-of-bounds read in the debug logging of
ims_pcu_irq(). It updates the dev_dbg() call to print data from the
transfer_buffer associated with the URB rather than unconditionally
using the input URB buffer.

> diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
> index 55e5599cf5107..d7a3f4c7214a0 100644
> --- a/drivers/input/misc/ims-pcu.c
> +++ b/drivers/input/misc/ims-pcu.c
> @@ -1529,7 +1529,7 @@ static void ims_pcu_irq(struct urb *urb)
>  	}
> =20
>  	dev_dbg(pcu->dev, "%s: received %d: %*ph\n", __func__,
> -		urb->actual_length, urb->actual_length, pcu->urb_in_buf);
> +		urb->actual_length, urb->actual_length, urb->transfer_buffer);
> =20
>  	if (urb =3D=3D pcu->urb_in)
>  		ims_pcu_process_data(pcu, urb);

[Severity: High]
This is a pre-existing issue, but I noticed a problem with how the memory f=
or
the IN URB buffer is managed when reviewing this driver.

Does this code pass the correct size to the DMA free function?

Looking at ims_pcu_buffers_free(), the input buffer is freed using
max_out_size instead of max_in_size:

drivers/input/misc/ims-pcu.c:ims_pcu_buffers_free() {
    ...
	usb_free_coherent(pcu->udev, pcu->max_out_size,
			  pcu->urb_in_buf, pcu->read_dma);
    ...
}

The buffer is originally allocated in ims_pcu_buffers_alloc() using
max_in_size:

drivers/input/misc/ims-pcu.c:ims_pcu_buffers_alloc() {
    ...
	pcu->urb_in_buf =3D usb_alloc_coherent(pcu->udev, pcu->max_in_size,
					     GFP_KERNEL, &pcu->read_dma);
    ...
}

Is it possible that max_in_size and max_out_size are different?

USB endpoints can have asymmetric packet sizes, so max_in_size and max_out_=
size
are not guaranteed to be identical.

Could this mismatch between the allocation size and the free size lead to D=
MA
pool corruption or memory leaks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523050634.5015=
09-1-dmitry.torokhov@gmail.com?part=3D8
