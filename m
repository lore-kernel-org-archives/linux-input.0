Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852E21367
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 00:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785113739; cv=none; b=sr84QjgzBY1S2Ulce+CqJ/tXw3AFaauYvQsuoBZCQaXfci77iGmBVaDMg2U2m4zfMNULcmbJ73gr1jOOQFBQTN7fu0kT8he6dm6VgbQ8Kf0UYxWDAKUtE3Nuqx7rg1YxQ9C+Yz7vmWu0YE4T+IEK64kqBFwYQLFErWNng3W/0go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785113739; c=relaxed/simple;
	bh=xajQ3APXAR2q/u5+r5/BvUq1XpwKQyAJB804L8OIrwA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mgHO8XXz9j8n1SisNU2Cg+AzFnLrTwapkIlz4xoZAfIhlIwJx2lKj3OlUBXtaU7+mSbd9Khu6Ow5FW/twzqvkih6/WJadY9gQCtm2dsVCcGvGW5rlFQ5pKWGmosneLniVn+a10+6RByA+JiIIQm6UdY+aKCGi7HETpEp9Zyv0Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQP4qFh7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQP4qFh7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1541F000E9;
	Mon, 27 Jul 2026 00:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785113738;
	bh=NE7Gv8Q/FYxysQZSK7oNpfTUpQ0ayZraskEdUih3yd4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XQP4qFh7wnB/iZgv8iRrV3P8YZ1gxItZ6nFWEmDmgFRM+HTYaywhum48Y6Mh+y7OA
	 xXy8OYZMJZy2Dk0q//eCZxjNSdzIfIc+cfI7vWUt7qMyjvk10tdkCR9j8Qqm23O94G
	 MaWM0lykzaq0JA0ZJl40hFBdOzFqd8J1vQBS+o2s8QBkXqYZfaZGVMTSSUgKGhJ+Tq
	 FlqIKJRocZs6wycJskwhxapx46jE7Et2HxWjOBQoj9YkPU5898lM9TSbW6ZIZfSWY+
	 HpQQ2rbS7AwUfUOecvNbrhb0g6Shsph0I/gPI/eZsn8XRt3BG6lt7VCSzLEiGbcQTh
	 DSw3bHh/7ZKRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: gscps2 - supply PA-RISC keyboard keymap via
 device property
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <amaJEXxiKjghv0F0@google.com>
References: <amaJEXxiKjghv0F0@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 00:55:37 +0000
Message-Id: <20260727005537.9D1541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Medium] Missing keycode mapping for PA-RISC keyboard scancode 0x92 leads=
 to spurious dmesg warnings.
- [Medium] The managed software node allocated for the keyboard serio devic=
e leaks if port registration is canceled before execution.

Pre-existing issues:
- [High] Lockless modifications to `ps2port_list` race with lockless traver=
sal in the shared hardirq handler, leading to potential list corruption and=
 panics.
- [High] `gscps2_remove()` frees the `serio` port before unregistering the =
interrupt handler, creating a use-after-free vulnerability.
- [High] The interrupt handler unconditionally returns `IRQ_HANDLED` for a =
shared IRQ line, defeating spurious interrupt detection.
--

--- Patch [1]: [PATCH] Input: gscps2 - supply PA-RISC keyboard keymap via d=
evice property ---
commit 66edd58351136502cfbfeb7361cae9d5adeebf48
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: gscps2 - supply PA-RISC keyboard keymap via device property

This patch refactors the PA-RISC keyboard driver to supply the keymap via a
software node device property instead of hardcoding it in the generic atkbd
driver. It moves hpps2atkbd.h to the serio subsystem and attaches the
property during port registration.

diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
--- a/drivers/input/serio/gscps2.c
+++ b/drivers/input/serio/gscps2.c
[ ... ]
> @@ -398,6 +397,17 @@ static int __init gscps2_probe(struct parisc_device =
*dev)
>  		goto fail;
>  #endif
> =20
> +	if (ps2port->id =3D=3D GSC_ID_KEYBOARD) {
> +		ret =3D device_create_managed_software_node(&serio->dev,
> +							  gscps2_props, NULL);

[Severity: Medium]
Does this leak the software node if driver unbinding races with the
asynchronous port registration?

serio_register_port() queues port registration asynchronously on a
workqueue. If the driver is unbound and calls serio_unregister_port()
before the workqueue executes device_add(), device_is_registered()
evaluates to false in serio_destroy_port(), bypassing device_del().
Because device_del() is skipped, the software node is never removed.

> +		if (ret) {
> +			dev_err(&dev->dev,
> +				"failed to add software node for keyboard: %d\n",
> +				ret);
> +			goto fail;
> +		}
> +	}
> +
>  	pr_info("serio: %s port at 0x%08lx irq %d @ %s\n",
>  		ps2port->port->name,
>  		hpa,
>  		ps2port->padev->irq,
>  		ps2port->port->phys);
> =20
>  	serio_register_port(ps2port->port);

[Severity: High]
This is a pre-existing issue, but does gscps2_remove() create a
use-after-free window?

In the driver removal path, serio_unregister_port() is called before
free_irq() and before the port is removed from ps2port_list. If a shared
interrupt fires in this window, gscps2_interrupt() will execute, traverse
the list, and dereference the freed ps2port->port pointer.

>  	list_add_tail(&ps2port->node, &ps2port_list);

[Severity: High]
This is a pre-existing issue, but can this race with the interrupt handler
and corrupt the list?

The global ps2port_list is modified here locklessly. Concurrently, the
shared interrupt handler gscps2_interrupt() iterates over this list using
list_for_each_entry() without any locks. Since the interrupt is registered
as IRQF_SHARED earlier in this function, an interrupt can trigger on another
CPU while the list is being modified.

[Severity: High]
This is also a pre-existing issue, but does gscps2_interrupt() defeat
spurious interrupt detection?

It appears the interrupt handler unconditionally returns IRQ_HANDLED
regardless of whether it actually serviced any pending data. Because this
IRQ is requested with IRQF_SHARED, this prevents the generic IRQ subsystem
from detecting unhandled states and disabling the IRQ line if another
device sharing this line asserts an interrupt but its driver fails to
clear it.

diff --git a/drivers/input/serio/hpps2atkbd.h b/drivers/input/serio/hpps2at=
kbd.h
new file mode 100644
--- /dev/null
+++ b/drivers/input/serio/hpps2atkbd.h
[ ... ]
> +	KEYMAP_ENTRY(0x79, KEY_KPPLUS),		KEYMAP_ENTRY(0x7a, KEY_KP3),
> +	KEYMAP_ENTRY(0x7b, KEY_KPMINUS),	KEYMAP_ENTRY(0x7c, KEY_KPASTERISK),
> +	KEYMAP_ENTRY(0x7d, KEY_KP9),		KEYMAP_ENTRY(0x7e, KEY_SCROLLLOCK),
> +	KEYMAP_ENTRY(0x7f, KEY_102ND),		KEYMAP_ENTRY(0x91, KEY_RIGHTALT),
> +	KEYMAP_ENTRY(0x94, KEY_RIGHTCTRL),	KEYMAP_ENTRY(0x9d, KEY_CAPSLOCK),
> +	KEYMAP_ENTRY(0x9f, KEY_LEFTMETA),	KEYMAP_ENTRY(0xa7, KEY_RIGHTMETA),

[Severity: Medium]
Is the mapping for scancode 0x92 intentionally omitted here?

The previous PA-RISC keycode table explicitly mapped scancode 0x92 to 255
(ATKBD_KEY_NULL), which atkbd ignores silently. With the new gscps2_keymap
property array, scancode 0x92 defaults to 0 (ATKBD_KEY_UNKNOWN).

If the physical keyboard emits this scancode, atkbd will process it and flo=
od
the kernel logs with "Unknown key %s ..." warnings.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/amaJEXxiKjghv0F0@go=
ogle.com?part=3D1
