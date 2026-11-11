Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368248;
	b=Brg8pUGqWobd/BQFWj20LDYIOtbuPd+A2kcV7CMl+mWsJozZsNTEzQh0FPbmqPdVFWrL
	 tGcCe4+wuoICV3Zka98W1+vYrY44IkHsvoQHSXW8pzQ+s9V0U/XUFZg80yiDr37eB3lp0
	 3Z5qxvIK+d5QpDOZwWgymYHzXl/8byl0Lph9fGQFkXUK83+03fRPkITYv0n2leZNojwc1
	 MBEnvbtvy2D5cul1NGrr9UF9PgDqhILMXoD+rY8TMXUYEX6mDU/EfhhwMhOWZ4TN9SfCw
	 niusz9BjyrALCtXfetiTIpIxvYeH+jrvyhOlCUVqcqQitBVdMfR/vDUKZ8NNJWqW9GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368248;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gekdd3yqyFd4ypNP4uZ1aNE7zW/55l2J7K3GqWzN00w=;
	b=k61OeHq7/j516kjl4v5lF3KrbfrcjatUtZpQenvvlew9MriU3Bk1CzzD7Sggazk9tbD1
	 MNKSiAZDI+eFN7NFtseZ5bxGNfzCLI7HUfY0COUo0l+KFd+qLA65l6Ld51m302mos2LN9
	 28gVoVDnqTigdaPCfvYd+1jloqGh//d/LeTBfNuKtU9JW5ptpt1J93f9bVJ7yCQy8X04T
	 V6hwGstVZEiAXIgnNgs7GhqOvielfTJuWHksoecMoTm9efCCmxvSOd20mQ49EWtl3zTeG
	 +QXuJjs2awMg477cWMhfBBrZRawqAj/2oe5lPJaIW/3+k+zyhY272cE3vwcHwds0Lyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jZdHDv+D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F72606A32A
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 03:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jZdHDv+D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C621F0089F;
	Wed, 11 Nov 2026 03:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794368248;
	bh=gekdd3yqyFd4ypNP4uZ1aNE7zW/55l2J7K3GqWzN00w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jZdHDv+D2Ai/8On392MpH7/TVz9jQYf+LCl5s0F0cLm3w9HEyztzygxpYW1gQCifC
	 z7r29lnzhLyWYIjs/5Mv6j2ez7bs0OTw6D3cT+UdIBLnwWx4VDhVodFlsyQ4vEWZsk
	 Yw29kG9j2EkkKSUPFzOXWTIxJqLJ9WOZ/JTm5/nbUOJ/R3dBqI8my7vmC5Ea8SkZCE
	 I7qpuZsTggHZ0Lr2MGRa+31YxhI2pJJm4WVV+p6Z8b2E0K0y+rXGa8hLWr1hzqEMwh
	 1y2hzUct5dnM6iKtOdupWEX/98Fc3lN2NmstBKZIm6NE/KVZFyKe0uoBPt5xt9DHoW
	 23Tq4qJ2arMyQ==
Message-ID: <sashiko-outbox-208208@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] HID: nintendo-switch2-usb: Improve shutdown logic
 with inbound message work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
In-Reply-To: <20261111032125.2888320-2-vi@endrift.com>
References: <20261111032125.2888320-1-vi@endrift.com>
 <20261111032125.2888320-2-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 03:37:27 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] HID: nintendo-switch2-usb: race in
  switch2_usb_message_in_work() on shutdown
--

commit f13e9d16677e01254216a22b0f74fbd5513c6e9d
Author: Vicki Pfau <vi@endrift.com>

HID: nintendo-switch2-usb: Improve shutdown logic with inbound message work

This commit moves the schedule_work() call for message_in_work under
bulk_in_lock in switch2_bulk_in() and adds a shutdown check at the start
of switch2_usb_message_in_work().

Link: https://lore.kernel.org/linux-input/a2dc00e7-9cab-4315-87a4-795f256c1=
e03@endrift.com/T/

> diff --git a/drivers/hid/hid-nintendo-switch2-usb.c b/drivers/hid/hid-nin=
tendo-switch2-usb.c
> index 8eafc4fc513d4..97b7bca790f8e 100644
> --- a/drivers/hid/hid-nintendo-switch2-usb.c
> +++ b/drivers/hid/hid-nintendo-switch2-usb.c

[ ... ]

> @@ -294,6 +287,10 @@ static void switch2_usb_message_in_work(struct work_=
struct *work)
>  	unsigned long flags;
> =20
>  	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
> +	if (ns2_usb->shutdown) {
> +		spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
> +		return;
> +	}
>  	for (i =3D 0; i < NS2_IN_URBS; i++) {
>  		urb =3D &ns2_usb->bulk_in[i];
>  		if (urb->state !=3D NS2_URB_IN)

[Severity: High]
Can switch2_usb_message_in_work() still race with teardown and shutdown
once it drops bulk_in_lock inside the loop?

CPU0 (kworker)                        CPU1 (disconnect / shutdown)
switch2_usb_message_in_work()
  spin_lock_irqsave(bulk_in_lock)
  if (ns2_usb->shutdown) // false
  spin_unlock_irqrestore(bulk_in_lock)
                                      switch2_usb_disconnect()
                                        switch2_usb_free_in_urbs()
                                          cancel_work(&message_in_work)
                                          spin_lock_irqsave(bulk_in_lock)
                                          bulk_in[i].urb =3D NULL
                                          spin_unlock_irqrestore(...)
                                          usb_free_coherent(..., data, ...)
                                          usb_free_urb(urb)
  switch2_receive_command(...,
    urb->urb->transfer_buffer, ...)
    <-- NULL deref or use-after-free

switch2_usb_free_in_urbs() and switch2_usb_shutdown() call non-blocking
cancel_work(), and switch2_usb_disconnect() only calls cancel_work_sync()
after switch2_usb_free_in_urbs() and switch2_controller_detach_cfg() have
already completed.  Because an URB in state NS2_URB_IN has already
completed, usb_kill_anchored_urbs() and usb_kill_urb() do not wait for the
worker either, allowing bulk_in[i].urb, its coherent DMA buffer, and
ns2_usb->cfg.parent to be cleared and freed while bulk_in_lock is dropped.

In addition, when switch2_usb_message_in_work() re-acquires bulk_in_lock
after switch2_receive_command(), it only checks !urb->urb and never
re-checks ns2_usb->shutdown.  Because switch2_usb_shutdown() sets
ns2_usb->shutdown =3D true and empties bulk_in_anchor without clearing
bulk_in[i].urb, an in-flight worker will re-anchor and resubmit urb->urb
via usb_submit_urb() and continue iterating after shutdown.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111032125.2888=
320-1-vi@endrift.com?part=3D2
