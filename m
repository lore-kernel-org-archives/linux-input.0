Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EBF33ADAD;
	Fri, 24 Apr 2026 19:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777058626; cv=none; b=WRqOl2sTKWeJ5rCskIoRCfM2ieuFS5qk1P5RcnQrxrYvRA0rJW6qWK4dehNes068Ni35fIOna6kBqMgevc7lSN47HbQn2l5lRYRDpGnO2x6ueBuLo3WmjPvMaxUBSfJTVovIl4DI5Y/bv6dhUiswbHBdG8jpSraHJlL2N5BCn70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777058626; c=relaxed/simple;
	bh=h54qspwNYk5XPdL/k566RuaxvahaMYytQIa1Djn5np8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bCYWceEeEQ4nhd6WfWm2iKh1r0gmx5P4B5Exyl22qKAIrlUcjyFEmSXD3ozAtzg3+A7byFFhYmZy2VQVeS9BEBthLkd+7hS0XdOdPhk7qWJnG+VwnAvQHKbPLeHXA3uUeLDFzuLzR49VpemkIUez6oGnETnk2sjTu38gOKjJxDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9JzKncA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9JzKncA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69B6C19425;
	Fri, 24 Apr 2026 19:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777058625;
	bh=h54qspwNYk5XPdL/k566RuaxvahaMYytQIa1Djn5np8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S9JzKncAjmLarkJN54xAK4lOmeb9Y9vwEG6iaZCrN/st//UN7Ylx18YUUS34iMvRy
	 PvP1HtlNjK49TOVDangKkLWZbF4FYzBKFhDUKWmk1H7+JnwUJOldOI3ETdfUEoJ8NQ
	 88XHQcK1crlGJGQlddfKrZplIs++LHIjWHJFXN04N+3gtyhRCtS1tnSobWD0dhLzf1
	 mTfQH7RLzxjbb/LA0x04nHkThe5Zk32ErctqCajZ0vhwaYWL7LviKfCjwUUnH7vRme
	 hfRmQrdXvTXZvt1IohejtX/shf9Q91A86GFRX/XHn7smQf2d6qCez/nUYYR4bwCLdo
	 gq6QBgRU8cXXQ==
Date: Fri, 24 Apr 2026 20:23:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?TmF0w6FsaWE=?= Salvino =?UTF-8?B?QW5kcsOp?=
 <natalia.andre@ime.usp.br>
Cc: andy@kernel.org, bentiss@kernel.org, dlechner@baylibre.com,
 jikos@kernel.org, nuno.sa@analog.com, srinivas.pandruvada@linux.intel.com,
 Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 1/7] iio: HID: Add helper method
 hid_sensor_adjust_channel_bit_mask()
Message-ID: <20260424202337.530d5aad@jic23-huawei>
In-Reply-To: <20260421222210.16016-2-natalia.andre@ime.usp.br>
References: <20260421222210.16016-1-natalia.andre@ime.usp.br>
	<20260421222210.16016-2-natalia.andre@ime.usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Apr 2026 19:20:33 -0300
Nat=C3=A1lia Salvino Andr=C3=A9 <natalia.andre@ime.usp.br> wrote:

> Add helper method to deduplicate code in HID sensors.
>=20
> Signed-off-by: Nat=C3=A1lia Salvino Andr=C3=A9 <natalia.andre@ime.usp.br>
> Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
> Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
> ---
>  .../iio/common/hid-sensors/hid-sensor-attributes.c   | 12 ++++++++++++
>  include/linux/hid-sensor-hub.h                       |  3 +++
>  2 files changed, 15 insertions(+)
>=20
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/dri=
vers/iio/common/hid-sensors/hid-sensor-attributes.c
> index c115a72832b2..3ee6e83c6cac 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -3,6 +3,7 @@
>   * HID Sensors Driver
>   * Copyright (c) 2012, Intel Corporation.
>   */
> +#include <linux/bits.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/time.h>
> @@ -589,6 +590,17 @@ int hid_sensor_parse_common_attributes(struct hid_se=
nsor_hub_device *hsdev,
>  }
>  EXPORT_SYMBOL_NS(hid_sensor_parse_common_attributes, "IIO_HID");
> =20
> +void hid_sensor_adjust_channel_bit_mask(struct iio_chan_spec *channels,
> +					int channel, int size)
> +{
> +	channels[channel].scan_type.format =3D 's';
> +	/* Real storage bits will change based on the report desc. */
> +	channels[channel].scan_type.realbits =3D size * BITS_PER_BYTE;
> +	/* Maximum size of a sample to capture is u32 */
> +	channels[channel].scan_type.storagebits =3D sizeof(u32) * BITS_PER_BYTE;
> +}
> +EXPORT_SYMBOL_NS(hid_sensor_adjust_channel_bit_mask, "IIO_HID");
> +
Looking at this again:

