Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FCA3DA7DD;
	Mon,  1 Jun 2026 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780329325; cv=none; b=EhIWvxfaGrI8QyR1VULB1cLtw5c0IvZXGqPljOAac2xryFL0x3GOAYqgBuRTfQnM2hCG/k2Ah105f8pYFvoJ/gUSvRl7BPYZKdK7DpzdVGeURvrS8O75Vk6XvgmLsqJtWJQuHQMx9p/f88vbYsWIjNkXz2KRGE3r59MCYIXqKLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780329325; c=relaxed/simple;
	bh=mLqDl3a49VIXDatxy/+CGtSHiBM0Ncvzdft4zHY4AxY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ib33xl0nMq+hqZ81jIB8HrzyENtdSkfoX1ZjCXfL1V85zRXtjpwTyKeMAmP5yZNeAmjzSUA9mx2r4hvpTY4C2EE0nTLNeQBxnNhhaWf3pThIxPdtmWeywB8rLjCvIxf6ElkbFMoy2EVZeQjgfah30KltbtteSNttHAG2CQfM++w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mgwMwQmd; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mgwMwQmd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780329324; x=1811865324;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=mLqDl3a49VIXDatxy/+CGtSHiBM0Ncvzdft4zHY4AxY=;
  b=mgwMwQmdoyv6R5Dyk1XPPMqlxxp7555zmYT5m1WziI0kv4UpzOw1i5By
   kgW0cWVjw/lkFMBeOmljta7FGGf8Qb4HfgqtA79togQPidGdd2h/Hrszo
   b2Z0ZvOwlVQx9rnlZlQtcc7KF/nRtS64WVUQkt4D5clCpbwZmianGZHhD
   gLFv/3HJX3fQJ1bVo801r7jQf6n+YX52Kw3VQ6QMsQ9bvN8ptlqzDad/g
   oSiGjoiTZt7aqY6AS3Z0vv4dFU8BndlFpCXkkqwJGaiwMDYfb8B6m5ZnT
   VgMf3kPakLPoMKzt8eTUnZtenwH0zTE6bl3TUbHnPiWE42fNfJVn38d9o
   Q==;
X-CSE-ConnectionGUID: dQ+zakLHSDab1BOcvfzXnw==
X-CSE-MsgGUID: 0xflDwwlQwCFxaZZ9KOomw==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="98507576"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="98507576"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 08:55:23 -0700
X-CSE-ConnectionGUID: VSCiugJST2GZKtmj2sL78g==
X-CSE-MsgGUID: QDYScdRMT5ydvtwqHoiTQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="267251646"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 08:55:22 -0700
Message-ID: <ab0799c5df94bc5a47327486d544c5b786e10a79.camel@linux.intel.com>
Subject: Re: [PATCH v4 00/36] HID: iio: basic clean up and introduce devm_
 API for HID sensors
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>, Sanjay Chitroda
	 <sanjayembeddedse@gmail.com>
Cc: jikos@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, 	sakari.ailus@linux.intel.com,
 linux-input@vger.kernel.org, 	linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 01 Jun 2026 08:55:22 -0700
In-Reply-To: <20260526165639.42d6e98e@jic23-huawei>
References: <20260524192059.1193716-1-sanjayembedded@gmail.com>
	 <20260526165639.42d6e98e@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-26 at 16:56 +0100, Jonathan Cameron wrote:
