Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0B713C9C4
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 02:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783737870; cv=none; b=ZGuSCDCDfWkFWLNM+842SYpLXbx0A/cduuR9195Xd3OFjDF8PPKyeJPZElmeMK6CZ0m3XOVEy4KsmiNOwoJoFPzz9JVEPZvc3mBa/MBQXSYdJE3V6LleDbYnLgh+5SoxaQTupVQOXWA/6PXJFyIavoP0nblpUTeym5i20+kPTCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783737870; c=relaxed/simple;
	bh=972otF5tI6sibOtvj9PQN6lYyL7UYbwZp1pE6u7ZboI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tZKDRj6czjwVAw5V/Q/HZyp2mriK0qxp8fJXIS/G8yCDSSjXnWiZOtg5w1SuUsfDi8OOAqAPN8e/gMnz6jl9PWW2MTybhBeXMZ/Fk3SdtH+GkEFAHmlOy04+6apqhZi6vhJDmLoKwEomWsoea3bxkVGCHj675z2LcMwlKmhNhmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnwxrEmV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnwxrEmV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7FF1F000E9;
	Sat, 11 Jul 2026 02:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783737869;
	bh=H2+S4FO0kW/zE7mVtqGuEVNFyZPV72OHN0E1dVVKz14=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TnwxrEmVfHNpl+oM6Y7ltHOr2MxGpOqjJA4qh57Exx3eeXXBUUdD6PL9qtr6wsTGY
	 QGOfCnAWKNoM83VPpmtAxkkPh86WF7IiftAmUwHNJhVnb1mJHEnyBcEB7dO29dn2uS
	 dNV/JVCLmrAUPNVICY0TqESaJAZClLKwVJKIuN0PaFSkI+vk5YKH3vlEQXGWCjs01Z
	 mQlGnroQJpDI6RyvQiELzvsyS19kuLP0/CAc+3TqNmz69ApWd9DFiMqlFJQAdgGcxb
	 vh2Sel2WlTcW+L6Nev7C7cSl9wbtBGvgSCrCAsU0PtBYIw+xlxgp3awiI0ZJhqSaz7
	 dlx1qrH0Nvl4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Input: qt1050 - wait for calibration to complete
Reply-To: sashiko-reviews@lists.linux.dev
To: "Miles Krause" <mileskrause5200@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260710-qt1050-calibration-status-bit-v2-1-a58da64bdf7e@gmail.com>
References: <20260710-qt1050-calibration-status-bit-v2-1-a58da64bdf7e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 02:44:28 +0000
Message-Id: <20260711024428.ED7FF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Race condition in calibration polling loop causes immediate premat=
ure exit.
- [Medium] The 200ms timeout is dangerously tight to wait for the entire ca=
libration process to finish.

Pre-existing issues:
- [High] The interrupt handler reports static firmware keycodes instead of =
the dynamic `keycodes` array, breaking userspace key remapping (`EVIOCSKEYC=
ODE`).
--

--- Patch [1]: [PATCH v2] Input: qt1050 - wait for calibration to complete =
---
commit 4b6f3ed53ac1e4647765d5813d7b91b2a1e6100d
Author: Miles Krause <mileskrause5200@gmail.com>

Input: qt1050 - wait for calibration to complete

The commit fixes a polling condition where regmap_read_poll_timeout() stopp=
ed
when calibration started rather than when it finished. It names the
calibration status bit and inverts the polling condition.

Closes: https://lore.kernel.org/r/20260711011903.0605C1F000E9@smtp.kernel.o=
rg

> diff --git a/drivers/input/keyboard/qt1050.c b/drivers/input/keyboard/qt1=
050.c
> index f9f480c910325..457acae0986aa 100644
> --- a/drivers/input/keyboard/qt1050.c
> +++ b/drivers/input/keyboard/qt1050.c
[ ... ]
> @@ -498,7 +499,8 @@ static int qt1050_probe(struct i2c_client *client)
>  		return err;
>  	}
>  	err =3D regmap_read_poll_timeout(ts->regmap, QT1050_DET_STATUS, status,
> -				 status >> 7 =3D=3D 1, 10000, 200000);
> +				 !(status & QT1050_DET_STATUS_CALIBRATE),

[Severity: High]
Will this polling condition evaluate to true on the very first read?

Because I2C transactions and hardware state changes take time, the first re=
ad
in qt1050_probe() will likely return a status where the calibration bit is
still 0. This would instantly satisfy the wait condition and bypass the loop
before calibration even begins, leaving the device in an uncalibrated state
when the subsequent soft reset occurs.

> +				 10000, 200000);

[Severity: Medium]
Is this 200ms maximum timeout dangerously tight for an operation that takes
approximately 200ms to complete?

The original 200ms timeout was used to wait for calibration to start, but
using it to wait for the entire calibration process leaves virtually no mar=
gin
for hardware or timing variances, potentially causing the probe to
sporadically fail with -ETIMEDOUT.

>  	if (err) {
>  		dev_err(dev, "Calibration failed: %d\n", err);
>  		return err;

[Severity: High]
This is a pre-existing issue, but does the interrupt handler report the sta=
tic
firmware keycode instead of the dynamically mapped one?

During probe, the driver properly sets input->keycode =3D ts->keycodes to
support dynamic remapping, but in qt1050_irq_threaded() it hardcodes the
static array:

drivers/input/keyboard/qt1050.c:qt1050_irq_threaded() {
    ...
    input_report_key(input, ts->keys[i].keycode,
                     test_bit(i, &new_keys));
    ...
}

When userspace remaps a key via EVIOCSKEYCODE, the input core updates
ts->keycodes and clears the old keycode's bit. Because the ISR still reports
the old, unmapped keycode, the input core safely filters it out and drops t=
he
event, breaking userspace key remapping entirely.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-qt1050-cal=
ibration-status-bit-v2-1-a58da64bdf7e@gmail.com?part=3D1
