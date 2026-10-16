Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE623AA1B2;
	Fri, 16 Oct 2026 07:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135190; cv=none; b=nfvcoya0zs0/Ul89JleysydE8BDmAwHO6d0bo+C1XQcMpubi5E67p3R7AgN5NpG2f+vL0uxbg676wLYCfp2lCyyLcF8KxRmWuXWHplOgvU/GEdfNfzBcVyq1EpkG7H7aixYfzKdFhDwO5JDzgVFfdMsM+9a+RF3+uFuB2DjZy3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135190; c=relaxed/simple;
	bh=TP0284cGvOJK/wMifYexkuUdWwlspMkVRMzvxwqYSfQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=p+TM5I8fUFjKeL+aRAHVyC0E8j08vXaAI+pQLwleVbpSbj6m29qnh3nh/EIik3w+d6Hu5jNHrjtvBQme3HxsckY9EcxNpPZ2xio6hdcO0haigCYSMsFzsbnytpVoiUAtBc8IqNkT2YAeJ2keWEfnWvSkpU5VmCU0g09EnYKOxWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGUKZKBo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGUKZKBo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BAE1F000C4;
	Fri, 16 Oct 2026 07:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792135189;
	bh=yw6D0Pu2FuAtk/kQtkBYCwUIw4riyXhcrsOA5ny2SKw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GGUKZKBo7uXHULs10Y7+J2p2AgYjGhJ3yUnmK0qx+IDjj86KwOPto/ysGvYEydH4P
	 GakeF+S6Zgcg5wZ5erFWZFzb/0VuJHsj6FQ1ONBd1DGBWD/z7hWKo3FWBAly/gcfi9
	 kKJ22DJ646gExrNLfw+OFerzLaCHe3dKhwlj8mkbsLYUCJZ8PJ0Bv3v8M0/bmeKMdK
	 drivVUlYQXTTTarfuIpGEwpIKVCKJUeH+dH7XI4Fy1vPRnXeiC3c44Foy/hC2YFJBs
	 ah44JpAGb6BFjacwFIXlYiWLYmpq5kt+l7MZxNjkib5YLfnn3nhMbrYy5fkPXB27tH
	 jaWbyltWYa1RA==
Message-ID: <sashiko-outbox-173915@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] tty: sysrq: reset the per-device key state when
 reparsing reset_seq
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhan Xusheng" <zhanxusheng1024@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261016070636.2559899-1-zhanxusheng@xiaomi.com>
References: <20261016070636.2559899-1-zhanxusheng@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 07:19:48 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] tty: sysrq: TOCTOU race in param_array parsing permanently trunc=
ates reset sequence
--

commit d416bc3fc7ebb943414eab9dc3be1f59ade9fcc6
Author: Zhan Xusheng <zhanxusheng1024@gmail.com>

tty: sysrq: reset the per-device key state when reparsing reset_seq

sysrq_parse_reset_sequence() clears reset_seq_cnt, but reset_keybit is
only ever __set_bit() and reset_seq_len only ever incremented. Since
struct sysrq_state lives until the device goes away, both accumulate
every time the sequence is reparsed. This commit fixes this by clearing
both along with reset_seq_cnt and deleting the keyreset_timer when the
sequence is redefined.

> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index c2e4b31b699aa..013ad3a500703 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -689,6 +689,15 @@ static void sysrq_parse_reset_sequence(struct sysrq_=
state *state)
>  	int i;
>  	unsigned short key;
> =20
> +	/*
> +	 * An armed reset belongs to the sequence being replaced: once the
> +	 * old keys are gone from reset_keybit their release no longer
> +	 * cancels it.
> +	 */
> +	timer_delete(&state->keyreset_timer);
> +
> +	bitmap_zero(state->reset_keybit, KEY_CNT);
> +	state->reset_seq_len =3D 0;

[Severity: Medium]
When a user writes a comma-separated list of keys to the module parameter,
param_array() updates the sequence elements sequentially:

kernel/params.c:param_array() {
    ...
    *num =3D 0;
    do {
        ...
        ret =3D set(val, &kp);
        ...
        (*num)++;
    ...
}

For each element, sysrq_reset_seq_param_set() increments the global
sysrq_reset_seq_version before param_array() increments the global length
sysrq_reset_seq_len (via *num).

If a hardware keypress triggers sysrq_filter() in the window after the
version is incremented but before the length is updated:

1. sysrq_handle_keypress() sees a version mismatch and calls
   sysrq_parse_reset_sequence().
2. The newly added state->reset_seq_len =3D 0 clears the sequence length.
3. The loop reads the transient truncated sysrq_reset_seq_len.
4. state->reset_seq_version permanently caches the new version.

Once param_array() finishes and corrects sysrq_reset_seq_len, subsequent
keypresses will see matching versions and skip reparsing.

Could this cause a regression by permanently leaving the device with a
truncated reset sequence?

>  	state->reset_seq_cnt =3D 0;
> =20
>  	for (i =3D 0; i < sysrq_reset_seq_len; i++) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016070636.2559=
899-1-zhanxusheng@xiaomi.com?part=3D1
