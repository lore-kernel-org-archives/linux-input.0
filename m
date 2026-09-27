Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9493BF660;
	Sun, 27 Sep 2026 20:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790542658; cv=none; b=o3n7X0sGyVjzmp9Dh45aQT2RrelHMFLWvIBArdQXhxprfTcWKgpvigUWmsMkrbgShmQjQtY3TVNH1F2yJGCy3/J/hTuG/WrZc1AUW7eWdSSmWU14gAd0hWKqNJpQj/oZuh/6CsgRQEtPHtNaWL08BKP9eKvbm5dE1NkBZrtZjUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790542658; c=relaxed/simple;
	bh=RleQXdpB5ZueJ69MezIw7yL8mGr2Pe7FgscAEcaANko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d5pVYwM2VCiY80YPHv/G80aVjo85QRRgePig10ibEjpMezMntYr9EGzAOrtkk8VFVKjTYxCpFD6tWbxPjkUhrDDa0QaeQ5NNfj0l9DUJWHhJM/SX1MVaBtjbSVQy1Enl60V/ZGSX1gzJsu8MTLVgIAMcwT3Sf58rOv9GTayj9ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aB1wPB6D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aB1wPB6D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAB41F000FF;
	Sun, 27 Sep 2026 20:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790542657;
	bh=I28jh/biD+MEPD2Y9VJQxbmMBNAfGj6du8SxptmJs8k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aB1wPB6DFtaSl6hQFueqgccOIDlqpF6JUlUl/M9juCS9lXa7hwz+bq3QCNEi6EFcR
	 dTv4pS6CNhAHvbF2FLtbzW2baGfkQQEX+MEGLvBckWqbPfQ0v3Fe2xrtyxyoLxZ4ED
	 jwnC39VhnxD1C1D4ZtZIpRnKdfKxHSufC4OrVRU3tGXOs/kQJnJECWiFl/Fqve4YT4
	 9KlpZx6lh+a21owVMqTfNtlgw11MFaSuG3o49qHBMMEB9Uwuo0kC3JQQyfBLgst+TM
	 5aNhyXkKWLr7Rg/JH8lRynrqm2UhIwLBSmUDJDOns3kO3JUfrcDspV3uGuLc9XnhaK
	 8FHjxwYpzuoWw==
Date: Sun, 27 Sep 2026 21:57:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda via B4 Relay
 <devnull+sanjayembeddedse.gmail.com@kernel.org>
Cc: sanjayembeddedse@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Benjamin Tissoires
 <bentiss@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Zhang Lixu
 <lixu.zhang@intel.com>
Subject: Re: [PATCH v6 00/14] HID: iio: Introduce devm_ APIs for HID sensors
Message-ID: <20260927215731.59fdb69b@jic23-hlaptop>
In-Reply-To: <20260919-28-apr-iio-redundant-argument-v5-temp-v6-0-d577b2371b3c@gmail.com>
References: <20260919-28-apr-iio-redundant-argument-v5-temp-v6-0-d577b2371b3c@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Sep 2026 16:06:23 +0530
Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org> wrote:

> Following feedback from reviewers and Srinivas, v4 series was split
> into two additional sub-series to perform cleanup and preparatory work
> before adding devm support:
> - HID: iio: warning clean up and prefer kernel coding style
>   https://lore.kernel.org/all/20260707-15-jun-hid-iio-alignment-v3-0-8791574ad0fe@gmail.com/
> - HID: iio: basic clean up for usage_id
>   https://lore.kernel.org/all/20260610-6-june-hid-iio-correct-usage-id-v2-0-c3c5f0720493@gmail.com/
> 
> Both series have been merged into IIO tree. This series introduces
> device-managed APIs and converts HID IIO sensor drivers to use the new
> devm-managed resources.
> 
> checkpatch reports a "suspect code indent" warning on the DEFINE_FREE()
> declaration, but this appears to be a false positive caused by the macro
> expansion. The code builds cleanly.
If possible, Zhang Lixu, would you mind retesting this full set?

I think the more recent changes in this are unlikely to cause problems
but would also prefer to have some more tags on this in general before
I pick it up, so if Srinivas or anyone else has time to take a look
that would be great.

Thanks

Jonathan

