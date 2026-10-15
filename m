Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B27A463B61
	for <linux-input@vger.kernel.org>; Thu, 15 Oct 2026 18:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792089707; cv=pass; b=evqIajLxCLInoRJuAF0M0iOZghdIXTYfcXOQa/udPJhloQVs2/VC/cjd2F445hw77+xif3Hw6SC4LpoEZ0WGiQLQZm1GZooRkPCLRAMJDXIyAcjroI9FZnkwQXO1J6nTzR3+Yg69Y5HNewRWjIN+oJA/RPTceDDFwHP1nktNRoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792089707; c=relaxed/simple;
	bh=xauoRU92rayWXBiUnhY4lqEI/RzVYWTkJ5X0x3hjblE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQW1gZbISfsF+zlNuqZec9P57ZpOdUSIoJRA7SbmHsK2Z/z3SIKkzh8UP0P5bxBAlDo/4yn8oRlpilNGUUR6H1O/P6Vcc3eZcotm4HPcnDjU8Q8zKVEF2pFv/K5ljrcPxqwJOuhutzK2He3/Ic/YdfWWq/G/O1q/I0HhhLfRdj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+x9goKG; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+x9goKG"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso6913586eec.1
        for <linux-input@vger.kernel.org>; Thu, 15 Oct 2026 11:41:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792089704; cv=none;
        d=google.com; s=arc-20260327;
        b=MeB4fww1nMgxiM1f0wb7+GWrEz3HPyR6zvBdWuHz0ovM3mMzz42Xw7GJHZCcXlSh9Y
         6Gh82h2GI3qJwnZINc8QQGAkqBNAPh0ciqdCeSD9fcc+R40uApxqv45qn3VGCuNyWCsG
         hX4HpGnS0PDkFpwX2TMJcnWcssH85rVjnYPy4+EQMBsTILC4+8ySE2BBOx0AbDKKhh0D
         IvsTBkvijsoRe2xDYEqt9s/UXr5oou3yIHDJg+JkCe5ijyYNA+koaU2PGpZral8HG/iY
         Fi0QJzq1soh3DXiUx7wj6VY9ItFMewp83sdRDeQHIdKRxqJYHuLZQBpB1r4TtHHJ1OiQ
         O1pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rsIPZgYgrzIClGBhGTKauA1e1WQnsO82rJ+gDiB7nEg=;
        fh=+amb4JMNB4zpBpkhMh3BFPuMWx+XeinYBiivpjWpVrM=;
        b=O3wK+fSjhjZtQlhuNHR1/wuELAFJKU96siwjZ8QzFwMObSU0VZ/zwQWDCRyfDP9NS4
         HP2s/Cn7Qr/SsbjaXhk9FyMmA4L/qBHx2SXQXBOrL9qqHjM+0PZkWbLVthA8cLUKGp+Y
         4ten99YisoZZfZog0lL7ehL32U1+uo7GRuekvbXIbjqkHelIPnnJoO5gvwUPc1p7qxKV
         rpdRaeMPhtGGjID7hwzNOQVTOaU8SIVUrOXsbA0zvXXqYQQ8JD87BBRFeKofdB9iKPca
         6fbGezgeoe1bVabGkwsda1aIeciUwmSC8+GmoByZTt2011ADtpDpg05X3ulMhwSZYAF+
         oVTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792089704; x=1792694504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rsIPZgYgrzIClGBhGTKauA1e1WQnsO82rJ+gDiB7nEg=;
        b=D+x9goKGpfvnl9hCynIoU/Y+0NFqZ7WirIuX6nMhBfHcDA2HUKIJVwq665QzT/6/Ap
         A/+Lm1PdYvR37sHqfiRmmbNUORvFIIqxOzbKh1NPcc9zHysO1RKfLlxwVDQoPLblq2BS
         oYRsCOP/iKDu9u7N4MRx1K2zgUKTkrr7oj0dHgtC76Dp+qycvi7ewwrGSe6r7RAsgwh4
         x15HDivoawBFaFdgcmvz5+L5fOTcV6n6Rxuq+wPN+O7o+0UuIiw5PyKLfWrUtlb0G9O8
         wIyrudOcUFKeZNt1XX0/P4qWEJm4QmV1xnN0lPQVDNi56AwZamHh+5OL5h8eaUxEhO/K
         EytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792089704; x=1792694504;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rsIPZgYgrzIClGBhGTKauA1e1WQnsO82rJ+gDiB7nEg=;
        b=P+vAanT2Epu0MkNdsOHA1U0tg84wVdH12ou79SyjwN2DnfyeI/WhL2MaefsK3PlYVS
         Gzd6I2AV7MiAT7ir9RLZBf4Rlh5p9AQYPgMSQRDib/jE1kiakfS45H8Rt7tW7p4nbtxM
         yqj0Ae4x0Cerfmuf7cRTYotlIDR1vBnv9TdrrZfBddEHZVWq/JKZC6M8KLWKSGfoimJv
         1/Ay35CRkZstuOX5R9uqOlKhdhcH/7R0/bDAYJCW9wZqiu8IKI3fdudcvz7mGWVXJa+0
         pmrMBhNGkTtssEcZKRArpCx2Qi/106jsUL4cKDi6Nl1cKx1TiSDl5Gy2EzZACB2r12R1
         L7IQ==
