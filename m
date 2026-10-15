Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AB64A8A32
	for <linux-input@vger.kernel.org>; Thu, 15 Oct 2026 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050583; cv=pass; b=Lj7KLypIANAUfocMgpFyvlqFtTjRuMIFw541TVqR+hnTxeBVA6RwTJjyqYpZj7Y3dsMC/Ml/Aj5PE+er+wDWUKp4/uqHkX8e67ynBIcSxm7xKLeh2xXixt5bTPEDsW93+MG9uFhBhQyrnt7IRO4AWHceAlv2GIsgYe9jlr0rrjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050583; c=relaxed/simple;
	bh=s0GzHLToX8l2pJV6FGUrdQW+qoZWtYzYSSm2Om3AhAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SVyjEkOF5woc/vbQg9F82Dqj6hh0n8g6kgIjYrR2ZdHaic+JazghoXtzjG2LqdN7EW/SmFDabAiNs2jfvjszeYEzcg1vHjl/W9iTUwRrMmwVWkqMi+912PPN/0YhHeAgeD46bUrEvy0OiuZgPRyVD1jwMa7Na5M15kviSY9T+VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0cx1fJ/; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0cx1fJ/"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35f036b17easo1883886eec.1
        for <linux-input@vger.kernel.org>; Thu, 15 Oct 2026 00:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792050580; cv=none;
        d=google.com; s=arc-20260327;
        b=QcpNT4V63+i4TAp7T7+8N1F/tjjf+7SY24+5JMXf8mbRfUYGkWv7I3MKw/ZU753yGJ
         OhmaUuXSQutLEUvV6EZCGjQREP2uBxJg7Hr6bxPcLybNpiOpVFQzNTWwSHL+51kjhhbF
         AZI2/2C2t6YjqeDgeHH7tAK1TofTWQH2Vc2Ddj0+7KcKiKUhMKqPoZFccw3LU8MYPXcJ
         pPr1Pyd0/4FY4VyzF2CPCJOhbGvMcznJ/PDt/NgHey61vFInhOLnRji6RP/uDF8vrHQj
         QS6LBN6PG/ty6dmu/O9VnEku9P1F58QcJMzXy2LDQ2NGBbdLFIWyvYopHmFFtEom7WsY
         jHHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bn76A1L1zSnfTuyCF8XnV2/uvU4lFD6V/f9S5z9LEdU=;
        fh=O26cz1KI7p3pMe+fT/Qk80kcqsqZYpI76ZuMOZvwLI8=;
        b=iUjdjTtB7RiGxpMVvCakQwwGgQCume3ioFKcR0AoKzzX92wZ8tijRlynOekjykIp4z
         9qltn+jmtPOJLuXuB8X3wmohDp5g68bqYOb16N27c1PsQgxc25dlJORtqu6GhPdXehOU
         wU7aIMpHUrHoxLXj/E9aJCmgElULgg4Apl+UgyY+AO41Bh5CatW26HF7TbJrLFyvnF0B
         cGwTJ02T7KCKlxdIVd890B1XAubnOnQCKJfMIiLGUoy4o/pnh0LBd2agTWLAsZPKzzGa
         FqiBs4H0MlKnFPc01dd31iaeho01EajRMUJHMrcsLOmtRD23/YblKZayruSVDIToeHXw
         kaEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792050580; x=1792655380; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bn76A1L1zSnfTuyCF8XnV2/uvU4lFD6V/f9S5z9LEdU=;
        b=O0cx1fJ/BDpY7KUOgOuGRDjQHPXU2Sax1fG8UyVch+sPis5isWnLDv1fKhlI82OOxS
         NIfC6XolPitBu+MBvV1+lbhC5MvQeuY4RdH7zDza7wN+PM+j6+X9KHsTn5XfMEVcHs4l
         UpBVMDNrxx8KWwTuYTO54TYGlMumcnqDAs3qSqNtkdiUb7ddZI52uT3FpXMJX65sPiM9
         LPFcp/qfPpW2gu7vMvqb0/okQ+p1ZpdJkIkIp6PxCru0wyxuXw1aX2f87vnqUsOxHTG+
         rv7Hekdck37en3gS4yd5UwKbomrHDGm7JXe7L6XqUwqPdycf4bKkvea9wGCccF/mT7KZ
         VKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792050580; x=1792655380;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bn76A1L1zSnfTuyCF8XnV2/uvU4lFD6V/f9S5z9LEdU=;
        b=FQnb8qLrEVK0jrOi+Fbzzsio3djeMytSjEidCmOvR0z3dsPwQu6FJf8pd0iyhjM7+U
         PCmBU75XnrWnlwu6zxhRjTxEsFd5Ukjjj8eUpefjpRNW89eNyTCNAaOQH76vYo35zRL+
         DsWSVTF3rjjwllpmOwp6AOtDDz/WectFKLrCKJBkEiB1kG5CXaMaXK9c8xKL+NtyivKh
         SAEtV8UkAAmF+B15ZqsgphsUMBi9FnE7hB/2M63ehJP9UHua5pRRpiM5XqIH3UJYa9Xv
         jzdbzOpW8n0kvA0NaWSdRvn4FPeITGB0zMnyUJzYRuw980ZrecME1F06Agmrc8qwAbrO
         PbeA==
