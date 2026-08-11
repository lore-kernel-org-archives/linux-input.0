Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E07D439326;
	Tue, 11 Aug 2026 22:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786487059; cv=none; b=dEjRbPndy6NssB6FsN/oMlrhn/4EYjFxYQoR+MMD97fFscgrz0hHc5D7bSSDtnWv/7vOdq6nKseWl6AMz/M6TXY4zRZq4nSjVhngExE98BCvDhC9k+p+KLQlOHbjzXJcwD4jdOsn6m0sPOMXGq9nMk01r/eWDx3Gc8GivdJ/y7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786487059; c=relaxed/simple;
	bh=pHFXFb6dF+uDmpFJM1vxwfRaTcIlYLvah1nlu2V2prY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nwBHqf6hAfFfwVReJCnq+rWzeMtyLjCSAqHBmXkCmhJfnv0CTEXEOUAIZI+8IUMAHH6QZ2FlUarXAurxfdGGwAT0JUnQ0ITPJKaG+IR61vlCcpFPZS5t3xSg5tzAq0iEjlngSTdd6weo+BMos7nTZhRTFDwKewSaCIJPzyjD1vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RH6ZAePt; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RH6ZAePt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786487058; x=1818023058;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=pHFXFb6dF+uDmpFJM1vxwfRaTcIlYLvah1nlu2V2prY=;
  b=RH6ZAePtMpBDKfGrjSzLuFlDeRL2onkNIW0s6xxkvezmxFbeIGstyzCf
   eu2EPZTaYOMBEIOxiVDPG/pkgmXvfgE4HQOnOzsSBKgb4IKDEHo5PrYjK
   j0QmpkVsV1ZUiZttuVw086ydtqRVqf3Zp3W0rkowfdiI99TwUdZovQ2hn
   h34VA6A7ZK3SoPMiEOZ6Da3GTgpIh84IrVMLFmT0kqEx3tzg2elP+ZT6p
   29N90deHcYmY4QlzA+E0UlvuXC3nV2RsqH366K8PymPINa0NdS8W1aSIF
   tRLB91urPwpDtNBbLG0PcEFo8VJBaAPaz8bNf0aFVott3MG3B03HEzWup
   Q==;
