Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4666EFC0A
	for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789570830; cv=none; b=n3WCU6IxFc1lcTzS9ZLX5ojYTpTkhTb9zA8lZak82Ui8LdDKWPWrR2pm+Fm0CikSMyBivOL8rlFy+rtpV7QGS7ESIHQEV8emTxaBY0G2x2hNTT/UB/3jWTEKYcnkAlrM9mYw9UEe1kBdivpKwYj+//fnWil6vmQghw5MNfu4aO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789570830; c=relaxed/simple;
	bh=BQUxHOT1sui2U1JRX9qUkC5V6X565hfD1yJRn3oCZ2U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mPBMSO1Q8w7mWdfAFtVQXYJ2AmqsJS+PngBzUiqaNuTn5B7z4qSk4gx4C9fVFoenUVbtaBzUeqk4lYVRrjBENMMBcqVVB1Pz8vSQt3WEaTzj7K/hVUchR2VmPHuRwabonkrVs37JZd1C0sdUDbElTy5as5NzgD0e481o3QX7TxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xi6si+uk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xi6si+uk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A750F1F000FF;
	Wed, 16 Sep 2026 15:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789570828;
	bh=E8/o1eEyPlow27UsOmJyxN54cOJOiUDQYvkBNmZaTKE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xi6si+uk0coPPpnlXBi6dvl8IlXQD/Q5ptIZtnwPlQo7iJYOn7WyXwGBub/mEWYzG
	 PjIhDHoXQ5bmsiiWxethZKJTHqYqbPvOkIpdCT888S/602B9lho2KxPcI2MyfO0QBh
	 EKMUFZDC5NZ0TdoUzRiFSg7XO5KbcWcpMegIreaEHGCOPWtihLJ/gZ4EZu2O9GxF9b
	 ubDyXVVGfHA51ZYHqg0SZKXGfbYhlf35fVGc8oY/9Ox4+2eJXRcsRN0nQoRNQduYP3
	 /0wlA7Ww53JNNhalQYSxtYq2Q3+eNLzDyO4SDxRNF16tEtAwzbOY1OD0sj1/67AOte
	 5wtEsl7dkHRyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/3] HID: lamparray: add new LampArray helper module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Erhardt" <aer@tuxedocomputers.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260916144838.456239-2-aer@tuxedocomputers.com>
References: <20260916144838.456239-1-aer@tuxedocomputers.com>
 <20260916144838.456239-2-aer@tuxedocomputers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 15:00:28 +0000
Message-Id: <20260916150028.A750F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] hid: lamparray: out-of-bounds access on field->value array
- [Medium] hid: lamparray: mixing goto and scope-based cleanup
- [Medium] hid: lamparray: silent state update failures due to unverified s=
hared reports
- [Medium] hid: lamparray: TOCTOU race in unregister leaves hardware in wro=
ng state
- [Medium] hid: lamparray: error path fails to revert autonomous mode
- [Medium] hid: lamparray: data race on LED class device state
- [Medium] hid: lamparray: initialization race due to early sysfs exposure
- [Low] leds: lamparray: prints success log messages
--

commit dcca692c120b5bda2e0a125483a058dc7b60dad2
Author: Aaron Erhardt <aer@tuxedocomputers.com>

HID: lamparray: add new LampArray helper module

Add a new hid-lamparray helper module that provides basic support for
devices exposing a Lighting/LampArray application collection. It registers a
single-zone RGB LED representation via the LED subsystem.

> diff --git a/drivers/hid/hid-lamparray.c b/drivers/hid/hid-lamparray.c
> --- /dev/null
> +++ b/drivers/hid/hid-lamparray.c

[ ... ]

