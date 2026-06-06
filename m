Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0A037B415
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 12:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748868; cv=none; b=cdxNU1tgcPw7SujCs2LTDUHIjWrAIeo7C0WMGDyuOcvpaEgMquFt/aWIl4FG9CGL0kZ0haBBtxWR1FBNxzqnRcI0nh3z3VX/UQSeXzxikZjX3kZaKMAH7zRgdkLGsX27INcYcCb/geWOCQDQ7lFXKsudEe0htMk7Ims7CxiUn4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748868; c=relaxed/simple;
	bh=a3KCUEgq80xu2OSHbJKXbFjT+5XGmEsjOlAKzmPOS+g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fZtFAF7yTdNnAFw+QWUxVtK1NmkV9tTR30qaE7+2MFmBBRClj2RCJFEkG1QDYD8kmd76YqSTqLSGjePuUSHoiG86BofoHeHQnpclEsWpBKOtrg+sWZflV4/xMwUsKBEPCQo7B+sQWPtFUkKIXD7t/krI2hXZb922hPF45c1IZVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ij6J/4vD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ij6J/4vD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F4E1F00893;
	Sat,  6 Jun 2026 12:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780748866;
	bh=sHaEXry23gMhCGH/w7hegfJAaLEK+HHxEAi3yQJAa3E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ij6J/4vD7ksAajMPBSGn3uDfrg58vn4zNpVG1NewDboZhsBp8wt9iUEUsZKxUBqJA
	 H1YL8w1U+lf0QswJF2jhXynENJ7Pq0VWYN3BnHPhZXTsQ3hVsijHsbUmQzCMXR7T98
	 o8sNswI/oqhYxu30m7/KnDwJZcyznVN9R+sAYWvBCO2Knt7dxvrAPrjVT83wr8oizX
	 CS/2fYHe8nhc3v/5ZxYUue/njozoiTpo0tEVRG+SF+dd4HsjbsIgdQfDoa26b6AsNS
	 fsmzk5+VoR4xh8FG6RtotVS50LJYQFkJTFIV7VXufbtNbq5ubCUaa0m1bRK8ZxjKW4
	 tUgpYr3iTni4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] iio: orientation: hid-sensor-rotation: use u32
 instead of unsigned
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260606-6-june-hid-iio-correct-usage-id-v1-6-dd4a6820b674@gmail.com>
References: <20260606-6-june-hid-iio-correct-usage-id-v1-6-dd4a6820b674@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 12:27:45 +0000
Message-Id: <20260606122746.57F4E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds read and information leak due to unverified raw_len =
in dev_rot_capture_sample().
- [High] Unaligned and endian-unsafe access when parsing HID raw byte strea=
ms.
--

commit 1678aae0ba9cfb6e8824b0811f3f770a159c5a16
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: orientation: hid-sensor-rotation: use u32 instead of unsigned

This commit replaces bare unsigned types with u32 for usage_id parameters
across the HID sensor rotation driver to improve code clarity and
consistency with kernel style.

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
This is a pre-existing issue, but does this function perform unaligned and
endian-unsafe reads?

Looking further down in dev_rot_capture_sample(), when raw_data is accessed:

        if (raw_len / 4 =3D=3D sizeof(s16)) {
            rot_state->scan.sampled_vals[0] =3D ((s16 *)raw_data)[0];
            rot_state->scan.sampled_vals[1] =3D ((s16 *)raw_data)[1];
            rot_state->scan.sampled_vals[2] =3D ((s16 *)raw_data)[2];
            rot_state->scan.sampled_vals[3] =3D ((s16 *)raw_data)[3];

Since raw_data points to a byte array from a tightly packed HID report, it
is not guaranteed to be aligned to a 2-byte boundary. Casting directly to
s16 pointers might cause bus errors or panics on architectures that do not
support unaligned loads.=20

Also, native CPU casts will read garbage values on big-endian architectures=
.=20
Should this use get_unaligned_le16() instead?

[Severity: High]
This isn't a bug introduced by this patch, but can the fallback memcpy=20
result in an out-of-bounds read?

If raw_len is not exactly 8 bytes, the code unconditionally copies 16 bytes:

        } else {
            memcpy(&rot_state->scan.sampled_vals, raw_data,
                   sizeof(rot_state->scan.sampled_vals));
        }

If a malformed or malicious HID descriptor specifies a size smaller than
16 bytes, this would read past the end of the raw_data buffer into adjacent
kernel memory.=20

The copied data could then be pushed to userspace via iio_push_to_buffers(),
potentially creating an information leak.

[Severity: High]
This is a pre-existing issue, but does the timestamp handling also have
bounds checking and alignment issues?

Later in the same function:

    } else if (usage_id =3D=3D HID_USAGE_SENSOR_TIME_TIMESTAMP) {
        rot_state->timestamp =3D hid_sensor_convert_timestamp(
                                    &rot_state->common_attributes,
                                    *(s64 *)raw_data);

The raw_data pointer is cast directly to a 64-bit integer without verifying
that raw_len is at least 8 bytes.=20

Similar to the unaligned reads above, a direct cast to an s64 pointer on an
unaligned buffer could cause bus errors on certain architectures, and it is
also not endian-safe.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606-6-june-hid=
-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com?part=3D6
