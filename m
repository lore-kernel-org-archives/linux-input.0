Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B8A3438B5
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 06:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779516166; cv=none; b=RNugGpBmxad/17Yjtw9S2SQ0juvEGEgmS9G2tJep3zjgIbI1OQulUJ0xnDY3SLRSx6UsGMdRIjUGGuwJNjk5zCr6N5SU6DMwnmWBjoTh9FlU0HSjl5v7FVDGHf4/9Gj1eaBXPlTC7N2Q21gQ1hkmxGbJvIlvQD6X+eHv+k/IKDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779516166; c=relaxed/simple;
	bh=K+QI2uwXpWErx1dr0Na5jK4Fdy5rSKupY9yDveI2y44=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YhXShr9ZLjJumv84D78/lA33nNZV009tbeRVSrOWL0QGdAFsM0ezweMPYj+tJOMuu1w9xxBLZnHRXtIQN/gxaK21flPN7XOvTR3FYJlQoP1EgTQlR1ZnN7omKIiahuOuGKVkDK+TbqN52oD6+7ouQ3bolCkTfpHC5xB4ayJRJSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQ5QDQR4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQ5QDQR4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A681F000E9;
	Sat, 23 May 2026 06:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779516164;
	bh=AgUl4V2fZyzqPUkTwW5Y/wIZZI5puNy/TNn7dP/ku3s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EQ5QDQR4quYJJBlzmXGUA37bsOJznUwXd76lbVF6YlOfuO+GD/XwM3MeLFpiRyEma
	 MwY6xJirT/O6im39caGvQXSc8lJ+z+ci42a9DBdjTxUooKl6A+ybfpQmiGjM65QZH+
	 D3v5zjOyuoz2C62EX5A4MWH9meyQxKNVmMDIfXtAcYkh5BnYOFy4Vg5uOQsdyN9/WD
	 DXNzLdB6LvYjUA2/4lwXCGeekPXX/THEoypeWBGVEuzFcCviItVyIF9bn2nkF3oni1
	 bsRY39Nn5ddsRXrLvl3+GCweK3/mwxnX9069hFIJpBDHlX9KVk7KL6J+aBoVGNHBNC
	 Pi0jOlM/TQPTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/11] Input: ims-pcu - fix potential infinite loop in
 CDC union descriptor parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260523050634.501509-11-dmitry.torokhov@gmail.com>
References: <20260523050634.501509-11-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 06:02:44 +0000
Message-Id: <20260523060244.83A681F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver frees `urb_in_buf` using `max_out_size` instead of the =
originally allocated size `max_in_size`, which can lead to memory corruptio=
n.
- [High] The driver fails to check if `max_ctrl_size` is zero before alloca=
ting DMA memory and submitting URBs.
--

commit 3eecab75c43789477700030b2ee3a57868b3c2d8
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: ims-pcu - fix potential infinite loop in CDC union descriptor parsing

This commit fixes a potential infinite loop in the IMS PCU driver when pars=
ing
CDC union descriptors. It adds a check to ensure the descriptor length is at
least 2, preventing issues caused by a malicious USB device returning a
zero-length descriptor.

> diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
> index 7cdf40ac42ce1..4d0c7d3e8676c 100644
> --- a/drivers/input/misc/ims-pcu.c
> +++ b/drivers/input/misc/ims-pcu.c
> @@ -1678,8 +1678,9 @@ ims_pcu_get_cdc_union_desc(struct usb_interface *in=
tf)
>  	while (buflen >=3D sizeof(*union_desc)) {
>  		union_desc =3D (struct usb_cdc_union_desc *)buf;
> =20
> -		if (union_desc->bLength > buflen) {
> -			dev_err(&intf->dev, "Too large descriptor\n");
> +		if (union_desc->bLength < 2 || union_desc->bLength > buflen) {
> +			dev_err(&intf->dev, "Invalid descriptor length: %d\n",
> +				union_desc->bLength);
>  			return NULL;
>  		}

While reviewing this, I noticed a couple of pre-existing issues nearby that
might also be triggered by a malicious USB device.

In ims_pcu_parse_cdc_data():

>	pcu->ep_ctrl =3D &alt->endpoint[0].desc;
>	if (!usb_endpoint_is_int_in(pcu->ep_ctrl)) {
>		dev_err(pcu->dev,
>			"Control endpoint is not INTERRUPT IN\n");
>		return -EINVAL;
>	}
>
>	pcu->max_ctrl_size =3D usb_endpoint_maxp(pcu->ep_ctrl);

[Severity: High]
This is a pre-existing issue, but does this code need to verify that
pcu->max_ctrl_size is greater than zero?

A malicious USB device could intentionally set the control endpoint's
wMaxPacketSize to 0. Passing a size of 0 to usb_alloc_coherent() could invo=
ke
undefined behavior in the DMA API. Additionally, submitting a zero-length
interrupt URB could cause undefined behavior in the host controller driver =
or
lead to an interrupt storm, since ims_pcu_irq() will repeatedly resubmit it.

In ims_pcu_buffers_free():

>static void ims_pcu_buffers_free(struct ims_pcu *pcu)
>{
>	usb_kill_urb(pcu->urb_in);
>	usb_free_urb(pcu->urb_in);
>
>	usb_free_coherent(pcu->udev, pcu->max_out_size,
>			  pcu->urb_in_buf, pcu->read_dma);

[Severity: High]
This isn't a bug introduced by this patch, but does this code free urb_in_b=
uf
using the wrong size?

In ims_pcu_buffers_alloc(), urb_in_buf is allocated using pcu->max_in_size,
but here it is freed using pcu->max_out_size. If a malicious device provides
descriptors where the OUT endpoint's wMaxPacketSize is significantly larger
than the IN endpoint's size, could calling usb_free_coherent() with this la=
rger
size erroneously free adjacent memory pages?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523050634.5015=
09-1-dmitry.torokhov@gmail.com?part=3D11
