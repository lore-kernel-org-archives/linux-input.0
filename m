Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400289;
	b=oFau61yQD9ttMiDd2TZZ5PFrF3kVsbF/eozXkTta6a6jVP8Rc1fTium65J2gCz/tP8m6
	 hpu9Lf+lCSMUn85dorQpZuySRVRrAFyJjEEWwGgbTlaqpw4YIhRgF8+6GxZPY59+nT69x
	 /WI2FNtXGE3FI6ST4BT6FHg5Wc0/T8apeyWI0lRSKkASKO6p5Il0M/kMM++EGId6NUcVh
	 OflqMT6emEtQM2wSDwUimt6hkTH0067urk05LQmWDGY7BQRZzy+dkcU6EI9NC5cUFmPvW
	 86v4ENzZKHYIUaerZ9TF7FndchcoY+p+hy0Gx3cS5af0+9EqrCn+ndz/NWXlYO2MVjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400289;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Vc9FeWDAG9XZyd1DUw0ilCV/zFGoP6/GH1MFKWQg+0w=;
	b=eqEB5OTRUhDCR0ZksdT2W4e/bz82CAqTGje4iOTtUGVJI36h2qZEaSzRKvWV6GcVJ9J3
	 2/6II+qhJA1O7Aoq/3/uin8tAgeECNTKCJ0k14A5D/zAeEOI28mPHUsZpV1p77rjNouzc
	 usBVG3ZteIzZLVBe2+GZR1vYPODb9EQZOl2QftnTcHJw0yq+1j4gI8oDoJzFN+8MB1eOR
	 LERrLHVfDUlyQZnnIV8SOK/ktfVMZz8C65wkc74xt2RXVlLWcZ+VeACiawj6XZ/UPaGop
	 ivCQ5JpPIdNMq4Y9U3R092Jf+LqqiF1GKeoNEynMLj2OONd2vU+rInQPllbAUD2o3Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hNNnVYwk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767FF606A31D;
	Fri, 30 Oct 2026 22:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hNNnVYwk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA4E1F000C1;
	Fri, 30 Oct 2026 22:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793400288;
	bh=Vc9FeWDAG9XZyd1DUw0ilCV/zFGoP6/GH1MFKWQg+0w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hNNnVYwkM6Y4alo3kw5h7Mb2FajnXoleGPhOvVWXZFYQJoWOoRRryIQu/uutYW7iB
	 spWgI+wE8XDwXZlflUvsWBOt0FJWNSq2zRD8PDUhXjgyfdg7sTgzIkDMzoU5moaSwI
	 FgYYhEFEY4KqF8nEC9EJoH21oisKOI6S2M0yQp8L6IO1Ys9dXobEdl8QTNzAVqMCW6
	 YSgrcjTeOjBrWii/o88MeygtUulcoMeRu9a3vlUOzEGlsLAvvmm9FmCEiXfHERs0OM
	 yiAGZahgm/uhQyzEsjbIyMI8ZkD9MWZlZuleXsOlTkc+Ckl9f4TkZay/BveVpqeKNm
	 wpkXauuy6P6VA==
Message-ID: <sashiko-outbox-191585@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/15] HID: ft260: i2c: reduce bus-error message
 severity
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-input@vger.kernel.org, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261030223637.86907-7-michael.zaidman@gmail.com>
References: <20261030223637.86907-1-michael.zaidman@gmail.com>
 <20261030223637.86907-7-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 22:44:47 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] HID: ft260: use-after-free of dev in devres-managed gpio_chip on r=
emove
--

commit 1fae4f26d8271d00c6ed7c7d5f16ef4ae51d0f21
Author: Michael Zaidman <michael.zaidman@gmail.com>

HID: ft260: i2c: reduce bus-error message severity

This commit lowers the log level of I2C bus error messages in
ft260_xfer_status(), ft260_i2c_write(), and ft260_smbus_write() from
hid_err() to ft260_dbg() to avoid spamming dmesg during bus scans, while
keeping hid_err() in ft260_hid_output_report_check_status() for actual HID
transport failures.

> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index d2c5c9ed79276..6f8d729387025 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
> @@ -575,7 +575,7 @@ static int ft260_xfer_status(struct ft260_device *dev=
, u8 bus_busy)
>  	 * to 1, bit 1 is also set to 1.
>  	 */
>  	if (report.bus_status & FT260_I2C_STATUS_ERROR) {
> -		hid_err(hdev, "i2c bus error: %#02x\n", report.bus_status);
> +		ft260_dbg("i2c bus error: %#02x\n", report.bus_status);
>  		return -EIO;
>  	}

[Severity: High]
As reported by Sashiko on v1 [1], in drivers/hid/hid-ft260.c, ft260_probe()
allocates dev manually with kzalloc_obj(), while ft260_gpio_init() registers
the GPIO chip via devres with dev as its private data:

drivers/hid/hid-ft260.c:ft260_gpio_init() {
	...
	ret =3D devm_gpiochip_add_data(&hdev->dev, dev->gc, dev);
	if (ret < 0)
		hid_err(hdev, "cannot add GPIO chip %d\n", ret);
}

During unbind, hid_device_remove() calls ft260_remove() before releasing
hdev->dev's devres group via devres_release_group():

drivers/hid/hid-ft260.c:ft260_remove() {
	...
	hid_hw_close(hdev);
	hid_hw_stop(hdev);

	if (dev->iface_type =3D=3D FT260_IFACE_UART)
		ft260_uart_port_put(dev);
	else
		kfree(dev);
}

Similarly, if sysfs_create_group() fails after ft260_gpio_init() in
ft260_i2c_probe() or ft260_uart_probe(), ft260_probe() frees dev before
__hid_device_probe() releases the devres group.

Because dev->gc remains registered until devres_release_group() runs, can a
concurrent GPIO callback such as ft260_gpio_get(), ft260_gpio_set(),
ft260_gpio_direction_input(), ft260_gpio_direction_output(), or
ft260_gpio_get_direction() obtain the freed dev pointer via
gpiochip_get_data(gc) and trigger a use-after-free?

[1] https://lore.kernel.org/r/20260822213941.98882-7-michael.zaidman@gmail.=
com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030223637.8690=
7-1-michael.zaidman@gmail.com?part=3D6
