Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E04F367B8B
	for <linux-input@vger.kernel.org>; Sun, 11 Oct 2026 22:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791757266; cv=none; b=BADTZlW5TKA/ehuQgg+txXnmc/04uTQOAiT4UFBQcAnMmGKCNSPWiOAj6Esurojpw6ZXhnJi7JAROK8Lo6xSxp0kUZoh+4Ec5K2/WU3VuqV38DMDoDUeX6/Y4/K1rgHytQNmTDHeeIvw0/XBKoE6Hbg4vBLpAtJGlyKatxra13Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791757266; c=relaxed/simple;
	bh=7aeyxbJ1AvXaMYthPR2UWBVyUkzk1Hu5yyCbG+IMSIw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=XhMj2ZDuhGrNLihc0SrbifqACSkhlLwQZvhavycskAQkWCRMfMpZoioBXjv89OYnk3uIhjGhK8R62XDsjqafqNyw0y6kBiRsmHIHGAtn+BfNYpJpKcCMZkAsmpKnQSvOd9KUBZxgZ2hhaTdWrk8iDZaFeoP5XY3DTo6hp0Xog8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQhVwVKt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQhVwVKt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993AA1F0089B;
	Sun, 11 Oct 2026 22:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791757264;
	bh=fmAXjjfdFG/WUU/lnbGgnO07XDUnu6066NCmW1ocqwE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cQhVwVKtfhxMXtgICIg3PSgdGHBiKYi2IveOHN/fIUEfTp82D7dTj1y0/PwW7oqwu
	 2gZaZBrr0OLxKHG9QB/jeUoSYIlNQxgXQ6DfTBEZOl8Hp5gQTFcjuOLltzCSebea77
	 PXrZ/CFjiNtZK3Q+YZ9uCG9Hy1THjmKBC1ySUKc2Y6qpLnh0ymF2YBnPjOrke0cOyR
	 JyyymyVJCChsj65t+OfZdq0y+8QK8Lfz6ALJ/xm/ZowskRvU6BVcHF9za9an8NBLxg
	 HdL3uwRARnwbu5fYs59QqUf4jNpY5EXqNMOqmeUpVv3HSI9i4heb+p4Wp8/6FOam4/
	 5aRRN4fdQB02w==
Message-ID: <sashiko-outbox-167476@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] HID: intel-thc-hid: quickspi: quiesce IRQs during
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20261011220531.2073892-2-mhun512@gmail.com>
References: <20261011220531.2073892-1-mhun512@gmail.com>
 <20261011220531.2073892-2-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 22:21:04 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hid: intel-thc-hid: DMA UAF due to HID deregistration race in remo=
ve
--

commit 664b72e58bd5cb1485c8eb563326dab08180f916
Author: Myeonghun Pak <mhun512@gmail.com>

HID: intel-thc-hid: quickspi: quiesce IRQs during teardown

This commit disables and synchronizes the IRQ and drains recovery work prior
to freeing the IRQ and releasing HID/DMA resources. It introduces this orde=
red
teardown in both the probe error and remove paths.

Link: https://lore-kernel.gnuweeb.org/linux-input/20260717035609.3874015-1-=
even.xu@intel.com/T/
Link: https://patchew.org/linux/20260729050145.2272597-1-even.xu@intel.com/

> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/dr=
ivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> index 53023e30cf8d4..c67476a378573 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
[ ... ]
> @@ -721,9 +731,12 @@ static void quickspi_remove(struct pci_dev *pdev)
>  	if (!qsdev)
>  		return;
> =20
> -	quickspi_hid_remove(qsdev);
> -
> +	WRITE_ONCE(qsdev->recovery_disabled, true);
> +	disable_irq(pdev->irq);
>  	quickspi_dev_deinit(qsdev);
> +	devm_free_irq(&pdev->dev, pdev->irq, qsdev);
> +
> +	quickspi_hid_remove(qsdev);

[Severity: High]
Does this sequence open a race window for a hardware DMA use-after-free?

By tearing down the hardware and disabling interrupts before unregistering =
the
HID device, it appears userspace can still issue a request via hidraw during
unbind.

If a raw_request is queued on the disabled device, it may call thc_dma_writ=
e()
to submit a TxDMA request:

drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c:thc_dma_write() {
    ...
	ret =3D wait_event_interruptible_timeout(dev->write_complete_wait, dev->wr=
ite_done, 1 * HZ);
	if (ret <=3D 0 || !dev->write_done) {
		dev_err_once(dev->dev, "timeout for waiting TxDMA completion\n");
		ret =3D -ETIMEDOUT;
		goto end;
	}
    ...
}

Because IRQs are disabled here, the wait will time out and return -ETIMEDOU=
T,
but it fails to clear the TxDMA START bit.

quickspi_remove() will then proceed to unregister the HID device and call
quickspi_dma_deinit(), which frees the DMA buffers without clearing the TxD=
MA
START bit. Could this allow the hardware TxDMA engine to remain active and
access freed DMA memory, leading to memory corruption or an IOMMU fault?

Note that follow-up patches in the series do not appear to resolve this rac=
e.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011220531.2073=
892-1-mhun512@gmail.com?part=3D1
