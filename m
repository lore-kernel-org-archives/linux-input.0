Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D8BE573
	for <linux-input@vger.kernel.org>; Sun, 19 Jul 2026 06:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784441586; cv=none; b=G0cXnyGYahI3IY/xJizsbYy0Xi42xI3p/nRTNLZZj/Bn/raVIlyoeEUaBdZ5zq2aMfTqHCjEvCwRjFwP97BDiIZL+jBAO5OIoilSspSiDOs4eun/43H0Q6UWW2cPjaXd/Ok1JTU+iE8teuzq8HAf5vt/dRKa+8iTpONJ60yfFJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784441586; c=relaxed/simple;
	bh=GbGuCmr9/WypURJQW3dCh1RydtIZgPxamwN3KBU2PhA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ILdBzkM9LH32f1dpNkd149UrDzCYakgXrn3ISxWeOD6yr/KQJEwiYPPB9cgDEvRTNV8HmxrV+ZUhANu4whxZLXOuJZMI0T2tyEQSqj5dFRRUeIqHIGMfrdqTDTRFziLKrLFcZOEZ6KcBo25uLyV0XEuIsQPOsAh5YhQD6GFHpJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpI8MQEx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpI8MQEx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475761F000E9;
	Sun, 19 Jul 2026 06:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784441584;
	bh=AUPHHgcadXA+lSOiNzpeVGZj7PVfPE5Sz/0CEqpxlfw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PpI8MQExrgg2T/P2flsCsbHoJC909H0R/Y/g6+mhWYwcep98pvZtPL1EliezkPqN7
	 SQymN8yUwmqW0JfARp06JTVChFpTyVlBpG4G2nkABnzjmH7TwgkVDKP/20k7bO/CWm
	 Xw5kpQdgt00gQVLISFAZm7eQYSV/wV9WJ2YXusemH/cleG+S5gLzLNGfaKzrs6etSv
	 BBZ0vk1Gpylh4vZ1IBEz1uwUzPINBbjbFHNYnvSXLfl/ntB4o0+/2P4XQRg1ndKRjd
	 Uk4WozI/o//ws1fGWmUpww+Xi/bmLWN4KG/vsi+JrMsCivdWeJFj4EyTf+snv1eQN0
	 fDd+9VTB/3dog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] Input: gunze: replace deprecated APIs and fix
 warning style
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bivash Kumar Singh" <bivashraj750@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260719060238.6440-1-bivashraj750@gmail.com>
References: <20260718190040.10613-1-bivashraj750@gmail.com>
 <20260719060238.6440-1-bivashraj750@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Jul 2026 06:13:03 +0000
Message-Id: <20260719061304.475761F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly added early return on coordinate parsing failure drops c=
ritical touch state transitions (like touch releases), causing stuck touche=
s.
--

--- Patch [1]: [PATCH v3] Input: gunze: replace deprecated APIs and fix war=
ning style ---
commit 7585c5c9a9ed51c8709aeaa8875aeb5e7e1646b2
Author: Bivash Kumar Singh <bivashraj750@gmail.com>

Input: gunze: replace deprecated APIs and fix warning style

This commit replaces deprecated simple_strtoul calls with kstrtoul and adds=
 an
early return for parsing failures. It also updates the logging from printk =
to
dev_warn using the serio device.

> diff --git a/drivers/input/touchscreen/gunze.c b/drivers/input/touchscree=
n/gunze.c
> index 2baeb4f3b941c..0e8131cad647e 100644
> --- a/drivers/input/touchscreen/gunze.c
> +++ b/drivers/input/touchscreen/gunze.c
> @@ -41,15 +41,24 @@ static void gunze_process_packet(struct gunze *gunze)
>  {
>  	struct input_dev *dev =3D gunze->dev;
> +	char buf[GUNZE_MAX_LENGTH + 1];
> +	unsigned long x, y;
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
> +	if (kstrtoul(buf + 1, 10, &x) || kstrtoul(buf + 6, 10, &y))
> +		return;

[Severity: High]
Does this early return risk dropping critical touch state transitions, such=
 as
touch releases, causing stuck touches?

If a release packet ('R') contains unparseable coordinates (such as space
padding or noise), parsing will fail and trigger this early return.

Because the return bypasses the input_report_key call for BTN_TOUCH and the
subsequent input_sync call, the release event would be silently dropped.

Could this leave the touchscreen desynchronized and permanently stuck in the
pressed state?

> +
> +	input_report_abs(dev, ABS_X, x);
> +	input_report_abs(dev, ABS_Y, 1024 - y);
>  	input_report_key(dev, BTN_TOUCH, gunze->data[0] =3D=3D 'T');
>  	input_sync(dev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719060238.6440=
-1-bivashraj750@gmail.com?part=3D1
