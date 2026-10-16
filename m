Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C27431326A;
	Fri, 16 Oct 2026 03:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792122101; cv=none; b=g3UJsc8CKe2wd0mApPdC3D4CVh3KQ4lj84I5oi0NkN4u3RJThaL2A5CHYEXUyLphQ74VEWBWVxYKAU2Qj+IvyCkw1L1P18LE7KuKQeib7BtR/wpTbt00vRcZtqwyw4izOMhttKZqOIdX4q6NDEkIkDMyg8jYunfNmu6MYD+j0MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792122101; c=relaxed/simple;
	bh=U8RLbG+AXgzVHJZTF9EOpKPj7RAgHCjWPKHQWdzOG1Q=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=c56pK7WAQvPekceOd+HHRbvPYDL/m57y6oanpx4dtCcb8rQd38E1RdFHdcXscTNi/MjNtmUID8UKMi/XOSGTbEZRrvos9nsb2b2nqkFP6DcvswJqTMKJgSGu9z1pFQtjKQBPVDGzLnxDduUjvs0NAtFrAmHUeMkYWTufq+wxT9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hW5GwEtj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hW5GwEtj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640351F000C4;
	Fri, 16 Oct 2026 03:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792122093;
	bh=X6+Y7j52qG0oaKi5ToCsoalyTnkODPHttQcNGTAVtRs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hW5GwEtjQ5Fhr6bDmYLwAY8khPO9SL+ey4J96fuBoQ4GqMarez83CJKn9Cr3ZfweA
	 DnwsJNilW9bX/32r99PaEIgrk3in474Lgi4HPnDVZTCmVb6RRs+83kTsN8ZT/Cy5JK
	 eHj+NUbFOpZ+39Y8eZe6Ai90ZGMd+f+9HsSr4X5uFzwRdc6R3Gni7EyQrrfJJeBqbs
	 /sv6ct3H/YN2b/fgGr6BSH3Psgomzavn+NURUCbGtqo/MVWNusKPyl4bQgdUW18ecB
	 8fO8cYY9WFtMZVNwA+vDZ4iu595radMpZzDGHxL9BirJmxCD8JdqygyDZLjC3VJL6T
	 rWihaG/s+G/ZA==
Message-ID: <sashiko-outbox-173692@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: sysrq - reset the per-device key state when
 reparsing reset_seq
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhan Xusheng" <zhanxusheng1024@gmail.com>
Cc: linux-input@vger.kernel.org, linux-serial@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261016032732.2328852-1-zhanxusheng@xiaomi.com>
References: <20261016032732.2328852-1-zhanxusheng@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 03:41:33 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] tty: sysrq: uncancelable reset timer on sequence change
--

commit 2166ad442fbe41cfd64e5275427188db06092a2e
Author: Zhan Xusheng <zhanxusheng1024@gmail.com>

Input: sysrq - reset the per-device key state when reparsing reset_seq

This commit clears the accumulated reset_seq_len and reset_keybit state when
reparsing the reset sequence. This prevents stale keys from affecting the r=
eset
detection, as the previous code only cleared reset_seq_cnt.

> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index c2e4b31b699aa..d28a4726b07fc 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -689,6 +689,8 @@ static void sysrq_parse_reset_sequence(struct sysrq_s=
tate *state)
>  	int i;
>  	unsigned short key;
> =20
> +	bitmap_zero(state->reset_keybit, KEY_CNT);
> +	state->reset_seq_len =3D 0;
>  	state->reset_seq_cnt =3D 0;
> =20
>  	for (i =3D 0; i < sysrq_reset_seq_len; i++) {

[Severity: Medium]
Does clearing the reset_keybit here create a situation where the reset timer
becomes uncancelable if the sequence changes while keys are held?

If sysrq_reset_downtime_ms is configured and a user is currently holding the
reset sequence keys, the reset timer will be active.  If the sequence is th=
en
modified via sysfs, this function clears the old reset_keybit.

When the user subsequently releases the old keys:

drivers/tty/sysrq.c:sysrq_detect_reset_sequence() {
    if (!test_bit(code, state->reset_keybit)) {
        /* ... */
        if (value && state->reset_seq_cnt) {
            state->reset_canceled =3D true;
            timer_delete(&state->keyreset_timer);
        }
    } else if (value =3D=3D 0) {
        ...
}

Because the key is no longer in reset_keybit, it takes the first branch.
Since this is a key release (value =3D=3D 0), the timer_delete() is skipped,
leaving the timer active and potentially causing an unwanted system reboot.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016032732.2328=
852-1-zhanxusheng@xiaomi.com?part=3D1
