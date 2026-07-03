Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74126257ACF
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2026 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783093337; cv=none; b=CgpRYAKRo1biAgH+PNgYTHks2EsbbbsrGTNyvx6Shp/SlBpsW+7TOPmfA8fnbXM66ANAKY5GKvoVxcFgNdqai4/10ljV8SXKi0f/SPY3dGdxwDBbDJ6Vb4H57O+tqi8sK/7Y4qeZscLWzGhRuyFwHoYjDhWOlKcA/DpSGmJRcV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783093337; c=relaxed/simple;
	bh=pQdWX9A+0DDGFoMAlpQy+r3Q9Kyadx/RZCKEz7TdW4g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eZY8wct22tAFUxQv/luitnTC5Unslhooyf/qXN3pwPBCILALXxyOHvq6cYih9BYW0T34MHpor1c49Wtvb4a5ddkJgh5/rAeXFwoahubSJVVkmU7q0aT5qOx4BB/nleJt1OVl+uOWcrhIpBClgmsueY8/+bTBcqkyzY+SQmHkg1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KF6ocYxn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KF6ocYxn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981AF1F000E9;
	Fri,  3 Jul 2026 15:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783093335;
	bh=sGzuvK0pEbz10dkO61QS6fuji3FnM7sn7SgxLaaMWRw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KF6ocYxn7wj28X447oW+1Xdva2b2x3fVmLaLCfj7J7Z8OVEpghrsDEDTm/0kqGmQH
	 GD8wgDT1zZEDrY3E0iPPSySD960iF0lX2uN8xCTp43bFGmsqC+dbbcZ3/AmqdKW31O
	 BliSFBRlyWI1sRv7RIbUOji4k5Ek4xo8Ic3dmhfJMIUkjIXZlYEUMYepCfwT8uyfbl
	 wXoN9KC8Q58IXiWS00g6qQHfFz1gkg3U5q5Yf75lVq1M+gLRukQUQG+4zzkDfkJ78D
	 8gVkdnZwy9cqIUfr4r0VDsG/aJTLjd9/0UPq6U6OSLvAUKxzAEGcLklI7z9fhjtmAp
	 7yPv3c9qLoC3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: asus: fix UAF of ->kbd_backlight on
 !CONFIG_ASUS_WMI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jann Horn" <jannh@google.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260703-hid-asus-uaf-v1-1-1a2af2534eb0@google.com>
References: <20260703-hid-asus-uaf-v1-1-1a2af2534eb0@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 15:42:15 +0000
Message-Id: <20260703154215.981AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition in asus_remove() due to incorrect teardown order fo=
r fn_lock_sync_work, leading to Use-After-Free.
--

commit 10088228c9fb50f752e52778b8014fc75f17200d
Author: Jann Horn <jannh@google.com>

HID: asus: fix UAF of ->kbd_backlight on !CONFIG_ASUS_WMI

This commit fixes a Use-After-Free bug where drvdata->kbd_backlight was not
set to NULL after being freed in asus_kbd_register_leds(). By explicitly
clearing the pointer when asus_hid_register_listener() fails, it prevents
asus_remove() from following a freed pointer during teardown.

Cc: stable@vger.kernel.org

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 3f5e96900b67a..c2a5edebbd7a7 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -777,6 +777,7 @@ static int asus_kbd_register_leds(struct hid_device *=
hdev)
>  	if (ret < 0) {
>  		/* No need to have this still around */
>  		devm_kfree(&hdev->dev, drvdata->kbd_backlight);
> +		drvdata->kbd_backlight =3D NULL;
>  	}
> =20
>  	return ret;

[Severity: High]
This is a pre-existing issue, but I noticed a potential race condition in
asus_remove() that might lead to a Use-After-Free.

When a device is removed, asus_remove() calls cancel_work_sync() for
fn_lock_sync_work before stopping the hardware:

drivers/hid/hid-asus.c:asus_remove() {
    ...
	if (drvdata->quirks & QUIRK_HID_FN_LOCK)
		cancel_work_sync(&drvdata->fn_lock_sync_work);

	hid_hw_stop(hdev);
}

If a KEY_FN_ESC event arrives in the window between these two calls, won't
the HID core invoke asus_event() and blindly requeue the work?

drivers/hid/hid-asus.c:asus_event() {
    ...
		case KEY_FN_ESC:
			if (drvdata->quirks & QUIRK_HID_FN_LOCK) {
				drvdata->fn_lock =3D !drvdata->fn_lock;
				schedule_work(&drvdata->fn_lock_sync_work);
			}
			break;
    ...
}

Since the driver data is freed after device removal, could this executed
work access freed memory if the teardown order isn't reversed so that
hid_hw_stop() runs before cancel_work_sync()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-hid-asus-u=
af-v1-1-1a2af2534eb0@google.com?part=3D1
