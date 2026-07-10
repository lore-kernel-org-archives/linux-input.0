Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4971F4071E5
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 15:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783698415; cv=none; b=kq8y1Vb6G87+AK4xYhoG5Wa2bHRcwm71grg4KGK46Yd3c/KaMvJLRkirO1cmmHnMWTWDX5Cd2l1YToGHIKmyRdQnL3D1nl8mKmEdv8rtFzBwn3gyRdsmzm4y5tdK5Jv1X6Uy2NXtrFGCMtLmo92WY+1vqsMwoxryw8zQvgdAM6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783698415; c=relaxed/simple;
	bh=4GzteFK2+dKMWr7WuuA8PhPVYb9KPF9/ercVJzN8500=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fEC1J5ToR2G+YJGM65Fxv+kBbRw+LRFfKXdTJku2eD9LrjoqAUCuyaQ5464ek/DRWS2UyWQwqRkqLVX06I2ID5zIbIEkPY7a7cYz+Xx3S83t2eYQ5dwWf9+PHT4virZzQZPvGUrVycgGAbytXh5oY5MYSplLhRjxJZvyF2xB0ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiOtRmE3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiOtRmE3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92A91F000E9;
	Fri, 10 Jul 2026 15:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783698413;
	bh=QS3KH88l2940XAZi7Am/jLcQrZEonc6sCnHPxZotCDM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JiOtRmE3UKX/cxpbhDHqmtXRRgMG71BwhTjYbABOmVRmTDNoJCDHHWlSFH/RFbsOO
	 /TnQcQUV0PWBLKC/2AoVenF5037LJ3l261bxd554W7ql/vNsU5UGPXRjAC4njuMddq
	 bEHEvHf9YsM8RXFJ7QR/wh6+/qZNsXmTeKu/Rssq56qkckPKGzQV9xL8np/dhdRTpv
	 US4IW3hwVIjg1oVrP0Wk5d89Zg/vsmEAXGDa/fKQQCrpAirRUMCzyLGeVEmSwKBVMY
	 pPFpUVnsyPU+vJJCkYJ7UkCxyCOfKYEyannTo/QZP8Dk2T8CA0pFpa0Ij/jWO2dgXv
	 HMcw/fA1+CSng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] HID: wiimote: turn on the LEDs indicating the
 controller id
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael Passos" <rafael@rcpassos.me>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260710153456.2093889-2-rafael@rcpassos.me>
References: <20260710153456.2093889-1-rafael@rcpassos.me>
 <20260710153456.2093889-2-rafael@rcpassos.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 15:46:52 +0000
Message-Id: <20260710154652.E92A91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Incorrect error check for `ida_alloc_min()` fails to catch negativ=
e error codes, leading to an out-of-bounds array read on `player_leds`.
- [Medium] The fallback logic for IDA allocation failure incorrectly claims=
 ID 1, leading to ID collisions and corruption of the IDA state upon remova=
l.
- [Medium] Mixing of `goto`-based error handling and scope-based cleanup he=
lpers (`scoped_guard`) in the same function.
- [Low] Defining a static array in a header file duplicates it across multi=
ple translation units.

Pre-existing issues:
- [High] Missing `state.lock` when calling `wiimote_cmd_abort` in `wiimote_=
queue`.
--

--- Patch [1]: [PATCH 1/3] HID: wiimote: turn on the LEDs indicating the co=
ntroller id ---
commit 48125f73deb74f22332d54c849af1f5b48042ab2
Author: Rafael Passos <rafael@rcpassos.me>

HID: wiimote: turn on the LEDs indicating the controller id

This commit introduces a new feature to assign an ID to each connected
Wiimote using an IDA struct. It also updates the module loading sequence
to cycle the LEDs from 1 to 4 to visually indicate the assigned player ID.

> diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-cor=
e.c
> index 63c4fa8fbb9b6..0d36a38bdcdad 100644
> --- a/drivers/hid/hid-wiimote-core.c
> +++ b/drivers/hid/hid-wiimote-core.c

[Severity: High]
This isn't a bug introduced by this patch, but does wiimote_queue() call
wiimote_cmd_abort() while holding queue.lock instead of state.lock?

