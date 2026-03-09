Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23143DA7E5;
	Mon,  9 Mar 2026 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070948; cv=none; b=leuRs2XdBHxSKBu0en2ArxlTorgouxUvHrYQsUaN8mJWWokBzW6fY5ukudmYRuehU66F8vEB4LCpmlXQvZwWjJDMEYvX6/Q4WvUMOmdvrI7+fUUcaiLJKgSGBkAT7NtOemyIWw9DoBqHJqLuvWCyUcXSuo8D3JXOG3G33REenJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070948; c=relaxed/simple;
	bh=+5JCVJB1rmmmycSnyjMmr8SN4oSzdN8sAtx7nSf9j5I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rqs0pyIT+4vGu1AtqAT3kGYo/pG/uPWnM7G8Qbub98ZHBqlupppUrSY3nZeOsfYvXj+C0Hm3T1CI4XFsy1sUYmViViXcxc9+mdP237dTcIAMPJonF9YQTBvT6N1FcsHpPlspHmbKZqZIL4fo2RGXPcfZg01Y197my9oQm0yNZx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LtLk7gG+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LtLk7gG+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773070946; x=1804606946;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=+5JCVJB1rmmmycSnyjMmr8SN4oSzdN8sAtx7nSf9j5I=;
  b=LtLk7gG+XjxlHPtnDaYAEXtZm/D8C4gs0/N/CCPtPfMy9wKxHZA40z1e
   vSV0sgjL+ida2GSVD74DHXF8LJXrnBP2myZp0JE4M6fDyJSg+QWUHeV28
   KpFAqmVdV0/j1bdiq41mCL8AVo9AwG3i7ww3D7Ky+C/XepJUqb/CSVN2I
   7OYab8Rm0uksckH6trjhWDwRNjEsiDKFCbxupbEkboRU/UcEpIjX9pm+P
   3hM/sT5eq9Q5csVs4jyPFI7guSrHq8urxMqPvbM4h/3/RfJdHqb4iasbD
   Jr2s5j7st9QUKOOv+exEO7BDM+XV9Yd/h5V/mcRqwWAXa5OgGtdpDppGK
   Q==;
X-CSE-ConnectionGUID: /ai5dwoPRp2jg9NIWCxLJg==
X-CSE-MsgGUID: eyPf/yq6QA+X5PH+144yjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="77976614"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="77976614"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 08:42:25 -0700
X-CSE-ConnectionGUID: Qz/HVf71R4akc84jFNGQvQ==
X-CSE-MsgGUID: 0bO/5/rURSS4IaFBo//lHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="219730753"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 08:42:25 -0700
Message-ID: <4695861781487359fddc6cb8aab932c70cb8ebba.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] iio: hid-sensor-gyro-3d: move iio_device_register()
 to end of probe()
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>, Bhargav Joshi
	 <rougueprince47@gmail.com>
Cc: jikos@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, 	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org
Date: Mon, 09 Mar 2026 08:42:24 -0700
In-Reply-To: <20260307142153.26bab5b0@jic23-huawei>
References: <20260228191400.19244-1-rougueprince47@gmail.com>
		<20260228191400.19244-2-rougueprince47@gmail.com>
		<20260301114450.17f79213@jic23-huawei>
		<CAPC4XCRom4ri1QKw_mTnZGc9np5XFD1LskQnd=ssDAKBdOkGmQ@mail.gmail.com>
	 <20260307142153.26bab5b0@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-03-07 at 14:21 +0000, Jonathan Cameron wrote:
