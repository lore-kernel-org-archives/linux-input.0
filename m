Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A372D44062D
	for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 07:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787209277; cv=none; b=rHxIaQUedpgHUMgqO5lL/NqWiFs7H6qCRSNiVFrqQZYnHXIcTTIlxoiG2ay1qZ8kBe1CFCBkFJlkaZUGg59DKNvo2bGLTt7Yztzr/mTx44EUF+AjZAjFrHkdlF1sZnxQfKmZV+w86z5K6T1woEjoLJtHX1gUqPbjWdmGOLSank8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787209277; c=relaxed/simple;
	bh=yaU8mRbH0VdGUL1bh6y+lCSNyzR/JPDoPKeoyNoL6SY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vx7Lf6byrdaY5eRPBcui2QFJaMHseTIzVAhLN0tiVl3EXtwSKS+0+aqQTkoZP+2tRS/i0Rc5SCTImgEotlNJAH9LqEt/spEA0eYMNUpAOH8hUnavY8lTntPSjMxJE9EhFP0MclWG7wZZqOP6UHQqwiRSOWevkRJr/7XBdwKd6ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PojsleS3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PojsleS3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E291F000E9;
	Thu, 20 Aug 2026 07:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787209276;
	bh=BctkFlVAGNTzYUKAPkBaZPAyCB5URXsTLj2A3idNwd0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PojsleS3blMlFGMDpUpvrWFDUeqWcEXLL4/iP59r9GPj4ezT0DhWvSbG5DJWSs0YQ
	 4tR4TmBPtwAyyPGd+2NFAc1it+0Zjd1Oh/cfWHt3qYoRQMfK1uGNhRHwDKNNw7j4fz
	 un5S+fz1wh3jxx878HUhikYbe3fgcFNijr+h6lr+3YCW/JsCj+2DLK+dPtb8V2/4LS
	 OP7ZIZVfvf4emBDlMJVN9nObB8j/RoaKaF/GcD6Jhb2gobrA8iCLg5RAAQIpPEJKZ3
	 p+9oUm9cvxaKAogYofC3pFLVefoRYE7ZaEhYvIkYvqNq/9q5cPEFhwmJP1d+WZQI2x
	 l4X7tpWyZ66pA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: raspberrypi-ts - reject out-of-range point
 counts and slot IDs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linkai Gong" <gonglinkai@kylinos.cn>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260820065340.3765457-1-gonglinkai@kylinos.cn>
References: <20260820065340.3765457-1-gonglinkai@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 07:01:15 +0000
Message-Id: <20260820070116.04E291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Returning early inside the touch reporting loop when encountering =
an out-of-bounds `touchid` leaves the input core with a partially updated, =
unsynchronized event frame, causing permanent ghost touches.

Pre-existing issues:
- [Critical] The driver fails to instruct the GPU firmware to stop writing =
to the physical DMA buffer before freeing it, resulting in a DMA use-after-=
free.
--

--- Patch [1]: [PATCH] Input: raspberrypi-ts - reject out-of-range point co=
unts and slot IDs ---
commit f72d20735f09ac5b0ab187efd0cc082fb9bc5bcf
Author: Linkai Gong <gonglinkai@kylinos.cn>

Input: raspberrypi-ts - reject out-of-range point counts and slot IDs

This commit drops out-of-bounds point counts and adds a bounds check to
drop frames containing invalid slot IDs. This prevents corrupted touch IDs
from causing out of bounds accesses.

Cc: stable@vger.kernel.org

> diff --git a/drivers/input/touchscreen/raspberrypi-ts.c b/drivers/input/t=
ouchscreen/raspberrypi-ts.c
> index 841d39a449b37..bd63d95c094b9 100644
> --- a/drivers/input/touchscreen/raspberrypi-ts.c
> +++ b/drivers/input/touchscreen/raspberrypi-ts.c
> @@ -78,6 +78,7 @@ static void rpi_ts_poll(struct input_dev *input)
>  		 ts->fw_regs_va + offsetof(struct rpi_ts_regs, num_points));
> =20
>  	if (regs.num_points =3D=3D RPI_TS_NPOINTS_REG_INVALIDATE ||
> +	    regs.num_points > RPI_TS_MAX_SUPPORTED_POINTS ||
>  	    (regs.num_points =3D=3D 0 && ts->known_ids =3D=3D 0))
>  		return;
> =20
> @@ -87,6 +88,9 @@ static void rpi_ts_poll(struct input_dev *input)
>  		touchid =3D (regs.point[i].yh >> 4) & 0xf;
>  		event_type =3D (regs.point[i].xh >> 6) & 0x03;
> =20
> +		if (touchid >=3D RPI_TS_MAX_SUPPORTED_POINTS)
> +			return;

[Severity: High]
Does returning early here leave the input core with a partially updated,
unsynchronized event frame?

If earlier iterations of this loop processed valid contacts, returning here
aborts the processing after partial state mutations have already occurred.
This skips the required input_sync() call at the end of rpi_ts_poll(),
which could leave the input core with unsynchronized event state and cause
permanent ghost touches or stuck slots.

> +
>  		modified_ids |=3D BIT(touchid);
> =20
>  		if (event_type =3D=3D RPI_TS_FTS_TOUCH_DOWN ||

[ ... ]

[Severity: Critical]
This isn't a bug introduced by this patch, but does the driver fail to
instruct the GPU firmware to stop writing to the physical DMA buffer before
freeing it?

In rpi_ts_probe(), the firmware is instructed to asynchronously write to
the touch buffer:

	error =3D rpi_firmware_property(fw, RPI_FIRMWARE_FRAMEBUFFER_SET_TOUCHBUF,
				      &touchbuf, sizeof(touchbuf));

During device removal or unbind, rpi_ts_dma_cleanup() frees this buffer:

	dma_free_coherent(dev, PAGE_SIZE, ts->fw_regs_va, ts->fw_regs_phys);

Without a corresponding action to tell the firmware to stop writing to this
address (such as sending a value of 0), the firmware might continue to write
touchscreen coordinates to freed memory, leading to a DMA use-after-free
and silent memory corruption.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820065340.3765=
457-1-gonglinkai@kylinos.cn?part=3D1
