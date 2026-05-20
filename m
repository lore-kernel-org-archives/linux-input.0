Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F6B33B6F9
	for <linux-input@vger.kernel.org>; Wed, 20 May 2026 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779277320; cv=none; b=gPVQTlQZN5t/v1Ba0Ur1IIYR+iCa/KYqF5NLOw8UJqG2koH/Bw200gwQfa5Hz2xOvm8uRrRbvOBKTVeYKeEdm4gv9BIJV/+zuA1gLE54UPd+HCA7Pa9A74hp3QD9p5KdI9s6PVVrb2hRJX+pnlBuCNOSMlHPzsmL7qLMb6vrJKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779277320; c=relaxed/simple;
	bh=NOCI+bN0c2tCoLZTioqVzL1iQV9kLUGSds5/EatYaXA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=atlY1ggwl2Qwf3X3DZjpo+ysqfjqBIgkfqnn+ypniFlviqDRLYJday9pOimLFFAyCQIIRrjocWvsxPLkzYkdnIqjsJkdQjQSzsjWr3WOSjMnojK6K+MPo2Z8M43G1qv+BMGTy/Q/B1DhVNjbUh7kw0A9oRu61IP4PLqklgXuBk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BN5d2Vs6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BN5d2Vs6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5589C1F000E9;
	Wed, 20 May 2026 11:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779277318;
	bh=xWWhWWJ1j+f7Fy0aRLqNd+LfxlBhPn5nXA97nVFz+qw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BN5d2Vs6LWJR08g+uMsNMRdHuvhqfKTVhb4vxoePIlWGDUiEGtx/mYVkELYLtQDWw
	 XeeMkmqnNo+EOBmSE+Z3fwyGVdCKsoL9NrYNG2fwH13K/M2H4hJUwtMEhyNzpWlO1f
	 OPHfRjmjSWnSPB8GSTLBMifY1yHTzKM9zBUalsmldXKO2OUWdl6U98Hr7MteP23Sqk
	 xo4yuZeMbhTtmwo1Mo87QielP9L1oq5nMayxn0WA3y4YkK7/fubSWsPnHIYoEGI+pK
	 6+bmnBkuOJEsDAJC8NThOr4KL0UOY/fAAFZ3lQA1BNckQVLzJMfRBYp5fkqa03FzyG
	 r2nWODP3o2sCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 7.0-5.10] HID: magicmouse: Prevent out-of-bounds
 (OOB) read during DOUBLE_REPORT_ID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260520111944.3424570-9-sashal@kernel.org>
References: <20260520111944.3424570-9-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 11:41:57 +0000
Message-Id: <20260520114158.5589C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] The newly added warning for mismatched report lengths is not rat=
e-limited, allowing an attacker to continuously spam the kernel log.
- [Low] Missing trailing newline in the newly added `hid_warn` format strin=
g.

Pre-existing issues:
- [Critical] A NULL pointer dereference can occur if a raw event is receive=
d before the device is fully initialized or if initialization fails to crea=
te an input device.
- [High] A malicious USB device can cause a kernel stack overflow by sendin=
g a crafted HID report with deeply nested DOUBLE_REPORT_ID reports.
--

commit 722425cdf7389e2fa0f87560f3507f1c80daa8b7
Author: Lee Jones <lee@kernel.org>

HID: magicmouse: Prevent out-of-bounds (OOB) read during DOUBLE_REPORT_ID

This commit adds checks to prevent out-of-bounds reads in the magicmouse
driver when processing DOUBLE_REPORT_ID reports. It verifies the report
size against the specified length and adds protection against zero-sized
recursive calls.

> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index 9eadf3252d0dc..f53839484c861 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -390,6 +390,10 @@ static int magicmouse_raw_event(struct hid_device *h=
dev,
>  	struct input_dev *input =3D msc->input;

[Severity: Critical]
This is a pre-existing issue, but can this lead to a NULL pointer
dereference?

If a device provides a crafted report descriptor without any input fields,
hidinput_connect() will not call .input_mapping, leaving msc->input as NULL.
During magicmouse_probe(), for some devices the probe returns 0 early witho=
ut
verifying msc->input. If raw IN reports are then streamed, this function wi=
ll
blindly dereference the NULL input pointer later when evaluating
input->id.product.

>  	int x =3D 0, y =3D 0, ii, clicks =3D 0, npoints;
> =20
> +	/* Protect against zero sized recursive calls from DOUBLE_REPORT_ID */
> +	if (size < 1)
> +		return 0;
> +

[ ... ]

> @@ -490,6 +494,18 @@ static int magicmouse_raw_event(struct hid_device *h=
dev,
>  		/* Sometimes the trackpad sends two touch reports in one
>  		 * packet.
>  		 */
> +
> +		/* Ensure that we have at least 2 elements (report type and size) */
> +		if (size < 2)
> +			return 0;
> +
> +		if (size < data[1] + 2) {
> +			hid_warn(hdev,
> +				 "received report length (%d) was smaller than specified (%d)",

[Severity: Low]
Does this log message need a trailing newline? It looks like the missing
newline will prevent the buffer from flushing immediately, causing subseque=
nt
log messages to append to this line.

[Severity: Medium]
Could this warning be abused to spam the kernel log? A malicious or
misconfigured device could rapidly stream malformed reports, flooding dmesg.
Would it be safer to use hid_warn_ratelimited() here?

> +				 size, data[1] + 2);
> +			return 0;
> +		}
> +
>  		magicmouse_raw_event(hdev, report, data + 2, data[1]);
>  		magicmouse_raw_event(hdev, report, data + 2 + data[1],
>  			size - 2 - data[1]);

[Severity: High]
This is a pre-existing issue, but does this recursion safely handle a paylo=
ad
entirely filled with DOUBLE_REPORT_ID markers and data[1] set to 0?

Because size is only decremented by 2 in each recursive step:

    magicmouse_raw_event(..., size - 2 - data[1]);

A large report of 4096 bytes could trigger up to 2048 nested calls. Since
tail-call optimization is not guaranteed in the kernel, couldn't this exhau=
st
the kernel stack and trigger a panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520111944.3424=
570-9-sashal@kernel.org?part=3D1
