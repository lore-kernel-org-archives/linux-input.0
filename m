Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D713368AA
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105505; cv=none; b=FYnrXZaQBsrb6rPMg76c/xu/BEAQg/qiI23n6sn6EtZmI7empAE8/KdOX/IojyA/UuifbHJKymcI1hPqdTilGthyBKQEYkXhSrHm+iwSUh8/IfVjPe1SSTkH7cJodlYdq1rl6LCRMoM2gLFFdESb7CObYl0wh4swaSxvn1K/Cko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105505; c=relaxed/simple;
	bh=FHGIF2SHeAvuDJjqGpqrMm/EAlvoG487ZVTTjTFZ8Ts=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H7b9FA2Dulm3xxwV9J2krxhmv/ifKSmqmBbOsGCmA8xBPhcL1riJOxPRz9hzojbYOLaPnQ/jD6XaUCBmgs3PV+KPQE5LBgxJzJ5j6o9oWwuem1+J9V06Y7jMAv3WwXJEAkx07S1XpcOIZ81DMS0PbwomA2sU9mobN38nVs1uoOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaL4BbVN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaL4BbVN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1585C1F000E9;
	Wed, 15 Jul 2026 08:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784105504;
	bh=wF5l8dJtEsnJqJ6YZn0yi/4qS6MVnLbtjuqM8g4qZ+4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QaL4BbVNu3A9whFeM7YG8+G1h3c0L370C5guDz3wm/DTz8EE87h77QqeQkeSYK57V
	 /2BdoI5nSNa+AvSL9KbiMclz2cYbd+2oN04MCBaGzjameEy788/GPF9rQLWhTQzwWf
	 70JeDunY6of1kZWzOp4jMhEeQX8C7AbcqktfvkO3P29LIGUiI0MTCZAdtwXhR/+MCR
	 jMlzL2wrHS2z7w6rFTRHKEHdf64YIoUhnYZLZkQ3h6qxJjN4+KsJDfdPXAsU+J3huz
	 ADH3xtXHjSAiQMtXP48O633ef4KI/rX8JbF+RLE7+pb3Y2kO30WXIEyKHK2jjbeVpa
	 iiDlEJhaR4Eaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: iqs5xx: validate firmware record destination
 span
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260715083850.32155-1-pengpeng@iscas.ac.cn>
References: <20260715083850.32155-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 08:51:43 +0000
Message-Id: <20260715085144.1585C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent writes to the `fw_file` sysfs attribute can lead to a d=
ouble-registration of the input device, causing a kernel crash.
- [High] A checksum validation error in the firmware file is silently dropp=
ed, leading to incomplete firmware flashing.
- [Medium] The touchscreen input device may never be registered if a firmwa=
re update retry succeeds following an initial initialization failure.
--

--- Patch [1]: [PATCH] Input: iqs5xx: validate firmware record destination =
span ---
commit 897f4810526cdc25897398dbb6d1023c54aafc6a
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

Input: iqs5xx: validate firmware record destination span

This commit adds a length check in iqs5xx_fw_file_parse() to ensure that the
firmware record data fits within the remaining programmable map span. It
prevents out-of-bounds copies when a record is near the end of the map.

> diff --git a/drivers/input/touchscreen/iqs5xx.c b/drivers/input/touchscre=
en/iqs5xx.c
> index b9bbe8b3eab81..8559be7ed9a95 100644
> --- a/drivers/input/touchscreen/iqs5xx.c
> +++ b/drivers/input/touchscreen/iqs5xx.c
> @@ -786,7 +786,8 @@ static int iqs5xx_fw_file_parse(struct i2c_client *cl=
ient,
>  		switch (rec_type) {
>  		case IQS5XX_REC_TYPE_DATA:
>  			if (rec_addr < IQS5XX_CHKSM ||
> -			    rec_addr > IQS5XX_PMAP_END) {
> +			    rec_addr > IQS5XX_PMAP_END ||
> +			    rec_len > IQS5XX_PMAP_END + 1 - rec_addr) {
>  				dev_err(&client->dev,
>  					"Invalid address at record %u\n",
>  					rec_num);

[Severity: High]
This isn't a bug introduced by this patch, but I noticed that later in this
same function, if a checksum validation failure occurs, the error code seems
to be swallowed:

drivers/input/touchscreen/iqs5xx.c:iqs5xx_fw_file_parse() {
...
		if (chksm !=3D rec_chksm && rec_addr < IQS5XX_CSTM) {
			dev_err(&client->dev,
				"Incorrect checksum at record %u\n",
				rec_num);
			error =3D -EINVAL;
			break;
		}
...
	} while (rec_type !=3D IQS5XX_REC_TYPE_EOF);

	return 0;
}

Since the break statement exits the do...while loop and the function
unconditionally returns 0 at the end, doesn't this result in the checksum
error being silently ignored?

Could this lead to an incomplete or corrupted memory map being flashed if
the firmware file is invalid?

[Severity: High]
This is a pre-existing issue, but I found a potential problem in
fw_file_store() where concurrent writes could lead to a double-registration
of the input device:

drivers/input/touchscreen/iqs5xx.c:fw_file_store() {
...
	bool input_reg =3D !iqs5xx->input;
...
	error =3D iqs5xx_fw_file_write(client, fw_file);
	if (error)
		return error;

	/*
	 * If the input device was not allocated already, it is guaranteed to
	 * be allocated by this point and can finally be registered.
	 */
	if (input_reg) {
		error =3D input_register_device(iqs5xx->input);
...
}

The input_reg flag is evaluated locklessly before calling
iqs5xx_fw_file_write(). If two threads concurrently write to fw_file
when the device is in bootloader mode (iqs5xx->input is NULL), both threads
would evaluate input_reg as true.

They would then serialize through iqs5xx_fw_file_write(), where the first
thread allocates the input device. When both threads return, wouldn't they
independently check their local input_reg variables and concurrently call
input_register_device(iqs5xx->input) on the exact same pointer?

[Severity: Medium]
This is another pre-existing issue, but there appears to be a separate
registration problem involving iqs5xx_axis_init() and fw_file_store():

drivers/input/touchscreen/iqs5xx.c:iqs5xx_axis_init() {
...
	if (!input) {
		input =3D devm_input_allocate_device(&client->dev);
		if (!input)
			return -ENOMEM;
...
		input_set_drvdata(input, iqs5xx);
		iqs5xx->input =3D input;
	}

	error =3D iqs5xx_read_word(client, IQS5XX_X_RES, &max_x);
	if (error)
		return error;
...
}

If a firmware update via fw_file_store() triggers iqs5xx_axis_init() and
allocates the input device, but a subsequent I2C read like iqs5xx_read_word=
()
fails, fw_file_store() will return an error without calling
input_register_device().

The iqs5xx->input pointer remains non-NULL. If user-space retries the
firmware update and it succeeds, won't fw_file_store() evaluate input_reg
as false and skip calling input_register_device() entirely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715083850.3215=
5-1-pengpeng@iscas.ac.cn?part=3D1
