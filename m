Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0695F47D927
	for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 08:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784709274; cv=pass; b=ogx+8bp3s6k4dEbVW4/t2m+BJXR+bOLKzpNS6A+FSN/8UjVdxMHcHAYVUvd/s3S++oZjq6Fk/OAUG4ZucU/l53s1JQFNF7u+gDLutIxGL86laVrYq3heKM9SSz5GjNWt9sOc3Sth6RQfPpdLX8TIuqGUDPpCu08xRdiaBiPKmLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784709274; c=relaxed/simple;
	bh=nsI28AOe10DwMfFECWTYXs7YxbtRBLvRLKMl55KqieY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lSj4PdUBwvkSV98jCZHgJnNMmmNiZ7fxpgV/cVuXkJ6aXucbU97Uwycn7dkBtXsLbvBaYZhxao3hZ2W7Dm5RtBTEPHSQGrIj/74b52BDDyix8Z55ubSoOywOniOy4nqBI5Hdwn0CAVvaHkwarAsNql/J+npeReOLEnEeCPqEPUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RWUIahWE; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RWUIahWE"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-80e2cfe6918so71802827b3.0
        for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 01:34:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784709267; cv=none;
        d=google.com; s=arc-20260327;
        b=RX7JjWDakRwTtPVHYJOUA3nuF1WpF9TDG/mqj/XgbXoMaHJqWOedmXpqKMZJSB9u9M
         EaotWryI4F5K/ptJZxhELvLcaFYtfvXbXnTB3y3R5XdJw3brJkYlIgK5fsWVYziA/805
         A49bYOWC7hs8bWNn5bNulSNmtabi8wkQrWxyDAiiTy8kMzpu1ExSr7j1/5wIKg7eLCES
         KNy8ZirQk2rYeazkjsN5+7opjRdGlF4b5KFi9nuWfjkAPHW5w8SIZU/fOio92BUwezOn
         c/kgcSDKCbKDndn6+wzkCsHMKPfryqXFbW292aLWn2EUae/9sIdPXs16kFgEquuuCSou
         sWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mo8WgYh25ldjyX8DCM5vtgvNxtGzO4105EDC10m83EQ=;
        fh=xpYsG/O18QfDOS3SjXj5OwvkstTyywa+wc/lDWgHiOw=;
        b=PA0/oLcD7cBg+jTs3xsnYyKZF3XLPP3weI6C5gChIgGmAHrXBWaOrel/sLFz4tZdVV
         Z9349ces4fglFPZHz2RbPTaKHzvqFl/B6KEM0EL76qxFvsc3Hv7nT/cEEfNXJOagdChM
         WYsM/RrQ3dY2iPZ0uqRplvZb79Og3GN9QOOLACa8K9MrlQWI9ddKe9f3729+5wuNGu/z
         bQWonCDwf7UQ1T5rpe6kav65vZ4dwd9LMNGzcy8oCenpP2UQn3YK/pfbliLkqMAxY2Yk
         EkcU1Zd38tE8mugXu8sQQ0vZ0vOfW5ILO4fgx6VTjeeGGvWnKBCZHjAg0RuF/v6Z0uz5
         5+EA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784709267; x=1785314067; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mo8WgYh25ldjyX8DCM5vtgvNxtGzO4105EDC10m83EQ=;
        b=RWUIahWEmhU3BvBkZbity1BNYB/Eenyu3p4xEb3lXaQGwCayDs/ICdYUkdFJIxZZPa
         WHjVR/qucmaAcuUmqM5TLYPBhmmCsQ7WOjIk2AK7kbxHEzZJgk4P0iHS8JqJg2iiEET+
         REScANg4FtV6kYkmXLaOm6qYzdjNFCKd+3xec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784709267; x=1785314067;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mo8WgYh25ldjyX8DCM5vtgvNxtGzO4105EDC10m83EQ=;
        b=VJDbxp7b0pvrSHIEbd0cL6BClYK6fWTKNN0ubAU2yPzsBvm0jI79c1raUNKuJW6edK
         KmNO+oZWvO10xAEwuniXF4UgJczABFrnlQi2v00Bw9UjIjVffGoOlXpsHg+hYTgURLhQ
         16rYBS3wXR5RhE7wyNYgGtpgZYCHkBoHCMMsaoqAhRdEzlHD81slKntqeaXUsXrVXPCT
         vrQ6HDzr/5HiLQ0BHNfN3xCle/3A7yDpF3LcYFKvaO69r8T/7IdWEZ39WYv997oJ9b9B
         zwt50aL58eGaHltKzS88zTcnhB6s0IJ/CaAoM6knlMA2WOhQ9A0pZQADM3pqyrM991sp
         bAjg==
