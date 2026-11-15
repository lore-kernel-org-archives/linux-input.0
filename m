Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794722652;
	b=Z2aG6dJG9icBDPucgbXlP0DpytN9sbYs4ijLYxGMF0kL8x1kSZmrgKwf3Ul4Zv8pZb9c
	 ojij5TuZ/v6zmhXqufuzN48raVtt17L7olhw9CTCwftGWsPlWjAvEP8lVlatO/TR3F+fN
	 lMyXRkGx8IXDd/94WLyEXMzDAyC+xtxe3LVFfwYdxqDMOnCj9CBHvSm8SQJpT5laMlqC9
	 lKrxH8W5rGNvMXN2VG5wcstmwQ3vVfpEY+SKmNWDV5XhxRUKjdiRfL2ZTEoNSs1hhx96r
	 WjgmkQ5Wap8NANKu2yu3owWQTjqvv9rgj49eX7/bJu1jd5QFR2NfwmqPEnuWiiqvTiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794722652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Mz1kAJtcE9B8LOkyAl2sbn7zB/+G+yFVxMc7DvFy8oE=;
	b=J5QqzFDwj1OyepiOC9Djy8wE53FRZVaUEPLGA4sdaGU6GfbMOcTG1EZbMINhN5ykIghg
	 cR+CbLqk/WXoW2igC9hkclodmLNuFcjV7crzIhbJYFHKWUSV0WFAlozfnv1RHJNfNngtj
	 G9IkQpz9Nr5X1dXjZixm7UNv+46wj9LhwFPASamIU5fTkXxC5zrM81Ej2RfjQlAbv15k6
	 kD9lJUiQ/nxn0t+w+kT2IOtCZo/JK6m4ZuOsWInOr+iSlDSO1yIAQOw8hdaG50pWoy8SF
	 YjaT9n79h0npLlj2DPI8DlHkQYy3UPRB9y2yh5KgSjFDT17u9mt6/cpAIOs6z20VQRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WwTo1dOP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD80F606A329
	for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 06:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD80F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WwTo1dOP
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-677d35fd1d2so2366494d50.1
        for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 22:04:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794722651; cv=none;
        d=google.com; s=arc-20260327;
        b=sV4dZgyY2fEceKSzQ7ih4JTU5iPxwGnmwRKs/eEbg7b1J4XlRoGH4r4eNoKnBmQDIP
         1HqelTOhxY2v2YiCsEp7O4lgEhsTFeHPSBrXVFC2foIpHXpnlFhc6Wvv2KmrxefjKxWz
         m9fofjZt/2+qSRqISBA3rourrD/IdsVRPPTwoJErz1Tdf+sC5kJQROqRE2UhWQL6N6Dr
         Ha7wYdKv2ej+Op1pEN8q0y2PPDWIF4Hv8r17skFTeFVv/0ier7wR2EM5Bkt+gkpbDOl7
         gZkyTPksC7blqeA4Tij431p5KMWAPM4edQChpZnrilKBEonvjl+Bw0LcxVTNHvBAGTIo
         CIAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mz1kAJtcE9B8LOkyAl2sbn7zB/+G+yFVxMc7DvFy8oE=;
        fh=Wxl/FbHhhG8DtVmWQs3lxUuXVHNC/4VXYcgmXIKUpq0=;
        b=mvLavldvOIgDvLOTqDatOs65nVVg7U4LMzNf9fDBiOP2m50fTs74XpGaffIrt1sTrr
         yzCLEunLTFdn/qmwyZyO8/ibDjagOmJVJ+CfpN521iKGvOduCUPwDd7auQmzzzLJ2GDK
         gcJouWTRx2ncOaMNHmjOnhENZOtxrQ9gI38+zdnlsGqiQ06s7LFSLTrdWrb5QUug7K1B
         fTtVw6CFl8jClohFzboAmL16kpBAn6KjcDtzrmikRUoMXOeu+NnzhO+PNd2U851uPQPm
         WJHu7PrINwB978Re5zN1EN41aGnStXNop/yFr3Akjlb9rnbB0M+iENkgM4aRR/2VtGdd
         l2oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794722651; x=1795327451; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mz1kAJtcE9B8LOkyAl2sbn7zB/+G+yFVxMc7DvFy8oE=;
        b=WwTo1dOPG3HAplFkJfIhsd1pODUUp5tYZVNAmdXSjX5BP7QxQrVF2GkB8JaavETuVZ
         Cs8qfKJZLyVioBuJinB7xDv5ru8ic0cKJkx3jeB3To4+YYQEnRuUSuZvk9XmuUkO24c5
         A0qf0PpnqSuRKnoUhZwipmBu/caC5eTWfKNOic34O8j2OOX95ryVqprH+XkR0xt8RSCy
         h4BBAd7rtP35J4TDeGM98JKHUL69ZWaqO3r8u6Lyjz6RJcomFjL6mZ97R/ztOXzVD6cb
         SSQeI3HWAt5SmSxs+gDRD6ehvzWf8WA4BBSTR+MceMM57cnv1Vwo3eTb5QZGNOTFAQ2I
         Ab7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794722651; x=1795327451;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mz1kAJtcE9B8LOkyAl2sbn7zB/+G+yFVxMc7DvFy8oE=;
        b=Zf1as/SxpZ5o/n9Z+DeAIa9eICa9lexjF36jZVz2QOfNJrDPGJMZiDKqxt21teyAtL
         hswTziiQLwi6n+bMeKqHa5w344bpD8U72qzwGpoM2kf21QPIIhnceQ9TpTXWC3K2d5Gs
         X81HmrzSXPPON7tnNIdlXi1kn7LeQE7bBnrx5nUglRkPVklPo6mm86WF+g6j9yza/lP2
         KExoTgR8/m0g/aGCmGNTZ2ujOFkQVZ8ZWYCox3/9SkXA8gXeIji2Nwh0C1DKBt5qV5CB
         +336POfOGhYkIXzokiE3dGGPxzKfQ0PyMfugLjZq5aulwGbNk3bLO9HbR7ygY349HaZA
         ZW9w==
