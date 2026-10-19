Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBBB48488F
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792396862; cv=none; b=OFCyo0tKuhA+Iy5ZvK7DNd+slFsvlsFLEiQvcfsNNh7fwKzmKiGGWKjqmeAmlP1wdwEAn3tBtJ9u3C+fKjjZJKUoi5NDP1ZQhZ45uf4g8mghW0jVx4f5sAMUWrloFgdzsBsXH94O2tfsio0QcanpelVB+QEcuvgD6boO14MO4ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792396862; c=relaxed/simple;
	bh=v1DdUPCVUmOFI/TIUBIHp6cItFNA8BFk10P0B9BsNgo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iGAmjJGydspEubuDBQjo8r924WKoZGwoBuQAlj4oIkbn98anFOcpacdXbR4lVqBH6JuAf9Xiihgh1zbo5sb/5OA0rFU055hSGdG6vl8UsG2vk0rKuUlR90SSpLYiCjxENOquv6BykxSnBbSRuonX5B5oyg2xmuEWfZToEZW9eh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7MicdCk; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7MicdCk"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6aa9164072cso2308566a12.2
        for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 01:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792396859; x=1793001659; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J19aiaw61ESfpZhpHesVzTPqjjzjeVttorDaRwN+W08=;
        b=X7MicdCki6f2c9ThLW8NGIGjLMZyt1hmOsz+MwWY3oV8E5bNM3xdVb43/FVHywz55I
         PHf5gnnvFh4SxFejO3czQZ0tW0WxmVqIk+p5JED9+QxiNRrs1JY6towTH0nvikLA1mIG
         tspdAOUmriusjIxOaOjU+UOAtsho05nD3Y0JmyjPI7v7YlNc0W12kQUo/q6QsLhuEs2+
         qHIgTvNLXsGgncKwqEMrO5f5XLhPhxl1a//DUzenXQoOEQVaTKjxjBDTPAWlL3t/R0rS
         Yxt3ERFgW4QARYQUjfbMGgo7DSsOhxju0fbaqqQffUPR8zPxssw8r0FbM3u2sso6Nbe8
         8sPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792396859; x=1793001659;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J19aiaw61ESfpZhpHesVzTPqjjzjeVttorDaRwN+W08=;
        b=Xkl4KfEj82QAUzA8Xn7YTy3Ov7/36rKK+j8RM9mx1JE+mfpxWEO22/8SlRuNwwUUw/
         qGAjx5dtasoNE1EZne2jxhy+qipwi+IiFWs8qUHKJPIo3DNQjvtXZLabXCZ2OwF9xEiF
         nuBGcUj7dMg3rFj5Zplxz6+tnKDUD2qK5MdmCQg0H5RquZMv89UomwBwhPCS2/OjnIC6
         1rMwGIXI6aj/gyU6Qo43u/iZU+vew9+m7HAM/oNdQqIwPZt/UQ1TvioCUy/D15MgBQL9
         vmCUPR4bPnVCKydez+c5aU7he1xV6A5S1ao/MFSw1Zbfaxk9fDHkRjk6dXaO4+qZn9QS
         LAlg==
X-Gm-Message-State: AFq9FYLrkzPLTu0PPqnWY0gJSP0SRUWbbZcMEnT7JtD8sDN/tykwmkOv
	sABTqhofZB8m8JMxaKs3Ms9bzILACo8OhCC1HRw/aa4WZYOHU+n+yC2jaFRbpAlJ
X-Gm-Gg: AYBFou0b+6aA7KPIjGvYAxBUzAUELLC/iEnVyrUWEVgQsIzEpt+btueH2RqDXyLNH8S
	mEcmO3pT5zLiPg6eKOVDj3/UTVdWo2S1ibdJg/7WTyWswJ/AxzEBH5imB39cmUa6zKQ9UgnfnHG
	aaeEX5cTR/TDwXpBFfMaf2pej9+jEg9mjWlM0qMZ5Q+ND5jeKMD2UQsUBHXHR+O/Z1+rcDnpR2/
	T4tqK8K8VNmqOgSq5Wn6ylMZ3SebyEQW52ijpMY9GIKvp7ccWXm7gTZm76jH96WEBM0b4Qje+un
	fNyC+/Qq/RDD3thu5hGFSPOg9wpBVygDGusu3NxoxXu4GkF9ItaX0leOBW0XucqFCT0FiNzhMiO
	EdKN0a6I9bXZRS4dItfTllRU2FtnG/m4Gja/OsoxfFzz4djAode4VkVn3qt4vx5uabykutjP+t3
	4qa/opOpZWl0AuxFKh3spO31tz+fmbVK8RIqUODWU+mQnMYK66W/rqhhlxXvd14DUg7pL5CWEfK
	dk=