drivers/hid/hid-wiimote-core.c:wiimote_queue() {
...
out_error:
	wiimote_cmd_abort(wdata);
out_unlock:
	spin_unlock_irqrestore(&wdata->queue.lock, flags);
}

The documentation for wiimote_cmd_abort() specifies that it requires
state.lock:

drivers/hid/hid-wiimote.h:
/* requires the state.lock spinlock to be held */
static inline void wiimote_cmd_abort(struct wiimote_data *wdata)

Could this cause a data race with other command state accesses?

[ ... ]

> @@ -671,6 +671,12 @@ static void wiimote_modules_load(struct wiimote_data=
 *wdata,
>  	spin_lock_irq(&wdata->state.lock);
>  	wdata->state.devtype =3D devtype;
>  	spin_unlock_irq(&wdata->state.lock);
> +
> +	/* after loading all modules, set the LED for the player ID cycling fro=
m 1 to 4*/
> +	scoped_guard(spinlock_irqsave, &wdata->state.lock) {
> +		wiiproto_req_leds(wdata, player_leds[(wdata->instance_id - 1) % 4]);
> +	}
> +
>  	return;
> =20
>  error:

[Severity: Medium]
Is it acceptable to mix scope-based cleanup helpers like scoped_guard()
with goto-based error handling in the same function?

The cleanup documentation states that goto-based cleanup and scope-based
cleanup should not be mixed within the same routine.

[ ... ]

> @@ -1834,7 +1844,15 @@ static int wiimote_hid_probe(struct hid_device *hd=
ev,
>  	if (ret)
>  		goto err_free;
> =20
> -	hid_info(hdev, "New device registered\n");
> +	instance_id =3D ida_alloc_min(&wiimote_ida, 1, GFP_KERNEL);
> +	if (!instance_id) {
> +		hid_err(hdev, "cannot allocate controller id, defaulting to 1\n");
> +		instance_id =3D 1;
> +	}

[Severity: High]
Since ida_alloc_min() returns a negative error code on failure rather than =
0,
does this check fail to catch allocation errors?

If ida_alloc_min() fails and returns a negative error code, the later
calculation in wiimote_modules_load():

    player_leds[(wdata->instance_id - 1) % 4]

would result in a negative modulo and an out-of-bounds array read.

[Severity: Medium]
Additionally, if the IDA allocation fails and this fallback logic is reache=
d,
does assigning instance_id =3D 1 without actually reserving it in the IDA
risk corrupting the state?

[ ... ]

> @@ -1862,6 +1880,8 @@ static void wiimote_hid_remove(struct hid_device *h=
dev)
>  {
>  	struct wiimote_data *wdata =3D hid_get_drvdata(hdev);
> =20
> +	ida_free(&wiimote_ida, wdata->instance_id);
> +
>  	hid_info(hdev, "Device removed\n");
>  	wiimote_destroy(wdata);
>  }

[Severity: Medium]
If the fallback logic in wiimote_hid_probe() set instance_id to 1 without
reserving it, will this unconditional free corrupt the IDA state if another
device had legitimately claimed ID 1?

[ ... ]

> diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
> index 9c12f63f6dd2d..639f67c24f15f 100644
> --- a/drivers/hid/hid-wiimote.h
> +++ b/drivers/hid/hid-wiimote.h
> @@ -50,6 +50,13 @@
>  #define WIIPROTO_FLAGS_IR (WIIPROTO_FLAG_IR_BASIC | WIIPROTO_FLAG_IR_EXT=
 | \
>  							WIIPROTO_FLAG_IR_FULL)
> =20
> +static const __u8 player_leds[] =3D {
> +        WIIPROTO_FLAG_LED1,
> +        WIIPROTO_FLAG_LED2,
> +        WIIPROTO_FLAG_LED3,
> +        WIIPROTO_FLAG_LED4
> +};
> +

[Severity: Low]
Does defining a static array in a header file cause it to be unnecessarily
duplicated in the .rodata section for every translation unit that includes
hid-wiimote.h?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710153456.2093=
889-1-rafael@rcpassos.me?part=3D1