> 
> Changes in v6:
> - Following input from Andy rectify kernel-doc for return
> - With input from Jonathan used devres framework implemetation with
>   cleanup helpder to reduce complexity and resource allocation.
> - Link to v5: https://patch.msgid.link/20260806-28-apr-iio-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com
> Changes in v5:
> - With input from Jonathan, convert all HID IIO drivers to use
>   fully devm instead of partial or specific API; this is potential
>   goal and validation on that will reduce multiple validation cycle.
> - Rebase changes on latest iio/testing tree and resolve merge conflict
> - Resolve mail client issue as v4 series was splitted into sub-series
> - Link to v5: https://lore.kernel.org/all/20260524192059.1193716-1-sanjayembedded@gmail.com/
> Changes in v4:
> - Extend the series to cover remaining HID IIO drivers with devm API usage
> - Reorder patches to place cleanup and warning fix at beginning and,
>   devm-related changes toward the end based on feedback from David
> - v3 series -> https://lore.kernel.org/all/20260509101040.791404-1-sanjayembedded@gmail.com/
> Changes in v3:
> - Added cleanup and prepratory changes before adding devm_ API
>   conversion based on self review: 0002, 0004, 0006, 0007 and 0008
> - Address andy's review comment on commit message and coding style
> - v2 series -> https://lore.kernel.org/all/20260429175918.2541914-1-sanjayembedded@gmail.com/
> Changes in v2:
> - Following input from Jonathan and Andy, squash initial patch v1
>   series in single change as individual change should not break anything
> - Add devm API support and two driver using the same
> - v1 series -> https://lore.kernel.org/all/20260428071613.1134053-1-sanjayembedded@gmail.com/
> 
> Testing:
>   - Compiled with W=1 for each patch in series
> PS:
> - Sashiko reported an issue in a different driver and noted that it is not
>   introduced by this series. I have taken this feedback into account and
>   will address the actual issue in a separate series focus on that driver.
> - Following input from Jonathan, will prepare followup series for
>   HID IIO drivers to consistency support for logs in probe() path
> 
> ---
> Sanjay Chitroda (14):
>       iio: hid-sensors: remove unused iio_dev argument
>       iio: hid-sensors: introduce device managed API
>       HID: hid-sensor-hub: introduce device managed API
>       iio: gyro: hid-sensor-gyro-3d: convert probe and teardown to devm-managed resources
>       iio: accel: hid-sensor-accel-3d: convert probe and teardown to devm-managed resources
>       iio: humidity: hid-sensor-humidity: convert probe and teardown to devm-managed resources
>       iio: light: hid-sensor-prox: convert probe and teardown to devm-managed resources
>       iio: light: hid-sensor-als: convert probe and teardown to devm-managed resources
>       iio: magnetometer: hid-sensor-magn-3d: convert probe and teardown to devm-managed resources
>       iio: orientation: hid-sensor-incl-3d: convert probe and teardown to devm-managed resources
>       iio: orientation: hid-sensor-rotation: convert probe and teardown to devm-managed resources
>       iio: position: hid-sensor-custom-intel-hinge: convert probe and teardown to devm-managed resources
>       iio: pressure: hid-sensor-press: convert probe and teardown to devm-managed resources
>       iio: temperature: hid-sensor-temperature: convert probe and teardown to devm-managed resources
> 
>  drivers/hid/hid-sensor-hub.c                       | 35 ++++++++++++++++++
>  drivers/iio/accel/hid-sensor-accel-3d.c            | 40 +++++----------------
>  .../iio/common/hid-sensors/hid-sensor-trigger.c    | 21 +++++++++--
>  .../iio/common/hid-sensors/hid-sensor-trigger.h    |  5 +--
>  drivers/iio/gyro/hid-sensor-gyro-3d.c              | 41 +++++----------------
>  drivers/iio/humidity/hid-sensor-humidity.c         | 38 +++++---------------
>  drivers/iio/light/hid-sensor-als.c                 | 39 +++++---------------
>  drivers/iio/light/hid-sensor-prox.c                | 40 +++++----------------
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c      | 41 +++++----------------
>  drivers/iio/orientation/hid-sensor-incl-3d.c       | 42 +++++-----------------
>  drivers/iio/orientation/hid-sensor-rotation.c      | 40 +++++----------------
>  .../iio/position/hid-sensor-custom-intel-hinge.c   | 38 ++++----------------
>  drivers/iio/pressure/hid-sensor-press.c            | 41 +++++----------------
>  drivers/iio/temperature/hid-sensor-temperature.c   | 39 +++++---------------
>  include/linux/hid-sensor-hub.h                     | 26 ++++++++++++++
>  15 files changed, 175 insertions(+), 351 deletions(-)
> ---
> base-commit: 9c464e7473f762cee4c031a09da04f65a1c65d49
> change-id: 20260603-28-apr-iio-redundant-argument-v5-temp-4e49eed863af
> 
> Best regards,
> --  
> Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> 

