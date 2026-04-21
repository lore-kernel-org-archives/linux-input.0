Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7242332ED3;
	Tue, 21 Apr 2026 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776764519; cv=none; b=rLKjSYLwBz1a+2PfDR9MotmGHctEuF3dUdtr1KO5jxbTiLyslyhDx12zban6UDnSeuZdMj+/9uTE2VGvOZf1WQOySaiC9krYU3gEBBRdHYKeP0cwZc8AlOAWgYCzPORLkS/PfeYK6Er/vULw2o6UyM5rGTCb0CLJ1RzVBUvHsb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776764519; c=relaxed/simple;
	bh=h9xPnQBuVinikNtpkzeFhGCxcAGt3CCVLt/SMrBE4ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5oywrHPcRUlJRkR82Lm5sF7+GtbSuKPaXLDrHotYsz6eyME5+wy2w6P7Mlrs9g+2pWOFq93D4k0tA7rO2Xpzr1owdeXDll30DSZYqnjh80M4U8f5IMQyKKNQtq6tNjcg45Ju0k9B7ltcRCUQE+AxDt5VP63s9M8Q6X1FUaL85s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoJKbihT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoJKbihT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECDAC2BCB5;
	Tue, 21 Apr 2026 09:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776764519;
	bh=h9xPnQBuVinikNtpkzeFhGCxcAGt3CCVLt/SMrBE4ZQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MoJKbihT9d8lu4cp0Mq0pq2pl4GB7T++FwAfhoIicSSmTLkCRTX7n8iAY6fbG671h
	 0ELLHKibsn0611fKM95PHc8Ylm7nHoX2em1d10ql/RN+KSrdWbjtvrSs9LiIAVeZ76
	 Pxs9wYRn+Fcoye2xBWFuHjByh1TBCUOqGBD5KLkZDyeSYR/mwIUpV391ir8cUqj/wb
	 kDEfZ+4fEmfsb+DrKI+LTRecSkwGCQGaVWHDw2C+j7Vef1FI1IRZYCh6klIJ6uPgmO
	 N96UC3VeKqg2vHVxF09QwjSQqY9m8qVM6Rf98dvSgLpH+NbJGGWDY5rRkfAtM4xqIs
	 jcSLrWx9xKsVQ==
Date: Tue, 21 Apr 2026 10:41:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3] iio: magnetometer: hid-sensor-magn-3d: prefer 'u32'
 type
Message-ID: <20260421104151.05f3f871@jic23-huawei>
In-Reply-To: <20260421065837.1290-1-joshua.crofts1@gmail.com>
References: <20260421065837.1290-1-joshua.crofts1@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Apr 2026 06:58:37 +0000
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> Use 'u32' instead of bare 'unsigned' to resolve checkpatch.pl warnings
> and correct type use as defined in the struct hid_sensor_hub_callbacks.
> 
> No functional change.
> 
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Applied.

Thanks,

J
