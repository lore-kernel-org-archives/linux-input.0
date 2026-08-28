Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7643C456F
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787905320; cv=none; b=UVgathbtvL75xfED8WRgE+eH0QAy5JhOqKXwqokFsJlMDoHJz7dCIOn2owjZK4/rDlWbetN6mBTKqKsCvtR14ecoO/qKAmy5q/mKuz/fnNZ7cK13JjlcNcNZz7teO3T4VCN5gWgigk54Z0+UhfhSyGrE6q1XXqMHS5zm8+lmgqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787905320; c=relaxed/simple;
	bh=eaO9AmYJ31oDu2mD3D/rAG+C/Hhck8+rfm1ppDJlrgc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jjHZkxgN8PpFSDxz6wUEmzlq+XFPR/jlZBU3EQ9s8fdHldqC4sN3kyDfroaOEt2jFUGOQWoht6PCMFasoJyLPGOdOClgJuJz+yJeuQetG734xXuMDbJfaoX1DsuoSOsrbZIlp1GJDUrtoh35avLY2XuVrbh3EuOpKTs6NyhfUAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lC/Tn1uY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lC/Tn1uY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9171E1F000E9;
	Fri, 28 Aug 2026 08:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787905313;
	bh=Uu/xeYphioCawQKt2DRGI9Y8GexyrsZvEnwRS8HcAZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lC/Tn1uYMg6L8lvBPU4YjGOQt4yeBMutNpYu3JQnzeuWMS/kSUXAr1KIAQXh8u69Q
	 nfsT4V/F+6S4tpPbqtohI3zBQatm/aj/2ZVuTc72ETbD43rAhoEuAQXv1Js888hUc1
	 iurIfqzJtAvlTUmDXJ6Fpi+EuVbK9tK+Aez6DlldPLnpuZUtzoOdsFAnt/IHWrMFax
	 7SDlrqe+1SdmuTA0mI8RThGyUoy1g7+TkD4zdZYF48urJGAp870feQ7fe56BT4irJR
	 7KZTC0VJ/pCFKBlBcdV8n8Lr9uokGYSwFyKuXJzFzUCrpWYA47jIiNXYqB2aLs43u9
	 26CO1XP1xwM/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: atkbd - fix UAF in atkbd_set_repeat_rate() on
 disconnect
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jeffin Philip" <jeffinphilip14@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260828080839.116065-1-jeffinphilip14@gmail.com>
References: <20260828080839.116065-1-jeffinphilip14@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 08:21:53 +0000
Message-Id: <20260828082153.9171E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Relocating cancel_delayed_work_sync() before input_unregister_devi=
ce() leaves a race window where userspace can re-arm the delayed work, lead=
ing to a Use-After-Free of the atkbd structure.
--

commit 3288c579c8b7f19a0df10dc75d7e14b7f368e60b
Author: Jeffin Philip <jeffinphilip14@gmail.com>

Input: atkbd - fix UAF in atkbd_set_repeat_rate() on disconnect

Commit 0ef7a26af127 ("Input: atkbd - fix canceling event_work in disconnect=
")
moved cancel_delayed_work_sync() after input_unregister_device() on
the premise that events may arrive until input_unregister_device returns.

However, this created a UAF as work that may have passed the
atkbd->enabled check in atkbd_event_work() may attempt to dereference dev
which is freed in input_unregister_device(). Reverting the commit also
does not solve the issue as events may still come through and pass the
atkbd->enabled check as atkbd_disable() and atkbd_event_work() guard with d=
ifferent
locks. Fix this by closing the hardware first using serio_close()
and then unregistering to prevent work from executing after
input_unregister_device(). serio_close() closes the device preventing
work from arriving.

Reported-by: syzbot+1e2ef9bcb29af666b2e6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D1e2ef9bcb29af666b2e6
Fixes: 0ef7a26af127 ("Input: atkbd - fix canceling event_work in disconnect=
")

> Fix this by closing the hardware first using serio_close()
> and then unregistering to prevent work from executing after
> input_unregister_device(). serio_close() closes the device preventing
> work from arriving.

Is this description accurate?

While serio_close() stops data from the hardware port, it does not prevent
userspace events from arriving via the input core. Userspace can still trig=
ger
atkbd_event() by writing to the input device node (e.g. EV_LED or EV_REP)
as long as the input device remains registered.

> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkb=
d.c
> index 3509b58e64920..096bfbe241db0 100644
> --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -963,17 +963,18 @@ static void atkbd_disconnect(struct serio *serio)
> =20
>  	atkbd_disable(atkbd);
> =20
> -	input_unregister_device(atkbd->dev);
> -
>  	/*
> -	 * Make sure we don't have a command in flight.
> -	 * Note that since atkbd->enabled is false event work will keep
> -	 * rescheduling itself until it gets canceled and will not try
> -	 * accessing freed input device or serio port.
> +	 * close serio first so device will not get any data, which prevents
> +	 * atkbd_event_work from being rescheduled after cancel_delayed_work_sy=
nc
> +	 * returns. This ensures no work can dereference atkbd->dev after it has
> +	 * been freed.
>  	 */
> -	cancel_delayed_work_sync(&atkbd->event_work);
> =20
>  	serio_close(serio);
> +	cancel_delayed_work_sync(&atkbd->event_work);
> +
> +	input_unregister_device(atkbd->dev);
> +

[Severity: High]
Does moving cancel_delayed_work_sync() before input_unregister_device() lea=
ve
a race window where userspace can re-arm the delayed work?

Because the input device is still registered when cancel_delayed_work_sync()
returns, a local user with write access to the input device node can
concurrently write to it. This invokes atkbd_event(), which schedules the
work unconditionally:

drivers/input/keyboard/atkbd.c:atkbd_event() {
    ...
	switch (type) {
	case EV_LED:
		atkbd_schedule_event_work(atkbd, ATKBD_LED_EVENT_BIT);
		return 0;
    ...
}

>  	serio_set_drvdata(serio, NULL);
>  	kfree(atkbd);

[Severity: High]
If userspace re-arms the delayed work during the race window, will this kfr=
ee()
lead to a use-after-free when the re-armed timer fires?

The re-armed work item could execute after the atkbd structure is freed, and
immediately dereference the freed pointer when taking the mutex:

drivers/input/keyboard/atkbd.c:atkbd_event_work() {
    ...
	guard(mutex)(&atkbd->mutex);
    ...
}

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828080839.1160=
65-1-jeffinphilip14@gmail.com?part=3D1
