Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EC9345745
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 06:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781072214; cv=none; b=FarkQf0tw3JOecJY4d7I5dvhEnHnRMMf928/WoJk9n10nIg7jPu7840BFN2APz+fJZ3sd+xoAp3ERnAxeCXltMTOhBLiCEdhfv0ijvTYeSc0T4TXqIeWYYw0LYGxUjPHa3KlvcuOZrfE3nomzIMHMuFh89+zi+jVHo/Ci3dTVwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781072214; c=relaxed/simple;
	bh=+a75H7HpsrEzDBtxV/0Wu1ZAoiJ0EWHwThfgT9X0tjE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VVchPpD3bYQjcFDTq/65R+9gJaD00QM9CbkFOCD087wLO1xb5QMCQ+BgP57H/gJzXjNON55n7038PWiJk6BRxCLLG439ik72eGeej33c9rAYDb0pNMc8asLaxBRYZSZE1kKfxDaFYwhi+ekKQACyJbgOpDJQ0Oa7I7j3gXY8eWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZD2/+X1t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZD2/+X1t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC0B1F00893;
	Wed, 10 Jun 2026 06:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781072213;
	bh=a+pwfG2ifX03rSk+eQFaiBi9hTyWC3/0lJ2aQRonF2s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZD2/+X1tzisO4Vps1niPtrD9RcgqR2CoZICeDY2sC71DHZtl6KpIklDFAH4AqV/2q
	 LmR/jrCZQo1inSlk1Rhbvym7zatZ0d1XaMdtexlQpxQdlo/Ow205ipLtgTW3U0rEea
	 KMnNhcgZS7Sxp1/gD1fA+c7JlM/8dJTJT+BAMzmoSMwrsNYQ76Y4qCff2RvfNCqz1R
	 0/ineFILMzPvuek+JlE+ndB9GFVxyNVHfG7itUOKJ4nWDPVWg6VEa6BL0OBRZ0gbaQ
	 78BihgE5ZPsLRAcJmm2kWZOnvLuv6qi+L/D5aoq8i1qUXmEsI89ghYEW2LU3MAh20i
	 GXQNAbUyxAj8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: ipaq-micro-keys - fix potential deadlock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <aij-pfaKK-Nna7wf@google.com>
References: <aij-pfaKK-Nna7wf@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 06:16:52 +0000
Message-Id: <20260610061653.2EC0B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] ipaq_micro_str() fails to null-terminate a stack-allocated string =
before passing it to kstrdup().
- [Medium] micro_key_receive() accesses the message payload without checkin=
g if the length is greater than zero.
- [Medium] Potential off-by-one error in keycode array indexing.
--

commit cc960c88f9bd89346f2cb6d8461bbe44bd01c18b
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: ipaq-micro-keys - fix potential deadlock

This commit fixes a lock inversion deadlock in the ipaq-micro-keys driver.
It updates micro_key_start() and micro_key_stop() to use guard(spinlock_irq)
instead of guard(spinlock), ensuring interrupts are disabled while the lock
is held in process context.

> diff --git a/drivers/input/keyboard/ipaq-micro-keys.c b/drivers/input/key=
board/ipaq-micro-keys.c
> index ca7ec054b1cef..63d589253e465 100644
> --- a/drivers/input/keyboard/ipaq-micro-keys.c
> +++ b/drivers/input/keyboard/ipaq-micro-keys.c

[ ... ]

> @@ -54,7 +54,7 @@ static void micro_key_receive(void *data, int len, unsi=
gned char *msg)

[Severity: Medium]
This isn't a bug introduced by this patch, but could this code read
uninitialized or stale memory if len is zero?

In micro_key_receive():

    down =3D 0x80 & msg[0];
    key  =3D 0x7f & msg[0];

The parent MFD driver parses serial messages and can validly produce a
payload with a length of 0. When this happens, micro_process_char() skips
writing to the buffer, leaving it with stale data.=20

Since micro_key_receive() reads msg[0] without checking if len > 0, does
this cause the driver to report phantom key events based on old hardware
traffic?

[Severity: Medium]
This is a pre-existing issue, but does this array indexing have an
off-by-one error?

In micro_key_receive():

    if (key < ARRAY_SIZE(micro_keycodes)) {
        input_report_key(keys->input, keys->codes[key], down);
        input_sync(keys->input);
    }

If the hardware sends 1-based codes (for example, 1 for Record and 9
for Down), using the hardware key value directly as a zero-based index means
a value of 1 maps to index 1 instead of 0.

Furthermore, if the hardware sends 9 for the Down button, the event would be
dropped entirely since 9 < 9 evaluates to false. Should the index be
decremented before lookup if the device uses 1-based indexing?

> =20
>  static void micro_key_start(struct ipaq_micro_keys *keys)
>  {
> -	guard(spinlock)(&keys->micro->lock);
> +	guard(spinlock_irq)(&keys->micro->lock);
> =20
>  	keys->micro->key =3D micro_key_receive;
>  	keys->micro->key_data =3D keys;
> @@ -62,7 +62,7 @@ static void micro_key_start(struct ipaq_micro_keys *key=
s)
> =20
>  static void micro_key_stop(struct ipaq_micro_keys *keys)
>  {
> -	guard(spinlock)(&keys->micro->lock);
> +	guard(spinlock_irq)(&keys->micro->lock);
> =20
>  	keys->micro->key =3D NULL;
>  	keys->micro->key_data =3D NULL;

[Severity: High]
This is also a pre-existing issue in a related file, but does this code
cause an out-of-bounds stack read?

In drivers/mfd/ipaq-micro.c:ipaq_micro_str():

    for (i =3D 0; i < len / 2; i++)
        retstr[i] =3D wchar[i * 2];
    return kstrdup(retstr, GFP_KERNEL);

The array retstr is filled without an explicit null terminator. When
kstrdup() is called, it relies on strlen(), which will read past the valid
copied characters into uninitialized stack memory until it hits a random nu=
ll
byte.

Could this leak kernel stack contents when the string is later printed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/aij-pfaKK-Nna7wf@go=
ogle.com?part=3D1
