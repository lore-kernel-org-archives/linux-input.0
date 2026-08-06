Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADDC3859CB
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 05:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785995837; cv=none; b=ak2qdsh28Wy0cyxw6MFndYPYITadQ7v6pqZ2V2g1vqjcgVxUXcYXXtfKfDbmDMN47WRjhc6bpdN5CFGS/2pLX2vb7nSbPZnh4qJkERvZOTSGDo6+6lnDQCzfFkZPdmDn2kxqZqKdww+cTqnsldgrzfeAHS7sLO+bBb00BTuzSMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785995837; c=relaxed/simple;
	bh=YRk0T+5TRBShCJ1i1eG9RUUWavap7ofMy+f06KKTBoU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mQ8FhFnpVyifygtuNG5Xut7CMeY0BcsJ+2xrv51XfCpqB1MRf99xfsQfCs4AH6HR7bbuIxp0HdXvtzbWr3wZz9StgjMb3MMycNw9q4jNpA4AjsIpxjMg7rY33wQHZa/uke8EB/bP3AMPSs0KJcMvoNgPDtNL/QYBRkgt0nJvQ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBFlYM7G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBFlYM7G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBB01F000E9;
	Thu,  6 Aug 2026 05:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785995835;
	bh=noEgNPj98EbmUNgKtIk2j/n37wDxmh13EQHnGpK7124=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hBFlYM7GyDGxwZq8KNu8VoKDv5O2CpOVA2O+aw1KMxd9DwGUfqmiv6zqTEwg9Exkq
	 MPVOzOtEXT1fYM0L+XiS+gs+bdj6aHGtaiHW3wQ69DWkteEHVQPJiA3WMwZtWAmmv4
	 tHFbIg/cGG4GpCdyDjZXPVBTojIU1K+0nkItfbgV+nqW4E6Wpx4kakViqVVmBwPPCc
	 n4JzFXENK6HatsvcEK3K7TLS05b7Y9p8D9TtProDXNGCsNp9ipqsAiYLgGhmy16tHh
	 UfAKQsrAh84hPN450KXHxKQxsnZOB/74C/s69kWaE6T5VmIVMeRcG3ksRLbYCaEN0e
	 7wQPovOm1zgww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: synaptics-rmi4 - fix GPF in suspend and resume
 when unbound
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <anQe8UiyUR4x0flD@google.com>
References: <anQe8UiyUR4x0flD@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 05:57:14 +0000
Message-Id: <20260806055715.5DBB01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The exported function `rmi_set_attn_data()` dereferences `drvdata`=
 without a NULL check, leading to a potential NULL pointer dereference if t=
he physical device probe fails.
- [High] If `rmi_driver_probe()` fails after `rmi_f34_create_sysfs()` succe=
eds, the error path fails to call `rmi_f34_remove_sysfs()`, leaking the sys=
fs group. Accessing the leaked sysfs files causes a NULL pointer dereferenc=
e.
- [Medium] If `rmi_suspend_functions()` fails, `rmi_driver_suspend()` and `=
rmi_i2c_suspend()` disable IRQs and regulators, but propagate the error to =
the PM core. The PM core aborts suspend and does not call `resume` for this=
 device, leaving it permanently powered off.
- [Low] Misleading copy-paste error messages in suspend and resume paths.
--

--- Patch [1]: [PATCH] Input: synaptics-rmi4 - fix GPF in suspend and resum=
e when unbound ---
commit 19d89c520c8ddb566dee79a7cfbffc9acc8839a2
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: synaptics-rmi4 - fix GPF in suspend and resume when unbound

Transport drivers invoke rmi_driver_suspend() and rmi_driver_resume()
on their child rmi_dev device during power management events. This
prevents a GPF by checking if driver data is attached, exiting early
if not present.

Closes: https://syzkaller.appspot.com/bug?extid=3D09103639e39c989e3ed3

> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_dri=
ver.c
> index 5d49a9021c7d0..a349dfd17519c 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -991,6 +991,15 @@ int rmi_driver_suspend(struct rmi_device *rmi_dev, b=
ool enable_wake)
>  {
>  	int retval;
> =20
> +	/*
> +	 * Transport driver will try to suspend RMI device even if physical
> +	 * driver did not bind to the RMI device, because transport device
> +	 * (I2C, SPI) is fully registered and operational. Exit early if
> +	 * there is no driver data attached to the RMI device.
> +	 */
> +	if (!dev_get_drvdata(&rmi_dev->dev))
> +		return 0;
> +
>  	retval =3D rmi_suspend_functions(rmi_dev);

[Severity: Medium]
This isn't a bug introduced by this patch, but looking at the rest of
rmi_driver_suspend():

rmi_driver_suspend() {
    ...
    retval =3D rmi_suspend_functions(rmi_dev);
    if (retval)
        dev_warn(&rmi_dev->dev, "Failed to suspend functions: %d\n", retval=
);
   =20
    rmi_disable_irq(rmi_dev, enable_wake);
    return retval;
}

If rmi_suspend_functions() fails, the error path still disables the IRQ
and returns the error to the PM core. The I2C transport driver then
unconditionally disables regulators in rmi_i2c_suspend() and also
propagates the error.

Since the PM core aborts suspend and skips calling resume for devices
that return an error, does this leave the device permanently disabled and
unresponsive?

> @@ -1005,6 +1014,10 @@ int rmi_driver_resume(struct rmi_device *rmi_dev, =
bool clear_wake)
>  {
>  	int retval;
> =20
> +	/* Skip if not fully bound to RMI driver */
> +	if (!dev_get_drvdata(&rmi_dev->dev))
> +		return 0;
> +
>  	rmi_enable_irq(rmi_dev, clear_wake);
> =20
>  	retval =3D rmi_resume_functions(rmi_dev);

[Severity: Low]
This is a pre-existing issue, but further down in rmi_driver_resume() there
appears to be a copy-paste error in the warning message:

rmi_driver_resume() {
    ...
    retval =3D rmi_resume_functions(rmi_dev);
    if (retval)
        dev_warn(&rmi_dev->dev, "Failed to suspend functions: %d\n",
            retval);
    ...
}

Should this warning say "Failed to resume functions"? Similarly, in
rmi_i2c_suspend(), there is a warning that says "Failed to resume device"
when suspend fails.

[Severity: High]
This is a pre-existing issue, but since this patch addresses NULL pointer
dereferences from unbound devices, is there a similar vulnerability in
rmi_set_attn_data()?

rmi_set_attn_data() {
    struct rmi_driver_data *drvdata =3D dev_get_drvdata(&rmi_dev->dev);
   =20
    if (!drvdata->enabled)
        return;
    ...
}

If rmi_driver_probe() fails, dev_get_drvdata() is cleared to NULL. However,
the HID transport driver (hid-rmi) sets the RMI_STARTED bit after successful
transport registration, independent of the physical driver probe.

If hardware sends events or malicious data is provided after a probe failur=
e,
can rmi_input_event() bypass the RMI_STARTED check and call
rmi_set_attn_data(), leading to a NULL pointer dereference when accessing
drvdata->enabled?

[Severity: High]
This is another pre-existing issue, but looking at the error handling in
rmi_driver_probe():

rmi_driver_probe() {
    ...
    err_destroy_functions:
        rmi_free_function_list(rmi_dev);
    err:
        return retval;
}

If rmi_driver_probe() fails after successfully calling
rmi_f34_create_sysfs(), it jumps to err_destroy_functions but misses a
call to rmi_f34_remove_sysfs().

Does this leak the sysfs group? If the sysfs group is leaked and the driver
core clears drvdata, could a later user-space read to the world-readable
update_fw_status sysfs attribute trigger a NULL pointer dereference in
rmi_driver_update_fw_status_show() when it checks data->f34_container?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/anQe8UiyUR4x0flD@go=
ogle.com?part=3D1
