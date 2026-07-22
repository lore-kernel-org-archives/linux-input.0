Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E143E1CF8
	for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 03:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784691238; cv=pass; b=o7y/aUwRn6AhyBdLxE6pYMactblQFkUiwCNpWBtDPeBxucD5TDw8uiWBvPSfE341YBSPC6gE4JI+f4MLx4qFzXowiHlfUicoB0R5xDI4Eym5eHJgriDu4hUgChqMJc1oDQWP+QUjeQMXCpaypCYw41apqFXO9eyNpDL+O0KNKFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784691238; c=relaxed/simple;
	bh=TmfjsaY5vDGWro2W6B9BTuFvkBc8bjylIqjuthGf42o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9bvIC+mnGo25TMy3DbvJRrCQXrqhDTf4gGODJtywO/UHqkOimcBZWuPgpJU6vluvr2KdBsZCy3/BdN3QTRSirsxdR0KoIhW4MZenZ5M77s9eDuYKGs/lQSmR0EiJDeL2JkPIVG0EKUPbiZfkMGYcxU2n2A2T0if2auPodGkjoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZJPFEFHh; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZJPFEFHh"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-80dc4a68e4aso94404447b3.0
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 20:33:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784691233; cv=none;
        d=google.com; s=arc-20260327;
        b=b7SmiQ8iuIP+VkkDudSgv3TlyI7muo1bwgz57Iwr8fGKhZCpC57P95Dr6gF/8PD6XA
         ZmhNhpEdfOmGQBzp+px/ig+A/jRPDUeOTpxs18EXdr2qiwl171Ar6bk1g3J290GuUlBk
         iMbEgribCvMHWKcp69nO10rEQT9QGzU3X3PPsfncOnlpsDds786woAz9OmJWNwDfsXJO
         m2cY+4N8yQ6s99inAuR9RfIU6ngDredvXDKVBTuMDJLnKX1Nf41IWnO/XkmM0W+xM4O4
         p8p8vHWX8K1EAdWJR0PkG2IphGjwYCcrJ84cl6qAk/qp55H6pEkE/sBvTUNxhA6yueHn
         zR9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9KcR04mJabpHychs/QIME5IF7elu7nLc7+YdcFBgs0g=;
        fh=FHN1/oPX3RTi6X969lfowhh3fiaKjF/kIprq3kpmAsA=;
        b=BQLM3d983T/w9JDH9Hj6Y+DjBFNP582nY3DXh7efBxhenJO4kmosVsnJ8VkEWCKzI6
         42T0T8FCHXv2hDoXB5pfuTOjx1PEc7wHVF7BGSIKj1AZN8WgOrN3qsFfS1csp6A1qZAF
         eMdKxzDYu/YJ+e3dCQSYjfd0AJaBfHYoQh62D5+dScvPUlS/YiCh93k1AE8qsfEEzQ0f
         15MKtCozFcNMsgvH5AZDmAWNfT+qLJnSSBKCjz5fdrEhy5yMIMGghuZA7UZxTcf4GMWu
         WwPew+BOpZIAXRr6EmMPqHQpRy4MYn0fWMaxaTIb09jND1DnxSUWsgC6ov2iAZ/5XWs9
         0R0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784691233; x=1785296033; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9KcR04mJabpHychs/QIME5IF7elu7nLc7+YdcFBgs0g=;
        b=ZJPFEFHhqJfG1rtQCPEJX2PSJp5vKO683uHdsZtYK7BuHvZe1ToftaK5onAL+4DnLh
         9JCFZEQUUeqvBfesE0ZE2bTPrlW5NJQH/YtJIPbY6Ei1purp/oYrerLgSHMlG4iElUOv
         JVr3/YZjB2H9Wl6CjC3a3ABryGYEFN7a8ovTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784691233; x=1785296033;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9KcR04mJabpHychs/QIME5IF7elu7nLc7+YdcFBgs0g=;
        b=FqMN0EYtDZmRYQBTgvJxayVU/NbaK2tw+kemN/phWNKEvhnHSlF/WFxyz6V2ukCj0z
         GvSvWrN85oEXff5DQbGL3m8TBm9i4dnOTue0iWnlPxeSdYzYfPQHCK9nC/uzNkwskD+t
         iNR2NK83d8FaEyrhRxS5xWqw2AU0492ysPyY1ws1InzJmDRfOD85e8nBOnhk0nqfmzGy
         gul+UZklp8VNYual8iUN3/qfi/sa6n4ZrqXUt4LVZi4JvZe6+adba+Mi/KKAOAnRAY//
         LuyvKYKsH0JSVKNxgSx6SH1wrZL5XGOAdRfotVBtjNDHAeM4s7e2QGd0pv47P5iXCBeG
         Caaw==
