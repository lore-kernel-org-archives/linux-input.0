Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6282864A8C
	for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 00:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784852699; cv=none; b=Jdb6YBTOuNXT/oSc4oOq8JnNrBSRmBoSx65qIlDjmA/8qryaNc9Kju78Tj2yz1pJFAWqdH3N4O9bH09dVmDTZDI6LNeMJibuegmPFGJtNetRp+6lXDII++isVPDLAEH6DmoxspU3DR58GRfBYYWfUngWk1ij17NqoGXA6Auctew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784852699; c=relaxed/simple;
	bh=zDFI3RDZnWsIAaD5dAWnwiumJg3tnCGmf0o4ejhvktk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cx2OB+OykUQaKnchBrOwSEcenvx8RUKXf73fAkHXICD9E77wEZ2DTSmInAREKUfeB5Rb4uCDkqasn6n9doES5i0ZI35VmtRtbNUdAj6RiSXaPgTPRWiLolDxL8FN5e/91H5/809irRedrDTmNbm8WauQnp7eWqIerCpps9TYhvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzVG2kBD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzVG2kBD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075D01F000E9;
	Fri, 24 Jul 2026 00:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784852698;
	bh=bI/TNXaMQDtKhDgyGtV3EsZL+DnjOew6KkuomvXeyzw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AzVG2kBDq2HrBw02H180may9PGZ0d3In8b3hVgnRBTrOT68814+Pcf+vO3WtG8Aga
	 jNqtAGSCtVMngSeNL5wynf4Wow6bjC2RhAa2tetP6HQaU5nxDEqylixJ/XomfyVN0D
	 bz13n1sjRMjEN0cJG8cFvbosxSdq+MmR1kgM0c1nuXkoOcDQEzD7cKT9AX8e9nEbfR
	 nEnndlZeR9WffRCH+MPaS0J6mfvFhry8o9LafzrQDPcUoMm9KRwUTPwOdXGleHH4Gf
	 E3NpqXwBg4O89H9PUT987SKiTLWSGMrbYIFG6jHRkdVQkCff1X5BqGEjqzMOn8v5KE
	 6aJPVUBkgNEPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: multitouch: stop the release timer from being
 rearmed on remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260724000958.938675-1-qwe.aldo@gmail.com>
References: <20260724000958.938675-1-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 00:24:57 +0000
Message-Id: <20260724002458.075D01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Out-of-bounds write via set_bit() leading to memory corruption=
 by malicious HID devices.
- [High] Use-After-Free of report buffers in hid_haptic_destroy during devi=
ce teardown.
- [High] Race condition during probe leading to NULL pointer dereference in=
 mt_sync_frame.
- [High] Sleeping in atomic context when processing unmapped HID reports.
- [Medium] Data race modifying td->applications list without synchronizatio=
n.
--

--- Patch [1]: [PATCH] HID: multitouch: stop the release timer from being r=
earmed on remove ---
commit b618d8ab09924436537bc4c4c724c79da532672e
Author: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: HID: multitouch: stop the release timer from being rearmed on remo=
ve

mt_remove() quiesces the sticky-finger timer before stopping the
hardware. timer_delete_sync() waits for a running callback and
dequeues the timer, but it does not stop the timer from being armed
again. Use timer_shutdown_sync() instead.

Cc: stable@vger.kernel.org
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260723224211.613112-1-you@example.=
com?part=3D1
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 0495152091e3b..f25065b9ec66e 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -2233,7 +2233,7 @@ static void mt_remove(struct hid_device *hdev)
>  {
>  	struct mt_device *td =3D hid_get_drvdata(hdev);
> =20
> -	timer_delete_sync(&td->release_timer);
> +	timer_shutdown_sync(&td->release_timer);
> =20
>  	sysfs_remove_group(&hdev->dev.kobj, &mt_attribute_group);
>  	hid_hw_stop(hdev);
>  }

[ ... ]

