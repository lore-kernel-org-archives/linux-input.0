Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E3A34107D
	for <linux-input@vger.kernel.org>; Tue, 10 Feb 2026 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770716545; cv=pass; b=uLTsEBYHC9qcCYjJOwe3/U/5RZ5P1rWpBgc1gHNjzP488Cg9in1tAEP3ZuzPFWNJFcL5NdCF1LChNlhHxy4Twm/4OTLHzCjGMI+RN5vJIWN2RJ1GuHitNURLxllZuw1E6lWpBhz7/Pwd6hskc2VsJhtmWpNIsg1MJX6as7szrwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770716545; c=relaxed/simple;
	bh=oOjICXJg7ZpifL4ZDE4Mvkawuzo2HaLZVgTlYB0pvHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pTfkByzXY9WP+Qv7XkmaxLqLns2+2bv5q4yVJ4mczIhRGJ/MUUh+XCiXfwIsaAJkeXXfO3Yai5xvD4C8siECXsClxmInhpAiCz3i/fHHZnaLqUktKDTejAHOv267CjF+BQ/u7N6k/dfsGC3oFUrmOup7GraniE6m/O4WxNo4ing=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZwFvb4z; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZwFvb4z"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-436317c80f7so1804993f8f.1
        for <linux-input@vger.kernel.org>; Tue, 10 Feb 2026 01:42:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770716543; cv=none;
        d=google.com; s=arc-20240605;
        b=fy/oAlvVwrvORiAWI8krCh8hCaI77Ee7Umo/uqvc/Bf7BYqeY+73RF4c5brKE4gTCK
         0Wd6O/wjwUkeNVaUla+uUHgSA/neXGI+Fyl3NsJ/cFYcm+E1ybJXFB23caDvbVp7jLO+
         JpTq5fEkyPjZ9rLCIScKpOolJQpAUrqabdA9TSpk1mrVjDLI7oGQCsurOuKqpJBoMmNi
         LIIwn/UpojslQqJMWHpDLWHnotmVcddWs6BUqZ8gKfgKL6cSdhpdDZlaRxeSeGqNqM6A
         PBDpVn8CwbSBmm7qWp+U8Q98RjjZCZbCgZVXalI3q67g6j3vc7YWkgKFJrfSpXHbI+kV
         rOJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ze1c4tMfcpX491+6mPiJXsJlYkup8lMt/xtrcGpqjuI=;
        fh=zD9wT/RHDUvdlwxC69u1NNKZzRaRPZd5hl6qYSm1CgI=;
        b=ZDjfxIkYr6FZH6QkppCKMFVacN0aT6EqtfnIfk2yj+skC8t25zJ2LToyWQ6/oehGca
         bBO3JO4pj9IKp7cOxt1kAdO1GEGBmkjl+tSCzFSZHt/PvowyYvlaa4kWQYtZxiwkROp0
         JigvueXA+xh6SzJ/kycJMnVI5y/Jdt4Kj9MgsgvDTd00HuW1IiViMarMW3XyU1eHiQq8
         ZMzcK1dFJd39rrCC90G/Y+Syfuk2pI83Jc9l7zu4WzWJFPfurBn1zb0KNYWNN42ZKMSG
         iD9tlxDGLmLyu2Yeeh6w+301ZkL8k7vRlD6ElavZTSvMjblWhRTPOWAyDM6HVg40Hr3U
         1PLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770716543; x=1771321343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ze1c4tMfcpX491+6mPiJXsJlYkup8lMt/xtrcGpqjuI=;
        b=MZwFvb4zWxnfekjl+a8fsLfYtrscT0ebMy+djosDK9zMn1NLXNNuNkeJQ+YZDUZQSh
         tcLsWoxPOHXM5b/VVpDIbtS9/eMQysU7DEuHttnRlEIfhi72G94wQcIDA7I3fwtUs6rj
         nteoasqj8yMgzfcoesAhg58ZN4/uNGulmZC/d67iSwERAp7Mt+Jkxa2JWURr4iEkYGFy
         oWBK9pnh/KpCD9NvHu7tDrSq5ISoB9FqNFpd0X2E75oWHDjPuoLdvUe22FRymBGnvtBr
         cQthSGiuHgb/OH0zZ5bRLvrG3MUTNNcN1zPQOw4y/lRDOibeI+JZU3YRdmS7oBTm9slr
         OHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770716543; x=1771321343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ze1c4tMfcpX491+6mPiJXsJlYkup8lMt/xtrcGpqjuI=;
        b=PuU61kna30HaeeysH3fa37x/rV+h2N2JDn4XwRJzk493Il8l3D0cqyTUeegrZ1P3Rl
         SoLWa7YSKm3TM1LxROANcd0QciPt8g837DYi27Ts3hacXpgIrusjUePDTdfjBsqQLi6G
         Sq+V+H8/rL0whDUEH7YfGsZsCu3k710vo0GHPznEVFcbp6/oR2JnPFe1gr7aVutlb25J
         i1wZvBx8+9JGyQXsyjG1fAMzsxb/Eh4E3R2eJ7RLUQCPdKH70yKiCTUOjimtDiWNo3YF
         v4UYL1MdH+ONDu/9CKYy2N+1zuLyu++unaQrNlRwyqwkUI7CyT4XWEy1nIjH1ekosoxl
         SvXw==