> On Mon, 25 May 2026 00:50:23 +0530
> Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:
>=20
> > From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >=20
> > Key highlights:
> > - 0000-0024: General cleanup and kernel few coding style fixes
> > across HID IIO drivers
> > - 0025: Remove unused iio_dev argument from HID IIO sensor helper
> > - 0026: Introduce devm_hid_sensor_setup_trigger() device-managed
> > API
> > - 0027-0036: Convert HID IIO sensor drivers to use the new devm-
> > based trigger setup
> >=20
> > changes in v4:
> > - Extend the series to cover remaining HID IIO drivers with devm
> > API usage
> > - Reorder patches to place cleanup and warning fix at beginning
> > and,
> > =C2=A0 devm-related changes toward the end based on feedback from David
> > - v3 series ->
> > https://lore.kernel.org/all/20260509101040.791404-1-sanjayembedded@gmai=
l.com/
> > changes in v3:
> > - Added cleanup and prepratory changes before adding devm_ API
> > =C2=A0 conversion based on self review: 0002, 0004, 0006, 0007 and 0008
> > - Address andy's review comment on commit message and coding style
> > - v2 series ->
> > https://lore.kernel.org/all/20260429175918.2541914-1-sanjayembedded@gma=
il.com/
> > changes in v2:
> > - Following input from Jonathan and Andy, squash initial patch v1
> > =C2=A0 series in single change as individual change should not break
> > anything
> > - Add devm API support and two driver using the same
> > - v1 series ->
> > https://lore.kernel.org/all/20260428071613.1134053-1-sanjayembedded@gma=
il.com/
> >=20
> > Testing:
> > =C2=A0 - Compiled with W=3D1 for each patch in series
> > =C2=A0 - Build-tested on QEMU x86_64
> >=20
> > P.S.
> > - Sashiko reported an issue in a different driver and noted that it
> > is not
> > =C2=A0 introduced by this series. I have taken this feedback into
> > account and
> > =C2=A0 will address the actual issue in a separate series focus on that
> > driver.
> > - Once this series is merged into the IIO tree, a number of HID IIO
> > =C2=A0 drivers will become available to fully converted to devm API
> > usage.
> > - The changes are organized across drivers to keep similar
> > modifications
> > =C2=A0 grouped together for consistency, making the series easier to
> > review,
> > =C2=A0 rather than grouping all changes per driver.
> >=20
> The series is mostly fine, though not sure what happened with how you
> sent
> it as I have it in seperate threads of 10 patches at a time. If you
> are having
> email troubles with big series, use b4 to send them instead
> (instructions on kernel.org)
>=20
> My main concern is this is a lot of churn on a critical driver. I'd
> like therefore
> to be able to see the full benefit of those devm patches rather than
> get us
> part way as this does.
>=20

I am not able to apply this patchset cleanly on 7.1-rc6. This series
does formatting changes, u32 changes and devm changes. Atleast three
different series will be better.

Thanks,
Srinivas


