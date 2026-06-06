Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC80353EF3
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 12:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749144; cv=none; b=Kks5WLPCJepzX2DaRR3HCq5I8Agq0sGFZWLfE+5ryGECFtJL1tuz6wSpMOuuTtkwmr20IavGC3RB9aNwR4gNfmQbTuhpeUWfn+0ty1dcBKaEHv4Uk5hiejTfif1Mq3sAwtVh+q4DQzGv4TOKcT1YsjnZqcf1wNmUJSA8wVtdgXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749144; c=relaxed/simple;
	bh=Q6Q9rZOU+EP7QwHP6rpsS7MjZoteLaDHxj+3yUh6+Ow=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LrD+b016Zt/akwug4s9Bx9+fp334UMaHvo2vu8Og/pykWT4CRMmk56MTyCJikSt5W40eJVorIx8gBjNed+CLQsP9oGVA31eDiUQUm3UxArGGHKCwFN+aYLhUnTduulq8QwtX7NphSVEUkqmeml9tYJBuIatVnDjpCKLsOPAVdbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vkhq2x/z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vkhq2x/z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A2E1F00893;
	Sat,  6 Jun 2026 12:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780749142;
	bh=IL3CKKQ1HsBXieqz1y4bvmqi+IOe/dmcdHeM7qYqcOc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vkhq2x/zEC5H1e+p51LBV46plzp6aCkkKP4iSKLGwLrwuFqJtsOx8h40g0c7qlKjb
	 BzETVUuwTkB6syS6i5YrImElQfPu5uuhuil9gAZ76mEFlhkUT+scmZjUfXvSTqU803
	 Mc8b2f86NziwBxYGWbMO4hNi8935I1s0ayNIKv+uDtoMBz0OK6lZ2IO/SRlWjWfK10
	 sIlctm+D+2kdZd5v596ywOMjJyZHzcHdjegwqYmA0Btl5g0QkI5UZYScUGJuvtecwr
	 J/4dfYYL2A8IRLWZThmgG9Fr/vAmrU/nFfKAv3ZGMJt0GbQARDnEEcgGcC7WVRR6M3
	 XAwvUw1Kp7niQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] iio: pressure: hid-sensor-press: use u32 instead of
 unsigned
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260606-6-june-hid-iio-correct-usage-id-v1-7-dd4a6820b674@gmail.com>
References: <20260606-6-june-hid-iio-correct-usage-id-v1-7-dd4a6820b674@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 12:32:21 +0000
Message-Id: <20260606123222.62A2E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unaligned memory access and out-of-bounds read in `press_capture_s=
ample` due to unconditional pointer cast and ignoring `raw_len`.
- [High] Stale software timestamp reused for all subsequent samples if the =
device lacks hardware timestamps.
--

commit a1f5a54c679fcb699d59de1d79aadcc9a8177858
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: pressure: hid-sensor-press: use u32 instead of unsigned

Prefer 'u32' instead of bare 'unsigned' variable to improve code
clarity and consistency with kernel style.

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

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential problem
with how timestamps are handled in press_proc_event().

When a hardware timestamp isn't provided, the driver generates a software
timestamp:

	if (atomic_read(&press_state->common_attributes.data_ready)) {
		if (!press_state->timestamp)
			press_state->timestamp =3D iio_get_time_ns(indio_dev);

		iio_push_to_buffers_with_ts(indio_dev, &press_state->scan,
					    sizeof(press_state->scan),
					    press_state->timestamp);
	}

Because press_state->timestamp is never cleared back to 0 after pushing the
buffer, will all subsequent samples incorrectly reuse the exact same timest=
amp
instead of generating a new one?

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
This is a pre-existing issue, but could this cause unaligned accesses or
out-of-bounds reads?

Looking at press_capture_sample(), raw_data is cast directly to a pointer
without using the unaligned access helpers:

	case HID_USAGE_SENSOR_ATMOSPHERIC_PRESSURE:
		press_state->scan.press_data =3D *(u32 *)raw_data;
		ret =3D 0;
		break;
	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
		press_state->timestamp =3D hid_sensor_convert_timestamp(
			&press_state->common_attributes, *(s64 *)raw_data);

Since raw_data points into a HID report, it might not be aligned, which cou=
ld
cause undefined behavior on strictly aligned architectures.

Additionally, we're unconditionally reading 4 or 8 bytes here without check=
ing
raw_len. If the HID descriptor specifies a smaller field size, could this r=
ead
past the end of the valid data buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606-6-june-hid=
-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com?part=3D7
