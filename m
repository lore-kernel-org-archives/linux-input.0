Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C92F2459DC
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 02:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781317350; cv=none; b=EEwuWr0tj17PcS1nhz+3SdPICEf91GWqx9n2BPG7RKsJ/MJHHBoW6NkMNriOWc3hX/MnKE7C6qbnk5viWHTRw9Al+HpoILZx6U33DYrMZcZSe8/AGV3I2JePx9PTUW9ARIu2LoMkLZWZoosa1cs+YgbSBTGgzlxIGzOYGaVir8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781317350; c=relaxed/simple;
	bh=K1oVxhsG+pGuj9zyYxw4l1UzqYJIfFHiR/y50WS86wQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KxIRkXDgQFPCpuTRrJHy0zHCcsSkB7XTE96WJXUaDSCaj29ZJXa6kNq51mKy/LYhDQSRBREKNV+58bda3xRN0GPhHf0aDAnA3l+/NMHjBcSMa/2ZGPVyaYYfLVvZXmhwdfq4fXxn4pGc86SRYI2sa5QAW+MU8JCtN/E6ukTHUsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Od7PwRZY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Od7PwRZY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC471F000E9;
	Sat, 13 Jun 2026 02:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781317349;
	bh=CjUiXVcg/22pXCNNIii4JPqkMQsiQk1bzTkFMip5qRM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Od7PwRZYS+MD4/WHfHG9EIsH/nBP/1Tp6nHkPglKz1mTUBwCpYc3+HsrhIyMKLbsJ
	 RPX7lYexFD4e4tjL8u4iDraT/YuqaArkoYSGuoJHHAUHAW2xFJaFdMnfb5Zw847TiJ
	 lVVt2oFqLzyhr3TV7MkP/E6UhbOqBS7QAgPZQidd9Doy/EAwCMA6B/VpLmmg+otfAo
	 lnF2L3EyZe9Ox3IyTLw2uSTLbrXcLUWRFQgfgwKa3PoYTdUp+bf8gxy2crvDviGlkD
	 3XFFfW43BTkIhZdU5FfrKCubqTw24bIJhGC/Gg3rvIlidC1WpsJJUgPAlwuSnCZQAN
	 cALaRUNMSZ+MA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: goodix - clamp the device-reported contact count
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas via B4 Relay" <devnull+hexlabsecurity.proton.me@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260612-b4-disp-6844625d-v1-1-df0aed080c9d@proton.me>
References: <20260612-b4-disp-6844625d-v1-1-df0aed080c9d@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 02:22:28 +0000
Message-Id: <20260613022228.CAC471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbalanced IRQ teardown and request on suspend/resume leads to ker=
nel panic.
--

commit 67a6ac06922d6e5f9f42f13db85b8ae1bd396b75
Author: Bryam Vargas <hexlabsecurity@proton.me>

Input: goodix - clamp the device-reported contact count

This commit fixes an out-of-bounds stack write when reading the input
report. It clamps the maximum number of touch points reported by the
device configuration to prevent a malicious or malfunctioning controller
from overflowing the on-stack buffer.

> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscre=
en/goodix.c
> index f8798d11ec030..17fcfe45988c2 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c

[Severity: High]
This isn't a bug introduced by this patch, but looking at the driver's
suspend and resume paths, is there a potential regression regarding null
pointer dereferences if device initialization fails asynchronously?

If asynchronous firmware loading or configuration fails, device
initialization aborts without unbinding the driver. The ts->input_dev
pointer remains uninitialized, and the interrupt is never requested.

During system suspend, goodix_suspend() unconditionally calls
goodix_free_irq(), which invokes devm_free_irq() without checking if the
interrupt was actually requested:

goodix_suspend()->goodix_free_irq():
    if (ts->client->irq)
        devm_free_irq(&ts->client->dev, ts->client->irq, ts);

This triggers a warning because the managed resource does not exist.

Furthermore, upon system resume, goodix_resume() unconditionally
calls goodix_request_irq():

goodix_resume():
    ...
    error =3D goodix_request_irq(ts);
    if (error)
        return error;

This successfully registers the interrupt handler even though the device
is completely uninitialized.

When a subsequent touch event triggers the interrupt,
goodix_process_events() blindly accesses the uninitialized input device:

goodix_process_events():
    ...
    input_mt_sync_frame(ts->input_dev);

Because ts->input_dev is uninitialized, does this dereference cause a
regression during device operation?

Could the suspend and resume functions be updated to verify the device is
fully initialized before tearing down and requesting the interrupt?

> @@ -1057,7 +1057,8 @@ static void goodix_read_config(struct goodix_ts_dat=
a *ts)
>  	}
> =20
>  	ts->int_trigger_type =3D ts->config[TRIGGER_LOC] & 0x03;
> -	ts->max_touch_num =3D ts->config[MAX_CONTACTS_LOC] & 0x0f;
> +	ts->max_touch_num =3D min(ts->config[MAX_CONTACTS_LOC] & 0x0f,
> +				GOODIX_MAX_CONTACTS);
> =20
>  	x_max =3D get_unaligned_le16(&ts->config[RESOLUTION_LOC]);
>  	y_max =3D get_unaligned_le16(&ts->config[RESOLUTION_LOC + 2]);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612-b4-disp-68=
44625d-v1-1-df0aed080c9d@proton.me?part=3D1
