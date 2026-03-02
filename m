Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF243A331F;
	Mon,  2 Mar 2026 20:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483953; cv=none; b=M2K57B2vpHVa+qL+ELt+bUXwB6rtR7rlOP9i74v4U/h5gqcQOZAFRw7009qYj/Bwrgy2DR1yUCOTlc++8U/WS/Nx5IqKQP3WEZp3eetJiEj2/2Zge62c1sFZihiDQsNN1mSY3KkKTm0Ve9L4EEzO5ViBii9S70T4RqcK5WM/gbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483953; c=relaxed/simple;
	bh=pFfPSNxtGFkRYqV6Ta0uf8gVvc79p+51pA2KUDhmdyw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cOy4O8RbX1LInxwQGpijLW66sYdwr0UKjNjoFlxVv61u/O5/nu+w/1l0QqmINCMEr1e7/d/xEnGExiea9CuWpq/OIx1rg2S4A3S+dPwbCc+Ye8c8pGhou03N/k47WBWgHe4N9KEiOkbUxZKDnWyawPqtUZRlYVJ14+0AaMwvZME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMKsyGd2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMKsyGd2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AA2C19425;
	Mon,  2 Mar 2026 20:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772483952;
	bh=pFfPSNxtGFkRYqV6Ta0uf8gVvc79p+51pA2KUDhmdyw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aMKsyGd22XW4bHoS3jmcSksOMNASw8c7d2+3yboytIhhPe6ZzKjOtKKDS9fcJyl+Z
	 Ivn6aa34mY+Bu+4dFH/gRJH8bydOx0Cs9eGTGQIkB5EokhBzx73jLTDALnFp8uTjpU
	 Bs0WxnM7jJXOtKqVy4oWSYkKVPbaF+2IPL5vNQZZl6EHT78QdCS+kWN7aUYcxjhhQ4
	 Tr/VyG/EYCRiUJSZLqTN78x9RkJo2BAr7Tnz1NOceHQF+fJO3ToB6Jsn7TjTnVsdrD
	 e4+A4JIxWtU9vQyjb05w/G0wxiKBgqXSHFyx9+zmiux17g3yn0/H/p+usW1F07kv4l
	 zk7NoNwGLFGDA==
Date: Mon, 2 Mar 2026 20:39:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jiri Kosina
 <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars
 =?UTF-8?B?TcO2bGxlbmRvcmY=?= <lars.moellendorf@plating.de>, Lars-Peter
 Clausen <lars@metafoo.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Lixu Zhang
 <lixu.zhang@intel.com>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: orientation: hid-sensor-rotation: add
 timestamp hack to not break userspace
Message-ID: <20260302203902.4f918811@jic23-huawei>
In-Reply-To: <8f9dc90d-9dba-4ed4-8cca-41012027aa10@baylibre.com>
References: <20260301-iio-fix-timestamp-alignment-v1-0-1a54980bfb90@baylibre.com>
	<20260301-iio-fix-timestamp-alignment-v1-1-1a54980bfb90@baylibre.com>
	<aaVPQsvz02S8GtsX@ashevche-desk.local>
	<8f9dc90d-9dba-4ed4-8cca-41012027aa10@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Mar 2026 09:18:56 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 3/2/26 2:50 AM, Andy Shevchenko wrote:
> > On Sun, Mar 01, 2026 at 02:24:50PM -0600, David Lechner wrote:  
> >> Add a hack to push two timestamps in the hid-sensor-rotation scan data
> >> to avoid breaking userspace applications that depend on the timestamp
> >> being at the incorrect location in the scan data due to unintentional
> >> misalignment in older kernels.
> >>
> >> When this driver was written, the timestamp was in the correct location
> >> because of the way iio_compute_scan_bytes() was implemented at the time.
> >> (Samples were 24 bytes each.) Then commit 883f61653069 ("iio: buffer:
> >> align the size of scan bytes to size of the largest element") changed
> >> the computed scan_bytes to be a different size (32 bytes), which caused
> >> iio_push_to_buffers_with_timestamp() to place the timestamp at an
> >> incorrect offset.
> >>
> >> There have been long periods of time (6 years each) where the timestamp
> >> was in either location, so to not break either case, we open-code the
> >> timestamps to be pushed to both locations in the scan data.  
> > 
> > ...
> >   
> >> +		/*
> >> +		 * HACK: There are two copies of the same timestamp in case of  
> > 
> > Usually we use FIXME in such cases. HACK is something which goes with
> > "do not apply".
> > 
> > Does it mean it will stay forever?  
> 
> Yes, it will have to stay forever because we can't break userspace.
> 
> My intention here was for HACK to mean "do not copy to another driver".
> 
> 
> If we think that no one is depending on timestamps being in the wrong
> offset, we could omit this change and apply only the rest of the series.
> And then only apply this patch if anyone complains. I am just trying to
> play it safe here and not risk breaking things.

I think it makes sense, but maybe label it something like

ABI regression avoidance: 

Good idea to just keep the wrongly aligned one as it removes the
risk and should do no harm as correct userspace should ignore the
second copy as it's in the padding.

Jonathan


