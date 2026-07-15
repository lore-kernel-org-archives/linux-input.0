Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877833BFACA
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 21:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784152660; cv=none; b=Q+IprDnlVMCe/2mIS0KnppAQggLZl9xSZMLt+XB5Q1CNuAFfpodxu/TBllo1BSKKoNe4By0EvfVN2kFKM/wD0jBe69F6Rb8veX9xN1PyftZyQnreFIqRvDsXBPku7li0jF7fdn7uNJvugE1JQylqzaZRDfsvAEcIqV7QrNx46ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784152660; c=relaxed/simple;
	bh=k4sowiCepKz8K54/sRygaZqa/Qu/HaxuTCpeMSn1lD0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WWpJmne1LPB3M8PGod/7CqOtmCXSOLCpeSLpF+JVBVNz1xGcKu+doyMEJYwzdEkUZqDnR/6nrbpBR2y3mbcGmN+9uJQnNFEXEfKUpWrTj5618PzsUcH5G+kc7feskjOnOMqOkmKj+dKhRf7jcSMYNzDyVKxtrNqKPmFoHXg7MaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1Y9c3uc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1Y9c3uc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36DB1F000E9;
	Wed, 15 Jul 2026 21:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784152658;
	bh=ZI/MVc5BYpi0/rbxSKF4gSoMyTMQhnK4FxTQatnPCKg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T1Y9c3ucIQA8i+Rz3s0XjIhcRBootvQyO74xRzdkiZsbcPtWX5uipxC1Kyn6i983V
	 pJ28J7E9FVBIwLaBa2X5IrSwWdKGvQe9VKivlluVsj18i1dDJtwwroXgPHgo4R8dKJ
	 YVr9yLziZwOWtFR7T9wnJs1HPBHdqk/gMuPp+vBT0x4kVpF5a45tO5aCvgUxmz6MOy
	 wp4vljtpflRIraoAdjNqXn6sDiyuKw3l+crUOFHQB/wDRCvtFrTAP7puIagkEoy+eE
	 /+kbLZCspEjRNitBaMC9W+PvXRgMi9KfX0g5MxrlmCQNauoguck1tIdiS76K4mnvQq
	 bFVxwiY1OoT4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] HID: wiimote: fix uaf when hid events are
 handled during destroy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael Passos" <rafael@rcpassos.me>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260715212501.3920033-5-rafael@rcpassos.me>
References: <20260715212501.3920033-1-rafael@rcpassos.me>
 <20260715212501.3920033-5-rafael@rcpassos.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 21:57:37 +0000
Message-Id: <20260715215737.D36DB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Module cleanup commands (e.g., rumble off, LEDs off) are dropped=
 during driver unload, leaving the controller hardware in an incorrect or s=
tuck state.
--

--- Patch [4]: [PATCH v2 4/4] HID: wiimote: fix uaf when hid events are han=
dled during destroy ---
commit 62bea240ecf4b4da704b1580ca426a1f9c83501a
Author: Rafael Passos <rafael@rcpassos.me>

HID: wiimote: fix uaf when hid events are handled during destroy

This commit adds a flag check to wiimote_queue() to drop events
if the driver is in the process of unloading. This mitigates a
use-after-free issue when handling events during destroy.

> diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-cor=
e.c
> index b549a7d58d512..c9638ec352e44 100644
> --- a/drivers/hid/hid-wiimote-core.c
> +++ b/drivers/hid/hid-wiimote-core.c
> @@ -92,6 +92,9 @@ static void wiimote_queue(struct wiimote_data *wdata, c=
onst __u8 *buffer,
>  	 */
> =20
>  	spin_lock_irqsave(&wdata->queue.lock, flags);
> +	/* Do not schedule work if controller is exiting */
> +	if ((wdata->state.flags & WIIPROTO_FLAG_EXITING))
> +		goto out_unlock;

[Severity: Medium]
Will this aggressively drop hardware cleanup commands during driver unload?

Looking at wiimote_destroy(), the exiting flag is set before calling
wiimote_modules_unload():

drivers/hid/hid-wiimote-core.c:wiimote_destroy() {
    ...
	/* prevent init_worker from being scheduled again */
	scoped_guard(spinlock_irqsave, &wdata->state.lock)
		wdata->state.flags |=3D WIIPROTO_FLAG_EXITING;
    ...
	wiimote_modules_unload(wdata);
    ...
}

If a user unbinds the driver or disconnects the controller while rumble is
active, wiimote_modules_unload() invokes wiimod_rumble_remove() to send
a command to turn the rumble off.

Will this check in wiimote_queue() unexpectedly drop the rumble-off
packet, leaving the physical controller vibrating indefinitely?

> =20
>  	memcpy(wdata->queue.outq[wdata->queue.head].data, buffer, count);
>  	wdata->queue.outq[wdata->queue.head].size =3D count;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715212501.3920=
033-1-rafael@rcpassos.me?part=3D4
