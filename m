Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9436030F548
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 21:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788123752; cv=none; b=TQEzcPg52B+i7xka9xPNqDZ2DTKLjfq/J9AlDa33TUfiyUjlkiBMKDCF/tNf2zN7J3Jg68Enchei/yZuKmP/s+vJf7TJqnijtKKsFwIgJrXbgd3yfugj2aTe6ss9wO2LvYSPIEbwMfwXvktHtG1LE4yRCylT6iLhTOTBr1l+Osk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788123752; c=relaxed/simple;
	bh=xkawZtxPov54aug2peu9hFugcRC66Nn5dspDjaBhzZc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lD3qkDQ/eWER3AsyIKdekbaNSm7DKSlIsoqbZ0YVYQgsePYARCzVDPeQVaBwQuGc/n4RA0685xMadI1o5D/h9tgTJCxQWwcazF7TDDbxPOSfh6E2IMrCj0JHle602x4PGBCeNej3zqJ30Cv/yFRt5tO7i+MYuDykk6NUch9f6VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9ij8so+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9ij8so+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B06E1F01558;
	Sun, 30 Aug 2026 21:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788123751;
	bh=yVwyPFn0w1weR7VY+iKLUJym1vILpSaOUbAjjAQnsNk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I9ij8so+CLwD3zhhynVpVKZ5ZB7PqT5f7wzd/DFvoYSrPYhtKHlyul9iWzPsA/Aun
	 yEyGcq2ZPBVV+WSd5F35byVNzcoiNpfeS4YuBXj4J0oe51hjiHYhlHZq5hJmJlFq9Q
	 aUVdHMmBT206XsV/xMeniKWMvOyt/4NW4IqRfe4FkXIf++KglRkXF0v4Aeh1ZILCcL
	 qHft+STTh1Dk1DtOKDuk3DY/GVAdn+chEI7DF3Rfjn+IVGRzLTULOdYFcbe1AD5yp4
	 tbPGuixdaHKnamyLCIIdLsI+s2yjGI1aV7Pi/a2Furr8sAnF0VJUDprJ52f9c9md2x
	 QekberKhP9wbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] Input: gscps2 - serialize hardware and buffer
 access in gscps2_flush()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260830-gscps2-v1-4-c733d4cae7f9@gmail.com>
References: <20260830-gscps2-v1-0-c733d4cae7f9@gmail.com>
 <20260830-gscps2-v1-4-c733d4cae7f9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 21:02:30 +0000
Message-Id: <20260830210231.1B06E1F01558@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] gscps2_writeb_output spins infinitely if the hardware receive buff=
er becomes full while executing in a context where IRQs are disabled.
--

commit 98b3bfa0449cf3b48806ab726d6170adf6e0246e
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

    Input: gscps2 - serialize hardware and buffer access in gscps2_flush()
   =20
    gscps2_flush() reads from hardware registers and resets the ring buffer
    indices ps2port->act and ps2port->append. In gscps2_enable(), the
    trailing gscps2_flush() was called without holding ps2port->lock, racing
    with concurrent hardware interrupts and buffer access.
   =20
    Assert that ps2port->lock is held in gscps2_flush() with
    lockdep_assert_held(), and ensure all callers acquire ps2port->lock so
    that multi-step hardware sequences remain fully serialized without
    unprotected windows.

> diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
> index fef6fffb6f865..36c25db9ff7f6 100644
> --- a/drivers/input/serio/gscps2.c
> +++ b/drivers/input/serio/gscps2.c
[ ... ]
> @@ -364,7 +366,8 @@ static void gscps2_enable(struct gscps2port *ps2port,=
 bool enable)

[Severity: High]
This is a pre-existing issue, but can the loop in the preceding function
gscps2_writeb_output() spin infinitely and cause a hard lockup?

Looking at gscps2_writeb_output():

	while (gscps2_readb_status(addr) & GSC_STAT_RBNE)
		cpu_relax();

This lockless loop waits for a status flag to clear without a timeout or
fallback wake mechanism. If a byte arrives from the PS/2 port (setting
GSC_STAT_RBNE) while gscps2_writeb_output() is executing with local
interrupts disabled, the gscps2_interrupt handler cannot run on the same CPU
to drain the buffer.

Could this spin forever if triggered by normal hardware interaction, such as
typing on the keyboard while the system sends a command?

>  	}
> =20
>  	wait_TBE(ps2port->addr);
> -	gscps2_flush(ps2port);
> +	scoped_guard(spinlock_irqsave, &ps2port->lock)
> +		gscps2_flush(ps2port);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830-gscps2-v1-=
0-c733d4cae7f9@gmail.com?part=3D4
