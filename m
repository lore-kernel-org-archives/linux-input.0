Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9474D3ACF1B
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 08:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080730; cv=none; b=NtX43d0Pgg0rj+eDEP7wvRVqOQo0D6A7HYRVvfvDniil1d6HsZdmVCjQJA9AHBEZ1IyIq1gPHlKnUyPTwrJmCvnNL1W0sIj6B5chWbbWhNuA6dOcF9/3Vz4Xfo1w6xyAaC+jMhlMJNgC9F32uaGFfd6I8JO++hXFDrGh4AzIH4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080730; c=relaxed/simple;
	bh=KTegAyMUDqiIQmgB1iGwagradOHuRTRvVTZy43IeWZ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WBCl2bVAUvWNnhi0lOqRNKpbhuGSnBYF85L4PBBM1vpL/QCkXMgL0zxKRVbh/xGk7n0Pp4auwCLn735YVK01n1OS72FE+7wJXYxS8bY3TH9BiigYfEVK6/c9JEh4IuI/pc/MMGnbT8YJZrgdoEUjLd59P+XCCsLdH5a/04PtKvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0WKpqOn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0WKpqOn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067A11F00893;
	Wed, 10 Jun 2026 08:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781080729;
	bh=S7sMQ1hkGluWVMy9jAVNfpUCpvU0nFk4aJglP7jhJQI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l0WKpqOnYcxB/kniIx2xvq28tLzpcGWI848XM9Bxf1zVH8+RwtS6cc+NAs9jw1cso
	 ySo9scUhMX3HMKwotUMwwXc25Ckp4mAyRK6sIcHZ3u0abeXgpUuL7oFJC5o5GFq1v4
	 3TtTWMh0O5Hc7zSzVjMWpU7DT+g/kVtNqdyMvFrTpP3pAnlnySsmzUjzbB6Ryck3Il
	 h9gyH/2R4Q8PUAGHMLFCcB7DITFIA7+yIN9KAZgmgpUQ6nap3AfgLjH719vpDWqh/C
	 ZqLytTk3AzJ5sTDkFH9088yfkdvZlxRtIGUpicd2ZD+SIcrhohTu64rCvclMw5eFR4
	 gdVGrTI8w9xnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] HID: sensor-hub: Add
 sensor_hub_input_attr_read_values() for multi-byte reads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhang Lixu" <lixu.zhang@intel.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260610082911.157232-2-lixu.zhang@intel.com>
References: <20260610082911.157232-2-lixu.zhang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 08:38:48 +0000
Message-Id: <20260610083849.067A11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Missing spinlock acquisition in the timeout/abort path of `sen=
sor_hub_input_attr_read_values` leads to race conditions, use-after-free, a=
nd stack memory corruption.

Pre-existing issues:
- [High] Reading past the end of short HID reports exposes uninitialized ke=
rnel heap memory.
- [High] Repeated field matches in `sensor_hub_raw_event()` cause uncontrol=
led `kmemdup()` allocations, leaking memory.
--

commit b3186306e6632f94df0275d5e172210ae3044b54
Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

HID: sensor-hub: Add sensor_hub_input_attr_read_values() for multi-byte rea=
ds

This commit introduces sensor_hub_input_attr_read_values() to allow
multi-byte reads for sensors reporting data larger than 32 bits. It
uses a caller-provided buffer to accumulate incoming data in
sensor_hub_raw_event() until the buffer is full.

> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c

[ ... ]

> +	if (flag =3D=3D SENSOR_HUB_SYNC) {
> +		cycles =3D wait_for_completion_interruptible_timeout(&hsdev->pending.r=
eady,
> +								   HZ * 5);
> +		if (cycles =3D=3D 0)
> +			ret =3D -ETIMEDOUT;
> +		else if (cycles < 0)
> +			ret =3D cycles;
> +
> +		hsdev->pending.status =3D false;

[Severity: Critical]
Does setting this status flag without acquiring the data->lock introduce a
race condition?

If wait_for_completion_interruptible_timeout() times out or is interrupted,
this locklessly sets hsdev->pending.status =3D false and returns. Concurren=
tly,
the interrupt handler sensor_hub_raw_event() might have already observed
status as true and could be mid-copy into the caller-provided buffer.

Returning early would invalidate the caller-provided buffer, and the
interrupt handler might subsequently overwrite the destroyed stack frame.

> +	}
> +	mutex_unlock(hsdev->mutex_ptr);
> +
> +	return ret;
> +}

[ ... ]

> @@ -518,12 +568,27 @@ static int sensor_hub_raw_event(struct hid_device *=
hdev,
>  					      hsdev->pending.attr_usage_id =3D=3D
>  					      report->field[i]->logical)) {
>  			hid_dbg(hdev, "data was pending ...\n");
> -			hsdev->pending.raw_data =3D kmemdup(ptr, sz, GFP_ATOMIC);
> -			if (hsdev->pending.raw_data)
> -				hsdev->pending.raw_size =3D sz;
> -			else
> -				hsdev->pending.raw_size =3D 0;
> -			complete(&hsdev->pending.ready);
> +			if (hsdev->pending.max_raw_size) {
> +				if (hsdev->pending.index < hsdev->pending.max_raw_size) {
> +					avail =3D hsdev->pending.max_raw_size - hsdev->pending.index;
> +					copy_size =3D clamp(sz, 0U, avail);
> +
> +					memcpy(hsdev->pending.raw_data + hsdev->pending.index,
> +					       ptr, copy_size);

[Severity: Critical]
As mentioned above, if sensor_hub_input_attr_read_values() aborts early,
could this memcpy() write into an invalidated stack buffer?

> +					hsdev->pending.index +=3D copy_size;
> +					if (hsdev->pending.index >=3D hsdev->pending.max_raw_size) {
> +						hsdev->pending.raw_size =3D hsdev->pending.index;
> +						complete(&hsdev->pending.ready);
> +					}
> +				}
> +			} else {
> +				hsdev->pending.raw_data =3D kmemdup(ptr, sz, GFP_ATOMIC);

[Severity: High]
This is a pre-existing issue, but does this allocation leak memory if a
crafted HID report contains multiple duplicate fields matching the
requested usage?

If the device rapidly spams events while a reader is waiting, each match
could trigger a new kmemdup, overwriting the hsdev->pending.raw_data
pointer and permanently leaking the previously allocated blocks.

> +				if (hsdev->pending.raw_data)
> +					hsdev->pending.raw_size =3D sz;
> +				else
> +					hsdev->pending.raw_size =3D 0;
> +				complete(&hsdev->pending.ready);
> +			}
>  		}
>  		if (callback->capture_sample) {
>  			if (report->field[i]->logical)

[Severity: High]
This is a pre-existing issue, but does the loop advancing ptr expose
uninitialized heap memory on short reports?

Looking at the loop in sensor_hub_raw_event():

	for (i =3D 0; i < report->maxfield; ++i) {
		...
		sz =3D (report->field[i]->report_size *
					report->field[i]->report_count)/8;
		...
		ptr +=3D sz;
	}

The pointer is unconditionally advanced by the expected sizes defined in
the report descriptor. Since sensor_hub_raw_event() ignores the actual
size argument representing the received packet length, a maliciously
short packet could cause the driver to read past the initialized packet
bounds.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610082911.1572=
32-1-lixu.zhang@intel.com?part=3D1
