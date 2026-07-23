Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652D2355F5C
	for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 02:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784774329; cv=none; b=qDQ62sx/LMsLpowFsSJoIcSzRVZ2VFU8zk8IR0j7RCTp7oXrzli0sXwRsmAxWbHI4jxehkCYngWLmIE4F9SaqAmKl47A6UpO5V1B65ZYTU8Vq6eDadlhVI+ddd6OUOcIHGGIza7wnVPAUsZ7ut80pgBEZhHr4PhfJlIDYniyH0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784774329; c=relaxed/simple;
	bh=1swifGGHOwKKS1aqGlITAMc/lpviq7Nh9AC+/sD1Hw4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sJHj7rVv6J2bR7v+M1rY+JJkE57h6CYU1/8kJlvoNUWqLtisvxuEYBQV0i4FhFUGDjtwWChSHZ5xTi1iD4FWda6hR54dyiHH4ZrYHdZdZwLsgLBSbNCoKk70jEyhc64lTFUdFiLmV4fNre6/sqOwv/f/IzILJuy3uKoQpJfmS48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgLoHhQg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgLoHhQg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8909B1F000E9;
	Thu, 23 Jul 2026 02:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784774326;
	bh=VIeV0vZt/w6ZbpEiMbknX4S2mJjXee4TcbMMxT1096Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PgLoHhQgCX3iFl5sFDoGd0ye9VDk0N3I2DOmDLbTtTAj5x2qLNhdof+11rPXq5Lb2
	 +cjxH7y1bga3SuP0OAXwVbzGp4Nduui0X6eHMEIfWHrGNAASjXwsvqmUZkyHQZ4NL1
	 FWiVdcO7Hx9F00lma9pTWahq5JgxSNa/EPSILd3yATVCvSNmrM5l+UdX7ZuAIn3Doz
	 NlKWWxUcbyiZUe3PZqS+PeH/5EbzL07HncPEjn1mKc3Sxu0Uvy4UBsy4ExC7w2R+FL
	 m2unIS3l/+T/rFF10H+R4OWZzOG5iOhDpdNzID9ISgiaD7soQXFX6RqtPTevJvldOM
	 IW5snju4SPEIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: charlieplex_keypad - check
 gpiod_direction_output() return value
Reply-To: sashiko-reviews@lists.linux.dev
To: kr494167@gmail.com
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260723022943.9337-1-kr494167@gmail.com>
References: <20260723022943.9337-1-kr494167@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 02:38:46 +0000
Message-Id: <20260723023846.8909B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The return value of `gpiod_direction_input()` is ignored, which ca=
n leave the line configured as an output driving HIGH upon hardware failure=
, breaking the matrix scanning logic.
--

--- Patch [1]: [PATCH] Input: charlieplex_keypad - check gpiod_direction_ou=
tput() return value ---
commit dcc381a1c321f8eedf04b92519f6edd1db4050eb
Author: Surendra Singh Chouhan <kr494167@gmail.com>

Input: charlieplex_keypad - check gpiod_direction_output() return value

This commit updates charlieplex_keypad_scan_line() to capture and return
the error code if setting the active output line fails. This prevents
the keypad from continuing to sleep and read inputs from an improperly
configured GPIO.

> diff --git a/drivers/input/keyboard/charlieplex_keypad.c b/drivers/input/=
keyboard/charlieplex_keypad.c
> --- a/drivers/input/keyboard/charlieplex_keypad.c
> +++ b/drivers/input/keyboard/charlieplex_keypad.c
> @@ -77,7 +77,9 @@ static int charlieplex_keypad_scan_line(struct charliep=
lex_keypad *keypad,
>  	int err;
> =20
>  	/* Activate only one line as output at a time. */
> -	gpiod_direction_output(line_gpios->desc[oline], 1);
> +	err =3D gpiod_direction_output(line_gpios->desc[oline], 1);
> +	if (err)
> +		return err;

[Severity: High]
This is a pre-existing issue, but since this patch explicitly adds error
checking for gpiod_direction_output(), should we also check the return value
when restoring the line to an input state?

A few lines below in charlieplex_keypad_scan_line(), the same pattern exists
when restoring the line direction:

	err =3D gpiod_get_array_value_cansleep(line_gpios->ndescs, ...);

	gpiod_direction_input(line_gpios->desc[oline]);

	if (err)
		return err;

If gpiod_direction_input() fails here due to a temporary hardware or bus er=
ror
(like on an i2c or spi GPIO expander), does this leave the line configured
as an output driving high?=20

On subsequent scans, this could cause multiple lines to act as outputs
simultaneously and break the matrix scanning logic entirely.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723022943.9337=
-1-kr494167@gmail.com?part=3D1
