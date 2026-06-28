Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB83F261B8D
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782666050; cv=none; b=ktOcxSQs6TaUfyUOCF2QBI+/GUHELQzCappicGLDaNqNqHBIyWIE1pr52CIDkal0GEH2ySSycF9zDejmqCUjdwcy+VOV7CF4Bag3Ff+zx0GxuG7QKSy1gOPBuo7Qad7PV3vQU6Z8iBEQADIv58gEPbjmP7Zziqrs567NLzQsPFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782666050; c=relaxed/simple;
	bh=0JBdmFGSSoi/JuqJ7gpWvcsRDuNTU9jFDJFj0YeEcZ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tv29rPn3wC6kEg6tiKjk347jBxUYHquIy+vAfo2eOgQvbuaA8RSUjzX/pl4JbVyI4t3W8O/eDNFtoy1pUUzxRisTN4UNSyxKtrUJHZHU059eSLDtVpZ7S+SpvHPGhlHiFVw3C+qPugRPbaDVGQe51bdYh/93Mnau9LTdGmLiVBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=id/VV21v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="id/VV21v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625721F000E9;
	Sun, 28 Jun 2026 17:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782666048;
	bh=axWxUUyDg5XHlgov6VNxfoVYW/W4rbAxI3bd1a4dCpg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=id/VV21vY2ZhA9pxgUvjwvhYqrIF9OMSfSDFtOJMUZRwhdMbM22646jnnb+IiXaUd
	 kViERTeA8blvGYhiAtHYDHhprkHTHEcNbGS9oybbNgMLSbVYNIlHWpZPYMOv2NzcHR
	 0ip2gLSGGoirwti90Jrg6Wgl7iCrqqKRGQwilh1MB6uHTuaIj92aIfi3TL2+u8aIby
	 qKPcu9t8xCt1dIRmqStt2UNw3j8bPz0S/tkckGF+XV6ANhZDoE+BlwYdlpl4LFAAKE
	 3b7ekhpnTaQGQ8MKIiGCbrw8IfeBqSN7N63bleTTUOwKCfJ9fC1aXn29gN6EwiGJ8v
	 ZCC65fDxruWEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: cp2112: validate input response lengths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260628164731.17614-1-alhouseenyousef@gmail.com>
References: <20260628164731.17614-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 17:00:46 +0000
Message-Id: <20260628170048.625721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The irqchip callback `irq_shutdown` causes a system panic by sleep=
ing in atomic context.
- [High] Concurrent masking and unmasking corrupts `dev->irq_mask`.
- [High] Stale state reads occur due to missing memory ordering between dat=
a updates and the availability flag.
- [High] Late USB responses from aborted I2C transfers wrongly satisfy new =
transfer wait conditions.
--

commit 4d019b9aa500a3c35cd141dda658a1f88ad1c46a
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

HID: cp2112: validate input response lengths

cp2112_raw_event() parses transfer-status responses as a fixed seven-byte
structure without checking the report size. It also trusts the length in
data-read responses and copies that many bytes even when the received
report is shorter. A malformed USB device can use either path to trigger
out-of-bounds reads from the HID input buffer.

Reject short status responses with -EMSGSIZE. Treat truncated data
responses as zero-length reads so the waiting transfer fails instead of
timing out or copying beyond the report.

Fixes: e932d8178667 ("HID: add hid-cp2112 driver")
Cc: stable@vger.kernel.org

> diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
> index 04379db93571b..f2988659a5cbb 100644
> --- a/drivers/hid/hid-cp2112.c
> +++ b/drivers/hid/hid-cp2112.c
> @@ -1430,6 +1430,12 @@ static int cp2112_raw_event(struct hid_device *hde=
v, struct hid_report *report,
> =20
>  	switch (data[0]) {
>  	case CP2112_TRANSFER_STATUS_RESPONSE:
> +		if (size < sizeof(*xfer)) {
> +			dev->xfer_status =3D -EMSGSIZE;
> +			atomic_set(&dev->xfer_avail, 1);

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to use atomic_set=
()
here without a write memory barrier?

If a thread waiting on another CPU reads the flag locklessly via
wait_event_interruptible_timeout() in cp2112_wait(), could the CPU reorder
the data stores and loads? For example:

cp2112_wait()
    ret =3D wait_event_interruptible_timeout(dev->wait,
            atomic_read(avail), msecs_to_jiffies(RESPONSE_TIMEOUT));

Could this cause the reader to see the flag as set but read stale data?

[Severity: High]
This is also a pre-existing issue, but does setting the availability flag
unconditionally here leave us vulnerable to late USB responses?

If an I2C transfer times out and a new transfer is initiated, could a delay=
ed
response from the aborted transfer arrive here and incorrectly wake up the =
new
transfer since there's no sequence number checking?

> +			break;
> +		}
> +

[ ... ]

>  	case CP2112_DATA_READ_RESPONSE:
> +		if (size < 3 || data[2] > size - 3) {
> +			dev->read_length =3D 0;
> +			atomic_set(&dev->read_avail, 1);
> +			break;
> +		}
> +

While reviewing this file, I noticed a couple of other pre-existing issues:

[Severity: High]
This is a pre-existing issue, but does disabling a GPIO IRQ cause a system
panic by sleeping in atomic context?

The irqchip callback irq_shutdown is called by the IRQ core with the
per-IRQ desc->lock raw spinlock held. In cp2112_gpio_irq_shutdown():

cp2112_gpio_irq_shutdown()
    cancel_delayed_work_sync(&dev->gpio_poll_worker);

Could calling this sleeping function inside a raw spinlock trigger a BUG
scheduling while atomic?

[Severity: High]
This is another pre-existing issue, but can concurrent masking and unmasking
corrupt dev->irq_mask?

The irq_mask and irq_unmask callbacks are called with the per-pin desc->lock
held, so they can execute concurrently on different CPUs for different pins.

In cp2112_gpio_irq_mask():
    __clear_bit(hwirq, &dev->irq_mask);

And in cp2112_gpio_irq_unmask():
    __set_bit(hwirq, &dev->irq_mask);

Do these non-atomic bitwise updates create a read-modify-write data race on
the shared dev->irq_mask, leading to lost or stuck interrupts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628164731.1761=
4-1-alhouseenyousef@gmail.com?part=3D1
