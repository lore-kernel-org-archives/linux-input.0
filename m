Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639C53D75BE
	for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 06:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790750104; cv=none; b=DBEVNjj/D0r4f3SeNaDU1M6XVMX+M6ivDbfLArwMMAbCgLYiPyt3lW/bTw0odVAevQNZQZkdxh43adfj2ybupxX8m9Ls1dXNhH8pojucd3y2Q6dPRAe00jy8dGHja5J4lB+NfmRepqHDY6PA5U3Dxa9d+VmhgPbGbgH5BjISQdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790750104; c=relaxed/simple;
	bh=aXOoCLEeEuC4t5LHj3S9xqJc/snybCxhQ60UQne2Zl4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EB/NWu2g5rS+DZWDKCjEjRu8kEOaz7DFIfJhcIMX2rzW0kZSTdWWJ0l/Psier54OfMQQ3rGUX+hs5BmF67URY4yF7ZfZJe7WwiwLUY4uLymTzJ9cF/A1/jojtJXftvIXjXXfZNR/U8/Uo6PXZ97HwGe/8Srhz8zBwR5WGefGIks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZ3pbi9S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZ3pbi9S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2B31F00899;
	Wed, 30 Sep 2026 06:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790750100;
	bh=G0iX33ZXw33QjlYcC6UVSu59Ru6uNwW6BatgDXfqDqE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OZ3pbi9SEsK+OYUGSrEvTPlrF+xKEpXcPvYwN077Of3qzZjtgWwyOSXYhG0+U3j5G
	 22i/6d6cBCHXhpF/yUlceZrld2+5RqdsmbDy2pXnSxWsib5C4u9eF6cwWQlpf7aFKQ
	 6m0ygnVpVZG+pVXdaiaYLkUqnkW4Xrbe5MvHB1j9nFRHSNLEnT80ynbesIdSlpeCqC
	 iCUQZApo3v2+k3V7RUeEigiU2nBceKfcvFThQ/oO1Mr5QV/bRzuo6tscVi5utanH01
	 oWhiisB7bME3sn2+n0xmIx5g5Bn9ZoSyyKs3VSWq/oAb66gsXhGBWFN5mijIgFCNH6
	 +BFdgaCaNtApw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: i2c-hid-acpi: restore touchscreen IRQ routing on
 HP OmniBook X Flip 16
Reply-To: sashiko-reviews@lists.linux.dev
To: "Waqar Gulzar" <iamwaqargulzar@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260930-b4-elan2514-irq-route-v1-1-44671bf01d05@gmail.com>
References: <20260930-b4-elan2514-irq-route-v1-1-44671bf01d05@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 06:35:00 +0000
Message-Id: <20260930063500.7D2B31F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] hid: i2c-hid-acpi: IRQ routing quirk bypassed on resume if wakeu=
p enabled
--

commit c1ea0adbfc4956d2ccd0cfccdc56448c010e7ac2
Author: Waqar Gulzar <iamwaqargulzar@gmail.com>

HID: i2c-hid-acpi: restore touchscreen IRQ routing on HP OmniBook X Flip 16

The HP OmniBook X Flip 16 firmware disconnects the ELAN2514 touchscreen
interrupt from the IO-APIC in its power resource _ON method, which Linux
runs at probe and resume. This patch re-enables the routing through the
firmware's own helper from i2c-hid-acpi's power_up hook.

Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2142384
Link: https://github.com/testyfishy/hp-omnibook-flip16-touchscreen-fix
Link: https://github.com/iamwaqargulzar/hp-omnibook-x-flip-16-linux-touchsc=
reen-pen-fix

> diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c=
-hid-acpi.c
> index 9371db200fc4d..b6348ee3d422b 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-acpi.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-acpi.c

[ ... ]

> @@ -85,6 +140,9 @@ static int i2c_hid_acpi_probe(struct i2c_client *clien=
t)
>  	ihid_acpi->adev =3D adev;
>  	ihid_acpi->ops.shutdown_tail =3D i2c_hid_acpi_shutdown_tail;
>  	ihid_acpi->ops.restore_sequence =3D i2c_hid_acpi_restore_sequence;
> +	if (acpi_dev_hid_uid_match(ihid_acpi->adev, "ELAN2514", NULL) &&
> +	    dmi_check_system(i2c_hid_acpi_irq_route_dmi))
> +		ihid_acpi->ops.power_up =3D i2c_hid_acpi_restore_irq_route;

[Severity: Medium]
Will this quirk be reliably applied on resume if the device has wakeup enab=
led?

The quirk is hooked up to the power_up callback. However, in
i2c_hid_core_resume() the core driver conditionally skips the power_up
callback if wakeup is enabled:

drivers/hid/i2c-hid/i2c-hid-core.c:i2c_hid_core_resume() {
    ...
	if (!device_may_wakeup(&client->dev))
		i2c_hid_core_power_up(ihid);
    ...
}

If the user or system enables wakeup for the touchscreen,
i2c_hid_core_resume() skips i2c_hid_core_power_up(). If the device's ACPI
power resource was turned off during sleep, _ON will execute on resume and
break the IRQ routing again, but the power_up quirk will not run to fix it.

Does the quirk need to run unconditionally on resume instead of being tied
to the core's power management logic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-b4-elan251=
4-irq-route-v1-1-44671bf01d05@gmail.com?part=3D1
