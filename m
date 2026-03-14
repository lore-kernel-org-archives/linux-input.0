Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B47303A12;
	Sat, 14 Mar 2026 12:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773490733; cv=none; b=W1nsxHZmWXxuJotbKSrK3eP2BXg3X/M7FTs7KvzAg88Bx3U3nEJ1yuC3dJFqJIVcvKrUM3KZ472wLLzaWTKWUkAF0+kGMoIV5ABGJZm6wnt73FdqmSayCSTvEmggQVlXgiAYPJhpDk4L7W3d6TAVC5Ixr6v3nTIIGlvA3z1NhqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773490733; c=relaxed/simple;
	bh=3YXqDZb2j9/Tmqdnz5mG+lyHwXBw7W1+1HfiLDTMsj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxuEg2z+F2dkVQFN6wh4RdRkz4Ncy0Dlagez+D4F9hstwRWTaKMqoFxEhsdVrOMwMn1ZpBHMteFWHlcCVaW7aZzSdZWTUedOeYpNNpPXCWhBUYljDzy44NMBV/N1FjVkrLeWbZOrBOt+6q78nTFLatAN29j+xKwGVuVOxDbFyBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V068ur+U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V068ur+U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8796EC116C6;
	Sat, 14 Mar 2026 12:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773490733;
	bh=3YXqDZb2j9/Tmqdnz5mG+lyHwXBw7W1+1HfiLDTMsj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V068ur+U4s7CUaQ6hQBECYL/XVa8UjWp40dxGFHlddWIwgHbCjNaMu6M0GCUwzLO6
	 elMYK1XSuW1mEhWZ8vdu9m+ArD4EQeGuSJg6eEgvjcOboimkq7Fb/AvR8RewSkJVvc
	 lLhYfJvjYKwS70t0cMS7GV+SsQTUL6yU5Ljh531BFq8J+9M+0kdgfb7qVSTOPkcpUO
	 rGNlqrYuNzUtnKRLEuk/KYTgXO9joElM5SVvvMGTMFnq6JNkHYSSqKgGqByr5UsVTC
	 hHgP/dUBahvqZf2PxXI6SuxKl1n2p7W7gibYbsHNKqPCPcYcXuA7lauRF0RKftJYTx
	 g4SP80q4ohV3g==
Date: Sat, 14 Mar 2026 12:18:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars
 =?UTF-8?B?TcO2bGxlbmRvcmY=?= <lars.moellendorf@plating.de>, Lars-Peter
 Clausen <lars@metafoo.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Lixu Zhang
 <lixu.zhang@intel.com>, Francesco Lavra <flavra@baylibre.com>,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] iio: orientation: hid-sensor-rotation: add
 timestamp hack to not break userspace
Message-ID: <20260314121838.620a4b4c@jic23-huawei>
In-Reply-To: <20260307-iio-fix-timestamp-alignment-v2-1-d1d48fbadbbf@baylibre.com>
References: <20260307-iio-fix-timestamp-alignment-v2-0-d1d48fbadbbf@baylibre.com>
	<20260307-iio-fix-timestamp-alignment-v2-1-d1d48fbadbbf@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 07 Mar 2026 19:44:09 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Add a hack to push two timestamps in the hid-sensor-rotation scan data
