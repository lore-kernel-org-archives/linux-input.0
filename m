Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EA418A6DB
	for <linux-input@vger.kernel.org>; Wed,  1 Jul 2026 03:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782876530; cv=none; b=D9mwIvmhSrh5lLtPuV6yYaczashD9Jma5UX8z0k6a9t2ivCSkuSBwTA3fXQ5rL8aVNgm9IRxyRmYPt7mXhDeB6WfYdi/Lhvmm68Jhdsdh+K9Cuy6tNRimi6dZPIVpo9cYXlxkG6lgyodQ6gQFHnjEhO1hXVKSSESkC6ObRjYWHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782876530; c=relaxed/simple;
	bh=tndxMmv/J1IFz5CERPaPH/gwF6bUil8cbYt1lL9ptUs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fOUHGg2U9XpOpwpP3KkYQMfkblRjegnsWjnmnTUc1WPU8Xe82LjVnfIMYIQgP4D23QdxU0+ghk/VUYSUsS4XA27kFLJz05ukk6N12ZYUeuPjIWMREjUfsrF9C+Sg6XmjQWXFg6pCmSC3GYxihmXEiZmjv1GPp7qcUkOwu/jKR/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kynTyQ70; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kynTyQ70"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0691F000E9;
	Wed,  1 Jul 2026 03:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782876528;
	bh=tndxMmv/J1IFz5CERPaPH/gwF6bUil8cbYt1lL9ptUs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kynTyQ70dA3GQBTTU/V4SKuWUAXq9nO8pLCTBJSNrqIyqOpKuOmalK0K2JxLGZT8l
	 webhM1gQbLjt18Knvb8UIiv9ina+aee9/Q9Akr2MkoaWtYb1bxOeRSnOR8l5gGEvrV
	 YPigcAbw+0IbnItr2CkAIavVJucu4raPlSVrYI35QrDlpFLX4kSJBaD9+KIGkMr2+M
	 lL6lytuVGkjXEqbaeT3uywqt4VetQEMyAo73gMELvqW04oFsHmRyJDIQSe4fmRiV23
	 57QVJehfdfxOiAAVHwkhj+74D5Ao5FhqpXiEWSq9RvopUb4DotAd6xftWQqQVo1Sa/
	 3ze91iJCWXtJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/3] HID: nintendo: Add preliminary Switch 2
 controller driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260701031513.3068035-2-vi@endrift.com>
References: <20260701031513.3068035-1-vi@endrift.com>
 <20260701031513.3068035-2-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 03:28:47 +0000
Message-Id: <20260701032848.0F0691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [Critical] Race condition in switch2_get_controller() allows calling kref=
_get() on an object with a 0-refcount.
- [Critical] The controller structure (ns2) is freed before its devm-manage=
d LEDs are unregistered, causing Use-After-Free.
- [High] Reversed teardown order in switch2_usb_disconnect() causes Use-Aft=
er-Free of ns2_usb.
- [High] Explicit input_unregister_device() on a devm-managed input device =
causes resource leaks and LED subsystem list corruption across USB reconnec=
ts.
- [High] Double spinlock acquisition in the USB probe error path causes a h=
ard deadlock.
- [High] Probe failure for a duplicate HID device wrongly unregisters the a=
ctive input device of the existing controller.
- [High] Dangling cfg->parent pointer on switch2_controller_attach_cfg fail=
ure leads to Use-After-Free.
- [High] Dereference of ns2->cfg without a NULL check in switch2_receive_co=
mmand causes a crash.
- [Low] Redundant manual assignment of parent device for devm-managed input=
 device.
--

Note: The format of this review has been altered to a free-form summary due
to recitation restrictions. The original diff is not quoted, but the
locations and issues are described below.

commit d9d2794b04a1b3ab24fb33bed74fba65c1f6f459
Author: Vicki Pfau <vi@endrift.com>
Subject: HID: nintendo: Add preliminary Switch 2 controller driver

This commit adds a new split driver for the Nintendo Switch 2 controllers,
handling input and rumble over a main HID interface and configuration over
a secondary interface.

[Severity: High]
In switch2_usb_disconnect() in drivers/input/joystick/nintendo-switch2-usb.=
c,
is the teardown sequence reversed?

The code calls cancel_work_sync() for message_in_work before it calls
usb_kill_anchored_urbs() for the bulk_in anchor. If an active IN URB
completes after the work is canceled but before the URBs are killed, its
completion handler could schedule the work again.

Will this lead to a use-after-free of the ns2_usb structure when devres
eventually frees it?

[Severity: Critical]
Looking at switch2_get_controller() and switch2_kref_put() in
drivers/hid/hid-nintendo.c, is there a race condition that allows acquiring
a zero-refcount object?

switch2_kref_put() deletes the entry from the list, but there is a window
where the refcount is zero before the lock is acquired and the item is
removed.

Can a concurrent switch2_get_controller() find this dying object and
blindly call kref_get() on it, resulting in list corruption and a
use-after-free? Should this use kref_get_unless_zero() instead?

[Severity: High]
In switch2_controller_put(), the code explicitly calls
input_unregister_device() on an input device that was allocated with
devm_input_allocate_device().

Does this violate the devm lifecycle? The input subsystem defers freeing a
devm-managed input device and its children until the parent unbinds.

On a USB reconnect, will this leak the old input device and cause a name
collision or list corruption in the LED subsystem when the driver tries
to register new LEDs with the same names?

[Severity: Low]
In switch2_init_input(), the code manually assigns the parent of the input
device to the hdev device.

Since devm_input_allocate_device() automatically sets the parent device,
isn't this manual assignment redundant?

[Severity: Critical]
In switch2_remove(), the code calls switch2_controller_put() and then drops
the final refcount via kref_put(), which frees the ns2 structure.

However, the LED class devices are embedded inside the ns2 structure and
are devm-managed.

Won't devres attempt to unregister these LEDs later during the driver
core's devres_release_all() phase? Will this cause a use-after-free
because the memory for the LEDs has already been freed?

[Severity: High]
In the err_free_in cleanup path of switch2_usb_probe(), if the urb pointer
is NULL, the code calls spin_lock_irqsave() again instead of releasing the
lock with spin_unlock_irqrestore().

Will this double spinlock acquisition cause a hard deadlock under memory
pressure when URB allocation fails?

[Severity: High]
In switch2_probe(), if a second HID interface attempts to bind to an
already claimed physical controller, it correctly detects this and returns
an error.

However, the error path jumps to err_put, which calls
switch2_controller_put().

Does this unintentionally unregister the active input device of the
existing, working controller? Should it just drop the newly acquired
refcount instead?

[Severity: High]
In switch2_controller_attach_cfg(), if switch2_init_controller() fails,
the code clears ns2->cfg but does not clear cfg->parent.

Does this leave a dangling pointer? If an IN URB completes concurrently,
could switch2_usb_message_in_work() observe a non-NULL cfg.parent and
pass a freed ns2 pointer to switch2_receive_command(), causing a
use-after-free?

[Severity: High]
In switch2_receive_command(), the code checks for a packet error and then
unconditionally accesses ns2->cfg->dev to print a warning.

Because this work can run concurrently with switch2_controller_detach_cfg()
(due to the teardown order issue mentioned above), is it possible for
ns2->cfg to be NULL here?

Will this cause a NULL pointer dereference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701031513.3068=
035-1-vi@endrift.com?part=3D1