> On Mon, 2 Mar 2026 01:00:06 +0530
> Bhargav Joshi <rougueprince47@gmail.com> wrote:
>=20
> > On Sun, Mar 1, 2026 at 5:15=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg>
> > wrote:
> > >=20
> > > On Sun,=C2=A0 1 Mar 2026 00:43:59 +0530
> > > Bhargav Joshi <rougueprince47@gmail.com> wrote:
> > > =C2=A0
> > > > Currently, calling iio_device_register() before
> > > > sensor_hub_register_callback() may create a race condition
> > > > where the
> > > > device is exposed to userspace before callbacks are wired.=C2=A0=
=20
> > >=20
> > > We needs some more here on 'why' this is a problem.
> > > Whilst this is an unusual arrangement, I couldn't immediately
> > > find
> > > anything that was actually broken.=C2=A0 It's possible data will turn
> > > up
> > > after we tear down the callbacks and before the userspace
> > > interfaces
> > > are removed, but I think that just results in dropping data.
> > > Given it's
> > > in a race anyway I don't think we care about that. The callbacks
> > > don't seem to be involved in device configuration which can go on
> > > whether
> > > or not the callbacks are registered.=C2=A0 Maybe there is something
> > > that
> > > won't get acknowledged if they aren't in place in time?
> > >=20
> > > For a fix like this we'd normally want to see a clear flow that
> > > leads to a bug.
> > >=20
> > > Also a fixes tag so we know how far to backport.
> > > =C2=A0
> >=20
> > Hi Jonathan,
> >=20
> > I originally submitted the patch for the driver because calling
> > iio_device_register() before the callbacks are wired up violates
> > standard IIO LIFO ordering. I assumed this created a dangerous race
> > condition with userspace. However, as you correctly pointed out,
> > the
> > HID sensor hub safely drops those early events without crashing,
> > even
> > if it is unusual behaviour still won't have a hard crash.
> >=20
> > My underlying goal was simply a structural cleanup to align the
> > probe() and remove() sequences with standard IIO architecture.
> >=20
> > Would you like me to send a v2 of this patch with a revised commit
> > message classifying it purely as a structural cleanup (and without
> > a
> > Fixes tag), or is the current driver behavior acceptable enough
> > that I
> > should just drop this patch entirely?
>=20
> My gut is leave this one alone. It's a rather unusual driver in lots
> of ways, so I don't really mind one more ;)
>=20
> Lets see if anyone else has strong views one way or the other.
>=20
> Srinivas?
>=20
I don't see anything wrong with this. If you register callback before,=20
then iio_push_to_buffers_with_timestamp() can be called before
iio_device_register(), although it will not happen because nobody
powered on sensors in the hub.

Thanks,
Srinivs






> >=20
> > Thanks,
> > Bhargav
> >=20
> > > >=20
> > > > Move iio_device_register() to the end of the probe() function
> > > > to prevent
> > > > race condition.
> > > >=20
> > > > Consequently, update the error handling path in probe() and in
> > > > remove()
> > > > ensuring that iio_device_unregister() is called first to cut
> > > > off
> > > > userspace access before the hardware callbacks are removed.
> > > >=20
> > > > Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
> > > > ---
> > > > =C2=A0drivers/iio/gyro/hid-sensor-gyro-3d.c | 20 ++++++++++--------=
-
> > > > -
> > > > =C2=A01 file changed, 10 insertions(+), 10 deletions(-)
> > > >=20
> > > > diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > > > b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > > > index c43990c518f7..8e3628cd8529 100644
> > > > --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > > > +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > > > @@ -333,12 +333,6 @@ static int hid_gyro_3d_probe(struct
> > > > platform_device *pdev)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return ret;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > >=20
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D iio_device_register(indio_dev);
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 dev_err(&pdev->dev, "device register failed\n");
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto error_remove_trigger;
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > -
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gyro_state->callbacks.send_event =3D=
 gyro_3d_proc_event;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gyro_state->callbacks.capture_sample=
 =3D
> > > > gyro_3d_capture_sample;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gyro_state->callbacks.pdev =3D pdev;
> > > > @@ -346,13 +340,19 @@ static int hid_gyro_3d_probe(struct
> > > > platform_device *pdev)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 &gyro_state->callbacks);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 dev_err(&pdev->dev, "callback reg failed\n");
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto error_iio_unreg;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto error_remove_trigger;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D iio_device_register(indio_dev);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 dev_err(&pdev->dev, "device register failed\n");
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto error_remove_callback;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > > >=20
> > > > -error_iio_unreg:
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0 iio_device_unregister(indio_dev);
> > > > +error_remove_callback:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 sensor_hub_remove_callback(hsdev,
> > > > HID_USAGE_SENSOR_GYRO_3D);
> > > > =C2=A0error_remove_trigger:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hid_sensor_remove_trigger(indio_dev,=
 &gyro_state-
> > > > >common_attributes);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > > > @@ -365,8 +365,8 @@ static void hid_gyro_3d_remove(struct
> > > > platform_device *pdev)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_dev =3D platfo=
rm_get_drvdata(pdev);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct gyro_3d_state *gyro_state =3D=
 iio_priv(indio_dev);
> > > >=20
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0 sensor_hub_remove_callback(hsdev,
> > > > HID_USAGE_SENSOR_GYRO_3D);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_device_unregister(indio_dev);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 sensor_hub_remove_callback(hsdev,
> > > > HID_USAGE_SENSOR_GYRO_3D);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hid_sensor_remove_trigger(indio_dev,=
 &gyro_state-
> > > > >common_attributes);
> > > > =C2=A0}
> > > > =C2=A0
> > > =C2=A0
