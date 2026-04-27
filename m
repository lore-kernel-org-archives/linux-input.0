Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF0E3EC2EC;
	Mon, 27 Apr 2026 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777314397; cv=none; b=nE4AGKjn2GsJiPOs7X3Y1MsoRMj3XtbJ25AXeLL/YdRiv8X5gn80VzFpChvUWN4tri7TZ07JOKtrWnzYZBzfvxCxo+OU028PQkR9Aaz+2Vegm9y11+QRFS+FMbNUKvyuULOd/tYluWqZpVx40Z9SLUuRfxIajBVgptIaosw0mz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777314397; c=relaxed/simple;
	bh=s9wn6pT7Fa8KxB3cJPlGCfk8jzed3DR5ycOJYJQN1NM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u7Ke7OtC36cGxOS0LZLEmudT/Vt0lh7gcR+wXXcHzQ5p+c/CCI2z9/Q9Ku1DdlNczsWX2/2gIcvwrTOqKD3uGuuEUG/HSzUYn+AjAq9u3Gb4ZgSFQkQkqC9WpbJz97lEen3A8n6OOh6DvPh1CG83MnAuTDzmXiqjPRcUeQA7sC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EpsPICob; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EpsPICob"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777314395; x=1808850395;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=s9wn6pT7Fa8KxB3cJPlGCfk8jzed3DR5ycOJYJQN1NM=;
  b=EpsPICob7ilHqvygmL/sKHx2nVoRrfMR4S23Xj4cSYwBVGqAEqsiTu9i
   CUsdEeer2YBmYoO/eGkUnNvxw7/4sGeYnEgc7vpKgM5Aq+FwRRE+ax0zl
   0oEASNUwFyq8YggVqlMgi0hf0DRunn0/WrtVugL5ozX8a1asFJ64kx+Z2
   9fETfHs+HwOF5nklEcRXzw5sYilcbjNHo7SWwO9d6jpUW17TJDXynzL/q
   +SD3T7C2kAq2k819p8wal0Z4IXt1z0uEsrzkUE4bGf6IqALNAdnRrBA26
   rXBsjwzUg9qbF/IkWbXysLfTl0Kbh8YDlIi0wh7JV//NDVCHd7jPEU9PS
   Q==;
X-CSE-ConnectionGUID: m8HeiToDRY2y3b8BwCLJQg==
X-CSE-MsgGUID: V8kCOhzVRS+/N02zHGQExQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="88526049"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="88526049"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 11:26:32 -0700
X-CSE-ConnectionGUID: sV6bBssJQya4uZwquF6S7A==
X-CSE-MsgGUID: F2rGrkqaRMyqkAz9p0zgoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="227194199"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 11:26:30 -0700
Message-ID: <6b21845b85535f475c23604d4821d18759b6d714.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/7] iio: HID: Add helper method
 hid_sensor_adjust_channel_bit_mask()
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>, =?ISO-8859-1?Q?Nat=E1lia?=
 Salvino =?ISO-8859-1?Q?Andr=E9?=
	 <natalia.andre@ime.usp.br>
Cc: andy@kernel.org, bentiss@kernel.org, dlechner@baylibre.com,
 jikos@kernel.org, 	nuno.sa@analog.com, Pietro Di Consolo Gregorio
 <pietro.gregorio@usp.br>, 	linux-iio@vger.kernel.org,
 linux-input@vger.kernel.org
Date: Mon, 27 Apr 2026 11:26:29 -0700
In-Reply-To: <20260424202337.530d5aad@jic23-huawei>
References: <20260421222210.16016-1-natalia.andre@ime.usp.br>
		<20260421222210.16016-2-natalia.andre@ime.usp.br>
	 <20260424202337.530d5aad@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-24 at 20:23 +0100, Jonathan Cameron wrote:
