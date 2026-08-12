Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B6A480325
	for <linux-input@vger.kernel.org>; Wed, 12 Aug 2026 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555614; cv=none; b=e5aK9EtrIoCLxOaJQSrPiXkM2fESbsOMqcttYbcsRl6jz+DAVlOu9ngaeEAGuJq587aPkWYsCkzeAsb2zKfyf2+Y47kxvcp0YHgZkh3CdF3tMk0lVzIgOpwbrNREcPCA/PKKWZg08RMv7x6bQjdG/DKygSBBeZCibaF48pKzXoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555614; c=relaxed/simple;
	bh=uuXO1HCYXdK5vkAUixJLPhuFNRogUqMkSuZX5swlx84=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K1MEf4B/D+rFDPPDQtel0oRjfJmTObGgSpN7eMQAqd7/O4jdqsp3XMLAELG+wX4JsBgWOBt1QRgYgsxZ9/utd7UpEqqhQKfS5wKXjG9RdC8WgOu0m4Uc6/QPAH3U2LaboahzEyzfbgKjT2+LmgSpmt9r/zdQmQ1dpsc4xy5MziE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLz1GRWb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLz1GRWb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06BC1F000E9;
	Wed, 12 Aug 2026 17:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786555613;
	bh=25WqVN37sLiMWkrIiU2S9B+eHUjhsdhKS8iZAlNjBD4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SLz1GRWbnh0A5FxEcxoQLmM4hQa8NVlCvuGxMiVLk/f83ySbyxEL3/nLmUhbPMoXT
	 28McnPb5kEEPmELLuUGqj+4c9YuAtue4pyDvE2sJ5KXIHbAVPwj5VWSLt3gqLIpzIo
	 nEFvVk6hojDufLTCWbPN3wCFKO//4egWxW7jDk8ymTUcgkva8o1/Kp5s4rMhbLCIKk
	 ZItZdF0fFuIpmjafTKwPc/oIAisF/6CxbBCCUhJlS/gtT+O1oADO2bkfVYnLjyEigq
	 9l0NIZLnIVM+8b0n/uQ7bf2jckvImfi/Po40ccd35F/9fJlns2F2d6PXSraYzPXw2v
	 ZdQ++feXT0ing==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: winwing: fix use-after-free in force feedback
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?UmVuw6kgT25pZXI=?= <f3nr1l@me.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260812171359.18135-1-f3nr1l@me.com>
References: <20260812171359.18135-1-f3nr1l@me.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:26:52 +0000
Message-Id: <20260812172652.D06BC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect teardown ordering in `winwing_remove()` causes `rumble_w=
ork` to be re-queued after cancellation, leading to a Use-After-Free.
- [High] The `lights_lock` mutex in `struct winwing_drv_data` is used witho=
ut ever being initialized.
- [High] LED class devices remain registered after the hardware is stopped,=
 leading to potential Use-After-Free or crashes in the low-level transport =
driver.
--

--- Patch [1]: [PATCH] HID: winwing: fix use-after-free in force feedback t=
eardown ---
commit 7ead0cac4461910c7f089ed4dac8be573080aceb
Author: Ren=C3=A9 Onier <f3nr1l@me.com>

HID: winwing: fix use-after-free in force feedback teardown

winwing_init_ff() passes the driver's private data, allocated with
devm_kzalloc() in winwing_probe(), as the effect context to
input_ff_create_memless(). The memoryless force-feedback core takes
ownership of that pointer and frees it with kfree() from
input_ff_destroy() (ml_ff_destroy()) when the input device is
destroyed.

Fixes: 42d020b54edc ("HID: winwing: Enable rumble effects")

> diff --git a/drivers/hid/hid-winwing.c b/drivers/hid/hid-winwing.c
> index 9cd25a77999e6..19b92c2c6579a 100644
> --- a/drivers/hid/hid-winwing.c
> +++ b/drivers/hid/hid-winwing.c
> @@ -315,7 +315,8 @@ static void winwing_haptic_rumble_cb(struct work_stru=
ct *work)
>  static int winwing_play_effect(struct input_dev *dev, void *context,
>  		struct ff_effect *effect)
>  {
> -	struct winwing_drv_data *data =3D (struct winwing_drv_data *) context;
> +	struct hid_device *hdev =3D input_get_drvdata(dev);
> +	struct winwing_drv_data *data =3D hid_get_drvdata(hdev);
> =20
>  	if (effect->type !=3D FF_RUMBLE)
>  		return 0;
[ ... ]
> @@ -342,7 +343,12 @@ static int winwing_init_ff(struct hid_device *hdev, =
struct hid_input *hidinput)
> =20
>  	input_set_capability(hidinput->input, EV_FF, FF_RUMBLE);
> =20
> -	return input_ff_create_memless(hidinput->input, data,
> +	/*
> +	 * input_ff_create_memless() takes ownership of the context pointer
> +	 * and frees it on teardown; do not hand it the devm-managed drvdata.
> +	 * winwing_play_effect() fetches it from the input device instead.
> +	 */
> +	return input_ff_create_memless(hidinput->input, NULL,
>  			winwing_play_effect);
>  }

[Severity: High]
This is a pre-existing issue, but does the teardown ordering in
winwing_remove() in drivers/hid/hid-winwing.c cause rumble_work to be
re-queued after cancellation?

winwing_remove() {
	if (data)
		cancel_work_sync(&data->rumble_work);

	hid_hw_close(hdev);
	hid_hw_stop(hdev);
}

When hid_hw_stop() unregisters the input device, it invokes=20
evdev_disconnect() and input_flush_device(). The flush executes
input_ff_flush(), which erases active effects by calling ff->playback()
with a magnitude of 0.

This triggers winwing_play_effect(), which re-schedules data->rumble_work
on the global workqueue. After winwing_remove() returns, devres frees the
data structure, leaving a pending work item that will access freed memory
when it runs.

Could this lead to a use-after-free?

[Severity: High]
This isn't a bug introduced by this patch, but is the lights_lock mutex in
struct winwing_drv_data used without ever being initialized?

In drivers/hid/hid-winwing.c:winwing_probe():
	data =3D devm_kzalloc(&hdev->dev, data_size, GFP_KERNEL);
	if (!data)
		return -ENOMEM;

The driver attempts to acquire this uninitialized mutex when userspace writ=
es
to the LED brightness sysfs attribute:

drivers/hid/hid-winwing.c:winwing_led_write():
	mutex_lock(&data->lights_lock);

Can this cause a kernel crash or undefined behavior when lock contention
occurs?

[Severity: High]
This is a pre-existing issue, but do the LED class devices remain registered
after the hardware is stopped?

In drivers/hid/hid-winwing.c:winwing_remove():
	hid_hw_stop(hdev);

The underlying hardware is stopped here, but the devm-managed LEDs remain
registered until after this function returns and the driver's devres group
is released.

If userspace writes to the LED brightness attribute during the window betwe=
en
hid_hw_stop() and devres cleanup, this triggers invalid hardware access on a
stopped transport:

drivers/hid/hid-winwing.c:winwing_led_write():
	ret =3D hid_hw_output_report(led->hdev, buf, 14);

Could this crash the kernel or cause a use-after-free in the low-level
transport driver?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812171359.1813=
5-1-f3nr1l@me.com?part=3D1
