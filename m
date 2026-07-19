Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8E724C06A
	for <linux-input@vger.kernel.org>; Sun, 19 Jul 2026 05:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784440439; cv=none; b=A+vRJnd0YBZ4uJTxAkSk2roQEgP6tnEDl1a4lLsz8Sdp3d1Yj71XW5It2OJDwEkaEBKabuWk5mAfdwbcvUJakzBFWpfG9ujIcb4s4AJB6vWBDoTdIwZa2ljZcVbLL87wWyLJKUc0VgPqkeO289Ibc/qKV2Edwg+0BEbCszPX/lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784440439; c=relaxed/simple;
	bh=fshbUsvweA9NhVtrpVmcl8GvZDAIGV/HqCEhCHNzM3M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ccea3TdQJk2cLqs59Xkb+BIGi+snrJE6q1fFvlK8msthC1X+yqCRf8QTR/IscEafQSI1yMK5AUVWIxC1nBcl4Pec96dOit76yvvajVjqVcEdkhOUtGraC3lK79oXXgqHyuRYth0pizPJPhDYhNPSEmA9HwEDO8krLGaZcYX+qzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7JvHfOs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7JvHfOs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDAC1F000E9;
	Sun, 19 Jul 2026 05:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784440437;
	bh=NJsXj0aPlWibDd4HM8abmlRMF/+bS1/OAm87ZM/qZ2M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E7JvHfOsZSfa9XR4l18rwokoCgles09ic8muObNkfuwPXRDkEtBfHHQdtaZwuni3k
	 SkeK37kQMDtieRtTEKOg3slgKAGEybztIsBixfUWnFx7GJR3lYGEY0i5AynKcMfgRQ
	 mL65t/Dxxg/CYQTf42c83jdej3Xfn91hcThpBjdm/DiDVNP+4PfI5BTl7p9Kjc7WZU
	 /3NEKYykXEMhbZa1l1nfJUt6mGBXNVJVpPBYJ9z5KEcL04NZ59ZDtPXqw47OapoldN
	 RF4aH9WAIG+14IpQ/LsJyGw3wBiQ+AHAUIQtEU3R3mZcjWRx1LZmXh417+ZL31bMzo
	 MI93MG/EUXxEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Input: gunze: replace deprecated APIs and fix
 warning style
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bivash Kumar Singh" <bivashraj750@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260719054121.5917-1-bivashraj750@gmail.com>
References: <20260718190040.10613-1-bivashraj750@gmail.com>
 <20260719054121.5917-1-bivashraj750@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Jul 2026 05:53:56 +0000
Message-Id: <20260719055357.5DDAC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Strict parsing with kstrtoul() and an early return drops packets o=
n non-digit coordinate data, potentially causing permanently stuck touch st=
ates.
--

--- Patch [1]: [PATCH v2] Input: gunze: replace deprecated APIs and fix war=
ning style ---
commit 448e772e264a7d37aec51432b84a51cdf06f350f
Author: Bivash Kumar Singh <bivashraj750@gmail.com>

Input: gunze: replace deprecated APIs and fix warning style

This commit replaces the deprecated simple_strtoul() API with kstrtoul()
and updates the logging style to use dev_warn(). It also adds an early
return in the packet processing path if coordinate parsing fails.

> diff --git a/drivers/input/touchscreen/gunze.c b/drivers/input/touchscree=
n/gunze.c
> index 2baeb4f3b941c..e9c028430420c 100644
> --- a/drivers/input/touchscreen/gunze.c
> +++ b/drivers/input/touchscreen/gunze.c
[ ... ]
> @@ -41,15 +41,24 @@ static void gunze_process_packet(struct gunze *gunze)
[ ... ]
> -	input_report_abs(dev, ABS_X, simple_strtoul(gunze->data + 1, NULL, 10));
> -	input_report_abs(dev, ABS_Y, 1024 - simple_strtoul(gunze->data + 6, NUL=
L, 10));
> +	memcpy(buf, gunze->data, GUNZE_MAX_LENGTH);
> +	buf[5] =3D '\0';		/*NULL-terminate X portion: "1234\0" */
> +	buf[GUNZE_MAX_LENGTH] =3D '\0';	/*NULL-terminate Y portion */
> +
> +	if (kstrtoul(buf + 1, 10, &x) || kstrtoul(buf + 6, 10, &y))
> +		return;

[Severity: High]
Could this strict parsing with kstrtoul() and early return drop valid events
and cause the touch state to get permanently stuck?

Unlike simple_strtoul(), which stops parsing at the first non-digit charact=
er,
kstrtoul() will return an error if the string contains trailing spaces or
serial line noise.

If a touch release packet (starting with 'R') contains non-digit padding,
kstrtoul() will return an error and trigger this early return.

> +
> +	input_report_abs(dev, ABS_X, x);
> +	input_report_abs(dev, ABS_Y, 1024 - y);
>  	input_report_key(dev, BTN_TOUCH, gunze->data[0] =3D=3D 'T');
>  	input_sync(dev);

Bypassing the BTN_TOUCH state update and input_sync() would cause the
touchscreen to remain stuck in a pressed state until a subsequent valid
packet is received.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719054121.5917=
-1-bivashraj750@gmail.com?part=3D1
