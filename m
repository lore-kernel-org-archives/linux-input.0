Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C923AD50B;
	Wed,  7 Oct 2026 05:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791352723; cv=none; b=GBsxCL+zVcq1674yB6jWralS9hMV9CqnSDVmfBbTiwzEMAOKu1udyqISwxs6kQ/fR1+y1qU0Ws11+MSR88vm63jf0yHtj2YgLfgOCUzamT3E9kPdlhnzg21Xrch7ua+S1wAZyR/tcB6RnZ9ZperuKdxGc3t7wNsfpDVuRbi8Lho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791352723; c=relaxed/simple;
	bh=SPUWE9vnQcSJyDbuuxDItlr6ORGIu3vRoIOqhgyJqyg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=XxmgMgtpRXuKUht0mitAGGF9Tgv0Kjd81sE2iEUmYRsidlFaMBV76zZ5y7i4tnCSQQ7bBtARQwukZ1bJDqPVXX+2qyobNDzs1hNMJuSXH9aU7VXMC3cpN3JIH1Pgn2tGVCfX+nircynmqutLEfj/EBmO0HViyHzqx7bApbVnUnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7+h4A6E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7+h4A6E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C4D1F0089B;
	Wed,  7 Oct 2026 05:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791352721;
	bh=6xmygw6JGow+wZfs15RIuuQx1nmInn5IAZfaG2lA8rI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m7+h4A6E7k6J5oKTEV4q1WiuxspgbXKGj2k0NimzqUSCRj4nyTNsx8UG0onJqik0t
	 DPlVohFuoaHh8VcRfgQzgSY9ZJNDfa+8oJQ40nCEGZWi7JKkvlBNpMggyXaCzyZ3kW
	 iwVPJzwFX3wrtowD4HHTCrMNn1JPXcn6JgudrCNUSPhrYOChc2cazHWvP1Y8s57cWb
	 rZNjy2/kWxnHV6952E9TSHRu+2E0ZztBjTBLRbV3fdVPzh22MJK1jo9j3sUUHlu/iT
	 Voc0m1SFKCxRDURiFD+d0/PyND5HloqMlEkhAVu6fFNfgUKtDPFzUoTgXoa6lJ2h6q
	 2eI4hAKAAzO5w==
Message-ID: <sashiko-outbox-162655@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFT PATCH] Input: sur40 - fix DMA handling in video capture
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, media-ci@linuxtv.org, dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org
In-Reply-To: <20261007054430.40155-1-kmehltretter@gmail.com>
References: <20261007054430.40155-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 05:58:41 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] media: use-after-free of sur40 state on disconnect when V4L2 fd is=
 open
- [Medium] usb: invalid GFP flags (0) passed to usb_sg_init in sleepable co=
ntext
--

commit f65bffa4ada0f7963abf3d4813cdc5924218586d
Author: Karl Mehltretter <kmehltretter@gmail.com>

Input: sur40 - fix DMA handling in video capture

This commit fixes video capture failures by transitioning from vb2_dma_sg to
vb2_vmalloc. It receives each frame into a driver-owned, page-backed
scatterlist and copies it through the vb2 mapping, while synchronizing
CPU writes to imported dma-bufs.

> diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscree=
n/sur40.c
> index 09d8c5f8d09fc..72e3f0fa1f4cb 100644
> --- a/drivers/input/touchscreen/sur40.c
> +++ b/drivers/input/touchscreen/sur40.c
[ ... ]
> @@ -579,11 +584,17 @@ static void sur40_process_video(struct sur40_state =
*sur40)
> =20
>  	dev_dbg(sur40->dev, "header acquired\n");
> =20
> -	sgt =3D vb2_dma_sg_plane_desc(&new_buf->vb.vb2_buf, 0);
> +	vaddr =3D vb2_plane_vaddr(&new_buf->vb.vb2_buf, 0);
> +	if (!vaddr)
> +		goto err_poll;
> =20
> +	/*
> +	 * vb2_plane_vaddr() may return a vmalloc or vmap address. Receive
> +	 * into page-backed memory so the USB core can map it for DMA.
> +	 */
>  	result =3D usb_sg_init(&sgr, sur40->usbdev,
>  		usb_rcvbulkpipe(sur40->usbdev, VIDEO_ENDPOINT), 0,
> -		sgt->sgl, sgt->nents, sur40->pix_fmt.sizeimage, 0);
> +		sur40->video_sgl, sur40->video_nents, size, 0);

[Severity: Medium]
Is it correct to pass 0 as the mem_flags argument to usb_sg_init() here?

Passing 0 implies no reclaim and no wait (equivalent to GFP_NOWAIT), which
restricts usb_alloc_urb() and internal kmalloc operations. This can increase
the probability of spurious -ENOMEM failures under memory pressure.

Since sur40_process_video() executes inside the input poller worker thread
(sur40_poll) which runs in process context and is allowed to sleep (it alre=
ady
calls usb_bulk_msg() and usb_sg_wait()), shouldn't this use GFP_KERNEL inst=
ead?

[ ... ]
> @@ -831,6 +883,7 @@ static void sur40_disconnect(struct usb_interface *in=
terface)
>  	video_unregister_device(&sur40->vdev);
>  	v4l2_device_unregister(&sur40->v4l2);
> =20
> +	sgl_free(sur40->video_sgl);
>  	kfree(sur40->bulk_in_buffer);
>  	kfree(sur40);

[Severity: High]
Could freeing the sur40 structure unconditionally here lead to a use-after-=
free
if userspace holds the V4L2 file descriptor open during device unplug?

When the application later closes the file, the V4L2 core invokes
vb2_fop_release(), which dereferences vdev->queue and attempts to acquire
vdev->queue->lock. Because vdev is embedded in the freed sur40 structure,
this results in a direct use-after-free.

While the commit message acknowledges this bug and defers to a pending patch
series for the disconnect fixes, the current patch adds new cleanup to this
vulnerable path. The referenced series is absent from the provided tree,
leaving the vulnerability exposed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007054430.4015=
5-1-kmehltretter@gmail.com?part=3D1
