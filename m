Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AE82F290A
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 06:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783145576; cv=none; b=V5G6djnQmLo09BgbrmyQQrHSiiZChgzU1W9xvqxe6EgYiXPUxZjXD7TbKRLcauqbIPyco6Dk/ZWKFR6pImo4Nz0khhJU1kqlXQVP233yqEBAYVUuij79Pc9wxaZ5vVb8rT9uEXYLv8At2lqjmHrYb0AQJQEflwO+uE18FXqPBVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783145576; c=relaxed/simple;
	bh=v3F/rLfontODdWGile3JJIU/M4PEnAG1l7hxYgriB/c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r+vwVWVXcUVCrMsAyXBr/NE2slVy89akiydgveVp9chUv4npsMBFgMJ+tPX1tFb5rh7lFO5KkMmR7o8pIzidnCS8bqcu+dFYq1iuYrZt+5hwkTcQYjs8vSbI8gEMS7weXzTfgkrO/BiszGE/W5p2y20x9X2Hu2Ws5d3Ybp/nf/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efbX0/58; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efbX0/58"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDA71F000E9;
	Sat,  4 Jul 2026 06:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783145574;
	bh=7mOi30NmrHCu0XAZP8qDd4T+ajpeEqFT+XM2JeUO6AU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=efbX0/58P3Zdf7hZd5EoSQkaOtzqbNH9s3Tqme/Y6OPwCtBSKPRn1e5zTJ3QT437e
	 VlOYPOaIimZ2zHP1mApn4AI9M5Ul4iRqLAxwxkI8f1h//UAxWbuAKpEfillTgmL5dT
	 tLFW++7nlMihvOjOJz/7V8q5kI1WxytIItwKL2xoXzShpF9yFJuKEyIA4JsX1c1asH
	 1fS1x6D1+xHN6CdcCScTpYXXeAsk+J6UOaydoGx8/gGRgsISDvUz8ttRnBctjivMy6
	 YvWPYuD8vRs39joLsaeET+YGamngNvMYxLM04tDwX1mN09KIFk/bJfpKK0zgfUbEJ8
	 +HFLipY9d/Otw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 17/26] sh: maple: implement bus-level probe/remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260703-b4-maple-cleanup-v1-17-41e424964da5@gmail.com>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
 <20260703-b4-maple-cleanup-v1-17-41e424964da5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 06:12:54 +0000
Message-Id: <20260704061254.9FDA71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Dangling function pointers in maple_device leading to execution of=
 unloaded module code on hot-unplug.
- [High] Missing `cancel_work_sync()` in `maple_bus_init` error path leads =
to Use-After-Free.
- [High] Dangling hardware callback in `vmu_connect` error path leads to Us=
e-After-Free.
- [High] NULL pointer dereference and multiple memory leaks in `vmu_disconn=
ect`.
- [High] The driver reports input events but fails to call `input_sync()` a=
t the end of the packet handling.
- [Medium] Memory leak of `card->mtd` array on failure path in `vmu_connect=
`.
--

commit 8d15bc5545d93a9d1f9f85e0e543bc57384c73cb
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

sh: maple: implement bus-level probe/remove
   =20
Implement probe() and remove() methods for the maple bus, and update
struct maple_driver to have its own probe() and remove() members that
take struct maple_device * directly. Adjust all maple drivers to
use these new bus-level methods.

> diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joysti=
ck/maplecontrol.c
> index 955e01bcfa0c1..6864243b0b4a2 100644
> --- a/drivers/input/joystick/maplecontrol.c
> +++ b/drivers/input/joystick/maplecontrol.c
> @@ -78,7 +78,7 @@ static void dc_pad_close(struct input_dev *dev)
>  }
> =20
>  /* allow the controller to be used */
> -static int probe_maple_controller(struct device *dev)
> +static int probe_maple_controller(struct maple_device *mdev)
>  {

[Severity: High]
This is a pre-existing issue, but does dc_pad_callback() fail to call
input_sync() after reporting events?

drivers/input/joystick/maplecontrol.c:dc_pad_callback() {
    ...
    input_report_abs(dev, ABS_RY,     res[15]);
}

The driver reports input events but never calls input_sync() at the end of =
the
packet handling. As dictated by the Input Subsystem guidelines, every logic=
al
group of events must be followed by a call to input_sync(), otherwise events
may not be properly synchronized and delivered to userspace.

[ ... ]
> diff --git a/drivers/mtd/maps/vmu-flash.c b/drivers/mtd/maps/vmu-flash.c
> index 8f7028ac1b56a..c34c768dfb876 100644
> --- a/drivers/mtd/maps/vmu-flash.c
> +++ b/drivers/mtd/maps/vmu-flash.c
> @@ -769,30 +769,25 @@ static void vmu_file_error(struct maple_device *mde=
v, void *recvbuf)
>  }
> =20
> =20
> -static int probe_maple_vmu(struct device *dev)
> +static int probe_maple_vmu(struct maple_device *mdev)
>  {
> -	struct maple_device *mdev =3D to_maple_dev(dev);
> -
>  	mdev->can_unload =3D vmu_can_unload;
>  	mdev->fileerr_handler =3D vmu_file_error;
> =20

[Severity: High]
This is a pre-existing issue, but does this leave dangling function pointers
during device hot-unplug?

mdev->can_unload and mdev->fileerr_handler are set here, but remove_maple_v=
mu()
never clears them. If the module is unbound and unloaded, and the device is
subsequently physically unplugged, maple_response_none() will call the dang=
ling
mdev->can_unload(mdev). This would jump to unmapped memory and cause a kern=
el
panic.

>  	return vmu_connect(mdev);
>  }

