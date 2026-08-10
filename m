Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BF240B360
	for <linux-input@vger.kernel.org>; Mon, 10 Aug 2026 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786372103; cv=none; b=tl7L6qIUSP7lY1uusbM6qTaJt58xp5PclCcWTRduTk6D9rI6rKyMUKXEntMEbYsFydc7pfUmnKmxwH2Eb4KhFdNwSFC3HKE7GAJEbFGjwlfAeYsSA3+lTZwMeioQQE6rhK0LH4YGaYjSzLyy9YHEfvJrDE5NUNUoqAFKt5nlxJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786372103; c=relaxed/simple;
	bh=DFCtgb5kNJ3oCHvcuPJAlG4Rwh76d66sGMDCNk9u74c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FGvMMLTyKneTVzbE1gmIniMvbDOLmLzpZlFH1qDWxccmVzw9QwutYaHhAsGy22hxT9p8CGx1/zIrkxHvZxOtYvavx19hoIIWcZ8FZ1SOeIreR0RdQh/QQeVlJjMPjtUISDSNPMW92ylyPcpjZFH5QtpD7daYewK7/RPoAbP9ZeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ljj9iFE8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ljj9iFE8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454221F000E9;
	Mon, 10 Aug 2026 14:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786372098;
	bh=j3gETe9fd0kPsJUK1St3BUZoevKoatTWhzGcp+rHhkU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ljj9iFE8rf7DD3POpWANIdzH3EvMESuG6oXw3RNbY0iLm9cUoU0YdOe0mFBLpz2CS
	 gUvfvwjrOsM0EBE0gyYc3OdccaLM3RhX8Nl3ZIYVI9pyEOWJLho441LgfpO/p5j21j
	 G1OR98MEPfbcP3r5NJ+fJyh2GJU6lHbKJ9YGAcqtA8ChcLblODCvJoq9nN899euAfx
	 6LbnrVHM0PLHzNVRXSzD/hLh2Vh0/TJp264hhY+r1BV6sRzNHNMsDz2UCKAgk3OlCa
	 a8nBTrqJGfyVAIzssujmYA3UYX39Vcl663mKpyWbNmR2/yEsWfnee1dyVxpYseMnS4
	 Ka+HKs8nb8sqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] input: sur40: fix error recovery in sur40_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Antipov" <dmantipov@yandex.ru>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260810141319.118259-1-dmantipov@yandex.ru>
References: <20260810141319.118259-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 14:28:17 +0000
Message-Id: <20260810142818.454221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Calling `input_unregister_device()` on an unregistered input devic=
e during early probe failures leads to a kernel crash.
--

--- Patch [1]: [PATCH] input: sur40: fix error recovery in sur40_probe() ---
commit ae7595899669d474b491f275a114a4cdae739843
Author: Dmitry Antipov <dmantipov@yandex.ru>

input: sur40: fix error recovery in sur40_probe()

This commit modifies the error recovery path in sur40_probe() by
unregistering the input device instead of freeing it. It also ensures
that the v4l2 control handler is freed on all error paths.

Link: https://syzkaller.appspot.com/bug?extid=3D2a123f6269da57ffefaa

> diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscree=
n/sur40.c
> index 77ec2c94b91fd..9f32208b94fd7 100644
> --- a/drivers/input/touchscreen/sur40.c
> +++ b/drivers/input/touchscreen/sur40.c
[ ... ]
> @@ -806,12 +807,15 @@ static int sur40_probe(struct usb_interface *interf=
ace,
> =20
>  err_unreg_video:
>  	video_unregister_device(&sur40->vdev);
> +err_unreg_ctrl:
> +	v4l2_ctrl_handler_free(&sur40->hdl);
>  err_unreg_v4l2:
>  	v4l2_device_unregister(&sur40->v4l2);
>  err_free_buffer:
>  	kfree(sur40->bulk_in_buffer);
>  err_free_input:
> -	input_free_device(input);
> +	if (input)
> +		input_unregister_device(input);

[Severity: High]
Can this cause a kernel panic if an error occurs before
input_register_device() is called?

During sur40_probe(), if an early initialization step like
sur40_input_setup_events() or kmalloc() for sur40->bulk_in_buffer fails,
the code jumps to err_free_input. At that point, input is non-NULL but
input_register_device() has not been called yet.

Calling input_unregister_device() on an allocated but unregistered device
attempts to remove it from the sysfs hierarchy, which can lead to a NULL
pointer dereference since device_add() was never called.

>  err_free_dev:
>  	kfree(sur40);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810141319.1182=
59-1-dmantipov@yandex.ru?part=3D1
