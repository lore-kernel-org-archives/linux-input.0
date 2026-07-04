Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C762EA154
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 06:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783145498; cv=none; b=ki9FxvtI+m0e06gPnUTRkiOeSfNS19+RIYZ/8a8NwqIVTUTfQgCrQpqsv5OU1Ynv/vXSxepEomWJulGt+njcnVXBLQU5x7MGGTF9t9c0g9V6loG0euHcyGfynrsjs875ZoB4litzkuuYdmBmoGE1+oZ/5ZMWdpaoj+Ubwi/GYcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783145498; c=relaxed/simple;
	bh=3Fjiopu3LIn0oTqFFKPdkLeph/hBOGHvjHiH9VguY+k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rH494A4cT10N3EWSGsz9pgD0pY9PMQD/MM4uByb8XSCp6ClFQt8cJ9mkPAjLiLBNIVktZTzeCF89eTguISTwS81A+CXDU9McPCDnOWEClF9cLkPJ/VlwaWNh2VXA2dNkDP7IcbfUIohJ5DQyqOrpLLvxmp91RdMHs9VR2oiVDrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBlQ8a3l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBlQ8a3l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8899C1F000E9;
	Sat,  4 Jul 2026 06:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783145496;
	bh=49yrueSkApsKPEEQnpDep04yaUL6Nj5y2MXD16RSgHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PBlQ8a3lFlYHi/WRqCZAEllnuOcTFex8E62OeiiBe0o/uXNa3vbdUAg+yFsHz04D5
	 IjgYBcweyqRphMMk3c+6MNh0f9fTfwnPi9fMgo60Ye6nPxHCypTi4rCPxyP9Qlmkes
	 ug1MLL7CkdWWNrijm98EgYduUdeMJkmhRCCrd/dxhN3+sfCN7xGnLpk2yzZcuQCccq
	 NwmS9ypIJLKsG1YcMogukPu9vGiNoCtkM8C6QgqGNE73A53pxkPhjo0KeTCESr69TD
	 HDTRQY0eW2Vx9Fn6pffrxn/zHrvxiutNr+2lqhc1/4w2wL9eJny7As8GTs7YilxGIK
	 WOSTI3JAWwf/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/26] sh: maple: remove not needed
 maple_unsupported_device driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260703-b4-maple-cleanup-v1-15-41e424964da5@gmail.com>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
 <20260703-b4-maple-cleanup-v1-15-41e424964da5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 06:11:36 +0000
Message-Id: <20260704061136.8899C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Asynchronous work items are not canceled on the `maple_bus_init` e=
rror path.
- [High] Error path in `maple_bus_init` frees devices that are still linked=
 on the global `maple_waitq`.
- [High] Directly calling `kfree` via `maple_free_dev` on `device_register`=
 failure in `maple_attach_driver` leaks kobject state.
- [High] Re-queuing a maple packet without setting the busy flag causes lis=
t corruption.
--

commit 8ed68bea570556010f84062b91e5bd48da1f0c8d
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

sh: maple: remove not needed maple_unsupported_device driver

This commit removes the maple_unsupported_device fallback driver since
the driver core handles devices without drivers. It also updates the
shared interrupt registrations to use &maple_bus instead of the removed
driver.

> diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
> --- a/drivers/sh/maple/maple.c
> +++ b/drivers/sh/maple/maple.c

[ ... ]

> @@ -378,7 +376,6 @@ static void maple_attach_driver(struct maple_device *=
mdev)
>  		if (matched =3D=3D 0) {
>  			/* Driver does not exist yet */
>  			dev_info(&mdev->dev, "no driver found\n");
> -			mdev->driver =3D &maple_unsupported_device;
>  		}
>  		dev_set_name(&mdev->dev, "%d:0%d.%lX", mdev->port,
>  			     mdev->unit, function);

[Severity: High]
This isn't a regression introduced by this patch, but does the error path in
maple_attach_driver() leak kobject state?

If device_register(&mdev->dev) fails:

	error =3D device_register(&mdev->dev);
	if (error) {
		dev_warn(&mdev->dev, "could not register device at"
			" (%d, %d), with error 0x%X\n", mdev->unit,
			mdev->port, error);
		maple_free_dev(mdev);
		mdev =3D NULL;
		return;
	}

maple_free_dev() directly calls kfree(). Since device_register() was
called, shouldn't failures be handled by calling put_device() to safely
invoke the release callback instead of bypassing it?

[ ... ]

> @@ -863,17 +851,14 @@ static int __init maple_bus_init(void)
>  	kmem_cache_destroy(maple_queue_cache);
> =20
>  cleanup_bothirqs:
> -	free_irq(HW_EVENT_VSYNC, 0);
> +	free_irq(HW_EVENT_VSYNC, &maple_bus);
> =20
>  cleanup_irq:
> -	free_irq(HW_EVENT_MAPLE_DMA, 0);
> +	free_irq(HW_EVENT_MAPLE_DMA, &maple_bus);
> =20
>  cleanup_dma:
>  	free_pages((unsigned long) maple_sendbuf, MAPLE_DMA_PAGES);

[Severity: High]
This is a pre-existing issue, but can this error path lead to a
use-after-free crash?

In maple_bus_init(), if initialization fails after setting the DMA
interrupt handler (for example, if KMEM_CACHE allocation fails), the error
path calls free_irq() and frees the maple_sendbuf memory.

However, it does not appear to call cancel_work_sync() for
maple_dma_process and maple_vblank_process. If an interrupt fired before
free_irq(), could the scheduled work items execute asynchronously after the
buffers are freed, dereferencing the freed memory?

[Severity: High]
This is another pre-existing issue in maple_bus_init(), but does the port
initialization loop leave dangling pointers on the global maple_waitq?

During the loop, each allocated device is immediately queued onto the
global maple_waitq via maple_add_packet():

	for (i =3D 0; i < MAPLE_PORTS; i++) {
		checked[i] =3D false;
		empty[i] =3D false;
		mdev[i] =3D maple_alloc_dev(i, 0);
		if (!mdev[i]) {
			while (i-- > 0)
				maple_free_dev(mdev[i]);

If a subsequent allocation fails, the error handler loops backwards and
calls maple_free_dev(). However, maple_free_dev() frees mdev and mdev->mq
directly via kfree() without executing list_del() to remove them from
maple_waitq. Could this corrupt the linked list?

[Severity: High]
This is a pre-existing issue not touched by this patch, but can re-queuing
a maple packet without setting the busy flag cause list corruption?

Looking at setup_maple_commands() in drivers/sh/maple/maple.c, a
MAPLE_COMMAND_GETCOND packet is queued if mdev->busy is 0:

	if (mdev->interval > 0 && atomic_read(&mdev->busy) =3D=3D 0 &&
		time_after(jiffies, mdev->when)) {
		/* bounce if we cannot add */
		add =3D maple_add_packet(mdev,
			be32_to_cpu(mdev->devinfo.function),
			MAPLE_COMMAND_GETCOND, 1, NULL);
		if (!add)
			mdev->when =3D jiffies + mdev->interval;
	}

It successfully calls maple_add_packet(), which links mdev->mq->list into
maple_waitq. However, unlike other packet types, it fails to set
mdev->busy =3D 1.

If a concurrent userspace action (such as a read via /dev/mtdX in vmu-flash
leading to maple_vmu_read_block()) executes, would it read mdev->busy as 0,
assume the queue is free, and call maple_add_packet() again? This would
reuse the exact same mdev->mq object, executing list_add_tail() on an
already-linked node, which corrupts the list.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-b4-maple-c=
leanup-v1-0-41e424964da5@gmail.com?part=3D15
