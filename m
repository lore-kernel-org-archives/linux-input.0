Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F011399348
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126151; cv=none; b=aQqpSs8R9z2hcus5RE+YCVw4EVhLgtuNOqIm3MMRH1mTL7i2nfI2ZneJMM5GKcdsJSlcXYXJvhALDMqD56yd4vw/5IU0WGuLNLgpHiVwksgDZ0MXYjuENkh3B7qqkxzhVYU7bFbhYPLrghwusLMhmeiAnuJMcKp7JfUTlh4EyLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126151; c=relaxed/simple;
	bh=Yrny+7eTJkje7B3wW5Tc9cyei2qRC3wo3Po0qKtAEqQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QKIOr9x77QHf8CyPjWR9N+aEYxDgMVGe43OyjcGTMQtpZw8pySX8dkXK5zjVIlF26xNJQm6mJdlaJrNWCpwrfWt83yZHXtgyg3fpnMVgT6MDfmVeZ9gsXFZSeUTZn7C4rk9ERfxj5hZV0ugGrY+4MREb+jlmusfBl0MDAnXj9LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=It7cDDWC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="It7cDDWC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1861F000E9;
	Wed, 15 Jul 2026 14:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784126149;
	bh=lc6AxRyAMa9dM11QZwKcmfBxDol/8glahUEOmRyVIYw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=It7cDDWC6m0AEmXUsxOqtJrRpbmRSMZ5qChOsTqCeCDoDCVWwE6EMKQVerfc37OhW
	 tCGxDAKzkWi+ml/MrjvEW8243ze/n6ZoWO4wntp8uHiQIYoG3+KCIQ/GEaIesSrzML
	 TgBPKmX9bE0lKHluz/kPRBEr1L5g6FRHW5IL0KMMQ8OTp4c0s7h7DHUvsniTo85EX1
	 Cxdiw6aMrPJSb39aXpVRKQqmcmV1VMBucjIZEypmYoT6Pwxb7ooFJ91aeo7MMppbsz
	 RiFrIceR8ykz+tLhlORtVce0iX28lEdOxwmkNNay5TWlAh0lAomkI+kNWVqfD1WIEJ
	 pm4DUQ1DKmBaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] virtio_input: validate device-reported multitouch
 slot count
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hari Mishal" <harimishal1@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260715142337.22811-3-harimishal1@gmail.com>
References: <20260715142337.22811-1-harimishal1@gmail.com>
 <20260715142337.22811-3-harimishal1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 14:35:49 +0000
Message-Id: <20260715143549.9A1861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent execution of virtqueue interrupts during device teardow=
n causes a use-after-free of the input device.
- [High] If `input_register_device()` fails, the driver deletes virtqueues =
without first resetting the virtio device, violating the virtio specificati=
on.
- [Medium] The driver fails to detach unused buffers from the `vi->evt` que=
ue before deleting the virtqueues, leading to leaked DMA mappings.
- [Medium] Missing null-termination for `vi->name` and `vi->serial` strings=
 copied from the host.
--

--- Patch [2]: [PATCH 2/4] virtio_input: validate device-reported multitouc=
h slot count ---
commit 2551acf6fb14e59620dd29579313834ccc291ba0
Author: Hari Mishal <harimishal1@gmail.com>

virtio_input: validate device-reported multitouch slot count

The commit adds validation for the nslots value derived from the
device-reported ABS_MT_SLOT maximum. It prevents registering a
multitouch device with zero backing slots by rejecting non-positive
slot counts before calling input_mt_init_slots().

> diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
> index deec24e8e6828..2cc19782cdd33 100644
> --- a/drivers/virtio/virtio_input.c
> +++ b/drivers/virtio/virtio_input.c
> @@ -312,6 +312,10 @@ static int virtinput_probe(struct virtio_device *vde=
v)
> =20
>  		if (test_bit(ABS_MT_SLOT, vi->idev->absbit)) {
>  			nslots =3D input_abs_get_max(vi->idev, ABS_MT_SLOT) + 1;
> +			if (nslots <=3D 0) {
> +				err =3D -EINVAL;
> +				goto err_mt_init_slots;
> +			}
>  			err =3D input_mt_init_slots(vi->idev, nslots, 0);
>  			if (err)
>  				goto err_mt_init_slots;

[Severity: High]
This is a pre-existing issue, but can concurrent execution of virtqueue
interrupts during device teardown cause a use-after-free of the input devic=
e?

Looking at virtinput_remove(), the teardown unregisters the input device
before stopping the hardware and synchronizing interrupts:

drivers/virtio/virtio_input.c:virtinput_remove() {
    ...
    input_unregister_device(vi->idev);
    virtio_reset_device(vdev);
    ...
}

If virtinput_recv_events() runs concurrently with virtinput_remove(), the
interrupt handler temporarily drops vi->lock and calls input_event(vi->idev=
).

Meanwhile, virtinput_remove() can free vi->idev if there are no active user=
s,
since it doesn't call virtio_reset_device() or del_vqs() until after
unregistering the input device.

[Severity: High]
This is a pre-existing issue, but does the error path in virtinput_probe()
violate the virtio specification by deleting virtqueues without resetting
an active device?

During virtinput_probe(), the device is marked ready and activated:

drivers/virtio/virtio_input.c:virtinput_probe() {
    ...
    virtio_device_ready(vdev);
    vi->ready =3D true;
    err =3D input_register_device(vi->idev);
    if (err)
        goto err_input_register;
    ...
}

If input_register_device() fails, the code jumps to the error path and dele=
tes
the virtqueues without first calling virtio_reset_device():

drivers/virtio/virtio_input.c:virtinput_probe() {
    ...
err_input_register:
    spin_lock_irqsave(&vi->lock, flags);
    vi->ready =3D false;
    spin_unlock_irqrestore(&vi->lock, flags);
err_mt_init_slots:
    input_free_device(vi->idev);
err_input_alloc:
    vdev->config->del_vqs(vdev);
    ...
}

Could this lead to memory corruption or host crashes due to DMA into
freed queues?

[Severity: Medium]
This is a pre-existing issue, but does the driver leak DMA mappings for the
vi->evt queue during teardown?

In virtinput_remove() and virtinput_freeze(), the driver detaches and frees
buffers from the vi->sts queue, but ignores the vi->evt queue:

drivers/virtio/virtio_input.c:virtinput_remove() {
    ...
    while ((buf =3D virtqueue_detach_unused_buf(vi->sts)) !=3D NULL)
        kfree(buf);
    vdev->config->del_vqs(vdev);
    ...
}

The buffers in vi->evt were mapped for DMA when queued in virtinput_fill_ev=
t().

Could deleting the virtqueues without detaching these unused buffers leave
their DMA mappings active indefinitely?

[Severity: Medium]
This is a pre-existing issue, but does the device name copy lack
null-termination if the host provides a full-length string?

In virtinput_probe(), the host-provided string is copied into the fixed-size
vi->name array:

drivers/virtio/virtio_input.c:virtinput_probe() {
    ...
    size =3D virtinput_cfg_select(vi, VIRTIO_INPUT_CFG_ID_NAME, 0);
    virtio_cread_bytes(vi->vdev, offsetof(struct virtio_input_config,
                                          u.string),
                       vi->name, min(size, sizeof(vi->name)));
    ...
}

If the host provides exactly 64 bytes of non-null characters, vi->name will
not be null-terminated.

Since this string is passed to vi->idev->name, could a subsequent sysfs read
of the device name read past the array boundary?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715142337.2281=
1-1-harimishal1@gmail.com?part=3D2
