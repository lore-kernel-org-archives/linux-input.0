Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F03481652
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 15:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106364; cv=none; b=dqYLTcYEpsaPN17sRVKFeYr6kWjxDva99GlGVfxLtuJN3S3W2jBPRzL2PnZWCAqu2aMGpfROuaP5vqS5giz8RuFzM/PZUem+fq1KtISF/B+ySVCaJuyEQBLxMe0P/ABveW1cXu72Q75E7Bfsc29n8IukkqcmUNp4TcIneKeO4/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106364; c=relaxed/simple;
	bh=fBk9uFYh8+w3VgD879V5Vs9oWPVYotdn/VuJ6l92nRs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hoGDlI+MFbjf6hbBC94sfQYg8ItSCf6CwU6/JHgL28NkKpxqQXewsdeQfxpy//5ifbK67AabCLfWMlDCUYNVHmob3QA0xAGgQtUTbsILddi/1blNzDnJCPR7stzO7gVXt6Gza4MAKJlbLJW6an88ysIWlezPqOnyrR2jxXXW7vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgWd5/6S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgWd5/6S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC281F00893;
	Wed, 10 Jun 2026 15:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106363;
	bh=qEaJuqPvqpnri2PayP0Ur9AfA+2zBX5mirDvh3ztEPQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lgWd5/6STm8y8nFD3ya15Oh1sZ/SCTHDLII7/rDdc/sYaRlDyxqsdlU6Fa3P/xpzR
	 3HfVUFJLuHGpmBINLRHu5PhgazciUx70vfQyWwdz99tJsIm4p1LMTCTMm+XhS+j4IR
	 htRCaUzQWmM1cHpfbfrYGPBY8luFa+xVt78TwSZlfyq3km6DvnkOGShzJw0Un3Ze3J
	 +Gypc/nGCBSdI6m+Rr2ju3URGmFlYQyQWWGRqyHvvMZVmhMnU9oFnGgLJRiRbQtkIb
	 sqbtITwvyr4gSNwTfV70a7d1ZMgiH/s+E3M+NTzMmj2S4apsWZGsWCbJJKeFLQEQfO
	 TqLSR7RU7G9AQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/7] iio: accel: hid-sensor-accel-3d: use u32 instead
 of unsigned
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260610-6-june-hid-iio-correct-usage-id-v2-2-c3c5f0720493@gmail.com>
References: <20260610-6-june-hid-iio-correct-usage-id-v2-2-c3c5f0720493@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 15:46:02 +0000
Message-Id: <20260610154602.8BC281F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds read and unaligned access in capture_sample callbacks
--

commit 4cc56ddc040c8b55845a800e3ad9e90ea9d698c9
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: accel: hid-sensor-accel-3d: use u32 instead of unsigned

This patch changes the usage_id parameter type from unsigned to u32 in
hid-sensor-accel-3d callbacks to match the expected API type.

> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/=
hid-sensor-accel-3d.c
> index 2bf05ab5235ef..42c4259bf2094 100644
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
[ ... ]
> @@ -247,7 +247,7 @@ static int accel_3d_proc_event(struct hid_sensor_hub_=
device *hsdev,
> =20
>  /* Capture samples in local storage */
>  static int accel_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
> -				unsigned usage_id,
> +				u32 usage_id,
>  				size_t raw_len, char *raw_data,
>  				void *priv)
>  {

[Severity: High]
This is a pre-existing issue, but since we are looking at the signature of
accel_3d_capture_sample(), is there a risk of an out-of-bounds read or
unaligned access when dereferencing raw_data?

Further down in accel_3d_capture_sample(), raw_data is unconditionally
cast and dereferenced without verifying raw_len:

	switch (usage_id) {
	case HID_USAGE_SENSOR_ACCEL_X_AXIS:
	case HID_USAGE_SENSOR_ACCEL_Y_AXIS:
	case HID_USAGE_SENSOR_ACCEL_Z_AXIS:
		offset =3D usage_id - HID_USAGE_SENSOR_ACCEL_X_AXIS;
		accel_state->scan.accel_val[CHANNEL_SCAN_INDEX_X + offset] =3D
						*(u32 *)raw_data;
		ret =3D 0;
	break;
	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
		accel_state->timestamp =3D
			hid_sensor_convert_timestamp(
					&accel_state->common_attributes,
					*(int64_t *)raw_data);

Could a malicious or non-compliant HID device provide a report descriptor
with a smaller size (e.g., 1 byte) for these usages, causing the dereference
to read up to 7 bytes past the end of the allocated report buffer?

Also, since raw_data is a byte pointer originating from the HID core, could
casting it directly to u32* or int64_t* trigger an unaligned access excepti=
on
on architectures that do not support unaligned memory access?

Does this same pattern need to be addressed in gyro_3d_capture_sample()
within drivers/iio/gyro/hid-sensor-gyro-3d.c? It appears to perform the
same unconditional casts to u32* and s64* on raw_data.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610-6-june-hid=
-iio-correct-usage-id-v2-0-c3c5f0720493@gmail.com?part=3D2
