Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332D32DEA89
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950209; cv=none; b=SoMehXXmx27XAqDFQKrZXVhre0nYqITSR8WFMtlRtyKaljYXGTvTVTpqaat1+Rlgeh71u3NjfWIlxx555IJNJQpro3iJCBY/eSGRBOX/I9ZMKqCBaj8KtcHFBw+GhUm+SwNnfNM7zy2e91W839dyFhYii+vx/kR8heGAWur7A4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950209; c=relaxed/simple;
	bh=S8pSBv5mkVzpCWJLhf3LGyfg92wb05/exHSieFOFMDM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AQP9p0wOBB/vJr/HmCfGlLYqphLP+tig+0NEFsr/lej6jaWeBrbAgDIu+fsfW86XGmkAmcwo0usxG79hjvyUYJhy4JuvTDP7gMnexltciXnBvNudcibtngT7b6K5SLkIjljI8XQaY9uhNo2tzwlrpT+eigpMFEjC+xgNSf3HZW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+aSxYjw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+aSxYjw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51F81F000E9;
	Mon, 13 Jul 2026 13:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783950207;
	bh=o3GdAxi5PQVkb6X6DjunuNOi1bar1MIF3kG/NtGTls8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c+aSxYjwbB6Qbt6AKZaW/d6kIwrNqIqytSBmgmclt10NMGq1EKvWB8RO0vKcOg8kZ
	 QaolE+4nY4zBrhWQL2SPwUggnWCa18d/QcMrMD4wU2ojLZbsLSlVXT6yQ1ZgA/24fa
	 aReTyjWAk45rjOZmOSC51jjLYIU2OFXKpXQxBUcubIaXS3Tv35s6xh6JvHYCBiuCSn
	 OBH4aAS9qF0ePg2g0Qbd6N89ro2HAo6NzwkvZ0vWuf/7xCZGtI1gb6fZ745xa2lkum
	 XJqNvbSy/ZqU1YXv4laH1FxH9rRen+c0UMR0M5oKD9u+dRgWphLFVqS1EiZ7RP03zy
	 y9fOcyZNaJ9gQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] HID: intel-ish-hid: ipc: Remove redundant dev_err()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260713132439.380121-4-panchuang@vivo.com>
References: <20260713132439.380121-1-panchuang@vivo.com>
 <20260713132439.380121-4-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 13:43:27 +0000
Message-Id: <20260713134327.A51F81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `bh_hbm_work_fn` background task lacks a loop to process all p=
ending messages, which can result in bus messages getting permanently stuck=
 in the ring buffer (`rd_msg_fifo`).
--

--- Patch [3]: [PATCH 3/4] HID: intel-ish-hid: ipc: Remove redundant dev_er=
r() ---
commit caab51c18c54958eb317830d35603876995d77e0
Author: Pan Chuang <panchuang@vivo.com>

HID: intel-ish-hid: ipc: Remove redundant dev_err()

The commit removes a redundant dev_err() call from ish_probe() after
devm_request_irq(). The devm_request_irq() function handles its own
logging on failure, making the driver-specific error message unnecessary.

> diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-=
ish-hid/ipc/pci-ish.c
> index ed3405c05e73c..cef1030643f15 100644
> --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
[ ... ]
> @@ -232,10 +232,8 @@ static int ish_probe(struct pci_dev *pdev, const str=
uct pci_device_id *ent)
> =20
>  	ret =3D devm_request_irq(dev, pdev->irq, ish_irq_handler,
>  			       irq_flag, KBUILD_MODNAME, ishtp);
> -	if (ret) {
> -		dev_err(dev, "ISH: request IRQ %d failed\n", pdev->irq);
> +	if (ret)
>  		return ret;
> -	}
> =20
>  	dev_set_drvdata(ishtp->devc, ishtp);

While looking at this subsystem, I noticed a pre-existing issue in the
related HBM processing path.

drivers/hid/intel-ish-hid/ishtp/hbm.c:
> void	bh_hbm_work_fn(struct work_struct *work)
> {
[ ... ]
> 	spin_lock_irqsave(&dev->rd_msg_spinlock, flags);
> 	if (dev->rd_msg_fifo_head !=3D dev->rd_msg_fifo_tail) {
> 		memcpy(hbm, dev->rd_msg_fifo + dev->rd_msg_fifo_head,
> 			IPC_PAYLOAD_SIZE);
> 		dev->rd_msg_fifo_head =3D
> 			(dev->rd_msg_fifo_head + IPC_PAYLOAD_SIZE) %
> 			(RD_INT_FIFO_SIZE * IPC_PAYLOAD_SIZE);
> 		spin_unlock_irqrestore(&dev->rd_msg_spinlock, flags);
> 		ishtp_hbm_dispatch(dev, (struct ishtp_bus_message *)hbm);
> 	} else {
> 		spin_unlock_irqrestore(&dev->rd_msg_spinlock, flags);
> 	}
> }

[Severity: High]
This is a pre-existing issue, but does bh_hbm_work_fn() need a loop to
process all pending messages?

Currently, it pops and processes exactly one message from rd_msg_fifo
before returning. If recv_hbm() adds a second message and calls
queue_work() before this worker thread begins execution, the second
queue_work() is a no-op because the work is already pending.

Could this leave crucial IPC bus messages from the firmware stuck in the
rd_msg_fifo ring buffer indefinitely until another arbitrary interrupt
arrives?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713132439.3801=
21-1-panchuang@vivo.com?part=3D3