> On Tue, 21 Apr 2026 19:20:33 -0300
> Nat=C3=A1lia Salvino Andr=C3=A9 <natalia.andre@ime.usp.br> wrote:
>=20
> > Add helper method to deduplicate code in HID sensors.
> >=20
> > Signed-off-by: Nat=C3=A1lia Salvino Andr=C3=A9 <natalia.andre@ime.usp.b=
r>
> > Co-developed-by: Pietro Di Consolo Gregorio
> > <pietro.gregorio@usp.br>
> > Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
> > ---
> > =C2=A0.../iio/common/hid-sensors/hid-sensor-attributes.c=C2=A0=C2=A0 | =
12
> > ++++++++++++
> > =C2=A0include/linux/hid-sensor-hub.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +++
> > =C2=A02 files changed, 15 insertions(+)
> >=20
> > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > index c115a72832b2..3ee6e83c6cac 100644
> > --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > @@ -3,6 +3,7 @@
> > =C2=A0 * HID Sensors Driver
> > =C2=A0 * Copyright (c) 2012, Intel Corporation.
> > =C2=A0 */
> > +#include <linux/bits.h>
> > =C2=A0#include <linux/module.h>
> > =C2=A0#include <linux/kernel.h>
> > =C2=A0#include <linux/time.h>
> > @@ -589,6 +590,17 @@ int hid_sensor_parse_common_attributes(struct
> > hid_sensor_hub_device *hsdev,
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_NS(hid_sensor_parse_common_attributes, "IIO_HID");
> > =C2=A0
> > +void hid_sensor_adjust_channel_bit_mask(struct iio_chan_spec
> > *channels,
> > +					int channel, int size)
> > +{
> > +	channels[channel].scan_type.format =3D 's';
> > +	/* Real storage bits will change based on the report desc.
> > */
> > +	channels[channel].scan_type.realbits =3D size *
> > BITS_PER_BYTE;
> > +	/* Maximum size of a sample to capture is u32 */
> > +	channels[channel].scan_type.storagebits =3D sizeof(u32) *
> > BITS_PER_BYTE;
> > +}
> > +EXPORT_SYMBOL_NS(hid_sensor_adjust_channel_bit_mask, "IIO_HID");
> > +
> Looking at this again:
>=20
> This feels like a helper that doesn't necessarily add much value.
I think so.

>=20
> 		channels[CHANNEL_SCAN_INDEX_X + i].scan_type =3D
> (struct iio_scan_type) {
> 			.format =3D 's',
> 			.real_bits =3D BYTES_TO_BITS(st-
> >accel[CHANNEL_SCAN_INDEX_X + i].size),
> 			.storage_bits =3D BITS_PER_TYPE(u32),
> 		};
>=20
> Maybe with local variables to help a touch. such as
> 		unsigned int ch =3D CHANNEL_SCAN_INDEX_X + i];
>=20
> 		channels[ch].scan_type =3D (struct iio_scan_type) {
> 			.format =3D 's',
> 			.real_bits =3D BYTES_TO_BITS(st-
> >accel[ch].size),
> 			.storage_bits =3D BITS_PER_TYPE(u32),
> 		};
> Whilst it technically sets other parts of scan_type to 0, they are 0
> anyway
> so that's harmless given readability improvements.
>=20
> There is another two uses for ch just above as well so makes this
> even easier to
> argue in favour of as a change as it'll be (this is effectively
> replacing patch 2)
>=20
> 	for (unsigned int i =3D 0; i <=3D CHANNEL_SCAN_INDEX_Z; ++i) {
> 		unsigned int ch =3D CHANNEL_SCAN_INDEX_X + i;
>=20
> 		ret =3D sensor_hub_input_get_attribute_info(hsdev,
> 				HID_INPUT_REPORT,
> 				usage_id, ch,
> 				&st->accel[ch]);
>=20
> 		if (ret < 0)
> 			break;
> 		channels[ch].scan_type =3D (struct iio_scan_type) {
> 			.format =3D 's',
> 			.real_bits =3D BYTES_TO_BITS(st-
> >accel[ch].size),
> 			.storage_bits =3D BITS_PER_TYPE(u32),
> 		};
> 	}
>=20
> Hmm. That's also an odd loop as the use assumes CHANNEL_SCAN_INDEX_X
> =3D 0
> (which is true) but then uses an offset that implies it isn't.
> Clearer to
> just loop over the actual enum values.
>=20
> So probably wants to be something like.
>=20
> 	for (unsigned int ch =3D CHANNEL_SCAN_INDEX_X;
> 	=C2=A0=C2=A0=C2=A0=C2=A0 i <=3D CHANNEL_SCAN_INDEX_Z; ch++) { //maybe on=
 a long
> single line.
> 		ret =3D sensor_hub_input_get_attribute_info(hsdev,
> 							=C2=A0
> HID_INPUT_REPORT,
> 							=C2=A0 usage_id,
> ch,
> 							=C2=A0 &st-
> >accel[ch]);
> 		if (ret < 0)
> 			break;
>=20
> 		channels[ch].scan_type =3D (struct iio_scan_type) {
> 			.format =3D 's',
> 			.real_bits =3D BYTES_TO_BITS(st-
> >accel[ch].size),
> 			.storage_bits =3D BITS_PER_TYPE(u32),
> 		};
> 	}
> =09
>=20
This change is better than adding another export function.

Thanks,
Srinivas


>=20
> > =C2=A0MODULE_AUTHOR("Srinivas Pandruvada
> > <srinivas.pandruvada@intel.com>");
> > =C2=A0MODULE_DESCRIPTION("HID Sensor common attribute processing");
> > =C2=A0MODULE_LICENSE("GPL");
> > diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-
> > sensor-hub.h
> > index e71056553108..6523d46c63e0 100644
> > --- a/include/linux/hid-sensor-hub.h
> > +++ b/include/linux/hid-sensor-hub.h
> > @@ -281,4 +281,7 @@ bool hid_sensor_batch_mode_supported(struct
> > hid_sensor_common *st);
> > =C2=A0int hid_sensor_set_report_latency(struct hid_sensor_common *st,
> > int latency);
> > =C2=A0int hid_sensor_get_report_latency(struct hid_sensor_common *st);
> > =C2=A0
> > +void hid_sensor_adjust_channel_bit_mask(struct iio_chan_spec
> > *channels,
> > +					int channel, int size);
> > +
> > =C2=A0#endif
