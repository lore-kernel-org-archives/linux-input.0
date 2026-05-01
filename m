Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F119D38CFF1;
	Fri,  1 May 2026 11:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777636431; cv=none; b=VG1/YCNWmaP8alcUg40opdKcSUbIrmYETCn1Qblcz2oclBFOkcAqPG60/Qd1Xilweq5n3BsBh+YX6Xto/3TmpmrEBGB3uWwLdWh2aufhFtpb+AQ+hioMq2wDpuXjCMZChEn8QA/ziu5YhqE683kHcKeVhN2SMqR97lqX4M0ANA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777636431; c=relaxed/simple;
	bh=3pxpCNf+ef0ocrUA+f82Nd4u4cD+I9MZYEJbEcUssN8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NsIQRVoBJFOrtpf2jOnjD9JWfwmbtBwfDaeotTHjEppJRwYXIHYWdiRoki12Qu/PjrlcvNRuYJU9y5kT0F0Lfrn8oLCqrYVaAli4cVIowbjqABl87yCHZSm8N66zyx0d6UYgLBOgVgrDbWCYVPHXVFKbv2oF3W33r+NW8Fpg9oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gc/S8lOQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gc/S8lOQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777636430; x=1809172430;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=3pxpCNf+ef0ocrUA+f82Nd4u4cD+I9MZYEJbEcUssN8=;
  b=gc/S8lOQuSk68QOcUyLGVtBK4GuMNWdrkLfYqz6u2dxyijXxjBcYLzcU
   4NO4bl7xK59z55kh2MsX9Ow4/57idrrdss+F2ttRFJ12155LpdZQOv8Ar
   86sqWMze33Mxko1fX3Phn14eGMBI7AOV5HJy9o/832yDor0eeGgQ4PYpE
   ycsU953GvagFUUuwQWBM5IFK2Sy/Z9g9u/33+WVkl9JhbNozqUxi1Om7D
   jyV/H8lBiQWRUs/7DHwfa1TczVb++BgYAn7XdWhGtCODzGEgtOnfFPF7p
   vudu3q//eNVE3V2X4g0eeb4PCG3J/LSPg61Nls1iweIgpuvdOhDvaIYcH
   Q==;
X-CSE-ConnectionGUID: ccMTBsZcRM6zjryDpYOZQQ==
X-CSE-MsgGUID: +zq/Z3JIT7a69xryAeENjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="101261474"
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; 
   d="scan'208";a="101261474"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2026 04:53:50 -0700
X-CSE-ConnectionGUID: gum3g4pZSPyNqTubLjEy8g==
X-CSE-MsgGUID: qWfDuUcWTOC8MJMkwPriZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,210,1770624000"; 
   d="scan'208";a="258197893"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.109.137]) ([10.125.109.137])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2026 04:53:47 -0700
Message-ID: <15509f5e5a6642d2a4b0ccc13bc7d40d3b79f72a.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/4] iio: introduce devm_ API for hid sensro setup
 and cleanup
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jikos@kernel.org, 
	jic23@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	sakari.ailus@linux.intel.com, linux-input@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Lixu
	 <lixu.zhang@intel.com>
Date: Fri, 01 May 2026 04:53:38 -0700
In-Reply-To: <20260429175918.2541914-1-sanjayembedded@gmail.com>
References: <20260429175918.2541914-1-sanjayembedded@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

+ Lixu

On Wed, 2026-04-29 at 23:29 +0530, Sanjay Chitroda wrote:
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>=20
> Key highlights:
> - Prepare change as pre-requisite for devm conversion for HID IIO
> =C2=A0 drivers by removing redundant argument
> - Add devm API to setup trigger and clenaup resource using
> =C2=A0 devm_add_action_or_reset()
> - few sample driver update using devm conversion to auto release
> resource
>=20

devm_* calls are fine but needs tests particularly when forces ISH PCI
drivers unbind, while iio-sensor-proxy has open sessions.

Lixu, Please check.

Thanks,
Srinivas



> changes in v2:
> - Following input from Jonathan and Andy, squash initial patch v1
> =C2=A0 series in single change as individual change should not break
> anything
> - Add devm API support and two driver using the same
> - v1 series ->
> https://lore.kernel.org/all/20260428071613.1134053-1-sanjayembedded@gmail=
.com/
>=20
> Testing:
> =C2=A0 - Compiled with W=3D1
> =C2=A0 - Build-tested on QEMU x86_64
>=20
> Based on further feedback and reviews, I would extend this series to
> convert all HID IIO driver to use devm_* API.
>=20
> Thanks,
> Sanjay Chitroda
>=20
> Sanjay Chitroda (4):
> =C2=A0 iio: hid-sensors: drop redundant iio_dev argument
> =C2=A0 iio: hid-sensors: introduce device managed API
> =C2=A0 iio: gyro: drop hid_sensor_remove_trigger() using devm API
> =C2=A0 iio: humidity: drop hid_sensor_remove_trigger() using devm API
>=20
> =C2=A0drivers/iio/accel/hid-sensor-accel-3d.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 4 +--
> =C2=A0.../common/hid-sensors/hid-sensor-trigger.c=C2=A0=C2=A0 | 27
> +++++++++++++++++--
> =C2=A0.../common/hid-sensors/hid-sensor-trigger.h=C2=A0=C2=A0 |=C2=A0 5 +=
+--
> =C2=A0drivers/iio/gyro/hid-sensor-gyro-3d.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 10 +++----
> =C2=A0drivers/iio/humidity/hid-sensor-humidity.c=C2=A0=C2=A0=C2=A0 | 10 +=
++----
> =C2=A0drivers/iio/light/hid-sensor-als.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +--
> =C2=A0drivers/iio/light/hid-sensor-prox.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +--
> =C2=A0drivers/iio/magnetometer/hid-sensor-magn-3d.c |=C2=A0 4 +--
> =C2=A0drivers/iio/orientation/hid-sensor-incl-3d.c=C2=A0 |=C2=A0 4 +--
> =C2=A0drivers/iio/orientation/hid-sensor-rotation.c |=C2=A0 4 +--
> =C2=A0.../position/hid-sensor-custom-intel-hinge.c=C2=A0 |=C2=A0 4 +--
> =C2=A0drivers/iio/pressure/hid-sensor-press.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 4 +--
> =C2=A0.../iio/temperature/hid-sensor-temperature.c=C2=A0 |=C2=A0 4 +--
> =C2=A013 files changed, 52 insertions(+), 36 deletions(-)
>=20
>=20
> base-commit: eade2b843d9b1f668fc1775f15611bb0a1999cd9
