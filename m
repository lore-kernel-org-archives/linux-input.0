Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE1E2F7EEF
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 06:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783145523; cv=none; b=YCgKfBxMStpLnm1SVg+YFwP9/Lgc8u2846iNsmSn4GuXAiTC1xSukCkES2lfRrBr4AIhxCzvEdFqqzG/VH7PDxtfsFFrLaNzkBsdBx6nI7gjRhOVfxpLiMXawrnuM7BHS3V/s379ak2CqQ3J9TImqCyRC51UmTttZR9NTgaeBPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783145523; c=relaxed/simple;
	bh=ke69U3GJZvOvRj/zWztezNysAgCGfCcDN0vF3kVE5ss=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eQT4mZSolZhc7UHKOCr9i6ZCeVsCLckecguspX27SGVlS6aEaoWxuDyBTcxcCRO1UjynFQjZn2h5Yy+rpnlZAhMhlAf+8AHHYRcgDJeKVEeDwA6bWzsxK0tpaqUYmU+aAsYM5dA6ZbbmtyjIrQBm/Px3fVvH5Eh5YBX1w7cgPPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXfWEm/W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXfWEm/W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400D81F000E9;
	Sat,  4 Jul 2026 06:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783145522;
	bh=TIWclublxodxKGHy32t8AedmAvdrjE/uuwTUXVX7TPE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gXfWEm/WuBwT3mSbrPhXf1dYkAPR8if10qropmz8P+hbomUarRuxfy7kuKM3sgSlp
	 sSfGQxGTmOV/JHHm7VBrXSX1M7ZmLUjRg7dDj15RVsvkRCwsoMWS3tct2kqHOhE8Jt
	 j221qoBXAD28X0qyAeeNzC6kbaqDhXTbyqm0nJe8DzdorMWbCNmsrd2gAMZlcP0rBu
	 fN/4Oz1mBhdxNiW4d+NQzxnjogu0K4HsnbXejopJB9LILUIE2iw6nQzXH9PLi9VQ3c
	 Y2K7nhud38+/Nz/GP3fpFZM9dZq2fuQvbg2E3mC2/KWpSYcKOA08ksp7dY/wS/1DJm
	 bQWBWrN1DQc3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] Input: mms114 - fix endianness portability in I2C
 packet layout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260704060115.353049-2-dmitry.torokhov@gmail.com>
References: <20260704060115.353049-1-dmitry.torokhov@gmail.com>
 <20260704060115.353049-2-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 06:12:01 +0000
Message-Id: <20260704061202.400D81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition in suspend causes stuck touches.
- [High] Unsafe DMA buffer allocation (stack-allocated memory passed to I2C=
 transfers).
--

commit 2e96699ad380d6d47c8e998bc41268e9b77bac90
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: mms114 - fix endianness portability in I2C packet layout

The driver defines the I2C packet layout using C bitfields in struct
mms114_touch. This is not portable as the layout of bitfields within a
byte is compiler-dependent and varies with endianness. On Big Endian
systems, the fields will be parsed incorrectly.

> diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscre=
en/mms114.c
> index 23e0283bc6b8b..84afdadb3bccc 100644
> --- a/drivers/input/touchscreen/mms114.c
> +++ b/drivers/input/touchscreen/mms114.c

[ ... ]

> @@ -325,8 +338,9 @@ static irqreturn_t mms114_interrupt(int irq, void *de=
v_id)
> =20
>  	for (index =3D 0; index < touch_size; index++) {
>  		t =3D (struct mms114_touch *)((u8 *)touch + index * event_size);

[Severity: High]
This isn't a bug introduced by this patch, but does passing stack-allocated
buffers to I2C transfer functions risk memory corruption if the I2C adapter
uses DMA?

Since kernel stacks are often allocated in vmalloc space (when
CONFIG_VMAP_STACK is enabled), they cannot be safely mapped for DMA.

In mms114_interrupt(), the touch array is stack-allocated and used as a
receive buffer:

	struct mms114_touch touch[MMS114_MAX_TOUCH];
	// ...
	error =3D __mms114_read_reg(data, MMS114_INFORMATION, packet_size, touch);

Similarly, __mms114_read_reg() and mms114_write_reg() pass local stack
variables (u8 buf and u8 buf[2]) to I2C transfers.

> +		unsigned int type =3D FIELD_GET(MMS114_FLAGS_TYPE_MASK, t->flags);
> =20
> -		switch (t->type) {
> +		switch (type) {
>  		case MMS114_TYPE_TOUCHSCREEN:
>  			mms114_process_mt(data, t);
>  			break;

[ ... ]

[Severity: High]
This is a pre-existing issue, but could the sequence in mms114_suspend()
have a race condition that results in stuck touches?

In mms114_suspend(), the driver injects artificial release events before
disabling the IRQ:

	/* Release all touch */
	for (id =3D 0; id < MMS114_MAX_TOUCH; id++) {
		input_mt_slot(input_dev, id);
		input_mt_report_slot_inactive(input_dev);
	}
	// ...
	input_sync(input_dev);

	guard(mutex)(&input_dev->mutex);

	if (input_device_enabled(input_dev))
		mms114_stop(data);

If a touch interrupt fires and its threaded handler (mms114_interrupt)
executes after these release events are injected but before mms114_stop()
disables the IRQ, might it report the touch as active again and leave it
stuck indefinitely after suspend?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704060115.3530=
49-1-dmitry.torokhov@gmail.com?part=3D2
