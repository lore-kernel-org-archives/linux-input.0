Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFBF346A11
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784117755; cv=none; b=kbFoElq4IHyXKmnqjSaB0XSgQSJForP66d38I2irCHYE0/fXPD+w702zNwffmhbqWoUA2leObT+3kpSEkyLzaOXK7Z6pq1u7cbo+zI6gyJtezUl7zXuAVDafXF/dXqeAvSDogwKru8gn3uAmhGKqp7Z+uO729KzMV/Cm70Kqu3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784117755; c=relaxed/simple;
	bh=XZQqEMOlbKlrULb9A0/shv9+8AszlzZrDi0a3JZBPZ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fenIa8cmyzxgSICBxSArjhRZPJsT0Lum7tAknOmQpKkwz8sBfQK4L23v/lzxpRwHaH8BXGVP9VU1NoOssScsrUBX2U2iAUN9oJGVKCVd0zp3CEr26lHX+iWQdJfuvBMC0yO7Y+ghmRigrdtoykutPdi9RHHN8wHOOD7juRfWiYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQsb0UMx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQsb0UMx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48241F00A3A;
	Wed, 15 Jul 2026 12:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784117754;
	bh=xFA/gpIn2ltEWn1IwK1CeNN/Q6ID4vGv+9V6h9WDwbk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JQsb0UMxHJhfUALMp5VJQrzEPgyimmFHOi7XlSelJDq3UxDgyn8yzX4YPgw76OGnz
	 4nP5OFgoUfePtBhiVVPN4/g8Cq4t/evY8wLkJXb3JsA7rCeeCXHkcD7CJE2rjF/hxb
	 jqJKJW+JbnfuNzzXmzF1MXW7BuIJLZsDqjFqlAOAA2o0Zqvl58efuVHVGgWOu3h/pg
	 stmJHBBtJsRM5ZpB+sCjABLeALoHMNiSYCCZuU/xh53ucrTglBk95kmb9rg+ZBGwP4
	 vefrMdqRBokhX8qa0BAQKsH1W14ZqYldZymCp8Fsud4hvUeR0Q5p2xXbn0mmP0SnTD
	 Hn3BBSRe7iF0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: nintendo: fix out-of-bounds read in
 joycon_ctlr_read_handler()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ibrahim Hashimov" <security@auditcode.ai>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260715115253.91029-1-security@auditcode.ai>
References: <20260715115253.91029-1-security@auditcode.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 12:15:53 +0000
Message-Id: <20260715121553.D48241F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The input device is registered before its capabilities are fully i=
nitialized.
--

--- Patch [1]: [PATCH] HID: nintendo: fix out-of-bounds read in joycon_ctlr=
_read_handler() ---
commit 4a13815d9787a8e4509f8221af788267db0c1886
Author: Ibrahim Hashimov <security@auditcode.ai>

HID: nintendo: fix out-of-bounds read in joycon_ctlr_read_handler()

This commit changes a bounds check in joycon_ctlr_read_handler() from
12 bytes to the full size of struct joycon_input_report. This prevents
an out-of-bounds read when decoding IMU reports that are smaller than
the full structure size.

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index e7302ec01ff1f..11b5fe05acf44 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -2607,7 +2607,12 @@ static int joycon_ctlr_read_handler(struct joycon_=
ctlr *ctlr, u8 *data,
>  {
>  	if (data[0] =3D=3D JC_INPUT_SUBCMD_REPLY || data[0] =3D=3D JC_INPUT_IMU=
_DATA ||
>  	    data[0] =3D=3D JC_INPUT_MCU_DATA) {
> -		if (size >=3D 12) /* make sure it contains the input report */
> +		/*
> +		 * The whole struct is cast and parsed below, including the
> +		 * IMU/subcmd union, not just the 12-byte partial header this
> +		 * used to check for.
> +		 */
> +		if (size >=3D sizeof(struct joycon_input_report))
>  			joycon_parse_report(ctlr,
>  					    (struct joycon_input_report *)data);
>  	}

While reviewing this file, I noticed a pre-existing issue in
joycon_input_create():

drivers/hid/hid-nintendo.c:joycon_input_create() {
[ ... ]
	ctlr->input->phys =3D hdev->phys;
	input_set_drvdata(ctlr->input, ctlr);

	ret =3D input_register_device(ctlr->input);
	if (ret)
		return ret;

	if (joycon_type_is_right_joycon(ctlr)) {
		joycon_config_right_stick(ctlr->input);
[ ... ]
}

[Severity: High]
This is a pre-existing issue, but is the input device registered here before
its capabilities are configured?

Calling input_register_device() before setting the keys and absolute axes
results in an empty capability map during registration. This causes the joy=
dev
handler to reject the device since EV_KEY and EV_ABS are not set.

Could this lead to udev exporting empty capabilities, and evdev calculating
an incorrect event buffer size, causing applications to fail to reliably
recognize the controller?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715115253.9102=
9-1-security@auditcode.ai?part=3D1