X-CSE-ConnectionGUID: SHhSr927SxmkzSq9uyrC1g==
X-CSE-MsgGUID: +oqRETRbSdGZHee6qBWUTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="86960987"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="86960987"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 15:24:17 -0700
X-CSE-ConnectionGUID: BpA5Thm5Sou//DyhOVFi8Q==
X-CSE-MsgGUID: WnfplBrQSq6upoB0YhFjcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="288171798"
Received: from spandruv-desk1.amr.corp.intel.com ([10.124.223.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 15:24:17 -0700
Message-ID: <45d002c27ec333bec9bc83b7d164444d6a0b510c.camel@linux.intel.com>
Subject: Re: [PATCH v2 RESEND] HID: sensor-hub: Fix out-of-bounds write in
 sensor_hub_get_feature
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: bakabaka9 <baka9@bakabaka9.tech>, jikos@kernel.org, jic23@kernel.org, 
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, stable@kernel.org
Date: Tue, 11 Aug 2026 15:24:16 -0700
In-Reply-To: <20260805185753.3069-1-baka9@bakabaka9.tech>
References: <20260805185753.3069-1-baka9@bakabaka9.tech>
Autocrypt: addr=srinivas.pandruvada@linux.intel.com; prefer-encrypt=mutual;
 keydata=mQGNBGYHNAsBDAC7tv5u9cIsSDvdgBBEDG0/a/nTaC1GXOx5MFNEDL0LWia2p8Asl7igx
 YrB68fyfPNLSIgtCmps0EbRUkPtoN5/HTbAEZeJUTL8Xdoe6sTywf8/6/DMheEUzprE4Qyjt0HheW
 y1JGvdOA0f1lkxCnPXeiiDY4FUqQHr3U6X4FPqfrfGlrMmGvntpKzOTutlQl8eSAprtgZ+zm0Jiwq
 NSiSBOt2SlbkGu9bBYx7mTsrGv+x7x4Ca6/BO9o5dIvwJOcfK/cXC/yxEkr1ajbIUYZFEzQyZQXrT
 GUGn8j3/cXQgVvMYxrh3pGCq9Q0Q6PAwQYhm97ipXa86GcTpP5B2ip9xclPtDW99sihiL8euTWRfS
 TUsEI+1YzCyz5DU32w3WiXr3ITicaMV090tMg9phIZsjfFbnR8hY03n0kRNWWFXi/ch2MsZCCqXIB
 oY/SruNH9Y6mnFKW8HSH762C7On8GXBYJzH6giLGeSsbvis2ZmV/r+LmswwZ6ACcOKLlvvIukAEQE
 AAbQ5U3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5j
 b20+iQHRBBMBCAA7FiEEdki2SeUi0wlk2xcjOqtdDMJyisMFAmYHNAsCGwMFCwkIBwICIgIGFQoJC
 AsCBBYCAwECHgcCF4AACgkQOqtdDMJyisMobAv+LLYUSKNuWhRN3wS7WocRPCi3tWeBml+qivCwyv
 oZbmE2LcxYFnkcj6YNoS4N1CHJCr7vwefWTzoKTTDYqz3Ma0D0SbR1p/dH0nDgN34y41HpIHf0tx0
 UxGMgOWJAInq3A7/mNkoLQQ3D5siG39X3bh9Ecg0LhMpYwP/AYsd8X1ypCWgo8SE0J/6XX/HXop2a
 ivimve15VklMhyuu2dNWDIyF2cWz6urHV4jmxT/wUGBdq5j87vrJhLXeosueRjGJb8/xzl34iYv08
 wOB0fP+Ox5m0t9N5yZCbcaQug3hSlgp9hittYRgIK4GwZtNO11bOzeCEMk+xFYUoa5V8JWK9/vxrx
 NZEn58vMJ/nxoJzkb++iV7KBtsqErbs5iDwFln/TRJAQDYrtHJKLLFB9BGUDuaBOmFummR70Rbo55
 J9fvUHc2O70qteKOt5A0zv7G8uUdIaaUHrT+VOS7o+MrbPQcSk+bl81L2R7TfWViCmKQ60sD3M90Y
 oOfCQxricddC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-08-05 at 18:57 +0000, bakabaka9 wrote:
> From: Xingrui Li <baka9@bakabaka9.tech>
>=20
> sensor_hub_get_feature() clamps its return value to the caller's
> buffer
> size, but the copy loop still copies field->report_size / 8 bytes for
> each report value. A malicious HID descriptor can advertise a large
> feature field size while an IIO caller supplies a small stack buffer,
> such as a single s32, causing an out-of-bounds write.
>=20
> HID core stores parsed report values in __s32 slots and clamps
> extracted
> values to 32 bits. Reject feature fields that require more than one
> slot
> per value, guard the total byte count calculation, and clamp each
> per-value copy to the remaining caller buffer.
>=20
> Fixes: 5459ada2b3cd69 ("HID: sensor-hub: Fix packing of result buffer
> for feature report")
> Cc: stable@kernel.org
> Assisted-by: OpenAI:GPT-5.5-Cyber
> Signed-off-by: Xingrui Li <baka9@bakabaka9.tech>

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/hid/hid-sensor-hub.c | 42 +++++++++++++++++++++------------=
-
> --
> =C2=A01 file changed, 25 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-
> hub.c
> index 34f710c465b8..6470a290ebfc 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -239,12 +239,17 @@ int sensor_hub_get_feature(struct
> hid_sensor_hub_device *hsdev, u32 report_id,
> =C2=A0			=C2=A0=C2=A0 u32 field_index, int buffer_size, void
> *buffer)
> =C2=A0{
> =C2=A0	struct hid_report *report;
> +	struct hid_field *field;
> =C2=A0	struct sensor_hub_data *data =3D hid_get_drvdata(hsdev->hdev);
> -	int report_size;
> +	size_t field_size;
> +	size_t report_size;
> +	size_t copied =3D 0;
> +	size_t to_copy;
> =C2=A0	int ret =3D 0;
> -	u8 *val_ptr;
> -	int buffer_index =3D 0;
> -	int i;
> +	unsigned int i;
> +
> +	if (!buffer || buffer_size <=3D 0)
> +		return -EINVAL;
> =C2=A0
> =C2=A0	memset(buffer, 0, buffer_size);
> =C2=A0
> @@ -258,26 +263,29 @@ int sensor_hub_get_feature(struct
> hid_sensor_hub_device *hsdev, u32 report_id,
> =C2=A0	hid_hw_request(hsdev->hdev, report, HID_REQ_GET_REPORT);
> =C2=A0	hid_hw_wait(hsdev->hdev);
> =C2=A0
> +	field =3D report->field[field_index];
> +
> =C2=A0	/* calculate number of bytes required to read this field */
> -	report_size =3D DIV_ROUND_UP(report->field[field_index]-
> >report_size,
> -				=C2=A0=C2=A0 8) *
> -				=C2=A0=C2=A0 report->field[field_index]-
> >report_count;
> -	if (!report_size) {
> +	field_size =3D DIV_ROUND_UP(field->report_size, 8);
> +	/* HID core stores each parsed report value in a __s32 slot.
> */
> +	if (!field_size || field_size > sizeof(field->value[0])) {
> +		ret =3D -EINVAL;
> +		goto done_proc;
> +	}
> +	if (field->report_count > SIZE_MAX / field_size) {
> =C2=A0		ret =3D -EINVAL;
> =C2=A0		goto done_proc;
> =C2=A0	}
> -	ret =3D min(report_size, buffer_size);
> =C2=A0
> -	val_ptr =3D (u8 *)report->field[field_index]->value;
> -	for (i =3D 0; i < report->field[field_index]->report_count;
> ++i) {
> -		if (buffer_index >=3D ret)
> -			break;
> +	report_size =3D field_size * field->report_count;
> +	report_size =3D min_t(size_t, report_size, buffer_size);
> =C2=A0
> -		memcpy(&((u8 *)buffer)[buffer_index], val_ptr,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 report->field[field_index]->repor=
t_size / 8);
> -		val_ptr +=3D sizeof(__s32);
> -		buffer_index +=3D (report->field[field_index]-
> >report_size / 8);
> +	for (i =3D 0; i < field->report_count && copied < report_size;
> ++i) {
> +		to_copy =3D min(field_size, report_size - copied);
> +		memcpy(&((u8 *)buffer)[copied], &field->value[i],
> to_copy);
> +		copied +=3D to_copy;
> =C2=A0	}
> +	ret =3D copied;
> =C2=A0
> =C2=A0done_proc:
> =C2=A0	mutex_unlock(&data->mutex);
