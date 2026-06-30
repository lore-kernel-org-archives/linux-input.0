Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BF6288D0
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 06:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782799260; cv=none; b=T5XOfEeD+8BsVBUPMQ+DZQgGACRZNE++jQeoegJdVAJ/neyAAXk4dUOyJ1co/wigidZ3fh3YFxr0TQRALMqIqWrRAQRPjPmldcFZnOQ23jFUpaf3I9gwKyICe2MOeHYOXtYq008ppPOWLEnhVOpi/si0U0AASVNOvGMozk7hv2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782799260; c=relaxed/simple;
	bh=FtLAmcbxLKs61F7eZ1uPTbLHZ2vPoHpuK2kNh4kVWss=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MXeqh7kf5rO2NxHb2JkPoTxq4HBe/E1WhYYu2tRThpc+kBHGIGUuSfSiX46PPFYABozLL3Rw+ExO0JA6vOvB0bkkC1pJGVB1MMI0wvRrej5VroCSxSDxVExEoTAr2xTjOYnY9taDN22yWZndp1hv50k74ZCckHd3ZoFdpECcn90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gN36KrOg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gN36KrOg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7EB1F000E9;
	Tue, 30 Jun 2026 06:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782799258;
	bh=XlKvpxgpMgvvIi50OoMOblZ8QeeMXpZQp4vquTSlGxk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gN36KrOgJNUFSknLgHeMvuxm0oxzQ8Y5zu0aOD4wYS6f3D6Y60gS45PSoWdd0y+1n
	 eWeCJxJKJ7Ji7cA4BFgPf05y4a0pLb+7tQoJZ50CHQv9jS+oX0lacy2pkAhhjdZR+1
	 HiGUN9sdCqYmr5NJK7D0D6xHh1QUyoenlG9Ryh1KlqTrNDM3jCF8jsIDNVucaWSb45
	 qk5bb0fuTg6J6cYkKSNgHGyUrf7UbeEeIOrQhB3/tGYc9HmMPSlDRBzlZcJ7g4Cre0
	 6SgrSWvTjKXOIAVm4TqxUfivNmkCHGs5NfzABUhLMH1/HKcSuCiOevj2GrdZ4cv00S
	 CyMWNlbN/a1hg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: maplecontrol - set driver data before
 registering input device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <akNYib9hQFNN1fA9@google.com>
References: <akNYib9hQFNN1fA9@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 06:00:58 +0000
Message-Id: <20260630060058.8B7EB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] Dangling pointer to freed memory remains in driver data during t=
he probe error path.

Pre-existing issues:
- [Critical] Invalid pointer derivation leading to NULL pointer dereference=
 on device open.
- [High] Race condition exposing uninitialized driver data to hardware call=
backs or userspace.
- [High] Race condition during device unbind leading to a NULL pointer dere=
ference in the callback.
--

commit 32d63e0cc91d90b1d5a10a7764828de58888a240
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: maplecontrol - set driver data before registering input device

This commit modifies the maplecontrol driver to set the driver data before
calling input_register_device(). This ensures that the driver data is
available immediately if the device is opened and the callback is triggered.

> diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joysti=
ck/maplecontrol.c
> index 7f36f73844a91..6293b6e8148b3 100644
> --- a/drivers/input/joystick/maplecontrol.c
> +++ b/drivers/input/joystick/maplecontrol.c
> @@ -146,7 +148,6 @@ static int probe_maple_controller(struct device *dev)
>  		goto fail;
> =20
>  	mdev->driver =3D mdrv;
> -	maple_set_drvdata(mdev, pad);
> =20
>  	return 0;

[Severity: Medium]
Since maple_set_drvdata(mdev, pad) was moved before input_register_device(),
does this leave a dangling pointer to freed memory in the error path?

If input_register_device() fails, it jumps to the fail block:

fail:
        input_free_device(idev);
        kfree(pad);
        maple_set_drvdata(mdev, NULL);
        return error;

This executes kfree(pad) before maple_set_drvdata(mdev, NULL), temporarily
leaving a dangling pointer in driver core structures. Should the order be
updated to clear the driver data before freeing pad?

[Severity: High]
This isn't a bug introduced by this patch, but does device removal race with
the maple DMA workqueue leading to a NULL pointer dereference?

When unbinding the device, remove_maple_controller() clears mdev->callback:

drivers/input/joystick/maplecontrol.c:remove_maple_controller() {
    ...
    mdev->callback =3D NULL;
    input_unregister_device(pad->dev);
    maple_set_drvdata(mdev, NULL);
    kfree(pad);
    ...
}

If the device is still open, input_unregister_device() synchronously invokes
dc_pad_close(), which inadvertently overwrites mdev->callback back to
dc_pad_callback:

drivers/input/joystick/maplecontrol.c:dc_pad_close() {
    ...
    maple_getcond_callback(pad->mdev, dc_pad_callback, 0, MAPLE_FUNC_CONTRO=
LLER);
    ...
}

The driver then executes maple_set_drvdata(mdev, NULL) and frees memory. A
pending maple DMA response running in the workqueue can then trigger
dc_pad_callback(), which fetches the now-NULL drvdata:

drivers/input/joystick/maplecontrol.c:dc_pad_callback() {
    ...
    struct dc_pad *pad =3D maple_get_drvdata(mapledev);
    struct input_dev *dev =3D pad->dev;
    ...
}

Could this result in dereferencing pad->dev and crashing the kernel if
triggered by unbinding the device while it is actively opened by local
userspace?

[Severity: High]
This is a pre-existing issue, but is there a race condition exposing
uninitialized driver data to hardware callbacks or userspace in other maple
drivers?

In drivers/input/keyboard/maple_keyb.c:probe_maple_kbd():

    maple_getcond_callback(mdev, dc_kbd_callback, HZ/50, MAPLE_FUNC_KEYBOAR=
D);
    mdev->driver =3D mdrv;
    maple_set_drvdata(mdev, kbd);

The callback is armed before the driver data is initialized, allowing the
interrupt handler to run and read a NULL pointer.

Similarly, in drivers/input/mouse/maplemouse.c:probe_maple_mouse():

    error =3D input_register_device(input_dev);
    if (error)
            goto fail_register;

    mdev->driver =3D mdrv;
    maple_set_drvdata(mdev, mse);

Driver data for the mouse is set after device registration. If the hardware
callback fires immediately or userspace opens the device concurrently,
maple_get_drvdata() will return NULL and the callback could dereference it.

[Severity: Critical]
This is a pre-existing issue, but can this lead to a NULL pointer dereferen=
ce
on device open?

Looking at dc_mouse_open() in drivers/input/mouse/maplemouse.c:

    struct dc_mouse *mse =3D maple_get_drvdata(to_maple_dev(&dev->dev));
    maple_getcond_callback(mse->mdev, dc_mouse_callback, HZ/50, MAPLE_FUNC_=
MOUSE);

The to_maple_dev macro uses container_of to subtract the offset of dev in
struct maple_device, and maple_get_drvdata immediately adds the offset back
via &mdev->dev. This mathematical cancellation means it effectively calls
dev_get_drvdata(&input_dev->dev).

However, the driver data was actually stored in the maple device (&mdev->de=
v),
not the input device. Thus, dev_get_drvdata returns NULL, and the subsequent
dereference of mse->mdev results in a direct NULL pointer dereference.

The same issue appears in drivers/input/mouse/maplemouse.c:dc_mouse_close():

    struct dc_mouse *mse =3D maple_get_drvdata(to_maple_dev(&dev->dev));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/akNYib9hQFNN1fA9@go=
ogle.com?part=3D1
