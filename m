Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EDF417365
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949746; cv=none; b=gEiZEaRCySxHGz6jnk66hr52JE8DMlZ+jpxLVu86a5+hhYT9ZwIF4nDeWukiIBXUY7xyoshp+l9MsdQGDHmkyEiBFb25kNZZKICnykxODb9tmw/OucRiWFYUAifp0VzClOgp9+UHGK+gkoQVRMeM2Ur2wvisOh45Lc7uufBtvFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949746; c=relaxed/simple;
	bh=Q0Zlt9KukRsofgVnk+iAmCjhdJOSgPLJiDaYPqjrEUY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OXW4vRN1HuuxhMjUhihh7Vl89CW5wqjR2FTSl4SUaN1nSqDvv/sZbmqoeLoVzIzgOWtSv6QI5JGhBgU3Gk+S5uuNwXj8DecCnxvYoY6msKhQGZxzotNRn6hddeqyekBQAcxFQ7Yk6dO84GwVCOg5SEAlS1Bs+p/v+Eeqhm5RjNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwGjcFmt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwGjcFmt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D2A1F00A3A;
	Mon, 13 Jul 2026 13:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783949745;
	bh=U5MB6kAsEep1EWAirqFjABOq/TW9Beeo4c3I7DbsiVs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YwGjcFmtWvNQ755vlMLMPw1BDnGP10QxxCUynNZ8/pUJmKx2BsmnOtfjkOIJJnq9/
	 JSB5iI1gybcCOKFH5FbrbycA6v2shDt/VCo4ijmlFdeJEfn0eZHoFSW9ns4O9MhODp
	 Y4zIGJDUI8+73zNmaUI8CN65uHiCzO6SaH5AEQx+9WbHevwihUAV1hjtjYaWTZ8cFj
	 3XiokHcQeF5C1ileXJ9JtGarR/eqeAdWdAa9uyxyEhWKVltjzkqWlohkyaKVM+qbby
	 Ag+wDslL0ACpzbV/IkwUgNnZ7e2jLtd+W8F0lxBgptW2phLfuAK/KONbohtdH+a3zu
	 ogsCFVmrscZNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] HID: Intel-thc-hid: Intel-quickspi: Remove
 redundant dev_err()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260713132439.380121-5-panchuang@vivo.com>
References: <20260713132439.380121-1-panchuang@vivo.com>
 <20260713132439.380121-5-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 13:35:44 +0000
Message-Id: <20260713133544.D7D2A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the driver doubl=
e-decrements the runtime PM usage counter in quickspi_probe, leading to an =
underflow.
--

--- Patch [4]: [PATCH 4/4] HID: Intel-thc-hid: Intel-quickspi: Remove redun=
dant dev_err() ---
commit 8f8bad90f3cb44d16834df11da9c79f13af5488d
Author: Pan Chuang <panchuang@vivo.com>

HID: Intel-thc-hid: Intel-quickspi: Remove redundant dev_err()

This commit removes a redundant dev_err() call after=20
devm_request_threaded_irq() in the quickspi_probe function, relying on the=
=20
core's built-in error logging to handle failures.

> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/dr=
ivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> index 4ae2e1718b30c..504ef3c842ab6 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> @@ -636,11 +636,8 @@ static int quickspi_probe(struct pci_dev *pdev,
>  					quickspi_irq_thread_handler,
>  					IRQF_ONESHOT, KBUILD_MODNAME,
>  					qsdev);
> -	if (ret) {
> -		dev_err(&pdev->dev,
> -			"Failed to request threaded IRQ, irq =3D %d.\n", pdev->irq);
> +	if (ret)
>  		goto dev_deinit;

[Severity: High]
This problem wasn't introduced by this patch, but while reviewing
quickspi_probe(), I noticed the driver appears to double-decrement the
runtime PM usage counter later in the same function:

drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c:quickspi_probe() {
    ...
    /* Enable runtime power management */
    pm_runtime_use_autosuspend(qsdev->dev);
    pm_runtime_set_autosuspend_delay(qsdev->dev, DEFAULT_AUTO_SUSPEND_DELAY=
_MS);
    pm_runtime_put_noidle(qsdev->dev);
    pm_runtime_put_autosuspend(qsdev->dev);
    ...
}

Will this cause a PM runtime usage count underflow?

During device probe, the PCI core inherently takes a PM runtime reference.
Calling both pm_runtime_put_noidle() and pm_runtime_put_autosuspend() drops
two references while only one was acquired. This could potentially break
runtime power management for the device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713132439.3801=
21-1-panchuang@vivo.com?part=3D4
