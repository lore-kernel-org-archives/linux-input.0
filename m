Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8365E431E68
	for <linux-input@vger.kernel.org>; Thu,  2 Jul 2026 10:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782986737; cv=none; b=KPlBcaHwb6lqUKLNnQb8b4Ro8nf5rBghWoVlbsxf7RB0YrcgAbMTMW7mFAP9y67vwyBbfw81WkoEy88nVhtLPC7nOjCJQBlbwEDQWSd+fzTTZKlKhDkA2G1cDMOHtbfuwzSnnOfaV44U7ketAWUWYzsS2E+eqvv+uyzJQJAaXcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782986737; c=relaxed/simple;
	bh=k9hBirh/m23DSUkyLnZIgNgWZpD1N0kIN94Y0D7EA3I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tTwG0z+KorvRTtAbjZPIDWlEE6xTTHhugBvvLz19s7tCBa7OFp2KQPWiMTBwz98y4Km3CSnRYvILd+nYzf28CRCxPtPeg+ZC+SwLLa/4OrvhdhS2H1nXjcyGvDSXVrinXTLZoXiM8VYqq6vZ1uxqz94MWAbBriVJJdnRnl+kUOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJSn4IpX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJSn4IpX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF47D1F000E9;
	Thu,  2 Jul 2026 10:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782986736;
	bh=a9QGVM4SqAm1s8bdDWH3avUHugchJxi8IIWXMZOvk7g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jJSn4IpXiVApH2mLanWe3gQkT3hC21WcD1669nNuugAbQeRvHrXc/s05DADTuPBYv
	 HDQU1NjkyjE1bmbldtkhlkCSzl7z15CK4GRw0CAe7wzbtkAPTriM7gcLPRDJv8lQYU
	 0/fTAkgVJnkP2IsBbQjJ/D2s+0KJmJUSBcqU3FnyFIpJi8SiwZYmxYBOzAsM+mL93p
	 Y2dgkkVTlDeAmJbUDuSneTT3no3RIQzULpTTjdDr/t7h1g/0wVybNae/OccdiGGJJ6
	 vYH+ptHEn2aujr8TyKeEzqPDM3rgh907ONpLW1zDL1PUGLudFxpKUix6pjdYbIcJt0
	 nJWMVHlalbBcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] HID: sensor: custom: Remove enable_sensor before
 freeing fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haoxiang Li" <haoxiang_li2024@163.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260702094856.1105555-2-haoxiang_li2024@163.com>
References: <20260702094856.1105555-1-haoxiang_li2024@163.com>
 <20260702094856.1105555-2-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 10:05:35 +0000
Message-Id: <20260702100535.DF47D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Out-of-bounds array access in `show_value()` and `store_value(=
)` due to flawed sysfs attribute index parsing.
- [High] A race condition in `hid_sensor_custom_remove()` allows incoming s=
ensor events to trigger a Use-After-Free.
- [High] Using `devm_kzalloc` for the driver context linked to a `miscdevic=
e` causes a Use-After-Free if the device is unbound while the file is open.
- [Medium] Concurrent reads on the `miscdevice` corrupt the `kfifo` state, =
leading to broken data streams.
--

commit a7339c2fa4bb12ea6bad0a949e3b22ab6d1f4ed6
Author: Haoxiang Li <haoxiang_li2024@163.com>

HID: sensor: custom: Remove enable_sensor before freeing fields

enable_sensor_store() can call set_power_report_state(), which
dereferences sensor_inst->power_state and sensor_inst->report_state.
These pointers refer to entries in sensor_inst->fields.

hid_sensor_custom_remove() currently frees the field attributes before
removing the enable_sensor sysfs attribute, leaving a window where a
concurrent sysfs write can dereference freed memory.

Remove enable_sensor before freeing the field attributes.

Fixes: 4a7de0519df5 ("HID: sensor: Custom and Generic sensor support")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-cus=
tom.c
> index afffea8940214..d7bdbae96b501 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -1042,9 +1042,9 @@ static void hid_sensor_custom_remove(struct platfor=
m_device *pdev)
>  	}
> =20
>  	hid_sensor_custom_dev_if_remove(sensor_inst);
> -	hid_sensor_custom_remove_attributes(sensor_inst);
>  	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
>  			   &enable_sensor_attr_group);
> +	hid_sensor_custom_remove_attributes(sensor_inst);
>  	sensor_hub_remove_callback(hsdev, hsdev->usage);

[Severity: High]
This is a pre-existing issue, but does freeing the kfifo resource before
unregistering the interrupt-driven callback leave a window for a
use-after-free?

If hid_sensor_custom_dev_if_remove() frees sensor_inst->data_fifo, and an
incoming hardware event occurs before sensor_hub_remove_callback() is calle=
d,
could an open file descriptor trigger hid_sensor_capture_sample() to write =
to
the freed kfifo?

drivers/hid/hid-sensor-custom.c:hid_sensor_capture_sample() {
    ...
    if (kfifo_avail(&sensor_inst->data_fifo) >=3D required_size) {
        kfifo_in(&sensor_inst->data_fifo, ...);
    ...
}

>  }

[Severity: High]
This isn't a bug introduced by this patch, but it appears using devm_kzallo=
c()
for the driver context linked to a miscdevice might cause a use-after-free.

If the device is unbound (e.g., via USB unplug), devres frees sensor_inst.
However, if a user process holds the miscdevice file descriptor open, is it
possible for a subsequent call to read() to extract and dereference the fre=
ed
pointer?

drivers/hid/hid-sensor-custom.c:hid_sensor_custom_read() {
    sensor_inst =3D container_of(file->private_data, struct hid_sensor_cust=
om, custom_dev);
    ...
    if (kfifo_is_empty(&sensor_inst->data_fifo)) {
    ...
}

[Severity: Critical]
This is a pre-existing issue, but we might have an out-of-bounds array acce=
ss
when parsing the attribute name for an index.

In hid_sensor_custom_add_field(), the raw HID loop index is baked into the
sysfs filename:

drivers/hid/hid-sensor-custom.c:hid_sensor_custom_add_field() {
    ...
    snprintf(sensor_field->group_name, sizeof(sensor_field->group_name),
             "input-%x-%x", sensor_field->attribute.index,
             sensor_field->attribute.attrib_id);
    ...
}

If fields are skipped and the array is reallocated to a smaller size, would=
 a
user reading the sysfs file trigger an out-of-bounds access in show_value(),
given it uses the raw index directly from the filename?

drivers/hid/hid-sensor-custom.c:show_value() {
    ...
    if (sscanf(attr->attr.name, "input-%x-%x-%s", &index, &usage, name) =3D=
=3D 3) {
        ...
        field_index =3D index;
        ...
        attribute =3D &sensor_inst->fields[field_index].attribute;
    ...
}

[Severity: Medium]
This isn't a bug introduced by this patch, but can concurrent readers corru=
pt
the internal indices by invoking the kfifo consumer API without serializati=
on?

While open() prevents multiple independent opens, a process can fork() or
spawn threads to invoke read() concurrently on the same file descriptor.

Since hid_sensor_custom_read() does not use a mutex around kfifo_to_user(),
will racing threads corrupt the kfifo state?

drivers/hid/hid-sensor-custom.c:hid_sensor_custom_read() {
    ...
    ret =3D kfifo_to_user(&sensor_inst->data_fifo, buf, count, &copied);
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702094856.1105=
555-1-haoxiang_li2024@163.com?part=3D1