X-Received: by 2002:a17:907:9623:b0:c26:2eee:ffc7 with SMTP id a640c23a62f3a-c419f709628mr476872766b.35.1792396858464;
        Mon, 19 Oct 2026 01:00:58 -0700 (PDT)
Received: from smtpclient.apple ([62.171.228.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4091fab836sm331499066b.83.2026.10.19.01.00.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2026 01:00:57 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.3\))
Subject: Re: [PATCH] Revert "Input: matrix_keypad - force switch rows to input
 mode"
From: Alexander Kochetkov <al.kochet@gmail.com>
In-Reply-To: <20261002100935.449473-1-al.kochet@gmail.com>
Date: Mon, 19 Oct 2026 11:00:43 +0300
Cc: linux-kernel@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Siarhei Volkau <lis8215@gmail.com>,
 Paul Cercueil <paul@crapouillou.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <36834AAE-F2DD-4974-A5A9-60B30F29DCF4@gmail.com>
References: <20261002100935.449473-1-al.kochet@gmail.com>
To: linux-input@vger.kernel.org
X-Mailer: Apple Mail (2.3864.700.51.1.3)

Hi Dmitry,

Gentle ping. This is a regression fix for matrix_keypad with Acked-by
from Siarhei (author of the reverted commit) and Paul (Ingenic
maintainer); it still applies to your next branch. Is there anything
else you need from me?

Thanks,
Alexander

> 2 =D0=BE=D0=BA=D1=82. 2026=E2=80=AF=D0=B3., =D0=B2 13:09, Alexander =
Kochetkov <al.kochet@gmail.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB=
(=D0=B0):
>=20
> This reverts commit 01c84b03d80aab9f04c4e3e1f9085f4202ff7c29.
>=20
> The commit makes every scan call gpiod_direction_input() on the row
> GPIOs. On pin controllers where GPIO input and interrupt are separate
> pinmux functions this switches the row pins out of interrupt mode, and
> enable_row_irqs() does not switch them back: it only unmasks the
> interrupts. Row interrupts then never arrive and the keypad stops
> working. Seen with a matrix keypad on an Allwinner A64 board (PINE
> A64-LTS); it works again with the commit reverted.
>=20
> The workaround is not needed on Ingenic either: the author of the
> reverted commit re-tested all available JZ47xx SoCs and they all =
report
> the live pin state in interrupt mode, see the thread in Link.
>=20
> Fixes: 01c84b03d80a ("Input: matrix_keypad - force switch rows to =
input mode")
> Link: =
https://lore.kernel.org/all/4130C026-2A83-408B-836A-ECA044491C47@gmail.com=
/
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
> ---
> The same three-line removal has been in use on Allwinner A64 hardware =
on
> top of v6.12.33; this version is rebased onto v7.3-rc5 and =
build-tested
> (arm64, CONFIG_KEYBOARD_MATRIX=3Dm).
>=20
> Siarhei, Paul: you both agreed to the revert in the thread above, =
please
> reply with your Acked-by/Tested-by if you would like it recorded.
>=20
> drivers/input/keyboard/matrix_keypad.c | 3 ---
> 1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/input/keyboard/matrix_keypad.c =
b/drivers/input/keyboard/matrix_keypad.c
> index 8863b741d1a3..cda2888b2e56 100644
> --- a/drivers/input/keyboard/matrix_keypad.c
> +++ b/drivers/input/keyboard/matrix_keypad.c
> @@ -134,9 +134,6 @@ static void matrix_keypad_scan(struct work_struct =
*work)
>=20
> 	memset(new_state, 0, sizeof(new_state));
>=20
> -	for (row =3D 0; row < keypad->num_row_gpios; row++)
> -		gpiod_direction_input(keypad->row_gpios[row]);
> -
> 	/* assert each column and read the row status out */
> 	for (col =3D 0; col < keypad->num_col_gpios; col++) {
>=20
>=20
> base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
> --=20
> 2.43.0
>=20

