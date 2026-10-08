Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792F931F99A
	for <linux-input@vger.kernel.org>; Thu,  8 Oct 2026 07:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791444280; cv=none; b=ie89oVeP0iVPVjt9y5RqkeFh78tJOOsRH0uyNakbSyri+YS4ejZDkzmwbPvQO5VFejEPJNp9vCkoleDpMU5yiDPpyU77csEafabDyEMTeqZ99ChZdkNVK1YKPwhAPpB7qDYE7RfEYl3EJZJVNja9AdZrZyQgNQH7B4M/OOAQQ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791444280; c=relaxed/simple;
	bh=BUpN7OnIra7nTefQxJsO0PbRLWYuHUgttc7NsFd99lU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=NrB6dd8GjnT1wBl5naGNULQuJCdBTcBmbmIHQWxt+evOVf+8qYMtz3E9PUcqRWnGwgme2N+F2DTI9LVDzV+ZR+bL2rCM7TQYP6aOYv4s7hxFYN4XGCcBL772FHAVkEQy6jFqKC2mETupJXyJjNM3xIOjQBkDcNbNHyA3OiPGEtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfstfDGx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfstfDGx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B721F000FF;
	Thu,  8 Oct 2026 07:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791444275;
	bh=nuZLJiE9KY+oukAq/Gl2WfntaIEPj7qWu5tz5wz10Ok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jfstfDGxtCQfUNUpg6qxjuzV8WXIWEcxQhptVhRh1YhHmmGMAdMF4dOyQwvZ3hGlW
	 yFtn7AFehIr0Y5XFfpbfj/a8LlkOltI2nDXl30sAHxi+u0BB3wy4+0V38KxPmRdW+v
	 P9+RUiWBMRXG7A/eth4LPEdmr3aTwqyf/9M6g5lxeDUDS0CzuP/jtdlpCL5TRNtuE/
	 ddEfkoNqnv3bXhJOHyEJNVSME5iAez82wUTB5aFCMBcU7L4WW8NwapdpYOFpkAVR7i
	 AkgcK9YmwD8NITxSziv6zwsFrksREg05PX1iU/bZrSQXrZKgm8vMfjgUiOdeloCZCO
	 XCpkGBRYQXdAg==
Message-ID: <sashiko-outbox-163750@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: i2c-hid-acpi: restore touchscreen IRQ routing
 on HP OmniBook Flip laptops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Waqar Gulzar" <iamwaqargulzar@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20261008-b4-elan2514-irq-route-v2-1-432d95eb7348@gmail.com>
References: <20261008-b4-elan2514-irq-route-v2-1-432d95eb7348@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 07:24:34 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hid: i2c-hid-acpi: ACPI IRQ routing workaround bypassed on resume =
if wakeup enabled
--

commit 395f14993542089fc82210b5b3e47d5cf6164163
Author: Waqar Gulzar <iamwaqargulzar@gmail.com>

HID: i2c-hid-acpi: restore touchscreen IRQ routing on HP OmniBook Flip lapt=
ops

This patch works around a firmware bug on several HP OmniBook Flip laptops
where the touchscreen ACPI _ON method incorrectly disconnects the interrupt
from the IO-APIC. It attempts to re-enable the correct IRQ routing during
device initialization and resume using the i2c_hid_acpi driver's power_up
hook.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D220854
Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2142384
Link: https://github.com/testyfishy/hp-omnibook-flip16-touchscreen-fix
Link: https://github.com/iamwaqargulzar/hp-omnibook-x-flip-16-linux-touchsc=
reen-pen-fix

> diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c=
-hid-acpi.c
> index 9371db200fc4d..b307d9a3d0455 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-acpi.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-acpi.c

[ ... ]

> @@ -147,6 +147,9 @@ static int i2c_hid_acpi_probe(struct i2c_client *clie=
nt)
>  	ihid_acpi->adev =3D adev;
>  	ihid_acpi->ops.shutdown_tail =3D i2c_hid_acpi_shutdown_tail;
>  	ihid_acpi->ops.restore_sequence =3D i2c_hid_acpi_restore_sequence;
> +	if (acpi_dev_hid_uid_match(ihid_acpi->adev, "ELAN2514", NULL) &&
> +	    dmi_check_system(i2c_hid_acpi_irq_route_dmi))
> +		ihid_acpi->ops.power_up =3D i2c_hid_acpi_restore_irq_route;

[Severity: High]
Does this workaround get bypassed on system resume if the device is
configured as a wakeup source?

Looking at i2c_hid_core_resume() in drivers/hid/i2c-hid/i2c-hid-core.c,
the power_up hook is skipped if the device may wake the system:

drivers/hid/i2c-hid/i2c-hid-core.c:i2c_hid_core_resume() {
    ...
	if (!device_may_wakeup(&client->dev))
		i2c_hid_core_power_up(ihid);
    ...
}

If the user or system configures the touchscreen to wake the system from
sleep, the ACPI _ON method will run during the transition back to D0 and
disconnect the IRQ routing, but the power_up hook won't be called to
restore it.

Could this cause the interrupt storm to return immediately upon enabling
the IRQ on system resume?

> =20
>  	acpi_device_fix_up_power(adev);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-b4-elan251=
4-irq-route-v2-1-432d95eb7348@gmail.com?part=3D1
