Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C8936C0D8
	for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771338613; cv=pass; b=CSNidRdBEAKYc3bfINwEDB9MbnaIZE4CZhKZs/fbHzcGeA2nSrqsPdspG7Ve8k3QC+6zoYVrGvrt7QO2dR0ZZV6Br5dpHQYKRF05LjRUrn6Ji2QCh69OY0SmQ7qTY92l3Owd+OcHXHBZ2V9N13fhjUSveFlcFcG/T98zYHMlt0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771338613; c=relaxed/simple;
	bh=xgEp0OxlcQGQ7e2PjqAvPQDJsGSUceDoN/FTA2D933g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfwHnJIuv02cd2rXo3oVXl6UTdN7J3j9Pa+YJ227HP9w8hgUZOV6MjLEjW3muX+nKiZTq+7FlAiUG4ZwqntPp1aI6CfcKtFxjWwEUdJtLI60dNbkLQ3npw56gVFkdB6I7J0eJXbbswlsB6BYRXf1+Ch3iV1bN4ibUXtjM3i9s8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biGqLMoU; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biGqLMoU"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4362d4050c1so4917711f8f.2
        for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 06:30:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771338610; cv=none;
        d=google.com; s=arc-20240605;
        b=J+Lghdscdd51O6i4bA33TRLTnMVPvRl7JNgV66UViAYIkArrPd3vELJDtYBHKaYUV4
         yfZlpDv3qCLWq772qvQdridTMS/3l5oT2CrFfUOO13RPcFwPWS5ZzTqnTJ1L90V45N0u
         iAImKH5q1gwYJ3KFlImhlaeoH6COVxGA/0koEzH/THNR0/++gT3YCCYXINOzo1m4sx5K
         VX1aRp1VSbN7VOKdQJJ+TVJQ0w3BRPrktWdib3ASBpejTpSPTQ4l6EOEwrLDYAYvu9B5
         L2U5rvJykTI5uM9iXqwfvGGOU4moO5yODUyOBSsTxflDqLVOLAndizUJxZHqbMX7J+6L
         +r1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VEXatnwqoQncMhu3mEDseyvqdEZczrLmCyrd4Zj7SDE=;
        fh=9iiAXFne+kOOavEKP8lhMVfheXADStaT0Nxokbw9bMs=;
        b=bg/2itEPDv9f9RoccUeUURfMTnb33rk6bCWdndbeq/v2YsyslvXtGaR/spwyg1ms4H
         WGUaV/4PDKwTburwsEMIy4Mo4mtOf5coABgN4C8wWk4F0h9GbMPYwYtPM8lLrAjq8iOo
         DW0RzFYEks6PbCgCylNtyiWQwzm0rPUE2lWuPuxsPF8BRaauH/d2vvdD1DjeZ49nsRZ2
         I7LGrkWmwjzm164lxDn7bS80qcgATSHt3dSeugmtBLobvw0+IVJoarkZnqWBGDcMoYza
         71jal8TCFK2pqCiYy1wCEAN2LaBUU+wz0TLLj7I+5sgReg5ftGc92XXP11xW9aRSWJ+1
         z9Yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771338610; x=1771943410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEXatnwqoQncMhu3mEDseyvqdEZczrLmCyrd4Zj7SDE=;
        b=biGqLMoUinuXrScyEXxEfk4PfQt7PiiEuJlHjTXqzmcLuZrAhUOC7F+aTKrIu3Ro8L
         EIu/ck8AX8uYJ2jc9IuNMAacAXmwnuAcmd4O3s/0t6Pa211MTaIOutHt19aWHcq7n+GY
         TOVmNM1N8SnioBf3bIZC92PsGuLiRMyzRwk2Cv/yzA25EQN4HH2LuwEN9vESne9R4epT
         d2QXYa+AtGhwHopXPCM5YnD24xLB3fYZ/sWRb65b/6Nan4e4Wooumq+GVMSmKR3IcNC9
         B2GU2zbDox2aSRIP/cMTIaVXesmvE4k+qWrxOtu6nxuBUvisuXPplrSkbwlM13YVs6KQ
         YtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771338610; x=1771943410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VEXatnwqoQncMhu3mEDseyvqdEZczrLmCyrd4Zj7SDE=;
        b=HAnojEEPkFD03hOTtEImOB5lJ53bY12kvl0A6Vb4+xY4OzKRw9bqXDq6A1TGfU+0Lw
         fioCGPhr+h0uZ0hukupOSl0oLVgCaLNaAo4PGWEsIFef8TW1gheH30l3dPVDXsrGJewJ
         54jvPzeZeahiSIchx/t8R/K2uIXQU67rsmRMPuRD21ixMVsV4SwwQzRrxZNzkrKWE+JO
         D5kRIuv41fSaISbVebQumx6GC8hQJqNhkulv5qRXLGYjEE4ZWyG078qQtcIv98WImfzG
         k5H9Q1pmv6nr+Z1p5qM8gLZVSReaxY0He4QcdT/D4IeEObTukT2jErYODh0JUUPwBDkt
         +70A==