drivers/hid/hid-haptic.c:hid_haptic_destroy() {
    ...
	kfree(haptic->stop_effect.report_buf);
	haptic->stop_effect.report_buf =3D NULL;

	if (haptic->effect) {
		for (r =3D 0; r < ff->max_effects; r++)
			kfree(haptic->effect[r].report_buf);
		kfree(haptic->effect);
	}
	haptic->effect =3D NULL;

	destroy_workqueue(haptic->wq);
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but could this lead to a
use-after-free during device teardown?

When an input device is destroyed, input_ff_flush() queues
stop_effect.work on the workqueue. If the work is still pending,
destroy_workqueue() will wait for it to finish. However, the report
buffers are freed before the workqueue is drained.

When haptic_work_handler() executes, it calls play_effect() which uses
the freed effect->report_buf.

Should destroy_workqueue() be called before freeing the report buffers?

drivers/hid/hid-multitouch.c:mt_probe() {
    ...
	ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
	if (ret)
		return ret;
    ...
	if (td->is_haptic_touchpad) {
		if (hid_haptic_init(hdev, &td->haptic)) {
			dev_warn(&hdev->dev, "Cannot allocate haptic for %s\n",
				 hdev->name);
			td->is_haptic_touchpad =3D false;
			devm_kfree(&hdev->dev, td->haptic);
		}
    ...
}

[Severity: High]
This is a pre-existing issue, but does this create a race condition if
hid_haptic_init() fails?

Since hid_hw_start() enables hardware interrupts earlier in mt_probe(),
an interrupt could arrive after hid_haptic_init() fails (setting td->haptic
to NULL) but before td->is_haptic_touchpad is set to false.

If mt_sync_frame() runs in this window, it will see td->is_haptic_touchpad
as true and call hid_haptic_pressure_reset(td->haptic), dereferencing a
NULL pointer.

Should the interrupt enablement or error handling order be adjusted?

drivers/hid/hid-multitouch.c:struct mt_device {
    ...
	unsigned long mt_io_flags;
	__u8 inputmode_value;
    ...
	struct list_head applications;
    ...
}

drivers/hid/hid-multitouch.c:mt_process_slot() {
    ...
	set_bit(slotnum, &td->mt_io_flags);
    ...
}

[Severity: Critical]
This is a pre-existing issue, but does this set_bit() call allow an
out-of-bounds write?

A malicious USB HID device could declare a contact max up to 250, resulting
in a slotnum up to 249. Since mt_io_flags is a single unsigned long, calling
set_bit(249, ...) overflows the variable by up to 31 bytes.

This would corrupt adjacent fields in the mt_device struct, including the
inputmode_value and the applications list pointers.

Can the slot index be constrained or the storage for mt_io_flags be expande=
d?

drivers/hid/hid-multitouch.c:mt_allocate_report_data() {
    ...
	rdata =3D devm_kzalloc(&td->hdev->dev, sizeof(*rdata), GFP_KERNEL);
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but can this sleep in atomic
context?

If a device sends an unmapped report ID dynamically over the interrupt
endpoint, the URB completion handler runs in atomic context and calls
hid_report_raw_event(), which eventually calls mt_report().

mt_report() then calls mt_find_report_data() and mt_allocate_report_data().
Since devm_kzalloc() is called with GFP_KERNEL here, it could fault when
processing these unmapped reports in atomic context.

Should this use GFP_ATOMIC instead?

drivers/hid/hid-multitouch.c:mt_set_quirks() {
    ...
	list_for_each_entry(application, &td->applications, list) {
    ...
}

drivers/hid/hid-multitouch.c:mt_allocate_application() {
    ...
	list_add_tail(&mt_application->list, &td->applications);
    ...
}

[Severity: Medium]
This is a pre-existing issue, but is there a data race on the
td->applications list?

mt_set_quirks() iterates over td->applications without locking.
Concurrently, if the device receives an unmapped report, mt_report() can
call mt_allocate_application() from the interrupt path, which adds to the
same list using list_add_tail().

Could this concurrent modification without synchronization corrupt the
linked list?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724000958.9386=
75-1-qwe.aldo@gmail.com?part=3D1
