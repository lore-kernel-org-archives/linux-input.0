Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794123916;
	b=yqyPXyA/5Pr9z9lkxI+ht/8kCIhs65NkSuikvuGqpLH+oxZEwZpeeXrh1fGImTmWw31i
	 oFyMxL4PZievza7he5hQy05Em9piXnQ1y+2hX//rewehuCRFFPH0OBENLvDhp2BhPEUxI
	 9Otg4bSGtVE2R+f7LUFjbjQJk6ix22uy7o8gzggpegAYILFXFAmTRpJc8rFCALTfY6kwA
	 I/Ic8lZKwlFSeb0xJtJFoRVW9qQvFATs5EAaBxtC2G7oKmgpl+D2u/GXGXeMVyAVLMudE
	 PRw5ri8Ib8iIU0NHDVDwDtU2JbFPgU50eM612XtDS+8p0NeH3Vyhi0YNdzZs2jIyFOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794123916;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aF2G0ydcFppuwjaNTLg5qirYElBIA155TQabt5hQbPI=;
	b=3HMlLbtB1cA1JSN4zZYv16zmtJnuPUQGY5mJW2Vavc0OrSlPHJxyThRCZuhwPalCblKF
	 bZnqjEOvhHohcuxXY3CDjDQOi5I0XTqWUtm1RICZqXcDvs2HIPD+0TQXzSYgTHVPYxtJ/
	 Kw9ikfmYLu8zlMuqBgQudYBzitThmazczW9k+q4T0QyBYm2VlVm8+G/6RgMSpJPLhqMkK
	 3W8Ev4Yl01esNqONsB1F2lEjp74bR/DAZDgsZMLpQsyQcBvPU2zNqi48oc46nndi6f5us
	 DExIbz+j2PeUI2pm65szBISIHp4gj9FlkRIeKgETVqWLckaRqSZXmA4BmgLkOdeyzmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XtQWeMGm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0031606A31C;
	Sun,  8 Nov 2026 07:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XtQWeMGm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1CB1F0089F;
	Sun,  8 Nov 2026 07:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794123915;
	bh=aF2G0ydcFppuwjaNTLg5qirYElBIA155TQabt5hQbPI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XtQWeMGmszOzHz0yrOZsGLeXBVy+1lbgrqWFZ1eszJJI/X8+JiUqXHamMPTOWdTsP
	 8DmOkgyzklN6sBCDez7KfJEuCcy+5GroA9lb3z+34HhEDshsHs3BO6ARwqK7O24ciZ
	 txQexdPkezAOuswNXRkr/4I4THwhGFYTk0kFRYOVMDyI4jw50982b1czvmcQGFU0CH
	 aFB6xaL0J/L+TvAlFDzKY1Q0yIkkidZvW+Sxcu/Wp16jVv+jTVJhYvCbdU3AXtPeFe
	 aLiMvZ7F70SeEHTUEYOoO9jk4siMNJqNcs8ZAAtNPooBCcxD1A3ob+ig1+FlGftZwA
	 tMRge7CsdnMQA==
Message-ID: <sashiko-outbox-203639@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/8] mailbox: apple: Add DockChannel FIFO controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Reeves" <michael.reeves077@gmail.com>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261108-b4-apple-mtp-keyboard-v5-3-e2c97b82669a@gmail.com>
References: <20261108-b4-apple-mtp-keyboard-v5-0-e2c97b82669a@gmail.com>
 <20261108-b4-apple-mtp-keyboard-v5-3-e2c97b82669a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 07:45:14 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] mailbox: apple: unhandled TX IRQ storm in
  apple_dockchannel_irq_thread()
- [Medium] mailbox: apple: premature RX IRQ_FLAG clear in
  apple_dockchannel_irq_thread()
- [Medium] mailbox: apple: TX queue stall when FIFO is non-empty with
  tx_active false
--

commit b95e903761484cc55af89a24caaf5c68658e43d3
Author: Michael Reeves <michael.reeves077@gmail.com>

mailbox: apple: Add DockChannel FIFO controller

This commit adds a mailbox controller driver for the Apple DockChannel
hardware FIFO, handling TX completion and RX data in a threaded interrupt
handler.

> diff --git a/drivers/mailbox/apple-dockchannel.c b/drivers/mailbox/apple-=
dockchannel.c
> new file mode 100644
> index 0000000000000..4400d767f6ad5
> --- /dev/null
> +++ b/drivers/mailbox/apple-dockchannel.c

[ ... ]

