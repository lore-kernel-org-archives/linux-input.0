Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584362135B8;
	Sun, 14 Jun 2026 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781455836; cv=none; b=OTiumirmG6szqXgV0qu5Rxbes1UpS5Q//xpuqyGfB0gDKJHwgWz/fPzCdx71vxv/YrGaHWmWsbiu1M6H/Oby+33ocfYCuxVRXwblBcd9G3n6hAZn2T9aqnOR4ugjh9XVCvIkaQ3J7o95YfK+gxc8aeYJ6aPphCOVy1TDm0vqfc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781455836; c=relaxed/simple;
	bh=9Pgwl0z9k66G7L2jgNZIDbFeBAtUK8zzZjX4ilPkMLM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8dzkh5S5ncsWr/oNOFOy9q418luGZ4kBiDeKVqPkaRYXrwx11Q6GdBJ0619L85HJk9kOo5YQNsYF5pGbPw0CErW0fLNWKW8wfvrmdlPOxVLzQJcvCmNRY3AynG9tnafpHgUAVK23VUPTV7MyykNYk3REg1XzjXTdJyeJ7IJgxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKsIzhiW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKsIzhiW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BABD1F000E9;
	Sun, 14 Jun 2026 16:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781455835;
	bh=oCcVZiCiTl35Vsfg19lBZb+gd3PTSiCcx1+YJJ8FLxU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iKsIzhiWPvZ4NtasgtCoi354XRftjBpEZ4xpH+dBgmB5pWKhzfAYKXhFBLAw6O1BY
	 rh/rmqp5afhY8ACWg+CoH2wHwnN2Sp3CESriqL2xVYJgMP6jIiIMoGgqRICpKkGfvb
	 7+t/qfVyWPDN/1Gbs5maXaDJM0R9PCurEFPaflvjAY4mRk/q3WcbgeoMhCnF6U9cII
	 N3K5wWPlg74spr80+U8KlOaNMOk8G9ji+awvv+ReGFhfJg8nh3hllc1OZUICHArsI8
	 J63xvJNQlkhpbU73Wc8FBbPfdgUSOTd0vm14L/1xf8K3hQYNEiaS4wjJMhnjgXgWic
	 5O5lTZW3YGoNA==
Date: Sun, 14 Jun 2026 17:50:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Zhang, Lixu" <lixu.zhang@intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Benjamin Tissoires
 <bentiss@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: hid-sensor-rotation: Fix stale or zero output
 when reading raw values
Message-ID: <20260614175026.449f6f59@jic23-huawei>
In-Reply-To: <SJ0PR11MB5613EE4659912C262E950C9D93182@SJ0PR11MB5613.namprd11.prod.outlook.com>
References: <20260610082911.157232-1-lixu.zhang@intel.com>
	<20260610082911.157232-3-lixu.zhang@intel.com>
	<20260611173446.14b74365@jic23-huawei>
	<SJ0PR11MB5613EE4659912C262E950C9D93182@SJ0PR11MB5613.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Jun 2026 05:33:32 +0000
"Zhang, Lixu" <lixu.zhang@intel.com> wrote:

> >-----Original Message-----
> >From: Jonathan Cameron <jic23@kernel.org>
> >Sent: Friday, June 12, 2026 12:35 AM
> >To: Zhang, Lixu <lixu.zhang@intel.com>
> >Cc: Jiri Kosina <jikos@kernel.org>; Srinivas Pandruvada
> ><srinivas.pandruvada@linux.intel.com>; Benjamin Tissoires
> ><bentiss@kernel.org>; David Lechner <dlechner@baylibre.com>; Nuno S=C3=A1
> ><nuno.sa@analog.com>; Andy Shevchenko <andy@kernel.org>; linux-
> >input@vger.kernel.org; linux-iio@vger.kernel.org; linux-kernel@vger.kern=
el.org
> >Subject: Re: [PATCH 2/2] iio: hid-sensor-rotation: Fix stale or zero out=
put when
> >reading raw values
> >
> >On Wed, 10 Jun 2026 16:29:10 +0800
> >Zhang Lixu <lixu.zhang@intel.com> wrote:
> > =20
> >> When reading the raw quaternion attribute (in_rot_quaternion_raw), the
> >> driver currently returns either all zeros (if the sensor was never
> >> enabled) or stale data (if the sensor was previously enabled) because
> >> it reads from the internal buffer without explicitly requesting a new
> >> sample from the sensor.
> >>
> >> To fix this, power up the sensor, call
> >> sensor_hub_input_attr_read_values()
> >> to issue a synchronous GET_REPORT and receive the full quaternion data
> >> directly into a local buffer, then decode the four components.
> >>
> >> Signed-off-by: Zhang Lixu <lixu.zhang@intel.com> =20
> >Hi Zhang,
> >
> >Given this is clearly a fix, can you reply to this thread with an approp=
riate Fixes
> >tag.  Otherwise looks fine to me. =20
>=20
> Sure, here is the Fixes tag:
>=20
> Fixes: fc18dddc0625 ("iio: hid-sensors: Added device rotation support")
>=20
> >
> >Given timing and I guess that this bug is fairly old, this will probably=
 only go
> >upstream after rc1. =20
>=20
> That's perfectly fine. Thanks for the review!
Applied to the fixes-togreg branch of iio.git.

Note I'll be rebasing that on rc1 before sending out a pull request.

Thanks,

Jonathan

>=20
> Best regards,
> Lixu
>=20
> >
> >Thanks,
> >
> >Jonathan
> > =20
>=20

