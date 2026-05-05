Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49EF48C8A7;
	Tue,  5 May 2026 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998791; cv=none; b=m3mMX0ci/zCNLwQBEPQxd46CWzl4A6QIFARDxZXZCkkupQVbcZfiRr+wxledJcLNnYbFnZc0i8aAW3AOdc5t8Zfj7E1sz87akr8kMMAy75i3caBtGaABkyhSebQwm1wEc+RxXJ8z0p9wWSUATfbtSGSPHVDWwkolIoSy+4IDqeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998791; c=relaxed/simple;
	bh=U17EG3HOWP36m/HDxfx21lLXOvjQsut6iMc07XDh1hY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mI+eYe+HjM3pW1E1oc6NiZCwKZuAJ7oay4Zga/QHWEx1G5xUgl65myfwYsOklzSsYFU5uIrnbkNKXRz6m40GZ/FQ4UhcO8U2TEfGz42jFvxo2N6zSm2C1pI377SVeYpO5NpGnv4nbrGzlZ2L5gocK+7aIL2AgbSpHZBBksHudgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fw7HYll8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fw7HYll8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38116C2BCB4;
	Tue,  5 May 2026 16:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777998791;
	bh=U17EG3HOWP36m/HDxfx21lLXOvjQsut6iMc07XDh1hY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fw7HYll8E52jr+7TP5sKizwj2pnOqqvpaX0/uz9rdA2NSelwsuZ8z8VvCDc9CfJbF
	 kQQv8eqtDlpJp2AV1rfNFnkBZ9ZsF0kILJZKUCHOMt5QxKlJV+ctJX31/2Nwfb57Sx
	 Ah1syEVKOVAG8D+y88BtixxZSmUHsJOOdQSSOcKUUXKDh9Q3FvNnRkDZulLlGhHDJ0
	 t+VuFcvsdmynDdgPQFSQkaxkRIl9mnf4DuVe4bHFuvG7xMoZm+B5TxNgSGdPFrRDGV
	 MCkqi2TQ/+4yLIewUxd+PAurVx9zxLhxmDl01rtG94UcHdFGceLTDMr0FBAkInjSii
	 IqMi3bhZzfnPA==
Date: Tue, 5 May 2026 17:33:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jikos@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 sakari.ailus@linux.intel.com, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Lixu 
 <lixu.zhang@intel.com>
Subject: Re: [PATCH v2 0/4] iio: introduce devm_ API for hid sensro setup
 and cleanup
Message-ID: <20260505173302.4284a077@jic23-huawei>
In-Reply-To: <15509f5e5a6642d2a4b0ccc13bc7d40d3b79f72a.camel@linux.intel.com>
References: <20260429175918.2541914-1-sanjayembedded@gmail.com>
	<15509f5e5a6642d2a4b0ccc13bc7d40d3b79f72a.camel@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 01 May 2026 04:53:38 -0700
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> + Lixu
>=20
> On Wed, 2026-04-29 at 23:29 +0530, Sanjay Chitroda wrote:
> > From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >=20
> > Key highlights:
> > - Prepare change as pre-requisite for devm conversion for HID IIO
> > =C2=A0 drivers by removing redundant argument
> > - Add devm API to setup trigger and clenaup resource using
> > =C2=A0 devm_add_action_or_reset()
> > - few sample driver update using devm conversion to auto release
> > resource
> >  =20
>=20
> devm_* calls are fine but needs tests particularly when forces ISH PCI
> drivers unbind, while iio-sensor-proxy has open sessions.
>=20
> Lixu, Please check.
Hold off perhaps until we have a v3 with fixes for the existing devm
calls against wrong struct device.

Thanks,

Jonathan

>=20
> Thanks,
> Srinivas
>=20
>=20
>=20
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
> > =C2=A0 - Compiled with W=3D1
> > =C2=A0 - Build-tested on QEMU x86_64
> >=20
> > Based on further feedback and reviews, I would extend this series to
> > convert all HID IIO driver to use devm_* API.
> >=20
> > Thanks,
> > Sanjay Chitroda
> >=20
> > Sanjay Chitroda (4):
> > =C2=A0 iio: hid-sensors: drop redundant iio_dev argument
> > =C2=A0 iio: hid-sensors: introduce device managed API
> > =C2=A0 iio: gyro: drop hid_sensor_remove_trigger() using devm API
> > =C2=A0 iio: humidity: drop hid_sensor_remove_trigger() using devm API
> >=20
> > =C2=A0drivers/iio/accel/hid-sensor-accel-3d.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 4 +--
> > =C2=A0.../common/hid-sensors/hid-sensor-trigger.c=C2=A0=C2=A0 | 27
> > +++++++++++++++++--
> > =C2=A0.../common/hid-sensors/hid-sensor-trigger.h=C2=A0=C2=A0 |=C2=A0 5=
 ++--
> > =C2=A0drivers/iio/gyro/hid-sensor-gyro-3d.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 10 +++----
> > =C2=A0drivers/iio/humidity/hid-sensor-humidity.c=C2=A0=C2=A0=C2=A0 | 10=
 +++----
> > =C2=A0drivers/iio/light/hid-sensor-als.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +--
> > =C2=A0drivers/iio/light/hid-sensor-prox.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +--
> > =C2=A0drivers/iio/magnetometer/hid-sensor-magn-3d.c |=C2=A0 4 +--
> > =C2=A0drivers/iio/orientation/hid-sensor-incl-3d.c=C2=A0 |=C2=A0 4 +--
> > =C2=A0drivers/iio/orientation/hid-sensor-rotation.c |=C2=A0 4 +--
> > =C2=A0.../position/hid-sensor-custom-intel-hinge.c=C2=A0 |=C2=A0 4 +--
> > =C2=A0drivers/iio/pressure/hid-sensor-press.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 4 +--
> > =C2=A0.../iio/temperature/hid-sensor-temperature.c=C2=A0 |=C2=A0 4 +--
> > =C2=A013 files changed, 52 insertions(+), 36 deletions(-)
> >=20
> >=20
> > base-commit: eade2b843d9b1f668fc1775f15611bb0a1999cd9 =20

