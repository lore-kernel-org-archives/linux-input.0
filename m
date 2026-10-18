Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213253115BD;
	Sun, 18 Oct 2026 19:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792351867; cv=none; b=llo882sO7z52Fphf9+UpRoPXNh7Ttv5O9vAQZpcmGpAk45q7A9qidktMZny+1w5LvtoLKOpkjZENC52fdE7vTn0UhFSZfHfzuPHA9k7lFVvzjY4mVENQpH8V49Fjtwkx7U/JrEME1hdmqUt7jfetXuh1SkJSlabayktwO44rqI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792351867; c=relaxed/simple;
	bh=E7thlH/nBU+22b5b7ZXtyzcQLz8tHxPZ4MAEfmMGejw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJQNPJfwI9qgxtMHCuI9fVjTE+gEOieqILnkoljr0uLvtQETtxr80saJZito5XZ6wPVdqxCh+qXKwFCOOLhf0z2ZSHyvwGgjzb/2xLHEKc8HTDQOxU8WF6iDlLdmleFMSanNQ2D+d1Pg4gf9VoqhA3S4kqKgHkF0M3bnbZs98Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFBLG4Zl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFBLG4Zl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362FC1F000C4;
	Sun, 18 Oct 2026 19:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792351865;
	bh=jODYLZHzljdLiXnGGhsKtxbLZ+ZqF0sA2hJzKBvSB3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mFBLG4ZlpMzfhNArN5T5IsUWkyCDx3fOxCFITyXyOxyaDB+jKiYmpKKJCON2mkaKF
	 DJdK5y5DeIaC9rCr5QJk+6cZlY+eS6HBuIb7iZAyiSKG7vkiFTO31LLQYtLUvYloq0
	 722Gr4NQ+AHjM4iioHkDRnVEV2SLHZcGHKsQzZd7L7xNz/Hg6tX6+QqHy5zFPQPkcO
	 jY34VwuPeaS+pM+V/R10m//a+BFBd8aYVAoLW8pIzZ2C2B5SeHKDxXPAA8mvjcIRmJ
	 8ScNy1eOFHLBr5T7+E8mfbu6ppgo5qBx0sogwzdmpFEV0+Dc2vxXsEVk4TCJwelyqD
	 idRxBhpgtUAwQ==
Date: Sun, 18 Oct 2026 20:30:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Christopher Hoover <ch@murgatroid.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, nuno.sa@analog.com, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Zhang, Lixu" <lixu.zhang@intel.com>
Subject: Re: [PATCH v2 0/3] iio: hid-sensors: fix shared callbacks in
 temperature and humidity
Message-ID: <20261018203058.525ea7c9@jic23-hlaptop>
In-Reply-To: <20261007184423.622445-1-ch@murgatroid.com>
References: <20261007072329.27806-1-ch@murgatroid.com>
	<20261007184423.622445-1-ch@murgatroid.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Oct 2026 11:44:20 -0700
Christopher Hoover <ch@murgatroid.com> wrote:

> hid-sensor-temperature and hid-sensor-humidity share one static
> struct hid_sensor_hub_callbacks across instances and overwrite its pdev
> on every probe.  With two temperature sensors, reports for one go to
> the other's pdev; once that device is removed,
> temperature_capture_sample() dereferences NULL.  I hit this on 7.0
> with two uhid-created sensors.
> 
Looking for review from Jiri and / or Srinivas on this.
+CC Lixu as well who has been helping test HID sensors changes.

> Patches 2-3 make the callbacks per instance, as the other HID sensor
> drivers do.  Patch 1 makes sensor_hub_remove_callback() take
> pdata->lock, as sensor_hub_raw_event() does, so a report racing an
> unbind cannot call through the freed callbacks.
> 
> Changes in v2:
> - New patch 1, for the use-after-free on unbind found by the Sashiko
>   review of v1.
> 
> Christopher Hoover (3):
>   HID: hid-sensor-hub: Synchronize callback removal with raw events
>   iio: temperature: hid-sensor-temperature: Use per-instance callbacks
>   iio: humidity: hid-sensor-humidity: Use per-instance callbacks
> 
>  drivers/hid/hid-sensor-hub.c                     | 12 ++++++++++--
>  drivers/iio/humidity/hid-sensor-humidity.c       | 12 +++++-------
>  drivers/iio/temperature/hid-sensor-temperature.c | 12 +++++-------
>  3 files changed, 20 insertions(+), 16 deletions(-)
> 
> 
> base-commit: 9ee8306121495d2a25aa5d1bfd519f2748786b83

