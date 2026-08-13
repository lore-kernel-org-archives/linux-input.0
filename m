Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D336485518
	for <linux-input@vger.kernel.org>; Thu, 13 Aug 2026 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633218; cv=none; b=pWyQ21LRX/GX2TczsLLIDhO/F5JmoUqf2KqSHUm/UvyL6qHpohpEjAeTgM9QWI33m0THciN1UfghkBnkKozw+5K/zRitRZygDwjeB874EAmVN3b60BmQi+m41TjaZcNJq5PMV6Uh9YrK+mPvolDKvPN1qu1tWiT9PnPfIGW7j7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633218; c=relaxed/simple;
	bh=76ellz6rP+n9OAOhG+VkBcIegAVPPzWRS4sUMj7AqYE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X+SNEQZ2IRvNIWGmttC8TkUtn6dmQKhDjf7LlkGTq64umIpNoIoGzxeb0GA5mZLGiitteEH6o18wOf/NBk3rsQIxruHzi0hajyx5poaruz9N4wJz49l+Gh2D7csTF9uhHxDyKh78Qvnz2mnVUdr5hPrQ12qAdRf+QhxF7jIVxfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFLN/djC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFLN/djC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1651F000E9;
	Thu, 13 Aug 2026 15:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786633216;
	bh=RPQXA+y8kitVepk0EslHieIBd2JklU3UTLkxVmQNtD0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CFLN/djCXht6KHEgqzIlwHmAUbq7PZMtVLZH1UoZz4ocAmdBXHFxRv2g6O3HYb4dZ
	 SHSaF9QwaII47MWGnvSrSruk0v9JErr3+PlncS5ZdiEayjpq9FPfyjwUWXmbIxtq6F
	 m2Hld4GEk5zBLKdz/33Y9yH2o0zE9nQ93oX3pcbnkz8LrQO0wGWdZ+VMQuplZO9CAh
	 7snM9bfHLYtPlJ4xHLTRI4AKf5sNxNN34V0iEIdKXIF1lC5F/vClPovH1dbfUxGy+5
	 XdIExlUh4kasBfsUXMf4itoIcN0EGYvMAQYZQy8BJW/Rm6UM+7xR8Ech5aWZ4+0w5/
	 uq5IqW2mDzSEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/12] HID: asus: add support for ROG Ally handhelds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260813144736.2477941-3-denis.benato@linux.dev>
References: <20260813144736.2477941-1-denis.benato@linux.dev>
 <20260813144736.2477941-3-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 15:00:15 +0000
Message-Id: <20260813150015.BC1651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Acquiring a sleeping lock (mutex) inside an atomic context (UR=
B completion handler), causing a 'BUG: scheduling while atomic' kernel pani=
c.
- [High] Missing rollback of global state pointers on probe failure leaves =
dangling pointers in a static global struct.
- [Medium] Hardware packet structures are defined using native types (`uint=
16_t`), breaking portability on Big Endian architectures.
- [Medium] Device fails to resume if the ROG Ally extensions failed to prob=
e.
- [Medium] Missing bounds check before accessing `data[1]` in `ally_x_raw_e=
vent` allows reading stale buffer data.
--

--- Patch [2]: [PATCH 02/12] HID: asus: add support for ROG Ally handhelds =
---
commit 5a6720dc4f3259dca06d1dbb804d6380655462ce
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for ROG Ally handhelds

