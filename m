Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD5F3BB12D
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860938; cv=none; b=oaZi+iCf587poYMlk0KBolwJn09ZNJrzMrvcLsvLcAn4lfdy7l4ZKHbrUHiScB3AiBBF+BfQVU8OIOilnY0WYnh4vhC7jGpH3ZySLOx4p0f5VKJunnxFrB8cR6ziavnPksdqDVre+cXzyElBWIAbMvNQeZJqDr8V4e8hQwssCYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860938; c=relaxed/simple;
	bh=PZp5v74HdPPMIZyTrRaWmosmqbgP5WAZUjCqdQ9/E7k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PxwOiXkOP8LHJuIusaURn5Dg/Tby4xaB+bHSfH4ZHsgnXVbeIvbl0EKwBdCQCgfwewEwF1GrRalGKaMexYrXLyVR+nHcKqC2vbm6rbWDLFXroLMvtaA0zobObSplTaseORZxlgze/YxH7UbIzAALUogSiiT0gIAXRBsc/TE61pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Chxtp+Fe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Chxtp+Fe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D39EC2BCB0;
	Fri, 15 May 2026 16:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778860938;
	bh=PZp5v74HdPPMIZyTrRaWmosmqbgP5WAZUjCqdQ9/E7k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Chxtp+Fe1GUsQsWPIUSISEuB7ZLsMwRaRZzrlKjY0r9GkET1VKoC+Zu94fvE1xkrP
	 EGEpXaEfsgpye9wIXoTHL3RYeTj0QRSUoGPm6FcEXsWF/Afm0Byioli96TFxsqoIcA
	 M/zBRTct6hwKN85TelrzIFQSF7NdYQxG/phT3NcoM+1bFp5vlfdzkKbjG7I2mM7BXI
	 7vp9p/A9I4kHfLBp5AThkFWAbdsHLXMrQWigATyeA0TQSzb76ves+Laid5Z7Kks2//
	 0NLqxJGfLx+UFssP0iP/YoLvfRe62yAsEHF7PPQCtvNPxSH4R+971y4JSpbr14d15o
	 Idco/9ThShJrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: appleir: fix UAF on pending key_up_timer in
 remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manish Khadka" <maskmemanish@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260515153450.76146-1-maskmemanish@gmail.com>
References: <20260515153450.76146-1-maskmemanish@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 16:02:17 +0000
Message-Id: <20260515160218.4D39EC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Unprotected access to `appleir->input_dev` in the `flatbattery=
` event path leads to a Use-After-Free during device teardown.
- [Medium] The teardown path uses `timer_delete_sync()` instead of the mand=
ated `timer_shutdown_sync()` API.
--

commit 85e03ec2fd55b34b6351049c19c0b16cf580e59e
Author: Manish Khadka <maskmemanish@gmail.com>
Subject: HID: appleir: fix UAF on pending key_up_timer in remove()

This commit introduces a removing flag to prevent a use-after-free during
device teardown. It checks this flag in the event handler to avoid arming
the timer or accessing the input device after it has been freed by
hid_hw_stop().

> diff --git a/drivers/hid/hid-appleir.c b/drivers/hid/hid-appleir.c
> index 5e8ced7bc05a3..0e51f1e166531 100644
> --- a/drivers/hid/hid-appleir.c
> +++ b/drivers/hid/hid-appleir.c

[ ... ]

> @@ -229,12 +234,17 @@ static int appleir_raw_event(struct hid_device *hid=
, struct hid_report *report,
>  	appleir->prev_key_idx =3D 0;
> =20
>  	if (!memcmp(data, keyrepeat, sizeof(keyrepeat))) {
> -		key_down(hid, appleir, appleir->current_key);
> -		/*
> -		 * Remote doesn't do key up, either pull them up, in the test
> -		 * above, or here set a timer which pulls them up after 1/8 s
> -		 */
> -		mod_timer(&appleir->key_up_timer, jiffies + HZ / 8);
> +		spin_lock_irqsave(&appleir->lock, flags);
> +		if (!appleir->removing) {
> +			key_down(hid, appleir, appleir->current_key);
> +			/*
> +			 * Remote doesn't do key up, either pull them up, in
> +			 * the test above, or here set a timer which pulls them
> +			 * up after 1/8 s
> +			 */
> +			mod_timer(&appleir->key_up_timer, jiffies + HZ / 8);
> +		}
> +		spin_unlock_irqrestore(&appleir->lock, flags);
>  		goto out;
>  	}

Does this leave the flatbattery branch unprotected?=20

If a flat battery packet is received during the teardown window, execution
skips these guarded blocks and falls straight through to battery_flat()
which follows immediately after this hunk.

Looking at battery_flat(), it seems to unconditionally execute
dev_err(&appleir->input_dev->dev, ...), which dereferences the input_dev
pointer. Can this result in a use-after-free if it fires concurrently with
teardown?

[ ... ]

> @@ -318,8 +328,20 @@ static int appleir_probe(struct hid_device *hid, con=
st struct hid_device_id *id)
>  static void appleir_remove(struct hid_device *hid)
>  {
>  	struct appleir *appleir =3D hid_get_drvdata(hid);
> -	hid_hw_stop(hid);
> +	unsigned long flags;
> +
> +	/*
> +	 * Mark the driver as tearing down so that any concurrent raw_event
> +	 * (e.g. from a USB URB completion that hid_hw_stop() has not yet
> +	 * killed) and the key_up_timer softirq stop touching input_dev
> +	 * before hid_hw_stop() frees it via hidinput_disconnect().
> +	 */
> +	spin_lock_irqsave(&appleir->lock, flags);
> +	appleir->removing =3D true;
> +	spin_unlock_irqrestore(&appleir->lock, flags);
> +
>  	timer_delete_sync(&appleir->key_up_timer);

Should this teardown path use timer_shutdown_sync() instead?

The timer subsystem guidelines mandate using timer_shutdown_sync() in
teardown paths to permanently prevent the timer from being re-armed.

> +	hid_hw_stop(hid);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515153450.7614=
6-1-maskmemanish@gmail.com?part=3D1
