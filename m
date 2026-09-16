Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7550B377EAC
	for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789570814; cv=none; b=e+1+jla3QnI61I5i07sFzamDH9a6x8BDFgb1CGvje33ee0ZTgRsvPUv484NfWiF51C7qQ3K7t/DyvNDFtQUzj4nc4nxapoSvToCL9KXqUwwpkNoQh+Xda+EKotzmOQEA8wCdv6ZeeJmBNRKJq50f9mn8AzbqaksSA1ERt24YNAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789570814; c=relaxed/simple;
	bh=5KWDx9KYbC9/66DLpkUWKLxU9ZHHf0mx4mEd0OUhrgo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XL4q66zy0Tl+Wkqss2xrvP54d45vZtPyJbAqHr3qv8zSpG50LQPUlEwXpP6SIhdRZzY1dvlPmAHYE54p3Gs1n+rGks/m2zCp/AmuSjftULxLx1NRlRofw6Pc69MZAmzkAypfnMVtjgMB1rXW7Nyj9pmS/TBxsj4E9PrnJmBFfx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4LDG4Yl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4LDG4Yl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1EA1F00893;
	Wed, 16 Sep 2026 15:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789570813;
	bh=nA/1kPQk850gD0boPxzvVBYWFATB9YwHZFqtS8hy0oQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F4LDG4YlPD+CeWFUCfQUGR0WzCpRBHXc1USQ627kwxYZlAS759hz+UrkDzh52pHvY
	 nPfduLmS5ybqU8sRovxpQ3Hx1w1x1UlHrjDp7yfuuBgcOkkK29Q2+wRhFzWm8c7XZg
	 YvSK23GrOq7MKViMjRPMYFKqRLIhBuvM2hUAmaEgR2Rd5tHi5+6dHwA5te5U5EA8wy
	 VVVVaorDVnNg4WV/bchZV00omATXaRmYnO+r06PMe/XgjU0JYEt7dQ8kUBPvDnV3Z7
	 LVnsEIS3rHV7j2XaevzRhp5XK0R9pLtbDB81ahcJtHRUr8gKGHT8ius/gc076l5MrF
	 tU/zymxn4TLuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/3] HID: lamparray: blank lamps across suspend and
 restore on resume
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Erhardt" <aer@tuxedocomputers.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260916144838.456239-4-aer@tuxedocomputers.com>
References: <20260916144838.456239-1-aer@tuxedocomputers.com>
 <20260916144838.456239-4-aer@tuxedocomputers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 15:00:12 +0000
Message-Id: <20260916150012.EE1EA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] hid: lamparray: blink timer overwrites blanked state during susp=
end
--

commit 0480546fa780aefd04da86e31cbb23c2cb7e6a3d
Author: Cristian Mazzotta <cmmazzo@icloud.com>

HID: lamparray: blank lamps across suspend and restore on resume

This commit adds power management callbacks to blank lamparray devices
during system suspend by writing zeroes to the color channels. It also
introduces a resume function to explicitly transition the device out of
autonomous mode and restore its cached color state.

> diff --git a/drivers/hid/hid-lamparray.c b/drivers/hid/hid-lamparray.c
> index acc00950495bf..c7d4d3d1b02d3 100644
> --- a/drivers/hid/hid-lamparray.c
> +++ b/drivers/hid/hid-lamparray.c

[ ... ]

> +void lamparray_suspend(struct lamparray *la)
> +{
> +	struct lamparray_device *ldev;
> +
> +	if (!la)
> +		return;
> +
> +	ldev =3D &la->ldev;
> +
> +	if (!ldev->use_leds_uapi)
> +		return;
> +
> +	mutex_lock(&ldev->dev_lock);
> +	lamparray_hw_set_state(ldev, 0, 0, 0, 0);
> +	mutex_unlock(&ldev->dev_lock);

[Severity: Medium]
Will active LED software blink timers continue to fire during system
suspend and overwrite this blanked state?

If a userspace application or trigger enables software blinking on the
lamparray LED classdev before system suspend (e.g. s2idle), the timer
can continue to queue work to leds_wq. This will call
lamparray_hw_set_state() and overwrite the blanked (0,0,0,0) state set
here, causing high power draw and undermining the intent of this function.

Does the lamparray LED classdev initialization need to set the
LED_CORE_SUSPENDRESUME flag so the LED subsystem correctly applies
LED_SUSPENDED and prevents timers from queuing new brightness updates
during suspend?

> +
> +	hid_hw_wait(ldev->hdev);
> +}
> +EXPORT_SYMBOL_GPL(lamparray_suspend);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916144838.4562=
39-1-aer@tuxedocomputers.com?part=3D3