This commit implements the core functionality for ASUS handhelds, extending
the hid-asus driver to initialize the device, implement Ally X input mappin=
g,
and handle specific AC button events.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 897b04d06b464..f4b2c4a616b75 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
> @@ -232,12 +271,655 @@ static const struct asus_touchpad_info medion_e123=
9t_tp =3D {
[ ... ]
> +struct ally_x_input_report {
> +	uint16_t x, y;
> +	uint16_t rx, ry;
> +	uint16_t z, rz;
> +	uint8_t buttons[3];
> +} __packed;

[Severity: Medium]
Are these values interpreted correctly on big-endian architectures?

Since USB HID payloads natively use little-endian byte ordering, defining
these as native uint16_t and using them without le16_to_cpu() conversion
can corrupt the analog stick values on big-endian systems.

[ ... ]
> +static bool ally_x_raw_event(struct input_dev *input, struct hid_device =
*hdev,
> +			    struct hid_report *report, u8 *data, int size)
> +{
> +	struct ally_x_input_report *in_report;
> +	u8 byte;
> +
> +	if (!input)
> +		return false;
> +
> +	if (size < 1)
> +		return false;
> +
> +	if (data[0] =3D=3D 0x5A) {
> +		input_report_key(input, KEY_PROG1, data[1] =3D=3D 0x38);

[Severity: Medium]
Is it possible for data[1] to read stale memory here?

Since the size check above only ensures the size is at least 1, if the devi=
ce
sends a 1-byte report starting with 0x5A, accessing data[1] will read
out-of-bounds from the previous transfer buffer contents.

[ ... ]
> +static bool hid_asus_ally_raw_event(struct hid_device *hdev, struct ally=
_handheld *ally,
> +			struct hid_report *report, u8 *data, int size)
> +{
> +	struct input_dev *x_input;
> +	struct hid_device *x_hdev;
> +
> +	if (!ally)
> +		return false;
> +
> +	switch (ally_get_endpoint_address(hdev)) {
> +	case HID_ALLY_X_INTF_IN:
> +		scoped_guard(mutex, &ally_data_mutex) {
> +			x_input =3D ally->ally_x_input;
> +			x_hdev =3D ally->ally_x_hdev;
> +		}

[Severity: Critical]
Can this cause a kernel panic due to scheduling while atomic?

The hid_asus_ally_raw_event() function is invoked from the driver's
raw_event callback (asus_raw_event). For USB HID devices, the core HID
subsystem invokes raw_event directly from the URB completion handler which
executes in atomic interrupt context.

Acquiring a sleeping lock like a mutex in atomic context violates kernel
scheduling rules and will trigger an immediate panic.

[ ... ]
> @@ -1399,21 +2101,28 @@ static int __maybe_unused asus_reset_resume(struc=
t hid_device *hdev)
[ ... ]
> +	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
> +		ret =3D hid_asus_ally_reset_resume(hdev, drvdata->rog_ally);
> +		if (ret) {
> +			hid_err(hdev, "Failed to resume ROG Ally HID extensions: %d\n", ret);
> +			return ret;
> +		}
> +	}

[Severity: Medium]
Could this break system resume if the optional extension failed to probe?

If hid_asus_ally_probe() fails during device probe, drvdata->rog_ally is le=
ft
as NULL, but the device continues to operate as a generic HID device.

During system resume, hid_asus_ally_reset_resume() will return -EINVAL when
ally is NULL, which gets propagated here and causes the entire device resume
to fail.

[ ... ]
> @@ -1530,6 +2239,15 @@ static int asus_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
[ ... ]
> +	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
> +		ally =3D hid_asus_ally_probe(hdev);
> +		if (IS_ERR(ally))
> +			hid_err(hdev, "Failed to initialize ROG Ally HID extensions: %ld\n",
> +				PTR_ERR(ally));
> +		else
> +			drvdata->rog_ally =3D ally;
> +	}

[Severity: High]
Might this lead to a use-after-free if probe fails later in this function?

The hid_asus_ally_probe() function populates the statically-allocated global
ally_drvdata struct with pointers to the current device's hdev and
devres-managed input_dev.

If a subsequent step in asus_probe() fails (such as
asus_initialize_reports()), the function jumps to the error path without
calling hid_asus_ally_remove(). The devres cleanup will free the input_dev,
but the global ally_drvdata will retain the dangling pointer. If another
interface successfully probes and triggers ally_resume_work_fn(), it will
dereference the freed pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813144736.2477=
941-1-denis.benato@linux.dev?part=3D2