X-Forwarded-Encrypted: i=1; AKwUvBw3DWaECq2usFUps2aT4Gn4S0dOF2IWPQPVdZ0QC2IYMWaJ9oVCpxHrr4y83aPhu7U54sSnFgEpJsM15w==@vger.kernel.org
X-Gm-Message-State: AFq9FYL+8a0eLDx9/jwvJ7p0LIoxMWCpOB5bkUru6nsNH88S4AVNcQF/
	JD+peeHJcX2wJKfq7YJN1zGIbaX5TFTSQzdY7iHvPJmy6vVtgvtHTqeHAnUE2gGevSfBN/ZoB+o
	SpwUQ81TztPZcVKuixogq9apaf2KYvpw=
X-Gm-Gg: AYBFou15Ru5NKBQL5k6NE9QlXHW4i/ApG6+gWK0lhLEPuKju6yO9DqOcL2my9OcOaB4
	67Yi09C6xDK/RmEB3A9EHfINua91WtOUkTQtIGcZqWsnBIdzSDdwTUdK8sw5/dU08vANkMSVZrr
	zlD2FtA/eyVa2W4sSQydD5Gos0M+e2/8gfK5ZkhNU573xOLYY6DoHBZV043nJtHJ2khPgTW+qjS
	Lid5XgtawUaLDZncaJXZCrNVJ+abXD+HKW3+pUte/Z6p/t/QdckTXjtvAP+RN1xDy9qb0RycEB5
	hQZKxV8OE91h86GhwZbuaCJPIEaL4mO8q99sGbswwJ7t040/SzTJOONSYF5u0hMw5iZS+QPAgAl
	yXeedE0gaUgw+
X-Received: by 2002:a05:693c:2a12:b0:35d:2c2b:215a with SMTP id
 5a478bee46e88-35d2c2b2220mr10102451eec.35.1792089703889; Thu, 15 Oct 2026
 11:41:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013173504.451391-7-clamor95@gmail.com> <f26b6bba-2c2e-46b3-9350-0ba0785cf3ba@web.de>
In-Reply-To: <f26b6bba-2c2e-46b3-9350-0ba0785cf3ba@web.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 15 Oct 2026 21:41:31 +0300
X-Gm-Features: AclHuK-9dwgzuV_rOZ05ZsN-0-b2YgDg6QoraK02oNxRoGvJeYL0q4NRa-SbCE4
Message-ID: <CAPVz0n2ubBgOGO5q4ZBYkw-eDSuNh-MpdBk7uoWW69m2QduSgQ@mail.gmail.com>
Subject: Re: [PATCH v11 6/7] power: supply: Add driver for ASUS Transformer battery
To: Markus Elfring <Markus.Elfring@web.de>
Cc: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	linux-pm@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, mfd@lists.linux.dev, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Florian Krischer <florian.krischer@fkr.dev>, Ion Agorria <ion@agorria.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 15 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 21:0=
6 Markus Elfring <Markus.Elfring@web.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
> =E2=80=A6
> > +++ b/drivers/power/supply/asus-transformer-ec-battery.c
> > @@ -0,0 +1,289 @@
> =E2=80=A6
> > +static const unsigned int asus_ec_battery_prop_offs[] =3D {
> > +     [POWER_SUPPLY_PROP_STATUS] =3D 1,
> =E2=80=A6
> > +};
> > +
> > +static int asus_ec_battery_get_value(struct asus_ec_battery_data *priv=
,
> > +                                  enum power_supply_property psp)
> > +{
> > +     int ret, offs;
> =E2=80=A6
>
> The referenced array provides unsigned integers.
> Would you like to specify a more appropriate data type for the correspond=
ing variable?
>

This is a nitpick, it does not affect anything.

> Regards,
> Markus
