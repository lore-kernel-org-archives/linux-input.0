Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B043B19BB
	for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785245327; cv=none; b=HKHRtFqiRBncoNN5F9dWxb/vwtUqmkAVZTqCsWaq/qSaU+8sDqYJuaA3oQKBh8aDrNAXp/FIbfx2OGYw3y7f7VpKTCcL2h3x1tFs8zPnLuYG1XL5DDy4ct1tjmL7I+RCgzY9LQG+RZk4TD2K7Cx1aBhmK5eSkYU/K5JtX8yisOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785245327; c=relaxed/simple;
	bh=GkdAxZCtc/M9D3GZUGq/6msYDYZk1ob6vmVC9euS57k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iHsSn3SjB3sa1SE8gJhqS9secuqsioMYZSHg7b+yYk3ei4D3HpwOOkgdV/qYGv3i2ElUxpa7t43ZIFOHM/gMdXGNIqtnSCBtfU8CQZrVmVSapE6GbglL1+evugaaXHNBSBS0VPFeIiAVUa4c8aFbB/TgNmYlUnL7vUzlaSL48cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUHXyNEw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUHXyNEw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFF61F000E9;
	Tue, 28 Jul 2026 13:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785245326;
	bh=pS9ytEdseunV/4jOYRiuXocHK5/ixzszvlE6e2drFLM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XUHXyNEwjo+SNTuQitYWlsaaR0/uPaqhKz7GvOc8IiAz1iGaE7k2QcYOtAH024/s6
	 kmL6L4pHp06V6kVAOq+WUzg4fU38QcVusHLG+Inp/Qr3BCWoD+2Ggj1KFF7LtK/S2a
	 HgXbGZg00m70a6KXMm3pKQqEOqYrM+9QObcjDH5TrzwVMgBf9JyEmdwVXS6AfP2MHD
	 p6wEI4UMryaqy/n9YnKe1UjhMxHtjP8SHmihQHuBg4cL0GCvz88t3eOkANCX2JIq6E
	 Ravx9p0Lpm3sckvQrYttJRUPyQxyujWjZvoV4R1u9gCjYoo9gRyhvvxdhRSE1pUFdW
	 2iA9Jvu0SZ43A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] HID: mcp2221: validate report size in
 mcp2221_raw_event()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiangshan Yi" <yijiangshan@kylinos.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260728131442.834604-4-yijiangshan@kylinos.cn>
References: <20260728131442.834604-1-yijiangshan@kylinos.cn>
 <20260728131442.834604-4-yijiangshan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 13:28:45 +0000
Message-Id: <20260728132845.BEFF61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unprotected Time-Of-Check to Time-Of-Use (TOCTOU) race conditi=
on in `mcp->rxbuf` access leads to a Use-After-Free and kernel stack corrup=
tion.
- [High] The patch incompletely fixes out-of-bounds reads by only validatin=
g the payload length for `MCP2221_I2C_GET_DATA`, leaving other command bran=
ches vulnerable.
- [High] Data race on the shared `mcp->txbuf` buffer and `mcp->gp_idx` duri=
ng GPIO operations corrupts concurrent USB command payloads.
- [High] Lack of request/response sequence tracking leads to completion cro=
sstalk and state machine corruption.
--

--- Patch [3]: [PATCH v2 3/3] HID: mcp2221: validate report size in mcp2221=
_raw_event() ---
commit 771b21acaed8d565e6718447cf1dd1d9d3045324
Author: Jiangshan Yi <yijiangshan@kylinos.cn>

HID: mcp2221: validate report size in mcp2221_raw_event()

This patch adds a minimum size check to incoming HID reports in
mcp2221_raw_event() and validates that the source range fits within the
received report before performing a memcpy in the MCP2221_I2C_GET_DATA path.
This prevents a malicious USB device from causing an out-of-bounds read
that could leak uninitialized kernel memory.

> diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
> index 9e03d1f733ff8..d52ce3531ab70 100644
> --- a/drivers/hid/hid-mcp2221.c
> +++ b/drivers/hid/hid-mcp2221.c
> @@ -865,6 +865,9 @@ static int mcp2221_raw_event(struct hid_device *hdev,
>  	u8 *buf;
>  	struct mcp2221 *mcp =3D hid_get_drvdata(hdev);
> =20
> +	if (size < 4)
> +		return 0;
> +

[Severity: High]
This is a pre-existing issue, but while this patch adds a size check for
the MCP2221_I2C_GET_DATA command, does it leave other commands vulnerable?

For instance, the MCP2221_I2C_PARAM_OR_STATUS branch copies from data[50]:

drivers/hid/hid-mcp2221.c:mcp2221_raw_event() {
    ...
    case MCP2221_I2C_PARAM_OR_STATUS:
        ...
        memcpy(&mcp->adc_values, &data[50], sizeof(mcp->adc_values));
    ...
}

And MCP2221_GET_SRAM_SETTINGS accesses data[22]:

drivers/hid/hid-mcp2221.c:mcp2221_raw_event() {
    ...
    case MCP2221_GET_SRAM_SETTINGS:
        ...
        memcpy(&mcp->mode, &data[22], 4);
    ...
}

Could a short USB report of 4 bytes still leak uninitialized memory through
these paths via the IIO subsystem?

>  	switch (data[0]) {
> =20
>  	case MCP2221_I2C_WR_DATA:
[ ... ]
> @@ -930,6 +933,10 @@ static int mcp2221_raw_event(struct hid_device *hdev,
>  					mcp->status =3D -EINVAL;
>  					break;
>  				}
> +				if (4 + data[3] > size) {
> +					mcp->status =3D -EINVAL;
> +					break;
> +				}
>  				buf =3D mcp->rxbuf;
>  				memcpy(&buf[mcp->rxbuf_idx], &data[4], data[3]);

[Severity: Critical]
This isn't a bug introduced by this patch, but is there an unprotected
race condition between the interrupt handler and process context here?

If an I2C read times out, mcp_i2c_smbus_read() clears mcp->rxbuf in
process context:

drivers/hid/hid-mcp2221.c:mcp_i2c_smbus_read() {
    ...
out:
    mcp->rxbuf =3D NULL;
    mcp->rxbuf_size =3D 0;
    ...
}

If a delayed USB response arrives concurrently, could mcp2221_raw_event()
check mcp->rxbuf successfully earlier in the function, but before this
memcpy runs, the process context clears it and destroys the stack frame,
causing the memcpy to corrupt kernel stack memory?

>  				mcp->rxbuf_idx =3D mcp->rxbuf_idx + data[3];


[Severity: High]
This isn't a bug introduced by this patch, but does the unconditional
completion of the wait queue lead to state machine corruption?

drivers/hid/hid-mcp2221.c:mcp2221_raw_event() {
    ...
    complete(&mcp->wait_in_report);
    ...
}

If a command times out and mcp_cancel_last_cmd() resets the wait state,
could a delayed hardware response for the original command trigger this
complete() call, falsely waking up the cancellation command or subsequent
transactions early?


[Severity: High]
This is a pre-existing issue, but does mutating shared state before
acquiring the lock in the GPIO handlers cause a data race?

In mcp_gpio_set(), mcp->txbuf and mcp->gp_idx are modified before taking
mcp->lock:

drivers/hid/hid-mcp2221.c:mcp_gpio_set() {
    ...
    memset(mcp->txbuf, 0, 18);
    mcp->txbuf[0] =3D MCP2221_GPIO_SET;
    mcp->gp_idx =3D offsetof(struct mcp_set_gpio, gpio[offset].value);
    mcp->txbuf[mcp->gp_idx - 1] =3D 1;
    mcp->txbuf[mcp->gp_idx] =3D !!value;

    mutex_lock(&mcp->lock);
    ...
}

If another thread is concurrently executing mcp_i2c_xfer() and assembling i=
ts
I2C payload in mcp->txbuf under the lock, could this zero out and corrupt
the I2C payload while it is being actively sent? Similar unprotected
modifications also appear to occur in mcp_gpio_get().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728131442.8346=
04-1-yijiangshan@kylinos.cn?part=3D3