X-Forwarded-Encrypted: i=1; AL+hErGe9YUZJN/+sYHdfRN3IBYk3kk95DhYGf/1lg0KVVaKcL0HKRLfwEHh9U5Xyz6DZ8P27FhlKNHOJS52lA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8zplcsblpCKpH8k7F086IOZQpbU9zErZCa668yF+A+dgP7wdXz
	j9h0apY+Swp3jYrAYqvjPlgyAV5DnmkZH+73PHYQpuujyNzRzF1dhdNqwxGXr4+NVoHWmHm3vaS
	tx12OJNdg1CZJaSzhANDgYFcBDcj6Fa0=
X-Gm-Gg: AYBFou3wePQITamU75U7yI6bMdu288rJTShWkbh7aZjMENSbF1BuViUGkejVoYLEmhk
	2rXQgqCVeNtIDgU6PIgSH2LwpeIZ0I8NiqZREqgLSkA0B2ta4vTNJzQOTUNvD86SU/0Ie+68eA2
	khJKtPmKWQh3pMFxu3eewNs/kYiUBzCybTJgyrNaRz1zWPktfZTuvirbyfQMU2O9RJjGoCwB1f5
	m4FBZiNool9qbj2vWmwBmwh0ghJscxDJz95RWyZejoLXJRde4oHVmXt4OM0J7zhnAMUyO+I6BWY
	X6iNXM3CwGqeELlLLH8EmXCC2c/b6tDMiNNUDPf4820V2CxC9zOBIjE4Ko2r91Z6r7JeFGzHngv
	B9rndr3dm5LD2SJvsrdy2KnyPIk5rx/LqEkWcQQKNBj8ZfF17ZJbSmYvoMdh9dzg5Uh/Kd8u9
X-Received: by 2002:a05:690e:191d:b0:679:a4a5:10c1 with SMTP id
 956f58d0204a3-67d895e4469mr3762944d50.22.1794722650778; Sat, 14 Nov 2026
 22:04:10 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105174252.36714-1-asiyee994@gmail.com> <CAK77STDQ+BDPJfxyewHDzf2VNkekV2dRapF-STmXyMazvxOyEQ@mail.gmail.com>
In-Reply-To: <CAK77STDQ+BDPJfxyewHDzf2VNkekV2dRapF-STmXyMazvxOyEQ@mail.gmail.com>
From: =?UTF-8?B?QXNpeWUgU2FyxLF5xLFsZMSxeg==?= <asiyee994@gmail.com>
Date: Sun, 15 Nov 2026 09:03:59 +0300
X-Gm-Features: AclHuK8s7kcRdIJ5mKwyLkOQyC5hxOv9HUsAnO_5mMHENqcGe_ARIu_bxvqKarw
Message-ID: <CAK77STCSUrjQUBsAM40GTPZ0URxwVVwc-YeRioMmAW3VYOseFg@mail.gmail.com>
Subject: Re: [PATCH] HID: multitouch: Preserve class quirks when inverting orientation
To: jikos@kernel.org
Cc: bentiss@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri, Benjamin,

Just a gentle ping on this patch.

Thanks,
Muhammed


Asiye Sar=C4=B1y=C4=B1ld=C4=B1z <asiyee994@gmail.com>, 15 Kas 2026 Paz, 09:=
01
tarihinde =C5=9Funu yazd=C4=B1:
>
> Hi Jiri, Benjamin,
>
> Just a gentle ping on this patch.
>
> Thanks,
> Muhammed
>
> Muhammed Sariyildiz <asiyee994@gmail.com>, 5 Kas 2026 Per, 20:43 tarihind=
e =C5=9Funu yazd=C4=B1:
>>
>> When exactly one coordinate axis is inverted, mt_probe() replaces the
>> device class quirks with MT_QUIRK_ORIENTATION_INVERT. This drops all
>> quirks selected for the device class. Applications created later
>> inherit the truncated quirk mask, which can break device-specific
>> contact handling.
>>
>> Add the orientation quirk instead of replacing the existing mask.
>>
>> Signed-off-by: Muhammed Sariyildiz <asiyee994@gmail.com>
>> ---
>>  drivers/hid/hid-multitouch.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
>> index 4e19a0c..94e83fc 100644
>> --- a/drivers/hid/hid-multitouch.c
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -2155,7 +2155,7 @@ static int mt_probe(struct hid_device *hdev, const=
 struct hid_device_id *id)
>>         if (hdev->quirks & (HID_QUIRK_X_INVERT | HID_QUIRK_Y_INVERT) &&
>>             !((hdev->quirks & HID_QUIRK_X_INVERT)
>>               && (hdev->quirks & HID_QUIRK_Y_INVERT)))
>> -               td->mtclass.quirks =3D MT_QUIRK_ORIENTATION_INVERT;
>> +               td->mtclass.quirks |=3D MT_QUIRK_ORIENTATION_INVERT;
>>
>>         /* This allows the driver to correctly support devices
>>          * that emit events over several HID messages.
>> --
>> 2.47.3
>>
