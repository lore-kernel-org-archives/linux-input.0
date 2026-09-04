Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED57D29ACC5
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 11:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788521558; cv=none; b=qFwTgUsfcs6Pvk9eTb1+MEue0fIDCgsGHsdEzqjrYRUXD2fmhLNg+sQDajcMa6p11v/7WmN1b2ssVzite/SzxjKRK8+2KLD7B31taok4CzLe+mHRFB2DRGPzFePJYVIAgdk7dCfNTqXlAo3G0qcXOTLtcukQ9ysxc92qSJHEo7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788521558; c=relaxed/simple;
	bh=kPKO7sGa8/m+cjrxMmAxthjRX7OfUapigaK7hBydQjs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fgRn4u5VSYNSoP4tGt7bs7wGXjQ19WQGLg8l9g7oiGnZgMSqugWa7s31qedYmJJhTsMyTf2AWn6Y2BW8cAv5YVrTk8AQ/vI6RK21mLbkqVlwrl/tPvH0pvKF1CEipgptXk/es/0zZRyEhgjPXv89PD19THdM2C4Unv6dAUBsVTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJAlqemZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJAlqemZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C09E1F00A3D;
	Fri,  4 Sep 2026 11:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788521556;
	bh=VAk7lLw08I7K/co//iDzlkeALhoPggNrGn33abHY5Rw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XJAlqemZfl3bnUXb/NGGE391bm5jHKW/uP1oe8HpLMaBaF7kow1WWeN+6w9LtRp5T
	 f4NiSb6zi0e3z3OzCK1rQx/DQEzOxJq8lGrdY/x6GLJ6YixAKaAzBPMuo2RqxVKEE1
	 8rBcbAESU8XaInUB1qXYPC8ufH5YbF81OIad5cfUHPyinUM4W7mAhMfmAP/hdL2q4Z
	 DecmrZAGGpcfe/ttb+ZuiqjeP+6iCFGrenNnujNNWRbm0HcS/QlwRIkx9GTWUa1Hac
	 FB2XDfjWz5slzPsg9avmiqWI2l7zTcoVFKHGCjtRTnfoldzmEV1iy6+moZcFXI4yZU
	 /mnJP2vksVhSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] input: fix repeated words in comments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hemanth Selam" <hemanth.selam@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260904111911.32224-3-hemanth.selam@gmail.com>
References: <20260904111911.32224-1-hemanth.selam@gmail.com>
 <20260904111911.32224-3-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 11:32:36 +0000
Message-Id: <20260904113236.8C09E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Low] The patch incorrectly fixes a typo, resulting in a grammatically in=
complete sentence.

Pre-existing issues:
- [High] Repeated firmware updates via sysfs leak `input_dev` structures an=
d devres nodes due to manual unregistration of a devm-managed device withou=
t freeing it.
- [High] The `serio->lock` spinlock is accessed uninitialized if an interru=
pt fires before `serio_register_port()` completes.
- [High] A Use-After-Free can occur on `q40kbd->port` during device removal=
 if a pending interrupt fires before `free_irq()`.
--

commit 45b867db64f6ee078771ef7b8cf723b44cd0fd23
Author: Hemanth Selam <hemanth.selam@gmail.com>

    input: fix repeated words in comments
   =20
    Drop words accidentally written twice, reported by checkpatch.pl as a
    possible repeated word.  Only touches comments, no code changes.
   =20
    Assisted-by: Cursor:claude-opus-5
    Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

[ ... ]

> diff --git a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40kbd.c
> index 2f553efbe649d..7ab4db61e46fe 100644
> --- a/drivers/input/serio/q40kbd.c
> +++ b/drivers/input/serio/q40kbd.c
> @@ -72,7 +72,7 @@ static void q40kbd_stop(void)
> =20
>  /*
>   * q40kbd_open() is called when a port is open by the higher layer.
> - * It allocates the interrupt and enables in in the chip.
> + * It allocates the interrupt and enables in the chip.

[Severity: Low]
Does this typo fix leave the sentence grammatically incomplete? The original
text "enables in in the chip" appears to be a typo for "enables it in the
chip".

>   */
> =20
>  static int q40kbd_open(struct serio *port)

[Severity: High]
This is a pre-existing issue, but does cyapa_update_fw_store() leak memory =
and
devres tracking nodes on every firmware update?

drivers/input/mouse/cyapa.c:cyapa_update_fw_store() {
    ...
    input_unregister_device(cyapa->input);
    cyapa->input =3D NULL;
    ...
}

Manual unregistration of a devm-allocated device without freeing it leaves =
the
devres tracking node and memory orphaned. When cyapa_reinitialize() is call=
ed,
it allocates a new input device, creating a new devres node.


[Severity: High]
This is a pre-existing issue, but can the serio port spinlock be accessed
uninitialized if an interrupt fires before q40kbd_probe() completes?

drivers/input/serio/q40kbd.c:q40kbd_probe() {
    ...
    error =3D request_irq(Q40_IRQ_KEYBOARD, q40kbd_interrupt, 0,
                        DRV_NAME, q40kbd);
    ...
    serio_register_port(q40kbd->port);
    ...
}

If an interrupt fires when request_irq() is called, q40kbd_interrupt() will
call serio_interrupt(), which acquires serio->lock. However, the spinlock
isn't initialized until serio_register_port() is called.


[Severity: High]
This is a pre-existing issue, but is there a use-after-free race during
device removal if a pending interrupt fires before the IRQ is freed?

drivers/input/serio/q40kbd.c:q40kbd_remove() {
    ...
    serio_unregister_port(q40kbd->port);
    free_irq(Q40_IRQ_KEYBOARD, q40kbd);
    ...
}

While serio_unregister_port() calls the close method to mask the hardware
interrupt, it does not wait for already-running handlers. If
q40kbd_interrupt() is executing on another CPU, it can dereference
q40kbd->port after it has been freed by serio_unregister_port().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904111911.3222=
4-1-hemanth.selam@gmail.com?part=3D2
