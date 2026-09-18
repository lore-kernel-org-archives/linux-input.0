Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7FA4AA574;
	Fri, 18 Sep 2026 11:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789730374; cv=none; b=sHnNwLqgKQCzypZSZsEEvIOdmIYTkAJgvZD5nmBRuHjV/7Q6GtKuGtRd52aAB7brM57DIvsHWk6bdl7tDyrG1mJM/ijZgrnO9Z0Gfvt9EYX/6nWayHpiM2MwUwPwyvupev8U7TT3/yX0F5ktwrGviE+kCaLu/FFrHTe6eGUjJAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789730374; c=relaxed/simple;
	bh=9ccsESYXHvoMwf4HBPfn96X/ssa+CtkaPha9NehXZkY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KdQvQmuX/+eDz+lmZS4PyKoummk0DeeLlcdMxDoljGeKWRg5/hDWu/lV2c1uorUsyBJnF3GxSphzw8zqFQ8hNVMEe/BHO2JrqnaOeo5oKnHDK5YM0ZfVhbowd/mHWoRcgewLpmI5+yFkdCiHT2l/r0i42vJT4az7bDTCAEVTVy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+ZsQOzG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+ZsQOzG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDC21F000FF;
	Fri, 18 Sep 2026 11:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789730372;
	bh=1YlMacjxCYi795BMSTNZ3KiDURvOtdGQRiDhRbWaapU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J+ZsQOzG6WIcULoJSOEWasxr/rBSjjRYQHKSUY7ucTQmVl16c0f4pdkZZD+bOO2eT
	 ja7FKP23BiSmLbIG0VZJkt32CGZmu9ltbybN5Hzy1QKx9WxMvdRjZrC81ePzFAwVC+
	 nsMPIEctLgdenLw3+MGeRCxciu2EHjk3r+n4BHSFYH+mxZ6Xni1aTHG7wL98LsByuu
	 V+/qmpOkTFe/6K8g62euYhgMaw35c8uLejwdm1OQqoOPWdyjHirROg2wK2/R12oGPD
	 hfRpFqRCTAPwlskJODiNq7xjZuRzXq9ZVxCsaZ8B3WxvRUx/a/nV4xvntHxB2a4Z+L
	 rS65D5pIsloQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/10] mailbox: apple: Add DockChannel FIFO
 controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Reeves" <michael.reeves077@gmail.com>
Cc: linux-input@vger.kernel.org, robh@kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260918-apple-mtp-keyboard-final-v2-5-a5c685e50b60@gmail.com>
References: <20260918-apple-mtp-keyboard-final-v2-0-a5c685e50b60@gmail.com>
 <20260918-apple-mtp-keyboard-final-v2-5-a5c685e50b60@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 11:19:31 +0000
Message-Id: <20260918111932.3DDC21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] mailbox: apple: interrupt storm if TX FIFO not empty during IRQ_TX
- [High] mailbox: apple: data corruption due to asymmetric byte lane mappin=
g on TX
- [High] mailbox: apple: TOCTOU race clearing IRQ_FLAG loses TX/RX events
--

commit 93fab252e833f92aad9624f1eae3f18e4b2d3e72
Author: Michael Reeves <michael.reeves077@gmail.com>

mailbox: apple: Add DockChannel FIFO controller

DockChannel is a hardware FIFO used by Apple coprocessors for
low-latency byte-stream communication with the AP. Add a mailbox
controller that preallocates RX storage, tracks IRQ enable state
in software, and reports TX completion from the TX-empty interrupt.

> diff --git a/drivers/mailbox/apple-dockchannel.c b/drivers/mailbox/apple-=
dockchannel.c
> index 0000000000000..d0a66e1b786cd
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

[Severity: High]
Does clearing IRQ_FLAG unconditionally before unmasking create a TOCTOU race
that loses events?

For example, in apple_dockchannel_send_data():
1. apple_dockchannel_write_pending() runs and the coprocessor starts draini=
ng
   the FIFO.
2. The coprocessor drains the TX FIFO and the hardware latches IRQ_TX.
3. apple_dockchannel_irq_enable(dc, IRQ_TX) unconditionally clears the latc=
hed
   IRQ_TX completion flag.

Can this result in permanent loss of TX completion interrupts, or similarly
swallow RX data interrupts during apple_dockchannel_startup(), leading to a
channel deadlock?

> +	apple_dockchannel_irq_update(dc, bits, true);
> +}
[ ... ]
> +static void apple_dockchannel_write_pending(struct apple_dockchannel *dc)
> +{
> +	size_t left =3D dc->tx_len - dc->tx_pos;
> +	const u8 *p =3D dc->tx_buf + dc->tx_pos;
> +
> +	while (left) {
> +		size_t avail;
> +		size_t block;
> +
> +		avail =3D readl_relaxed(dc->data_base + DATA_TX_FREE);
> +		if (!avail)
> +			break;
> +
> +		block =3D min(left, avail);
> +
> +		while (block >=3D sizeof(u32)) {
> +			writel_relaxed(get_unaligned_le32(p),
> +				       dc->data_base + DATA_TX32);
> +			p +=3D sizeof(u32);
> +			left -=3D sizeof(u32);
> +			block -=3D sizeof(u32);
> +		}
> +
> +		while (block) {
> +			writel_relaxed(*p++, dc->data_base + DATA_TX8);

[Severity: High]
Does this place the remainder byte in the wrong byte lane?

The RX path in apple_dockchannel_read() documents that the hardware uses
bits [15:8] for 8-bit FIFO accesses, shifting the read value by 8:

    *p++ =3D readl_relaxed(dc->data_base + DATA_RX8) >> 8;

Should the TX path also shift the byte << 8 to align with the hardware's
expected byte lane, avoiding data corruption for unaligned payloads?

> +			left--;
> +			block--;
> +		}
> +	}
> +
> +	dc->tx_pos =3D dc->tx_len - left;
> +}
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

[Severity: High]
If IRQ_TX is removed from the pending mask when the FIFO is not empty, does
it prevent the hardware latch from being cleared?

Since IRQ_FLAG is a write-to-clear register, writing back the modified mask
with IRQ_TX cleared will fail to clear the IRQ_TX hardware latch. Will this
cause an infinite interrupt storm upon returning from the handler?

> +
> +	spin_unlock_irqrestore(&dc->lock, irqflags);
> +
> +	if (tx_done)
> +		mbox_chan_txdone(&dc->chan, 0);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-apple-mtp-=
keyboard-final-v2-0-a5c685e50b60@gmail.com?part=3D5
