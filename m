Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B74418DB01
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126057; cv=none; b=qU+2LwycBoP27eCUUbDt3EJ5UKASSMAdXquZMdR4X/iXrHBCq0PcCzA9mZXzfqD5UGQHpT46xpTsW2tnWD75rskS+hvKgbAwE45KvvhWZun5gP0YRNlGq+m6XwXQcG2fYQn9ScWicu9atVITi2Vs1nVqUurY8M+Xwp/ZK4zY4hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126057; c=relaxed/simple;
	bh=+w03OCVJJ5lEdUvLjUtTWIFbCYkXxpgNSOfRk81Uymw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jE81u9NxfhPuQ7H0ASga+kYvD0zQUnLFCy4TBlQadPSV6eOVzcgjCnB9H9FKT88W5vqcR83P5dfyKLj35OuYdxbb/pI3ZOyOOSrzaqMetAiLUlmq5gsyJNriOaL5k4JCCnXWDVFvaO+HLqXugUkbbomakSKtRZUhTQwcZUtuzhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiwT6Myp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiwT6Myp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916A21F00A3A;
	Wed, 15 Jul 2026 14:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784126055;
	bh=Mc+TzmvAfQgDIIPWcjqNeuLMB7sr7e5yjqJPpckH58Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hiwT6MypnBrlUISU9ogM8u+deK2oJ8mplMk9rKbre64vf+pbo8ZBAQQw+sbgJpCSK
	 ZtuW/TUbQ7UAkOjLtTf87KeQbdm4+o5TcaMH4E2tinaHWDlL5d7WzmEB/yafhFIvv3
	 k/H+GezvkY+84AxFXsiOIce7IvzNtbEgeh/iDEEYy9f3q+1qExyRLjVsTCFHJ0HvJe
	 tpmeiddsoRylAWNP8OnJkh96vA0tkjqMOL0o0d6qzZ6fxzQ75YrLw5NNyDNpiwRV/m
	 cgSwoZVp2Eqhr3NxYW2arr2q74HWqNBRl4sPG68BELBDrVcWi6WbtrCiMNxgjbto6U
	 MH2z8DRmxgeZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: mcp2221: validate raw report length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260715135916.24417-5-pengpeng@iscas.ac.cn>
References: <20260715135916.24417-5-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 14:34:15 +0000
Message-Id: <20260715143415.916A21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Use-After-Free and Out-Of-Bounds Write due to a dangling `mcp-=
>rxbuf` pointer after an I2C transaction times out.
- [Critical] Time-of-Check to Time-of-Use (TOCTOU) Buffer Overflow in `mcp2=
221_raw_event` due to non-atomic buffer state updates.
- [High] Concurrent GPIO and I2C operations modify the shared hardware buff=
er (`mcp->txbuf`) outside of the `mcp->lock` mutex, leading to data corrupt=
ion.
- [High] Teardown asymmetry and Use-After-Free caused by runtime modificati=
on of the `gpio_mode_enforce` module parameter.
--

--- Patch [1]: [PATCH v2] HID: mcp2221: validate raw report length ---
commit 7349c59966a5598d3165aa4ca24a32b27b7b131a
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: HID: mcp2221: validate raw report length

The MCP2221A data sheet specifies 64-byte HID command and response
reports. mcp2221_raw_event() reads fixed response fields up to byte 55
and can copy a 60-byte I2C payload from byte 4 through byte 63 without
first checking the received size. Reject reports shorter than the fixed
protocol size before reading any response fields.

Link: https://lore.kernel.org/all/20260715083754.31210-1-pengpeng@iscas.ac.=
cn/

> diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
> index e4ddd8e9293b6..c910f6636ac95 100644
> --- a/drivers/hid/hid-mcp2221.c
> +++ b/drivers/hid/hid-mcp2221.c

[ ... ]

> @@ -639,11 +640,11 @@ static int mcp_gpio_read_sram(struct mcp2221 *mcp)
>  {
>  	int ret;
> =20
> -	memset(mcp->txbuf, 0, 64);
> +	memset(mcp->txbuf, 0, sizeof(mcp->txbuf));

[Severity: High]
This is a pre-existing issue, but I noticed mcp->txbuf is being zeroed and
populated here in mcp_gpio_read_sram() (and similarly in mcp_gpio_set() and
mcp_gpio_get()) before acquiring mcp->lock.

Because mcp->txbuf is shared with I2C operations, could this lead to data
corruption if mcp_i2c_xfer() is concurrently preparing an I2C transaction
under the lock? It looks like sysfs GPIO nodes and I2C device interfaces
can race here.

>  	mcp->txbuf[0] =3D MCP2221_GET_SRAM_SETTINGS;
> =20
>  	mutex_lock(&mcp->lock);
> -	ret =3D mcp_send_data_req_status(mcp, mcp->txbuf, 64);
> +	ret =3D mcp_send_data_req_status(mcp, mcp->txbuf, sizeof(mcp->txbuf));
>  	mutex_unlock(&mcp->lock);
> =20
>  	return ret;

[ ... ]

> @@ -861,6 +862,12 @@ static int mcp2221_raw_event(struct hid_device *hdev,
>  	u8 *buf;
>  	struct mcp2221 *mcp =3D hid_get_drvdata(hdev);
> =20
> +	if (size < MCP2221_REPORT_SIZE) {
> +		mcp->status =3D -EINVAL;
> +		complete(&mcp->wait_in_report);
> +		return 1;
> +	}
> +

[Severity: Critical]
This is a pre-existing issue, but does mcp2221_raw_event() have a
use-after-free or out-of-bounds write risk when handling delayed responses?

If mcp_send_data_req_status() times out inside mcp_i2c_smbus_read(), it
returns early without setting mcp->rxbuf to NULL. When a delayed I2C
response arrives later, wouldn't mcp2221_raw_event() copy up to 60 bytes
into this dangling mcp->rxbuf pointer?

[Severity: Critical]
This is also a pre-existing issue, but is there a TOCTOU race here with how
mcp->rxbuf and mcp->rxbuf_size are updated in mcp_i2c_smbus_read()?

If mcp_i2c_smbus_read() is updating these non-atomically:

mcp_i2c_smbus_read() {
    ...
    mcp->rxbuf =3D msg->buf;
    mcp->rxbuf_size =3D msg->len;
    ...
}

and an interrupt fires exactly between assigning a new 1-byte buffer to
mcp->rxbuf and updating mcp->rxbuf_size, could mcp2221_raw_event() bypass
the bounds check by reading the old, larger size?

>  	switch (data[0]) {
> =20
>  	case MCP2221_I2C_WR_DATA:

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but could runtime modifications
to the module parameter gpio_mode_enforce lead to a use-after-free during
device removal?

In mcp2221_remove(), the delayed work is conditionally canceled:

mcp2221_remove() {
    ...
    if (!gpio_mode_enforce)
        cancel_delayed_work_sync(&mcp->init_work);
    ...
}

Since gpio_mode_enforce has 0644 permissions, if it is changed to true
after the device is plugged in, won't mcp2221_remove() skip canceling
mcp->init_work? This would leave the work running after the mcp structure
is freed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715135916.2441=
7-5-pengpeng@iscas.ac.cn?part=3D1