> +static int lamparray_read_attributes_report(struct lamparray_device *lde=
v)
> +{
> +	struct hid_device *hdev =3D ldev->hdev;
> +	struct hid_report *report;
> +	int ret;
> +	size_t len;
> +
> +	if (!ldev->lamp_count.field) {
> +		hid_warn(hdev, "No LampCount field found\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!ldev->lamparray_kind.field) {
> +		hid_warn(hdev, "No LampArrayKind field found\n");
> +		return -ENODEV;
> +	}
> +
> +	report =3D ldev->lamp_count.field->report;
> +
> +	if (!report) {

[Severity: Medium]
Can lamparray_kind read stale or zeroed memory here? By only fetching the
report associated with lamp_count, the lamparray_kind field may not be
updated if it resides in a different HID report than lamp_count.

> +		hid_warn(hdev, "LampCount field has no report\n");
> +		return -ENODEV;
> +	}

[ ... ]

> +static int lamparray_parse_update_report(struct lamparray_device *ldev)
> +{
> +	struct hid_device *hdev =3D ldev->hdev;
> +	struct hid_report_enum *re;
> +	struct hid_report *report;
> +	struct hid_field *field;
> +	int i, j;
> +	int ret =3D 0;
> +
> +	re =3D &hdev->report_enum[HID_FEATURE_REPORT];
> +
> +	list_for_each_entry(report, &re->report_list, list) {
> +		for (i =3D 0; i < report->maxfield; i++) {
> +			field =3D report->field[i];
> +			if (!field)
> +				continue;
> +
> +			if (!field->usage || !field->maxusage)
> +				continue;
> +
> +			for (j =3D 0; j < field->maxusage; j++) {
> +				u32 usage =3D field->usage[j].hid;

[Severity: High]
Could this loop overflow the field->value array? The loop iterates up to
field->maxusage, storing the loop index in the field_value structs.
However, the field->value array is allocated by the HID core based on
field->report_count. If a crafted HID descriptor specifies a maxusage
larger than report_count, the subsequent reads and writes in
get_field_value() and set_field_value() can overflow the array.

> +				u32 collection_idx =3D field->usage[j].collection_index;
> +				u32 collection_usage =3D hdev->collection[collection_idx].usage;

[ ... ]

> +static int lamparray_hw_set_state(struct lamparray_device *ldev, u8 r, u=
8 g,
> +				  u8 b, u8 intensity)
> +{
> +	struct hid_device *hdev =3D ldev->hdev;
> +	struct hid_report *report;
> +
> +	if (!lamparray_color_fields_is_complete(&ldev->color_update))
> +		return -ENODEV;
> +
> +	if (ldev->range_start.field && ldev->range_end.field) {
> +		set_field_value(&ldev->range_start, 0);
> +		set_field_value(&ldev->range_end, ldev->lamp_count_value - 1);
> +	}
> +
> +	set_field_value(&ldev->color_update.red, r);
> +	set_field_value(&ldev->color_update.green, g);
> +	set_field_value(&ldev->color_update.blue, b);
> +	set_field_value(&ldev->color_update.intensity, intensity);
> +
> +	report =3D ldev->color_update.red.field->report;
> +	hid_hw_request(hdev, report, HID_REQ_SET_REPORT);
> +
> +	return 0;

[Severity: Medium]
Does this drop updates for the other color channels and range fields? If
green, blue, intensity, or the range fields reside in a different report
than the red field, sending only color_update.red.field->report will skip
their updates.

> +}

[ ... ]

> +static int lamparray_restore_state(struct lamparray_device *ldev)
> +{
> +	u8 r, g, b;
> +	int ret;
> +	enum led_brightness brightness;
> +
> +	if (!ldev->use_leds_uapi)
> +		return 0;
> +
> +	guard(mutex)(&ldev->dev_lock);
> +
> +	r =3D ldev->last_r;
> +	g =3D ldev->last_g;
> +	b =3D ldev->last_b;
> +	brightness =3D ldev->last_brightness;
> +
> +	ldev->mc_cdev.subled_info[0].intensity =3D r;
> +	ldev->mc_cdev.subled_info[1].intensity =3D g;
> +	ldev->mc_cdev.subled_info[2].intensity =3D b;
> +	ldev->mc_cdev.led_cdev.brightness =3D brightness;

[Severity: Medium]
Can these updates race with concurrent sysfs writes? Modifying these LED
class device fields without holding the led_cdev->led_access mutex while
the sysfs interface is active can cause inconsistent brightness or color
states if userspace writes to them simultaneously.

> +
> +	/*
> +	 * Quirk for devices ignoring intensity values, see
> +	 * lamparray_led_brightness_set for more information.
> +	 */

[ ... ]

> +static ssize_t use_leds_uapi_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t count)
> +{
> +	struct lamparray_device *ldev =3D lamparray_ldev_from_sysfs_dev(dev);
> +	bool val, old_val;
> +	int ret;
> +
> +	if (!ldev)
> +		return -ENODEV;
> +
> +	ret =3D kstrtobool(buf, &val);
> +	if (ret)
> +		return ret;
> +
> +	/* Make sure only one concurrent write is possible */
> +	guard(mutex)(&ldev->sysfs_lock);
> +	old_val =3D ldev->use_leds_uapi;
> +
> +	if (val =3D=3D old_val)
> +		return count;
> +
> +	ldev->use_leds_uapi =3D val;
> +
> +	/*
> +	 * Take the device out of autonomous mode before exposing the LED
> +	 * class device, and hand it back afterwards, so that control is
> +	 * transferred in both directions rather than only at probe.
> +	 */
> +	if (val =3D=3D 1) {
> +		ret =3D lamparray_hw_set_autonomous(ldev, false);
> +		if (ret)
> +			goto err_revert;

[Severity: Medium]
Does this function mix goto-based error handling with scope-based cleanup?
The cleanup subsystem guidelines request converting all resources to
scope-based cleanup if using __free() or guard(). Mixing the paradigms in
functions like lamparray_register() and use_leds_uapi_store() can create
ownership semantics confusion.

> +		ret =3D lamparray_register_led(ldev);
> +		if (ret) {
> +			lamparray_hw_set_autonomous(ldev, true);
> +			goto err_revert;

[ ... ]

> +struct lamparray *
> +lamparray_register(struct hid_device *hdev,
> +		   const struct lamparray_init_state *led_init_state)
> +{
> +	int ret;
> +	struct lamparray_device *ldev;
> +
> +	if (!hdev)
> +		return ERR_PTR(-ENODEV);
> +
> +	struct lamparray *la __free(kfree) =3D kzalloc_obj(*la, GFP_KERNEL);
> +	if (!la)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ldev =3D &la->ldev;

[ ... ]

> +	ret =3D xa_err(xa_store(&lamparray_by_hdev, (unsigned long)hdev, ldev,
> +			      GFP_KERNEL));
> +	if (ret)
> +		goto err_unregister_led;
> +
> +	ret =3D lamparray_register_sysfs(ldev);
> +	if (ret)
> +		goto err_xa_erase;
> +
> +	ret =3D lamparray_hw_set_autonomous(ldev, false);

[Severity: Medium]
Could exposing the sysfs file before hardware initialization completes
create a race condition? If userspace writes 0 to use_leds_uapi right
after this call, the store handler will unregister the LED and set
autonomous to true. This probe thread then resumes, unconditionally setting
autonomous to false and skipping lamparray_restore_state(), leaving the
device in a broken state.

> +	if (ret) {
> +		hid_err(hdev, "Could not disable autonomous mode: %d", ret);
> +		goto err_remove_sysfs;
> +	}
> +
> +	hid_info(hdev, "LampArray device registered\n");

[Severity: Low]
Should this log message be removed? The LED subsystem guidelines specify
that drivers should only log errors or warnings, avoiding success messages
on probe.

> +
> +	ret =3D lamparray_restore_state(ldev);
> +	if (ret) {
> +		hid_err(hdev, "Failed to set default state: %d", ret);
> +		goto err_remove_sysfs;
> +	}

[Severity: Medium]
Does this error path leave the hardware in a non-autonomous state? If
lamparray_restore_state() fails, the code jumps to err_remove_sysfs and
cleans up software state, but does not revert the device back to autonomous
mode.

> +
> +	return_ptr(la);
> +
> +err_remove_sysfs:
> +	lamparray_remove_sysfs(ldev);
> +err_xa_erase:
> +	xa_erase(&lamparray_by_hdev, (unsigned long)hdev);

[ ... ]

> +void lamparray_unregister(struct lamparray *la)
> +{
> +	struct lamparray_device *ldev;
> +
> +	if (!la)
> +		return;
> +
> +	ldev =3D &la->ldev;
> +
> +	lamparray_hw_set_autonomous(ldev, true);
> +
> +	lamparray_remove_sysfs(ldev);

[Severity: Medium]
Can this sequence permanently leave the hardware in a non-autonomous state?
Calling lamparray_hw_set_autonomous(..., true) before removing the sysfs
interface creates a window where a concurrent sysfs write to use_leds_uapi
can switch the device back to non-autonomous mode right before the device
is completely unregistered.

> +	xa_erase(&lamparray_by_hdev, (unsigned long)ldev->hdev);
> +
> +	mutex_lock(&ldev->sysfs_lock);
> +	lamparray_unregister_led(ldev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916144838.4562=
39-1-aer@tuxedocomputers.com?part=3D1
