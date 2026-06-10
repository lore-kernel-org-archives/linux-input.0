Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8A244BC91
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106434; cv=none; b=LUd5sDKqdw92eTnq5zXURsKO1oTCOmF+A/BMiznzhPIOtmiWSME1fBxRRioQl+6xOzkoYYGiO8agvqyaEvh024fMbyFhfyjawO8OIks46uPMjAF8ObRXmSsCw4EVHp8MgdNv4PTq412G+qOSHwKHzx4/BJH+ynAF02aXjCpUlPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106434; c=relaxed/simple;
	bh=sXNsQntN4thZ5T3P8RO3Rkvimmifx1N7M+CwQx9nLUc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JhYxJggc0GnNl3OhHeLUsoOx+PWHmqwTPOopy+V0cjebUDL5SAAlPY0G9KZfNkondDk6H7kBchBC4LNb1sI8W65Rn1cEKQ7ZiRh6yktf+a6vIgFMV9RwyYagqol5SK1nZLonzOE1bzksAQtyOgnUy/VsR0NdlaBvw7eOTT+30CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cltKo/KG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cltKo/KG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89271F00898;
	Wed, 10 Jun 2026 15:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106432;
	bh=3m2RecN+7d7DfYA01bRDigu1gnU8IMgbh2lyCv0e4Ik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cltKo/KGuKCHJFDWLmzriAIoz2Lu0lah7Vqu5oWwjaYItZkc9ntZ/ZCunwbdPP2CL
	 vcDLtYP4/RV23TfyzjdmMJhVTstojNqVXBEZTE3HjE5LZk0v9FTpMyX6aBFCjYflJj
	 EA7zEjjJmlYE+DO01Rbc3P53eq+cUCTbxnvuZh3GqsMjbi9G4O23szEHnglVOQAiYv
	 VA7zmL7swwZ0thrYGqXcWFQbDKBfNeKzvs2s3ujAGWtdECA6C0VM9mGWmHTIUSCzlo
	 eLvyO/IuX6Kort1azrq16lM3K27vjNjM9UuEDTK7o+wjBkotNzwSYFkAwxVWYrul9C
	 dtGZScKOcuRbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/7] iio: orientation: hid-sensor-rotation: use u32
 instead of unsigned
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260610-6-june-hid-iio-correct-usage-id-v2-6-c3c5f0720493@gmail.com>
References: <20260610-6-june-hid-iio-correct-usage-id-v2-6-c3c5f0720493@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 15:47:11 +0000
Message-Id: <20260610154711.A89271F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds read and unaligned access in `dev_rot_capture_sample`
- [High] Use-After-Free (UAF) race condition between device removal and raw=
 event processing
--

commit de9f9c2c99851d2c61cb3fce183da2297778f18f
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: orientation: hid-sensor-rotation: use u32 instead of unsigned

Prefer 'u32' instead of bare 'unsigned' for usage_id variable.
This matches expected callback API type and improves code clarity.
No functional change.

> diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/=
orientation/hid-sensor-rotation.c
> index 4a11e45550991..20563d8efaf6c 100644
> --- a/drivers/iio/orientation/hid-sensor-rotation.c
> +++ b/drivers/iio/orientation/hid-sensor-rotation.c

[ ... ]

> @@ -209,7 +209,7 @@ static int dev_rot_proc_event(struct hid_sensor_hub_d=
evice *hsdev,
> =20
>  /* Capture samples in local storage */
>  static int dev_rot_capture_sample(struct hid_sensor_hub_device *hsdev,
> -				unsigned usage_id,
> +				u32 usage_id,
>  				size_t raw_len, char *raw_data,
>  				void *priv)
>  {

[Severity: High]
This isn't a bug introduced by this patch, but does dev_rot_capture_sample()
blindly trust raw_len and raw_data derived from the HID device's report
descriptors?

If a malicious or faulty USB device provides a descriptor with a small repo=
rt
size (e.g., 4 bytes), raw_len / 4 =3D=3D sizeof(s16) evaluates to false. Th=
is
leads the code to execute:

    memcpy(&rot_state->scan.sampled_vals, raw_data,
           sizeof(rot_state->scan.sampled_vals));

Can this read out-of-bounds heap memory which is then pushed to IIO buffers
and leaked to userspace?

Furthermore, for HID_USAGE_SENSOR_TIME_TIMESTAMP, the code directly casts
and dereferences raw_data as a 64-bit integer:

    rot_state->timestamp =3D hid_sensor_convert_timestamp(
                            &rot_state->common_attributes, *(s64 *)raw_data=
);

As HID reports are packed, raw_data can be unaligned. Could this cause a
kernel panic (unaligned access exception) on architectures with strict
alignment requirements?


[Severity: High]
This is also a pre-existing issue, but is there a use-after-free race
condition between device removal and raw event processing?

During removal, hid_dev_rot_remove() calls sensor_hub_remove_callback(),
which deletes the callback from the list using dyn_callback_lock but does
not synchronize with active or concurrent readers:

drivers/hid/hid-sensor-hub.c:sensor_hub_remove_callback() {
    ...
    list_del(&callback->list);
    kfree(callback);
    ...
}

Meanwhile, in sensor_hub_raw_event(), sensor_hub_get_callback() fetches the
callback pointer and drops the lock. The function then continues to invoke
callback->capture_sample() without any locks or reference counting:

drivers/hid/hid-sensor-hub.c:sensor_hub_raw_event() {
    ...
    callback->capture_sample(hsdev, report->field[i]->logical, sz, ptr,
                             callback->pdev);
    ...
}

If device removal completes and devres frees indio_dev and dev_rot_state
before sensor_hub_raw_event() finishes execution on another CPU, will the
event handler dereference a freed function pointer or access the freed driv=
er
state structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610-6-june-hid=
-iio-correct-usage-id-v2-0-c3c5f0720493@gmail.com?part=3D6