> to avoid breaking userspace applications that depend on the timestamp
> being at the incorrect location in the scan data due to unintentional
> misalignment in older kernels.
> 
> When this driver was written, the timestamp was in the correct location
> because of the way iio_compute_scan_bytes() was implemented at the time.
> (Samples were 24 bytes each.) Then commit 883f61653069 ("iio: buffer:
> align the size of scan bytes to size of the largest element") changed
> the computed scan_bytes to be a different size (32 bytes), which caused
> iio_push_to_buffers_with_timestamp() to place the timestamp at an
> incorrect offset.
> 
> There have been long periods of time (6 years each) where the timestamp
> was in either location, so to not break either case, we open-code the
> timestamps to be pushed to both locations in the scan data.
> 
> Reported-by: Jonathan Cameron <jic23@kernel.org>
> Closes: https://lore.kernel.org/linux-iio/20260215162351.79f40b32@jic23-huawei/
> Fixes: 883f61653069 ("iio: buffer: align the size of scan bytes to size of the largest element")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
As suggested, I've applied this one to fixes-togreg and the rest will have
to wait for now.  Interestingly this cycle has more fixes coming through
than any I remember!  Hence I've sent a 2nd fixes pull and this will
be queued up for the 3rd in a week or so.  It's possible the rest
might have to wait for next cycle though given round trip times etc.

Let's see.

Thanks for sorting this out and for the test scripts etc!


Jonathan

> ---
> 
> v2 changes:
> - Rebased on fix that also touches the scan struct.
> - Improved comments.
> 
> I found that I could emulate this thanks to /dev/uhid. And thanks to AI
> code generators, I was able to reasonably quickly make a script that
> worked for emulating "HID-SENSOR-20008a". See v1 message for test script
> source code.
> 
> [v1]: https://lore.kernel.org/linux-iio/20260301-iio-fix-timestamp-alignment-v1-1-1a54980bfb90@baylibre.com/
> 
> I set up the buffer like this:
> 
> cd /sys/bus/iio/devices/iio:device1/buffer0
> echo 1 > in_rot_quaternion_en
> echo 1 > in_timestamp_en
> echo 1 > enable
> 
> Before this series is applied, we can see that the timestamp (group of 8
> ending in "98 18") is at offset of 24 in the 32-byte data.
> 
> hd /dev/iio\:device1
> 
> 00000000  6a 18 00 00 ac f3 ff ff  83 2d 00 00 02 d3 ff ff  |j........-......|
> 00000010  00 00 00 00 00 00 00 00  5a 17 a0 2a 73 cb 98 18  |........Z..*s...|
> 
> 00000020  ad 17 00 00 6a f4 ff ff  35 2b 00 00 ca d0 ff ff  |....j...5+......|
> 00000030  00 00 00 00 00 00 00 00  2a a6 bb 30 73 cb 98 18  |........*..0s...|
> 
> 00000040  92 1e 00 00 50 ec ff ff  ea c1 ff ff 78 f0 ff ff  |....P.......x...|
> 00000050  00 00 00 00 00 00 00 00  8f 3b a7 39 77 cb 98 18  |.........;.9w...|
> 
> After the first patch, we can see that the timestamp is now repeated at
> both the correct and previous incorrect offsets (24 and 32). (Normally,
> the last 8 bytes would be all 00 for padding.)
> 
> 00000000  dd e0 ff ff 0e e0 ff ff  75 07 00 00 90 3f 00 00  |........u....?..|
> 00000010  f4 38 82 d0 3a cc 98 18  f4 38 82 d0 3a cc 98 18  |.8..:....8..:...|
> 
> 00000020  a0 e0 ff ff 1d e0 ff ff  a0 0a 00 00 1c 3f 00 00  |.............?..|
> 00000030  3a 29 9f d6 3a cc 98 18  3a 29 9f d6 3a cc 98 18  |:)..:...:)..:...|
> 
> 00000040  a9 e1 ff ff 1e 14 00 00  6c c1 ff ff 98 f2 ff ff  |........l.......|
> 00000050  39 21 77 11 55 cc 98 18  39 21 77 11 55 cc 98 18  |9!w.U...9!w.U...|
> ---
>  drivers/iio/orientation/hid-sensor-rotation.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
> index 6806481873be..5a5e6e4fbe34 100644
> --- a/drivers/iio/orientation/hid-sensor-rotation.c
> +++ b/drivers/iio/orientation/hid-sensor-rotation.c
> @@ -20,7 +20,12 @@ struct dev_rot_state {
>  	struct hid_sensor_hub_attribute_info quaternion;
>  	struct {
>  		IIO_DECLARE_QUATERNION(s32, sampled_vals);
> -		aligned_s64 timestamp;
> +		/*
> +		 * ABI regression avoidance: There are two copies of the same
> +		 * timestamp in case of userspace depending on broken alignment
> +		 * from older kernels.
> +		 */
> +		aligned_s64 timestamp[2];
>  	} scan;
>  	int scale_pre_decml;
>  	int scale_post_decml;
> @@ -154,8 +159,19 @@ static int dev_rot_proc_event(struct hid_sensor_hub_device *hsdev,
>  		if (!rot_state->timestamp)
>  			rot_state->timestamp = iio_get_time_ns(indio_dev);
>  
> -		iio_push_to_buffers_with_timestamp(indio_dev, &rot_state->scan,
> -						   rot_state->timestamp);
> +		/*
> +		 * ABI regression avoidance: IIO previously had an incorrect
> +		 * implementation of iio_push_to_buffers_with_timestamp() that
> +		 * put the timestamp in the last 8 bytes of the buffer, which
> +		 * was incorrect according to the IIO ABI. To avoid breaking
> +		 * userspace that may be depending on this broken behavior, we
> +		 * put the timestamp in both the correct place [0] and the old
> +		 * incorrect place [1].
> +		 */
> +		rot_state->scan.timestamp[0] = rot_state->timestamp;
> +		rot_state->scan.timestamp[1] = rot_state->timestamp;
> +
> +		iio_push_to_buffers(indio_dev, &rot_state->scan);
>  
>  		rot_state->timestamp = 0;
>  	}
> 

