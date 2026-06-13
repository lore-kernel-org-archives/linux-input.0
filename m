Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CB93B2FCC
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 09:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781343505; cv=none; b=dXGQxm3EDe5ex7DLNrduyQvz1Ggh96N+Eg/hABKGQ+M9KBt74gRtfAiafDRtfzXyn1Zzg2FRlfsXOWSf/b/Rn5ElWkBwrWXu1lBpuFwFv0sC9wdRLfl+Tl1MAUpXMlxDcngmk8J2tAuw40dOFxeUk/yDoFg06vgIBUpubapL90U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781343505; c=relaxed/simple;
	bh=1sX3QYXGeCW+Lv5W+F5sZN6MOeOyiU6kXOMbPlP1lIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AHdus8rstcCqhAmo0zw33NE731gfx0+2/vr4oRZ/HZdZd9RcnM35cIGsNbFuRIFWAsvPC/48Hw9PamEE9WRe6mRmhna65HgUlrLfwO/PClijfdZNTLSVKvdGHrEp8TAquq5otCr6lCDDTq9J+YLJWE06ikAp/yXnQk7o3k3Jr/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxEk5yFF; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxEk5yFF"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45eee266c6cso1528046f8f.1
        for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 02:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781343500; x=1781948300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSPcHOrJhwoZ6fKHrLRI2q23k/nKTvAXHvk0RF9YXD0=;
        b=HxEk5yFFIHCL60zi4VZHltwsAt+3NMC9sn6fTSLyrnV0uPjMZ4SR0x0HOibXXqKiv3
         BNKk235u+0aihneFdDNunIHGXe4yUKx6eqY9gTKmRpqXmEnyAI1b2VoK9mLrp0W9ZN+D
         9bOOTNPZbIYyZnMV7te/p2A98cVQh6akK5eK+6v0YqIrLExJojsynl6qm2XToUF0aMTu
         B001eorNLnxHZunY3yMVaZRqfQYz/mlQpc3R/B4kAt0Gly13hzOoE0m1rd3/e8EXHlYG
         123R9VC8loM3hDbZKanz17ckf33YirB0hX9w4jcPDAx2xrAtayZJP/sCxvrnpVl7R/Et
         2I9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781343500; x=1781948300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hSPcHOrJhwoZ6fKHrLRI2q23k/nKTvAXHvk0RF9YXD0=;
        b=UAURusHK9F8AEvnVajCQj91P3DW0YtU0cR1vQBaFn3AkCe1oLxAgc4aRWvTlEgh+xB
         zOO54rmD57AOrjay0A4H2lJKOQNIQnXHgLbveO3F5ya4RnqQdkzBHxyXPXlqYAE12YGP
         M9j7kfhk3EYsitHphUDcCh7vFQtv6HMvtMH6o6Figi69S0xODBS3cupWGiUfuTFAHJVQ
         JVJ/P3s2fJSQVj/wP3jempEcRDBXGoPYteuut6IHJDU4zJCRFVq13Qf9M/80f/SJAs9r
         VqOf4bIEudHcaiv/4Hc3Qn76qffFpdQxKFCxu/+wLfmKMnl/3E1ItW961hW1m90SXwEm
         PEcg==
X-Forwarded-Encrypted: i=1; AFNElJ+V7wOK/h0ONHnP4wIX4q3qQGRvkdKxHgMEbum3dKafTycY7HvSTQAr4Lhu5dlUSU8BlrHbs3Wue1270w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMfxgisprr5IZrryqOkbZTFKbx9wmmvFKzcwRX8hgBQFF58Llk
	4q9UDK/9bBPKxfwgYV7aSTtu2QUXsYGWzNIfYbpww0lbpNIe3gCwIfBi
X-Gm-Gg: Acq92OEjmCVvAs8DPgLq8SJLMu5MicHhfRlaGlvd0i9kDaZggwEQArBrWotaYyaaOHV
	1xwiHXDhOZ0BaLQ6y/z/zxox8S01sQzu0zBqp9+UK+Y2U4aqL3/in4t34WKHpcunGtJhrqn1lzX
	9Knbi3R7iPm4xtg9xJb081haDRmPxuiZ0e7ws4nkUVBFe09i71LJ62rVd/O5tNsivtL0qswhSFI
	EGmjqdQTd6OnDx89Tj610TXHmfwNlUkHbrM2odWqW9b0us0gXmimrTMoj8aIQQO/+llvvgceJn0
	P8fvkKwtUG8/IW3FOmL+OJNvEFT8/YrFOd98ihH71pfaAU//va9Dpregwh1KYD0Vb4x5xN8SOs3
	U0lsX2tQ89kIEFo/HuPTi+McHrUwDzqI9LwdVsgsn4l/xPywsafp/D4pjI4TtWG2e5ORFtVPH92
	BpZ5Ejo1EGtOGWFcvCXqXzcxE4KQKP+gBImWRLE6lA5Hoj
