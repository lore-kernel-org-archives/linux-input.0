Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0565E38E8DA;
	Tue, 26 May 2026 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811022; cv=none; b=pWWfncZAR/AwWylYxbDIe6HKRXHCX9FpAqagQ5WL2ynvKPOzC/8+wsd/r8lEoHuHKML3V94oFsd5OZNIRe/UtNERoyEmPf9l7Hps8vnv4ZwSFSbU40mjAUEVFTV/j9m1d73WFxRW9kVzJF9lTlU2QahsRM4H7XNubxCtHsxEO50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811022; c=relaxed/simple;
	bh=TfMUEsq25Q93mzr9mFA1ofwJi1FfPzLGm8yvH8lCgE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fzFEvTSQ7WppJxSPCdDJauVNxIhST2PnDfyT8M0WooUMSpZzguu5zKIG9IhyhhRWwBmiN6vg6imjlATVWHzaSdo1e5543icYB83SgCJAQkkElSIqssi8a5bZXjJdw1y0uXJQqt92c0MuU6ezL4lQ4RNRP4my8iLS+U2oXSMnpQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duPGICa8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duPGICa8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00681F000E9;
	Tue, 26 May 2026 15:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811020;
	bh=s9xqY+VFGX/9iSHd3IwkLS1Zup6Bikr9onIme4Sv80U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=duPGICa8nsQElZrGZp1BYWnJTzuRIYQTA2yc0sO6bg6qLomL5FyVJoib/VdNVYZIv
	 jMOwF8aoHfvTsq6NS3GSOQuMlqa6lA262Uq2NkOmUUS+Dl2j/YfojsQAhEuaASE9vm
	 1rPqZzbe2Gc1iroIqvO3TkDXLEoWrL2pEXerl1N6g20vDFpC7O6VDgKTVwkZ7EQgiM
	 BU6mjbfmMVqEJ5pg6xkvawhgnUEC1wXH7f6EoVH86jYGRavseCDTxDhkoENpOJVZFl
	 YzWqpzQv1TzSV8RXOp0LDEMHgp97P4erHYrLF6/AGYXxEbuoX2av1mhoJMQ77llu4A
	 9xRfnxcPz12CA==
Date: Tue, 26 May 2026 16:56:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 sakari.ailus@linux.intel.com, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/36] HID: iio: basic clean up and introduce devm_
 API for HID sensors
Message-ID: <20260526165639.42d6e98e@jic23-huawei>
In-Reply-To: <20260524192059.1193716-1-sanjayembedded@gmail.com>
References: <20260524192059.1193716-1-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 00:50:23 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Key highlights:
> - 0000-0024: General cleanup and kernel few coding style fixes across HID IIO drivers
> - 0025: Remove unused iio_dev argument from HID IIO sensor helper
> - 0026: Introduce devm_hid_sensor_setup_trigger() device-managed API
> - 0027-0036: Convert HID IIO sensor drivers to use the new devm-based trigger setup
> 
> changes in v4:
> - Extend the series to cover remaining HID IIO drivers with devm API usage
> - Reorder patches to place cleanup and warning fix at beginning and,
>   devm-related changes toward the end based on feedback from David
> - v3 series -> https://lore.kernel.org/all/20260509101040.791404-1-sanjayembedded@gmail.com/
> changes in v3:
> - Added cleanup and prepratory changes before adding devm_ API
>   conversion based on self review: 0002, 0004, 0006, 0007 and 0008
> - Address andy's review comment on commit message and coding style
> - v2 series -> https://lore.kernel.org/all/20260429175918.2541914-1-sanjayembedded@gmail.com/
> changes in v2:
> - Following input from Jonathan and Andy, squash initial patch v1
>   series in single change as individual change should not break anything
> - Add devm API support and two driver using the same
> - v1 series -> https://lore.kernel.org/all/20260428071613.1134053-1-sanjayembedded@gmail.com/
> 
> Testing:
>   - Compiled with W=1 for each patch in series
>   - Build-tested on QEMU x86_64
> 
> P.S.
> - Sashiko reported an issue in a different driver and noted that it is not
>   introduced by this series. I have taken this feedback into account and
>   will address the actual issue in a separate series focus on that driver.
> - Once this series is merged into the IIO tree, a number of HID IIO
>   drivers will become available to fully converted to devm API usage.
> - The changes are organized across drivers to keep similar modifications
>   grouped together for consistency, making the series easier to review,
>   rather than grouping all changes per driver.
> 
The series is mostly fine, though not sure what happened with how you sent
it as I have it in seperate threads of 10 patches at a time. If you are having
email troubles with big series, use b4 to send them instead (instructions on kernel.org)

