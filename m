Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B30142DA3D
	for <linux-input@vger.kernel.org>; Sun, 11 Oct 2026 22:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791757225; cv=none; b=XaEyKYeP3GhiJPLhmIFLuutVme0KNA2c82YWOJXwJii1Z694sT5iTk2OiMHu+RUSav0YymJxb6EjXX+Sj8qC9vcLxQ0zin8OYwG0GbjQSQ3Bxibf647/w9RlmFlfkd6jsAtDa0ugnXs4S4nNwuy7hkwGJfvy73FtYSYEVDvDg/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791757225; c=relaxed/simple;
	bh=3tET96btQ5l9uELilDN7bFpHN4VSTQR+H9PEXlvrhIs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=p6EUNJuyjkV9cDfmDqIyFlgfMgwK9FnxHcOJiFLPXDulKLawAvobAe1k5Jm6/XgbipeVF4x4UYw8QLYHsZVaATig17R3yKmwuxq1KsLE28XKYSH2L06WVxPeA+usDo2KRwTqVmKo2GXSnHcWvU8O/G6NKr5fE7eU+VDFSVMoWWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aw7gMEDY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aw7gMEDY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F0C1F0089B;
	Sun, 11 Oct 2026 22:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791757224;
	bh=hXxO8jJcrLemkhaVAabgNeuzq1oJqHGkMulNWjbLUrg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Aw7gMEDYc+rqg7Nx2Bf73d6DKzK+5yj2nCpB73nYtld93qSh09fcC7deYEelvY8Zt
	 tcR6xKZfK4VMpPQvX3Gyp/W9q2mZpySQh9Iz1rLUJwRI65p2ms7TMjyjMF5kLVK+LP
	 gwHtz4vmONMY2/Sgknu4IXBNFKzgxcu4UAWwN2fl6XGsUD2u6a6PR3hDVqKOGd3OF/
	 M1tzQ1pJ/m6ZmQI3Y7mlKUOWpDs3tniBYFu4iLBqHwXG0dupPC9zvJaUE+lUzB1c/o
	 pP/BQb1Qm0WffisvTrDes/vPcocJI/K5antpzCL7/ejNDanvxuHhjSJ6e2oCSLUMuX
	 dZLxPPzjeJgRA==
Message-ID: <sashiko-outbox-167473@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] HID: intel-thc-hid: quicki2c: quiesce IRQs during
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20261011220531.2073892-3-mhun512@gmail.com>
References: <20261011220531.2073892-1-mhun512@gmail.com>
 <20261011220531.2073892-3-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 22:20:23 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] hid: intel-thc: 1s timeout on HID teardown commands due to early=
 IRQ disable
--

commit 074bce22ab8075bef92df21dcd016a16b939a785
Author: Myeonghun Pak <mhun512@gmail.com>

HID: intel-thc-hid: quicki2c: quiesce IRQs during teardown

This commit disables and synchronizes the IRQ, drains recovery work, and
masks THC interrupts before freeing the IRQ and releasing HID/DMA resources.
It tracks IRQ/DMA initialization for conditional probe cleanup and disables
the IRQ during shutdown as well.

> diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/dr=
ivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> index 7a913f717efaa..ac073be894817 100644
> --- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> +++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
[ ... ]
> @@ -788,9 +798,12 @@ static void quicki2c_remove(struct pci_dev *pdev)
>  	if (!qcdev)
>  		return;
> =20
> -	quicki2c_hid_remove(qcdev);
> -
> +	WRITE_ONCE(qcdev->recovery_disabled, true);
> +	disable_irq(pdev->irq);
>  	quicki2c_dev_deinit(qcdev);
> +	devm_free_irq(&pdev->dev, pdev->irq, qcdev);
> +
> +	quicki2c_hid_remove(qcdev);

[Severity: Medium]
Could moving the IRQ disable/free and device deinit before
quicki2c_hid_remove() break any HID raw_requests issued during high-level
driver teardown?

High-level HID drivers (like hid-multitouch) often send final commands
(e.g., turning off LEDs or disabling features) during their remove
callback, which is triggered by hid_destroy_device() inside
quicki2c_hid_remove().

Since the patch moves disable_irq() and devm_free_irq() before
quicki2c_hid_remove(), thc_dma_write() in intel-thc-dma.c will block
for 1 second waiting for an IRQ completion that will never arrive:

	ret =3D wait_event_interruptible_timeout(dev->write_complete_wait, dev->wr=
ite_done, 1 * HZ);
	if (ret <=3D 0 || !dev->write_done) {
		dev_err_once(dev->dev, "timeout for waiting TxDMA completion\n");
		ret =3D -ETIMEDOUT;
		goto end;
	}

This might unconditionally introduce a 1-second delay per command
during device unbind or system shutdown if the bound high-level HID driver
issues any hardware commands in its remove callback.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011220531.2073=
892-1-mhun512@gmail.com?part=3D2
