Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F57324B20
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 03:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787889037; cv=none; b=KkLptT0B/BqcjqV5hWDvvbDX3cdrgdY1U2vQCcGgpxXubIrHVokt6h/A1OisiR9CzXNPBWSd9glusQ7jOogbjcoYJwiWTg92KA8IdHRB9gzkRYEyxEaokVJLLpK0eatD3oFHeqn9Pzc2re5FyC1Ir0bbGU0BCZNKna8wMo2Ns+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787889037; c=relaxed/simple;
	bh=GReZa9AEjFBMoUjatC+m9jnuoxILWgWHQaqgPsBl/Hg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YIORFyR5I0YR+V9ykpwQOl+NZQdFeCIA7qKkD6o8MAdnbdSL/mfTcOSGQug4/puIzGtFLwa+BYfcQN6FNTVSDzk7AonY68V+2UeHHCdylrEdCGLYz+JVcPUGy7OQZKZX+wbra0Hm4J/sPq0DOHt8u9Y64yzOyATqXt2Yr+y4jEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHCyRRMY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHCyRRMY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78121F000E9;
	Fri, 28 Aug 2026 03:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787889036;
	bh=hdk7XRgg11bvb4AJLkfhLDoqkGakp1fOgnB2w18YwrU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VHCyRRMYED6cND9oScm6sp9YTIy98e8ujvFe3eSOGN3wD2g8JtwSZ92VbYvRQ44zK
	 CQZJfcSHSOKCcTrVntQcVms9PctBV5EtAL04a0YnlFv1g3QRrZACtehOJc9ZPBdtLt
	 shK1wdYc42OaxY4CXxCvAwOy+iHE08i9NbtMrc3ZAjxft4Wgpd4vbWG4TvqglSqkfK
	 FEvQTVgvMtCdav78qmBGfdWtBOY9467AIE4leEDYyG49O2LKO2YeBsNyqOAcn4GJ2u
	 mX/t+uyIfWHz163MhTEGD29qXQkbRv3EcacJ6iyIisWkHOCJOhz8k2smqYROtOodm1
	 S/KiTTJA2WXNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] HID: wacom: fix OOB read in
 wacom_wac_pen_serial_enforce()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Jie LAW" <98lawweijie@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260828033323.82958-1-98lawweijie@gmail.com>
References: <CANRwn3TWTHxP=ZEpgZzjRweC8vqifoi2koKgSQTEuPuY4FZxcQ@mail.gmail.com>
 <20260828033323.82958-1-98lawweijie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 03:50:35 +0000
Message-Id: <20260828035035.E78121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Delayed work 'init_work' is scheduled but not canceled on hid_hw_o=
pen() failure, leading to Use-After-Free.
- [High] Sysfs handlers wacom_led_select_store and wacom_led_select_show do=
 not check if wacom->led.groups is NULL before accessing it, leading to a c=
rash during unbind.
--

commit e33281ca5de90c5a4993fe522ad3163d519fa468
Author: Wei Jie Law <98lawweijie@gmail.com>

HID: wacom: fix OOB read in wacom_wac_pen_serial_enforce()

This commit clamps the iteration loop in wacom_wac_pen_serial_enforce() to
field->report_count to prevent an out-of-bounds read when processing usages.
It fixes an information disclosure bug where reports could read past their
bounds into other memory.

[ ... ]

drivers/hid/wacom_sys.c:wacom_parse_and_register()
> 		error =3D hid_hw_open(hdev);
> 		if (error) {
> 			hid_err(hdev, "hw open failed\n");
> 			goto fail_hw_stop;
> 		}

[Severity: High]
This is a pre-existing issue, and was not introduced by the patch under
review, but does this error path fail to cancel the previously scheduled
init_work before returning?

A device connects and wacom_probe() calls wacom_parse_and_register().
The function schedules wacom->init_work.

If the device is a WL_MONITOR and hid_hw_open() fails, the function exits
with an error without canceling the delayed work.=20

The HID core's devres cleanup frees the wacom structure, leaving the delayed
work queued.

Could this cause a Use-After-Free memory corruption when the delayed work
executes after the wacom structure has been freed?

A malicious USB device or a fuzzer could simulate a device that fails
hid_hw_open(), reliably triggering the use-after-free.

[ ... ]

drivers/hid/wacom_sys.c:wacom_led_select_store()
> 	wacom->led.groups[set_id].select =3D id & 0x3;

[Severity: High]
This is a pre-existing issue, and was not introduced by the patch under
review, but could this assignment cause a NULL pointer dereference of
wacom->led.groups?

During device unbind, wacom_remove() clears wacom->led.groups to NULL. Beca=
use
the sysfs attributes were created using devres (sysfs_create_group), they a=
re
not removed until after wacom_remove() completes.=20

During this window, any read or write to status_ledX_select will invoke
wacom_led_select_show() or wacom_led_select_store(), which unconditionally
dereference wacom->led.groups.

drivers/hid/wacom_sys.c:wacom_led_select_show()
> 	return scnprintf(buf, PAGE_SIZE, "%d\n",			\
> 			 wacom->led.groups[SET_ID].select);		\

[Severity: High]
This is a pre-existing issue, and was not introduced by the patch under
review, but is wacom->led.groups accessed here without first checking if it
is NULL?

Could this lead to a NULL pointer dereference and a kernel crash?

The sysfs files are world-readable (DEV_ATTR_RW_PERM), meaning an unprivile=
ged
local user can continuously read them in a loop while the device is being
unplugged to win the race and crash the system.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828033323.8295=
8-1-98lawweijie@gmail.com?part=3D1