[Severity: Medium]
This is a pre-existing issue, but does vmu_connect() leak the card->mtd arr=
ay
on the packet addition failure path?

When maple_add_packet() fails, the code jumps to fail_mtd_info:

drivers/mtd/maps/vmu-flash.c:vmu_connect() {
    ...
fail_device_busy:
    kfree(card->mtd);
fail_mtd_info:
    kfree(card->parts);
    ...
}

This bypasses the kfree(card->mtd) cleanup block, causing a memory leak.

[Severity: High]
This is a pre-existing issue, but does vmu_connect() leave a dangling callb=
ack
if it fails?

drivers/mtd/maps/vmu-flash.c:vmu_connect() {
    ...
    maple_getcond_callback(mdev, vmu_queryblocks, 0, MAPLE_FUNC_MEMCARD);
    ...
}

If vmu_connect() returns an error (like device busy or maple_add_packet fai=
lure),
it frees the 'card' structure but doesn't clear mdev->callback. If the maple
bus receives a MAPLE_RESPONSE_DATATRF, will the core unconditionally execut=
e the
callback and attempt to use the freed 'card' structure?

> -static int remove_maple_vmu(struct device *dev)
> +static void remove_maple_vmu(struct maple_device *mdev)
>  {
> -	struct maple_device *mdev =3D to_maple_dev(dev);
> -
>  	vmu_disconnect(mdev);
> -	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but can vmu_disconnect() trigger a NULL point=
er
dereference?

drivers/mtd/maps/vmu-flash.c:vmu_disconnect() {
    ...
    for (x =3D 0; x < card->partitions; x++) {
        mpart =3D ((card->mtd)[x]).priv;
        mpart->mdev =3D NULL;
    ...
}

Since vmu_connect() creates card->mtd as a zeroed array, card->mtd[x].priv =
is
NULL until vmu_queryblocks() asynchronously allocates and assigns it. If the
device is disconnected before the callback completes for all partitions, wi=
ll
this blindly dereference mpart? Additionally, does this fail to free mpart,
pcache, and pcache->buffer completely, causing memory leaks on every succes=
sful
bind/unbind?

[ ... ]
> diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
> index 35aff2e57d2c8..c0715e3ace6f1 100644
> --- a/drivers/sh/maple/maple.c
> +++ b/drivers/sh/maple/maple.c
> @@ -790,7 +816,6 @@ static int __init maple_bus_init(void)
>  	if (retval)
>  		goto cleanup_device;
> =20
> -
>  	/* allocate memory for maple bus dma */
>  	retval =3D maple_get_dma_buffer();

[Severity: High]
This is a pre-existing issue, but does the error path in maple_bus_init()
fail to cancel asynchronous work, leading to a use-after-free?

drivers/sh/maple/maple.c:maple_bus_init() {
    ...
cleanup_irq:
    free_irq(HW_EVENT_MAPLE_DMA, &maple_bus);

cleanup_dma:
    free_pages((unsigned long) maple_sendbuf, MAPLE_DMA_PAGES);
    ...
}

If initialization fails after the DMA or VBLANK IRQs are registered, the er=
ror
path frees the IRQs and the maple_sendbuf memory. However, it fails to canc=
el
the asynchronous work (maple_dma_process and maple_vblank_process). If an I=
RQ
fires before free_irq(), the scheduled work will execute maple_dma_handler(=
) or
maple_vblank_handler(), which dereferences the freed maple_sendbuf memory v=
ia
maple_send().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-b4-maple-c=
leanup-v1-0-41e424964da5@gmail.com?part=3D17
