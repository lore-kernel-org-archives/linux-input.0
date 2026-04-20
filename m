Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B831F344029;
	Mon, 20 Apr 2026 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700245; cv=none; b=AK/Ncn1QxM7eqYxfoyaemeF3cupAr2D71fNzgRH6JAMHCtTeVqK4cBRw+fz+caYIRxDJoNHhwsU7hwIIRfhGa7u10XtbEV1TxjgZq+RUSCrDbgYJAD+IHfR86z7CB4Auqp9/vbVvVy0qxfvsB9D5FEoarC9Mr9Wq6dQj/7zhBpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700245; c=relaxed/simple;
	bh=F40+zvj3QJ1NjUP9UvS/6wzwOCp7mKkUIkZCndcs8Mo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DUw6EzO7H1mXUGAMWOx8rgysoCnsO401aFVO393fycBNe8gCgklnMWpaSRRFzMEgAdCPt5gX7NdV+v/d373tU0Cd0R6y4NP1pzJJJP4zf84c7AYVlZ1dBNC6M1tTj+4+irlWAxKTc7pXLxAt+BqnPQ9ClHAo9CCIvn7Z1wISfxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ILjsZSRp; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ILjsZSRp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776700244; x=1808236244;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=F40+zvj3QJ1NjUP9UvS/6wzwOCp7mKkUIkZCndcs8Mo=;
  b=ILjsZSRpYPZEBbgokw25Ktxj1WjDvH4rsw+X+T7iqqRh2UPQw4rIDHTU
   WWjhlRwv4h7mayDtpXIg91TN/oi0x4zsSUg4PmaOJanzDDRdVg3EdAxeZ
   4CXc2aOPQ0rXMl9fs527EPN+TJyyA64koYD+lPeDLxAvQOkzHx9B07XBT
   qYluC2ecagoR20KBIv0MMn7eFB0Urpc69Ww2uh6nw/XjBgIXBVqreJEEW
   Zi/RcpoU8G55qftL3zxWbtrehjfolbzxs6gVkpyEEfTBPqwo3FJ8Abh5+
   EP/OoUI3GAUCu6sq+u+jT1iL0SUPT5etusWjksH6TDO/3U9e2GATaBjY9
   Q==;
X-CSE-ConnectionGUID: mQWLAGPKTzmpWzLNRe3qSQ==
X-CSE-MsgGUID: RCgqIfwBTvurb9L2fjBqNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77489481"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="77489481"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 08:45:50 -0700
X-CSE-ConnectionGUID: xo09gGzwRVKqyrOZomXU2g==
X-CSE-MsgGUID: NGzM8DktR12CJzeujQvMvQ==
X-ExtLoop1: 1
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 08:45:49 -0700
Message-ID: <ff6d54f76139c43642f15ef21da6997145bca8e3.camel@linux.intel.com>
Subject: Re: [PATCH v2] iio: orientation: hid-sensor-rotation: use
 ext_scan_type
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Lixu Zhang <lixu.zhang@intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 20 Apr 2026 08:45:49 -0700
In-Reply-To: <20260412152643.68c8f065@jic23-huawei>
References: 
	<20260301-iio-hid-sensor-rotation-cleanup-v2-1-245c6ad59afc@baylibre.com>
	 <20260412152643.68c8f065@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

+Lixu

On Sun, 2026-04-12 at 15:26 +0100, Jonathan Cameron wrote:
> On Sun, 01 Mar 2026 17:46:48 -0600
> David Lechner <dlechner@baylibre.com> wrote:
>=20
> > Make use of ext_scan_type to handle the dynamic realbits size of
> > the
> > quaternion data. This lets us implement it using static data rather
> > than
> > having to duplicate the channel info for each driver instance.
> >=20
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> I'm going to apply this now, but would welcome any additional
> feedback
> from Srinivas or others.
>=20
> Note, given this is next cycle material now I'll only push the tree
> out
> as testing until I can rebase on rc1.
>=20

In real world I think report size is always 16 copying from spec.

    Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thanks,
Srinivas


