Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656571;
	b=RBjrL/XbhCcBcPR8BGpMjgDS0fa0HB976HlX8rf4yX/1VzZPYdjucUqaxKb66GOJrN8D
	 ksiQ1LBNszTxM5LbJn+987yNlQzWBhbWFDWlOAiOJdj8aAUUdnPlAIYBYgobr0ocnJvka
	 ZDLQiQ1Qi5vlL32huTbW/et+DH8n3IXc3VICjqPFf2xlS7cgnMmv4UGh4Nvl6htj6gOFD
	 rL+pMwgD3NHvQle2/oEeE6nMnM8L4OrYhD1nc6Cvhn9IHY+kqLyp05sVa4Zp7GM+qfNcB
	 /pO7EwoAj0cZXPGf++3SmUteZW+lVTso/h8F4tdqAMNZSGU0qhmxhneJGYRAV6GK8gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656571;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=nyuT3jAra0GlDW7PPgARgvC6ifNJJjzDIvX3nXn21YM=;
	b=MaPCH/RZ6KxFr+2EXPsP3Zf647YFoM9pn3nFndjBgqFEESn38usny4v9hnHgJTkydv5w
	 enwdxkD/RtyDNvnojxWWafW6biYRJCEj68bbzKQRb3nn8JooNgZ6gesPu/cNhODHIn1dN
	 2Wk/oc/I+bEZMI9sA/I5wPQ2Qq01qUwNR9LOhxr0z+QaBSFXSd1ON5UqX88MzjE+wzC+E
	 py1s0pn24rf9x/7CKb7/2Moro525X+KmN7OHH2Qdeuusi600XBuOoQqsrbGlmk0/uHaYN
	 tyTzHgkbxlQHc0HJdBJ/SPPXgGp/jFW4oAzNdKUt2CffFtTm7JTVgmnl47sRO09PYHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gXfDca/s";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9041D606A327;
	Mon,  2 Nov 2026 21:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gXfDca/s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90351F00A16;
	Mon,  2 Nov 2026 21:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793656571;
	bh=nyuT3jAra0GlDW7PPgARgvC6ifNJJjzDIvX3nXn21YM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gXfDca/su318tH3kGwfqvT89cRwwFGjh1hbi8tOnu9+1ssLMKhBPeK5nU0hFWbkgc
	 x27Woq7pww6CghuI6qSGmwosmUpsE+ojYIVlP1zwzwMfnYhqQyCcUf9YyT3/mqi3C5
	 cXSfY375wRrKrN3mwtc7n6mHmLdW+wYEY+Yvnhevy4NykHfs2BY/z2QEYXMtnHpbUU
	 n2CIKogp3/LjWgdvryUNoEwMfN9JP2YS3q63nmC5HaEgmkJP1knkKZJLYIaHFMhzdt
	 IAF1L3P3S7nx8POlUkGNaw17lnKpcde2+YVQT7Ka89WKqAcRW12f1pEUf1pTs7yvWh
	 rm34+pRRH4Asg==
Date: Mon, 2 Nov 2026 21:56:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Christopher Hoover <ch@murgatroid.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Lixu Zhang
 <lixu.zhang@intel.com>, Joshua Crofts <joshua.crofts1@gmail.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] iio: hid-sensors: fix shared callbacks in
 temperature and humidity
Message-ID: <20261102215606.5e36a2a2@jic23-hlaptop>
In-Reply-To: <20261019023420.83976-1-ch@murgatroid.com>
References: <20261019023420.83976-1-ch@murgatroid.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Oct 2026 19:34:17 -0700
Christopher Hoover <ch@murgatroid.com> wrote:

> hid-sensor-temperature and hid-sensor-humidity share one static
> struct hid_sensor_hub_callbacks across instances and overwrite its pdev
> on every probe. With two temperature sensors, reports for one go to
> the other's pdev; once that device is removed,
> temperature_capture_sample() dereferences NULL. I hit this on 7.0
> with two uhid-created sensors.
> 
> Patches 2-3 make the callbacks per instance, as the other HID sensor
> drivers do. Patch 1 makes sensor_hub_remove_callback() take
> pdata->lock, as sensor_hub_raw_event() does, so a report racing an
> unbind cannot call through the freed callbacks.
Applied to the fixes-togreg branch of iio.git with the ordering tweaks Andy suggested.

Thanks,

Jonathan
> 
> Changes in v3:
> - Patches 2-3: set the callbacks with one compound literal (Jonathan).
> - Kept Joshua's Reviewed-by on all three; patches 2-3 changed only in
>   style.
> - Rebased onto v7.3.
> - Sent as a new thread, not a reply to v2.
> 
> Changes in v2:
> - New patch 1, for the use-after-free on unbind found by the Sashiko
>   review of v1.
> 
> v2: https://lore.kernel.org/all/20261007184423.622445-1-ch@murgatroid.com/
> 
> Christopher Hoover (3):
>   HID: hid-sensor-hub: Synchronize callback removal with raw events
>   iio: temperature: hid-sensor-temperature: Use per-instance callbacks
>   iio: humidity: hid-sensor-humidity: Use per-instance callbacks
> 
>  drivers/hid/hid-sensor-hub.c                     | 12 ++++++++++--
>  drivers/iio/humidity/hid-sensor-humidity.c       | 14 +++++++-------
>  drivers/iio/temperature/hid-sensor-temperature.c | 14 +++++++-------
>  3 files changed, 24 insertions(+), 16 deletions(-)
> 
> 
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222

