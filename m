Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8EB43E4AB
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106678; cv=none; b=en2aP9S7o1DGSPbYBKE9n/bgWCyLr5rj7CxEOsxPjHl09DCiHootIz+1OGrnex2AzW9HtPXSFkVk/pigNuTCRU141LvulXZjZlTv3f9z6JJgp3azaBEcUeFsW9Iw+p3v4tJwzmehEvr1cUDqOgIpvugsZGsH6ztb9Fl2ZART2Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106678; c=relaxed/simple;
	bh=5ZD6eDpx8cAR5QKfrm4mFFTy1GvL0Af5UXwpMQdmKko=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AX8S4wA5G33GYmVGdUBHsdYVkxH966fMD9k1m2zXcSO/MwmXjt/ESYvZao4LKfXVsEMYFm+8pgSct1Q5Jcg5tAApQwtW9KKS8r7cO6w1UvqegYkFAPYwx+okp/jss3lcVvMU/ERtqXjMeWBwP/OvO44CsGSaVuWuShcZ5UaRBik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaL1OlmS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaL1OlmS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4741A1F00893;
	Wed, 10 Jun 2026 15:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106675;
	bh=QHz93dCUCEkCHTNlfUNSH7+4379gm9+IyEtecZwASsA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UaL1OlmS9ycXROkgXHzm0xFwrkW//KKooNgfZZqeg6A+zxzfH2QBKrHcnFnYKHSP4
	 AVy9NSGgU6Ah/k+qO2zkTb2YgB+HJZakEXwUE14/Ipcz0A8rd8mdyaOfG5GS0zVbCc
	 amjdpqwDkdwJ67O5f2V0963PrFwXqXDyrbIFwP6dqFNaTqt3mx/lAbvQqJvsBIjnwu
	 DEdjbM98N7l8I0RGa7twG1Eu8tMSkNbo4R20YwEOhSa28lGh2UJN9knDFn+4zmoP1v
	 X8gD0cCmyFVdk0qtfaEj8aSnQlrAAJL8wPNQSZfSeuI5peI6FD41blGYMUwK/AROO+
	 qwALlM9ywDaxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/7] iio: orientation: hid-sensor-incl-3d: use u32
 instead of unsigned
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260610-6-june-hid-iio-correct-usage-id-v2-5-c3c5f0720493@gmail.com>
References: <20260610-6-june-hid-iio-correct-usage-id-v2-5-c3c5f0720493@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 15:51:14 +0000
Message-Id: <20260610155115.4741A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional pointer casts in `incl_3d_capture_sample` cause unal=
igned memory access, endianness mismatch, and out-of-bounds field reads.
--

commit ffa9a4c020f23415f0ba3c3eae4063a4d5e16403
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>
iio: orientation: hid-sensor-incl-3d: use u32 instead of unsigned

This commit replaces the bare 'unsigned' type with 'u32' for the usage_id
variable in several callback handlers. This change aligns the code with the
expected callback API types and improves clarity. There are no functional
changes introduced by this patch.

> diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/o=
rientation/hid-sensor-incl-3d.c
> index 4e23a598a3fb9..c7fbff498be7a 100644
> --- a/drivers/iio/orientation/hid-sensor-incl-3d.c
> +++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
[ ... ]
>  /* Capture samples in local storage */
>  static int incl_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
> -				unsigned usage_id,
> +				u32 usage_id,
>  				size_t raw_len, char *raw_data,
>  				void *priv)
>  {

[Severity: High]
This is a pre-existing issue, but while reviewing this signature update I
noticed a potential memory access problem.

Looking further down in incl_3d_capture_sample(), raw_data is directly cast
and dereferenced:

	switch (usage_id) {
	case HID_USAGE_SENSOR_ORIENT_TILT_X:
		incl_state->scan.incl_val[CHANNEL_SCAN_INDEX_X] =3D *(u32 *)raw_data;

And for timestamps:

	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
		incl_state->timestamp =3D
			hid_sensor_convert_timestamp(&incl_state->common_attributes,
						     *(s64 *)raw_data);

Can this direct pointer casting trigger unaligned memory access exceptions =
on
architectures that do not natively support them?

Additionally, since HID report data is explicitly little-endian, does casti=
ng
the byte stream to a native u32 or s64 pointer cause it to read reversed
bytes on big-endian architectures?

Finally, the callback does not appear to check the raw_len parameter. If the
HID field is 16-bit or a 32-bit timestamp, will the unconditional 32-bit or
64-bit dereference fetch adjacent HID fields or uninitialized buffer paddin=
g,
potentially corrupting the reported sensor value?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610-6-june-hid=
-iio-correct-usage-id-v2-0-c3c5f0720493@gmail.com?part=3D5
