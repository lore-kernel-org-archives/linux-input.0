Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA042D9EED
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 21:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788123914; cv=none; b=HpBFu5DY2VNMVO2ZVachAFIQiJTs3BPIkPJyz70FLsWWBzaFqo1AfcNDP7FSL4MyNWLrX5vAZ1l4liuNtAb4i+m6eR7EhKk3G7nRBWwui6MEh/BcUZsAPguA8j9YXu3e74MipqznWXdX8GV/pNvbnGhlx+i05B85Od8QImqQYOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788123914; c=relaxed/simple;
	bh=h7Zim3B52rahvMyHbUM/aE2sPr57WZzzcvQsXJJz/v4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D8TT5csK6OGPz2YgOJ3gO+0iNDsoVC3WngcqBgAn5quxPinDUkJUu4t4QYjNWjs2zNZitcb2RuLIv9Ycpi5PA/h0Z7KBhW68LfaKEAzh+kujhiSwyHDA3N4RtYn2OiEnL0LSbUYKpH2/GTZZihUACckix0FNxupq8n/H4wWUS+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kR7TjRak; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kR7TjRak"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93301F000E9;
	Sun, 30 Aug 2026 21:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788123912;
	bh=WSN9q/rTcZc6WEZK+Rsnlo0QkSWXrqfLJ1CBt/t/JlM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kR7TjRakzHpngKcYfGkpyyd2OychlvJ2ApNFgXGEygSf22PPR9qi0h+VmXYAzK8xM
	 wYgmuUglrp4vpjYG0aMoYvU5PxN4vobmu2S5C/dxcZyevRXB5SFYxCh1fRgmgXIeEh
	 2t63mJZsohxmozQR4YTlOpFuuBJtr6SFaUdHfqXBf66Ev9a7QweGFVC2AOZBNhR8tj
	 NHRpNtC1mrG1QwIx4vS8x9+V8t6giwkjj6U1ktB1U+TQUEvIcAeBM99Nh4vHSCy67+
	 BGpIttjT05nNrG959CGaKNvn+tlDldeWP5liz0PD5LRLUdKlKGDQJWyk9i/I/v8Zfg
	 w+f/v4Oi+1aMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] Input: gscps2 - return IRQ_NONE when interrupt is
 not handled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260830-gscps2-v1-5-c733d4cae7f9@gmail.com>
References: <20260830-gscps2-v1-0-c733d4cae7f9@gmail.com>
 <20260830-gscps2-v1-5-c733d4cae7f9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 21:05:12 +0000
Message-Id: <20260830210512.B93301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbounded hardware status polling loop can cause a hard CPU lockup
--

commit 9f561e93b317449afad0b8c42cee86d0e78216d9
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: gscps2 - return IRQ_NONE when interrupt is not handled

This commit modifies the GSC PS/2 driver to track whether any bytes were
handled during an interrupt and returns the appropriate IRQ status. This
prevents masking unhandled interrupts on a shared line.

> diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
> index 36c25db9ff7f6..907fb1537595c 100644
> --- a/drivers/input/serio/gscps2.c
> +++ b/drivers/input/serio/gscps2.c
[ ... ]
> @@ -247,11 +248,14 @@ static void gscps2_read_data(struct gscps2port *ps2=
port)
>  		if (!(status & GSC_STAT_RBNE))
>  			break;
> =20
> +		read_any =3D true;
>  		ps2port->buffer[ps2port->append].str =3D status;
>  		ps2port->buffer[ps2port->append].data =3D
>  				gscps2_readb_input(ps2port->addr);
>  		ps2port->append =3D (ps2port->append + 1) & BUFFER_SIZE;
>  	} while (true);

[Severity: High]
This is a pre-existing issue, but could this unbounded hardware polling loop
cause a hard CPU lockup?

If the PS/2 controller malfunctions and fails to clear the GSC_STAT_RBNE bit
after a read, this loop will never exit. Since gscps2_interrupt runs with
local interrupts disabled, this would freeze the system.

Could we add a bounded iteration guard or retry limit here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830-gscps2-v1-=
0-c733d4cae7f9@gmail.com?part=3D5
