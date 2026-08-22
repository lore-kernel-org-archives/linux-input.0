Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B2323EAA6
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787401493; cv=none; b=PBsM5SdJB3MoSAFCmStxLWNudu37ClxPTut6/TGSDHXwsJsxHYgen6u8ma6LhzRg4i2XuUZtIO16BKL30FbO08QcPPxZOHflE2l3IqUwiQeosCDyfKJnwHVeMvl3kyy4CfdpASRv1/OoPHwvv/76R7BCXEHPIRV0oUdDXhBkoPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787401493; c=relaxed/simple;
	bh=8r7d2sEj72ZQrB/nizayirB3FO08eLQhk+U/5ZSH2XI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uWwRWRf14agfrqOMNR9L7AJg/hfnjnUMb5LmO5e8d+rCCVEO4EK8h9Q+12QawHF9jIXN/HZKwiyTKcAmns6SPSsGtUlb9Q7kc6ABMCSg8h23Msqco45cEDPyb5Le1NSjt/LmXze06pgrWGeXITZ0mkY55be6mNjnRP46xlAlzYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSjTkMIr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSjTkMIr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CF31F000E9;
	Sat, 22 Aug 2026 12:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787401491;
	bh=JQVS7dvEHIQqje5b02NrfwkTaCNiUN+bFWQkoYY7FOg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MSjTkMIrEoGmH/e72UnpjGGM4AytPk8pEDMGy4xUX7Xi01tOhtqXng2uGNLbMYtwd
	 IkgwzsskXizw5EYrPNYepXpRd6Dpb0lEVRUSRNLSBqDuqUynLh+gbgJoAxsEktIl+G
	 fF6Ap8TSOtaSrkPwXQUZ4Kvvg7GLIlHTcmldvRexOAduF7C5lAnphdLIxitzouKdsK
	 NUV63n+OqSTHtA1kOWTC8IRK4AmSnCpdhtlVUdDoYdtfl1SMFd4FLzugMyMYHKKizO
	 H5Y/S7mBc2G6YN/C/39jB7dK9ehV6++9KVC5LULNGgklyPeL/AhJsOQmJnaPUiN5cA
	 aoIWMmAyF6cEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: wacom: fix OOB read in
 wacom_wac_pen_serial_enforce()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Jie Law" <98lawweijie@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260822120926.153849-1-98lawweijie@gmail.com>
References: <20260822120926.153849-1-98lawweijie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 12:24:51 +0000
Message-Id: <20260822122451.61CF31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A 1-byte out-of-bounds heap read occurs in `wacom_wac_pen_serial_e=
nforce` when processing an unnumbered HID report.
--

--- Patch [1]: [PATCH] HID: wacom: fix OOB read in wacom_wac_pen_serial_enf=
orce() ---
commit 7eb0a702b27b2b8dba9547945aa50ecb4a4d7cc0
Author: Wei Jie Law <98lawweijie@gmail.com>

HID: wacom: fix OOB read in wacom_wac_pen_serial_enforce()

This commit fixes an out-of-bounds read in wacom_wac_pen_serial_enforce()
by clamping the usage iteration count to the field's actual report count.
This prevents extracting data beyond the received report bounds when a
descriptor lists more usages than its Report Count.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 0eafa483b7f75..1ea8763b68a82 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -113,8 +113,10 @@ static int wacom_wac_pen_serial_enforce(struct hid_d=
evice *hdev,
> =20
>  	/* Queue events which have invalid tool type or serial number */
>  	for (i =3D 0; i < report->maxfield; i++) {
> -		for (j =3D 0; j < report->field[i]->maxusage; j++) {
> -			struct hid_field *field =3D report->field[i];
> +		struct hid_field *field =3D report->field[i];
> +		unsigned int count =3D min(field->maxusage, field->report_count);
> +
> +		for (j =3D 0; j < count; j++) {
>  			struct hid_usage *usage =3D &field->usage[j];
>  			unsigned int equivalent_usage =3D wacom_equivalent_usage(usage->hid);
>  			unsigned int offset;

[Severity: High]
This isn't a bug introduced by this patch, but does the call to
hid_field_extract() later in this loop cause an out-of-bounds read if the
report is unnumbered?

Inside the loop, the code calls:

	value =3D hid_field_extract(hdev, raw_data+1, offset + j * size, size);

This blindly adds 1 to raw_data, assuming raw_data[0] is a report ID. If an
attacker crafts a USB HID device (or uses UHID) with the Wacom vendor ID
(0x056a) but provides a descriptor with no Report ID, the transport layer
allocates a buffer exactly matching the payload size.

For the last field in such an unnumbered report, this reads 1 byte past the
end of the heap allocation. Since the extracted value can be stored in
wacom_wac->serial[0] and emitted to userspace via MSC_SERIAL events, could
this lead to a 1-byte out-of-bounds heap read and information disclosure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822120926.1538=
49-1-98lawweijie@gmail.com?part=3D1
