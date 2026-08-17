Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8E9377A98
	for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 07:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952852; cv=none; b=ZqFhAWaqeNAqWbGi4tyCaQ5LPWvEwzypEX+jJxrPeoRcNa6t8mCphXfdwKUvlVi25HSewNqaumjqDIQjovO6cGuFKflWhgR58Ga/UdYFO0p+p4bsKBSmzt0vD3+S7bi83R1zvcdG1snbNDeWqW5nzJ8awIgWG8DJhEjQr3MaU1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952852; c=relaxed/simple;
	bh=/engzqWl29doyYxRbMVhrACHsevN57jOUwszO6nGYQE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cNrtQNkpyOWTTwk+paUYA3319tzVMwKuyoYokZRl+6GED7kCbBp7sd93DKrwRAEC1s4wEdEV44pFMBLr6lmRljsRuU3Kjh4CMa6pMLyneeIGnqdR2gLV8O/M2ohfm+Ub5d9pzvsikP26RKa8Y29Rq/ZwuIgpBQCwXzGM1T3DmKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLz7IDHT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLz7IDHT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408701F000E9;
	Mon, 17 Aug 2026 07:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786952850;
	bh=7LMsR2V5vFNTJ1O1aCimnLDoJQK+bsSexLOUQ65ZizU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mLz7IDHTrbiYOM+SmGtemBySTT/nlkBDSLhuJOEn7Xe2OGEpoW0mAcAIz99bN5XU8
	 F42I9D72683nIo0RV+5hih7PFT3xha5rGxBCwRS4TKJEGiiBWfWOBHOkK+lrSQ+Zx2
	 5TGQks085eEnkKyx94t7vfeozHu22Fop+MgGqdtsRA2A0at77HA2EdU1wsbiYRN4GQ
	 zeCU+naMEbUKN/Ug4Irej1AKL0JXEavQHin8Ra0QfIqaJTfB1pCvQpNQKlO8dhBbBP
	 TeMEHT8MTJmmpjkcOh5N8T/dfeC7U1KTj0XSVG/u4bD/sdlW57cMDT9cDtIcqGbK5B
	 8mVRtgRVF/pgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: corsair: do not re-schedule LED worker after it
 has been cancelled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Changcheng" <ccc194101@163.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260817072831.139954-1-ccc194101@163.com>
References: <20260817072354.139154-1-ccc194101@163.com>
 <20260817072831.139954-1-ccc194101@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 07:47:29 +0000
Message-Id: <20260817074730.408701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Moving cancel_work_sync() before led_classdev_unregister() in the =
probe error path introduces a TOCTOU race with concurrent sysfs writes, lea=
ding to a Use-After-Free.

Pre-existing issues:
- [High] Hardware events can trigger Use-After-Free in corsair_event() due =
to hid_hw_stop() being called after freeing driver data in corsair_remove().
- [High] TOCTOU Use-after-free in LED workers due to led_classdev_unregiste=
r() being called before cancel_work_sync() in cleanup functions.
--

--- Patch [1]: [PATCH] HID: corsair: do not re-schedule LED worker after it=
 has been cancelled ---
commit 4542e75f6964d50f56a268d347abdebb867081d5
Author: Chen Changcheng <chenchangcheng@kylinos.cn>

HID: corsair: do not re-schedule LED worker after it has been cancelled

This commit attempts to fix a use-after-free by preventing the LED worker
from being re-scheduled after it has been cancelled. It adds a removed flag
check and reorders the cleanup sequence in the probe error path.

> diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
> index 21cd8b12a7572..dba233b99e5d6 100644
> --- a/drivers/hid/hid-corsair.c
> +++ b/drivers/hid/hid-corsair.c

[ ... ]

> @@ -507,8 +510,8 @@ static int k90_init_macro_functions(struct hid_device=
 *dev)
> =20
>  fail_sysfs:
>  	k90->record_led.removed =3D true;
> -	led_classdev_unregister(&k90->record_led.cdev);
>  	cancel_work_sync(&k90->record_led.work);
> +	led_classdev_unregister(&k90->record_led.cdev);

[Severity: High]
Does swapping these calls introduce a Time-of-Check to Time-of-Use race
with concurrent sysfs writes?

Since led_classdev_unregister() acts as the synchronization barrier against
sysfs writes, moving cancel_work_sync() before it might allow a concurrent
write to bypass the barrier.

Could a concurrent sysfs write evaluate led->removed as false in
k90_brightness_set(), get preempted, and then schedule the work after
cancel_work_sync() has already finished?

Sysfs thread:
k90_brightness_set()
    if (led->removed)
        return;
    <preempted>

Probe error thread:
fail_sysfs:
    k90->record_led.removed =3D true;
    cancel_work_sync(&k90->record_led.work);
    led_classdev_unregister(&k90->record_led.cdev);

Sysfs thread resumes:
    led->brightness =3D brightness;
    schedule_work(&led->work);

If the probe error thread then finishes and frees the k90 struct, wouldn't
the newly queued work execute later on freed memory?

>  fail_record_led:
>  	kfree(k90->record_led.cdev.name);
>  fail_record_led_alloc:


This is a pre-existing issue, but looking at the commit message and the
cleanup functions:

The commit message states that a previous commit moved cancel_work_sync()
ahead of led_classdev_unregister() in k90_cleanup_backlight() and
k90_cleanup_macro_functions() to fix a use-after-free. However, looking at
those functions in the current code, led_classdev_unregister() is still
called first:

k90_cleanup_macro_functions(struct hid_device *dev) {
    ...
    led_classdev_unregister(&k90->record_led.cdev);
    cancel_work_sync(&k90->record_led.work);
    ...
}

[Severity: High]
Does calling led_classdev_unregister() before cancel_work_sync() cause a
use-after-free during driver unbind?

led_classdev_unregister() drops the refcount and frees the underlying device
struct. If a worker thread like k90_backlight_work is executing concurrentl=
y,
passes the removed check, and gets preempted, it could resume after the
device is freed:

k90_backlight_work(struct work_struct *work) {
    ...
    dev =3D led->cdev.dev->parent;
    ...
}


This is also a pre-existing issue, but looking at corsair_remove():

corsair_remove(struct hid_device *dev) {
    ...
    k90_cleanup_macro_functions(dev);
    k90_cleanup_backlight(dev);

    hid_hw_stop(dev);
}

[Severity: High]
Does calling hid_hw_stop() after freeing driver data allow hardware events
to trigger a use-after-free?

In k90_cleanup_macro_functions(), the k90 struct is freed via kfree(k90),
but the drvdata->k90 pointer is not set to NULL. Since hid_hw_stop() hasn't
been called yet, the HID core can still deliver incoming USB hardware event=
s.

If an event arrives in this window before the hardware is stopped, could
corsair_event() dereference the dangling pointer?

corsair_event(...) {
    ...
    drvdata->k90->record_led.brightness =3D 1;
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817072831.1399=
54-1-ccc194101@163.com?part=3D1
