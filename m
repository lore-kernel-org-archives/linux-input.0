Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365624;
	b=n5LOX4LOSWq+SQ+Vqur57EucvQCIkEQbuV3oMvV3gLlV9ddgFVRbMAbn0L2ybnEAL5bu
	 4xxI4Z12Eh9usHmdx5NYs7XU2V1a+IhzM55R+G/RwSc0X1EkVpgUbzs7oFbIZ9/oYhdlo
	 UMSeobxsZKKSDM5mcBMYRLehLgP0b0j9lvFWg0w+89RcvE23gpqbSiCgJ9GKFfclYGdR7
	 yyOVGZoOxq6hajt48XWwRv6/TMwq1b/3SKfZ52WnTn5JiW3HkbOqOZdgMEH+binHBSKNT
	 p0OJSLceSkaROKxYSwT0xJqTqgiuIfXyxzAyF8RMvwPYaVDkeeJlAyTiBr5Syw+TCzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365624;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=nQ45SBbrrPfcBxk/ZVOWzmZZv9CA/Wh842zlVfVE3Ek=;
	b=St6yRYJ77OIoJqh25kdKQLPiLHohDlbnEH/rNFNTSCnGSnLY9KyZ/OcM/UMpYsThkkUg
	 2pWKgWRtaVxzim/dqwkrggucpcw3V8GYZzrWnNMyRIdZTB167x01axnTVCENQQu0b2YJy
	 nxrd03ixWkRR0U2Y46qEZ6iU2Lxhkl5ecuH6rAFKToW7aOWXfVzsvmKqxt9PW45bHdY/t
	 e+yXaqC6Cfnw2P+kOi53pNKDJYJCm+AF3Bw/bIGaSPq7Wai5ADm0LOiVdyiyYrhW5Au3V
	 avdJNENdio8bUtmXA6xczhcaMsNpPnr+bIDvbX2RjvkyTVPJ7xrxySjdcxosIZruf+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BS77exDR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552A5606A31C;
	Wed, 11 Nov 2026 02:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BS77exDR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E591F0089F;
	Wed, 11 Nov 2026 02:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794365623;
	bh=nQ45SBbrrPfcBxk/ZVOWzmZZv9CA/Wh842zlVfVE3Ek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BS77exDRksvh5edR0Phb6ETZjoNj6GG38sh/cAC9D2f/DP1aEmvukU8iKsjxmh3Kq
	 qr1P54iq6iodb8IM+ATG5964FXsZ20qOTPD4eBOePasNlfa2LLcV8i2+fcrnXEZfcI
	 fT2ESY+ecMDWWGwEKjEZRC4si6AEZvzcwQoP39JAUBt1GpJ/w0BfrI155b0OGcKY4P
	 MvFRLoEt2r/xaVJ/G4ayijzC+xEj69XNS9jV11nKN9FyKL9adMBttFptdbdCs0lXjv
	 tK3sSjNo0snPNUjZ/2VG85Gd/0Vvp9rZYOUNYXqhA3kTy3sZ6R1HhyD41x46e2QgLW
	 p5OtdXgtBBzWw==
Date: Wed, 11 Nov 2026 02:53:36 +0000
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
Message-ID: <20261111025336.051fbbcb@jic23-hlaptop>
In-Reply-To: <20261102215606.5e36a2a2@jic23-hlaptop>
References: <20261019023420.83976-1-ch@murgatroid.com>
	<20261102215606.5e36a2a2@jic23-hlaptop>
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

On Mon, 2 Nov 2026 21:56:06 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 18 Oct 2026 19:34:17 -0700
> Christopher Hoover <ch@murgatroid.com> wrote:
> 
> > hid-sensor-temperature and hid-sensor-humidity share one static
> > struct hid_sensor_hub_callbacks across instances and overwrite its pdev
> > on every probe. With two temperature sensors, reports for one go to
> > the other's pdev; once that device is removed,
> > temperature_capture_sample() dereferences NULL. I hit this on 7.0
> > with two uhid-created sensors.
> > 
> > Patches 2-3 make the callbacks per instance, as the other HID sensor
> > drivers do. Patch 1 makes sensor_hub_remove_callback() take
> > pdata->lock, as sensor_hub_raw_event() does, so a report racing an
> > unbind cannot call through the freed callbacks.  
> Applied to the fixes-togreg branch of iio.git with the ordering tweaks Andy suggested.

One day I'll remember some bits of this driver are in hid.

Dropped patch 1, that should go via the hid tree.

Sorry Jiri / Christopher.

I only seem to notice I've done this whilst writing pull requests :(

Jonathan



> 
> Thanks,
> 
> Jonathan
> > 
> > Changes in v3:
> > - Patches 2-3: set the callbacks with one compound literal (Jonathan).
> > - Kept Joshua's Reviewed-by on all three; patches 2-3 changed only in
> >   style.
> > - Rebased onto v7.3.
> > - Sent as a new thread, not a reply to v2.
> > 
> > Changes in v2:
> > - New patch 1, for the use-after-free on unbind found by the Sashiko
> >   review of v1.
> > 
> > v2: https://lore.kernel.org/all/20261007184423.622445-1-ch@murgatroid.com/
> > 
> > Christopher Hoover (3):
> >   HID: hid-sensor-hub: Synchronize callback removal with raw events
> >   iio: temperature: hid-sensor-temperature: Use per-instance callbacks
> >   iio: humidity: hid-sensor-humidity: Use per-instance callbacks
> > 
> >  drivers/hid/hid-sensor-hub.c                     | 12 ++++++++++--
> >  drivers/iio/humidity/hid-sensor-humidity.c       | 14 +++++++-------
> >  drivers/iio/temperature/hid-sensor-temperature.c | 14 +++++++-------
> >  3 files changed, 24 insertions(+), 16 deletions(-)
> > 
> > 
> > base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222  
> 
> 

