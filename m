Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FF6383C64
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 07:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805087; cv=none; b=L3cW3XVxlXEjH7SyroIpckq1q1yFPt5RelF23nAiM2iD91mms3Ym3tE4bG6gb1TU1Pn+wuDLdfg5j/qKi3AofGiYT18wIYmzq86e5z5QMdT/fqcSzuVS9hU2pW2EJEVriwbyZ4BVT//RvvDKYHPcRdZeennJ9S4bbTUrLBKZoU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805087; c=relaxed/simple;
	bh=fTNP/fxK8N0RVVudYn4Klci0fFaT/gJJ9yWqGqTR8Pk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FdfvY5iUIyD/s042u2f4wr6XNhGotW5hz2MC1ELmZXbuGHZAkY7h11P2yQe8bYYiZXUrWtlAeFLhtVTJ0TtGMVVCtk+877mIB7wF8BEKEH3SfomBOQYIdL29X18Qu2CzLXYtiSkSNmyReZWZO+2O2Z/Bc5DzBmTmLAylPBfrcNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhbF3JnW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhbF3JnW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858061F000E9;
	Tue, 30 Jun 2026 07:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782805085;
	bh=jQErWCsSfzQqrfluuwatKVOKwfbNngICc44BbZKKdus=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GhbF3JnWZiEGRIM+H84LqcUzActEKaAO6uoVYUW1rvVg74s20+/HvO+JXpdFOVYxu
	 zKo5wYGKueKb5vw1KUaNwMdMiklSs579QrzmusVYEEJBisJmABXNLYt56Bhh5m8u8q
	 ZRyMZGzWYvw61AuI677iQJ7IcLxMrdxV/UyjmfjpzeaU9fsOz4/i0+RWfAVTaiYK92
	 BDYD+RCaS9JkVLNSFk/2ALaNm6WUIE61dypDg+BtfEWmsAyx2KzxiGplmOiPEepykT
	 53W42c/BN9zLwUI37mBCrI9hF/HBB40TT784XLEFLnojOvz0a6RyM07lsRkYI0pLog
	 QzjYyNbUpo0Cg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: cyapa - validate unsupported PIP response length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <2026063008017969.1-ccfa108-0008-Input-cyapa---validate-unsu-pengpeng@iscas.ac.cn>
References: <2026063008017969.1-ccfa108-0008-Input-cyapa---validate-unsu-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 07:38:05 +0000
Message-Id: <20260630073805.858061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Stack buffer overflow in `cyapa_pip_irq_handler` when reading =
touch reports.
- [High] Stack out-of-bounds read in `cyapa_gen5_read_panel_scan_raw_data` =
during raw data parsing.
- [High] Stack out-of-bounds read and kernel infinite loop in `cyapa_gen5_r=
ead_idac_data`.
--

commit 577a902f2ff46d9f3cceff655a89f68889610a56
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

Input: cyapa - validate unsupported PIP response length

cyapa_sort_tsg_pip_app_resp_data() accepts PIP application
responses after checking PIP_MIN_APP_RESP_LENGTH bytes.  That covers
the application command byte at offset 4, but the unsupported-command
path also reads the status byte at PIP_RESP_STATUS_OFFSET.

A short response can advertise PIP_UNSUPPORTED_CMD_RESP_LENGTH in the
response header while the supplied buffer still contains only the generic
minimum response.  Validate the unsupported response length before reading
the status byte.

> diff --git a/drivers/input/mouse/cyapa_gen5.c b/drivers/input/mouse/cyapa=
_gen5.c
> index 59f6e97d54827..733da6d324331 100644
> --- a/drivers/input/mouse/cyapa_gen5.c
> +++ b/drivers/input/mouse/cyapa_gen5.c
> @@ -686,6 +686,7 @@ bool cyapa_sort_tsg_pip_app_resp_data(struct cyapa *c=
yapa,
>  		u8 *data, int len)
>  {
>  	struct cyapa_pip_cmd_states *pip =3D &cyapa->cmd_states.pip;
> +	u8 cmd_code;
>  	int resp_len;
> =20
>  	if (!data || len < PIP_MIN_APP_RESP_LENGTH)

[ ... ]

>  		/* Read mutual global idac or local mutual/self PWC data. */
>  		offset +=3D read_len;
>  		for (i =3D 10; i < (read_len + GEN5_RESP_DATA_STRUCTURE_OFFSET);
>  				i +=3D *data_size) {
>  			value =3D cyapa_parse_structure_data(resp_data[9],
>  					&resp_data[i], *data_size);

[Severity: High]
This is a pre-existing issue, but does this loop in
cyapa_gen5_read_idac_data() risk an infinite loop or out-of-bounds read?

If a malicious I2C peripheral sets the data size (derived from resp_data[9])
to 0, wouldn't the loop fail to increment i and hang the CPU?

Additionally, doesn't blindly trusting read_len (derived from resp_data[7:8=
])
for the loop bound risk reading past the bounds of the 256-byte resp_data
stack array?

[ ... ]

> 		read_elements =3D get_unaligned_le16(&resp_data[7]);
> 		if (read_elements =3D=3D 0)
> 			break;
>=20
> 		data_size =3D (resp_data[9] & GEN5_PWC_DATA_ELEMENT_SIZE_MASK);
> 		offset +=3D read_elements;
> 		if (read_elements) {
> 			for (i =3D GEN5_RESP_DATA_STRUCTURE_OFFSET;
> 			     i < (read_elements * data_size +
> 					GEN5_RESP_DATA_STRUCTURE_OFFSET);
> 			     i +=3D data_size) {
> 				value =3D cyapa_parse_structure_data(resp_data[9],
> 						&resp_data[i], data_size);

[Severity: High]
This isn't a bug introduced by this patch, but does this risk an out-of-bou=
nds
read on the kernel stack in cyapa_gen5_read_panel_scan_raw_data()?

If the device returns a large read_elements value, the loop condition appea=
rs
to allow cyapa_parse_structure_data() to read far beyond the bounds of the
256-byte resp_data stack array.

[ ... ]

> int cyapa_pip_irq_handler(struct cyapa *cyapa)
> {
> 	struct device *dev =3D &cyapa->client->dev;
> 	struct cyapa_pip_report_data report_data;
> 	unsigned int report_len;
> 	int ret;
>=20
> 	if (!cyapa_is_pip_app_mode(cyapa)) {
> 		dev_err(dev, "invalid device state, gen=3D%d, state=3D0x%02x\n",
> 			cyapa->gen, cyapa->state);
> 		return -EINVAL;
> 	}
>=20
> 	ret =3D cyapa_i2c_pip_read(cyapa, (u8 *)&report_data,
> 			PIP_RESP_LENGTH_SIZE);

[ ... ]

> 	/* Idle, no data for report. */
> 	if (report_len =3D=3D PIP_RESP_LENGTH_SIZE)
> 		return 0;
>=20
> 	ret =3D cyapa_i2c_pip_read(cyapa, (u8 *)&report_data, report_len);

[Severity: Critical]
This is a pre-existing issue, but could this lead to a stack buffer overflow
in cyapa_pip_irq_handler()?

The report_data structure is 127 bytes on the stack, but an untrusted
report_len from the device is used in cyapa_i2c_pip_read(). Since the read
wrapper only caps the length to 256 bytes (CYAPA_REG_MAP_SIZE), can't a
compromised peripheral supply a length that overflows the buffer and corrup=
ts
the stack?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026063008017969.1-=
ccfa108-0008-Input-cyapa---validate-unsu-pengpeng@iscas.ac.cn?part=3D1
