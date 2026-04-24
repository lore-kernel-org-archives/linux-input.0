Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD3F3F9F54;
	Fri, 24 Apr 2026 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777057324; cv=none; b=es3zkvm41lO2Vk6v9MQq1HJUFQTz/9bjsw5o4v7hEKivTrQkcdadNx0NbTIYyxOTKawYuGBejRSyZfML1K7AfaPVvY0S07K+H2XK1XgLfzl4e/+my3/ccQ+dYff3xtLIcNXgVHPe70JldAL9+WR/dg/dk0wurAmJVF96gslzEXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777057324; c=relaxed/simple;
	bh=JTdkZi7jNm9LCQKuZ/J0LtP/TeJPxPZIBdlRtUFw/8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXxYb8Bt0YNgOJBYfORykCXS3ZKWipfftH0bkfoafCfBOjzbI2//BL4l86mSECfDiRWKxgDnCh9oKmEDtby/fcNY9mTYOG2/cx+xsfwM8h9i4JqWxWu1GpJoVR8+dFeJiTK2t61hbHEhXj7BVGVi3NPPx4gTTVnoHcC0LsGMv68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7X1wyAV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7X1wyAV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A976C19425;
	Fri, 24 Apr 2026 19:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777057324;
	bh=JTdkZi7jNm9LCQKuZ/J0LtP/TeJPxPZIBdlRtUFw/8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B7X1wyAVOCEasobGcs951Yc+z/mgcxdbmyP/HofO5jTbbma07Ez4kL2PZZ9InwJcr
	 elKYThdLFzvAvAtGhSlKejU8Er47pZ9/WntqJxRc72bQyLvbuPtJh7jqvp0pXBYtsJ
	 RpzZ+3fmJZMyog2yj/w+IBIuK3juSqqTZu9AfOMBVdWcsOD5T46CbXEpOD+J/pkfmt
	 36ZdFvXIlKqWmPVnTOyUm2xlVGi/Xf3aodA19waJnRVX5JmxJR+UPIBJNMamjGTcAK
	 /3wha4E352t6K6FJgsboT3YsKAxDd3tTQdUjAJHNz55oRAUli4MtPbfVHMpOeWv+Mr
	 apu49duqKAG6Q==
Date: Fri, 24 Apr 2026 20:01:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: =?UTF-8?B?TmF0w6FsaWE=?= Salvino =?UTF-8?B?QW5kcsOp?=
 <natalia.andre@ime.usp.br>, andy@kernel.org, bentiss@kernel.org,
 dlechner@baylibre.com, jikos@kernel.org, nuno.sa@analog.com,
 srinivas.pandruvada@linux.intel.com, Pietro Di Consolo Gregorio
 <pietro.gregorio@usp.br>, linux-iio@vger.kernel.org,
 linux-input@vger.kernel.org
Subject: Re: [PATCH v2 1/7] iio: HID: Add helper method
 hid_sensor_adjust_channel_bit_mask()
Message-ID: <20260424200155.61b6f273@jic23-huawei>
In-Reply-To: <aeiO0JRGW0oKdcON@ashevche-desk.local>
References: <20260421222210.16016-1-natalia.andre@ime.usp.br>
	<20260421222210.16016-2-natalia.andre@ime.usp.br>
	<aeiO0JRGW0oKdcON@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Apr 2026 12:03:12 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Apr 21, 2026 at 07:20:33PM -0300, Nat=C3=A1lia Salvino Andr=C3=A9=
 wrote:
> > Add helper method to deduplicate code in HID sensors. =20
>=20
> ...
>=20
> > +#include <linux/bits.h> =20
>=20
> Will need bitops.h instead (see below why).
>=20
> ...
>=20
> > +void hid_sensor_adjust_channel_bit_mask(struct iio_chan_spec *channels,
> > +					int channel, int size)
> > +{
> > +	channels[channel].scan_type.format =3D 's';
> > +	/* Real storage bits will change based on the report desc. */
> > +	channels[channel].scan_type.realbits =3D size * BITS_PER_BYTE; =20
>=20
> BITS_TO_BYTES(size)

BYTES_TO_BITS(size)

>=20
> > +	/* Maximum size of a sample to capture is u32 */
> > +	channels[channel].scan_type.storagebits =3D sizeof(u32) * BITS_PER_BY=
TE; =20
>=20
> BITS_PER_TYPE(u32)
>=20
> > +} =20
>=20

