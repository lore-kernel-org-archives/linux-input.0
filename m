Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130EC382291;
	Mon,  2 Mar 2026 20:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772484485; cv=none; b=XKYuyVWIScn/CPekHuoL+71uRxPiYeWajQy/WTRYJwQEdsUhBIBI6oatT0ZfOUNnFFqYTJptXROMWQgv3BfmpqYAAIftGDwsY+W+gXWegnxI0yDnHJ+PQneKR4F1OnOcI3+6kaxZxguiJPXpKHIkKOYAHLKtjNLTKGC+NxDD9gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772484485; c=relaxed/simple;
	bh=uTk3j2RtahZjmJKorm9xsBDJwJbY1sTw2gCxxz67kn8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=djOapBBURN3Q5Kwe/VRt5DhhEDv0AxZMtI7iQci2MRKsTNoQvnXj9R9c6weVFsgAyXrd/Isfz9pVlDjpb9A68fdjm2Kr+ekf576/MqkiMpbPMl+SltK1c0aeFASEz4cSi9ZpH6uMX2bbNP1l/Qg2Ns/o4N85NW/5nGoFzIHso6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rv238Ufo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rv238Ufo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB475C19423;
	Mon,  2 Mar 2026 20:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772484484;
	bh=uTk3j2RtahZjmJKorm9xsBDJwJbY1sTw2gCxxz67kn8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rv238UfoTVgvGkTadY1HM1IYQznB7j6O7MNMusjiZ3nSE7mfjuVCSvuZSs0C8AYGt
	 a5vbTfDjHA1V34af18ofDIUa/hq9DvFX+PC0JwHilmvtSpRfynQJSs9iqUQNtL/FDs
	 wfceZEyk9JWnt4aM4wVVhup4lAPgsiHBBGQNzwS7sMbMqmNx6H8cfnkiRdXX/fQQF+
	 4qxajNQvh4sav3vrTVFRYhn65Xp2iQ6swEA7KWYbKiHZxrZZ9vVaj/eFujLdrCXJzy
	 0QoH1VNhH/IJ+4UxQAkrUSjho31Olue5I+r7bso8R+7F16AnFHXG9xJbysjgRccaT7
	 zRi2JLeLK4ynA==
Date: Mon, 2 Mar 2026 20:47:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars
 =?UTF-8?B?TcO2bGxlbmRvcmY=?= <lars.moellendorf@plating.de>, Lars-Peter
 Clausen <lars@metafoo.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Lixu Zhang
 <lixu.zhang@intel.com>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: buffer: cache largest scan element size
Message-ID: <20260302204755.462d6b63@jic23-huawei>
In-Reply-To: <20260301-iio-fix-timestamp-alignment-v1-3-1a54980bfb90@baylibre.com>
References: <20260301-iio-fix-timestamp-alignment-v1-0-1a54980bfb90@baylibre.com>
	<20260301-iio-fix-timestamp-alignment-v1-3-1a54980bfb90@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 01 Mar 2026 14:24:52 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Cache the largest scan element size of elements enabled in a scan
> buffer. This will be used later to ensure proper alignment of the
> timestamp element in the scan buffer.
Why can't we just stash the start of the timestamp? It's computed
a couple of lines up (or at least it's supposed to be computed there!)

	if (timestamp) {
		length = iio_storage_bytes_for_timestamp(indio_dev);
		if (length < 0)
			return length;

		bytes = ALIGN(bytes, length);

Or is that wrong currently?  If it is we need to fix that logic.

J
> 
> The new field could not be placed in struct iio_dev_opaque because we
> will need to access it in a static inline function later, so we make it
> __private instead. It is only intended to be used by core IIO code.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/industrialio-buffer.c | 14 +++++++++++---
>  include/linux/iio/iio.h           |  3 +++
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 71dfc81cb9e5..83e9392f949f 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -765,7 +765,8 @@ static int iio_storage_bytes_for_timestamp(struct iio_dev *indio_dev)
>  
>  static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
>  				  const unsigned long *mask, bool timestamp,
> -				  unsigned int *scan_bytes)
> +				  unsigned int *scan_bytes,
> +				  unsigned int *largest_element_size)
>  {
>  	unsigned int bytes = 0;
>  	int length, i, largest = 0;
> @@ -793,6 +794,9 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
>  
>  	*scan_bytes = ALIGN(bytes, largest);
>  
> +	if (largest_element_size)
> +		*largest_element_size = largest;
> +
>  	return 0;
>  }
>  
> @@ -848,7 +852,7 @@ static int iio_buffer_update_bytes_per_datum(struct iio_dev *indio_dev,
>  		return 0;
>  
>  	ret = iio_compute_scan_bytes(indio_dev, buffer->scan_mask,
> -				     buffer->scan_timestamp, &bytes);
> +				     buffer->scan_timestamp, &bytes, NULL);
>  	if (ret)
>  		return ret;
>  
> @@ -892,6 +896,7 @@ struct iio_device_config {
>  	unsigned int watermark;
>  	const unsigned long *scan_mask;
>  	unsigned int scan_bytes;
> +	unsigned int largest_scan_element_size;
>  	bool scan_timestamp;
>  };
>  
> @@ -997,7 +1002,8 @@ static int iio_verify_update(struct iio_dev *indio_dev,
>  	}
>  
>  	ret = iio_compute_scan_bytes(indio_dev, scan_mask, scan_timestamp,
> -				     &config->scan_bytes);
> +				     &config->scan_bytes,
> +				     &config->largest_scan_element_size);
>  	if (ret)
>  		return ret;
>  
> @@ -1155,6 +1161,8 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
>  	indio_dev->active_scan_mask = config->scan_mask;
>  	ACCESS_PRIVATE(indio_dev, scan_timestamp) = config->scan_timestamp;
>  	indio_dev->scan_bytes = config->scan_bytes;
> +	ACCESS_PRIVATE(indio_dev, largest_scan_element_size) =
> +		config->largest_scan_element_size;
>  	iio_dev_opaque->currentmode = config->mode;
>  
>  	iio_update_demux(indio_dev);
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index a9ecff191bd9..85bcb5f8ae15 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -584,6 +584,8 @@ struct iio_buffer_setup_ops {
>   *			and owner
>   * @buffer:		[DRIVER] any buffer present
>   * @scan_bytes:		[INTERN] num bytes captured to be fed to buffer demux
> + * @largest_scan_element_size: [INTERN] cache of the largest scan element size
> + *			       among the channels selected in the scan mask
>   * @available_scan_masks: [DRIVER] optional array of allowed bitmasks. Sort the
>   *			   array in order of preference, the most preferred
>   *			   masks first.
> @@ -610,6 +612,7 @@ struct iio_dev {
>  
>  	struct iio_buffer		*buffer;
>  	int				scan_bytes;
> +	unsigned int			__private largest_scan_element_size;
>  
>  	const unsigned long		*available_scan_masks;
>  	unsigned int			__private masklength;
> 

