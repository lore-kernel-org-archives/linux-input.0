Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563E238F94F
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787435530; cv=none; b=GOmEbViLmZEfPnHTyBYmG9B/qHF/Pe4JA1CbccI2+yfMaeL25kfeCuXq78t3rP84sbPe+a5Ej96nPilOjCU+6JKFuYCXWlwTDDtV3HH03hhbXJuuh62lbLW0V08Bux039FLKaUMRqU9JsoSh7G1BPLFXa/PDFNOkOTm9WMtmTdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787435530; c=relaxed/simple;
	bh=8BJSq0Zy6nNY7BCZhm/EBScM0GDTjECIwmNZRYwpt8U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JWkOZBTkaUmbQGmNVL2TszMWoyjg2OffNVdTax94JmQaQecH4Ql51iG3QwsgEGIzrY+dznc0iwwEXmg9lSP6mJSlMMmQYnKGI17YMu0Qwe2ST2kJvBUVBfqYzvpYr3Ck0H05K+mPWt1o3Brc3U7tr9lh2qi9WXW61DCfCTdccG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOKjwgLa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOKjwgLa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5624B1F000E9;
	Sat, 22 Aug 2026 21:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787435526;
	bh=kECr9EW3N3xTbuPAv6ai+++XZ+MX8BOGfZlIFyprk2k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dOKjwgLaZP6+NvvRUbz3fIsfsOlCBft0r4/PL6SXBTkW2gOnea5PcGBeIUbAcxdRX
	 TFdIWmYfg6RcT20/r2I5+vtwVwav1z69Cn75R1x88bwKuOuPbdTVuCzE8UYybLE+/k
	 J+p4ljfFFyUBXzoluiOkIuAZIQLJ7NpPIGzjBx+6iB5L49wMNwCaXG31RV/4CwuEzN
	 nVHofTj5rzELNWTZUMFfZBcMI+YKNTriEm/4bIVXEruqYzcORVU/MRk2Fhsmpr8nLW
	 HnsFrqYt33m05geuo4m5nS7+UywfvoVryMi8c/zoY/WRuKG+8OMFs6BFxXAOE3DYLj
	 94PqEY6CyXpzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/13] HID: ft260: i2c: reduce bus-error message
 severity
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260822213941.98882-7-michael.zaidman@gmail.com>
References: <20260822213941.98882-1-michael.zaidman@gmail.com>
 <20260822213941.98882-7-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 21:52:05 +0000
Message-Id: <20260822215206.5624B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Low] Redundant `__func__` prefix in `ft260_dbg` logging.

Pre-existing issues:
- [High] Hardware is stopped after freeing device resources in `ft260_remov=
e`, causing a Use-After-Free if a report arrives.
- [High] Accessing `dev` after it has been synchronously freed by `ft260_ua=
rt_port_remove`.
- [High] Double free of `dev` in the `ft260_probe` error path for UART inte=
rfaces.
- [High] The devres-managed GPIO chip remains active after the driver manua=
lly frees its context.
- [High] Improper cleanup order of workqueue and timer leads to a leaked wo=
rk item and UAF.
--

--- Patch [6]: [PATCH 06/13] HID: ft260: i2c: reduce bus-error message seve=
rity ---
commit 726d7795b8219b2b5c0f6063a18546f73c323838
Author: Michael Zaidman <michael.zaidman@gmail.com>

HID: ft260: i2c: reduce bus-error message severity

This commit reduces the severity of I2C bus error messages during bus scans=
 by
replacing hid_err with ft260_dbg. It keeps returning -EIO but avoids spammi=
ng
dmesg with routine failures.

> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 8db896f164cd0..1ed3701eaaf75 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
[ ... ]
> @@ -669,7 +669,7 @@ static int ft260_i2c_write(struct ft260_device *dev, =
u8 addr, u8 *data,
>  		ret =3D ft260_hid_output_report_check_status(dev, (u8 *)rep,
>  							   wr_len + 4);
>  		if (ret < 0) {
> -			hid_err(hdev, "%s: failed with %d\n", __func__, ret);
> +			ft260_dbg("%s: failed with %d\n", __func__, ret);

[Severity: Low]
Does ft260_dbg already prepend the function name to the log output? If so,
keeping __func__ in the format string here might cause the function name to=
 be
printed twice.

>  			return ret;
>  		}
> =20
[ ... ]
> @@ -710,7 +710,7 @@ static int ft260_smbus_write(struct ft260_device *dev=
, u8 addr, u8 cmd,
> =20
>  	ret =3D ft260_hid_output_report_check_status(dev, (u8 *)rep, len);
>  	if (ret < 0)
> -		hid_err(dev->hdev, "%s: failed with %d\n", __func__, ret);
> +		ft260_dbg("%s: failed with %d\n", __func__, ret);

[Severity: Low]
Similarly, does this result in a redundant function name in the log output?

> =20
>  	return ret;
>  }

While reviewing this code, I also noticed a few other items in the driver.

[Severity: High]
This is a pre-existing issue, but is it possible for a use-after-free to oc=
cur
during device unbind in ft260_remove()?

drivers/hid/hid-ft260.c:ft260_remove() {
    ...
    kfree(dev);
    ...
    hid_hw_stop(hdev);
}

Because hid_hw_stop() is called at the end of the function, the HID hardware
is still active and can process incoming reports. If a report arrives, it
triggers ft260_raw_event() which accesses the already freed dev:

drivers/hid/hid-ft260.c:ft260_raw_event() {
    struct ft260_device *dev =3D hid_get_drvdata(hdev);
    ...
}

Can this sequence be triggered by hot-unplugging or receiving interrupts
during removal?

[Severity: High]
This isn't a bug introduced by this patch, but does ft260_remove() access d=
ev
after it has been synchronously freed?

drivers/hid/hid-ft260.c:ft260_remove() {
    ...
    ft260_uart_port_remove(dev);
    /* dev is still needed, so we will free it in _destroy func */
    if (dev->iface_id =3D=3D 0)
    ...
}

If the port is not actively opened by userspace, ft260_uart_port_remove()
drops the tty_port refcount to 0, which invokes the destructor and frees de=
v.
Is it safe to access dev->iface_id immediately after this call?

[Severity: High]
This is a pre-existing issue, but could the error path in ft260_probe() lead
to a double free for UART interfaces?

drivers/hid/hid-ft260.c:ft260_uart_probe() {
    ...
err_register_tty:
    ft260_uart_port_remove(dev);
    return ret;
}

If ft260_uart_probe() fails and drops the port reference, dev is freed. The
failure propagates back to ft260_probe(), which then executes:

drivers/hid/hid-ft260.c:ft260_probe() {
    ...
hid_fail:
    kfree(dev);
}

Does this cause kfree(dev) to be called on an already freed pointer?

[Severity: High]
This isn't a bug introduced by this patch, but does devres leave the GPIO c=
hip
active after its private data is freed?

drivers/hid/hid-ft260.c:ft260_remove() {
    ...
    i2c_del_adapter(&dev->adap);
    kfree(dev);
}

The driver registers a GPIO chip using devm_gpiochip_add_data() and assigns
dev as its private data. Since devres automatically cleans up the GPIO chip
only after the remove callback fully completes, can userspace race to invoke
GPIO operations during this window and dereference the freed dev?

[Severity: High]
This is a pre-existing issue, but does the cleanup order of the timer and
workqueue leak a work item and cause a use-after-free?

drivers/hid/hid-ft260.c:ft260_remove() {
    ...
    cancel_work_sync(&dev->wakeup_work);
    ...
    ft260_uart_port_remove(dev);
}

drivers/hid/hid-ft260.c:ft260_uart_port_remove() {
    ...
    timer_delete_sync(&port->wakeup_timer);
}

Since cancel_work_sync() is invoked before the timer is shut down, could the
timer fire concurrently and invoke schedule_work() again? This would leave a
pending work item that executes after the driver is unloaded and its private
data freed. Should timer_delete_sync() occur before cancel_work_sync()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822213941.9888=
2-1-michael.zaidman@gmail.com?part=3D6
