Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7935A3D6CB9;
	Sat, 16 May 2026 11:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778931888; cv=none; b=ilJS9BNT2hC+Va7Rthl6CVks32br7+KphiiIWyWa1XjEz1sysuuJ/IAADiggHMYLpYApQUsAT5Nzip7DPceOj8AbQ0PSUyv88UuE9tPVMn/Qu+YIdV/NW+NEFv0wsiX7LbEjCKbGoTIRqKoCHBc5g3Uq4lgQftgFjdQqVcZyXKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778931888; c=relaxed/simple;
	bh=7JDt2BdU8yt2fO2x7S9hFlrenXGdViWoX0Mkt/8SLDE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TM1aqhSQhwFxM6wraZE5CjojPjAwOY81wyKmqLIWztMdBz3TChreN81DZT/FOAkVBQ39Z9DMFjNDoMRsdptxBJj0Z8otiDu/MxPkSpj7kmxtmH9SIr69o5z+nCSC/H+At89sPUiB2K0DwL8Tx00jH0rTbyMqFv8zpaD9EvGCpnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vi+4UP/v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vi+4UP/v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DADC19425;
	Sat, 16 May 2026 11:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778931888;
	bh=7JDt2BdU8yt2fO2x7S9hFlrenXGdViWoX0Mkt/8SLDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vi+4UP/vJlNbBOXcekpwXWO/oqmjiPfRA5cNAEbpacRaf+i1iyzO00moTQZYBuY67
	 WzuRcLsCO6FVjuJAAgf7zw6bTKNDGFEtXMEuYy7EU1H9sSqqCYU5B/3NkIiRb54qSC
	 vxoBWgx+xmXnuz++42jWDNqgZlfWo/SUeeOigFLnO9iYUqWFIds4glAnhYac0Klps7
	 uuUOH5XknZnmT5Cq424tQEF8oEI2jgUqU7YbBWMqD6BSeTdeD0hH/dsGwD7kh/UFhF
	 Np5koafs8aioygmWWXFMQona9Xz7YElanxJk1zyjVi5AVem8UQLI1Xg9yqecEEFybN
	 o1Ql1xmCHan9w==
Date: Sat, 16 May 2026 12:44:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: =?UTF-8?B?TmF0w6FsaWE=?= Salvino =?UTF-8?B?QW5kcsOp?= 
 <natalia.andre@ime.usp.br>, andy@kernel.org, dlechner@baylibre.com,
 jikos@kernel.org, nuno.sa@analog.com, Pietro Di Consolo Gregorio
 <pietro.gregorio@usp.br>, linux-iio@vger.kernel.org,
 linux-input@vger.kernel.org
Subject: Re: [PATCH v3 2/6] iio: gyro: HID: hid-sensor-gyro-3d: Refactor
 channel initialization
Message-ID: <20260516124439.6ca0843f@jic23-huawei>
In-Reply-To: <873e576772dc7b283bb4f01b3c838894cc7a35de.camel@linux.intel.com>
References: <20260512012302.20883-1-natalia.andre@ime.usp.br>
	<20260512012302.20883-3-natalia.andre@ime.usp.br>
	<873e576772dc7b283bb4f01b3c838894cc7a35de.camel@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 15 May 2026 09:48:34 -0700
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Mon, 2026-05-11 at 22:16 -0300, Nat=C3=A1lia Salvino Andr=C3=A9 wrote:
> > Replace the local gyro_3d_adjust_channel_bit_mask() function with a
> > compound literal for scan_type initialization to improve code
> > readability.
> >=20
> > Signed-off-by: Nat=C3=A1lia Salvino Andr=C3=A9 <natalia.andre@ime.usp.b=
r>
> > Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
> > Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
> > ---
> > =C2=A0drivers/iio/gyro/hid-sensor-gyro-3d.c | 24 +++++++++-------------=
--
> > =C2=A01 file changed, 9 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > index c340cc899a7c..4cbe4d93a0a1 100644
> > --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > @@ -3,6 +3,7 @@
> > =C2=A0 * HID Sensors Driver
> > =C2=A0 * Copyright (c) 2012, Intel Corporation.
> > =C2=A0 */
> > +#include <linux/bitops.h>
> > =C2=A0#include <linux/device.h>
> > =C2=A0#include <linux/platform_device.h>
> > =C2=A0#include <linux/module.h>
> > @@ -82,17 +83,6 @@ static const struct iio_chan_spec
> > gyro_3d_channels[] =3D {
> > =C2=A0	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
> > =C2=A0};
> > =C2=A0
> > -/* Adjust channel real bits based on report descriptor */
> > -static void gyro_3d_adjust_channel_bit_mask(struct iio_chan_spec
> > *channels,
> > -						int channel, int
> > size)
> > -{
> > -	channels[channel].scan_type.sign =3D 's';
> > -	/* Real storage bits will change based on the report desc.
> > */
> > -	channels[channel].scan_type.realbits =3D size * 8;
> > -	/* Maximum size of a sample to capture is u32 */
> > -	channels[channel].scan_type.storagebits =3D sizeof(u32) * 8;
> > -}
> > -
> > =C2=A0/* Channel read_raw handler */
> > =C2=A0static int gyro_3d_read_raw(struct iio_dev *indio_dev,
> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *cha=
n,
> > @@ -251,16 +241,20 @@ static int gyro_3d_parse_report(struct
> > platform_device *pdev,
> > =C2=A0	int i;
> > =C2=A0
> > =C2=A0	for (i =3D 0; i <=3D CHANNEL_SCAN_INDEX_Z; ++i) {
> > +		unsigned int ch =3D CHANNEL_SCAN_INDEX_X + i;
> > + =20
>=20
> When you do code change more than what you described, then you should
> add to commit description that you are also doing this at the same
> time.
Particularly true when it is less than ideal.  Like in previous
patch the loop shouldbe from CHANNEL_SCAN_INDEX_X to CHANNEL_SCAN_INDEX_Z
not 0 (the value is 0 but if we assume that then the sum for ch makes little
sense!)

>=20
> Thanks,
> Srinivas
>=20
> > =C2=A0		ret =3D sensor_hub_input_get_attribute_info(hsdev,
> > =C2=A0				HID_INPUT_REPORT,
> > =C2=A0				usage_id,
> > =C2=A0				HID_USAGE_SENSOR_ANGL_VELOCITY_X_AXI
> > S + i,
> > -				&st->gyro[CHANNEL_SCAN_INDEX_X +
> > i]);
> > +				&st->gyro[ch]);
> > =C2=A0		if (ret < 0)
> > =C2=A0			break;
> > -		gyro_3d_adjust_channel_bit_mask(channels,
> > -				CHANNEL_SCAN_INDEX_X + i,
> > -				st->gyro[CHANNEL_SCAN_INDEX_X +
> > i].size);
> > +		channels[ch].scan_type =3D (struct iio_scan_type) {
> > +			.format =3D 's',
> > +			.realbits =3D BYTES_TO_BITS(st- =20
> > >gyro[ch].size), =20
> > +			.storagebits =3D BITS_PER_TYPE(u32),
> > +		};
> > =C2=A0	}
> > =C2=A0	dev_dbg(&pdev->dev, "gyro_3d %x:%x, %x:%x, %x:%x\n",
> > =C2=A0			st->gyro[0].index, =20
>=20

