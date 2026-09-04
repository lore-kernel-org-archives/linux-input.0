Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9E447DD50
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 11:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788521883; cv=none; b=O3Z/An7UQTVMAswPWHp5tgpth1Vy0IhlAOo8sIdBfCVr4irzQ2PY0vaOhoan+DUt2bZLyuIk4abZWxY7jFazN7c7TTlHpSzwm4WrdEUki0JsVtA5JnDcecVwlbGG9niq8JzZHjXkx3+u1LmziWZPrtLlBAWdeSRJzZ+b3u8rQ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788521883; c=relaxed/simple;
	bh=UNwli8gxyusUAnlsyzLgZB8GuHz49rST8UUvrH3VHv4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ozAqxP5gOJ4h+8n+osswKNpgCHLqddoFyDUTDRfTNf5XgqgU0oBwehXq8fdrqFoksfwfDfB9R6xzYJwdxqFbQNGEmtWA/Bx4mf6dIssbQTYMl24kXHVXKttzFBZLYwUADG/NrYt/+uKXy7vS2Ig3MQsolkDDJFZrx+Jpodz2JE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QX1UNnEO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QX1UNnEO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4281F00A3E;
	Fri,  4 Sep 2026 11:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788521881;
	bh=Qg6lwziS/WiHLyTz9yvBXP/P6pLjGnDAPmyjqMbW/7E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QX1UNnEO9vl7tOj5breNrOuUQc+ny3qqp5P6M4fl+syOozKaMsOIsB22JDSL7IDyN
	 XlYLTCKxjAfYE43iodRX5pfbqcaBRVc1WFbCN/6VS9SDAUKV4R6qsPNwaJfS6vWJK5
	 qJD4FIEif0ybkC2x7kLiIf5a0WUdV5Y5doHvV8iXRcmgiuBIZUEom1h8sOx/EA8W7o
	 5YoefUja9+wdoFbGYIur3t+mqZajGlgwHyZh1mZuMXsWZERoiyN/asmXRZQUKXb1gU
	 EfCzzvuFLBOBNue+42jBCAbik57IJxOvZ66FcyeKdlWRnTUfcrP+2yMx4/Vpl8mnJt
	 gn3BfZTvW4KIw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/2] HID: topping-m62: driver for the M62's vendor
 controls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Gavrilov" <mikhail.v.gavrilov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260904112610.3286659-2-mikhail.v.gavrilov@gmail.com>
References: <20260904070530.195389-1-mikhail.v.gavrilov@gmail.com>
 <20260904112610.3286659-1-mikhail.v.gavrilov@gmail.com>
 <20260904112610.3286659-2-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 11:38:00 +0000
Message-Id: <20260904113800.DC4281F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Use-After-Free of `snd_kcontrol` and potentially `snd_card` in `to=
pping_raw_event` due to dereferencing pointers after releasing the spinlock
- [High] Race condition in `topping_unbind` can strand delayed work `m62->k=
eepalive`, leading to a Use-After-Free
- [Medium] API Contract Violation: Unconditional cleanup loop passes NULL p=
ointers to `snd_ctl_remove()`, triggering kernel warnings
--

commit 172808f08cae9fcb08d59263a0babfa30be89c2c
Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

    HID: topping-m62: driver for the M62's vendor controls
   =20
    The Topping M62 is a USB audio interface whose analogue input gains,
    output volumes and output source selectors are not described by the USB
    Audio Class. They live behind a vendor protocol on a HID-class
    interface, spoken by Topping's M Control Center, which has no Linux
    build.

> diff --git a/drivers/hid/hid-topping-m62.c b/drivers/hid/hid-topping-m62.c
> index 0000000000000..0ef407ffb46b7
> --- /dev/null
> +++ b/drivers/hid/hid-topping-m62.c
[ ... ]
> +static int topping_raw_event(struct hid_device *hdev,
> +			     struct hid_report *report, u8 *data, int size)
> +{
[ ... ]
> +	scoped_guard(spinlock_irqsave, &m62->lock) {
> +		card =3D m62->card;
> +		if (m62->val[idx] !=3D value) {
> +			m62->val[idx] =3D value;
> +			kctl =3D m62->kctl[idx];
> +		}
> +	}
> +
> +	/*
> +	 * A frame that arrived just as the audio side was unbinding can
> +	 * notify an id that has already gone.  snd_ctl_notify() takes a
> +	 * copy of the id and touches nothing that unbind frees, so such
> +	 * an event is merely wasted.
> +	 */
> +	if (card && kctl)
> +		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE, &kctl->id);
                                                                 ^^^^^^^^^

[Severity: High]
Does this code risk a use-after-free by passing a pointer to the kctl id
after releasing the lock?

If the audio component unbinds concurrently, topping_unbind() will execute,
clearing m62->card under the lock and freeing the kctl structures via
snd_ctl_remove().=20

When topping_raw_event() resumes and calls snd_ctl_notify(), the &kctl->id
pointer references freed memory. Because snd_ctl_notify() takes the ID by
reference rather than by copy, it will dereference this freed memory,
leading to memory corruption.

[ ... ]
> +static void topping_drop_kctls(struct topping_m62 *m62, struct snd_card =
*card)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < TOPPING_NUM_KCTLS; i++) {
> +		snd_ctl_remove(card, m62->kctl[i]);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Medium]
Will this unconditionally pass a NULL pointer to snd_ctl_remove() if a
control fails to allocate during probe?

If topping_add_kctl() fails, topping_bind() jumps to the err_drop label
and calls topping_drop_kctls(). The loop iterates over all indices in
the array and calls snd_ctl_remove() on them.

For any controls that were never allocated, m62->kctl[i] will be NULL.
Calling snd_ctl_remove() on a NULL pointer triggers ALSA's internal
snd_BUG_ON macro, which generates stack traces in dmesg.

> +		m62->kctl[i] =3D NULL;
> +	}
> +}
[ ... ]
> +static void topping_unbind(struct device *comp, struct device *master,
> +			   void *master_data)
> +{
> +	struct hid_device *hdev =3D to_hid_device(comp);
> +	struct topping_m62 *m62 =3D hid_get_drvdata(hdev);
> +	struct snd_card *card =3D master_data;
> +
> +	cancel_delayed_work_sync(&m62->keepalive);
> +
> +	/*
> +	 * Stop reporting before the controls go, so that a frame in
> +	 * flight cannot look up a control this function is removing.
> +	 */
> +	scoped_guard(spinlock_irqsave, &m62->lock)
> +		m62->card =3D NULL;
                ^^^^^^^^^^^^^^^^

[Severity: High]
Can a concurrent resume strand the delayed work and cause a use-after-free
if it is scheduled after cancel_delayed_work_sync() executes?

Because the work is cancelled before the m62->card synchronization flag is
cleared, a runtime resume occurring in this narrow window can observe that
m62->card is still valid.=20

The topping_resume() function would then erroneously call
schedule_delayed_work(). Since the component is already unbound,
topping_remove() will eventually free the m62 structure without canceling
this newly scheduled work, allowing the timer to fire on freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904112610.3286=
659-1-mikhail.v.gavrilov@gmail.com?part=3D1
