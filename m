Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DAC36EA99
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 18:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781548349; cv=none; b=NIJAZ3m2vbFgFMgxeSMaeJtZ65NPnc02MfudHhDZJRq8G3URosmewTR+JAr+yppwHgp1neQl09KlxyR7IvbDqFG+wgzSjQFx+h2DisbBo6RTt+Yv5kzrknNlOpzxhD/iNrBPVyGT7A6KZDBDIZG4PxuzMjYTHaUdXSpA12s0NHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781548349; c=relaxed/simple;
	bh=oguEWWXpL/NXnGB5+8LcUoABpsfXgdXbAL6GZIUEg2U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dHc6JIXuQ1kxy3aU1QBU++O5UUdx7FHy8M2Bnpq0KsuiZ8ywkdoGoemVNZV425AbsCtEn3tknVtoXQ0TttJjxxZWVutzQTwSJoaKh1vYbNEaOu4UKzq3WbPb9xzQ9Hmez41YCHlE23dtf3IVpEQNf5f/LFN5Diw9ripUb1OZE10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHLtrXNI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHLtrXNI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B191F00A3A;
	Mon, 15 Jun 2026 18:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781548348;
	bh=HLFvDW2TWva7AURaXuoLk9RTSWM9BD7i2AktOfIffg0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CHLtrXNIA/KN5F2cct29/IDq9Y9l2Cx4H2wA/wWPu6CYrNYkx+0OHpkzQ1lyKDjz5
	 pCX5c0X/xTDujzMNGyNFGWlG6UCrIgyU2qmqwteyEK+92cZuFQ26ShzqwQKce3qqcl
	 k1PjM360eyvTa7lUqeqdaneKWXKnpmL6bQYdl4o1Ksf12a/aHNWg+/TgIToLmesu33
	 8NaPAv9aR1q3QERcwdrn6XF5qRMiR38t2e0qGdkb2Jtlwh/KG7gROtHL4GcAwSLwkZ
	 2KCeN3PE3kQlbQmb3Uu+RjUTm3YGIrmB0omxfWQd/0lpR7Ylyx1cBWNE0UoTVpB7sI
	 A72YsjdEKoWeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] Input: apple_z2 - bound the device-reported
 finger count
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas via B4 Relay" <devnull+hexlabsecurity.proton.me@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260615-b4-disp-05943ee1-v3-2-bbfe1b651613@proton.me>
References: <20260615-b4-disp-05943ee1-v3-2-bbfe1b651613@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 18:32:27 +0000
Message-Id: <20260615183228.44B191F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent execution of apple_z2_read_packet() from the probe thre=
ad and threaded IRQ handler causes buffer corruption.
- [High] Missing length check for `fw->size` before accessing the firmware =
header in `apple_z2_upload_firmware()`.
- [Medium] The timeout error path in `apple_z2_boot()` returns early withou=
t disabling the IRQ or asserting the reset GPIO.
- [Low] Missing input_set_drvdata() before device registration.
--

commit 647d8f6a84132a3fd0648807a009baeb1d458863
Author: Bryam Vargas <hexlabsecurity@proton.me>

Input: apple_z2 - bound the device-reported finger count

This commit adds bounds checking to apple_z2_parse_touches() to ensure the
reported finger count does not exceed the receive buffer. It drops packets
that claim more fingers than can fit, preventing an out-of-bounds read that
could leak adjacent kernel memory.

Closes: https://lore.kernel.org/all/20260613215358.329921F000E9@smtp.kernel=
.org/

> diff --git a/drivers/input/touchscreen/apple_z2.c b/drivers/input/touchsc=
reen/apple_z2.c
> index ff9ff97be185a..4e2a6967436e8 100644
> --- a/drivers/input/touchscreen/apple_z2.c
> +++ b/drivers/input/touchscreen/apple_z2.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but does concurrent execution of
apple_z2_read_packet() from the probe thread and threaded IRQ handler cause
buffer corruption?

In apple_z2_upload_firmware():

    z2->booted =3D true;
    apple_z2_read_packet(z2);

If the device asserts the IRQ line here, the unmasked IRQ handler
apple_z2_irq() wakes up, observes booted is true, and also calls
apple_z2_read_packet():

    else
            apple_z2_read_packet(z2);

Could this result in a data race where SPI DMA transfers corrupt the receive
buffer while apple_z2_parse_touches() is executing?

[Severity: High]
This is a pre-existing issue, but does apple_z2_upload_firmware() miss a
length check for fw->size before accessing the firmware header?

    fw_hdr =3D (const struct apple_z2_fw_hdr *)fw->data;
    if (le32_to_cpu(fw_hdr->magic) !=3D APPLE_Z2_FW_MAGIC ||
        le32_to_cpu(fw_hdr->version) !=3D 1) {

If the firmware file is truncated or empty, will this cause an out-of-bounds
read when the header fields are accessed?

[Severity: Medium]
This isn't a bug introduced by this patch, but I noticed the timeout error
path in apple_z2_boot() returns early without cleaning up:

    if (!wait_for_completion_timeout(&z2->boot_irq, msecs_to_jiffies(20)))
            return -ETIMEDOUT;

Does this leave the hardware out of reset and create an unbalanced IRQ enab=
le
state? The subsequent error path for apple_z2_upload_firmware() correctly
performs these cleanup steps by disabling the IRQ and asserting the reset
GPIO.

[Severity: Low]
This is a pre-existing issue, but the input device is registered in
apple_z2_probe() without prior initialization of driver data:

    error =3D input_register_device(z2->input_dev);

Is it intentional to omit input_set_drvdata() before registration here? The
subsystem guidelines state that all private driver data must be initialized
before registration to avoid visibility issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615-b4-disp-05=
943ee1-v3-0-bbfe1b651613@proton.me?part=3D2
