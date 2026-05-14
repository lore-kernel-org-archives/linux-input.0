Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C759F39478D
	for <linux-input@vger.kernel.org>; Thu, 14 May 2026 11:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778757247; cv=none; b=LWAemk9NY/hC2J5KegigUeDs6aTvBAdGmWObbM58zOZE74JA8dm4Idd5Hj/Pr7Zo5XAMN84ySc4XBhqDR84ASqRl41m+z/G8ZWJE6Xr1cjWrajaU22MT9BNf/AeeQeqpCWdSrJWF3QR0ZFUQHGP2CQmSzk8l+fGTFHzSH+H1Trc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778757247; c=relaxed/simple;
	bh=XB85ZMz5wb11K7ntqKmFrypMynThmx9LxyFM2EPz8i8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QoOlNGozExFZuofoV+zteNVdvlTtPk2oqmTDF+jiJbdRYfw8ObAjUMniCdmlMWLDElwgGTnaCMBSY5z4QkUM6AAb01LCPLS6Z+Kbku5dxmEZlnAvMvr7rTQGY5dHUoePbgSjqM29v+2QhKiiIoMCNbgy3d+QoNu6/2qmtb0OeWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqtJndVj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqtJndVj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFAAC2BCB3;
	Thu, 14 May 2026 11:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778757247;
	bh=XB85ZMz5wb11K7ntqKmFrypMynThmx9LxyFM2EPz8i8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=WqtJndVjKXgYeSTYx65vOANzLnCmQb/YLGaK66ZmW757dipiYzXuBf8coo1MibrxC
	 effmsyP+Szqe4t09pMDsR/eJfbMbMEpb2nuLI1vEwFF7p8acK0JjTef30X8JzAJYUi
	 Epjp7fJLbV5NzCKVQO6fRDxUx/V7Paz4wKCoEdekltTyKK448ER2Oqf6Ry1n14sF44
	 fm50gHOAXIYi07NSWgqv8UFVaMltF1J23Zn+rbXu4psETDcWwZn9uTlJZHN59QAxt2
	 7JPIvMeXOx8wEJKDpwBuasXkEIJsXxJlddVJVIE5r9bG1Z3AXW9iSat4Wt3Pz1JOvi
	 6owI0/MV7hCcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] hid-asus: Allow adding custom hotkey handler logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Pisati" <p.pisati@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260513163248.16483-7-p.pisati@gmail.com>
References: <20260513163248.16483-7-p.pisati@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 11:14:06 +0000
Message-Id: <20260514111407.3AFAAC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Calling platform_profile_cycle() from an atomic context causes a '=
scheduling while atomic' bug.
- [High] Missing Kconfig dependency on ACPI_PLATFORM_PROFILE leads to a lin=
ker error.
- [Medium] Improper HID event return value causes spurious error logs and i=
ncorrect event propagation.
- [Low] Dead code due to unreachable break statement.
--

commit f4dcdddfbfb9d5acd09f6a961fcad0539b0cd8c7
Author: Joshua Leivenzon <hacker1024@users.sourceforge.net>

hid-asus: Allow adding custom hotkey handler logic

This commit modifies the Asus HID driver to handle a custom vendor hotkey
for cycling the platform profile when a specific usage code is received.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index fe52fd63d61c6..37e3aec612b6d 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -29,6 +29,7 @@
>  #include <linux/input/mt.h>
>  #include <linux/usb.h> /* For to_usb_interface for T100 touchpad intf ch=
eck */
>  #include <linux/power_supply.h>
> +#include <linux/platform_profile.h>

Does the HID_ASUS Kconfig option need to depend on or select
ACPI_PLATFORM_PROFILE? If the kernel is built with
CONFIG_ACPI_PLATFORM_PROFILE=3Dn, won't this result in a linker error since
platform_profile_cycle() is used unconditionally and there are no empty dum=
my
stubs provided in the header?

[ ... ]

> @@ -362,8 +363,21 @@ static int asus_event(struct hid_device *hdev, struc=
t hid_field *field,
>  	if ((usage->hid & HID_USAGE_PAGE) =3D=3D HID_UP_ASUSVENDOR &&
>  	    (usage->hid & HID_USAGE) !=3D 0x00 &&
>  	    (usage->hid & HID_USAGE) !=3D 0xff && !usage->type) {
> -		hid_warn(hdev, "Unmapped Asus vendor usagepage code 0x%02x\n",
> -			 usage->hid & HID_USAGE);
> +
> +		/*
> +		 * Some reports do not map directly to standard keys, and need special
> +		 * handling.
> +		 */
> +		switch (usage->hid & HID_USAGE) {
> +			case 0x9d:
> +				if (!value)
> +					break;
> +				return platform_profile_cycle();

Is it safe to call platform_profile_cycle() from here?

The asus_event() callback is invoked by the HID core in an atomic softirq
context when processing USB URB completions. However,
platform_profile_cycle() acquires profile_lock, which is a mutex. Will this
result in a scheduling while atomic panic? Should this action be deferred to
a workqueue, similar to how fn_lock_sync_work is handled?

Also, if platform_profile_cycle() returns a negative error code (like -EINV=
AL
when no profiles are registered), returning it directly here will cause
hid_process_event() to spam the kernel log with error messages on every key
press. Conversely, if it returns 0 on success, won't the HID core incorrect=
ly
continue processing this event instead of treating it as consumed? Does this
need to handle the return value and return 1 to halt further event
processing?

> +				break;

This isn't a bug, but this break statement is unreachable since the previous
line always returns.

> +			default:
> +				hid_warn(hdev, "Unmapped Asus vendor usagepage code 0x%02x\n",
> +					 usage->hid & HID_USAGE);
> +		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513163248.1648=
3-1-p.pisati@gmail.com?part=3D6
