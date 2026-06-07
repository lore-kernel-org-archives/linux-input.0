Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E5C1FFC59
	for <linux-input@vger.kernel.org>; Sun,  7 Jun 2026 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780849075; cv=none; b=fCmoHhnG5DaLwt7QK+0FninXWBB75mSbQzsnLJqgtsgrVZaycwqmEj30ytYBYDdSR3i56yMJPmQe/tWBHkvWGuCrqhyaJgfYHTzcF1M1IXHt8EX1UaJVLX02JQZNgp55q32JYWgKZVfX3a/pqcPAPnnpPP/LDcDXEE5Vk8Gz6LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780849075; c=relaxed/simple;
	bh=Q4ou13KV1MLVk4FniOyUw4K1xq6H2CKQth97q/bE96M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r5RtkE6m+WWCY0GT5Ffld9Ze0oXSjpcuQc11dkHqWeLij3CUhWlGQvmehFNy0ZU9TEjXKahTlugxao0ZOlssCMhaiKe3C//0RsrhgRNWiwNr00QzZLlI2fuB1ipno+66erRo5i4uCCOdHf5wtHHdKGatwIYl3iQA67mdJF8tFi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuCdux22; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuCdux22"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9374E1F00893;
	Sun,  7 Jun 2026 16:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780849071;
	bh=2EXccabL9SBmzk61xGbJEnyIJeMnzvDrg6C2V0bnn9Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GuCdux22c9f9ysqk7xHNZebOVlwugP0Sy8aMHaDGa+WjJZ2ALPDGhdE3dvNoHOzsR
	 zmG3xjQaMv2cZ67L3WJxYqIHLNWH/7aa0KyyAve4rALLmxKwDdl3fEf5C8Y//ZnjxF
	 LHa955DOdyuqXsjbEeD6/k5A5lUbxx8tHR59Su4v58Cn/wK/l53jOsxMdblxv8uahp
	 eNDtHwpec+JzHAidallWc9UG9X+4S8AcytBe1rZ/Yv6gRwKtMrtPDste9Xy8ofj2yY
	 bCDA+j7+aqsV8G9uxjG5RDZtTH8lk0mPMvKNUl21AxgDVTO1ySgxJ40UKg6VdcYEWM
	 cuHj6OIJm3qOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: appletouch - fix offset caused by smoothing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Icenowy Zheng" <zhengxingda@iscas.ac.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260607160311.2192061-1-zhengxingda@iscas.ac.cn>
References: <20260607160311.2192061-1-zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 16:17:50 +0000
Message-Id: <20260607161751.9374E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Removing the 4-sensor offset causes valid edge touches to evaluate=
 to 0, which the caller treats as dropped events.

Pre-existing issues:
- [High] Race condition between `atp_close()` and `atp_reinit()` causes use=
-after-free.
- [High] A 32-bit signed integer overflow in absolute coordinate calculatio=
n causes negative cursor jumps.
--

commit 39d19e6e224959faeb0b8190e5d07e558b5470fe
Author: Icenowy Zheng <zhengxingda@iscas.ac.cn>

Input: appletouch - fix offset caused by smoothing

This commit subtracts 4 from the index when accumulating smoothed values
to compensate for the 4-sensor margin introduced by smoothing. This aims
to keep the calculated coordinates within the maximum reported range.

> diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/apple=
touch.c
> index eebeb57515e1c..174762d59f87b 100644
> --- a/drivers/input/mouse/appletouch.c
> +++ b/drivers/input/mouse/appletouch.c
> @@ -415,7 +415,7 @@ static int atp_calculate_abs(struct atp *dev, int off=
set, int nb_sensors,
>  		 * by scale. Mostly noise.
>  		 */
>  		if ((dev->smooth[i] >> ATP_SCALE) > 0) {
> -			pcum +=3D dev->smooth[i] * i;
> +			pcum +=3D dev->smooth[i] * (i - 4);

[Severity: High]
Does this change cause valid touches on the first sensor to be dropped?

If a touch is centered exactly on the first sensor (index 4 in the smooth
array), the smoothed values will be perfectly symmetric around index 4. The
new (i - 4) multiplier will cause the left and right sides to cancel out
exactly, making pcum equal 0.

The callers use 0 as a sentinel for no touch:

drivers/input/mouse/appletouch.c:atp_complete_geyser_3_4() {
    ...
    if (x && y && fingers =3D=3D dev->fingers_old) {
    ...
}

Will this cause valid edge touches to be mistakenly treated as finger
lift-offs and create dead zones on the trackpad edges?

>  			psum +=3D dev->smooth[i];
>  		}
>  	}
>=20
>  	if (psum > 0) {
>  		*z =3D psum >> ATP_SCALE;        /* Scale down pressure output. */
>  		return pcum * fact / psum;

[Severity: High]
This is a pre-existing issue, but does this expression overflow a 32-bit
signed integer?

In atp_calculate_abs(), the accumulator pcum can reach large values for
multi-finger touches at the far edges of the trackpad. If pcum reaches
around 100,000,000, multiplying it by fact (which is 64 for xfact) yields
over 6 billion.

Does this silently wrap to a massive negative number, causing the cursor to
violently jerk to the top or left edge when reported to userspace?

[ ... ]

[Severity: High]
This is a pre-existing issue, but can a race condition between atp_close()
and atp_reinit() cause a use-after-free?

In atp_close(), usb_kill_urb() is called before cancel_work_sync():

drivers/input/mouse/appletouch.c:atp_close() {
    ...
    usb_kill_urb(dev->urb);
    cancel_work_sync(&dev->work);
    ...
}

If the worker atp_reinit() is executing concurrently, can it submit the URB
after usb_kill_urb() has finished? The cancel_work_sync() simply waits for
the worker to finish and returns, leaving the URB actively running after
the device is closed.

Furthermore, atp_disconnect() does not call cancel_work_sync() if the
device was already closed:

drivers/input/mouse/appletouch.c:atp_disconnect() {
    ...
    usb_kill_urb(dev->urb);
    input_unregister_device(dev->input);
    usb_free_coherent(...);
    usb_free_urb(dev->urb);
    kfree(dev);
}

Since a running URB can schedule the work again, could atp_disconnect()
free the dev structure while the worker or URB completion handler is still
running?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607160311.2192=
061-1-zhengxingda@iscas.ac.cn?part=3D1