X-Forwarded-Encrypted: i=1; AJvYcCUj85H4SU8MC0tqNs02MhXFCPPhtmman0XkzgBEGeUaBmJn8yQVjlfeFmDIjyz8bfLzWASfXjSHHHSb8g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxe/GRIEL3i7bh4TpUO6tE7W1ViqkDk1IxbvpPcW3QwTqXu3Ni
	taKcix4XS0AOtg8+1+0l0iADtJxdBraPu0g+9izyKjYKtxrNp4sOKDaDAegb+dgtpDAc/S+9Cwl
	WyKrFgjd5efaCnuDXXyfSjt6RYg4lW24=
X-Gm-Gg: AZuq6aLiC9x+EqG7QIWWvrEm05Vxn52qSb/fn3eCM5HeRpBo0HPEQrfrbnISyqIun/g
	99RajM+XWEy00Z8RDGMh6si1Br3syul+LzkYyh3a8ulLHOhby+Has58nZqIbDdb0jaeg07dhZbz
	mVzrk/OLFdHM4Wej2y4GFDFGD6LEqmDN+rwVJebpPHtvlsDrqHWsVLRkMqEmh1GNXrtI2MeN9sr
	eToSu0ZpJt+3pyBXH51z5IUHCsA+gX7+KoRuMGteZyn6YFbtlEW+QH5hWDYZbKc/md9OND8GOXL
	juoSxCly
X-Received: by 2002:a05:6000:2502:b0:436:684:b94a with SMTP id
 ffacd0b85a97d-437978c9ecamr23859985f8f.4.1771338610325; Tue, 17 Feb 2026
 06:30:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260214180959.30714-1-clamor95@gmail.com> <20260214180959.30714-2-clamor95@gmail.com>
 <20260216-sprung-scallop-de7b64bf528c@spud> <CAPVz0n06+uLCSfY_bYS9v7KJ-hXotye7ej-rze6-Q8_JAF7XVA@mail.gmail.com>
 <20260216-plunder-defense-de11cf56dd3d@spud> <CAPVz0n0-LbTUZBCaO=oN3PpPLpwAqzNo29r687pKY8NbEE9giA@mail.gmail.com>
 <20260217-vowed-botany-b1c47c7e40b8@spud> <55C30023-4175-48F2-BCB0-12EC23C48F01@gmail.com>
 <1519143e-4fc3-490d-ab8d-e65edd2c4eec@kernel.org> <81844CC9-5355-4B1D-AEBD-6DD67FB8C81B@gmail.com>
 <20260217-dig-husked-8a59b6a19aee@spud>
In-Reply-To: <20260217-dig-husked-8a59b6a19aee@spud>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 17 Feb 2026 16:29:59 +0200
X-Gm-Features: AaiRm527JrR1d9ft4Dd7Ae54Z5WSVlmOfX8realrnvc6GC-L9yzztDY8UwpAN6o
Message-ID: <CAPVz0n0u7uhL8_FQFiuB7DrnL++ecbaEKEoV7N2PgTVRBVECkw@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] dt-bindings: embedded-controller: document ASUS
 Transformer EC
