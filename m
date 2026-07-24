Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB553D954D
	for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 09:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784885842; cv=none; b=TP8YMPe6nwmXykjpNqexXC78OmmX78CSW1/23YpfwKj0m3j0aSk8FTKkRVBT4KW6TWlex4uxDgfhNPP+aMHu5NkzDqtNMdo/lctxME1Ib1HMxAWGoVanoA+r6QdXDrERXexEhFA9vwyc1Upx2wQqPHa+erQyL36QODh80ebwd0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784885842; c=relaxed/simple;
	bh=uH3d5t4LCH02lLsYIqJpXg88PWrSRKA3Ys8NP2ijP78=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VhXc9vbxyXuIz1hfHx3GBy0HOi+SHUbkSL7KwfJ4aKuJv/XIBOCJNUQaVX5ItuHhl1212Sz0DruhB7b/X9s66N4StyneL22roFvLE197VJP/LmzWVkVXrJ2aX9nTzLxG4gHzDL70+Kp7jXNwjicPzX5W5z3Eu9tk6W89+ul/nrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyyLPZj5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyyLPZj5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7EB1F000E9;
	Fri, 24 Jul 2026 09:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784885840;
	bh=S4b8wtwZhBVdf8WXSBTqNCtjSO0j6Lo8xstSoP6RnUQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YyyLPZj5JpqgTWobMdP5doc/1TvIFchxqkt7dumVRUD2uyObihHWfdqFWEqI+GKRf
	 2XKNi8MdxhTqlLIe+ce1quaKbA5swjkWY8QTXsb+mFwSQEbZs5Fh2S+nzna5A/MNhk
	 bXiSJiRBQ8aGHBzXys8g26ewWpZ5Rvk2r7+V0m7nHEaHLZrgw3Mnl2O/7epazQflMS
	 VLuAJUVwoRqhbz0QHemSgFIAGhGgfEu6bopIBhfZ9RwD/S5TBu7hw7t1Mb9rZlA8IO
	 +EqMZLdydRIRtqYHrjmy8Dc1XipzAyXuoRpKfqrFYHk9s3zlLNzl3jvUfq7KsnyCRH
	 t/PPEXutG8TxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: corsair: fix use-after-free by reordering remove
 sequence
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Changcheng" <chenchangcheng@kylinos.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260724091906.240588-1-chenchangcheng@kylinos.cn>
References: <20260724091906.240588-1-chenchangcheng@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 09:37:20 +0000
Message-Id: <20260724093720.8A7EB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing Use-After-Free race condition in k90_record_led_work =
and k90_backlight_work.
--

--- Patch [1]: [PATCH] HID: corsair: fix use-after-free by reordering remov=
e sequence ---
commit 79119529f5e0e6e15e9750d9ceb51ce25886fb73
Author: Chen Changcheng <chenchangcheng@kylinos.cn>
Subject: HID: corsair: fix use-after-free by reordering remove sequence

This commit fixes a use-after-free in the corsair driver during device
removal. It reorders the remove sequence to call hid_hw_stop() before
freeing structures, preventing concurrent USB events from accessing freed
memory. It also sets drvdata->k90 to NULL after freeing it as a defensive
measure.

> diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
> index 21cd8b12a7572..ac12877a6db7b 100644
> --- a/drivers/hid/hid-corsair.c
> +++ b/drivers/hid/hid-corsair.c

[ ... ]

> @@ -596,10 +597,10 @@ static int corsair_probe(struct hid_device *dev, co=
nst struct hid_device_id *id)
> =20
>  static void corsair_remove(struct hid_device *dev)
>  {
> +	hid_hw_stop(dev);
> +
>  	k90_cleanup_macro_functions(dev);
>  	k90_cleanup_backlight(dev);

[Severity: High]
This is a pre-existing issue, but is there a use-after-free race between
these cleanup functions and the LED worker threads?

If a user modifies the LED brightness via sysfs, it schedules
k90_backlight_work() or k90_record_led_work(). If the device is unplugged
concurrently, they can race:

CPU1 (Worker)
k90_backlight_work() {
    if (led->removed)
        return;
    <preempted>

CPU2 (Remove)
corsair_remove() {
    k90_cleanup_backlight() {
        drvdata->backlight->removed =3D true;
        led_classdev_unregister(&drvdata->backlight->cdev);
        // This unregisters and can free led->cdev.dev

        cancel_work_sync(&drvdata->backlight->work);
        // Blocks waiting for CPU1
    }
}

CPU1 (Worker resumes)
    dev =3D led->cdev.dev->parent;=20
    // UAF dereferencing the freed led->cdev.dev

Would swapping the order of led_classdev_unregister() and cancel_work_sync()
in both cleanup functions prevent this memory corruption?

> -
> -	hid_hw_stop(dev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724091906.2405=
88-1-chenchangcheng@kylinos.cn?part=3D1
