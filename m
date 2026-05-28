Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FB3309F1D
	for <linux-input@vger.kernel.org>; Thu, 28 May 2026 05:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945048; cv=pass; b=irLYexNhAtTv0KQcnkIsgtza4O0aAi2wBaYv8SXs/lYdVjheMbPS2CYDfZ/3GhAaOvGCF65W8nC/e0RdCzVU+yXTVJNlyNRuLcgkljrZYeIIgcQDtJgxVzDQOjNVQwscYee2DbVEHcLuL353MMx39w15ZkzbLwomwbVy1kG1lM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945048; c=relaxed/simple;
	bh=MfH+OfqUIqkC1sWKkiJm/aqSYamFeEbiXsfH5VRilGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PmkJVww8HivjhKa/CHZnUZnoB8czXGONJhx9sM07naEML4nzl5ZCR0974/oye/5UQvEj77Lswniv1KE1HvNn1N2zzJMQVPclOchKO7rcWzxf0dhFqWsUa6kAoYMv8GDSXaXJ4MnlDLuikcNH1EDAA2/0gxhXw7JiQhgMu5b6K/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIyPntya; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIyPntya"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f33ae12f97so5186432eec.1
        for <linux-input@vger.kernel.org>; Wed, 27 May 2026 22:10:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779945046; cv=none;
        d=google.com; s=arc-20240605;
        b=N56rpYJfX8I8uu/IrQLyK/A5GFMU8GB7R70q68euC72phVUf+A1zccNBj3KyEaw48h
         p6V5dilsif5Kn3F1e8OnSJK8h77oj49n2PTVB24rhfjtW7EcnHRNDaDg+js3r0f3elhY
         GBLh6fhcKu8wc8JOF7z+liFrIKSEM2hO5N6LdNaqPauP30YRdecNooonkz1tyBX1T5Kg
         gIgls0t+V4V0gp6kMf4yK8ZuabCBMMIO1H5pmIsB4pRaKWB2mLtZm81JudVzBXXIoQdC
         nEDoiZhWoQRwfipPqDC3xqJdxLLGr350/WwJHmGMUDRMLGh6xnFX33gm/bofOtiCMW+p
         AfHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MfH+OfqUIqkC1sWKkiJm/aqSYamFeEbiXsfH5VRilGc=;
        fh=3LWIpwblLGHoNTpB5O22nUdyGGJCyQGtXHM5/kjUQjs=;
        b=bXJUlunDa2chajCMRLdjIvWH3UdiLk+v4i0rzlriJOvFHoAJgWOOK3QgALEsci/wJs
         H0WX1MB7zg7oRH/qqiUc8iUKjqV7ihvrf0eAl53F6xdg1pYEjtX1y8cMdmWdu+iysypC
         Jo35e9d+ciIc4AZCcWJEovc0udarBXQWyAeXBQNnQ5uizXOwBhIvQax5a/p6JS7VoTri
         R6UGZlemNHcTbEoW+ddXGpdaDqNPXJsdPXRo/B6cZyzOUoT/xxDr11j0NxNqacBUx0lZ
         rFod9Oyhf2MOg0RMiVRtIhyM93UY4IxiBJ+kscd/LMPR6fM1xCcCh7wHFiSVkMOevyzD
         SKbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779945046; x=1780549846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfH+OfqUIqkC1sWKkiJm/aqSYamFeEbiXsfH5VRilGc=;
        b=FIyPntyaQci7Gow3k5Tv9c+eiSQuvMqAIg8GauSmePGIb2DAXnmUuFcEBNNEbMKY7l
         z5IfrSIUcto7gnwcIRtowu4GcOZdDKVYTCu3Z8TiCfbVGGBS4ikhaknmg3LDgf41mCkD
         wMmKMcuvP0uX7NjK90oK2N0Z1AGDJRgSPGa0tVqwM7pOVpGcKGmSZMD7jbQtpLxd4iyK
         mpH8+HdDfH9pwkhFQWl/HZob7rD6I5NUQybbLojqgUOmMYMfNp4BIRUVQBZKD8XHDera
         yballBJqN+9CsqGtlZUeZWioS3jB9XMzBjtpeUofLYCM+sdyX/BhMpUIy4DiWf4zEh5X
         OOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779945046; x=1780549846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MfH+OfqUIqkC1sWKkiJm/aqSYamFeEbiXsfH5VRilGc=;
        b=TMvTBILW1CUBBRQE3QOYgGYqwn99Xr5n7PMA8reboFfHOf29bIMPMwzkUDLwCLmeBx
         r5dssoRY/R6QZXefJSq231OKlGuteTh8t7OgAJChmaXznWGTpZ/YFz3PIfEVeP4uz72h
         4Y9BXbeZ0tFkWQJ/Yt8Vh+sVqxMCXu5hnBi1x8OziwwN3Zg6xub0OE8KO6iSWN2GJRs5
         VjVT97/TaKxX+dSk7ATb13SI+6wI8M5TbSTS1Tk5dbNF9yP9hZkBr953Sn5hn4tDhncC
         j8/mTTndxFg1sqNiu/7mqriLG4OwTK6qEFcydedA6k2YaJGVyjUhrrTA5KkzO73wgftD
         i05A==