X-Forwarded-Encrypted: i=1; AHgh+RrkXIZcJ7zwfMFpxzljczWzkmtZ87+Hf9rDOO08itRAmgRD0r5+JMd9js5nsgb9P5rQwNpCPGqHkzVzsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyT+cHhwYOiZMFWGfn2axmcxrYTO1wDJ0bfyr8PzFGZo5H/rgyC
	CU3O5SZh8tDl87Q5Hf7rY1FzpQ34TiT9bi9CEKY7eiyEJkaUJFjh1ZdRWGlaL2b3+AN+d9ZuYBz
	5KgGJ3dtI+t0E7Ui00fHkx9bEkGdRZibjmKxeGXwP
X-Gm-Gg: AR+sD11+lYm/WQR9QtKrHiHgPK0hPVPyj9uH0ml8wm32Q5az6Q2jykUo3VNnEsqbcRW
	mXa0QuwtXobTLX2Q4PwMLZZyT4dENCgn1p3UIyEu0smmRbhvYtAzA5BPIsJosesKUj8cq9t/gdF
	TJB52FeBHMzMulRG924AjaMb8huLqYgyyP8SKqlSkTfLSLRF3BB4UhstxaIZdshNqcaaJxU2TQp
	BGLf8jWT4uBMEI7/FP/z4gDYDpUehK4f9e+nZ22wA677vJgLRTl4qD/5GSq2J0MnFNZGNQsiYdg
	WKwEQH4cWUOx1zf4
X-Received: by 2002:a05:690c:c453:b0:81e:bf0e:55da with SMTP id
 00721157ae682-81ef260c885mr66446937b3.48.1784709266701; Wed, 22 Jul 2026
 01:34:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721075226.2347933-1-wenst@chromium.org> <20260721075226.2347933-7-wenst@chromium.org>
 <al9IwVR7Whw2DiXU@ashevche-desk.local>
In-Reply-To: <al9IwVR7Whw2DiXU@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 22 Jul 2026 16:34:15 +0800
X-Gm-Features: AUfX_myMObbdQM6Uou8RDo9wMrLkt0Z3Ce7LljI10q7k1rjjaXzvygc1Ey8OWtE
Message-ID: <CAGXv+5EkcASZ__Cyp4PnwemPd2xAe+WL-ics9jqHLuxWjWyT7w@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] i2c: of-prober: Defer regulator_disable() on
 successful probe in simple helper
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

On Tue, Jul 21, 2026 at 6:24=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Jul 21, 2026 at 03:52:20PM +0800, Chen-Yu Tsai wrote:
> > When a I2C component is found, it's device node is immediately enabled.
> > This triggers device creation and driver binding. The prober will hold
> > the regulator enable reference across this part. If the driver probes
> > synchronously, then it happens within this window. On the other hand,
> > if the driver probes asynchronously, there is high chance that it
> > happens after the prober's cleanup function was called, in which case
> > the regulator would have been disabled when the driver's probe function
> > is called. This would then require the driver to wait 100 ms for the
> > hardware to reinitialize, even if the probe function was just a split
> > second late and the regulator was disabled a few milliseconds ago.
> >
> > Recently, some of the drivers for the component that are targeted by th=
e
> > I2C OF component prober gained the ability to skip waiting for hardware
> > initialization if the regulator was left enabled. This happens when the
> > PMIC has them on by default, or if the component prober left them on
> > after probing the component.
> >
> > Wait a bit of time before dropping the enable refcount on our end so
> > that the actual driver has the opportunity to catch and increase the
> > refcount on their end. The 100 ms delay was arbitrarily chosen.
>
> ...
>
> > +     /*
> > +      * Wait a bit of time for async drivers to probe and increase the
> > +      * regulator enable count. This allows the drivers to check and
> > +      * skip waiting for re-initialization.
> > +      */
> > +     if (defer_disable) {
> > +             dev_dbg(dev, "Deferring regulator disable\n");
> > +             msleep(100);
>
> How was this value chosen?

I just chose an arbitrary round value.

If both the prober and the driver for the probed device (trackpad in
this example) are builtin, the time between enabling the node and the
driver asynchronously probing is between 5 ms and 30 ms, but could
also see outliers exceeding 100 ms.

If you're worried the value won't suit every user, I could make it a
parameter of the simple helpers? And the user itself could be made to
probe asynchronously to not block the main code path.


ChenYu
