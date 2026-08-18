Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA6D47D45A
	for <linux-input@vger.kernel.org>; Tue, 18 Aug 2026 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069481; cv=none; b=QfXdkwKcXrzDK0r07Bt4yhdfCc6/zLlEjqc5cHH4Hvvxvfqjh2BLPrtzlz4UfUIAycMIJ9BKkpYCSj2Vgh2NeuoO5ocaUKvCabvyHyKneAfNCWG++r+iQK4ikoOjLYIPbbTzTyhjGxMAuQs0XCue53RAoM49MuHKzT3YpXT8+I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069481; c=relaxed/simple;
	bh=4oakhetJIu5Y+/CthFDluD7iEHiHXfZV695M286Ms58=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lIHQJ114oUsMy5iZCIMEL4dfNgCwZGb0Cz/7Az9SOtyP105qGF+ODqoINgEzAE5GGQHsj2dK1M3n5/f1JX4fNpUcMAQi5raJsdVVAF/js52UZZw/b/54PNalqi4AP4HaT6lSdrfF8wCXJx77KM15hA0YjNO74DyL7CSdtPvUttY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGpWfud8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGpWfud8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25A31F00A3A;
	Tue, 18 Aug 2026 16:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787069480;
	bh=4oakhetJIu5Y+/CthFDluD7iEHiHXfZV695M286Ms58=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kGpWfud8QLjMvU+1xc5E/v9ZaDzd0fx3vw9fB/V4uB9vgJnjABCEDY+YJWjTgwy8D
	 ItOH/4tefwyGrtGPVAk9oeXc+b8wzOD/VZgeqdOLPENVjjQ2jE7Zc1zgHsCFrkpnHu
	 Dvs+aiSbPwxB6J9fI1PLMg5FfsbkxMrqYi6pkCckYnZKYVIrIeK1NaH/Avv2uMxKFT
	 eoMEqS+8IjGeUpVzfcimPhnJEsjipk4utpWJVrk1YiWjbujml+6C/IFeDnoB5oqmpe
	 EaQGtOw+eQiUmzcVQwbc/LSejdCuNehtjkJZhgXl6wTzZeLRoLbAhmvB3Ox0wl0xMe
	 LlsrblGRJSFzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: adp5588-keys - cache GPIO state before
 registering the gpiochip
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWx2aW4gxaBpcHJhZ2E=?= <alvin.sipraga@analog.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260818-adp5588-gpio-cache-v1-1-650a2674fc0d@analog.com>
References: <20260818-adp5588-gpio-cache-v1-1-650a2674fc0d@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 16:11:19 +0000
Message-Id: <20260818161119.E25A31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing error handling for I2C reads causes out-of-bounds memory a=
ccesses and hardware state corruption.
--

--- Patch [1]: [PATCH] Input: adp5588-keys - cache GPIO state before regist=
ering the gpiochip ---
Note: The format of this review has been altered to a free-form summary
due to system recitation restrictions. No direct patch quoting is used.

commit d8a90d44c5e4df663ac4d3f942090902da1d6732
Author: Alvin =C5=A0ipraga <alvin.sipraga@analog.com>
Subject: Input: adp5588-keys - cache GPIO state before registering the gpio=
chip

This commit reorders the GPIO state caching to occur before the
gpiochip is registered. This prevents gpiochip operations from clobbering
pre-programmed GPIO states set by the bootloader.

[Severity: High]
This isn't a bug introduced by this patch, but this patch actively
exacerbates the consequences of a pre-existing issue with missing error
handling on I2C reads.=20

If adp5588_read() fails due to a bus fault, it returns a negative error
code (e.g., -EIO). In adp5588_gpio_add(), these negative values are
silently truncated to 8-bit unsigned values and stored in the driver's
cached GPIO state (dat_out, dir, pull_dis).=20

Because this patch moves this caching to occur before=20
devm_gpiochip_add_data(), when a GPIO hog is subsequently applied, the
driver inadvertently clobbers the real hardware state by writing back this
error-corrupted cache. Can this actively undermine the patch's stated goal
of preserving bootloader GPIO configurations if an I2C read fails during
probe?

Additionally, this same missing error check causes severe issues elsewhere.
In adp5588_report_events(), the error is bitwise-ANDed with KEY_EV_MASK,=20
resulting in an invalid, large key value. This yields a calculated code
index that exceeds the bounds of the kpad->keycode array, causing an
out-of-bounds heap read and leaking phantom key presses to userspace.=20

Finally, in adp5588_gpio_get_value(), a negative error code evaluates to
true, incorrectly reporting the pin state as HIGH.

Would it be appropriate to add proper error checking to adp5588_read() or
its callers to prevent state corruption and out-of-bounds memory access
during I2C faults?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-adp5588-gp=
io-cache-v1-1-650a2674fc0d@analog.com?part=3D1
