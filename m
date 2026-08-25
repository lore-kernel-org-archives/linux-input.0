Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9663D4132
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 09:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649156; cv=none; b=CM3mpPVFY+FUOaOmMOKHLizdobaqHU2gOW42Ly+9Q/5loHlBGaQV6EVqBrF5nLMKoKZ8jU82DQwxrLeKLcjyH/g/1Vmk6DMVaIUUY0Jb1wowwNUKZx9XHo0ELHAc2OBIWIazXRlB49VUUB5+4AwH7Ykch4oqnktT2OhrUB47lCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649156; c=relaxed/simple;
	bh=B0nJBPtkcwA+4Uu0lv6Dy6TmZpzTOKi7ufUB+CfBP/0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uIldPVhhHQGCRZYNq25mFrPDuwqTPB4Xd0gRqPTG/UXJlmIvCGJti9UyFmIzlofNWVEGYqhPWYOlZE6UzMXseCzc7ACzFTwgvBkwIQ/IaTAc2jkC/Zh1nrTkkH9A19dS9RThTwzB3xvv/hK0fIx79hNjxsaJ9BdI2oma+8QwSLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpzHW0WS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpzHW0WS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35181F000E9;
	Tue, 25 Aug 2026 09:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787649155;
	bh=/8mIMkCimpIuoeadN0fXV67xflUimNMraZRVNscwNpk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HpzHW0WSuUSbqqgnN3FCNbRLAEXy+RPr4Dn6SqEzKyuKvBSgvuSvktogK/PUfzeND
	 RLQm0mBA1sLKZB3k0j01RPvb3PO5bRTE0qZzbUCwhHQrL+pS0tyOmm8yX9fr07vxXB
	 j9k0tqAvCapq0nnl2grH/oxkWv1ltPYtwgwYtvjwv1NGYHTsj2/ZYbYEO2jFYgN2Dt
	 VM1REP+E+YkDyfn5Mq/91UXjMhAWpJ3IBms3QnuwfAeQorNwUXYCOUXneIT8dqh5LO
	 y3PraFkS4oFudFNsQRMqDkAYz5GlJfWLFqRU2pdd5pFkRILDkrBZ183tWwnuODI1ha
	 5fKsgoga0jfyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/2] ALSA: usb-audio: expose the Topping M62's
 analogue gains as mixer controls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Gavrilov" <mikhail.v.gavrilov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260825085659.52675-2-mikhail.v.gavrilov@gmail.com>
References: <20260824223107.406504-1-mikhail.v.gavrilov@gmail.com>
 <20260825085659.52675-1-mikhail.v.gavrilov@gmail.com>
 <20260825085659.52675-2-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 09:12:34 +0000
Message-Id: <20260825091234.F35181F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The keepalive worker reschedules itself indefinitely and causes =
log spam every 2 seconds if the device is unplugged while userspace holds t=
he ALSA card open.
- [Medium] Cache desynchronization race between `topping_ctl_put` and concu=
rrent unsolicited hardware events.
--

--- Patch [1]: [PATCH v7 1/2] ALSA: usb-audio: expose the Topping M62's ana=
logue gains as mixer controls ---
commit 97e5c28d5c9df80af2f3a0a9199b11cf828931a5
Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

ALSA: usb-audio: expose the Topping M62's analogue gains as mixer controls

This commit introduces a mixer driver for the Topping M62 to expose analogue
input gains and output volumes hidden behind a vendor HID protocol. It
subscribes to device state changes and maintains an internal cache updated
by a URB completion handler.

> diff --git a/sound/usb/mixer_topping.c b/sound/usb/mixer_topping.c
> new file mode 100644
> --- /dev/null
> +++ b/sound/usb/mixer_topping.c
[ ... ]
> +static int topping_send(struct topping_mixer *tm, u8 target, u8 prop,
> +			s32 value)
> +{
[ ... ]
> +	err =3D usb_interrupt_msg(tm->mixer->chip->dev, tm->pipe_out,
> +				buf, TOPPING_FRAME_LEN, &actual, 1000);
> +	if (err < 0)
> +		usb_audio_err(tm->mixer->chip,
> +			      "Topping: write %02x/%02x failed: %d\n",
> +			      target, prop, err);
> +	return err;
> +}
[ ... ]
> +static void topping_keepalive(struct work_struct *work)
> +{
> +	struct topping_mixer *tm =3D container_of(work, struct topping_mixer,
> +						keepalive.work);
> +
> +	topping_send(tm, TOPPING_TT_DEVICE, TOPPING_PP_SUBSCRIBE, 1);
> +	schedule_delayed_work(&tm->keepalive,
> +			      msecs_to_jiffies(TOPPING_KEEPALIVE_MS));
> +}

[Severity: Medium]
What prevents this worker from rescheduling itself indefinitely if the
device is unplugged?

If the ALSA card is kept open by userspace, topping_send() will continually
return an error (like -ENODEV) when the device is disconnected, which is th=
en
unconditionally logged every 2 seconds. The worker then proceeds to call
schedule_delayed_work() here without checking if the device is gone.

Should it check the return value of topping_send() or check something like
tm->mixer->disconnected before rescheduling?

[ ... ]
> +static int topping_ctl_put(struct snd_kcontrol *kctl,
> +			   struct snd_ctl_elem_value *ucontrol)
> +{
[ ... ]
> +	err =3D topping_send(tm, d->target, d->prop, value);
> +	if (err < 0)
> +		return err;
> +	if (d->target_pair) {
> +		/*
> +		 * The device announces only one of a pair, so the other
> +		 * would drift away unheard.
> +		 */
> +		err =3D topping_send(tm, d->target_pair, d->prop, value);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	scoped_guard(spinlock_irqsave, &tm->lock)
> +		tm->val[elem->control] =3D value;
> +	return 1;
> +}

[Severity: Medium]
Could this blind update of tm->val desynchronize the cache from the actual
hardware state?

The tm->lock is released while calling topping_send(), which can sleep. If a
user turns a physical knob on the device concurrently, the device emits an
unsolicited URB. The URB completion handler (topping_urb_complete()) runs,
acquires the spinlock, and correctly updates the cache to the true hardware
state.

However, once topping_send() returns, this code reacquires the lock and
unconditionally overwrites tm->val[elem->control] with its own original
value. This ignores any fresh hardware events that arrived during the windo=
w.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825085659.5267=
5-1-mikhail.v.gavrilov@gmail.com?part=3D1