X-Forwarded-Encrypted: i=1; AHgh+Rp+o+JMj7YKa11IHOjUiBRSJMRiwCaP1e1iEydGRoAc7m6UPNY6UTQqjal1WDIShkm78rIXbUNsueRmhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPVBeX/p6VGeJU3yFeE6J/aWFebs9mW7a1oXxZcTVECei7p2ZX
	brRGc0YlonaABTdHzy8h2zbpYQeM1dy6Q2QcT5WqpDL/W9ZtptkXBXuVGwggNmd3tVe7+8TZJfc
	y395nPp95yHJuJ7OiE6aGQ7YWyj1416ARfPa8BAV5
X-Gm-Gg: AR+sD12+xLREbkp3RlZzOuptnsZZfQ8jlGJ74DMjNUv7N8OheTqo+6YteOsOXUEBoN1
	qd/tK+MfkqZKo1HkREG4Qbd9R4S03xpn7I+tKEuEIiAk/seP1LalUMQUM6Zw1iSxc2SUAhJZOfc
	1c4qckYvROZlRGHDJonYRWYRJ3PvGu6l/cO3ia5bcwIF2VP9YFhBnv1PzLolFy2o6MfXbi0hbFI
	JAGUN0r3R3Wtunvt9dV9l9V6KfegrkQ++STLvjNL+lGoblZ8r6FyMycaIA5fmvqcU3+As9S3Llm
	pwpGeNljSi/58xw=
X-Received: by 2002:a05:690c:6e82:b0:80d:f376:5ba9 with SMTP id
 00721157ae682-81ef252e359mr66727137b3.24.1784691233300; Tue, 21 Jul 2026
 20:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721075226.2347933-1-wenst@chromium.org> <20260721075226.2347933-8-wenst@chromium.org>
 <al9JivV0SZCiOgK8@ashevche-desk.local>
In-Reply-To: <al9JivV0SZCiOgK8@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 22 Jul 2026 11:33:41 +0800
X-Gm-Features: AUfX_mxYNc8IPOzIIfv3TBCyd0Fs8lnIBTuyeRs9t7NJj3-mYtf52pIbJvj-z9A
Message-ID: <CAGXv+5Es0RZiAdUj-Y3FEFHU4Km6XBOL-Gk2DbTLrF-OcD54cw@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] platform/chrome: of_hw_prober: Add delay for hana trackpads
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	chrome-platform@lists.linux.dev, linux-input@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 6:27=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Jul 21, 2026 at 03:52:21PM +0800, Chen-Yu Tsai wrote:
> > Up until now, the MT8173 elm/hana device tree has set the dedicated
> > regulator supplying the trackpad as always-on, simply because the Elan
> > driver was missing proper delays. As a result the delay for the
> > Synaptics trackpad was also omitted, as it was not strictly required
> > under such a model and delayed the availability of the trackpad to the
> > user.
> >
> > The Elan driver recently gained proper delays after power-up, with
> > adaptive skipping of the delay if the regulator was originally
> > on. The I2C HID driver and I2C OF component prober library gained
> > similar adaptive delay skipping. The device tree will be fixed to have
> > the regulator not be always on, and proper post-power-on delay time
> > added to the I2C HID device.
> >
> > Also add the post-power-on delay to the ChromeOS OF component prober,
> > so that if the regulator is off at the time of probing, the prober know=
s
> > to wait for the hardware to initialize.
>
> ...
>
> > +++ b/drivers/platform/chrome/chromeos_of_hw_prober.c
>
> >               /*
> >                * ELAN trackpad needs 2 ms for H/W init and 100 ms for F=
/W init.
> >                * Synaptics trackpad needs 100 ms.
> > -              * However, the regulator is set to "always-on", presumab=
ly to
> > -              * avoid this delay. The ELAN driver is also missing dela=
ys.
> >                */
> > -             .post_power_on_delay_ms =3D 0,
> > +             .post_power_on_delay_ms =3D 110,
>
> This and the other delay in the previous patches are all HW-related. What=
 if
> another touchpad gets connected? I mean that the delays for the certain H=
W
> should not affect other possible devices connected to the platform.

This is a complete laptop, not a development board. You can't just randomly
swap out the trackpad. The model AFAIK is no longer in production, and we
have already added all possible configurations to the device tree. And
there's no extra connector or pin header to attach additional peripherals.
If someone hacks their own device to swap out a trackpad, then handling
the additional bring-up should fall on them.

If you are referring to the delay for the other trackpad option, that is
100 ms, and is described in the device tree. See patch 8 of this series.

Any other device with different delay requirements should have its own
entry, not reuse this one. The information in the entry is tightly
coupled to the device tree anyway. I already corrected the other device
that incorrectly reused this entry [1]. We have some additional offenders
downstream, but nothing that can't be corrected in the same manner.


ChenYu

[1] https://lore.kernel.org/all/20260625060859.1020483-1-wenst@chromium.org=
/