My main concern is this is a lot of churn on a critical driver. I'd like therefore
to be able to see the full benefit of those devm patches rather than get us
part way as this does.

Jonathan

> Thanks,
> Sanjay Chitroda
> 
> Sanjay Chitroda (36):
>   iio: hid-sensors: add missing blank line after declarations
>   iio: gyro: hid-sensor-gyro-3d: use u32 instead of unsigned
>   iio: accel: hid-sensor-accel-3d: use u32 instead of unsigned
>   iio: light: hid-sensor-als: use u32 instead of unsigned
>   iio: light: hid-sensor-prox: use u32 instead of unsigned
>   iio: orientation: hid-sensor-incl-3d: use u32 instead of unsigned
>   iio: orientation: hid-sensor-rotation: use u32 instead of unsigned
>   iio: pressure: hid-sensor-press: use u32 instead of unsigned
>   iio: humidity: hid-sensor-humidity: align parenthesis for readability
>   iio: gyro: hid-sensor-gyro-3d: align parenthesis for readability
>   iio: magnetometer: hid-sensor-magn-3d: align parenthesis for
>     readability
>   iio: humidity: hid-sensor-humidity: use common device for devres
>   iio: position: hid-sensor-custom-intel-hinge: use common device for
>     devres
>   iio: temperature: hid-sensor-temperature: use common device for devres
>   iio: humidity: hid-sensor-humidity: use local struct device
>   iio: gyro: hid-sensor-gyro-3d: use local struct device
>   iio: accel: hid-sensor-accel-3d: use local struct device
>   iio: light: hid-sensor-als: use local struct device
>   iio: light: hid-sensor-prox: use local struct device
>   iio: magnetometer: hid-sensor-magn-3d: use local struct device
>   iio: orientation: hid-sensor-incl-3d: use local struct device
>   iio: orientation: hid-sensor-rotation: use local struct device
>   iio: position: hid-sensor-custom-intel-hinge: use local struct device
>   iio: pressure: hid-sensor-press: use local struct device
>   iio: hid-sensors: remove unused iio_dev argument
>   iio: hid-sensors: introduce device managed API
>   iio: gyro: hid-sensor-gyro-3d: drop hid_sensor_remove_trigger() using
>     devm API
>   iio: humidity: hid-sensor-humidity: drop hid_sensor_remove_trigger()
>     using devm API
>   iio: light: hid-sensor-prox: drop hid_sensor_remove_trigger() using
>     devm API
>   iio: light: hid-sensor-als: drop hid_sensor_remove_trigger() using
>     devm API
>   iio: magnetometer: hid-sensor-magn-3d: drop
>     hid_sensor_remove_trigger() using devm API
>   iio: orientation: hid-sensor-incl-3d: drop hid_sensor_remove_trigger()
>     using devm API
>   iio: orientation: hid-sensor-rotation: drop
>     hid_sensor_remove_trigger() using devm API
>   iio: position: hid-sensor-custom-intel-hinge: drop
>     hid_sensor_remove_trigger() using devm API
>   iio: pressure: hid-sensor-press: drop hid_sensor_remove_trigger()
>     using devm API
>   iio: temperature: hid-sensor-temperature: drop
>     hid_sensor_remove_trigger() using devm API
> 
>  drivers/iio/accel/hid-sensor-accel-3d.c       |  30 ++---
>  .../common/hid-sensors/hid-sensor-trigger.c   |  24 +++-
>  .../common/hid-sensors/hid-sensor-trigger.h   |   5 +-
>  drivers/iio/gyro/hid-sensor-gyro-3d.c         |  96 ++++++++-------
>  drivers/iio/humidity/hid-sensor-humidity.c    |  61 +++++-----
>  drivers/iio/light/hid-sensor-als.c            |  31 +++--
>  drivers/iio/light/hid-sensor-prox.c           |  30 ++---
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c | 112 +++++++++---------
>  drivers/iio/orientation/hid-sensor-incl-3d.c  |  36 +++---
>  drivers/iio/orientation/hid-sensor-rotation.c |  38 +++---
>  .../position/hid-sensor-custom-intel-hinge.c  |  27 ++---
>  drivers/iio/pressure/hid-sensor-press.c       |  36 +++---
>  .../iio/temperature/hid-sensor-temperature.c  |  15 +--
>  13 files changed, 264 insertions(+), 277 deletions(-)
> 
> 
> base-commit: 08297ca8422541dde6c8b7e6b1d68bd4aa4568ef

