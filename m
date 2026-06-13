Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A063750DB
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 08:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781339686; cv=none; b=BswtuRKc4cBnDWNUI4Jl8oWJA/YLWhyKG/CXP1Sl1T6BUCNB7XoaD8zeaha1v1aWP0pfgRj3dfNRH/mF4j0H8V+seYeE2bFu/q6/TZXvioI5pyGZOyuMFXMjbkNRoVr7eY+j94IDjtek2f33ZCmUzviHKgHAWDuzXtliP2INiMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781339686; c=relaxed/simple;
	bh=mbzvuH7IfNDrZaVdLFw9eoGGYP0QvKcW4I7S/aIG17k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OBKceRgwEHFvpeEx6Vr3hdLORRh5lqH59YIRy1ZpmXa6nkNNg9RnGbMNj8uhz1cujppGLEGRaKNIl6Ojb9MgTOX2LkvnTDxjD+MFCPG5AH94DMWvdgL346Em4F5GbLkzjw2KXztyZ5//MIkVyoBUooy9Xj6ye8Ann8CbtxMhRFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esJ79rNN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esJ79rNN"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so17609995e9.1
        for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 01:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781339683; x=1781944483; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QHs9yK5AtFf0IN6y8bIIPCYpjsJCXaUVqV8EKE6IMM0=;
        b=esJ79rNNH2ER9YupQNbJi/a213ecb+1NnOJRa8wyWgjynGc9PsQF7C74n+yAJM0WkV
         gOPCHP57sN3QbTZR93uALsBLWorCupX0a/gQzEKqDKl9WwY1N1xnKgEt5pE2v1ZOfK7s
         ZIoPY7YT6QjO0U+dbeNAZwbejPk3qmO/M54j/kJ2RQ7VGF/jfnaI1szSebi6yvPXwYrg
         jby2yuv/8gr2ay+Umv5iUjgMEBRDSlUtNork97vtkR5+a289GYk7HsvH3wQ50rh10qmK
         x+OGdxJtRlv8AFsssCbzOFByMA0nhbPRcd0uTw5ZBAODxRojpKFddObnGnpBSNHhN5dG
         hdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781339683; x=1781944483;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QHs9yK5AtFf0IN6y8bIIPCYpjsJCXaUVqV8EKE6IMM0=;
        b=r0lb6BTM/x9ASAjxV8m7dN8G4ULXnCWvC5yTNMDN27fEI4MPJ3QAB9PLLSrVv3Gdlj
         g7ILwmu2dLpi0/+/1GkLbK9Lk2+X8Zp8LUnJ00pbwKXM5ZmKUQrRVR7K0EtueRgIs7+2
         VuRvEwjUpRsgPjDGB46OZ/dRiCFgzIpH6fDCEjwCmK0Nt7jFuEFqCC7YQ6ntpjW5Qd0t
         XALHufmrmX+91Z/AFxYN/lDrVKaWTMuhphGo65CCLayM14LU3pX1Vrt2Copky2MbqN4K
         mNslsgXfg9XIst8nnKiEXh0xvsBSg6So/T/gb5z79lm0UpeB7L4ZToIeLmiYXs3PaEz+
         ZXZw==
X-Forwarded-Encrypted: i=1; AFNElJ/WYt+/N5O7eVIP+VQSIvA4lrGV0vCHcF5S4rrVAqASpACqINrmwnlY5BlyZ2wulQXAKn5uMNqDMzF8CQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YywQIxShnZK5F+qEUxcekNvQWZ6dzO/y5Q/LN3Bd/msjszQVivc
	UUj1W4dY5hKxmPB/mtI/qjbNa7xlHEY/6GSalLeRUXbpAPvmVQ9nNht9
X-Gm-Gg: Acq92OFhRFd7dg1gy1xB1NIbeHjb6F19/jrDxtuAP0TGR33lgUXIXRCLn5kpC3176fl
	zgqTIceLhhmkHdvScrAA/2Rp7KR+GsMG/DNm/0NLoZYOAbzNJLNEiY6RAprK0AHMOLWABukpGKP
	Gq54d3ZmMgBm0NLdG8fMuqK5dIt19H7qSJF8KzTESZmVYa81sszwrrHF7rTEnBCsslgqsFt9F1j
	XN2Fa7wKmYou9L58U+csj+Hmm0l63F/CiYuZh0tNte5EqI3Nxs7iny6IHhB0o6Dnxcef7NI+E3Q
	E+ivFPiLh6BBWLNHG043y1SlfEvc+kPL1f6BsavBCdsURqnNjB1UgGHU3dGApvA08+Vklt8CwtD
	2+zr59X89qWClIWFGVujDikHezl6Pq9LM8FwJxUtQQ9Ij6896Av5B0DnjwmU4uU6XkqgRBdY0nd
	uVL1U3AAqCQ9knVoxZmBwC5wUzz/0jl4SaIMczm3RNWJqMlWz42tO5lPNiTeU1nEx3JLUrAoTb6
	EL8OJfFdK4jvafbSw==
