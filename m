Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BD92D9EED
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 21:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788123888; cv=none; b=KPu+6CaFFGZddT3xRNobmsucHtmsupPVak2M8ecdfgJXMla3VJ7a8QIMHRdyKEwCxjmqzKh6U8Gpmmm0jHmeFKGCFzj8yHSjOdWcjfM1N8Tpk1ntPyrIJYc8nF2vzxi7dx9f3GEBtltQuM2M89CsQ3a48gqw3rWLgClkTiCUpdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788123888; c=relaxed/simple;
	bh=D1NHns7KVHoEgA9/zbG1OVBBFTw1Jfk+OZINBuJ9OWo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NKdhONn+uWjIazozfJj9s/9nWZuUxsBm4qmJ3ZcBK1RTcqFrcKKAoATS/CKb7GRpYTczNVEYw+AVAHonj4Tb3Nv7R/95Swf/q1WlZf4F7gs1s0XnYmTM2xsOj0ERWjESj+qE5o5t3Sq6BuTN9TV1wTBjCtNjM6d5p1Ke9FlF/uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEdYuHBc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEdYuHBc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8D31F000E9;
	Sun, 30 Aug 2026 21:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788123887;
	bh=ZjArutqQkZzGNYL2gcGgagGmGDoffJw+AY2LWPnz2oc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QEdYuHBcwDhJ2NwgAWUreYQct4Jr3JYbnXfOGSiL6l194iu11OUvyUYmyE8L3snTX
	 wJpn/kMqZ4A45uLvwZ9FDzASAZzSglK2o5Yxt/EY8jT9+vj8YU28c9BLIEYiWfUeKy
	 8lQhd5u//nfIIa98yzeQys/rMQGHkD2+F5drGmPSryh2dbU+/f00JRpXpIyraUFm0o
	 ZIrBmci0OITuCGV2c7/z/3NzzNMhbsf+lrzkxMbbfk2YkTQKUJviK3322hVtm2eQ5J
	 YoeatU2jvFG8G7iayzBiOHueCeh1gGdIlxaKWgYwJkp/61MeJBjgZgwx4tVcHj3Uj3
	 mDMY6b3rkuJnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] Input: gscps2 - clean up driver code style and
 structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260830-gscps2-v1-1-c733d4cae7f9@gmail.com>
References: <20260830-gscps2-v1-0-c733d4cae7f9@gmail.com>
 <20260830-gscps2-v1-1-c733d4cae7f9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 21:04:46 +0000
Message-Id: <20260830210447.0C8D31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The busy-wait loop in `gscps2_writeb_output` polling the hardware =
status register lacks a timeout, creating a hard lockup (deadlock) risk whe=
n invoked with local interrupts disabled.
--

commit edfe57337208b53162446f9db3e046a15ffe59af
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: gscps2 - clean up driver code style and structure

This commit cleans up code style and function ordering in the gscps2 driver.
It updates macro definitions, replaces printk with dev_dbg, and introduces
cpu_relax() into the spin-wait loops.

> diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
> index 43453ec533b22..b82c56ba8ff70 100644
> --- a/drivers/input/serio/gscps2.c
> +++ b/drivers/input/serio/gscps2.c

[ ... ]

> +/*
> + * gscps2_writeb_output() - write a byte to the port
> + *
> + * returns 1 on success, 0 on error
> + */
> +static inline int gscps2_writeb_output(struct gscps2port *ps2port, u8 da=
ta)
> +{
> +	char __iomem *addr =3D ps2port->addr;
> +
> +	if (!wait_TBE(addr)) {
> +		dev_dbg(&ps2port->padev->dev, "timeout - could not write byte %#x\n", =
data);
> +		return 0;
> +	}
> +
> +	while (gscps2_readb_status(addr) & GSC_STAT_RBNE)
> +		cpu_relax();

[Severity: High]
This is a pre-existing issue, but does this busy-wait loop risk a hard CPU
lockup when invoked with local interrupts disabled?

A PS/2 driver like atkbd can call serio_write() from an interrupt context
with local IRQs disabled (for example, in atkbd_interrupt sending
ATKBD_CMD_RESEND in response to a parity error).

If a new byte arrives in the receive buffer concurrently, the GSC_STAT_RBNE
bit is set. Since local IRQs are disabled, the hardware interrupt handler
cannot run to read the pending byte. This means GSC_STAT_RBNE will never
clear and the CPU could hang indefinitely waiting for the buffer to empty.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830-gscps2-v1-=
0-c733d4cae7f9@gmail.com?part=3D1
