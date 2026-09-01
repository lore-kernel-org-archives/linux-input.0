Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5403793B6
	for <linux-input@vger.kernel.org>; Tue,  1 Sep 2026 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788266453; cv=none; b=phHzGeuB6ebUnZYz83OM4LufqJaxpXANAQm/iGqIHrAeDolag9z8DQHKSx/mwjv8cdnsFR25SxqnWqo1yVz8tGmmltkmgfzj4WvwmQSHr2/IJheVnlmRs8ELIB8Wjanr30EgvvQwfaJdxBV7S12YKJCtMoApTZyfACSeG+yNt/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788266453; c=relaxed/simple;
	bh=TaQbHwTK/EJ8ARMqcKdNNx799/RzuEc+4XietvNBoCk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QFHxUMqob+JoqzzTXVernfpJW4NfnwQMNa6Gp8fgPf8/TBtOFnNTG+IrnqQuqN9dQDIEUg+5KSR9TGgvYt/I/VlHZDaGcK3CWqbK0wComLkuZJhlV33oD0YfnGDWt1K77fwXbFHymAG9pHvH7q1A0lZdWDOah9f0iKx8CrT29h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lx7DJAJv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lx7DJAJv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E820F1F000E9;
	Tue,  1 Sep 2026 12:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788266452;
	bh=ahikrmOjDteIZH0ZBB+hdFnHy/bxXc4epR7zRhKkTuI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lx7DJAJv+4GXdI3gEC8fr+bmlRHWENGfLL9NkPAYx3j+AAO5vO65PMi43HReEMhEJ
	 I1lfeyOVWDzVnIriu6/7VKtNDGQUnxJwOTkLewH+92IJ2dvLEBcRClwMO9VJjlxSLH
	 FOlrtT2FYa0Bxh8kw3RrZDfFozd2WusoomQIEQiAKzQgYJ1WbpGC43gC0mXomDISu5
	 l23xnMyVhVCPUau2xB9idYz8RzcUp13Ns6i7xik46O8AL5G/2cZkl+zdxkjBHzBeNW
	 JSGoQPRgWbYPqKq0l5F1vwPAyfPov15SU23kVHXYF1jmzMyhJ0S++aHYoQf1bGWzNJ
	 kBLtdJnwIFFPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: cyttsp5 - clamp the HID report size before
 memcpy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linkai Gong" <gonglinkai@kylinos.cn>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260901122649.1173066-1-gonglinkai@kylinos.cn>
References: <20260901122649.1173066-1-gonglinkai@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 12:40:51 +0000
Message-Id: <20260901124051.E820F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete Buffer Overflow Fix (TOCTOU) / Out-of-bounds Read / Int=
eger Underflow
- [High] Out-of-Bounds Read / Missing Length Validation for Touch Data
--

commit 0acfd851483a1efe80080d23464f2baa2b7b318e
Author: Linkai Gong <gonglinkai@kylinos.cn>

Input: cyttsp5 - clamp the HID report size before memcpy

This commit attempts to fix a buffer overflow by clamping the size of the
HID report payload before copying it into the response buffer.

> diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscr=
een/cyttsp5.c
> index 9266c07314bee..e878a02dc9b75 100644
> --- a/drivers/input/touchscreen/cyttsp5.c
> +++ b/drivers/input/touchscreen/cyttsp5.c
> @@ -710,6 +710,7 @@ static irqreturn_t cyttsp5_handle_irq(int irq, void *=
handle)
>  		size =3D 2;
>  	} else {
>  		report_id =3D ts->input_buf[2];
> +		size =3D min(size, CY_MAX_INPUT);
>  	}
> =20
>  	switch (report_id) {

[Severity: High]
This isn't a bug introduced by this patch, but the patch provides an
incomplete fix. Although the local size variable is clamped here to protect
the memcpy, the unclamped size remains embedded within the copied payload in
ts->input_buf, which is then copied to ts->response_buf.

Later, cyttsp5_validate_cmd_response() reads the original unclamped size
directly from the buffer:

cyttsp5_validate_cmd_response() {
    ...
    size =3D get_unaligned_le16(&ts->response_buf[0]);
    ...
    if (ts->response_buf[size - 1] !=3D HID_OUTPUT_BL_EOP) {
        ...

If the device provided a size greater than 512, does this result in an
out-of-bounds read?

Additionally, if the size is very small (e.g., 5), the expression size - 7
mathematically underflows when passed to crc_itu_t():

crc =3D crc_itu_t(0xFFFF, &ts->response_buf[4], size - 7);

Could we also validate the size value stored inside the buffer, or ensure
that the extracted size in cyttsp5_validate_cmd_response() falls within safe
bounds (>=3D 7 and <=3D CY_MAX_INPUT)?


[Severity: High]
This is also a pre-existing issue, but while we are looking at bounds check=
ing
in this driver, there appears to be missing validation for the touch data
sizes as well.

In cyttsp5_get_sysinfo_regs(), scd->max_tch is set directly from the device
payload without capping it to fit within the static CY_MAX_INPUT buffer
bounds.

When an interrupt occurs, cyttsp5_mt_attention() extracts num_cur_tch from
the payload. There is no check to guarantee that num_cur_tch multiplied by
TOUCH_REPORT_SIZE fits within the statically allocated 512-byte buffer.

For large values of num_cur_tch, the loop in cyttsp5_get_mt_touches()
calculates pointers that exceed the 512-byte bound:

cyttsp5_get_mt_touches() {
    ...
    for (i =3D 0; i < num_cur_tch; i++) {
        tch_addr =3D ts->input_buf + offset + (i * TOUCH_REPORT_SIZE);
        ...

Could this lead to out-of-bounds reads of the ts->input_buf array,
potentially leaking adjacent kernel heap data into userspace via the input
events?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901122649.1173=
066-1-gonglinkai@kylinos.cn?part=3D1