X-Received: by 2002:a05:6000:2684:b0:45e:f228:830d with SMTP id ffacd0b85a97d-46077d40be6mr3398045f8f.23.1781343500099;
        Sat, 13 Jun 2026 02:38:20 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2e592csm14464581f8f.36.2026.06.13.02.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 02:38:19 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Hans de Goede <hansg@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Jun Yan <jerrysteve1101@gmail.com>,
 Lukas Schmid <lukas.schmid@netcube.li>,
 =?UTF-8?B?Si4gTmV1c2Now6RmZXI=?= <j.ne@posteo.net>,
 Eric Biggers <ebiggers@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Luca Weiss <luca@lucaweiss.eu>, Sven Peter <sven@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v4 6/7] arm64: dts: allwinner: a100: reserve RAM for ATF
Date: Sat, 13 Jun 2026 11:38:17 +0200
Message-ID: <FE7Vh4yfTmGMM24i18Wwwg@gmail.com>
In-Reply-To: <b428d57ba5464f1226daf099877f4c25fa4fc191.camel@gmail.com>
References:
 <20260605070923.3045073-1-alexander.sverdlin@gmail.com>
 <_6NEZ78hR8a_3V2bhBAGoQ@gmail.com>
 <b428d57ba5464f1226daf099877f4c25fa4fc191.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne sobota, 13. junij 2026 ob 10:34:42 Srednjeevropski poletni =C4=8Das je =
Alexander Sverdlin napisal(a):
> Hi Jernej,
>=20
> On Sat, 2026-06-13 at 10:22 +0200, Jernej =C5=A0krabec wrote:
> > Dne petek, 5. junij 2026 ob 09:09:20 Srednjeevropski poletni =C4=8Das j=
e Alexander Sverdlin napisal(a):
> > > Add reserved-memory node carving out Trusted Firmware-A region spanni=
ng
> > > fixed 256K from physical address 0x40000000. Even though Allwinner ATF
> > > itself passes the address range in the fdt to U-Boot, U-Boot currently
> > > only reserves this memory internally, but doesn't carve out the region
> > > in the fdt passed to Linux.
> > >=20
> > > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> >=20
> > NAK. It is job of boot procedure to properly inject TF-A reserved node.
> > Any issue should be fixed there.
>=20
>=20
> like in commit 0d17c865118881609ea7e381c7cadbb7979cc596
> ("arm64: dts: allwinner: Add Allwinner H616 .dtsi file")
>     Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>=20
> ? ;-)

I was against that too.

It's time to be fixed in bootloader.

Best regards,
Jernej

>=20
> > Best regards,
> > Jernej Skrabec
> >=20
> > > ---
> > > Changelog:
> > > v4:
> > > - new patch
> > >=20
> > >   arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi | 16 ++++++++++++++++
> > >   1 file changed, 16 insertions(+)
> > >=20
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/ar=
m64/boot/dts/allwinner/sun50i-a100.dtsi
> > > index 7cb06b19b5a5..d8391663fd1d 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> > > @@ -87,6 +87,22 @@ osc32k: osc32k-clk {
> > >   		#clock-cells =3D <0>;
> > >   	};
> > >  =20
> > > +	reserved-memory {
> > > +		#address-cells =3D <2>;
> > > +		#size-cells =3D <2>;
> > > +		ranges;
> > > +
> > > +		/*
> > > +		 * 256 KiB reserved for Trusted Firmware-A (BL31).
> > > +		 * This is added by BL31 itself, but some bootloaders fail
> > > +		 * to propagate this into the DTB handed to kernels.
> > > +		 */
> > > +		secmon@40000000 {
> > > +			reg =3D <0x0 0x40000000 0x0 0x40000>;
> > > +			no-map;
> > > +		};
> > > +	};
> > > +
> > >   	timer {
> > >   		compatible =3D "arm,armv8-timer";
> > >   		interrupts =3D <GIC_PPI 13
>=20
>=20




