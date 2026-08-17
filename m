Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6313BBFCC
	for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 21:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787003953; cv=none; b=ZoBBhHnlGo3Z99ECRjLreCnwBFkJrMljPjFcZHA5NdH9dH9ivNxBgxrKzSYSjdnefuLCd0/E2+djtG18oO5OSx+XYDOfag2xp5zn12PcK4RVhxrVL2E1KMPF9I6G0s51/dci6zkmTYnv6LmerEBMOLX++UsaPCRpnOXNkrDUQTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787003953; c=relaxed/simple;
	bh=ZKK5YoVaGBUFm35kK42Xd4P6qHGNvInBEelQxI8GCUQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S0zrl+7GWO4n6x14XnmwzYsjRX7F96dPmpcpFeQKkO11a+Q4l4HRIkWuWfLXhSEkvNwytWE3HGguUqzluG+i4xe4Q0tWAoQK8WXfBX/pyUdu4FeHfcDLLquwHY3hiCvAi5uoKDPcHFSRKVloskO6Dj8yzskVXRmL001qR9c/94w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9lwdilJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9lwdilJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25AA1F000E9;
	Mon, 17 Aug 2026 21:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787003951;
	bh=S4AK/HMtFQyt3a7ONEyeQDeEcDGaqPQuRmoXVMsHmU0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X9lwdilJjkQjjEys1Ngz1WoB87X3TXvRHpFpXR1z3fRxCxx4QOHc4M51aX5vQCaHP
	 D9xW9XDwU0HECuf/EEPL+ErJ3fy71WGCz9fmT1yIH7XGQEgky4+8p3DV7tb8Bhq0AC
	 uQI5hIXWtjT9qtazqGXCfoAcd73NQ3t508cA6UDrmbqH7baQuQwzllenTAVEx6n9gs
	 FxhF3Ivn8Ui69mriwQTEqv4q9NzbdPy/VCbYbiozNKUjereyeNRPUWGWdyzYAKbYPj
	 BXr8FE8FiPgYXVhtHa4E6UuTGaU01Mz+MXVsxGX7M6VmaHqplERhulQ93CmP9dZLi3
	 +LytojgBHynrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] HID: wiimote: replace spinlock pairs with
 scoped_guard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael Passos" <rafael@rcpassos.me>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260817213840.1053216-3-rafael@rcpassos.me>
References: <20260817213840.1053216-1-rafael@rcpassos.me>
 <20260817213840.1053216-3-rafael@rcpassos.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 21:59:10 +0000
Message-Id: <20260817215910.E25AA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Low] Functions improperly mix goto-based cleanup labels with scoped_guar=
d usage.
- [Low] Inconsistent space-based indentation utilized inside scoped_guard b=
locks.
- [Low] The commit message inaccurately describes the formatting configurat=
ion of one-liner scoped_guards.

Pre-existing issues:
- [High] The `queue.worker` can be rescheduled after cancellation because h=
ardware polling is stopped too late.
--

--- Patch [2]: [PATCH v4 2/4] HID: wiimote: replace spinlock pairs with sco=
ped_guard ---
commit 7580c2db3c79e9b0eeae8d3525656cfd7d171c35
Author: Rafael Passos <rafael@rcpassos.me>

    HID: wiimote: replace spinlock pairs with scoped_guard

This commit replaces manual spinlock lock/unlock pairs with scoped_guard
across the wiimote driver to improve safety and maintainability.

>     The multi line spinlock blocks were replaced by braced scoped_guard,
>     and one-liners by a scoped_guard without braces nor indentation.

[Severity: Low]
This isn't a bug, but there's a discrepancy in the commit message. The=20
one-liners in the diff correctly retain their tab indentation for the=20
guarded statement (e.g., in wiimote_cmd_read), contradicting the=20
description here.

> diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-cor=
e.c
> index acf31d8b6991d..05f8ddb7909bc 100644
> --- a/drivers/hid/hid-wiimote-core.c
> +++ b/drivers/hid/hid-wiimote-core.c
[ ... ]
> @@ -362,13 +363,12 @@ void wiiproto_req_rmem(struct wiimote_data *wdata, =
bool eeprom, __u32 offset,
>  int wiimote_cmd_write(struct wiimote_data *wdata, __u32 offset,
>  						const __u8 *wmem, __u8 size)
>  {
> -	unsigned long flags;
>  	int ret;
> =20
> -	spin_lock_irqsave(&wdata->state.lock, flags);
> -	wiimote_cmd_set(wdata, WIIPROTO_REQ_WMEM, 0);
> -	wiiproto_req_wreg(wdata, offset, wmem, size);
> -	spin_unlock_irqrestore(&wdata->state.lock, flags);
> +	scoped_guard(spinlock_irqsave, &wdata->state.lock) {
> +	    wiimote_cmd_set(wdata, WIIPROTO_REQ_WMEM, 0);
> +	    wiiproto_req_wreg(wdata, offset, wmem, size);
> +	}

[Severity: Low]
This isn't a bug, but does this inner block use spaces for indentation=20
instead of standard tabs?

>  	ret =3D wiimote_cmd_wait(wdata);
>  	if (!ret && wdata->state.cmd_err)
[ ... ]
> @@ -675,11 +673,8 @@ static void wiimote_modules_load(struct wiimote_data=
 *wdata,
>  			goto error;
>  	}
> =20
> -	spin_lock_irq(&wdata->state.lock);
> -	wdata->state.devtype =3D devtype;
> -	spin_unlock_irq(&wdata->state.lock);
> -
>  	scoped_guard(spinlock_irqsave, &wdata->state.lock) {
> +		wdata->state.devtype =3D devtype;
>  		/* after loading modules, set the Player ID LED cycling from 1 to 4*/
>  		wiiproto_req_leds(wdata, player_leds[(wdata->player_id - 1) % 4]);
>  	}
> @@ -703,13 +698,11 @@ static void wiimote_modules_unload(struct wiimote_d=
ata *wdata)

[Severity: Low]
Does this mix goto-based error handling (the goto error statements above)=20
with cleanup helpers in the same function?

The cleanup subsystem guidelines suggest that for a given routine, we=20
should convert all resources that need a goto cleanup to scope-based=20
cleanup, or convert none of them. This pattern also appears in=20
wiimote_init_detect and wiimote_init_check.

[ ... ]
> @@ -1120,16 +1106,15 @@ static void wiimote_init_hotplug(struct wiimote_d=
ata *wdata)
> =20
>  	wiimote_cmd_acquire_noint(wdata);
> =20
> -	spin_lock_irq(&wdata->state.lock);
> -
> -	/* get state snapshot that we will then work on */
> -	flags =3D wdata->state.flags;
> +	scoped_guard(spinlock_irq, &wdata->state.lock) {
> =20
> -	/* disable event forwarding temporarily */
> -	wdata->state.flags &=3D ~WIIPROTO_FLAG_EXT_ACTIVE;
> -	wdata->state.flags &=3D ~WIIPROTO_FLAG_MP_ACTIVE;
> +	    /* get state snapshot that we will then work on */
> +	    flags =3D wdata->state.flags;
> =20
> -	spin_unlock_irq(&wdata->state.lock);
> +	    /* disable event forwarding temporarily */
> +	    wdata->state.flags &=3D ~WIIPROTO_FLAG_EXT_ACTIVE;
> +	    wdata->state.flags &=3D ~WIIPROTO_FLAG_MP_ACTIVE;
> +	}

[Severity: Low]
This isn't a bug, but it looks like spaces are used here instead of tabs=20
for the indentation inside the scoped_guard block.

[ ... ]

[Severity: High]
This is a pre-existing issue, but can the wdata->queue.worker be=20
rescheduled after it is canceled during device teardown?

Looking at wiimote_destroy (which is not modified in this patch but=20
is in the same file):

	cancel_work_sync(&wdata->queue.worker);

	if (wdata->init_state & WIIMOTE_PROBE_HW_OPENED)
		hid_hw_close(wdata->hdev);
	if (wdata->init_state & WIIMOTE_PROBE_HW_STARTED)
		hid_hw_stop(wdata->hdev);

	kfree(wdata);

If the hardware sends a report between the cancel_work_sync and=20
hid_hw_stop calls, wiimote_hid_event could process it and queue=20
a request via wiimote_queue, which calls=20
schedule_work(&wdata->queue.worker).

Since wdata is freed immediately after hid_hw_stop, would the=20
rescheduled worker later access the freed wdata structure and cause a=20
use-after-free? Should hid_hw_stop be called before canceling the=20
worker?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817213840.1053=
216-1-rafael@rcpassos.me?part=3D2
