Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78E03BB130
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 05:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451917; cv=none; b=FIHoAvk9mBFbrx2NiGrEqY0Cd3Wh22hLMOvLjlCPIHe5zBMVCjmUApnLWt0IHjFWWdqY5SODpLONndaRKKjZPKsooGnigBfdk3pxY/nRtmwbRIiiEggJK+2gs33Egt6dzUSjFSkzEsbxzGcba+RSSJDH40Id95K+gnZTxN4gdw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451917; c=relaxed/simple;
	bh=O5OFI+51cBMkbkTQPlBtJhCOLTTvk+fMwyQiuuryYR4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SlfDb/Awj1BED06zJfb7xO3E4vs3twGA2oM4i+URyTlUKMV1YS+ObtOhxJ5/3zjCTJ1szCfbU1aEWSYgx3AGnqlEUB6yWA//+F/J5E1U8bzIIXp1AFh0XoDrpGHzM4xYR3ZOCG28+rC8GS/WVxfEfbaBoJSxd3KQvbLCowdoQdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqzDizq4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqzDizq4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71641F000E9;
	Fri, 26 Jun 2026 05:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782451910;
	bh=8nYcll7ri5u/YgFS1KX/6rs/X2fnng8PR/TENVVu/kU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AqzDizq4+jFguWSNxsbopoAzTeGMYBlq0Hbvkn1ej+DSENFBTf9fSQwwknp+WHFpa
	 ncrST/MqngMdDWVfZc/Vc5OKN7Y+EDMVstautYT6ffUKTYFdAS5lIVm0Dq/UdrLIIj
	 zMd4k4nyOMxbCY/4yoUf2iWwn+X9IT5jTG9n4YHo64tOE9iXminQ0Zf7eDtApdfGIn
	 XK492ZG7RkznfpAY9M6MFBnnxr8ptm/bsSqky0TPXVIQA/xBUAa7yf7xwx7rEyVw7O
	 oLrN/QKnLq3PlcTDnzBNr9iUq+HMwtz9ljgmeAu9JHJ3Q7f6J809YQZtDg8scs6383
	 G8Cc4mByxyChg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/10] Input: synaptics-rmi4 - check V4L2 buffer size in
 F54 queue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260626051802.4033172-7-dmitry.torokhov@gmail.com>
References: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
 <20260626051802.4033172-7-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 05:31:49 +0000
Message-Id: <20260626053149.A71641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The driver embeds V4L2 structures (`video_device`, `vb2_queue`=
, `mutex`) within `struct f54_data` allocated using `devm_kzalloc()`, leadi=
ng to a use-after-free when the device is unbound while file descriptors re=
main open.
--

commit 5a88e74ace3829801abe168bf6f2a7e65b6ad4b8
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: synaptics-rmi4 - check V4L2 buffer size in F54 queue

Add a safety check in rmi_f54_buffer_queue() to ensure that the requested
report size (f54->report_size) does not exceed the actual allocated size of
the V4L2 buffer (vb2_plane_size()). This provides a defense-in-depth
measure against any potential size mismatches between the V4L2 queue and
the driver's internal state.

[Severity: Critical]
This is a pre-existing issue, but does the driver have a use-after-free
in the V4L2 device unbind path?

In drivers/input/rmi4/rmi_f54.c:rmi_f54_probe(), f54_data is allocated
using devm:

    f54 =3D devm_kzalloc(&fn->dev, sizeof(struct f54_data), GFP_KERNEL);

And in rmi_f54_remove():

    video_unregister_device(&f54->vdev);

When the device is unbound while a user holds the V4L2 file descriptor
open, devres will immediately free f54_data after rmi_f54_remove()
returns. However, the V4L2 core retains a reference to the embedded
video_device for the open file descriptor.

Additionally, vb2_queue_release() is never called, leaving active V4L2
waitqueues pointing to the freed memory.

Can subsequent operations on the open file descriptor dereference the
freed f54->vdev, f54->lock, or f54->queue?

> diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
> index c86bc81845bb1..93526feea5636 100644
> --- a/drivers/input/rmi4/rmi_f54.c
> +++ b/drivers/input/rmi4/rmi_f54.c
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626051802.4033=
172-1-dmitry.torokhov@gmail.com?part=3D7
