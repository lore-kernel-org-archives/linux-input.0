Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475AF3793BD
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787922833; cv=none; b=SGhCDfL++oL9wrufdDlV/0fZk5NXT1/pP/R+ki2nb6JPrvMx63y0L/kpYWNO7dgzAjTCSb17Bzxf0zQN3U4q6ebavmDibXEMW34dq/+Q7W3PSkvWBR8HV+kxs6dghZk8puk96RkD7NDb5ctOyuhVZ9HuMEvF+NGOHGArA8+++8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787922833; c=relaxed/simple;
	bh=rL55CRgOMpXlQ6k2uR15aZ6JdMbgbNghZ15wXsdt31E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ePt004i2AHvsB0HtxUKWqthl7wAZhHT4f2i1Fu4rNzeTCcnH195h96O94TQT7Ne7U4t7TenBuQia8/bEf18FUcXhsn/mZTWlUZkiYQdvsue9xL4AIl0aEt18x7gKLpmzgeLKbMNQDP4Qtq6SzopmrrC9juZZKfJXhJaqml7GeYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0Rsb7vU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0Rsb7vU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F011F000E9;
	Fri, 28 Aug 2026 13:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787922831;
	bh=WfGgdUg6Ju+dmFJh3oLGShH6bWOwvOYdRmH7sIqHPfY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b0Rsb7vUte3jGRVPp3xAlUPH/5Z95Z7xWjLVcg+F9sL2ZC0TdlC9rIbgTJwxiFdxx
	 Y3JTw33uN8g08IQStQiFYwpNXVP8hLCim5ytPkO9VIe9TX1bj6o+Y3GOJoAu+vYP8A
	 d4Yfex1NJaQvpaX7RKdIEzYsgdJVYsbLKbDjDpFCHorhoKEmUZyAi3f8wKMFnJ8LuP
	 OEcvN5aLe96cRcXjWNBM3oUNGPfxG8315flig0OVF9wLRnYz86QcdrFlKReSx7aFnt
	 2DBW9ecHKaUyiWlZ/WLQQRjYQ1/T4JWzgonPWAp8oGv5DCcNsNqdFzI35BpfVaUc++
	 P4AA8GRfUjWTQ==
From: sashiko-bot@kernel.org
Subject: Re: [syzbot] [input?] KASAN: slab-use-after-free Read in
 atkbd_set_repeat_rate
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jeffin Philip" <jeffinphilip14@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260828125430.11470-1-jeffinphilip14@gmail.com>
References: <6a90d9ef.4d659fcc.734b4.0019.GAE@google.com>
 <20260828125430.11470-1-jeffinphilip14@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 13:13:51 +0000
Message-Id: <20260828131351.C3F011F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unconditional acquisition of `atkbd->mutex` in `atkbd_disable()` c=
auses an AA self-deadlock because callers already hold this mutex.
- [Low] Passing `struct mutex` by value instead of a pointer to the `guard(=
mutex)` macro causes a build failure.
--

commit ea5b33bff452dfd0c6a1ded0647c9fed571513f0
Author: Jeffin Philip <jeffinphilip14@gmail.com>

    KASAN: slab-use-after-free Read in atkbd_set_repeat_rate

This commit adds a mutex guard to atkbd_disable() to prevent a
use-after-free issue detected by KASAN in atkbd_set_repeat_rate.
A syzkaller test case is referenced in the commit message.

> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkb=
d.c
> index 3509b58e64920..82157782e166f 100644
> --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -706,6 +706,7 @@ static inline void atkbd_enable(struct atkbd *atkbd)
> =20
>  static inline void atkbd_disable(struct atkbd *atkbd)
>  {
> +	guard(mutex)(atkbd->mutex);

[Severity: Low]
Does this compile? The guard(mutex) macro expects a pointer to the mutex,
but it looks like we are passing the struct by value here instead of using
the address-of operator (&atkbd->mutex).

[Severity: High]
Does acquiring the mutex here cause a self-deadlock?

Looking at atkbd_reconnect() and atkbd_attr_set_helper(), they already acqu=
ire
the mutex before calling atkbd_disable():

drivers/input/keyboard/atkbd.c:atkbd_reconnect() {
...
	guard(mutex)(&atkbd->mutex);

	atkbd_disable(atkbd);
...
}

drivers/input/keyboard/atkbd.c:atkbd_attr_set_helper() {
...
	scoped_guard(mutex_intr, &atkbd->mutex) {
		atkbd_disable(atkbd);
...
}

Since mutexes are not recursive, wouldn't unconditional acquisition here
cause a thread hang when a user modifies a sysfs attribute or triggers a
reconnect?

>  	guard(serio_pause_rx)(atkbd->ps2dev.serio);
> =20
>  	atkbd->enabled =3D false;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828125430.1147=
0-1-jeffinphilip14@gmail.com?part=3D1
