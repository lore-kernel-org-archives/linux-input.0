Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3F91684BE
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 04:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788494470; cv=none; b=HWfUCYUOM2P9v2HgjZjhpb5dWBQewMZEIymExNOvNfiZ337V1lfKUSXTLq7HCDjilqGTzUN6RFkKNCz+WaZAhoWRhU7snOQ8FWAhQSzEvqHDO81qLTWAtP3po0RFhXWrL3Ks78172CteviOfgq7Aqs2WLi9Z3Yz0+nQSUg6pnsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788494470; c=relaxed/simple;
	bh=mmZ4PwFRVSB4aVNEGuoWJem4yxu0BwfGCwN4Ht8JHtk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gSqME3LSd05OAuGrqLUF3k2JfZe0ED8jvy+q/dd9kgieDhqWQPik2aNp14osOKIDemNuTCQeljZvDOafR6n4nY4uZ8XAdD8vzvrMQ/F2NB5IAf4p7Ay8eu4Po8flrCEQwpGrHPbFN/ws2zKjb+SIll1FJ4nnEaLdUajqhKUR8BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDOwIpd9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDOwIpd9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1E41F00A3E;
	Fri,  4 Sep 2026 04:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788494469;
	bh=asjRNgv7bsKb0hRyUTYuyjdM9S8sY6+kl66l6wr3QKE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iDOwIpd9tpyLZJlX20tOWcmyolLu9U6x8zQ8FM/c14GRJ9In2zTa1e4CM/MVl3aZk
	 4/W9yqndBF698SxkoGEIxL+GpP/drtbJvdQAK//Mp4PbNpefB1Qv8AM8Wi2VhtxbbL
	 kzy0PqXGqTfGsbJes8ruo4EBiiVrg71JZ8che0UXO40/EQcHfd76ofeZ+B2KVo2Ib5
	 nNvfG06hc/wEDcDH1yjZhuKaHF9SYxzZ3LIGB7BTe91NE3y04YpSN7gnR/FHiCqtv9
	 llR0ts9Ucpd0qW3pe8zszqkZRLyKz/8I9U34/hBw1ghIuLuBZZ7rrciXeEVclb6DVO
	 LQEpYplDaEWVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: i2c-hid: Skip SET_POWER on shutdown for panel
 followers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Justin Yeh" <justin.yeh@mediatek.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260904035009.4114363-1-justin.yeh@mediatek.com>
References: <20260904035009.4114363-1-justin.yeh@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 04:01:08 +0000
Message-Id: <20260904040108.EF1E41F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The i2c-hid driver passes an unaligned, embedded structure to a DM=
A-safe I2C transfer, violating DMA safety rules for cacheline alignment.
- [High] Missing deregistration of panel follower in the shutdown path allo=
ws asynchronous panel callbacks to execute on a freed IRQ action.
--

commit 1cf5a880978c5891efe7abbc9352dfefd3ad2697
Author: Justin Yeh <justin.yeh@mediatek.com>
HID: i2c-hid: Skip SET_POWER on shutdown for panel followers

This commit modifies the shutdown sequence for i2c-hid devices that act as
panel followers. It skips the SET_POWER command to avoid bus timeouts on
reboot, as the panel's unpreparing callback already powers off the device.

> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c=
-hid-core.c
> index 0e725a0f0abee..13f3dcc52440f 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -1353,7 +1353,9 @@ void i2c_hid_core_shutdown(struct i2c_client *clien=
t)
>  {
>  	struct i2c_hid *ihid =3D i2c_get_clientdata(client);
> =20
> -	i2c_hid_set_power(ihid, I2C_HID_PWR_SLEEP);
> +	if (!ihid->is_panel_follower)
> +		i2c_hid_set_power(ihid, I2C_HID_PWR_SLEEP);
> +
>  	free_irq(client->irq, ihid);

[Severity: High]
This is a pre-existing issue, but does missing deregistration of the panel
follower in the shutdown path allow asynchronous panel callbacks to execute
on a freed IRQ action?

The commit relies on an implicit assumption that the DRM display controller
shuts down and unprepares the panel before the i2c-hid device shuts down.

However, if the probe ordering flips and i2c-hid's shutdown() runs first,
it calls free_irq() here but fails to remove the panel follower, unlike
remove() which correctly calls drm_panel_remove_follower().

Later, when the DRM controller shuts down and unprepares the panel, the
panel invokes the i2c-hid follower's panel_unpreparing callback. This
triggers i2c_hid_core_panel_follower_suspend(), which ultimately calls
disable_irq(client->irq) after free_irq() was already executed.

Could this cause a kernel WARNING and an unbalanced IRQ depth during system
reboot or shutdown?

> =20
>  	i2c_hid_core_shutdown_tail(ihid);

While reviewing this code, I also noticed another pre-existing issue regard=
ing
DMA safety in the driver's probe path.

In i2c_hid_core_fetch_hid_descriptor():

    error =3D i2c_hid_read_register(ihid,
                                  ihid->wHIDDescRegister,
                                  &ihid->hdesc,
                                  sizeof(ihid->hdesc));

This passes &ihid->hdesc (which is embedded inside the heap-allocated
struct i2c_hid and not independently cacheline aligned) as the receive
buffer.

Then in i2c_hid_xfer(), the I2C_M_DMA_SAFE flag is explicitly set:

    msgs[n].flags =3D (client->flags & I2C_M_TEN) |
                    I2C_M_RD | I2C_M_DMA_SAFE;
    msgs[n].len =3D recv_len;
    msgs[n].buf =3D recv_buf;

[Severity: High]
This isn't a bug introduced by this patch, but does explicitly setting
I2C_M_DMA_SAFE on an unaligned, embedded buffer violate cacheline alignment
rules for DMA-safe I2C transfers?

Could this cause memory corruption of adjacent fields in struct i2c_hid
during the DMA transaction due to cacheline sharing on cache-incoherent
architectures, bypassing the I2C core's bounce buffering?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904035009.4114=
363-1-justin.yeh@mediatek.com?part=3D1
