Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF1935C69B
	for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 06:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790575500; cv=pass; b=a/zN/UPrA0BKrtXATuzbowtuaQbJsWoN//Z8NU587/GkWQNFtofD++xPP37Kgy+LDIPT2qcV2XLWq5oMaKZ3aKkHN/R9FEnr2IiWzKYCUhKXY+bWWYb1eqTX630VaXVNSayGnGkb5fK3WcogxwNSpRB4fS1lXfeeH5wxZmM7Yxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790575500; c=relaxed/simple;
	bh=GYLuVesnje3a3q8fx40L4GXeBGM+JoVDaVm2RxVQTuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jajEVAI3bGM4O3lBWIeXcNFDw28Xm33LoS/J2wEbDc7Ufxz+MURWK0i+zCRYfYc1jZJwNFsqrPun0pzssd2cNlCixIZysWdpx94Mo4JVB+yEqGaHgZ65buPhBDBEzPOMcRclmZZlpjzoGHoq6zT/Omb0inRqmwN5DbMQcGJ6Iuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISvg+HHs; arc=pass smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISvg+HHs"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e83a388f8so19680105e9.1
        for <linux-input@vger.kernel.org>; Sun, 27 Sep 2026 23:04:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790575497; cv=none;
        d=google.com; s=arc-20260327;
        b=HYhG5s6ftrFDh270vdgq8qOKZOwsHDqr0H+FzdKIHASEDYzRrq26f5j7UXPOa88/P2
         HQ4P4qEFYCilWJCNfyPexNckbi0RvoYNYrvXsnyMEyUADbgB0dfhKHmNlbDdPCqwvM6u
         DU0QknEjXe0OEI9wxYqZsPF9x34l9RFMkrKmZE61P0nx74zSsMmW4cla2HSn/7BBTwum
         LkHzXSTZ3AO8RzQ8BuzW6AhqkcwlDPKAVpw2baM+Exfd0XnzLJ/jU1VHdnCq706dDQBL
         +AkS5ATW5M0lOTixLEZMLnPAeK1Kpn8K0vni1dyCDSE+j+rZYPAo/4O69xmwBUmpQyHJ
         jP/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GYLuVesnje3a3q8fx40L4GXeBGM+JoVDaVm2RxVQTuk=;
        fh=UDZwEzLTPam51zXlKbMkSer/FKnKbvHGqP5JsJ7b4jg=;
        b=qFtT0ojRYJLNYeR8Ehguge0D1fm7Nnn6uKuq8Vfys0cZrmv0J2qYVZiIz/cvBfmFVC
         y1eyNsheTlzndLq8NvX8AJkpmbewuQD4tq1WlWZh1uCvQwnIDtFClHSIfqdeZ0raF31H
         +T9pQA8r6o4HLw6okpz/gZY5uEGjyKhW1SiHMw9b/uZA+9FlMJw3RPamrDTT1cfZZHpN
         Ve/WuUjjtNELkcwXI7Q+21+Yeuz7RWd5fgUM8oBIuWqBy5AzMwCS/OqMWjH5fTZCuHbw
         JyTUX1w/exX8XMXu5+S84o0QwZgr8Gs3Kowj5NDKamVIemiSypqPUOPLP5RN/GM8R00Y
         z4EA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790575497; x=1791180297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GYLuVesnje3a3q8fx40L4GXeBGM+JoVDaVm2RxVQTuk=;
        b=ISvg+HHs0Vm0kqLWM+2/0HRrZVYH+VC1VhwlHOLDmCvsx91QfggJxDXqNrK9ECD05k
         lnCYubiO8LVc9K3qp7IywkBFt4ARA1G4P3P1DUJpWJnTnDTrISeynfHNRyWw52wsGo6E
         SS0lck2gn17ckG2MAWItOe+ZQ1eX4LVn/yb9bElk3izPGGM3FpcOMBFz/3TiNDAt3Ofh
         3QNLuuPrrbpPgLh0jVyBJed1e5C19VBhpkxuUJ88XF5IoFb8aXsKQ3970eP8on3/5P8K
         fvlpuH2Unxhg4j6UMJYlqneV8BalfgXvEFxCk6mxfTx+F5rm0I2MmX3/ulouaFx6krWH
         u6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790575497; x=1791180297;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GYLuVesnje3a3q8fx40L4GXeBGM+JoVDaVm2RxVQTuk=;
        b=KhWNWCwtlr/yL86cVrfwvVSzIkuLmWq2BEVS7nI3u9HzWF+YXxteDoM6KQW7APjNow
         VFVg5HeZAWOMp54bD1ahgLjzsrp1/9W3TxPh7eV8GokGd2gheU+ILf6697PoxyfZZGGI
         iC13149ro3tsV7jFZTADnK/P5hMyS+SGcoHtYewv06q4s8n7iixwIokUeR2E0zoylrLl
         e3o2en1//AHWug0WyVze2A7GfWpMNrp2o6EDrtwhCkGSSVBBN8CKVZ3pxjVAW+4g/hcd
         cTAih8E1VRxVP3qW5OeN3d7yY8iw62KdKJD45izrzYTwbjYSqhqTAlkYzXFWu1jsgm+x
         W8hg==