To: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 17 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 16:03 Cono=
r Dooley <conor@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, Feb 17, 2026 at 01:34:01PM +0200, Svyatoslav Ryhel wrote:
> >
> >
> > 17 =D0=BB=D1=8E=D1=82=D0=BE=D0=B3=D0=BE 2026=E2=80=AF=D1=80. 13:32:26 G=
MT+02:00, Krzysztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >On 17/02/2026 12:23, Svyatoslav Ryhel wrote:
> > >>>> in other words you propose this:
> > >>>>
> > >>>> properties:
> > >>>>   compatible:
> > >>>>     oneOf:
> > >>>>       - items:
> > >>>>           - enum:
> > >>>>               - asus,sl101-ec-dock
> > >>>>               - asus,tf101-ec-dock
> > >>>>               - asus,tf101g-ec-dock
> > >>>>               - asus,tf201-ec-dock
> > >>>>               - asus,tf300t-ec-dock
> > >>>>               - asus,tf300tg-ec-dock
> > >>>>               - asus,tf300tl-ec-dock
> > >>>>               - asus,tf700t-ec-dock
> > >>>>           - const: asus,transformer-ec-dock
> > >>>>
> > >>>>       - items:
> > >>>>           - enum:
> > >>>>               - asus,p1801-t-ec-pad
> > >>>>               - asus,tf201-ec-pad
> > >>>>               - asus,tf300t-ec-pad
> > >>>>               - asus,tf300tg-ec-pad
> > >>>>               - asus,tf300tl-ec-pad
> > >>>>               - asus,tf700t-ec-pad
> > >>>>               - asus,tf600t-ec-pad
> > >>>>               - asus,tf701t-ec-pad
> > >>>>           - const: asus,transformer-ec-pad
> > >>>>
> > >>>> And in the driver add match to every single entry of enums?
> > >>>
> > >>> No, I was talking about removing the generic compatibles entirely, =
since
> > >>> they are not suitably generic to cover all devices at the point of
> > >>> addition. So like:
> > >>>
> > >>
> > >> Actually, they all can be grouped under asus,transformer-ec fallback=
 if that is needed, both pad and dock EC have the same core functions just =
different set of cells. And then in the driver each compatible will get a d=
edicated matching data. Will this work?
> > >
> > >Then what does the generic compatible express if it is not used by the=
 SW.
> > >
> > >Wrap your emails to mailing list style.
> > >
> > >>
> > >> properties:
> > >>   compatible:
> > >>       - items:
> > >>           - enum:
> > >>               - asus,p1801-t-ec-pad
> > >>               - asus,sl101-ec-dock
> > >>               - asus,tf101-ec-dock
> > >>               - asus,tf101g-ec-dock
> > >>               - asus,tf201-ec-dock
> > >>               - asus,tf201-ec-pad
> > >>               - asus,tf300t-ec-dock
> > >>               - asus,tf300t-ec-pad
> > >>               - asus,tf300tg-ec-dock
> > >>               - asus,tf300tg-ec-pad
> > >>               - asus,tf300tl-ec-dock
> > >>               - asus,tf300tl-ec-pad
> > >>               - asus,tf700t-ec-dock
> > >>               - asus,tf700t-ec-pad
> > >>               - asus,tf600t-ec-pad
> > >>               - asus,tf701t-ec-pad
> > >>           - const: asus,transformer-ec
> > >>
> > >> And them schema name will match the genetic compatible.
> > >
> > >Then what does the generic compatible express?
> > >
> >
> > Then enum it is
>
>
> Why would you do that, instead of what I posted earlier in the thread?
> If you send a flat enum with all devices listed, I'm gonna just be there
> telling you to consolidate into one device-specific fallback compatible
> per programming model.

There is no one device-specific fallback compatible! Schema describes
HARDWARE not drivers no? I will not use random device compatible from
the list as a fallback compatible for a different random unrelated
device, that is plain wrong. Discuss this with Krzysztof and come up
with something meaningful please.
