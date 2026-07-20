Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD43C3955DC
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 03:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784518329; cv=none; b=OvCH3omwKh/mlzTtZ1oKYgZxMv9lIYpyZ/fSuRXEbUDoVhqjT++G2QjyzrD8mkyaWrum5Rtul1UwkUxOsxAMAzjFBayezjCh6hqj4l3ubF6Rt5jglkWlZNDqNAxhx0soLa65yz8M+U2sHoQTzpVJL8RkY2aVOF+5DY3vkTyV1gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784518329; c=relaxed/simple;
	bh=/V+bCUvrEfRCYTK+Qak28Fl/PamSbut8ONItQejOSww=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U0gmV6RIuNHwe3QUeKIYjqLBlolqo9V0q1+mV8Gj/ZlV7zzjbsjDPssAta/T6Tya6GOmiazPsjoXUJOO9aR7hPfIDQMDzqXMtw1CepuCkr/Lb/C+RJdC8H/cTb476aWqoJnAXHb2JXCoAw/ogv+SoPV0DrNEgkez37EBMdd+DNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAiN6ZQV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAiN6ZQV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3681F000E9;
	Mon, 20 Jul 2026 03:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784518327;
	bh=C72liKSl6FwCBwqOS5IVg5gGW6zTjocgETWvemm9PWA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oAiN6ZQVgEAdwygEC6x0j0HTcKsqdVlBZNEXefLjIEXnXi2MJk/Iul5pITD+Z8N/m
	 aL82duyNmjR0n5NC9ZWy+ec3rv2aeJ1HXBFjgQm3s/NP8itwu3O6IzNQEVZvNwZKXE
	 o5YlLadqAq81xByOzKOY+QlOfGxNKFu4dYprLE+0cPGg9si9m6tC1lUlSYspr2wIay
	 3fNa4sHZIKId6YAzCFXts6cQ84xRjb7a/8FLidd/elA8QZO8ne26FuqWbMtTEX62Wb
	 Eu4b1p+6Z/xL9VCFiwPYxYeqg1tcyZ7tI2Dl9xqppcRdUjDROGblS1bHoA1aEvZzVj
	 FceLlpuI6Edpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] Input: gunze: replace deprecated APIs and fix
 warning style
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bivash Kumar Singh" <bivashraj750@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260720032407.4644-1-bivashraj750@gmail.com>
References: <20260718190040.10613-1-bivashraj750@gmail.com>
 <20260720032407.4644-1-bivashraj750@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 03:32:06 +0000
Message-Id: <20260720033207.1A3681F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Off-by-one buffer overflow when NUL-terminating the receive buffer=
 corrupts the device physical path.
- [High] Early return on coordinate parsing failure drops malformed release=
 packets, permanently sticking the touch state.
--

--- Patch [1]: [PATCH v5] Input: gunze: replace deprecated APIs and fix war=
ning style ---
commit e46d9a0baa3ae281ee5b9c02aad4e7f63a5cf33f
Author: Bivash Kumar Singh <bivashraj750@gmail.com>

Input: gunze: replace deprecated APIs and fix warning style

This commit updates the driver to use dev_warn_ratelimited() instead of
printk() and replaces simple_strtoul() with sscanf() for parsing coordinate
data. It also NUL-terminates the receive buffer to allow safe string parsin=
g.

> diff --git a/drivers/input/touchscreen/gunze.c b/drivers/input/touchscree=
n/gunze.c
> index 2baeb4f3b941c..7a92052eba805 100644
> --- a/drivers/input/touchscreen/gunze.c
> +++ b/drivers/input/touchscreen/gunze.c
> @@ -41,15 +41,20 @@ struct gunze {
>  static void gunze_process_packet(struct gunze *gunze)
>  {
>  	struct input_dev *dev =3D gunze->dev;
> +	unsigned int x, y;
> =20
> -	if (gunze->idx !=3D GUNZE_MAX_LENGTH || gunze->data[5] !=3D ',' ||
> -		(gunze->data[0] !=3D 'T' && gunze->data[0] !=3D 'R')) {
> -		printk(KERN_WARNING "gunze.c: bad packet: >%.*s<\n", GUNZE_MAX_LENGTH,=
 gunze->data);
> +	if (gunze->data[0] !=3D 'T' && gunze->data[0] !=3D 'R') {
> +		dev_warn_ratelimited(&gunze->serio->dev, "bad packet: >%s<\n", gunze->=
data);
>  		return;
>  	}
> =20
> -	input_report_abs(dev, ABS_X, simple_strtoul(gunze->data + 1, NULL, 10));
> -	input_report_abs(dev, ABS_Y, 1024 - simple_strtoul(gunze->data + 6, NUL=
L, 10));
> +	if (sscanf(gunze->data + 1, "%4u,%4u", &x, &y) !=3D 2) {
> +		dev_warn_ratelimited(&gunze->serio->dev, "bad packet: >%s<\n", gunze->=
data);
> +		return;
> +	}

[Severity: High]
Does this early return risk leaving the touch state permanently stuck?

If a release packet (starting with 'R') is received but the coordinate data
contains noise causing sscanf() to fail, this will return early and skip the
input_report_key() call below, dropping the release event.

> +
> +	input_report_abs(dev, ABS_X, x);
> +	input_report_abs(dev, ABS_Y, 1024 - y);
>  	input_report_key(dev, BTN_TOUCH, gunze->data[0] =3D=3D 'T');
>  	input_sync(dev);
>  }
> @@ -60,6 +65,7 @@ static irqreturn_t gunze_interrupt(struct serio *serio,
>  	struct gunze *gunze =3D serio_get_drvdata(serio);
> =20
>  	if (data =3D=3D '\r') {
> +		gunze->data[gunze->idx] =3D '\0';

[Severity: High]
Can this write past the end of the data array and corrupt the physical path?

The data array in struct gunze is sized exactly to GUNZE_MAX_LENGTH (10):

struct gunze {
	...
	unsigned char data[GUNZE_MAX_LENGTH];
	char phys[32];
};

When a full-length valid touch packet is received followed by a '\r',
gunze->idx will be 10. Writing '\0' at this index will write out of bounds
and overwrite the adjacent phys array. Could the array size be increased to
accommodate the NUL terminator?

>  		gunze_process_packet(gunze);
>  		gunze->idx =3D 0;
>  	} else {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720032407.4644=
-1-bivashraj750@gmail.com?part=3D1