X-Forwarded-Encrypted: i=1; AKwUvBxUuKMRHGkrc3hMJGfbGfDggFx+utlABrPxWWEMgxNDnqZeKbAAE9gVb1eEkRBrfriiEkuO4i8G+65A8A==@vger.kernel.org
X-Gm-Message-State: AFq9FYJByfsIg+xH+VbtUJCZdcg4yhPPM1BXRQE88qgSulNk4fRbI2c7
	pjKUS7dzi3cp4Xo2RwWcRESuhHpIX2EV6PZ7vfExbxZNLva9gVREC4s7fMHvtapEziRuCf8Ek7a
	wRo+0Xjfr376wxTMJ10moI8gdBKqRU2I=
X-Gm-Gg: AYBFou3DbQD8JL68oBzPu/QuPtgedu3C3mDocngQH+LDTBitm1VQQApB0opUCtmsfZD
	evV73FK5FdeAEin0FoBJrGQBnnl+SJF4hypgwLeZycH7hUq9Dk2mRa1CBQCNeZK39LpMZ+l1gkV
	XNlpWFafD+l/9eX4KAtSYuQFzO1ZnrKH/nnF97Q1+IJrw3XWAx4PCCcOYBl1uvyA+ylBm/FgkIg
	MblYJH6xlCejOmchGAuot8DCS6W81oxlaxLcEHzznwZ8j7ezXK/3yk0hpiRWzfqmH2zcNHAk+Tc
	irtPAKB0J0l2UbzEHq6VXMApWcmXQkrto1igepKvSHHUGUMiWiPYbJUBiPyS2UtXu4P44kPEhsM
	DAFHZDMb+PXHl
X-Received: by 2002:a05:693c:80c5:b0:35f:6d9d:af68 with SMTP id
 5a478bee46e88-35f6d9db757mr1154283eec.23.1792050579562; Thu, 15 Oct 2026
 00:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013173504.451391-1-clamor95@gmail.com> <20261013173504.451391-7-clamor95@gmail.com>
 <f5d367e3847da2f3d3db0abd0a099920@gmail.com>
In-Reply-To: <f5d367e3847da2f3d3db0abd0a099920@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 15 Oct 2026 10:49:28 +0300
X-Gm-Features: AclHuK_Oo9j5QRqhps9x8wmywtw4oQlKiNMQc_P7VxvfWQOhI0DwxVL2kvoPOvI
Message-ID: <CAPVz0n1YcHwH7b8kg82Gfh7GaT=O9Sx0YEhx9jAGkZ=C1JV_JA@mail.gmail.com>
Subject: Re: [PATCH v11 6/7] power: supply: Add driver for ASUS Transformer battery
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Florian Krischer <florian.krischer@fkr.dev>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	mfd@lists.linux.dev, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 15 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 04:3=
8 Dmitry Torokhov <dmitry.torokhov@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On Tue, Oct 13, 2026 at 08:35:02PM +0300, Svyatoslav Ryhel wrote:
> > +static int asus_ec_battery_get_property(struct power_supply *psy,
> > +                                     enum power_supply_property psp,
> > +                                     union power_supply_propval *val)
> > +{
> > +     struct asus_ec_battery_data *priv =3D power_supply_get_drvdata(ps=
y);
> > +     int ret;
> > +
> > +     switch (psp) {
> > +     case POWER_SUPPLY_PROP_PRESENT:
> > +             val->intval =3D 1;
> > +             break;
> > +
> > +     default:
> > +             ret =3D asus_ec_battery_get_value(priv, psp);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             val->intval =3D (s16)ret;
> > +
> > +             switch (psp) {
> ...
> > +             case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
> > +             case POWER_SUPPLY_PROP_TIME_TO_FULL_NOW:
> > +                     val->intval *=3D 60;
> > +                     break;
>
> asus_ec_battery_get_value() returns a u16 (via get_unaligned_le16()), and
> unconditionally casting it with (s16)ret sign-extends unsigned 16-bit
> properties >=3D 0x8000 into negative values.
>
> In particular, when the battery is not discharging or not charging,
> TIME_TO_EMPTY_NOW / TIME_TO_FULL_NOW report 0xffff, which (s16)ret turns
> into -1 and then -60 seconds instead of an unsigned value (or -ENODATA).
> Should only signed properties (like POWER_SUPPLY_PROP_CURRENT_NOW) be cas=
t
> to s16?
>
> Thanks.
>

You have a point. I assume that using val->intval =3D ret * 60 should be
acceptable.

> --
> Dmitry