X-Forwarded-Encrypted: i=1; AJvYcCVWvrEGS2qtGfU+wmXTY5AuM2yVEFg13EyXaU8OwFeaq0ChrsUkmlkeWQVZkM5R/UWhqa9L2IeVzkq3BA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwExgLkjaVuscKVKN2MCIZT14NLpXoFg4bOE6Pr6Fzd4zyS10Mj
	aR16a1UwNWN168FoKahas1L0nMS48xmMFLKuyMSPID+uEvvqUV+GqocQ1xGtp9OkvDcDYeJ0mHL
	2LaSmT0Jv5Pw9eVB+t+9gnM46AbM+OXo=
X-Gm-Gg: AZuq6aJnr3OyNwW6CR0aN19zeysc5f1F3stA5Kfk+Qx130ptkhkTBOcYJE0f3vTESKf
	6qOf0BskxDkhkcDwKTmZdaglyOrPt5JQw0Yl/1OekXwxLjRj2YtCo/uLdj8T78uoIN8UJw4V14v
	k+7E2+h5l7QUwjAF+uqIh5H72Ry467Y9kXaj3lohfxokW61934LokwWy/Gy/JpKl9dDf0GCToxL
	ABrpm7agoRBrPGlJmN3/2EDTWx7THMHBDCA6//n29PRFft8vVmRQ76zCc8ABClmogtp16U4Ue4n
	ym4hmFh1
X-Received: by 2002:a05:6000:3111:b0:435:db9b:5881 with SMTP id
 ffacd0b85a97d-4377a1f2a30mr2055191f8f.25.1770716542552; Tue, 10 Feb 2026
 01:42:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209104407.116426-1-clamor95@gmail.com> <20260209104407.116426-2-clamor95@gmail.com>
 <20260210-hidden-swinging-galago-fdcfa3@quoll>
In-Reply-To: <20260210-hidden-swinging-galago-fdcfa3@quoll>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 10 Feb 2026 11:42:11 +0200
X-Gm-Features: AZwV_Qhn-R0xjZTEGY6wy39uV3chiY2pUKepim55rxxDwQzXQ4tGrjUlByAc-JY
Message-ID: <CAPVz0n3Pzvzt+LmOH_peCtpx8DP2-GiRv--6-ppQUaa51AXRFw@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: misc: document ASUS Transformers EC DockRAM
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sebastian Reichel <sre@kernel.org>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Ion Agorria <ion@agorria.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 10 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 11:25 Krzy=
sztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Feb 09, 2026 at 12:43:59PM +0200, Svyatoslav Ryhel wrote:
> > Documenting an I2C device used in conjunction with the EC on ASUS
> > Transformers. The main function of DockRAM (the name used by downstream
> > ASUS sources) is to provide power-related functions, such as battery an=
d
> > charger communication. The device is exposed as an individual entity
> > because multiple embedded controllers can utilize the same DockRAM
> > instance.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../bindings/misc/asus,dockram.yaml           | 40 +++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/asus,dockram=
.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/misc/asus,dockram.yaml b=
/Documentation/devicetree/bindings/misc/asus,dockram.yaml
> > new file mode 100644
> > index 000000000000..0cfde619ba01
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/asus,dockram.yaml
>
> Not a misc device. Find appropriate place, e.g. for EC or docking or
> laptop devices or power-related.
>

Why not misc? be more specific pls where you want it to be.

> > @@ -0,0 +1,40 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/misc/asus,dockram.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Asus Transformer EC DockRAM
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +
> > +description:
> > +  Dedicated i2c device used to provide power related functions of the
> > +  embedded controller used in ASUS Transformer device family.
> > +
> > +properties:
> > +  compatible:
> > +    const: asus,dockram
>
> Way too generic compatible. You are not documenting here all ASUS
> laptops/devices dockram. For example this implies dockram is also on
> ASUS Vivobook... or on any other asus device.
>

Asus were not so generous to provide more specific data, they call
this device dockram in their sources.

> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
>
> Device looks weirdly empty. Probably you have it only to instantiate I2C
> handle, so what you really wanted is i2c-parent. This is not a real
> device.
>

WDYM? it is a real physical i2c device located on a i2c bus and probed
by i2c driver just fine. Maybe you will deny RTC being a real device
like it was done for example for max77663 which now causes a massive
issues since it can occupy different i2c addresses?

> Best regards,
> Krzysztof
>
