Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC9938C2DE
	for <linux-input@vger.kernel.org>; Fri, 29 May 2026 09:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780046014; cv=none; b=lMcBz6cgSPg5gMP+LXSyYHZO3MlQKP6oO1dWRks0qdw+5HxVjYVThiBmWYeGbbGfl8q/UsPSzGUH3BPAJS5lhf8nb+AOjrQGyUIY7ZBlNAufU/YSAriS8t9CQ448EA+1GHjF4LxjU0Jdj5/oGclHdh8Id05MZIm/NJlTXW2nBdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780046014; c=relaxed/simple;
	bh=QuinRr2rqXx8ebl//hINudaP/o5Vqx286nPRjwU6ras=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cDaDuaVaCp3rHiFKlSJJ82QPEjZIqwisJZlO7fUtWMMnNBQvRAfPseF7J+H3mSdHBniV8NkOzTO+kg7+sTltLQWF7kDQrJaAKsO5TC5LXcShFCUX+FNWTQxENTb/sF1/lOhL/L4SQIsbKsDu7Gl6WJGE0cWUpZbIKNMGFjArkjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAak2dsE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAak2dsE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FB61F00893;
	Fri, 29 May 2026 09:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780046013;
	bh=TYRELrrNxMSs33+UKChPGHnnVzZ7jZWIxM7LsKGoLxA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fAak2dsEOIc0JjdaFMSRPVYGMx6+yDT6j7UqonPnxmiQfDvWpFcW67He80yxHF2Hp
	 OmHgaNWFBXT/mdII1UL//NxKjF44nibqEoTYYNDp+wWwmNthJ5KGlNkeRZKZNHOsbU
	 K94WNTmX4VfZYI1TUFEYBbT9i9gU5kqax9ERrqFaSD+Fliee8pmcgOZN7ubGgUkxCS
	 uwZgq2UkIUJvPUkxVA54sbPFLqjpkkeao+bRBPLmdwkARWjLe3br/IbYVY/HgHA7u6
	 pXuaYD7ABlSpTBqyeIAbZhzarx6T9uuW82wCrrM4RRzHoRahgAVjPfCK/2OzWhqaF2
	 EQdr8rOfD8BRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 3/4] HID: hid-msi: Add RGB control interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260529072111.7565-4-derekjohn.clark@gmail.com>
References: <20260529072111.7565-4-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 09:13:32 +0000
Message-Id: <20260529091332.C7FB61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] A race condition in `claw_remove()` allows the `rgb_queue` delayed=
 work to be re-armed after it has been cancelled, leading to a Use-After-Fr=
ee of the `drvdata` structure.
- [Medium] A hardcoded LED class device name prevents supporting multiple c=
onnected devices.
--

commit 151b50cdc17e18af52c3d79eb6a71e3b5e4583d8
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add RGB control interface

Adds RGB control interface for MSI Claw devices using a unique frame-based
RGB protocol. Mirrors Windows effects using a delayed work queue to apply
state to the device.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c
[ ... ]
> @@ -954,6 +1572,7 @@ static int claw_probe(struct hid_device *hdev, u8 ep)
[ ... ]
>  	if (!drvdata->bmap_support)
>  		dev_dbg(&hdev->dev, "M-Key mapping is not supported. Update firmware t=
o enable.\n");
> =20
> +	drvdata->led_mc.led_cdev.name =3D "msi_claw:rgb:joystick_rings";

[Severity: Medium]
Does hardcoding the LED class device name prevent multiple MSI Claw devices
from being connected at the same time?

If two devices are connected, it seems the second one will fail to register
its LED class device due to a sysfs name collision. Would it be safer to
include a unique identifier like dev_name(&hdev->dev) in the string?

[ ... ]
> @@ -1030,6 +1662,7 @@ static void claw_remove(struct hid_device *hdev)
[ ... ]
>  	if (gp_registered)
>  		device_remove_group(&hdev->dev, &claw_gamepad_attr_group);
> =20
> +	cancel_delayed_work_sync(&drvdata->rgb_queue);
> +	if (rgb_registered) {
> +		device_remove_group(drvdata->led_mc.led_cdev.dev, &claw_rgb_attr_group=
);
> +		led_classdev_multicolor_unregister(&drvdata->led_mc);
> +	}
> +
>  	hid_hw_close(hdev);
>  }

[Severity: High]
Can a race condition here lead to a use-after-free of drvdata?

In sysfs store functions like effect_store(), rgb_registered is checked
under the registration_lock, but mod_delayed_work() is called after dropping
the lock.

If a sysfs thread is preempted right after dropping the lock, claw_remove()
could set rgb_registered to false, execute cancel_delayed_work_sync(), and
block on device_remove_group() waiting for the sysfs operation to finish.

Once the sysfs thread resumes, it would call mod_delayed_work(), effectively
re-arming the workqueue after it was supposed to be cancelled. When
claw_remove() completes, drvdata is freed, and the delayed work timer firing
later would result in a use-after-free.

Would moving cancel_delayed_work_sync() after the device_remove_group() and
led_classdev_multicolor_unregister() calls prevent this race?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529072111.7565=
-1-derekjohn.clark@gmail.com?part=3D3