This feels like a helper that doesn't necessarily add much value.

		channels[CHANNEL_SCAN_INDEX_X + i].scan_type =3D (struct iio_scan_type) {
			.format =3D 's',
			.real_bits =3D BYTES_TO_BITS(st->accel[CHANNEL_SCAN_INDEX_X + i].size),
			.storage_bits =3D BITS_PER_TYPE(u32),
		};

Maybe with local variables to help a touch. such as
		unsigned int ch =3D CHANNEL_SCAN_INDEX_X + i];

		channels[ch].scan_type =3D (struct iio_scan_type) {
			.format =3D 's',
			.real_bits =3D BYTES_TO_BITS(st->accel[ch].size),
			.storage_bits =3D BITS_PER_TYPE(u32),
		};
Whilst it technically sets other parts of scan_type to 0, they are 0 anyway
so that's harmless given readability improvements.

There is another two uses for ch just above as well so makes this even easi=
er to
argue in favour of as a change as it'll be (this is effectively replacing p=
atch 2)

	for (unsigned int i =3D 0; i <=3D CHANNEL_SCAN_INDEX_Z; ++i) {
		unsigned int ch =3D CHANNEL_SCAN_INDEX_X + i;

		ret =3D sensor_hub_input_get_attribute_info(hsdev,
				HID_INPUT_REPORT,
				usage_id, ch,
				&st->accel[ch]);

		if (ret < 0)
			break;
		channels[ch].scan_type =3D (struct iio_scan_type) {
			.format =3D 's',
			.real_bits =3D BYTES_TO_BITS(st->accel[ch].size),
			.storage_bits =3D BITS_PER_TYPE(u32),
		};
	}

Hmm. That's also an odd loop as the use assumes CHANNEL_SCAN_INDEX_X =3D 0
(which is true) but then uses an offset that implies it isn't. Clearer to
just loop over the actual enum values.

So probably wants to be something like.

	for (unsigned int ch =3D CHANNEL_SCAN_INDEX_X;
	     i <=3D CHANNEL_SCAN_INDEX_Z; ch++) { //maybe on a long single line.
		ret =3D sensor_hub_input_get_attribute_info(hsdev,
							  HID_INPUT_REPORT,
							  usage_id, ch,
							  &st->accel[ch]);
		if (ret < 0)
			break;

		channels[ch].scan_type =3D (struct iio_scan_type) {
			.format =3D 's',
			.real_bits =3D BYTES_TO_BITS(st->accel[ch].size),
			.storage_bits =3D BITS_PER_TYPE(u32),
		};
	}
=09


>  MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@intel.com>");
>  MODULE_DESCRIPTION("HID Sensor common attribute processing");
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hu=
b.h
> index e71056553108..6523d46c63e0 100644
> --- a/include/linux/hid-sensor-hub.h
> +++ b/include/linux/hid-sensor-hub.h
> @@ -281,4 +281,7 @@ bool hid_sensor_batch_mode_supported(struct hid_senso=
r_common *st);
>  int hid_sensor_set_report_latency(struct hid_sensor_common *st, int late=
ncy);
>  int hid_sensor_get_report_latency(struct hid_sensor_common *st);
> =20
> +void hid_sensor_adjust_channel_bit_mask(struct iio_chan_spec *channels,
> +					int channel, int size);
> +
>  #endif