> +static int apple_dockchannel_send_data(struct mbox_chan *chan, void *dat=
a)
> +{
> +	struct apple_dockchannel *dc =3D chan->con_priv;
> +	struct apple_dockchannel_msg *msg =3D data;
> +	unsigned long flags;
> +
> +	if (!msg || !msg->data || !msg->len)
> +		return -EINVAL;
> +
> +	if (msg->len > APPLE_DOCKCHANNEL_FIFO_SIZE)
> +		return -EMSGSIZE;
> +
> +	spin_lock_irqsave(&dc->lock, flags);
> +
> +	if (dc->tx_active || !apple_dockchannel_tx_empty(dc)) {
> +		spin_unlock_irqrestore(&dc->lock, flags);
> +		return -EBUSY;
> +	}

[Severity: Medium]
Can this stall the mailbox TX queue if the hardware TX FIFO is non-empty
while dc->tx_active is false?

When msg_submit() gets -EBUSY from send_data() on a txdone_irq controller,
it leaves the message queued in chan->msg_data and waits for
mbox_chan_txdone() to retry submission.  If residual bytes are in the FIFO
at apple_dockchannel_startup() or after apple_dockchannel_shutdown()
clears dc->tx_active and masks dc->irq_tx, returning -EBUSY here without
arming dc->irq_tx and setting dc->tx_active means no interrupt will fire
when the FIFO drains and mbox_chan_txdone() will never be called.

[ ... ]

> +static irqreturn_t apple_dockchannel_irq_thread(int irq, void *data)
> +{
> +	struct apple_dockchannel *dc =3D data;
> +	unsigned long irqflags;
> +	u32 flags;
> +	u32 pending;
> +	bool tx_done =3D false;
> +
> +	spin_lock_irqsave(&dc->lock, irqflags);
> +
> +	flags =3D readl_relaxed(dc->irq_base + IRQ_FLAG);
> +
> +	pending =3D flags & dc->irq_mask & (dc->irq_tx | dc->irq_rx);
> +	if (!pending)
> +		goto out_unlock_none;
> +
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
> +
> +	spin_unlock_irqrestore(&dc->lock, irqflags);
> +
> +	if (tx_done)
> +		mbox_chan_txdone(&dc->chan, 0);
> +
> +	if (!(pending & dc->irq_rx))
> +		return pending ? IRQ_HANDLED : IRQ_NONE;

[Severity: High]
Can clearing dc->irq_tx from pending when apple_dockchannel_tx_empty() is
false cause an unhandled IRQ storm?

In apple_dockchannel_send_data(), FIFO writes go to dc->data_base,
CONFIG_TX_THRESH goes to dc->config_base, and apple_dockchannel_irq_enable()
clears IRQ_FLAG and unmasks dc->irq_tx in dc->irq_base using relaxed MMIO
without a readback.  If dc->irq_tx is latched in IRQ_FLAG before
DATA_TX_FREE reaches APPLE_DOCKCHANNEL_FIFO_SIZE, removing dc->irq_tx from
pending skips clearing it in the write-to-clear IRQ_FLAG register while
leaving it unmasked in IRQ_MASK.  When dc->irq_rx is not also set, the
handler returns IRQ_NONE with the level-high interrupt still asserted,
re-entering the handler in a tight loop until genirq disables the IRQ line.

Also, because IRQ_FLAG is written after apple_dockchannel_tx_empty() is
checked, acknowledging IRQ_FLAG before checking DATA_TX_FREE is needed so a
FIFO that finishes draining between the check and the IRQ_FLAG write does
not lose its completion interrupt.

> +
> +	for (;;) {
> +		struct apple_dockchannel_msg msg;
> +		size_t avail;
> +
> +		avail =3D readl_relaxed(dc->data_base + DATA_RX_COUNT);
> +		if (!avail)
> +			break;
> +
> +		avail =3D min_t(size_t, avail, APPLE_DOCKCHANNEL_FIFO_SIZE);
> +
> +		apple_dockchannel_read(dc, dc->rx_buf, avail);
> +
> +		msg.data =3D dc->rx_buf;
> +		msg.len =3D avail;
> +		mbox_chan_received_data(&dc->chan, &msg);
> +	}
> +
> +	return IRQ_HANDLED;

[Severity: Medium]
Does clearing dc->irq_rx in IRQ_FLAG before draining the RX FIFO cause a
spurious interrupt after every RX transfer?

IRQ_FLAG is a sticky write-to-clear status register, and CONFIG_RX_THRESH
is set to 1.  When IRQ_FLAG is written before reading the FIFO,
DATA_RX_COUNT is still at least 1 (and more bytes may arrive while the loop
drains the FIFO), so dc->irq_rx immediately re-latches in IRQ_FLAG and trig=
gers
an extra wakeup of apple_dockchannel_irq_thread() once the line is unmasked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-b4-apple-m=
tp-keyboard-v5-0-e2c97b82669a@gmail.com?part=3D3
