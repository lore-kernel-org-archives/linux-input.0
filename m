Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE692253B0
	for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 19:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787512495; cv=none; b=Hsur7QR0j/fipSawq7MaYClt+DBljIUUWrvb/H9NDwz1KyrsD+mlCrISnW0osu5hZbk1NoNniJa1bZUcLBIR2Y+Bo7gvRrBOGTgcjHP/ihHeEKEmQ2V77ThNhEbhITDn/w0iJ4ro+XF5YokXFhBs48xwxONNUkpjcNvMai8x/n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787512495; c=relaxed/simple;
	bh=FKp+YHb2xjUzHabtaNxujM+XCYDgOksR5+FzGBAwO0E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bw/CXzcDevDDeWICOq2XzKM0gf24RTDQi+XX8Rz/+eWrc0aMheaest8LPVcJ10zmnu84iO2REErdXu9SFqpp6owVFyDaJSQ5Ko1rRkQ9NewBe6+E1z5uGnOwMQAUtVXG/KyNe9vZ6gKhXHVVgeH47oW8dcANa79/G62vMZCVNoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqiPT5Jo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqiPT5Jo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A883C1F000E9;
	Sun, 23 Aug 2026 19:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787512492;
	bh=zHUvqq8vZo3SmgnFYuUtcEuegWdaIXXGY+gPeDO6XLo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MqiPT5JoFDRMYByAyngMSBgX/wc3m/fsOKtEiHw3mV0MC2W4efHYt+edo53fClPCz
	 dUMOuFz8itdMtPTik+1RLN92KNXbK7NP+mT4K9M3gAo+c8Im32dWUwCwm1kBFrk0nU
	 Sa71ge0k/UnAThfkbaRs0IytS7giC5GQT1e2FdwS/lb8acM2Q+8OVQKEV1hqWF4JOW
	 T5SYeWfMtELt/BUVkVAlzOD5+4g10m1FPejQQt6f45S6HS4mt6uElt667CdQYDZVgm
	 RhPqe+qcQ2E+vDNsk7LzSAJFrQ1HIBF6YXzvbuqA9BLlioAKeXNd4e+/+bV81/4btZ
	 09cVs7YBpp2Ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/12] HID: asus: add support to force feedback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260823185849.2478673-10-denis.benato@linux.dev>
References: <20260823185849.2478673-1-denis.benato@linux.dev>
 <20260823185849.2478673-10-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 19:14:52 +0000
Message-Id: <20260823191452.A883C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Concurrent unbind of the gamepad interface during the config inter=
face probe causes a Use-After-Free in hid_hw_output_report().
- [Low] Missing return statement after `scoped_guard` loop causes `-Wreturn=
-type` warning.
--

--- Patch [9]: [PATCH v3 09/12] HID: asus: add support to force feedback ---
commit c9da8775d34d1910105c3e14e76fe75184d40841
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support to force feedback

Unlike ROG ally the X version and following ones uses DInput protocol
and the force feedback needs to be implemented as its protocol is
vendor-specific, therefore add support for FF_RUMBLE with magnitude
scaling on a work-queue based approach to avoid using possibly
sleeping calls in atomic context.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index dc7a504e84cb6..04bf2c6ca449b 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> +static int ally_x_send_ff_report(struct ally_handheld *ally,
> +				 struct hid_device *hdev,
> +				 const u8 *buf, size_t len)
> +{
> +	u8 *dmabuf __free(kfree) =3D kmemdup(buf, len, GFP_KERNEL);
> +
> +	if (!dmabuf)
> +		return -ENOMEM;
> +
> +	scoped_guard(mutex, &ally->intf_mutex)
> +		return hid_hw_output_report(hdev, dmabuf, len);
> +}

[Severity: Low]
Does returning directly from within a scoped_guard leave the function
without a top-level return statement?

Because scoped_guard expands into a for loop, the compiler's static analysis
assumes the loop condition could evaluate to false, causing execution to fa=
ll
through to the end of the non-void function.

This emits a -Wreturn-type warning, which causes build failures on
configurations using -Werror.

Could this use guard() instead?

	guard(mutex)(&ally->intf_mutex);
	return hid_hw_output_report(hdev, dmabuf, len);

[ ... ]

>  static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handh=
eld *all
>  {
>  	int ret;
>  	struct ally_config *cfg;
> +	struct hid_device *x_hdev;
> +	unsigned long flags;
> =20
> -	/* Failure at this point is non-critical */
> -	ret =3D ally_gamepad_send_packet(ally, hdev, ALLY_FORCE_FEEDBACK_OFF,
> -				       sizeof(ALLY_FORCE_FEEDBACK_OFF));
> -	if (ret < 0)
> -		hid_err(hdev, "Ally failed to init force-feedback off: %d\n", ret);
> +	/*
> +	 * The force-feedback "off" packet belongs to the gamepad interface,
> +	 * which consumes it as an output report: the config interface probed
> +	 * here would reject it. The gamepad probe path sends the packet itself,
> +	 * so this only matters when the gamepad interface is already bound,
> +	 * e.g. after a reset resume that re-initialized the MCU.
> +	 */
> +	spin_lock_irqsave(&ally_data_lock, flags);
> +	x_hdev =3D ally->ally_x_hdev;
> +	if (x_hdev)
> +		get_device(&x_hdev->dev);
> +	spin_unlock_irqrestore(&ally_data_lock, flags);
> +
> +	if (x_hdev) {
> +		/* Failure at this point is non-critical */
> +		ret =3D ally_x_send_ff_off(ally, x_hdev);

[Severity: High]
Can this lead to a use-after-free if the gamepad interface is unbound
concurrently (e.g., via sysfs or USB hot-unplug) during the config probe?

While get_device() prevents the hid_device struct from being freed, it does
not stop the underlying transport driver (like usbhid) from unbinding.

When the transport driver unbinds, it removes the device and frees its
private data. If that happens before ally_x_send_ff_off() calls
hid_hw_output_report(), the transport's output_report callback will
dereference the already freed hdev->driver_data.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823185849.2478=
673-1-denis.benato@linux.dev?part=3D9
