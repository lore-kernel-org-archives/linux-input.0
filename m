Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B59C393DF1
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788533612; cv=none; b=EQalnZbkM737iw00PlBFDjfz2vBSrP5DlrTK7P+uGU5X3c+73K44MrDTbfw9As38ryxqBFPSB/JqhEw5iL+boI1boj88HurS6NVTfXuQOX9CMdCzRjtemUEKbrJ6j1njozKythPXDh4LRKfomOB40CsNwdeXVXNGaSsx+zlOMhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788533612; c=relaxed/simple;
	bh=ixlUiAz5ab4Rp3gm7EoVVl7kkbscnO0wL1rkb8smwqM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LxtWjGK8DcdHWY/2HM9sycnbTB9Fe5Mzf0LKf0mfn/DbLyKXJlCgUDD+6Jv7MY36Us+mILnDsZM3dZRiAxoLoaPNHbgQBiRecIB6A+Vei0jbYbjh2owgZ7qaqFxtoYgW7ug6kVC9xovOAOqugEJWFrpqwaIpgQElY5rm2KgaXEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xa4tajcv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xa4tajcv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9E41F00A3D;
	Fri,  4 Sep 2026 14:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788533611;
	bh=uodnmZr7/Hm76iA4W8khvnkQt41khjBcpLQp4po8gkA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xa4tajcv8+ZKmLYBLU6626zwHE896ZNsTjVd7puAVO41o9ezZBmLmqJkRwcxtxbiQ
	 Zy9dkIlQHgypMm/pDVR8nwihSI2WpIq7wdcBJ3kYb3eDNiRFYJkj8rI3YZ/l3+34WZ
	 oYQPRh226MlMz90WY0O/XezT3x38GQ5os3X7KP+zhDal/7PptrgUNhdlrtqq/yWnXK
	 6oqvljbFphsfeg5shb+k4Mra2uFIfh2XtfDZLBTGluS9J5KdEnGcPNUnJqwiqRjNEH
	 B6bzTxJeUUoa3oqZvq4bXAQyCfyoyepulB2dj0ZrFbsLGDpdBQVq4/VbcyWSFAzT2w
	 PPOIteyxJNKDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: corsair: cancel worker after unregistering LED,
 not before
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danish Khateeb" <danishkhateeb03@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260904143610.119808-1-danishkhateeb03@gmail.com>
References: <20260904143610.119808-1-danishkhateeb03@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 14:53:30 +0000
Message-Id: <20260904145330.BD9E41F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Reordering `led_classdev_unregister()` before `cancel_work_sync()`=
 reintroduces a Time-of-Check to Time-of-Use (TOCTOU) Use-After-Free race c=
ondition on `led->cdev.dev` inside the worker threads.
--

commit 4df2db0ecd93b852af20dc26a815f8345bbc393a
Author: Danish Khateeb <danishkhateeb03@gmail.com>

    HID: corsair: cancel worker after unregistering LED, not before
   =20
    This commit reorders cancel_work_sync() to occur after
    led_classdev_unregister() during the device removal process. The intent=
ion
    is to prevent led_classdev_unregister() from re-arming the worker.
   =20
    Link: https://syzkaller.appspot.com/bug?extid=3Dabcedffc9201f2bb66c2

>    Cancel the worker after led_classdev_unregister() so that nothing can
>    re-arm it before the memory goes away. The removed flag is still set
>    first, so a worker already past the flag check returns without
>    dereferencing led->cdev.dev, which is what commit eb51c9f8cb4f ("HID:
>    corsair: cancel worker before unregistering LED to fix use-after-free")
>    set out to prevent.

[Severity: High]
Is this description accurate?

Looking at k90_backlight_work() and k90_record_led_work(), if a worker is
already past the flag check, it did not return. Instead, it proceeds to the
next line and dereferences led->cdev.dev:

	if (led->removed)
		return;

	dev =3D led->cdev.dev->parent;

If the worker is preempted right after evaluating the flag to false, and
led_classdev_unregister() runs concurrently freeing led->cdev.dev, won't the
worker resume and dereference the freed pointer?

> diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
> index 278c6efb565df..ac12877a6db7b 100644
> --- a/drivers/hid/hid-corsair.c
> +++ b/drivers/hid/hid-corsair.c
> @@ -524,8 +524,8 @@ static void k90_cleanup_backlight(struct hid_device *=
dev)
> =20
>  	if (drvdata->backlight) {
>  		drvdata->backlight->removed =3D true;
> -		cancel_work_sync(&drvdata->backlight->work);
>  		led_classdev_unregister(&drvdata->backlight->cdev);
> +		cancel_work_sync(&drvdata->backlight->work);

[Severity: High]
Does this reintroduce the Use-After-Free race condition?

If the worker thread k90_backlight_work() evaluates led->removed to false
and is then preempted:

drivers/hid/hid-corsair.c:k90_backlight_work() {
    ...
	if (led->removed)
		return;

    <preempted>
}

And concurrently k90_cleanup_backlight() proceeds to call
led_classdev_unregister(), which synchronously unregisters and frees the
underlying device structure.

Then cancel_work_sync() waits for the preempted worker to finish. When the
worker resumes, will it execute:

	dev =3D led->cdev.dev->parent;

and dereference the pointer that was just freed by led_classdev_unregister(=
)?

>  		kfree(drvdata->backlight->cdev.name);
>  		kfree(drvdata->backlight);
>  	}
> @@ -540,8 +540,8 @@ static void k90_cleanup_macro_functions(struct hid_de=
vice *dev)
>  		sysfs_remove_group(&dev->dev.kobj, &k90_attr_group);
> =20
>  		k90->record_led.removed =3D true;
> -		cancel_work_sync(&k90->record_led.work);
>  		led_classdev_unregister(&k90->record_led.cdev);
> +		cancel_work_sync(&k90->record_led.work);

[Severity: High]
Does this suffer from the same Time-of-Check to Time-of-Use race condition
for k90_record_led_work()?

>  		kfree(k90->record_led.cdev.name);
> =20
>  		kfree(k90);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904143610.1198=
08-1-danishkhateeb03@gmail.com?part=3D1
