Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A15E43C7C5
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357779; cv=none; b=SGX1GikqKQ/5VIQnwfPe+SEY/36gR9710ZnRTVENBnNB0hEH0TKlN+V5eTwu7I20fuzSW4DfS+vVo94IOoGAklPIrmLMbYcv8M6IpKuk2flt7Y4buDhzIak+voOQUwPmE02IdBWpTeQskr3T8vM9sJcSY9TREJpf8jQxe5HofTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357779; c=relaxed/simple;
	bh=yjpo4vi3LSQjRPtbZiBVmQfkpbi8LiXB5kp3ArVE4hc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YO/J1yfSC55o1axuXc9pzL/IXWUEMdKgeN0s5crfQY7MK/n2LOV+K0Puj9+PhtLmIOIEmlvUcLEMjhgBSbc/Z+sNxwfF5kzw3l+SIwmWvHnCKjnTHIifhyz6Joz9LYi5+OCZ6Mk0sS5tDj745W5rzEdjctai0nFkbJvPgzp0PGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R65ibU8h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R65ibU8h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8FF1F000E9;
	Wed,  2 Sep 2026 14:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788357777;
	bh=VwAX5U0APo1PxbE0yE7dhF+EBkn/hH2XzHmQodHqsSo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R65ibU8hXslI+tN30B0ub6b7MGLw8Wyw0SqIG8TVv89vdPEzcJvLHYGXQIlC5Onbh
	 aC9Q9wbcEAH+XQZhK+3f0YXtrO24nB0oSgxMRQdsqTBSPUjoVGlvMTwBI3gHOoGwXz
	 AUghRschyhZiU4ckqx48byhhyjW0dI6HoXYFRSnm2NzAVV9oXPuSAQtxGJQBXYpADP
	 sGAn7pOUv7YFwwHS+tZpRi6ck881w9fuygyk6NhLtTjXQWFh4l7Nthi5zV6UuUzACM
	 g6Pfz8qIx21h1fFESuJgqXIfomeZSeZn7zPdEKGJhlN8WyUx43GDTzK7Chk4H8C50B
	 KjDudsKj+I+ZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] HID: amd_sfh: Add HPD support for new AMD SOC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Basavaraj Natikar" <Basavaraj.Natikar@amd.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260902134431.3146117-4-Basavaraj.Natikar@amd.com>
References: <20260902134431.3146117-1-Basavaraj.Natikar@amd.com>
 <20260902134431.3146117-4-Basavaraj.Natikar@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 14:02:57 +0000
Message-Id: <20260902140257.7B8FF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Kernel stack memory is leaked to userspace due to uninitialized st=
ack variables being copied to the HID input report buffer.
--

commit fbf2d0c98746dffa45a715c975a05e57c0b3b3fb
Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

HID: amd_sfh: Add HPD support for new AMD SOC

This commit adds Human Presence Detection (HPD) support for new AMD SOCs.
It updates the driver to use HPD data from DRAM instead of reading from the
C2P4 register path on newer hardware versions.

> diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c b/drivers/hid/=
amd-sfh-hid/sfh1_1/amd_sfh_desc.c
> index c8916afefa626..b81a97dbb1b01 100644
> --- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
> +++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
> @@ -187,6 +187,7 @@ static u8 get_input_rep(u8 current_index, int sensor_=
idx, int report_id,
>  	struct sfh_gyro_data gyro_data;
>  	struct sfh_mag_data mag_data;
>  	struct sfh_als_data als_data;
> +	struct sfh_hpd_data hpd_data;
>  	struct hpd_status hpdstatus;
>  	struct sfh_base_info binfo;
>  	void __iomem *sensoraddr;

[Severity: High]
This is a pre-existing issue, but do these struct definitions leave
uninitialized stack memory that gets leaked to userspace?

In get_input_rep(), structures like acc_input and als_input are allocated on
the kernel stack without explicit initialization.

For ACCEL_IDX, the in_accel_shake_detection field in acc_input appears to
never be initialized before copying it to the report buffer:

	case ACCEL_IDX:
		...
		acc_input.in_accel_z_value =3D amd_sfh_float_to_int(accel_data.acceldata.=
z) / 100;
		memcpy(input_report, &acc_input, sizeof(acc_input));

Similarly for ALS_IDX, light_color_temp, chromaticity_x_value, and
chromaticity_y_value are only initialized conditionally, which can leave
those bytes uninitialized before being copied:

	case ALS_IDX:
		...
		if (binfo.sbase.s_prop[ALS_IDX].sf.feat & 0x2) {
			als_input.light_color_temp =3D als_data.light_color_temp;
			als_input.chromaticity_x_value =3D
				amd_sfh_float_to_int(als_data.chromaticity_x);
			als_input.chromaticity_y_value =3D
				amd_sfh_float_to_int(als_data.chromaticity_y);
		}

		report_size =3D sizeof(als_input);
		memcpy(input_report, &als_input, sizeof(als_input));

Since input_report is subsequently sent to userspace by the HID core, does
this expose uninitialized kernel stack memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902134431.3146=
117-1-Basavaraj.Natikar@amd.com?part=3D3
