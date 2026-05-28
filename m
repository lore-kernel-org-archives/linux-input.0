Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D8664
	for <linux-input@vger.kernel.org>; Thu, 28 May 2026 00:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779926590; cv=none; b=QeAvjSWrPlC+cAObbub9L4iIFlFB7Ug/o2UTY10MtOlZeprSlPED82AXKOcZgxmBfrvid7cdojoWiNvHIvS1OPfcdPCI+FNJ4EMeItf+47YR+EO3NZ/G6i5ZW4zI/TnrVeMn5+Ffh7pkHgTLP4fyLdyi0j5ugRRZFi9l1N6EVcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779926590; c=relaxed/simple;
	bh=yFabSLkPYtyhZmgMv8on/t37OWEmmNUqJj1FocdY/Jw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=idpmzY7bD4w6/DOC9CKAWSAJmwFk+Hze8Ehat4BTG4iVQ6A0JrSj9QY+FCEodJj5O9eF5RBxHJzB6TtXMIFkGY6ynbdv1Tjlr2K+QOnKTnxNXsioIQ5goKe0/C9NJotL6peLX9oAGTR7UhthHeqBXl6YvyRLFwCFZyY6AD/I9U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLAWS6Cb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLAWS6Cb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E701F000E9;
	Thu, 28 May 2026 00:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779926588;
	bh=qj+CCBc2JmKONX82w7CO/YiBPJ2xAz8o5Kyvae9Xmd4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jLAWS6Cbmy4agvnCdT7wiOREy/YzIOvo1PNwYwELmH30hzhpPIa1Z4BxB+fbDWxCu
	 bvu22Gj0qn8EWfHZpTLpQZFD8KL7gOIwWp5iYDTmFvMdnXwYHWXrxau9WC/BVShbPo
	 I/qsn6y3aYmbbi6Aq3S3hC1LDr/wq1rgZ7qHW1BLksLRdCzOO1aoAcw7F1Dy3iSHwv
	 JvLiWAc0GWlFT/Ozw8j3UU0l7XJxrOS/jlKtGND6+0GMwQpk84ofDfg7Gvibhda2k4
	 qzZatPgotlgVXb0EV9SqQntePq/iWq29Naq2uZl+/7PHdmwTtC5+ySzAuVgxRYRaEu
	 10ps4BXhgE56A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/4] HID: hid-msi: Add RGB control interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260527222122.10620-4-derekjohn.clark@gmail.com>
References: <20260527222122.10620-4-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 00:03:07 +0000
Message-Id: <20260528000308.70E701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Race condition during device teardown allows the `rgb_queue` delay=
ed work to be queued after cancellation, leading to a Use-After-Free.
- [High] Early return in `claw_profile_event()` skips state machine reset, =
leaving the device stuck in `CLAW_RGB_PENDING` state.
- [Medium] Incorrect suspend handling for the LED class device leads to dro=
pped 'off' events and potential re-queuing of work during suspend.
- [Low] RGB configuration state variables are read and modified without syn=
chronization, leading to data races.
--

commit 4395753635f4bb8533afa93923c64af621829712
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add RGB control interface

This patch adds an RGB control interface for MSI Claw devices. It configures
a 9-zone multicolor LED device with up to 8 animation frames and exposes sy=
sfs
attributes to control the effects, speed, and enabled state.

diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
--- a/drivers/hid/hid-msi.c
+++ b/drivers/hid/hid-msi.c
[ ... ]
@@ -342,6 +403,34 @@ static int claw_profile_event(struct claw_drvdata *drv=
data, struct claw_command_
[ ... ]
> +	case CLAW_RGB_PENDING:
> +		frame =3D (struct claw_rgb_report *)cmd_rep->data;
> +		rgb_addr =3D drvdata->rgb_addr;
> +		read_addr =3D be16_to_cpu(frame->read_addr);
> +		frame_calc =3D (read_addr - rgb_addr) / CLAW_RGB_FRAME_OFFSET;
> +		if (frame_calc >=3D CLAW_RGB_MAX_FRAMES) {
> +			dev_err(&drvdata->hdev->dev, "Got unsupported frame index: %x\n",
> +				frame_calc);
> +			return -EINVAL;

[Severity: High]
Does this early return skip resetting the state machine?

By returning directly here, we bypass the drvdata->profile_pending assignme=
nt
at the bottom of the function. This appears to leave the device permanently
locked in the CLAW_RGB_PENDING state.

> +		}
[ ... ]
@@ -882,32 +971,553 @@ static const struct attribute_group claw_gamepad_att=
r_group =3D {
[ ... ]
> +static ssize_t effect_store(struct device *dev,
> +			    struct device_attribute *attr,
> +			    const char *buf, size_t count)
> +{
[ ... ]
> +	ret =3D sysfs_match_string(claw_rgb_effect_text, buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	drvdata->rgb_effect =3D ret;
> +	mod_delayed_work(system_wq, &drvdata->rgb_queue, msecs_to_jiffies(50));
> +
> +	return count;
> +}

[Severity: Low]
Can this modification of drvdata->rgb_effect race with reads from
claw_apply_rgb_state()?

It looks like rgb_effect, rgb_enabled, and rgb_speed are being read and
written without synchronization, which could lead to an inconsistent
configuration state if multiple sysfs operations happen concurrently.

[ ... ]
@@ -1030,6 +1662,7 @@ static void claw_remove(struct hid_device *hdev)
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
Could this ordering cause a use-after-free during device teardown?

If a sysfs operation like effect_store() is preempted, it could complete
after cancel_delayed_work_sync() finishes. Because device_remove_group() and
led_classdev_multicolor_unregister() haven't removed the interfaces yet,
the sysfs handler can still successfully call mod_delayed_work(), which will
re-queue the work to run after drvdata has been freed.

[ ... ]
@@ -1106,6 +1749,7 @@ static int claw_suspend(struct hid_device *hdev)
> =20
>  	cancel_delayed_work_sync(&drvdata->cfg_resume);
>  	cancel_delayed_work_sync(&drvdata->cfg_setup);
> +	cancel_delayed_work_sync(&drvdata->rgb_queue);
> =20
>  	return 0;
>  }

[Severity: Medium]
Is this cancellation sufficient to safely suspend the LED device?

Without setting LED_CORE_SUSPENDRESUME in the LED class device flags during
probe, the LED subsystem might not know to properly coordinate the suspend.
This could potentially lead to dropped 'off' events or concurrent timers
re-queuing this work after it has been cancelled here.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527222122.1062=
0-1-derekjohn.clark@gmail.com?part=3D3
