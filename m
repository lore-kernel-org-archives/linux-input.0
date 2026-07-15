Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE0E351C2D
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105847; cv=none; b=o8fEcw3VW7rW0f2Aypi1OLhEM0FfeFFHT+VuuzfaaokzOvRnd10cg9ipa8+k/ymUXLxmj+LjgdPUXccLfjefHXMnnJpZvZHzuAAwYmro2B8XgBrI58hEjEyWmmJyo5vrM9f13PZXMQM5ogFJMfN7lJoBF0w9eGhM4M5LDrbpUEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105847; c=relaxed/simple;
	bh=OuyU8XVDlK0ZKYHCOn0NycGTPnb2PlUcs8wZEDnl6ok=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tT2Io4UkLW5oF2oVumu9VJ7QS7VWk41cslqhNO1ayANXuGfNzBRblGzkdzgQD/LTzKjoFRZdQKvMjAq3R8BDakBoz+6x8zL+IKt5D6TGE1DIIcsVal0AdV/9g/GQbiZNArPm1rkbC1ngIVswLbdSw8T5WQaqtxYWBntMl4XhlW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBtSfAiQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBtSfAiQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1511F000E9;
	Wed, 15 Jul 2026 08:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784105844;
	bh=BN43AeFrV+ire8OOOu0n/HpM0WHjQlFg1Nl4X7dWWJQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hBtSfAiQ6rGEfGJlGxqE3LLgQysAew0bv6448Sq2L4+wlECVlTBBZ9pAlTMqTAkUE
	 IMOIu5HAMTuEEXNTUCI5kXZ3/BgEC0eCcQQsAVu770NL6b18YZgs+Zhnm5Dif5o32s
	 npFTDUvIh55CbR9nU8mVyW3VOvDbDkqXXy6csjN63GVhheDVPgdo7aX1wyEJJ6J3lj
	 iHDMUsWge2jZSF4phKF1cQCedAiFVP7wIh9BGYQM87jH/rTi2tPPM3Kda2XlvL1wQW
	 Szr3yboiM8hUN6BjeLvmqcj04jgqsje96DjFUe0An31889pHhkzMTpDdf3mOiqOcAq
	 YUhwwZJc52UQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: mcp2221: validate raw report length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260715083754.31210-1-pengpeng@iscas.ac.cn>
References: <20260715083754.31210-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 08:57:24 +0000
Message-Id: <20260715085724.7F1511F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Stack Use-After-Free via stale `mcp->rxbuf` pointer
- [High] Resource leak / infinite loop due to static `retries` variable
- [High] Race condition during device probe leading to NULL pointer derefer=
ence
- [Medium] Incomplete Fix / Vulnerability Bypass in report length validation
- [Medium] Data race on shared state in GPIO callbacks
--

--- Patch [1]: [PATCH] HID: mcp2221: validate raw report length ---
commit fe663280b0cd79c441444742c0ab076f8dbfec5d
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

HID: mcp2221: validate raw report length

This commit adds validation of the report length at the beginning of the
mcp2221_raw_event callback. This prevents the driver from reading beyond the
current report length and returns an error for truncated reports to avoid
unrelated timeouts.

> diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
> index e4ddd8e9293b6..67afef1a275f9 100644
> --- a/drivers/hid/hid-mcp2221.c
> +++ b/drivers/hid/hid-mcp2221.c
> @@ -861,6 +861,17 @@ static int mcp2221_raw_event(struct hid_device *hdev,
>  	u8 *buf;
>  	struct mcp2221 *mcp =3D hid_get_drvdata(hdev);

[Severity: High]
This is a pre-existing issue, but could this lead to a NULL pointer derefer=
ence
of the mcp pointer during device probe?

In mcp2221_probe(), hid_hw_open() is called to start the hardware and submit
the interrupt IN URB before hid_set_drvdata() is called. If the device sends
an early interrupt IN report, mcp2221_raw_event() could be triggered while
hid_get_drvdata() still returns NULL, causing a panic when accessing
mcp->status.

> =20
> +	/*
> +	 * HID invokes .raw_event() before its generic report-length check.
> +	 * The response handlers below read fixed offsets from @data, so reject
> +	 * a truncated current report before interpreting any of its fields.
> +	 */
> +	if (size < hid_report_len(report)) {

[Severity: Medium]
This isn't a bug introduced by this patch, but does this bounds check use t=
he
untrustworthy descriptor length instead of the required minimum length for =
the
fixed-offset reads performed subsequently?

If a malicious USB device presents a spoofed HID report descriptor with a v=
ery
small report length (e.g., 1 byte), hid_report_len(report) will evaluate to=
 1.
When a 1-byte packet arrives, this check evaluates to false and is bypassed.
The driver then performs fixed-offset reads, potentially copying uninitiali=
zed
or stale data from the buffer to userspace. Should the validation check
against the hardcoded structural length instead?

> +		mcp->status =3D -EINVAL;
> +		complete(&mcp->wait_in_report);
> +		return 1;
> +	}
> +
>  	switch (data[0]) {
> =20
>  	case MCP2221_I2C_WR_DATA:

[ ... ]


[Severity: High]
This is a pre-existing issue, but does the static retries variable cause
infinite delayed work scheduling?

drivers/hid/hid-mcp2221.c:mcp_init_work() {
    ...
    static int retries =3D 5;
    ...
}

Because retries is declared as static, it is shared across all device
instances. If initialization fails multiple times and retries decrements be=
low
zero, the check can evaluate to false on subsequent runs. This causes the w=
ork
to infinitely reschedule itself, leaking CPU resources and preventing system
suspend. Should this variable be an instance member in struct mcp2221 inste=
ad?


[Severity: Critical]
This is a pre-existing issue, but does this code use the stale mcp->rxbuf
pointer after the stack frame is freed?

drivers/hid/hid-mcp2221.c:mcp_i2c_smbus_read() {
    ...
    mcp->rxbuf =3D msg->buf;
    ...
}

In mcp_i2c_smbus_read(), mcp->rxbuf is assigned a buffer that may be stack
allocated, and the function returns without resetting mcp->rxbuf to NULL.

If the device subsequently sends an unsolicited input report,
mcp2221_raw_event() will execute:

drivers/hid/hid-mcp2221.c:mcp2221_raw_event() {
    ...
    memcpy(&buf[mcp->rxbuf_idx], &data[4], data[3]);
    ...
}

Could this overwrite up to 60 bytes of kernel stack memory with
attacker-controlled data?


[Severity: Medium]
This is a pre-existing issue, but does this code create a data race on the
shared mcp->txbuf and mcp->gp_idx variables?

drivers/hid/hid-mcp2221.c:mcp_gpio_set() {
    ...
    memset(mcp->txbuf, 0, 18);
    mcp->txbuf[0] =3D MCP2221_GPIO_SET;
    mcp->gp_idx =3D offsetof(struct mcp_set_gpio, gpio[offset].value);
   =20
    mutex_lock(&mcp->lock);
    ...
}

The shared txbuf and gp_idx fields are modified here before the mutex lock =
is
acquired. If multiple threads access GPIOs concurrently, their unlocked
modifications to the shared mcp->txbuf and mcp->gp_idx variables will
interleave. Can this cause the device to receive a corrupted command or
mcp2221_raw_event() to use the wrong index when interpreting the response?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715083754.3121=
0-1-pengpeng@iscas.ac.cn?part=3D1
