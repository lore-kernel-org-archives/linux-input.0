Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF673E51ED
	for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 17:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251253; cv=none; b=JuMQKQzf6C49I/hFOTWWek6iazL2B214esr+C9iUE/wIFwssMc4qsGkNi97IOo5aLMf4tnBn9amwp2IF1XlLoqX2B0zfTlfee9vfjR+Mb0cloXdTDB+PpValvRgKchAUMYMabRJGEPir0TQVMGonRz8fnJHh89lAgxsY3HLQ7+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251253; c=relaxed/simple;
	bh=RtB2CiHd6CJB9mXZPAxacW/h0R+GLVQBAkaHyVKppt4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PhSySMJ1s8GOJ1ukojjSjjkRiZLghJPnI0Yw2er/Ybsvk5Zi08EdKv1I2VTA2pIhM66mgDfG/XwVkGDz4BAytpVf5b3z85HHek5EaId9iKL2nMK/INlhzzE/7BVrslfXT3/Qm0dG7d2orS3VAUsVLf878DDl/l3LgD8wBqgd4PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDL4dOmy; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDL4dOmy"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38a67221fe8so1773391fa.3
        for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 10:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773251249; x=1773856049; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hFOZBgjLFq3owcq7/xAzrvvP7TlfY8SmsosEQaI0wn8=;
        b=bDL4dOmyrwlF9+c24r0kfQdNq9X2XfX83pe42fVj0WaxbaJzIB8Ccy4lD77uks0eWQ
         7GCZLqB/2l0hlBuCf/bBpauQxb2qp3JvHwEE2kERgIr0XAMhotUp58la2QbZrIvA64/x
         IPpN5nao7FdPiBiXdPSW0CoQzPhiKigE2P/q+WVLTDKCTkpXXKcEzCCtt+m9kbLbf5Yp
         Dm6xO4OYCmT/+0IL0XK0g/Qn++SbjL4pgfurOlS4VT1aFn2ar2O7bEDj+kUEWA7k1GWV
         LKlZOFBKO4XlLq3syRbNkKRsrQcmZ565kYEcz1EbT3XdJHfi//oSd0H3Y18VNfmWtUt/
         qGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773251249; x=1773856049;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFOZBgjLFq3owcq7/xAzrvvP7TlfY8SmsosEQaI0wn8=;
        b=v8iLwa99/ItoUw0HwXYHuJLQ1+lNHgRXCr2JVb2fYkQG5Qbg8D1xjiWjYHD3ftyANJ
         i/haAUiFIpPa3nMbODskYA7CC31ZS2R1n8ZJUcHacKYqF0lCT3rKunJraSycK3GguN/f
         jaVtEJ1n9OClSX/5Vhv2rM04REUgblbXVVj5JCu/dy4tOtQOupYKbhP+IQJSELSHeWZR
         N6PsUxi3JnHlbtt3Gghjyg6r6hzSFh4gEX1lvVMoVccpkto6jEiai86Brk5/Pa9Bm7mA
         6t5WuyiFLHZIb+EyIdje+g1mU9ry9bR4teUh+fVrytZZ3y3l2mrvlodR4+7hbz+6Yhu/
         pkwA==
X-Gm-Message-State: AOJu0YxGSYxiJHflKIFEUQQnvVjbGikO8qW1QYfv3i251GGINxt5gsO1
	bEoDYHCkfDkqh52+qEtCgOhRvl9OQnAb05J9jtWKclUDnzjrkoEfI23Qqc6po3OsNsM/1w==
X-Gm-Gg: ATEYQzzhCCY6zh8jQUbzDlIc0fUZ/Vv579dR6Zx5UU37puHPODOAJgYL5jCOSbFHu6B
	xxxkJBoJ2AxDWMDv8olD75dTnlf/o1IbDaHWJ+513oUa7FED26/OK3N+xv9dqaQt2n+8d7OyoSA
	tbvNigkfD1ArqyImiJ33SgseHclVxtrSmjvuq/Dsn1nX4IuFRc4bLxk+SyG8fnst+un5jPCXCtk
	QZjHHonTlSEXB0bO0I3/TE8MDP9N8IjAjpWTURkMe7aVidVgLQcfGZPT0uv5rI13DTF04Z3IlBw
	e0w/TNhXAxscijOgsXRSxxcLnW6uEig5JyMVxyWZ6XJazbPEe3276MhTfcQttlO5FFGNckqRYxp
	TziYhPVs5gngAMV/8JZbi1Gbjpb8x8c7sbOihR+erbZc/4seD+xtZiP4qF+rjPsje7sFF4cUuan
	RLUKJggh9SL6W8UXIwKA3vQ0Oaqfhyr41coya4Hb8UxqmrPYKuhLZikA==
X-Received: by 2002:a2e:9a0b:0:b0:38a:3764:414e with SMTP id 38308e7fff4ca-38a67e578aamr17382671fa.25.1773251248852;
        Wed, 11 Mar 2026 10:47:28 -0700 (PDT)
Received: from primary-ws.local ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67e5ed6esm4360351fa.23.2026.03.11.10.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 10:47:28 -0700 (PDT)
Message-ID: <e28527adc34ace88462f2fcce53ab8586dc760a7.camel@gmail.com>
Subject: Re: [PATCH] Input: uinput - fix circular locking dependency with
 ff-core
From: mikhail.v.gavrilov@gmail.com
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 11 Mar 2026 22:47:25 +0500
In-Reply-To: <20260228223628.472208-1-mikhail.v.gavrilov@gmail.com>
References: <20260228223628.472208-1-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.59.3 (3.59.3-1.fc45) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-03-01 at 03:36 +0500, Mikhail Gavrilov wrote:
> A lockdep circular locking dependency warning can be triggered
> reproducibly when using a force-feedback gamepad with uinput (for
> example, playing ELDEN RING under Wine with a Flydigi Vader 5
> controller):
>=20
> =C2=A0 ff->mutex -> udev->mutex -> input_mutex -> dev->mutex -> ff->mutex
>=20
> The cycle is caused by four lock acquisition paths:
>=20
> 1. ff upload: input_ff_upload() holds ff->mutex and calls
> =C2=A0=C2=A0 uinput_dev_upload_effect() -> uinput_request_submit() ->
> =C2=A0=C2=A0 uinput_request_send(), which acquires udev->mutex.
>=20
> 2. device create: uinput_ioctl_handler() holds udev->mutex and calls
> =C2=A0=C2=A0 uinput_create_device() -> input_register_device(), which acq=
uires
> =C2=A0=C2=A0 input_mutex.
>=20
> 3. device register: input_register_device() holds input_mutex and
> =C2=A0=C2=A0 calls kbd_connect() -> input_register_handle(), which acquir=
es
> =C2=A0=C2=A0 dev->mutex.
>=20
> 4. evdev release: evdev_release() calls input_flush_device() under
> =C2=A0=C2=A0 dev->mutex, which calls input_ff_flush() acquiring ff->mutex=
.
>=20
>=20
>=20
Hi Dmitry,

Friendly ping on this patch. It fixes a reproducible lockdep circular
dependency warning in uinput with force-feedback gamepads under
Wine/Proton, tested on 7.0-rc1.

I realize I should have included:

  Fixes: ff462551235d ("Input: uinput - switch to the new FF
interface")
  Cc: stable@vger.kernel.org

Should I resend as v2 with these tags, or can you add them when
applying?

--=20
Best Regards,
Mike Gavrilov.