> Jonathan
>=20
> > Thanks,
> > Sanjay Chitroda
> >=20
> > Sanjay Chitroda (36):
> > =C2=A0 iio: hid-sensors: add missing blank line after declarations
> > =C2=A0 iio: gyro: hid-sensor-gyro-3d: use u32 instead of unsigned
> > =C2=A0 iio: accel: hid-sensor-accel-3d: use u32 instead of unsigned
> > =C2=A0 iio: light: hid-sensor-als: use u32 instead of unsigned
> > =C2=A0 iio: light: hid-sensor-prox: use u32 instead of unsigned
> > =C2=A0 iio: orientation: hid-sensor-incl-3d: use u32 instead of unsigne=
d
> > =C2=A0 iio: orientation: hid-sensor-rotation: use u32 instead of
> > unsigned
> > =C2=A0 iio: pressure: hid-sensor-press: use u32 instead of unsigned
> > =C2=A0 iio: humidity: hid-sensor-humidity: align parenthesis for
> > readability
> > =C2=A0 iio: gyro: hid-sensor-gyro-3d: align parenthesis for readability
> > =C2=A0 iio: magnetometer: hid-sensor-magn-3d: align parenthesis for
> > =C2=A0=C2=A0=C2=A0 readability
> > =C2=A0 iio: humidity: hid-sensor-humidity: use common device for devres
> > =C2=A0 iio: position: hid-sensor-custom-intel-hinge: use common device
> > for
> > =C2=A0=C2=A0=C2=A0 devres
> > =C2=A0 iio: temperature: hid-sensor-temperature: use common device for
> > devres
> > =C2=A0 iio: humidity: hid-sensor-humidity: use local struct device
> > =C2=A0 iio: gyro: hid-sensor-gyro-3d: use local struct device
> > =C2=A0 iio: accel: hid-sensor-accel-3d: use local struct device
> > =C2=A0 iio: light: hid-sensor-als: use local struct device
> > =C2=A0 iio: light: hid-sensor-prox: use local struct device
> > =C2=A0 iio: magnetometer: hid-sensor-magn-3d: use local struct device
> > =C2=A0 iio: orientation: hid-sensor-incl-3d: use local struct device
> > =C2=A0 iio: orientation: hid-sensor-rotation: use local struct device
> > =C2=A0 iio: position: hid-sensor-custom-intel-hinge: use local struct
> > device
> > =C2=A0 iio: pressure: hid-sensor-press: use local struct device
> > =C2=A0 iio: hid-sensors: remove unused iio_dev argument
> > =C2=A0 iio: hid-sensors: introduce device managed API
> > =C2=A0 iio: gyro: hid-sensor-gyro-3d: drop hid_sensor_remove_trigger()
> > using
> > =C2=A0=C2=A0=C2=A0 devm API
> > =C2=A0 iio: humidity: hid-sensor-humidity: drop
> > hid_sensor_remove_trigger()
> > =C2=A0=C2=A0=C2=A0 using devm API
> > =C2=A0 iio: light: hid-sensor-prox: drop hid_sensor_remove_trigger()
> > using
> > =C2=A0=C2=A0=C2=A0 devm API
> > =C2=A0 iio: light: hid-sensor-als: drop hid_sensor_remove_trigger()
> > using
> > =C2=A0=C2=A0=C2=A0 devm API
> > =C2=A0 iio: magnetometer: hid-sensor-magn-3d: drop
> > =C2=A0=C2=A0=C2=A0 hid_sensor_remove_trigger() using devm API
> > =C2=A0 iio: orientation: hid-sensor-incl-3d: drop
> > hid_sensor_remove_trigger()
> > =C2=A0=C2=A0=C2=A0 using devm API
> > =C2=A0 iio: orientation: hid-sensor-rotation: drop
> > =C2=A0=C2=A0=C2=A0 hid_sensor_remove_trigger() using devm API
> > =C2=A0 iio: position: hid-sensor-custom-intel-hinge: drop
> > =C2=A0=C2=A0=C2=A0 hid_sensor_remove_trigger() using devm API
> > =C2=A0 iio: pressure: hid-sensor-press: drop hid_sensor_remove_trigger(=
)
> > =C2=A0=C2=A0=C2=A0 using devm API
> > =C2=A0 iio: temperature: hid-sensor-temperature: drop
> > =C2=A0=C2=A0=C2=A0 hid_sensor_remove_trigger() using devm API
> >=20
> > =C2=A0drivers/iio/accel/hid-sensor-accel-3d.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 30 ++---
> > =C2=A0.../common/hid-sensors/hid-sensor-trigger.c=C2=A0=C2=A0 |=C2=A0 2=
4 +++-
> > =C2=A0.../common/hid-sensors/hid-sensor-trigger.h=C2=A0=C2=A0 |=C2=A0=
=C2=A0 5 +-
> > =C2=A0drivers/iio/gyro/hid-sensor-gyro-3d.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 96 ++++++++------
> > -
> > =C2=A0drivers/iio/humidity/hid-sensor-humidity.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 61 +++++-----
> > =C2=A0drivers/iio/light/hid-sensor-als.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 31 +++--
> > =C2=A0drivers/iio/light/hid-sensor-prox.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 30 ++---
> > =C2=A0drivers/iio/magnetometer/hid-sensor-magn-3d.c | 112 +++++++++----=
-
> > ----
> > =C2=A0drivers/iio/orientation/hid-sensor-incl-3d.c=C2=A0 |=C2=A0 36 +++=
---
> > =C2=A0drivers/iio/orientation/hid-sensor-rotation.c |=C2=A0 38 +++---
> > =C2=A0.../position/hid-sensor-custom-intel-hinge.c=C2=A0 |=C2=A0 27 ++-=
--
> > =C2=A0drivers/iio/pressure/hid-sensor-press.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 36 +++---
> > =C2=A0.../iio/temperature/hid-sensor-temperature.c=C2=A0 |=C2=A0 15 +--
> > =C2=A013 files changed, 264 insertions(+), 277 deletions(-)
> >=20
> >=20
> > base-commit: 08297ca8422541dde6c8b7e6b1d68bd4aa4568ef
