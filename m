Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E943144C66F
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 12:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784117124; cv=none; b=r6wqhpRF/N9cnJFg+gHN0Ejk51EMVIzDoeBercqoMO2hOXhOwpxYFcDVou45iIDiBLicO/0iFneIeQXDeXWvRG3/1+P4yQ+2gXrgPhNPCCoYy1lDIZ++aEW5HGD41+CHJQPgR6QePObIYKbuAU8ci4NcuzXL6WgVMieWf6US960=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784117124; c=relaxed/simple;
	bh=IU1LA7X8kT1eXvqT7aFYouD5yBFDHSjbPFSuFV/jPEc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Usr/Cs7fd/f4a76BIx5lsLqBluAbgsXHBDbPoq//MzWfOmizIg3zFoRAepAUAgzdPqddXGB7lUywXrOOx0vS3xEJ9w85rpfMTSKct2yy7cLKwwby2ssGb5hDI2diKQqYfVxjXruyQg2KEoBDNzeDwi4dOjOc/22w3gygUwmyYbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeqKldGj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeqKldGj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93201F000E9;
	Wed, 15 Jul 2026 12:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784117121;
	bh=UMg41L+s/SZZpkloMupM3PWUPQOrx+pb7AbJ0eKzMAk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZeqKldGjGKweV0VWG21roo947DWXn/Mc8jchiXL+/X5zTbMQWQQk4XD8Y0Va1gGJa
	 1/mKSeBRRpvYKHkF4d5WmuOgJHUHrHd0xjfv4XEVyWCwWSz7noIKZy/sNWPwnh/Rag
	 gQEICrTIrQVmdlPj0ANEYCpjwoW/sNlkW7xBroubV9ImSaty+m/wxHmrilo0gJ187N
	 Q8m2QD/i3hYEFSPOGNg6tUrQCN8NFRTk/A/fdfjkPW8NyiUpWgzfnZZ0LWCUeBcE61
	 9LZY4jnmmubY7VEisUPlg9harncWoaTQCp9dAS4ONdm+4oykIhpfZeIenpTAunv+5l
	 7RilWXczKq0Bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: picolcd: clamp eeprom debugfs read to bytes
 actually received
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ibrahim Hashimov" <security@auditcode.ai>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260715115301.91063-1-security@auditcode.ai>
References: <20260715115301.91063-1-security@auditcode.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 12:05:20 +0000
Message-Id: <20260715120520.B93201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free on `data->rc_dev` and `data->input_keys` due to rac=
e in probe error path.
--

--- Patch [1]: [PATCH] HID: picolcd: clamp eeprom debugfs read to bytes act=
ually received ---
commit 16232239549016339287f47b37b440446a47d534
Author: Ibrahim Hashimov <security@auditcode.ai>

HID: picolcd: clamp eeprom debugfs read to bytes actually received

This commit fixes an out-of-bounds slab read in picolcd_debug_eeprom_read()
by correctly clamping the copy length to the received payload size.

Cc: stable@vger.kernel.org

> diff --git a/drivers/hid/hid-picolcd_debugfs.c b/drivers/hid/hid-picolcd_=
debugfs.c
> index 085847a92e07d..1f7dfe60e9ba2 100644
> --- a/drivers/hid/hid-picolcd_debugfs.c
> +++ b/drivers/hid/hid-picolcd_debugfs.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but I noticed a potential use-after-free in t=
he
probe error path.

If a USB device continuously sends interrupt IN packets to trigger
picolcd_raw_event() while intentionally failing device initialization, could
this cause a race condition?

In drivers/hid/hid-picolcd_core.c:picolcd_probe_lcd(), the probe error
handler destroys the cir and keys objects while the HID device is still ope=
n:

err:
	picolcd_exit_leds(data);
	picolcd_exit_framebuffer(data);
	picolcd_exit_backlight(data);
	picolcd_exit_lcd(data);
	picolcd_exit_cir(data);
	picolcd_exit_keys(data);
	return error;

Because hid_hw_close() isn't called until later, picolcd_raw_event() can
concurrently dereference the freed data->rc_dev pointer outside of the
spinlock in drivers/hid/hid-picolcd_cir.c:picolcd_raw_cir():

	spin_lock_irqsave(&data->lock, flags);
	if (!data->rc_dev || (data->status & PICOLCD_CIR_SHUN)) {
		spin_unlock_irqrestore(&data->lock, flags);
		return 1;
	}
	spin_unlock_irqrestore(&data->lock, flags);

	// ... [IR data processing] ...

	ir_raw_event_store(data->rc_dev, &rawir);

The same timing issue appears to apply to data->input_keys, which is access=
ed
locklessly in drivers/hid/hid-picolcd_core.c:picolcd_raw_keypad():

		input_event(data->input_keys, EV_MSC, MSC_SCAN, raw_data[i]);
		if (raw_data[i] < PICOLCD_KEYS)
			key_code =3D data->keycode[raw_data[i]];

Could this allow concurrent events to use these pointers after they are fre=
ed
by picolcd_exit_cir() and picolcd_exit_keys()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715115301.9106=
3-1-security@auditcode.ai?part=3D1
