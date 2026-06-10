Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8786037AA8B
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 08:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080856; cv=none; b=k/SnCkO00xBaadruoQcFV5LgTVMdwup6AnGq5jcAmouJalgEw1fMXQNqbM/QNdzZVcVZyS7h81bdQHmUnOnsgJYH93BjfgPv9hC7R5ocqadXAG48QrDRCbQ57FQLIr5A65R3XvOiC5qldbcepsDsjqfFbk4UzdRp5zda/JxiYns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080856; c=relaxed/simple;
	bh=yJc9nP/DjMwFnpl6G7hu8AVjJbbOJlC/cc3ZUFoM7KI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aHNJ+c14sOs/REJ+FDDzscDCDhkk0f6vhV0G662tnG33YFbt0RMA2jFeoLfFrdlulJz2ENW4C2rrYBgqzYwJIO+f4kP1aJ5HNTccsR76hVEkPCgdWcawcrkdqOv+R8cb0dk4Iq6dvGwZZalQELzkpbNmMkPdPzQnDbsM7m0oxh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtNrWiya; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtNrWiya"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E051F00898;
	Wed, 10 Jun 2026 08:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781080855;
	bh=1vMzLbRN68h99Iv5IgBxO6OzBn60tEGz8GHr1An29pY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AtNrWiyaIvpOaviMlTPK7XStc2hqG0j3ngPOE+zrnZ1q5tY9Bc20qPUc77G02FbrV
	 5XmDGpfaL+W+j/eLOEWnfHuY24QzbB6eYFJM4wUGlLA4PxetfbK8o9Y6t2kyffvZ5T
	 6Tz+t9fGz0J0ubtaOdPtVOY5e9QiJV61drXHyqxr1/+vRMuXZvYI1TuCyNYVJBSXNG
	 fodDwUDTI0zCbuLuUa+8veaRdmZ4Xawvaf/64qCJJy9dpJxmbdZhynRnnMAVAikdv0
	 A8y/mfmvi/0e3B5JlPrbmygqDIZbgahI4XLWC8ILfcfjL93OrGhw8hDr9Pf9wAr/mh
	 y1FU6XvSyHkMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] iio: hid-sensor-rotation: Fix stale or zero output
 when reading raw values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhang Lixu" <lixu.zhang@intel.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260610082911.157232-3-lixu.zhang@intel.com>
References: <20260610082911.157232-3-lixu.zhang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 08:40:54 +0000
Message-Id: <20260610084054.F2E051F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Stack Use-After-Free / Memory Corruption via synchronous HID r=
ead
- [High] PM Runtime Usage Counter Underflow due to missing error check
--

commit 4651e39f1dd649401d6eaaef3b3ae792bc120ba0
Author: Zhang Lixu <lixu.zhang@intel.com>

iio: hid-sensor-rotation: Fix stale or zero output when reading raw values

This commit fixes stale or zero output in dev_rot_read_raw by explicitly
powering up the sensor and issuing a synchronous GET_REPORT to receive
the full quaternion data into a local buffer.

> diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/=
orientation/hid-sensor-rotation.c
> index 4a11e45550991..1c6f02374f3ce 100644
> --- a/drivers/iio/orientation/hid-sensor-rotation.c
> +++ b/drivers/iio/orientation/hid-sensor-rotation.c
> @@ -86,6 +86,13 @@ static int dev_rot_read_raw(struct iio_dev *indio_dev,
>  				long mask)
>  {
>  	struct dev_rot_state *rot_state =3D iio_priv(indio_dev);
> +	struct hid_sensor_hub_device *hsdev =3D rot_state->common_attributes.hs=
dev;
> +	struct hid_sensor_hub_attribute_info *info =3D &rot_state->quaternion;
> +	u32 usage_id =3D HID_USAGE_SENSOR_ORIENT_QUATERNION;
> +	union {
> +		s16 val16[4];
> +		s32 val32[4];
> +	} raw_buf;
>  	int ret_type;
>  	int i;
> =20
> @@ -95,8 +102,37 @@ static int dev_rot_read_raw(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		if (size >=3D 4) {
> -			for (i =3D 0; i < 4; ++i)
> -				vals[i] =3D rot_state->scan.sampled_vals[i];
> +			if (info->size <=3D 0 || info->size > sizeof(raw_buf))
> +				return -EINVAL;
> +
> +			hid_sensor_power_state(&rot_state->common_attributes, true);

[Severity: High]
Should the return value of this power-on call be checked?

If hid_sensor_power_state fails, pm_runtime_resume_and_get cleans up its
PM usage count increment, leaving the net usage count unchanged.

Because this error is ignored, the code unconditionally calls
hid_sensor_power_state false later on, which invokes
pm_runtime_put_autosuspend and drops the usage counter by 1.

Does this cause the PM usage counter to underflow when power-on fails?

> +
> +			ret_type =3D sensor_hub_input_attr_read_values(hsdev,
> +								     hsdev->usage,
> +								     usage_id,
> +								     info->report_id,
> +								     SENSOR_HUB_SYNC,
> +								     info->size,
> +								     (u8 *)&raw_buf);

[Severity: Critical]
Can this corrupt the stack if the synchronous read is interrupted?

By passing a pointer to the stack-allocated raw_buf into
sensor_hub_input_attr_read_values, the driver relies on the wait
completing successfully.

If the wait is interrupted by a signal sent to the userspace process,
or if it times out:

drivers/hid/hid-sensor-hub.c:sensor_hub_input_attr_read_values() {
    ...
    cycles =3D wait_for_completion_interruptible_timeout(&hsdev->pending.re=
ady,
                                                       HZ * 5);
    if (cycles =3D=3D 0)
        ret =3D -ETIMEDOUT;
    else if (cycles < 0)
        ret =3D cycles;

    hsdev->pending.status =3D false;
    ...
}

The function locklessly clears hsdev->pending.status and returns, destroying
the raw_buf stack frame.

However, the concurrent HID interrupt handler sensor_hub_raw_event might
have already evaluated hsdev->pending.status as true under the lock, and
could proceed to memcpy into the now-freed stack pointer.

> +
> +			hid_sensor_power_state(&rot_state->common_attributes, false);
> +
> +			if (ret_type < 0)
> +				return ret_type;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610082911.1572=
32-1-lixu.zhang@intel.com?part=3D2