> Thanks,
>=20
> Jonathan
>=20
> > This is something I noticed we could do while looking at an
> > unrelated
> > bug. I've tested this using the same script from [1] and confirmed
> > that
> > that the scan type didn't change. Before and after are both:
> >=20
> > $ cat in_rot_quaternion_type
> > le:s16/32X4>>0=C2=A0=20
> >=20
> > [1]:
> > https://lore.kernel.org/linux-iio/20260301-iio-fix-timestamp-alignment-=
v1-1-1a54980bfb90@baylibre.com/
> > ---
> > Changes in v2:
> > - Dropped DEV_ROT_SCAN_TYPE_8BIT.
> > - Tested using /dev/uhid.
> > - Link to v1:
> > https://lore.kernel.org/r/20260214-iio-hid-sensor-rotation-cleanup-v1-1=
-3aec9a533c0f@baylibre.com
> > ---
> > =C2=A0drivers/iio/orientation/hid-sensor-rotation.c | 71
> > ++++++++++++++++-----------
> > =C2=A01 file changed, 43 insertions(+), 28 deletions(-)
> >=20
> > diff --git a/drivers/iio/orientation/hid-sensor-rotation.c
> > b/drivers/iio/orientation/hid-sensor-rotation.c
> > index e759f91a710a..3cfd0b323514 100644
> > --- a/drivers/iio/orientation/hid-sensor-rotation.c
> > +++ b/drivers/iio/orientation/hid-sensor-rotation.c
> > @@ -34,6 +34,27 @@ static const u32
> > rotation_sensitivity_addresses[] =3D {
> > =C2=A0	HID_USAGE_SENSOR_ORIENT_QUATERNION,
> > =C2=A0};
> > =C2=A0
> > +enum {
> > +	DEV_ROT_SCAN_TYPE_16BIT,
> > +	DEV_ROT_SCAN_TYPE_32BIT,
> > +};
> > +
> > +static const struct iio_scan_type dev_rot_scan_types[] =3D {
> > +	[DEV_ROT_SCAN_TYPE_16BIT] =3D {
> > +		.sign =3D 's',
> > +		.realbits =3D 16,
> > +		/* Storage bits has to stay 32 to not break
> > userspace. */
> > +		.storagebits =3D 32,
> > +		.repeat =3D 4,
> > +	},
> > +	[DEV_ROT_SCAN_TYPE_32BIT] =3D {
> > +		.sign =3D 's',
> > +		.realbits =3D 32,
> > +		.storagebits =3D 32,
> > +		.repeat =3D 4,
> > +	},
> > +};
> > +
> > =C2=A0/* Channel definitions */
> > =C2=A0static const struct iio_chan_spec dev_rot_channels[] =3D {
> > =C2=A0	{
> > @@ -45,23 +66,14 @@ static const struct iio_chan_spec
> > dev_rot_channels[] =3D {
> > =C2=A0					BIT(IIO_CHAN_INFO_OFFSET)
> > |
> > =C2=A0					BIT(IIO_CHAN_INFO_SCALE) |
> > =C2=A0					BIT(IIO_CHAN_INFO_HYSTERES
> > IS),
> > -		.scan_index =3D 0
> > +		.scan_index =3D 0,
> > +		.has_ext_scan_type =3D 1,
> > +		.ext_scan_type =3D dev_rot_scan_types,
> > +		.num_ext_scan_type =3D
> > ARRAY_SIZE(dev_rot_scan_types),
> > =C2=A0	},
> > =C2=A0	IIO_CHAN_SOFT_TIMESTAMP(1)
> > =C2=A0};
> > =C2=A0
> > -/* Adjust channel real bits based on report descriptor */
> > -static void dev_rot_adjust_channel_bit_mask(struct iio_chan_spec
> > *chan,
> > -						int size)
> > -{
> > -	chan->scan_type.sign =3D 's';
> > -	/* Real storage bits will change based on the report desc.
> > */
> > -	chan->scan_type.realbits =3D size * 8;
> > -	/* Maximum size of a sample to capture is u32 */
> > -	chan->scan_type.storagebits =3D sizeof(u32) * 8;
> > -	chan->scan_type.repeat =3D 4;
> > -}
> > -
> > =C2=A0/* Channel read_raw handler */
> > =C2=A0static int dev_rot_read_raw(struct iio_dev *indio_dev,
> > =C2=A0				struct iio_chan_spec const *chan,
> > @@ -136,9 +148,25 @@ static int dev_rot_write_raw(struct iio_dev
> > *indio_dev,
> > =C2=A0	return ret;
> > =C2=A0}
> > =C2=A0
> > +static int dev_rot_get_current_scan_type(const struct iio_dev
> > *indio_dev,
> > +					 const struct
> > iio_chan_spec *chan)
> > +{
> > +	struct dev_rot_state *rot_state =3D iio_priv(indio_dev);
> > +
> > +	switch (rot_state->quaternion.size / 4) {
> > +	case sizeof(s16):
> > +		return DEV_ROT_SCAN_TYPE_16BIT;
> > +	case sizeof(s32):
> > +		return DEV_ROT_SCAN_TYPE_32BIT;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > =C2=A0static const struct iio_info dev_rot_info =3D {
> > =C2=A0	.read_raw_multi =3D &dev_rot_read_raw,
> > =C2=A0	.write_raw =3D &dev_rot_write_raw,
> > +	.get_current_scan_type =3D &dev_rot_get_current_scan_type,
> > =C2=A0};
> > =C2=A0
> > =C2=A0/* Callback handler to send event after all samples are received
> > and captured */
> > @@ -196,7 +224,6 @@ static int dev_rot_capture_sample(struct
> > hid_sensor_hub_device *hsdev,
> > =C2=A0/* Parse report which is specific to an usage id*/
> > =C2=A0static int dev_rot_parse_report(struct platform_device *pdev,
> > =C2=A0				struct hid_sensor_hub_device
> > *hsdev,
> > -				struct iio_chan_spec *channels,
> > =C2=A0				unsigned usage_id,
> > =C2=A0				struct dev_rot_state *st)
> > =C2=A0{
> > @@ -210,9 +237,6 @@ static int dev_rot_parse_report(struct
> > platform_device *pdev,
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
> > =C2=A0
> > -	dev_rot_adjust_channel_bit_mask(&channels[0],
> > -		st->quaternion.size / 4);
> > -
> > =C2=A0	dev_dbg(&pdev->dev, "dev_rot %x:%x\n", st-
> > >quaternion.index,
> > =C2=A0		st->quaternion.report_id);
> > =C2=A0
> > @@ -271,22 +295,13 @@ static int hid_dev_rot_probe(struct
> > platform_device *pdev)
> > =C2=A0		return ret;
> > =C2=A0	}
> > =C2=A0
> > -	indio_dev->channels =3D devm_kmemdup(&pdev->dev,
> > dev_rot_channels,
> > -					=C2=A0=C2=A0
> > sizeof(dev_rot_channels),
> > -					=C2=A0=C2=A0 GFP_KERNEL);
> > -	if (!indio_dev->channels) {
> > -		dev_err(&pdev->dev, "failed to duplicate
> > channels\n");
> > -		return -ENOMEM;
> > -	}
> > -
> > -	ret =3D dev_rot_parse_report(pdev, hsdev,
> > -				=C2=A0=C2=A0 (struct iio_chan_spec
> > *)indio_dev->channels,
> > -					hsdev->usage, rot_state);
> > +	ret =3D dev_rot_parse_report(pdev, hsdev, hsdev->usage,
> > rot_state);
> > =C2=A0	if (ret) {
> > =C2=A0		dev_err(&pdev->dev, "failed to setup
> > attributes\n");
> > =C2=A0		return ret;
> > =C2=A0	}
> > =C2=A0
> > +	indio_dev->channels =3D dev_rot_channels;
> > =C2=A0	indio_dev->num_channels =3D ARRAY_SIZE(dev_rot_channels);
> > =C2=A0	indio_dev->info =3D &dev_rot_info;
> > =C2=A0	indio_dev->name =3D name;
> >=20
> > ---
> > base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
> > change-id: 20260214-iio-hid-sensor-rotation-cleanup-84e8410926ef
> >=20
> > Best regards,
