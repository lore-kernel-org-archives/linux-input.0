Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8143438AB;
	Mon,  1 Jun 2026 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303595; cv=none; b=sE0LHNIvpr5E1hcZJX2xq7fAuu/4rvwq5J8FW8ougUCgRezpJUPgEaEND4OeU+x8JB3BTZeT/Bs6Yd8NF1Snh24e45dr0n0YmDFYmKYytNYrSjedOj3lyYwHvyaytuXMbO5JtrhANQCKi8ZKicl/gNeiBdl+J0zki96VTExpIY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303595; c=relaxed/simple;
	bh=zLSCLCYSpJJa+hjDgqEHZsmiqnn1rxWi1SEStGABqyE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TIDLxs7WuPaf8gqUCuKtKBxpuXdxKMK7UVmShlaqgw38WdUnDkBqq1bYWsvp+Iao48wrpnFU6qZheta+bwIAyr9qdtk4GpJC8GgY9ywB3T8F+A12tMECm0Nc02L+rPN4fyxROb5gKSDQJy2Eo7fI7Pcp9cRE5E6fJBCyIsG5wTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/Ji16pr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/Ji16pr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC151F00893;
	Mon,  1 Jun 2026 08:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780303594;
	bh=02m6gPeKh6gS1T2eRV6buoizcT6iQRHodyNjhht6MsM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A/Ji16pr14bbF7ew8RN65+MkfWf+wu6uhQYHqP1709Xhc/TgxcXsXoBDU1O4DOsn0
	 tcp25X8UlwI9+S3MDA7aAieyJkGQ5xkFomFRJlaaexY8PPqY7i1kmUpYxdQdYHcOdX
	 3OMIpsxzZJD4cJFfyftXpQS3/c22t6x6g41BLptazbdC/lBvOianlbRbTsoaEAUdGN
	 ME69acK9KT2jqNw7NqBEQfEO1vqY1OgMsODw1YzEsHobqJChJjfrf2HgZBIUWrNrRs
	 qfxbfWx7cdtJztL55sovaQrY9UEOO2y/Hfo+lN0Rq3ApnZBpa8lAXBgvF+itYtAtPZ
	 yKqFHQKVfpBWA==
From: sashiko-bot@kernel.org
Subject: Re: [linux-6.12.y 3/4] HID: core: introduce hid_safe_input_report()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: linux-input@vger.kernel.org, bpf@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260601083642.908433-3-lee@kernel.org>
References: <20260601083642.908433-3-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 08:46:33 +0000
Message-Id: <20260601084634.1BC151F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The patch introduces a hard build failure by passing 9 arguments to=
 a function expecting 8.

Pre-existing issues:
- [High] Integer underflow in `i2c_hid_get_input()` when computing the rema=
ining buffer size for bogus HID descriptors.
--

commit d54718e72e548c203a2c42b46b69bf352c081a00
Author: Benjamin Tissoires <bentiss@kernel.org>

HID: core: introduce hid_safe_input_report()

This patch introduces hid_safe_input_report() to be used in transport
layers like usbhid and i2chid. This provides the buffer size allowing
the hid-core to make smarter decisions regarding incoming buffers.

> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 294a25330ed03..2c5583818421e 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
[ ... ]
> @@ -2141,6 +2142,30 @@ int hid_input_report(struct hid_device *hid, enum =
hid_report_type type, u8 *data
>  }
>  EXPORT_SYMBOL_GPL(hid_input_report);
> =20
> +/**
> + * hid_safe_input_report - report data from lower layer (usb, bt...)
> + *
> + * @hid: hid device
> + * @type: HID report type (HID_*_REPORT)
> + * @data: report contents
> + * @bufsize: allocated size of the data buffer
> + * @size: useful size of data parameter
> + * @interrupt: distinguish between interrupt and control transfers
> + *
> + * This is data entry for lower layers.
> + * Please use this function instead of the non safe version because we p=
rovide
> + * here the size of the buffer, allowing hid-core to make smarter decisi=
ons
> + * regarding the incoming buffer.
> + */
> +int hid_safe_input_report(struct hid_device *hid, enum hid_report_type t=
ype, u8 *data,
> +			  size_t bufsize, u32 size, int interrupt)
> +{
> +	return __hid_input_report(hid, type, data, bufsize, size, interrupt, 0,
> +				  false, /* from_bpf */
> +				  false /* lock_already_taken */);
> +}

[Severity: Low]
Does this cause a build failure? Looking at the definition of
__hid_input_report() in this file, it only accepts 8 arguments:

static int __hid_input_report(struct hid_device *hid, enum hid_report_type =
type,
                              u8 *data, u32 size, int interrupt, u64 source,
                              bool from_bpf, bool lock_already_taken)

This call passes 9 arguments, including the new bufsize parameter. Were some
prerequisite upstream patches updating the signature of __hid_input_report()
omitted from this backport?

> +EXPORT_SYMBOL_GPL(hid_safe_input_report);
> +
>  bool hid_match_one_id(const struct hid_device *hdev,
>  		      const struct hid_device_id *id)
[ ... ]
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c=
-hid-core.c
> index cf8ae0df0cda9..8ce0535fc42d6 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -568,9 +568,10 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
>  		if (ihid->hid->group !=3D HID_GROUP_RMI)
>  			pm_wakeup_event(&ihid->client->dev, 0);
> =20
> -		hid_input_report(ihid->hid, HID_INPUT_REPORT,
> -				ihid->inbuf + sizeof(__le16),
> -				ret_size - sizeof(__le16), 1);
> +		hid_safe_input_report(ihid->hid, HID_INPUT_REPORT,
> +				      ihid->inbuf + sizeof(__le16),
> +				      ihid->bufsize - sizeof(__le16),
> +				      ret_size - sizeof(__le16), 1);

[Severity: High]
This is a pre-existing issue, but can this calculation underflow and pass a
massive size to the HID core?

If a device has the I2C_HID_QUIRK_BAD_INPUT_SIZE quirk and provides a bogus
descriptor with wMaxInputLength < 2, the size variable will be < 2, and the
code earlier in i2c_hid_get_input() forces ret_size =3D size.

When ret_size and ihid->bufsize are less than sizeof(__le16) (which is 2),
subtracting sizeof(__le16) will result in an unsigned integer underflow.
This large underflowed value would then be passed into the HID core here and
could lead to out-of-bounds reads in functions like hid_dump_report().

>  	}
> =20
>  	return;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601083642.9084=
33-3-lee@kernel.org?part=3D1
