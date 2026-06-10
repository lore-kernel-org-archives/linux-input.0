Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC73635CB7B
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106961; cv=none; b=iotLz5yZQO065gRBmrfSfF2LMVod/wARtjXghZWUYWNECsxvrKCFjaBGJ/9XwFVND8lsZumaatiYcZDbIPEvewSMwkhoKtpRwkW/5xliBKAXJDK6JiE8DkzIXZRCD4Gh5/3osEhOBxT0l+FbpWuKzGhJ/46KMg00ul0kVuQ10FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106961; c=relaxed/simple;
	bh=2yBAP+qP58EsyWFkCveevF5QbIRuAZCN+zScrKc3fdc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i38lWkKHuW4qfBrbmmanomWSB2djLp+TXv4MMHRMYVjxg7cCcMYYN/JF06eQaKl86fCJ3NleG0V4Yps95Ip+pNO9FAY3cQchv5cJNWy0liiN88BpjbD+AU/SDtayjJ9bUQtiColxPG8x4YAhB/xAbwK752YtA2vFgZU0zla9lek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLJjvdNx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLJjvdNx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5321C1F00893;
	Wed, 10 Jun 2026 15:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106960;
	bh=vnAdqSWZV1Cf08veNAg9twPKb/BvkGNWUqp0If0hohc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BLJjvdNxRoS4yjbbkqSlwd8wcmnvMCAvr5xa7A+8rMuyTd4j3fHVSOOm7QFn7rHRy
	 0ZFMrQq3WWJHVayb557y8uUSphaaVedHPSf9y2iCc+YuWWOJepECBtgiMaRCt9n4C+
	 HNrNdlAXdPzkT+XtRvJo2lpZFHNcgHs74KDfXQClA0JOS/PmpV1ySrkH0RKvL9bcWk
	 Zn5kG2rLiMg8Q4B1cs+39J7tMy1UIb0a+NcP4aNuMeSBU6c0TEEdR9RgeduHT3TsjW
	 0zhtAttMcQBV+fYTbY2Qs38A6yBnz0ivZhbogcdua6WfTRR5Vq7lV7uWVQ3ZMwiizN
	 AukK1PLegJppA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/7] iio: pressure: hid-sensor-press: use u32 instead
 of unsigned
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260610-6-june-hid-iio-correct-usage-id-v2-7-c3c5f0720493@gmail.com>
References: <20260610-6-june-hid-iio-correct-usage-id-v2-7-c3c5f0720493@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 15:55:59 +0000
Message-Id: <20260610155600.5321C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unsafe casting and blind dereferencing of `raw_data` causes unalig=
ned memory accesses and Endianness data corruption.
- [High] Failure to reset the timestamp variable causes stale timestamps to=
 be pushed continuously.
--

commit e758a7e12e760b133513494eca06c038aeaa377a
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: pressure: hid-sensor-press: use u32 instead of unsigned

This patch changes the usage_id parameter type from unsigned to u32 in
callback functions. This aligns the signature with the expected callback
API and improves code clarity without making functional changes.

> diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressu=
re/hid-sensor-press.c
> index a039b99d9851d..3e47a10d72a89 100644
> --- a/drivers/iio/pressure/hid-sensor-press.c
> +++ b/drivers/iio/pressure/hid-sensor-press.c
> @@ -155,7 +155,7 @@ static const struct iio_info press_info =3D {
> =20
>  /* Callback handler to send event after all samples are received and cap=
tured */
>  static int press_proc_event(struct hid_sensor_hub_device *hsdev,
> -				unsigned usage_id,
> +				u32 usage_id,
>  				void *priv)
>  {
>  	struct iio_dev *indio_dev =3D platform_get_drvdata(priv);

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a pre-existing iss=
ue
with how the timestamp is handled in press_proc_event().

If the timestamp is zero, it gets populated with the current system time:

press_proc_event() {
        ...
        if (atomic_read(&press_state->common_attributes.data_ready)) {
                if (!press_state->timestamp)
                        press_state->timestamp =3D iio_get_time_ns(indio_de=
v);

                iio_push_to_buffers_with_ts(indio_dev, &press_state->scan,
                                            sizeof(press_state->scan),
                                            press_state->timestamp);
        }
        ...
}

However, the driver doesn't seem to reset press_state->timestamp back to ze=
ro
after pushing the buffer. Will this cause the first recorded software times=
tamp
to be continuously reused for all subsequent readings if the hardware does =
not
provide its own timestamp?

[ ... ]

> @@ -176,7 +176,7 @@ static int press_proc_event(struct hid_sensor_hub_dev=
ice *hsdev,
> =20
>  /* Capture samples in local storage */
>  static int press_capture_sample(struct hid_sensor_hub_device *hsdev,
> -				unsigned usage_id,
> +				u32 usage_id,
>  				size_t raw_len, char *raw_data,
>  				void *priv)
>  {

[Severity: High]
This is also a pre-existing issue, but while looking at press_capture_sampl=
e(),
could the direct cast of raw_data cause memory alignment or endianness prob=
lems?

press_capture_sample() {
        ...
        switch (usage_id) {
        case HID_USAGE_SENSOR_ATMOSPHERIC_PRESSURE:
                press_state->scan.press_data =3D *(u32 *)raw_data;
                ret =3D 0;
                break;
        case HID_USAGE_SENSOR_TIME_TIMESTAMP:
                press_state->timestamp =3D hid_sensor_convert_timestamp(
                        &press_state->common_attributes, *(s64 *)raw_data);
                break;
        ...
}

Since raw_data points directly into the packed HID report buffer, which is
unaligned, does directly casting it to a u32 or s64 pointer violate C
alignment rules and risk kernel panics on architectures without unaligned
memory access support?

Additionally, since HID reports are little endian, wouldn't casting directly
on a big endian platform reverse the byte order? For example, if reading a
16-bit field on a big endian system, could this place the actual data into
the upper 16 bits of the u32, resulting in garbage data being sent to
userspace?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610-6-june-hid=
-iio-correct-usage-id-v2-0-c3c5f0720493@gmail.com?part=3D7