X-Received: by 2002:a05:600d:8494:10b0:490:c7dd:de3e with SMTP id 5b1f17b1804b1-490ec521187mr55836955e9.31.1781339683115;
        Sat, 13 Jun 2026 01:34:43 -0700 (PDT)
Received: from 0.1.2.1.2.0.a.2.dynamic.cust.swisscom.net ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492203d05d1sm72320885e9.12.2026.06.13.01.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 01:34:42 -0700 (PDT)
Message-ID: <b428d57ba5464f1226daf099877f4c25fa4fc191.camel@gmail.com>
Subject: Re: [PATCH v4 6/7] arm64: dts: allwinner: a100: reserve RAM for ATF
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Jernej =?UTF-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, Samuel
 Holland <samuel@sholland.org>,  Hans de Goede <hansg@kernel.org>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, Andre Przywara	
 <andre.przywara@arm.com>, Jun Yan <jerrysteve1101@gmail.com>, Lukas Schmid	
 <lukas.schmid@netcube.li>, "J." =?ISO-8859-1?Q?Neusch=E4fer?=
 <j.ne@posteo.net>,  Eric Biggers <ebiggers@kernel.org>, Michal Simek
 <michal.simek@amd.com>, Luca Weiss <luca@lucaweiss.eu>,  Sven Peter
 <sven@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org
Date: Sat, 13 Jun 2026 10:34:42 +0200
In-Reply-To: <_6NEZ78hR8a_3V2bhBAGoQ@gmail.com>
References: <20260605070923.3045073-1-alexander.sverdlin@gmail.com>
	 <20260605070923.3045073-7-alexander.sverdlin@gmail.com>
	 <_6NEZ78hR8a_3V2bhBAGoQ@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jernej,

On Sat, 2026-06-13 at 10:22 +0200, Jernej =C5=A0krabec wrote:
> Dne petek, 5. junij 2026 ob 09:09:20 Srednjeevropski poletni =C4=8Das je =
Alexander Sverdlin napisal(a):
> > Add reserved-memory node carving out Trusted Firmware-A region spanning
> > fixed 256K from physical address 0x40000000. Even though Allwinner ATF
> > itself passes the address range in the fdt to U-Boot, U-Boot currently
> > only reserves this memory internally, but doesn't carve out the region
> > in the fdt passed to Linux.
> >=20
> > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
>=20
> NAK. It is job of boot procedure to properly inject TF-A reserved node.
> Any issue should be fixed there.


like in commit 0d17c865118881609ea7e381c7cadbb7979cc596
("arm64: dts: allwinner: Add Allwinner H616 .dtsi file")
    Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

? ;-)

> Best regards,
> Jernej Skrabec
>=20
> > ---
> > Changelog:
> > v4:
> > - new patch
> >=20
> > =C2=A0 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi | 16 ++++++++++++=
++++
> > =C2=A0 1 file changed, 16 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm6=
4/boot/dts/allwinner/sun50i-a100.dtsi
> > index 7cb06b19b5a5..d8391663fd1d 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> > @@ -87,6 +87,22 @@ osc32k: osc32k-clk {
> > =C2=A0=C2=A0		#clock-cells =3D <0>;
> > =C2=A0=C2=A0	};
> > =C2=A0=20
> > +	reserved-memory {
> > +		#address-cells =3D <2>;
> > +		#size-cells =3D <2>;
> > +		ranges;
> > +
> > +		/*
> > +		 * 256 KiB reserved for Trusted Firmware-A (BL31).
> > +		 * This is added by BL31 itself, but some bootloaders fail
> > +		 * to propagate this into the DTB handed to kernels.
> > +		 */
> > +		secmon@40000000 {
> > +			reg =3D <0x0 0x40000000 0x0 0x40000>;
> > +			no-map;
> > +		};
> > +	};
> > +
> > =C2=A0=C2=A0	timer {
> > =C2=A0=C2=A0		compatible =3D "arm,armv8-timer";
> > =C2=A0=C2=A0		interrupts =3D <GIC_PPI 13

--=20
Alexander Sverdlin.
