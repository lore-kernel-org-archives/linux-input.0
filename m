Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350F73AEF3A
	for <linux-input@vger.kernel.org>; Sun, 19 Jul 2026 17:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784483679; cv=none; b=XKmrlsSx3/4T1j6JzfUJKXGgvE27Q+TpVZVah9KbmqCTu5t3k8+e+iRQw3w0RUMA2Jlrs83kh/aQrqkfDQRrqJ3fYfLlqlLVru1AgSgI9PtKY49p51ty7r/cA/SyqDtAQfAB1jKiBXXlPKnYBHPWn/F4xV+3i1uNONRsA0yQFWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784483679; c=relaxed/simple;
	bh=j4bCPXs0SO8TWOKKV8JA7deUKuPcMFMqpJJL0a+dmyY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=InfsrdcUvXP6VpbRq+1alSQeN29V+b/B3l/XgUUTBemIBCowIfHqtc/go35Rtt7lgOBVI2kM/zludFGSoyGstmv6iWHyNEpwsH/P1JS3Xbja/Pr1iPoWuODhttZJwxvGwaHAkUXv4e72QFVCsnRw8ZFA9HC1IPqRCqAvBvZFF1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owk7cv0e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owk7cv0e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153A81F00A3E;
	Sun, 19 Jul 2026 17:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784483677;
	bh=5YA39H/FuUNTJZ3TdD56wtYoNxmeQxYlooLP2LHMrFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=owk7cv0eq7t/EkiibPoA7+zAUR27AtncU+AlWWl4RTiggIbSfrJ7OCW87IeDgeeTM
	 4Zp963iB8FThX22x+YmX7shq8RM++rZ7ksrziUT0t8N+dVJ1QmEBTb9C9ZIvHLA8vF
	 ooipT6LLx9136stSZ0ImyklheHN8+IhvnrUCqWEiN+93MCo35ySWe2UOx1i40XnXKt
	 8ESL8gj/BpwEL8hgi1xQd2bjpmw0AmDqOka9trpOR62lGkknVY8eYYJWtdCb/R4LcQ
	 HQkPw7v65wQJ9Pmj/vuJIp+RBm2Jq7Aepzp/Tse2aOR8Mp49JuP7FSXDIvvHHf+puv
	 8JnJxxDTjAkOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] Input: gunze: replace deprecated APIs and fix
 warning style
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bivash Kumar Singh" <bivashraj750@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260719173700.4942-1-bivashraj750@gmail.com>
References: <20260718190040.10613-1-bivashraj750@gmail.com>
 <20260719173700.4942-1-bivashraj750@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Jul 2026 17:54:36 +0000
Message-Id: <20260719175437.153A81F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Un-ratelimited dev_warn() calls in the interrupt handler lead to s=
evere kernel log spam (dmesg flooding).
- [High] Replacing simple_strtoul() with kstrtoul() causes a behavioral reg=
ression due to strict parsing requirements.

Pre-existing issues:
- [High] Unconditional reporting of fallback coordinates on parse failure c=
auses out-of-bounds values and cursor jumps.
--

--- Patch [1]: [PATCH v4] Input: gunze: replace deprecated APIs and fix war=
ning style ---
commit 7f14b2c0978a817cc80d8103302866bba7c3bf3f
Author: Bivash Kumar Singh <bivashraj750@gmail.com>

Input: gunze: replace deprecated APIs and fix warning style

This commit replaces simple_strtoul() with kstrtoul() by copying the packet
data into a local NUL-terminated buffer first. It also updates the logging
style from printk() to dev_warn().

> diff --git a/drivers/input/touchscreen/gunze.c b/drivers/input/touchscree=
n/gunze.c
> --- a/drivers/input/touchscreen/gunze.c
> +++ b/drivers/input/touchscreen/gunze.c
> @@ -41,15 +41,26 @@ static void gunze_process_packet(struct gunze *gunze)
>  	struct input_dev *dev =3D gunze->dev;
> +	char buf[GUNZE_MAX_LENGTH + 1];
> +	unsigned long x =3D 0, y =3D 0;
> =20
>  	if (gunze->idx !=3D GUNZE_MAX_LENGTH || gunze->data[5] !=3D ',' ||
>  		(gunze->data[0] !=3D 'T' && gunze->data[0] !=3D 'R')) {
> -		printk(KERN_WARNING "gunze.c: bad packet: >%.*s<\n", GUNZE_MAX_LENGTH,=
 gunze->data);
> +		dev_warn(&gunze->serio->dev, "bad packet: >%.*s<\n", GUNZE_MAX_LENGTH,=
 gunze->data);
>  		return;
>  	}
> =20
> -	input_report_abs(dev, ABS_X, simple_strtoul(gunze->data + 1, NULL, 10));
> -	input_report_abs(dev, ABS_Y, 1024 - simple_strtoul(gunze->data + 6, NUL=
L, 10));
> +	memcpy(buf, gunze->data, GUNZE_MAX_LENGTH);
> +	buf[5] =3D '\0';		/* NUL-terminate X portion: "1234\0" */
> +	buf[GUNZE_MAX_LENGTH] =3D '\0';	/* NUL-terminate Y portion */
> +
> +	if (kstrtoul(buf + 1, 10, &x))

[Severity: High]
In gunze_process_packet(), kstrtoul() requires a perfectly clean string
without trailing spaces or non-digit characters, whereas simple_strtoul()
would successfully stop parsing at the first non-digit.

If the legacy fixed-width hardware protocol pads coordinates with spaces
or contains noisy data, will kstrtoul() reject the entire packet and
return -EINVAL, resulting in a loss of valid touch coordinate data?

> +		dev_warn(&gunze->serio->dev, "failed to parse X coordinate\n");
> +	if (kstrtoul(buf + 6, 10, &y))
> +		dev_warn(&gunze->serio->dev, "failed to parse Y coordinate\n");

[Severity: High]
The commit message mentions that release packets can contain noisy data,
meaning parsing failures are an expected event.

Because gunze_process_packet() is called directly from the hardware interru=
pt
handler, could these un-ratelimited dev_warn() calls flood the kernel log a=
nd
cause high CPU overhead when users interact with the touchscreen?

> +
> +	input_report_abs(dev, ABS_X, x);
> +	input_report_abs(dev, ABS_Y, 1024 - y);

[Severity: High]
This is a pre-existing issue, but when parsing fails, the y coordinate falls
back to 0.

Does unconditionally reporting ABS_Y as 1024 - 0 cause the touch cursor to
instantaneously jump out of bounds and trigger spurious clicks or swipe
artifacts on the device?

>  	input_report_key(dev, BTN_TOUCH, gunze->data[0] =3D=3D 'T');
>  	input_sync(dev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719173700.4942=
-1-bivashraj750@gmail.com?part=3D1