X-Forwarded-Encrypted: i=1; AKwUvBz5cCzr31kmyTglOjHOlDiQvZms6as1q5WTW41+aQNLuxjuokHVHywiRZ0GpiqQz99hvcIGRSgxR2kIxg==@vger.kernel.org
X-Gm-Message-State: AFuF++mbAlPTwfuWpWqgdJoyezcygZKUYWFgYUgAxOppFKRkDAepNLit
	6GdT5NlbmIbwMdjCvSSw5ZMqvvraaiYB8eyzTAu7p4PZ/1pqYFXix/rCaKANq34hLKo3M/EtTKz
	lYDP/q6D52pAZw2u7Z1C3/OzPwWavLSA=
X-Gm-Gg: AYBFou2XozerrTD2UF4WtLpuJuCDycYRNHMj2Ql71PFdpzH7KBZEqPvBJw0Ugom/ky6
	JsB7/+ytqxluBu0hJ3tClcM/01ZcEZ4ug0tGl+BfAAnJ4CMPAueAh3xMpkKw/UH1cMhE0SaueNk
	wcMmmTR2zY5ztd0u6Eo740Z6ro7LVMxsVongPmMPDcOLI7MerqS+my2TFAEMLTHUapDKil/Bdv5
	CppvQ/1qc/CgvfBPgxGryRLjot8uThP4tZTMBENk8pC/itymYvFHo+y4P5oiXXW8COEsWr7eLL7
	tN9i7zx6zEvvSvp1vG2+mtk91EocJ3yRoEImZskfkK7daTPDh4+6tZzjkSoiPVf1Q80dz9N+6X1
	SXxEhLQ5TEwhSvbgGdfJz6W5IIP5uBnB31TcWfeqoffc=
X-Received: by 2002:a05:600c:314f:b0:49f:e4ca:e09 with SMTP id
 5b1f17b1804b1-49fe66ca9e5mr205820295e9.3.1790575496482; Sun, 27 Sep 2026
 23:04:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927114425.442803-1-pooyan.azadparvar@gmail.com> <arnRiZyWe6zmd68S@google.com>
In-Reply-To: <arnRiZyWe6zmd68S@google.com>
From: Pooyan Azadparvar <pooyan.azadparvar@gmail.com>
Date: Mon, 28 Sep 2026 08:04:45 +0200
X-Gm-Features: AclHuK_3fgXapZcya5CBrYMS9Xf5tOl9z-cRxefBRXPrIhRa93bw0gYBhPqW9Z8
Message-ID: <CANC3H+LG5tHnSU+8cnBUt1HEyUecN7M7=guF0yr6AOTa3cGtUg@mail.gmail.com>
Subject: Re: [PATCH] Input: raydium_i2c_ts - validate report parameters
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Muhammad Bilal <meatuni001@gmail.com>, Herlangga Maulani <w1zardsec@proton.me>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Dmitry,

Sure, I'll split these up in v2 and keep the validation fix separate for st=
able.

Thanks,
Pooyan


On Mon, Sep 28, 2026 at 4:38=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Pooyan,
>
> On Sun, Sep 27, 2026 at 01:44:25PM +0200, Pooyan Azad wrote:
> > The controller supplies packet and per-contact sizes used to allocate a=
nd
> > parse touch reports. The driver trusts these values without validation.
> >
> > A packet size smaller than the two-byte checksum makes report_size wrap=
,
> > allowing the IRQ handler to read beyond the report buffer. A zero or
> > undersized contact size can cause a divide by zero or make the contact
> > parser read beyond a record.
> >
> > Validate both sizes before publishing them, and reject reports that
> > describe more contacts than the input device has slots.
> >
> > Allocate the report buffer once valid main firmware information is
> > available, and resize it if a firmware update changes the packet size.
> > This also handles devices that probe in bootloader mode, where the pack=
et
> > size is not known yet.
> >
> > Finally, return main firmware query failures from initialization so pro=
be
> > and firmware update do not continue with invalid report parameters. Kee=
p
> > bootloader HWID query failures non-fatal so the recovery interface rema=
ins
> > available.
>
> It looks like there ate 3 somewhat independent changes. Please split the
> incoming data validation from the buffer management and handling
> bootloader query failures. I think only the data validation needs to go
> into stable, the rest are regular behavior improvements.
>
> Thanks.
>
> --
> Dmitry
