Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94815332EAE
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617806; cv=none; b=DXSC5sox3s6btHHgVDdapHMfLRYjWV+kGUwHR6uKfnF+irLYDdRPhqGoaIkzgBjrxjk2r3XmWUyDz8rE2EtXWosfDXcGTbHVCTGbhwPfzjorZLwWP9x5eJNoNRPi0z2D5u01CvEhOHsokDW9wmj4Zby/gfdrO1LLtyHv4YmVyiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617806; c=relaxed/simple;
	bh=zWC0j1boYouZ913gchxNK8SuhUI5aHDLJhb4Bd3D/38=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HwWaLMYlnV9F0WkVI1KGUz6cXYr9S6n3te3CuTuXVdZcJmS43JD+NLBujWvlLGB3vT7U54VsI6PyKxYfAmFuRODgAwUoAjCq1DpoF5z3QvCJaUxcwYXmHov9nuLP16wcgILIWM22kx7l59mj1bpy98wQb+f1aWp8Ds02BkCAI7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAlzZJpq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAlzZJpq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3B61F000E9;
	Tue, 16 Jun 2026 13:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781617805;
	bh=0PVHm3tlKbdmZtZ54cTl8EfUa4I+/+27W5aYNp/JUBs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SAlzZJpqrROAagla3E6zUIMLNOc5yMdJvzus9LAW7g+KfhjGx27yMXmYnieZGmPBG
	 7JqHl9xTqI4X/Gj88AILdRoMALDZYfeiQdgaa9dzwb28h4KopXv2bpaVl1XK0howXN
	 ewWBAn/8qzZSz1DMO15meBozvHx4AZPCp9yYj/LqRtXLyrA2NJrZ6TEgGukkbYk8m0
	 r/oLO0QZghEY9wBBQJrRykhCjdHouXIG8MFiViTA+oOOmE7PI0fll+Jgw+Fa2UBXcl
	 qO3JA4AsULHh2hCQK8lWtVlw3NNstyWXdmdxIgHmzgwkIDRaZ00+QI8vo0hIYlJpp/
	 5qQ6tg6q4ENmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] iio: hid-sensor-humidity: use u32 instead of
 unsigned int
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260616-16-jun-hid-iio-u32-api-type-v1-2-952c74195f46@gmail.com>
References: <20260616-16-jun-hid-iio-u32-api-type-v1-2-952c74195f46@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 13:50:04 +0000
Message-Id: <20260616135005.1A3B61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Directly dereferencing the `raw_data` pointer as an `s32` can caus=
e unaligned access faults on architectures that strictly enforce alignment.
- [High] The driver unconditionally dereferences `raw_data` as a 32-bit int=
eger, ignoring the `raw_len` parameter, leading to potential out-of-bounds =
memory reads and corrupted sensor data.
- [High] The `humidity_callbacks` structure is statically allocated but its=
 `pdev` field is modified during `probe`. If multiple humidity sensors are =
probed, the last probed device overwrites `pdev`, causing callbacks for all=
 instances to be routed to the last bound device's state.
--

commit 90e5b3ef32381e14224dfd5cf7711e2aa3c588a2
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: hid-sensor-humidity: use u32 instead of unsigned int

This commit updates the usage_id parameter type from unsigned int to u32
in callback functions to match the expected API. It is intended to improve
code clarity with no functional changes.

> diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/hum=
idity/hid-sensor-humidity.c
> index be2338d5f4070..c376a247b1372 100644
> --- a/drivers/iio/humidity/hid-sensor-humidity.c
> +++ b/drivers/iio/humidity/hid-sensor-humidity.c

[ ... ]

> @@ -141,7 +141,7 @@ static int humidity_proc_event(struct hid_sensor_hub_=
device *hsdev,
> =20
>  /* Capture samples in local storage */
>  static int humidity_capture_sample(struct hid_sensor_hub_device *hsdev,
> -				unsigned int usage_id, size_t raw_len,
> +				u32 usage_id, size_t raw_len,
>  				char *raw_data, void *pdev)
>  {

[Severity: High]
This is a pre-existing issue, but does casting the raw_data pointer directl=
y to
an s32 pointer cause unaligned access faults on architectures that strictly
enforce alignment?

drivers/iio/humidity/hid-sensor-humidity.c:humidity_capture_sample() {
	switch (usage_id) {
	case HID_USAGE_SENSOR_ATMOSPHERIC_HUMIDITY:
		humid_st->scan.humidity_data =3D *(s32 *)raw_data;
...
}

The raw_data pointer points directly into the packed HID report byte stream,
which may be unaligned.

Could casting it directly to an s32 pointer and dereferencing it trigger
alignment faults on architectures that do not support hardware unaligned
accesses?

[Severity: High]
This is also a pre-existing issue, but does this function unconditionally r=
ead 4
bytes from raw_data, ignoring the raw_len parameter?

drivers/iio/humidity/hid-sensor-humidity.c:humidity_capture_sample() {
	switch (usage_id) {
	case HID_USAGE_SENSOR_ATMOSPHERIC_HUMIDITY:
		humid_st->scan.humidity_data =3D *(s32 *)raw_data;
...
}

By indiscriminately reading 4 bytes, the driver might access out-of-bounds
memory when raw_len is smaller than 4.

Could this trigger memory access faults near page boundaries and leak kernel
heap data to userspace if the upper bits contain adjacent memory garbage?

>  	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> @@ -161,7 +161,7 @@ static int humidity_capture_sample(struct hid_sensor_=
hub_device *hsdev,
>  static int humidity_parse_report(struct platform_device *pdev,
>  				struct hid_sensor_hub_device *hsdev,
>  				struct iio_chan_spec *channels,
> -				unsigned int usage_id,
> +				u32 usage_id,
>  				struct hid_humidity_state *st)
>  {
>  	int ret;

[Severity: High]
This is a pre-existing issue, but does the shared static humidity_callbacks
structure get overwritten during probe?

drivers/iio/humidity/hid-sensor-humidity.c:
static struct hid_sensor_hub_callbacks humidity_callbacks =3D {
	.send_event =3D &humidity_proc_event,
	.capture_sample =3D &humidity_capture_sample,
};

drivers/iio/humidity/hid-sensor-humidity.c:hid_humidity_probe() {
...
	humidity_callbacks.pdev =3D pdev;
...
}

If multiple humidity sensors are probed, the last probed device overwrites =
pdev.

When sensor_hub_raw_event() receives data, it invokes callback->capture_sam=
ple
with the overwritten pdev.

Could this cause platform_get_drvdata(pdev) to return the wrong IIO device,
corrupting its state and dropping data for all previously bound sensors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616-16-jun-hid=
-iio-u32-api-type-v1-0-952c74195f46@gmail.com?part=3D2
