Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B5029DB64;
	Fri, 25 Sep 2026 12:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790338733; cv=none; b=YVCLxR9hFwcHhhfT31VPYhA9x91WBYTJGTbU8vtFVZE4kq/V6qeNFXpzPc52zRwuu9FWZBN1El3TKMiY+U6wxCh+0ho//4CoFS+VkNlbtbWwsezPsHSLFrdFjkGlLex73nmEQN88+AgdYp8oMbbBCEHB3IVnCRVVr4xL+hipVRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790338733; c=relaxed/simple;
	bh=164GKJ22csF16AjhDOLZzO5jGNBSrwLPFvF74TgmueM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KPoFzybGq6YgWVqHIJx1N3Ulb5a9PHXNhxks3yTNxh8ElNxNenWQIrpMo3JDD04uyK7bjTPIiq5CFqemTYkjXnryZiy6crDXzV1EgZJcJlKyb2nvjD7W2+uxUQfh4mx7FdJ4jMe8+wpnxkepFGxgDM6jD9a4tU8GRenJMD8qetM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kl4Bwps1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kl4Bwps1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4F41F000FF;
	Fri, 25 Sep 2026 12:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790338731;
	bh=0mB3MttGUs3XRFf28KCYLV1eCQ2/cDsa+O2hLTEaYRs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kl4Bwps1RFoaA9L4XHW07Jbx4PDyk+iJobkaMURceNvEgEViUzOUcmxZsYJ95IhLr
	 SI4B9FLRCFkcmkwoAYoM0V4jh5YrqoY2dvQon5eccSfz+8OEW5eOPkCa84ty7L/Sow
	 rQ3/FJByVeAbep8SVIUrdLFYv9Y09Gio9w/0kTtdnChFJ1ImF5ZeZAq9rlSWWqnhYw
	 eW6BqYSxeZRBYzYzO2ri54m9Xd79y91p+gnQOWnLI6Rk6A5sYT92peeJxKxUa5FMOw
	 I3PvZy1BddlJv7CCQKGv8TI3YXQz78ajAjL1olMbi5eCWZv+DEo/ZlNf/uHUgAFLfM
	 fUxL/ov3TGong==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/10] mailbox: apple: Add DockChannel FIFO
 controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Reeves" <michael.reeves077@gmail.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260925-apple-mtp-keyboard-final-v4-5-304c267518f4@gmail.com>
References: <20260925-apple-mtp-keyboard-final-v4-0-304c267518f4@gmail.com>
 <20260925-apple-mtp-keyboard-final-v4-5-304c267518f4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 12:18:50 +0000
Message-Id: <20260925121851.4E4F41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] irq: infinite IRQ storm on early/spurious TX interrupt
- [High] mailbox: TOCTOU race loses TX completion interrupt
- [High] mailbox: missed RX interrupt on startup drops pre-existing data
--

commit cccb050135d4c52daf05b87f17ad880ef928b912
Author: Michael Reeves <michael.reeves077@gmail.com>

mailbox: apple: Add DockChannel FIFO controller

This adds a driver for Apple's DockChannel hardware FIFO used by coprocesso=
rs.
It exposes the FIFO pair as a Linux mailbox channel and handles interrupts
in a thread.

> diff --git a/drivers/mailbox/apple-dockchannel.c b/drivers/mailbox/apple-=
dockchannel.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/mailbox/apple-dockchannel.c

[ ... ]

> +static void apple_dockchannel_irq_enable(struct apple_dockchannel *dc, u=
32 bits)
> +{
> +	/*
> +	 * IRQ_FLAG is write-to-clear. Clear stale latched flags before
> +	 * unmasking so the next interrupt reflects current FIFO state.
> +	 */
> +	writel_relaxed(bits, dc->irq_base + IRQ_FLAG);
> +	apple_dockchannel_irq_update(dc, bits, true);
> +}

[ ... ]

> +static int apple_dockchannel_send_data(struct mbox_chan *chan, void *dat=
a)
> +{

[ ... ]

> +	dc->tx_active =3D true;
> +
> +	apple_dockchannel_write(dc, msg->data, msg->len);
> +	writel_relaxed(APPLE_DOCKCHANNEL_FIFO_SIZE,
> +		       dc->config_base + CONFIG_TX_THRESH);
> +	apple_dockchannel_irq_enable(dc, dc->irq_tx);

[Severity: High]
If the coprocessor is fast enough to drain the FIFO before
apple_dockchannel_irq_enable() executes, the hardware might latch the
TX-empty interrupt flag.

Since apple_dockchannel_irq_enable() unconditionally writes to IRQ_FLAG
to clear latched flags, does this destroy a valid completion interrupt
and stall the channel permanently?

> +
> +	spin_unlock_irqrestore(&dc->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int apple_dockchannel_startup(struct mbox_chan *chan)
> +{
> +	struct apple_dockchannel *dc =3D chan->con_priv;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dc->lock, flags);
> +	/*
> +	 * The mailbox framework has no per-client RX threshold. Use byte
> +	 * granularity because UART-style DockChannel clients require it.
> +	 */
> +	writel_relaxed(1, dc->config_base + CONFIG_RX_THRESH);
> +	apple_dockchannel_irq_enable(dc, dc->irq_rx);

[Severity: High]
During startup, apple_dockchannel_irq_enable() unconditionally clears
latched RX interrupts.

If the coprocessor sent data to the FIFO before the mailbox was opened,
does this clear the latched interrupt without reading the data?=20

Since the FIFO is already above the threshold, this could strand pre-existi=
ng
data by not generating a new edge interrupt.

> +	spin_unlock_irqrestore(&dc->lock, flags);
> +
> +	enable_irq(dc->irq);
> +
> +	return 0;
> +}

[ ... ]

> +static irqreturn_t apple_dockchannel_irq_thread(int irq, void *data)
> +{

[ ... ]

> +	if (pending & dc->irq_tx) {
> +		if (apple_dockchannel_tx_empty(dc)) {
> +			apple_dockchannel_irq_disable(dc, dc->irq_tx);
> +			tx_done =3D dc->tx_active;
> +			dc->tx_active =3D false;
> +		} else {
> +			pending &=3D ~dc->irq_tx;
> +		}
> +	}
> +
> +	writel_relaxed(pending, dc->irq_base + IRQ_FLAG);

[ ... ]

> +	if (!(pending & dc->irq_rx))
> +		return pending ? IRQ_HANDLED : IRQ_NONE;

[Severity: High]
If the hardware triggers an early or spurious TX interrupt before the FIFO
is completely empty, apple_dockchannel_tx_empty() is false, which drops the
TX flag from the pending mask.

When pending is written back to IRQ_FLAG, the unmasked TX interrupt flag
is left uncleared in the hardware register.

If there is no RX interrupt pending, the function returns IRQ_NONE. Because
the interrupt is left asserted in hardware and unmasked at the controller,
will this cause an immediate re-trigger and an infinite IRQ storm?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-apple-mtp-=
keyboard-final-v4-0-304c267518f4@gmail.com?part=3D5
