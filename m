Received: from mail-ed2-f31.google.com (mail-ed2-f31.google.com [74.125.228.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9445F3DAACD
	for <linux-input@vger.kernel.org>; Sun,  4 Oct 2026 21:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791149799; cv=none; b=bb+tNYF/Ic7macAdIkGZYI3+G573NmIQW7fZLVosrvDl5VE1/ENK3IUwFRRMVBKnxZD9xa3qToGGPPQVQAP2WB9KcpSq52EwZhoYeEOeNgY3D8tcCq0yse3OHp6G9kGBZIyLyC8EZd5avVOjkPcfd/w4ZDdh+Se0egYU6G1M4w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791149799; c=relaxed/simple;
	bh=isfTBrqY9p5m/ED+4flN0cts6u/U4CK8ScTtSCqlZ1E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=XkxORd8ePTMsILRxMKgeENKx+0Z+cHZyBsoUzuyRQdLY0kjy1JQj6yr/hbmbJ0uH7SYNaPqnSsH+cWfYyqxUTFVulXGgCL/887ovD2PDIfFsplus+L4Mq0nynf8kb9S8KmEDscPvXlSFSJt0jUvurS/WLljLfBZ0+O4HcgTF72M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATbYxx61; arc=none smtp.client-ip=74.125.228.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATbYxx61"
Received: by mail-ed2-f31.google.com with SMTP id 4fb4d7f45d1cf-6ae19319854so1426312a12.3
        for <linux-input@vger.kernel.org>; Sun, 04 Oct 2026 14:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791149796; x=1791754596; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Qs/HNAMN3+qC8yepsmEsO4vU7YCCa/bUjxjtXFFHYg=;
        b=ATbYxx61nHcJSRT5Glr+PNxHZZREoLXxOlIICME0sYSyPjmh280SWtvvqsd73BKNe6
         UV2IT/l1zJj8/B1V6lBF18bRpo/BuHVmN1lZfRxmGupgbsXwZIOBV9wEHHZeQfyVJ1T7
         NtvDO1M84zAAUQ7d6RP5pmuJGzZh9aNCi0r4EmOqu5ZA02xwzC5twpejgK+KPx0OXqM3
         jgNGkG4bsT+sx7khkHkamiF08GRF8PUS0NPhEA9NUZkYWUiNKkfeOuPENeHKSNyusniX
         VY7f+nggs7AxuSQt0egaKfDjI2nsDJp4PeXPuP2F7m6S0f+BbfHozXHMmN6c3LuzjDYh
         Qseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791149796; x=1791754596;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Qs/HNAMN3+qC8yepsmEsO4vU7YCCa/bUjxjtXFFHYg=;
        b=00Y2H3QmCG2YC9AnvP+M9M3HDooHbIoXVZS71nJw6KnzlIeMu8JduZAlVOpZLw+YzS
         +UgqWRqIQkQG0MN+ce97o0YGlNptQKdJwxXYbyUSa3Ld0ToujADVY7ncY9DcAgJSC3ou
         XOC9KPdohW7K2o0mQN5yw9Snq0KydlWV3xHeAzg2Aegb9ldcyhzGGT3leo1VnglIpIY5
         A7CQm1iq9gAJn7YRcvv3KFArBcOxZbZeRIcD7GPzg9tdswxMWq22IFC3IBLGV3BvcB8h
         HPSAJzjZKq2LOUbPaSEgdqnscVyh19L8z230ml7GvtbqVT5mfjIYplW+XtMFNiXRHeqS
         OFLg==
X-Forwarded-Encrypted: i=1; AKwUvBzEztaBpZS0auw9d4rA0IAJIsYRBlOWgv8EpWalvDDxkUj3N0E2K37NfRJyStw7nlbJY9z0o52tChgaYw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIGrHvNK4XodvMX9pk1sAKYe0B69vX4wiTRWw2jfJFkecg0zaJW
	wEdvO1vOie99T3Tfd1cj5cs/Ju7HCZ3hklAZD09AjLQEUJzqGLJvGH57
X-Gm-Gg: AYBFou0i3QVRlH/r0jkZCG7nyWq9SLcbjcY2LIAVpxWDKZVUY7OPf4nvQs8hpF1w/NK
	5XJbmE2+VWMkKCF+ODBs/ADYy+bqbQre1jA4+ZRaxkdv/mnshVc3TM54OfTL+PzMMG8oCoCP933
	se+E8lZO6+sLnLm5iSDzBm15dsxN8h1W/ZQwbtxhYbBaMMkCddoVgTE2lVFLQGc1rDi6pb2rPl7
	Qn2bvaNHWjAx0IqLhiqLr+iYaXxsXCtC934UGrn3Yt9fJ7LDSyV5YWhXSj0i0nXQa7nc7XAlxAI
	G57ufcaZbY8Ab9Jc5TN6T7wRabux7PwT/q4zaIWv4TUXM9KK5iu4fWiEpLxMDIpBxL3/LmwyN17
	0vK6Eo2vHLOmX8RguyOvM25aTICE01jNpWj1XZXZGoABxICddkZ7TwYG/tmdsr3cgLKrC9xp7is
	eG7dO2NaJpsI437AxW84QxDesFuBVxgb1ZcnwNG7P8D0Gc2/O0rZ8PjZgRbE1o9rs1zyfcQHkw4
	pi6z3I=
X-Received: by 2002:a05:6402:5486:b0:6aa:915a:f51e with SMTP id 4fb4d7f45d1cf-6af9e2e11a3mr6565114a12.17.1791149795652;
        Sun, 04 Oct 2026 14:36:35 -0700 (PDT)
Received: from localhost ([46.205.201.71])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6afb01e59cesm2457040a12.12.2026.10.04.14.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2026 14:36:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 04 Oct 2026 23:36:33 +0200
Message-Id: <DLWDLZK1ZVOJ.G23QIUQTEMEC@gmail.com>
Subject: Re: [PATCH v2 3/5] Input: hynitron-cst816x: release gesture keys
From: "Oleh Kuzhylnyi" <kuzhylol@gmail.com>
To: "Daniel Golle" <daniel@makrotopia.org>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Hendrik Noack" <hendrik-noack@gmx.de>, "Arnd Bergmann" <arnd@arndb.de>,
 "Ferass El Hafidi" <funderscore@postmarketos.org>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <cover.1790944534.git.daniel@makrotopia.org>
 <7199967eb45b1c3adcb7efc859380f6f3dbf7bdd.1790944534.git.daniel@makrotopia.org>
In-Reply-To: <7199967eb45b1c3adcb7efc859380f6f3dbf7bdd.1790944534.git.daniel@makrotopia.org>

On Fri Oct 2, 2026 at 2:47 PM CEST, Daniel Golle wrote:
> The gesture key is reported with the value of the touch flag, so it
> stays pressed once the controller stops reporting the gesture code
> while the finger is still down. Report the press on its own and
> release the keys the input core still holds down on the first report
> that carries no gesture code. Keycodes above KEY_MAX are rejected,
> as that release looks the key state up in the input core's key bitmap.
>
> Fixes: c87a819bec86 ("Input: add driver for Hynitron CST816x series")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v2:
> - reject keycodes above KEY_MAX and publish keycodemax only once the
>   whole array validates (Sashiko AI review)
>
>  static irqreturn_t cst816x_irq_cb(int irq, void *cookie)
>  {
>  	struct cst816x_priv *priv =3D cookie;
> @@ -181,8 +205,9 @@ static irqreturn_t cst816x_irq_cb(int irq, void *cook=
ie)
> =20
>  	if (tch.gest)
>  		input_report_key(priv->input,
> -				 priv->keycode[cst816x_gest_idx(tch.gest)],
> -				 tch.active);
> +				 priv->keycode[cst816x_gest_idx(tch.gest)], 1);

Tested on CST816S setup, found out a subtle issue: cst816x_gest_idx() maps =
unhandled
single-click (0x05) and long-press (0x0C) gestures to index 4.

Input subsystem ignores SINGLE_TOUCH (code 0x5) events with tch.active =3D=
=3D 0 (t: 0).
Instead, reporting index 4 (single-click 0x05 minus 1) with tch.active =3D=
=3D 1 falls into BTN_TOOL_TRIPLETAP linux,keycodes element.

As a result every single touch accompanied by BTN_TOOL_TRIPLETAP:
Event: time 1791148663.331439, type 3 (EV_ABS), code 0 (ABS_X), value 117
Event: time 1791148663.331439, type 3 (EV_ABS), code 1 (ABS_Y), value 124
Event: time 1791148663.331439, type 1 (EV_KEY), code 334 (BTN_TOOL_TRIPLETA=
P), value 0
Event: time 1791148663.331439, type 1 (EV_KEY), code 330 (BTN_TOUCH), value=
 1
Event: time 1791148663.331439, -------------- SYN_REPORT ------------
Event: time 1791148663.397477, type 1 (EV_KEY), code 330 (BTN_TOUCH), value=
 0
Event: time 1791148663.397477, -------------- SYN_REPORT ------------
Event: time 1791148663.409413, type 1 (EV_KEY), code 334 (BTN_TOOL_TRIPLETA=
P), value 1
Event: time 1791148663.409413, -------------- SYN_REPORT ------------

Interrupts:
cst816x 1-0015: x: 127, y: 124, t: 0, g: 0x5 // Finger down (index 4, tch.a=
ctive =3D=3D 1)
cst816x 1-0015: x: 117, y: 124, t: 1, g: 0x0
cst816x 1-0015: x: 117, y: 124, t: 1, g: 0x0
cst816x 1-0015: x: 117, y: 124, t: 0, g: 0x0
cst816x 1-0015: x: 117, y: 124, t: 0, g: 0x5 // Finged up (index 4, tch.act=
ive =3D=3D 1)

I suggest either gate the gesture branch on tch.active so a finger-up
single-click never fires a key, or fix cst816x_gest_idx() to map 0x5/0xC
to their own valid slots so they stop aliasing the TRIPLETAP keycode.

Best regards,
Oleh Kuzhylnyi

> +	else
> +		cst816x_release_keys(priv);
> =20
>  	input_report_key(priv->input, BTN_TOUCH, tch.active);
> =20

