Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2CF3382F9
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781365983; cv=none; b=Z7Kkqyxx7CVnxBoBf00Mt5Cnmn4jnz3nLYSEgZuiJ0mufLEeeXWSIlfjcJ9IVPmAvKp6hWqor95/jI2QoG93W83XJk7eb81vVGQo/OqaFyNYPZascz6M5/BFCzIrdWnyzBhYz/qw+fz4qskqhHUsg9Ln9N7KNuWVS4Y/tDvLC0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781365983; c=relaxed/simple;
	bh=uI+AbbGZ1xAA2aOqqAJFgn2RVMtU05rea2zH22B0j3U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QbQ6zojpi2A+GnqlfPu9MI7W5bCp4a4QGpvxyRADyGG1WoAWsXv9QJQVNcFEVQOYZaObPXNGRSfs8AmFI1l/G7oyPUZv5ZPSZe7JQwNwYG0ydkmfXQsdV2Rum4hafb5c98CRczDNzlT/SylPVkoyDToep//o/OQawnqb2HtCwZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQs+0k77; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQs+0k77"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCAB1F000E9;
	Sat, 13 Jun 2026 15:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781365981;
	bh=SaTi5EeW2LeynRgm/BnHIeuEsZH8oHxXlfvnDO3Ykd0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fQs+0k77b9t637z3O4OFdp8uJNKxyf3yraH7gvo/mVDt80Tby0MaGidfGVZXFu6Ex
	 CjE/m3dcyeX1W1CATDKdhDBq9/I2RSRBB0dg/IYR0x8gnXsXQ0Pk2mSDX/QVYUWeIC
	 vzujebg13fOUkZ75AAyKfqzu8GI3pWXqszN+VUsyUqh0F0dgy609ilILkFJaf88HQQ
	 7OdbQ6CNYRaY2xduo9epkkT+skr7u840q0TRQNjIPCdBHeJ0Y1kE6vUl+nc/Qt92cc
	 ihxqEp5JRcagoqzEs6nLEmFTWMgFzhTLX+yvxVknsJNxJn2gCg4FPCTjjyIh9n4QAz
	 7tMvTsWqn5l+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/8] HID: asus: prevent a late KEY_FN_ESC to trigger
 a use-after-free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260613153029.2559774-7-denis.benato@linux.dev>
References: <20260613153029.2559774-7-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 15:53:00 +0000
Message-Id: <20260613155301.2BCAB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Unvalidated `size` from an untrusted HID event directly overwr=
ites `drvdata->wmi_size`, leading to a stack buffer overflow in `asus_wmi_w=
ork()`.
- [High] Missing `led_classdev_unregister` for `xgm_led` on `asus_probe` er=
ror paths leading to a Use-After-Free.

Pre-existing issues:
- [High] Missing `cancel_work_sync` on the `asus_probe` error path can lead=
 to a use-after-free of the `kbd_backlight->work` workqueue structure.
--

commit 621a1df344c100c1c65a96b5fd1d410d256fafef
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: prevent a late KEY_FN_ESC to trigger a use-after-free

A late KEY_FN_ESC event can trigger asus_event() and unconditionally call
schedule_work() after the work was supposedly canceled.

Once the driver is removed and drvdata is freed by devres, the workqueue
could execute asus_sync_fn_lock() and dereference the freed drvdata.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index a3437789b2341..c1a247348c3d9 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

[Severity: Critical]
Can this lead to a stack buffer overflow?

Unvalidated size from an untrusted HID event directly overwrites
drvdata->wmi_size in the commit 'HID: asus: avoid sleeping calls in atomic
context':

drivers/hid/hid-asus.c:asus_raw_event() {
    ...
    if (data[1] =3D=3D ASUS_FAN_CTRL_KEY_CODE) {
        ...
        drvdata->wmi_size =3D size;
    ...
}

Because size comes from the transport layer, a malicious USB device can
supply an event size up to HID_MAX_BUFFER_SIZE (4096 bytes).

Later, the asynchronously scheduled asus_wmi_work() uses this oversized
wmi_size:

drivers/hid/hid-asus.c:asus_wmi_work() {
    ...
    u8 report_data[FEATURE_KBD_REPORT_SIZE];
    ...
    memcpy(report_data, drvdata->wmi_data, drvdata->wmi_size);
    ...
}

Will this overflow the 64-byte stack buffer report_data?

[Severity: High]
This is a pre-existing issue, but does this error path need a call to
cancel_work_sync(&drvdata->kbd_backlight->work)?

drivers/hid/hid-asus.c:asus_probe() {
    ...
err_unregister_backlight:
    if (drvdata->kbd_backlight) {
        asus_hid_unregister_listener(&drvdata->kbd_backlight->listener);
        devm_kfree(&hdev->dev, drvdata->kbd_backlight);
        drvdata->kbd_backlight =3D NULL;
    }
    ...
}

If a subsequent initialization step fails, the error path unregisters the
listener and frees the backlight structure.

If the work was queued prior to the failure, wouldn't the workqueue core
execute the pending work on the newly freed memory?

[Severity: High]
Does this code leave a dangling pointer in the LED subsystem list?

drivers/hid/hid-asus.c:asus_probe() {
    ...
err_stop_hw:
    hid_hw_stop(hdev);
    return ret;
}

In the commit 'HID: asus: add support for xgm led', asus_xgm_init()
allocates drvdata->xgm_led using devm_kzalloc() and registers it via
led_classdev_register().

If a subsequent initialization step fails, the error handling paths branch
to err_unregister_backlight and err_stop_hw without calling
led_classdev_unregister() for the XGM LED.

When asus_probe() returns, devres will automatically free drvdata->xgm_led,
but won't unregister the device, which could leave a dangling pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613153029.2559=
774-1-denis.benato@linux.dev?part=3D6
