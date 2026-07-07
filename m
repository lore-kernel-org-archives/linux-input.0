Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F07379C47
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 15:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436651; cv=none; b=q2umYB2WiSkxtlS+Yjg1EHKOTst4V6tzSk1pIEuBPvqRuP939MXo1Ov0jPfXjs1D3Uk7FyJ9caUuxp9F/xKO3oMfZL7s+/qkgE6BM9F3bO/y6qEfxF5hlg+yYVjmkK0pKUW6Jx7TGmUDd6FWhVGd8VPVwqXb1eeEJaYM3U61xLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436651; c=relaxed/simple;
	bh=JugFnUrI+/GLfrwJb4m1A8yEfTd6FFGwNG0qYhaXSmE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eXs7l61vbNLU5+3vgu9YXtL5Q7QehAzbuHMdvjI8u/dFI8T6EnCR13l/jmiPl/1lUxSYiPRSWzlhdjqP4TJqXp0Pd5cCe+VlWlxAZpIi4Q/HA0n3D4YX+0qPBik85YW2R1sKmZlFoqz4J1/sLEX4mr9oPnMzSahNhueFs0HBRbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JP+jVgT3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JP+jVgT3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FAC1F000E9;
	Tue,  7 Jul 2026 15:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783436649;
	bh=sbJ5BwUC0pLfLKraJUDZkqMzoIwSMvNkWAM3zpxUSsI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JP+jVgT3R5qpNgcCw6PwBjmik0xNzEl4rVvVeMaSYM6KRyuaxpvYZbslnT8WTDkPP
	 TTanpNticXH0W96zT4eEYaxjy09+qfS4L7xIKZucTf2XPKUF/l8P/ZxdRr0S+2iD06
	 4ILk6VfhWewBIyzcIUrlyv90dLFt2LpCUx0ya13+YWnpQ0tXs5nckF9g6IJF2oyhbd
	 fL6EIfqtXcwPBPVvHCSx/KvqB8bgJ/mb8Ke809sVrj5W6A/cWVMMo0v61ACF1+8hWb
	 N8vLWGMLwT9rgoeiDQz/865OCa8qOz3LnLpkmU4Q5pEoyqdOjg6RCvvvlvTdT/oQhs
	 huDxZT/XKL4DQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/2] HID: appletb-kdb: Replace system_wq with
 system_dfl_wq
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marco Crivellari" <marco.crivellari@suse.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260707145327.313292-3-marco.crivellari@suse.com>
References: <20260707145327.313292-1-marco.crivellari@suse.com>
 <20260707145327.313292-3-marco.crivellari@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 15:04:09 +0000
Message-Id: <20260707150409.A2FAC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] Incomplete migration to the unbound workqueue: `schedule_work()` st=
ill targets the per-CPU workqueue.

Pre-existing issues:
- [High] Race condition during device probe causes a NULL pointer dereferen=
ce if a HID event arrives before `hid_set_drvdata()` is called.
- [High] Sleeping in atomic context when calling `hid_hw_power` from the in=
put event handler.
--

--- Patch [2]: [PATCH RFC 2/2] HID: appletb-kdb: Replace system_wq with sys=
tem_dfl_wq ---
commit b55f729cf441f481f051cec559ad520a64ea4188
Author: Marco Crivellari <marco.crivellari@suse.com>

HID: appletb-kdb: Replace system_wq with system_dfl_wq

This commit changes the driver to use the unbound system_dfl_wq workqueue
instead of the per-CPU system_wq, to optimize task placement and power
consumption.

> diff --git a/drivers/hid/hid-appletb-kbd.c b/drivers/hid/hid-appletb-kbd.c
> index 462010a758993..5cc27066f6026 100644
> --- a/drivers/hid/hid-appletb-kbd.c
> +++ b/drivers/hid/hid-appletb-kbd.c

[ ... ]

> @@ -201,7 +201,7 @@ static void reset_inactivity_timer(struct appletb_kbd=
 *kbd)
>  			kbd->has_turned_off =3D false;
>  			schedule_work(&kbd->restore_brightness_work);
>  		}

[Severity: Low]
Since the goal is to move entirely to the unbound system_dfl_wq, did we miss
updating this schedule_work() call?=20

The schedule_work() function implicitly targets the per-CPU system_wq, so
restore_brightness_work won't benefit from the scheduler optimizations
intended by this patch.

Could we use queue_work() with system_dfl_wq here instead?

> -		mod_delayed_work(system_wq, &kbd->inactivity_work,
> +		mod_delayed_work(system_dfl_wq, &kbd->inactivity_work,
>  				 secs_to_jiffies(appletb_tb_dim_timeout));
>  	}
>  }

[ ... ]

> @@ -423,7 +423,7 @@ static int appletb_kbd_probe(struct hid_device *hdev,=
 const struct hid_device_id
>  		INIT_DELAYED_WORK(&kbd->inactivity_work, appletb_inactivity_work);
>  		INIT_WORK(&kbd->restore_brightness_work,
>  			  appletb_restore_brightness_work);
> -		mod_delayed_work(system_wq, &kbd->inactivity_work,
> +		mod_delayed_work(system_dfl_wq, &kbd->inactivity_work,
>  				 secs_to_jiffies(appletb_tb_dim_timeout));
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but looking at the surrounding
appletb_kbd_probe() setup, is there a race condition between hid_hw_open()
and driver data initialization?

Earlier in appletb_kbd_probe(), hid_hw_open() is called before
hid_set_drvdata() executes. If a hardware event arrives immediately after
hid_hw_open() starts polling, the hid core calls the event handler:

appletb_kbd_hid_event()
   struct appletb_kbd *kbd =3D hid_get_drvdata(hdev);

Because hid_set_drvdata() hasn't been called yet, hid_get_drvdata() returns
NULL. When reset_inactivity_timer() later dereferences kbd->backlight_dev,
could this cause a kernel panic?

[Severity: High]
This is another pre-existing issue, but does appletb_kbd_inp_event() sleep
in an atomic context?

When the input subsystem invokes the .event callback, it holds the device's
event_lock spinlock with local interrupts disabled. If the fn key is toggle=
d,
the callback path goes:

appletb_kbd_inp_event()
  appletb_kbd_set_mode()
    hid_hw_power(hdev, PM_HINT_FULLON);

For usb devices, hid_hw_power() resolves to usbhid_power(), which calls
usb_autopm_get_interface(). This uses pm_runtime_get_sync(), which acquires=
 a
mutex and can sleep.=20

Could this trigger a scheduling while atomic panic when the user presses
the fn key?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707145327.3132=
92-1-marco.crivellari@suse.com?part=3D2
