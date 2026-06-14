Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177BA1E8826
	for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 03:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781406626; cv=none; b=piS8Nywm4JX16Lfc4XOuAhGTwqaw76MbWbVIIEbBhPYNxBqYSgYf69bnKBEG+wqkZVUMH+AFuqisYoD8AQDU9hRVT+Y7VnsenJrBp4Ax28LfqZqQrKkAJTRx84SSKZwXrK7j54dXnpTjUncAo945SoUfeYdBDpE4zcCTUCxvtYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781406626; c=relaxed/simple;
	bh=ERqDHqGMflDQkwzzAeSSP0jrL/Zwi3hTfmj9h16q34M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qplzAHT48xj3s+5E66t4TzJJ4DReH+I2WS5sauyC7zaB4QQH/bTwoTXw/qYYQ34ou1YhuvEUgMKswsQ+FI2c1PrLhvLXR+sqUhV86ibJPp8LLLQ74KfzH7RyIXNeavmEcvHSbeRHusyTIjZCa7Mc3tEG4RXvKWgGUh7lIDwZcZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKB/AYtq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKB/AYtq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A39E1F000E9;
	Sun, 14 Jun 2026 03:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781406624;
	bh=USvFF52aREMtEuA10FUa/2peudKkxpjYK7XrEtP4KBM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OKB/AYtqAw4KXDC1rBriHXkpXBVYP8HMpvInNy1g2zwiBjZAL4WuocqVrMS7D3KI8
	 DN9xHHVahznK898x362N3kRukHrDt0dNTjQnEe/ZWpZ/7hC2J5kXySYZvYgjvf0cPi
	 3w8GNZV5SscxvL0Hpm4pnnIetVS0EAZDtyNGIRrZnkYvXH+u8Pvr+oMKVlZXdMfD3I
	 yLTCJ5tMAPY342VsT/QFRT5U7YorsbD+E0SHB8SkynMMHhGFavXTKHg6evdfpRk8Wu
	 1d6Hm+rt9cTxVn1dDQiWi2EN9+ITY2Jz5U0mU7Z7RFyU7o5Hrol6EKZE28QiJ7YJzK
	 ANeiB51kU3f+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: iforce - bound the device-reported
 force-feedback effect index
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas via B4 Relay" <devnull+hexlabsecurity.proton.me@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260613-b4-disp-4828d263-v1-1-02320e1a89dd@proton.me>
References: <20260613-b4-disp-4828d263-v1-1-02320e1a89dd@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2026 03:10:23 +0000
Message-Id: <20260614031024.6A39E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] A zero-length USB packet causes an integer underflow when calc=
ulating the packet length, leading to massive out-of-bounds reads and a ker=
nel panic.
--

commit 03557dab27a995017f2c109d738ebd32fc4d550b
Author: Bryam Vargas <hexlabsecurity@proton.me>

Input: iforce - bound the device-reported force-feedback effect index

This commit bounds the force-feedback effect index reported by the device
to prevent an out-of-bounds read-modify-write past the core_effects[] array.
It fixes a memory corruption vulnerability caused by an unvalidated payload.

> diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/inp=
ut/joystick/iforce/iforce-packets.c
> index fd1cd731d781a..ff266568d586c 100644
> --- a/drivers/input/joystick/iforce/iforce-packets.c
> +++ b/drivers/input/joystick/iforce/iforce-packets.c
> @@ -186,14 +186,18 @@ void iforce_process_packet(struct iforce *iforce,
> =20
>  		/* Check if an effect was just started or stopped */
>  		i =3D data[1] & 0x7f;
> -		if (data[1] & 0x80) {
> -			if (!test_and_set_bit(FF_CORE_IS_PLAYED, iforce->core_effects[i].flag=
s)) {
> -				/* Report play event */
> -				input_report_ff_status(dev, i, FF_STATUS_PLAYING);
> +		if (i < IFORCE_EFFECTS_MAX) {
> +			unsigned long *flags =3D iforce->core_effects[i].flags;
> +
> +			if (data[1] & 0x80) {
> +				if (!test_and_set_bit(FF_CORE_IS_PLAYED, flags)) {
> +					/* Report play event */
> +					input_report_ff_status(dev, i, FF_STATUS_PLAYING);
> +				}
> +			} else if (test_and_clear_bit(FF_CORE_IS_PLAYED, flags)) {
> +				/* Report stop event */
> +				input_report_ff_status(dev, i, FF_STATUS_STOPPED);
>  			}
> -		} else if (test_and_clear_bit(FF_CORE_IS_PLAYED, iforce->core_effects[=
i].flags)) {
> -			/* Report stop event */
> -			input_report_ff_status(dev, i, FF_STATUS_STOPPED);
>  		}
> =20
>  		for (j =3D 3; j < len; j +=3D 2)

[Severity: Critical]
This is a pre-existing issue, but was not introduced by the patch under rev=
iew.

Could a zero-length USB packet cause an integer underflow that triggers a
massive out-of-bounds read in this loop?

Looking at iforce_usb_irq() in drivers/input/joystick/iforce/iforce-usb.c:

    iforce_process_packet(iforce, iforce_usb->data_in[0],
                  iforce_usb->data_in + 1, urb->actual_length - 1);

If urb->actual_length is 0, the subtraction underflows to a massive positive
unsigned value, which is passed as len.

If the first byte evaluates to a status report (packet ID 0x02), this loop
would execute against the underflowed len. Could this iterate billions of
times, repeatedly executing mark_core_as_ready() and causing uncontrolled
memory reads until an unmapped page is hit?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613-b4-disp-48=
28d263-v1-1-02320e1a89dd@proton.me?part=3D1
