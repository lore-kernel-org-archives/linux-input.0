Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208CA30EF7E;
	Sun, 13 Sep 2026 03:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789271658; cv=none; b=sT/K5tAJbGTzchuVDQ6AXcYygDq3HaaNpF9R6SSLBHcRHvGTRd2R/1wLQonK9E47Znt25mieo2E/85Rqt2ZdBNgWyGPjAwotps28NNEh2P/duv9QEFoqwzFVDzlSfzoxlr03QTtbsiJ3Vhto7rO65JlJi1pK4t5YO91vgLhHO7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789271658; c=relaxed/simple;
	bh=hnW9h2k6WrTvGVi83jxnUcjlHWPRQE+yzC2Wt+wEBaY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dYjx+U1kYOCngk0hX7zHYWf4xZfxbyif41LImktAPCHI3SRcy0NaQ6kG2IOYs1+OWIBBl5ywyHCNdV0WwWJUxdvJ17K7TY+8lVzHdwQUn9u8Dbn5pIvg9opytNk4mjCBnKqrWXdkzpQNrOLrIyoQTjh9yv/ArfWChNPPraPqre0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJnEJPon; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJnEJPon"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8B71F000FF;
	Sun, 13 Sep 2026 03:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789271656;
	bh=b+6rjl68l0vy/kGHJbA4EyT/VxNsxrCEZLVgXdt94t0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hJnEJPonGvD7dJSzi6ear6QZJD4itSS15lPOnajtQpNML5g6sTFozK03xNiogDUkF
	 kg6VxPMxhqDHjz1zjbXYbMZaRuteGh1ObX+fZzMPP5ypj5E+IgT3Dxe36jvTaHE/H0
	 esWWWN4cDW843rQRDNofwcmaWUBAkAf1UFOtd+T4CLxy3H+SpMUV2fCq5rmvX0NyZK
	 hOqDVXr6DxrN+/3vS4rSUiiH6zgpybHtsVdXGUp2bvgBOCizd6f3B744RtjLAMXHEl
	 guJQZ0YQPTOBxAlUr9NWhs6ew0HyOGmIZohelvckuvJg9eJHB9TOVbzEuyqaWbFJFJ
	 gmoL6gaKeY5AQ==
Date: Sun, 13 Sep 2026 04:54:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yibo Tan <lhfff@tju.edu.cn>
Cc: Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Benjamin Tissoires
 <bentiss@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, Zhang
 Lixu <lixu.zhang@intel.com>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: sensor-hub: Fail unfinished multi-value reads
 on remo
Message-ID: <20260913045411.5e2f5b25@jic23-hlaptop>
In-Reply-To: <20260912050257.837340-1-lhfff@tju.edu.cn>
References: <aqPNDZgMS9K6NT7d@ashevche-desk.local>
	<20260912050257.837340-1-lhfff@tju.edu.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Sep 2026 13:02:57 +0800
Yibo Tan <lhfff@tju.edu.cn> wrote:

> sensor_hub_remove() completes pending reads after stopping the HID device,
> but does not record why they completed.  A successful completion wait
> therefore returns zero even if no complete input report was received.
> Multi-value IIO callers then format their untouched automatic buffer as a
> successful result.
> 
> With a valid four-element signed 32-bit quaternion report descriptor, an
> unprivileged reader received all 16 bytes of the untouched buffer.  Across
> 11 independent KASLR-enabled boots, four reads exposed exact pointers to
> dev_rot_channels or dev_sysfs_ops.  Subtracting the matching link-time
> symbol address recovered the kernel KASLR slide in all four cases.
> 
> The reader ran as UID/GID 65534 with no effective capabilities through the
> mode-0644 IIO attribute.  The test used a privileged UHID broker to create
> and remove the provider; it does not demonstrate unprivileged provider
> removal.
> 
> Publish -ENODEV through pending.raw_size before completing an unfinished
> multi-value request, and propagate the error after a successful wait.  A
> fully received response already has a positive raw_size and remains
> successful; max_raw_size is zero for the separate single-value path.
> 
> The Root B-only repair returned -ENODEV with no payload or kernel
> diagnostic in 3/3 matching signed-32-bit runs.  The source reproducer,
> complete vulnerable and fixed serial logs, result tables, and checksums are
> available in [1].
> 
> Link: https://github.com/kimaiden1984-boop/linux-kernel-poc-collections/tree/main/cases/hid-sensor-quaternion-root-b-kaslr [1]
> Fixes: f784fcea4506 ("HID: sensor-hub: Add sensor_hub_input_attr_read_values() for multi-byte reads")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Yibo Tan <lhfff@tju.edu.cn>

Thanks for the report and fix. Looks good to me, but I'm a little
concerned about fragility of relying on ordering of data being set
and the update of raw_size (in sensorhub_raw_event()). It is messy 
for a compiler to reorder it but I think is allowed to in theory
at least.

Perhaps it is safer for these tear down paths to just set a flag before
the shutdown extra completion and ensure an error is returned in
anything that is waiting on that completion if that flag is set?
That flag would be before the new competion so I think ordering
would be fine.  Might result in extra errors to userspace but we don't
really care when ripping things down.

Jonathan


> ---
> Changes in v2:
> - Turn the reproducer URL into a Link trailer and cite it from the text.
> - Use the reviewer-requested generic LLM assistance trailer.
> 
> v1: https://lore.kernel.org/r/20260911092039.234253-1-lhfff@tju.edu.cn/
> 
>  drivers/hid/hid-sensor-hub.c   | 7 ++++++-
>  include/linux/hid-sensor-hub.h | 2 +-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 6470a290ebfc..687f8defa2f0 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -334,6 +334,8 @@ int sensor_hub_input_attr_read_values(struct hid_sensor_hub_device *hsdev,
>  			ret = -ETIMEDOUT;
>  		else if (cycles < 0)
>  			ret = cycles;
> +		else if (hsdev->pending.raw_size < 0)
> +			ret = hsdev->pending.raw_size;
>  
>  		hsdev->pending.status = false;
>  	}
> @@ -805,8 +807,11 @@ static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
>  {
>  	struct hid_sensor_hub_device *hsdev = dev->platform_data;
>  
> -	if (hsdev->pending.status)
> +	if (hsdev->pending.status) {
> +		if (hsdev->pending.max_raw_size && !hsdev->pending.raw_size)
> +			hsdev->pending.raw_size = -ENODEV;
>  		complete(&hsdev->pending.ready);
> +	}
>  
>  	return 0;
>  }
> diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
> index ab5cc8db3fbb..4ad53304bb0b 100644
> --- a/include/linux/hid-sensor-hub.h
> +++ b/include/linux/hid-sensor-hub.h
> @@ -41,7 +41,7 @@ struct hid_sensor_hub_attribute_info {
>   * @ready:		Completion synchronization data.
>   * @usage_id:		Usage id for physical device, e.g. gyro usage id.
>   * @attr_usage_id:	Usage Id of a field, e.g. X-axis for a gyro.
> - * @raw_size:		Response size for a read request.
> + * @raw_size:		Response size or negative error for a read request.
>   * @raw_data:		Place holder for received response.
>   * @index:		Current write index into raw_data for multi-byte reads.
>   * @max_raw_size:	Total buffer size for multi-byte reads; 0 for single-value reads.

