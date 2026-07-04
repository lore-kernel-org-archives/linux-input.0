Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36F433A005
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 06:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783145700; cv=none; b=kCS5mgdO3Wm29vI2ZJIi9X6a6PIC9MUOzaCNAWUenmTIZJ8OvA8d0BoEf5Ip3eLKOCdBzcfRxsHGR9peBKc7f9ihkPJmXvX6anzqcu63CYoeVAlh2uc0nq4ovdEbHJ2u/uEnQag1dvXThmIK+uwMJjEpCO+C7N0Yc/RVr74avnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783145700; c=relaxed/simple;
	bh=8uT9L0YWvE47utPUeAPzGkPepw2V6364tyXHLbLsqKs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TZ+Zj/Adf8SMH3aihM1b3ftoA+mlszRekFi0jzfDhLl6ksBRa8vnGDaWZoYsljTIixsDq3lqtufjqaprev1uoQ/q4LW3Vw6I4/ClEqHnu2wGwQt2LsPgC1B4jgdgz5JwNbr4kBp0qzI/lvlgdXesIiVIyK+LSWODDGeboz9OKWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTlwZ7Fv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTlwZ7Fv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F6C1F000E9;
	Sat,  4 Jul 2026 06:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783145699;
	bh=vF40/wYDQ6eJAUo/uNQNhm0JRBMEzoQ3QiUHAsrUK0k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oTlwZ7FvIxqeoeYPC9XgN3mzmFfrXbCQSOvI9KW1tN3RHac+5HuSgURZ49TQNDOz9
	 6U6tN0TmzZ3tbnm0LfhvFaPvmw3YgRe1mwOp55VHsjWWw3CXyW/YiAF0KRYuRMqB/L
	 px2oyeoBmfziHqKNOyKrmzSEs2mukDiySYjV+qKjihS3QWgIw1pFqNu6kdkd/red0d
	 GIqhYGBBs7fEUOHCWvLrPao48QtoHu+EcPUkTuOTlvNZ/vbFX0A0jNYhG/k26ey7F+
	 +lOECV+60YoBJDVReYZFuE2SL0xTqgp6NxS6cZ+a+PfabeWGOukpZTTR9sCML+wiUm
	 qXaLlxHL1osNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 18/26] sh: maple: introduce callback_mutex in
 maple_device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260703-b4-maple-cleanup-v1-18-41e424964da5@gmail.com>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
 <20260703-b4-maple-cleanup-v1-18-41e424964da5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 06:14:58 +0000
Message-Id: <20260704061459.68F6C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] The newly introduced callback_mutex causes a guaranteed self-d=
eadlock when enumerating vmu-flash devices.
- [Medium] The newly introduced callback_mutex is initialized dynamically b=
ut is not destroyed during the standard device release lifecycle.

Pre-existing issues:
- [High] The patch fails to prevent the Use-After-Free race condition in th=
e vmu-flash driver because vmu_disconnect bypasses the new callback_mutex.
--

commit 29c05632bf3bdcdb9087fb8230fb421ba8176ce5
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

sh: maple: introduce callback_mutex in maple_device

This commit introduces callback_mutex in struct maple_device to synchronize
callback registration and invocation. It is intended to prevent=20
use-after-free bugs if a device is removed while a callback is in flight.

> diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
> index c0715e3ace6f1..7c82b7a8a2809 100644
> --- a/drivers/sh/maple/maple.c
> +++ b/drivers/sh/maple/maple.c
> @@ -121,6 +121,7 @@ void maple_getcond_callback(struct maple_device *dev,
>  			void (*callback) (struct mapleq *mq),
>  			unsigned long interval, unsigned long function)
>  {
> +	guard(mutex)(&dev->callback_mutex);

[Severity: Critical]
Does this introduce a self-deadlock when a callback registers a new callbac=
k?

When enumerating a vmu-flash device, maple_dma_handler() acquires=20
mdev->callback_mutex and executes the callback vmu_queryblocks().=20
Inside vmu_queryblocks(), the driver calls maple_getcond_callback() to
configure the next phase.=20

Since maple_getcond_callback() unconditionally attempts to acquire the
same non-recursive mdev->callback_mutex here, won't this immediately
deadlock the maple bus workqueue?

>  	dev->callback =3D callback;
>  	dev->interval =3D interval;
>  	dev->function =3D cpu_to_be32(function);

[ ... ]

> @@ -230,11 +231,13 @@ static struct maple_device *maple_alloc_dev(int por=
t, int unit)
>  	mdev->dev.bus =3D &maple_bus_type;
>  	mdev->dev.parent =3D &maple_bus;
>  	init_waitqueue_head(&mdev->maple_wait);
> +	mutex_init(&mdev->callback_mutex);
>  	return mdev;
>  }
> =20
>  static void maple_free_dev(struct maple_device *mdev)
>  {
> +	mutex_destroy(&mdev->callback_mutex);

[Severity: Medium]
Is a corresponding mutex_destroy() needed in the standard device release=20
path?

While mutex_destroy() is added to maple_free_dev() here, if a maple device'=
s=20
reference count drops to zero after device_unregister(), the release=20
path maple_release_device() is executed.=20

Will this leave stale lockdep/RT-mutex structures behind if debugging=20
configs are enabled, since maple_release_device() does not destroy the=20
mutex before calling kfree(mdev)?

>  	kmem_cache_free(maple_queue_cache, mdev->mq->recvbuf);
>  	kfree(mdev->mq);
>  	kfree(mdev);

[ ... ]

> @@ -655,8 +658,10 @@ static void maple_dma_handler(struct work_struct *wo=
rk)
>  				break;
> =20
>  			case MAPLE_RESPONSE_DATATRF:
> -				if (mdev->callback)
> -					mdev->callback(mq);
> +				scoped_guard(mutex, &mdev->callback_mutex) {
> +					if (mdev->callback)
> +						mdev->callback(mq);
> +				}

[Severity: High]
This is a pre-existing issue, but does this actually prevent the=20
use-after-free race condition for all drivers?

If a user unbinds a vmu-flash device while a maple data transfer is=20
in-flight, vmu_disconnect() bypasses this new mutex entirely:

drivers/mtd/maps/vmu-flash.c:vmu_disconnect() {
    ...
    mdev->callback =3D NULL;
    card =3D maple_get_drvdata(mdev);
    ...
    kfree(card);
}

Since vmu_disconnect() modifies the callback and frees the private data=20
without acquiring callback_mutex, can maple_dma_handler() still=20
concurrently dereference the freed card data here?

>  				atomic_set(&mdev->busy, 0);
>  				wake_up(&mdev->maple_wait);
>  				break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-b4-maple-c=
leanup-v1-0-41e424964da5@gmail.com?part=3D18