X-Forwarded-Encrypted: i=1; AFNElJ8IWUYu7CFqEUUBGqR0nmhW+GYcRkRd/m3Br++2nC4TgI7Xl6MBNvTsnq9FC5fvTAtdjSWpePX240Tquw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnbiFQERlTzebFoI2cJrtpOhfBw+EtiF9fX8rFczoVOsce+2ty
	kKqILpQ6u2g4UvxzkdU1G97bhdohThmB5vk1IgbQBjUQHeN5ut9ISycdOFRWbpNXa/jOhvea/zg
	NI4b3iOFx/gKLasK9MDr75YCG2CPb/N8=
X-Gm-Gg: Acq92OFLpevwlZQejMXe+23LRuOTGcIADvW2iHfirOA1sI77RXQ+jLOcALrxMOwA+vw
	kHrzURsWrdN5sqzRN3NMuDFZM0gWxn3XME0Lo5p1weKjilWUn1mqChizKuTxhstVWtkhh0482Pv
	E455YRNkRxGIsfNT2AF8QPVUTLrDfOJgyc+KJyu15Io+YSC5t26OTGDhECkwKwZIypkS2Wva9IU
	R7uTvxSgfPSCHCc6jicYr4wILiGmWdL26Oxgq06ekqr5HkKEcXC4qizGZiSlvVKtzRwbxyUOMVP
	RNOtGKLsx5obnWBgOJ4=
X-Received: by 2002:a05:7301:fa8b:b0:2ea:3370:6e51 with SMTP id
 5a478bee46e88-30448ffc5a9mr11709293eec.4.1779945046369; Wed, 27 May 2026
 22:10:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518095907.36158-1-clamor95@gmail.com> <20260527144619.GA671544@google.com>
In-Reply-To: <20260527144619.GA671544@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 28 May 2026 08:10:34 +0300
X-Gm-Features: AVHnY4Lq5d5JMdXBzoz6BtIZMrqkYtiGSsaMXY6hInghOFfRu3LWOak5AA72Ac8
Message-ID: <CAPVz0n285opk=xwzEs28aitTZt-m_OtrvHRx0RenJrmV9rbPqA@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] mfd: Add support for Asus Transformer embedded controller
To: Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@kernel.org>, Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 27 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 17:4=
6 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, 18 May 2026, Svyatoslav Ryhel wrote:
>
> > Add support for embedded controller used in Asus Transformers for
> > managing power and input functions.
>
> Once you have your Input Acks, I'll merge everything through MFD.
>

That is awesome news! I have a few minor adjustments to add including
input adjustments Dmitry might require.

> --
> Lee Jones
