Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9873130C17E
	for <linux-input@vger.kernel.org>; Mon, 25 May 2026 03:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779680490; cv=none; b=FJwZMc1kYZnmIeNMEB6zAHPXbHv8GxYc+PhuZXIykoC+ULNXryapNeJeKdk24XrX0LiY7iN24/MH7qRuS7YAuWz56lCAl7T+iz8X9ebd7JSlIr0HbhIKtXZb+qu/aSt7D57vXLCS7uG3wgLn3w94D/7wsG+IIZQBChorTzeHTT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779680490; c=relaxed/simple;
	bh=v5Q4352vFgH8XSeeWCWLNK6BOVG5ajcWp1bhsgKALZU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qLO7lu50tCYBOlXSqGtGrWdiNIQjVQDfRFbzaZGRMs4/xLM5sZt0nzDiiTfCq/Cfu53htGivVJJQMokKcQvvX9ytj+cNItaUfRG/bbHoSiJ4y7e3OdKSMpXckrkJY6ScxfFiuTV64rT4SfJIiSkrWFUzU5VAuMFwjgkIRGZb27k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5vCMH9r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5vCMH9r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0181F000E9;
	Mon, 25 May 2026 03:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779680486;
	bh=k8V2EaQFC39gNvHBQ2DueIxRcz3yc8ykELNzztEZkdQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V5vCMH9r39p9FaqorVoLZGpdV5h4KiftQX8uvYEDus1bWNAUEgoan9+Nd5a/ehTUR
	 G1GeB1xElJFfi2fU+uFsLHSWrjXNTp3bVZpHrbH1YpbUOC7s2GdaRvxqvFGf0SnHoX
	 LzWBf/07PMzI/HNLmvryr47HsVOWa9nONOFzZlm0LScVpQ2G9AE7Rtzkkoc0bUCKVb
	 LRBHP4OAhTAQvuFAzOe5NXtl6N6bC9SsegFIWqcrBWNkS0uJUiy1vN8jDfeHcuS7Ig
	 9RHue20xK4XUCJRjCSy7G30yqBhsvs87/BdouFDSCmkUE+2bHHImQw8r3ydyqRfa3U
	 qExt62lw7LCmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/4] HID: hid-msi: Add RGB control interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260525020543.519082-4-derekjohn.clark@gmail.com>
References: <20260525020543.519082-4-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 03:41:25 +0000
Message-Id: <20260525034126.6A0181F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Tearing down the `rgb_queue` delayed work before unregistering the=
 sysfs attributes in `claw_remove()` allows the work to be re-armed, leadin=
g to a Use-After-Free.
--

commit e775f842567caa50d4c5a9bd87b14e6d6c8ffff6
Author: Derek J. Clark <derekjohn.clark@gmail.com>
Subject: HID: hid-msi: Add RGB control interface

This commit adds an RGB control interface for MSI Claw devices. It supports
configuring up to 8 sequential frames of RGB zone data across 9 zones,
mirroring effects available in the official Windows driver.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index 5f20102eae69d..96710d80543d4 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c

[ ... ]

> @@ -1043,11 +1675,21 @@ static void claw_remove(struct hid_device *hdev)
>  		gp_registered =3D smp_load_acquire(&drvdata->gp_registered);
>  		/* Pairs with smp_load_acquire in attribute show/store functions */
>  		smp_store_release(&drvdata->gp_registered, false);
> +		/* Pairs with smp_store_release from cfg_setup_fn in system_wq context=
 */
> +		rgb_registered =3D smp_load_acquire(&drvdata->rgb_registered);
> +		/* Pairs with smp_load_acquire in attribute show/store functions */
> +		smp_store_release(&drvdata->rgb_registered, false);
>  	}
> =20
>  	if (gp_registered)
>  		device_remove_group(&hdev->dev, &claw_gamepad_attr_group);
> =20
> +	cancel_delayed_work_sync(&drvdata->rgb_queue);

[Severity: High]
Could this lead to a use-after-free if the rgb_queue delayed work is re-arm=
ed
while claw_remove() is running?

If a sysfs writer (like effect_store()) reads rgb_registered as true under
registration_lock and gets preempted, claw_remove() can clear rgb_registere=
d,
call cancel_delayed_work_sync(), and then block in device_remove_group()
waiting for the sysfs writer to drop its active kernfs reference.

The sysfs writer could then resume, call mod_delayed_work() to re-arm the
workqueue, and finish:

sysfs writer
    scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
        if (!smp_load_acquire(&drvdata->rgb_registered))
            return -ENODEV;
    }
    // Preempted here

claw_remove()
    smp_store_release(&drvdata->rgb_registered, false);
    cancel_delayed_work_sync(&drvdata->rgb_queue);
    device_remove_group(drvdata->led_mc.led_cdev.dev, &claw_rgb_attr_group);
    // Blocks waiting for sysfs writer

sysfs writer (resumes)
    mod_delayed_work(system_wq, &drvdata->rgb_queue, msecs_to_jiffies(50));
    // Completes

claw_remove()
    // Unblocks and completes

After claw_remove() finishes, drvdata is freed by devres. When the re-armed
delayed work executes 50ms later, it would dereference the freed drvdata,
causing a use-after-free crash.

Should cancel_delayed_work_sync() be called after the sysfs attributes and =
LED
class device are fully unregistered?

> +	if (rgb_registered) {
> +		device_remove_group(drvdata->led_mc.led_cdev.dev, &claw_rgb_attr_group=
);
> +		led_classdev_multicolor_unregister(&drvdata->led_mc);
> +	}
> +
>  	hid_hw_close(hdev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525020543.5190=
82-1-derekjohn.clark@gmail.com?part=3D3
