Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C109D513574;
	Fri, 18 Sep 2026 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738824; cv=none; b=uio+KVn71KxOGC879pAiMO4cf22jUsoTL/j99rNb4ohlZhy+mNAJuA+tkU2hiyGSLyyJyqNWqraM/um4pFIkIPEXo+tC2MGZnfLMwfQlyNbNiEwKpaVbRRpDrQc21d4DKhX4M3UHyZay+p5JedbJ963lAP1md2ptlmz5F9ObV2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738824; c=relaxed/simple;
	bh=Y5AI++T6hC9WIipMlduO+vQ0RNPFYkmnAwmLtnAIGns=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KFAIjOG3AMYh7BKv8q8oBUOZEDov7uKmEPPNguOPDHo0/hI3Xx/n3WDCyNddwF9T9/iCipcWbAXas7R9hqYiVN2kbDz6iQww2NNclotLFGCvCqnTceW2Pw8HozLUuZ62/VuMvAxRsSHx+ZPR3oTkjws32st4CGtOmCUwU4V3Lkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOXDv5LA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOXDv5LA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE471F000FF;
	Fri, 18 Sep 2026 13:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789738821;
	bh=XTi9Oe9y8tnv+l0hdxOf2X/JoMlZn58xr7nYnH45wHI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FOXDv5LAvBafQfrokPp74VIZNBrEgjOovtoV9W5+8M/DDrUYTA+kQ37HzxY6/lKx6
	 OeooF2p5w2SaT1ajTzG2I3ojRhS+ACKLnSwgOBGD4a65lO0TSMX/rFWrHMxo5d6o6E
	 o94XBaueM0JwSSmv3WO6adTEBfzuHE1iN55YHgkP8Sw+znAJ+kTDu5PmaQ7j15CmrX
	 hJ+hkf7rcntWddsMcagNFiwdXwRAu8dGseAns1svqKuM7153ETgb5HhixE5EboMYBK
	 XEBKihYc1HClTmCbNSZF2j9cFQZ5cqNl1HQsNshunFbbyRGv889L1LxoD04BDyx+vc
	 vphiwesTzqtwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/10] mailbox: apple: Add DockChannel FIFO
 controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Reeves" <michael.reeves077@gmail.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260918-apple-mtp-keyboard-final-v3-5-e356464e454b@gmail.com>
References: <20260918-apple-mtp-keyboard-final-v3-0-e356464e454b@gmail.com>
 <20260918-apple-mtp-keyboard-final-v3-5-e356464e454b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 13:40:20 +0000
Message-Id: <20260918134021.1DE471F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] mailbox: apple: lost TX interrupt due to clearing IRQ_FLAG after t=
ransmission starts
- [High] mailbox: apple: TOCTOU race in IRQ handler clears newly asserted i=
nterrupts
- [Medium] mailbox: apple: interrupt storm when IRQ_TX fires but FIFO is no=
t empty
--

commit 2a04249ed27a338883aa783b0cfe092f13b2057a
Author: Michael Reeves <michael.reeves077@gmail.com>

mailbox: apple: Add DockChannel FIFO controller

DockChannel is a hardware FIFO used by Apple coprocessors for
low-latency byte-stream communication with the AP. This adds a
mailbox controller that preallocates RX storage, tracks IRQ enable
state in software, and reports TX completion from the TX-empty
interrupt.

> diff --git a/drivers/mailbox/apple-dockchannel.c b/drivers/mailbox/apple-=
dockchannel.c
> index 0000000000000..a99b8dad03987
> --- /dev/null
> +++ b/drivers/mailbox/apple-dockchannel.c
[ ... ]
> +static int apple_dockchannel_send_data(struct mbox_chan *chan, void *dat=
a)
> +{
[ ... ]
> +	dc->tx_buf =3D msg->data;
> +	dc->tx_len =3D msg->len;
> +	dc->tx_pos =3D 0;
> +	dc->tx_active =3D true;
> +
> +	apple_dockchannel_write_pending(dc);
> +	writel_relaxed(APPLE_DOCKCHANNEL_FIFO_SIZE,
> +		       dc->config_base + CONFIG_TX_THRESH);
> +	apple_dockchannel_irq_enable(dc, IRQ_TX);

[Severity: High]
Does this create a race condition where a valid completion interrupt
is cleared?

The transmission is initiated by writing to the FIFO in
apple_dockchannel_write_pending(). The hardware can transmit the bytes
and become empty extremely fast. If it does so before the call to
apple_dockchannel_irq_enable() executes, the hardware latches the IRQ_TX
completion flag, and apple_dockchannel_irq_enable() immediately clears
it, potentially permanently hanging the channel.

Could the stale flags be cleared prior to writing the FIFO?

[ ... ]
> +static irqreturn_t apple_dockchannel_irq_thread(int irq, void *data)
> +{
> +	struct apple_dockchannel *dc =3D data;
> +	unsigned long irqflags;
> +	u32 flags;
> +	u32 pending;
> +	bool tx_done =3D false;
> +
> +	flags =3D readl_relaxed(dc->irq_base + IRQ_FLAG);
> +
> +	spin_lock_irqsave(&dc->lock, irqflags);
> +
> +	pending =3D flags & dc->irq_mask & (IRQ_TX | IRQ_RX);
> +	if (!pending)
> +		goto out_unlock_none;
> +
> +	if (pending & IRQ_TX) {
> +		if (apple_dockchannel_tx_empty(dc)) {
> +			apple_dockchannel_irq_disable(dc, IRQ_TX);
> +			tx_done =3D dc->tx_active;
> +			dc->tx_active =3D false;
> +		} else {
> +			pending &=3D ~IRQ_TX;
> +		}
> +	}
> +
> +	writel_relaxed(pending, dc->irq_base + IRQ_FLAG);

[Severity: Medium]
Will this lead to an interrupt storm if the TX interrupt fires but the
FIFO is not empty?

Since IRQ_FLAG is a write-1-to-clear register, removing IRQ_TX from
pending intentionally skips clearing the active hardware interrupt in
this case. The handler returns while the unmasked interrupt is still
asserted, causing the IRQ controller to immediately re-fire the interrupt.

While this may require a spurious hardware interrupt or glitch to trigger,
it would result in an infinite interrupt loop that permanently hangs a
CPU core.

[ ... ]
> +out_unlock_none:
> +	spin_lock_irqrestore(&dc->lock, irqflags);
> +
> +	if (flags & (IRQ_TX | IRQ_RX))
> +		writel_relaxed(flags & (IRQ_TX | IRQ_RX),
> +			       dc->irq_base + IRQ_FLAG);

[Severity: High]
Can this write back a stale flags value, clearing newly asserted interrupts?

The flags value is read outside the lock at the beginning of the handler.
If the handler takes the out_unlock_none path (e.g., due to a concurrent
shutdown making pending =3D=3D 0), it will write this stale flags value to
IRQ_FLAG locklessly.=20

If another CPU executes apple_dockchannel_send_data() and completes a
transmission in the intervening window, this lockless write-1-to-clear
will wipe the newly generated IRQ_TX interrupt, hanging the mailbox channel.

> +
> +	return IRQ_NONE;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-apple-mtp-=
keyboard-final-v3-0-e356464e454b@gmail.com?part=3D5
