Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435159;
	b=Nuq69UOVfXUkZwsyJodMkCAiEpIKiu7U/725nhlWP/7xQfn3c2PJ6QKXD6oJ8gAsaJLO
	 0nIuq6hce0EeNIe9DBTcI1V6rs3A/0ghFwp1Wqrf8xoIRfb6395gAAjuhGh51vfWFQbsF
	 06gu2P/xidPujvcvjGqDtWDH1vxhBdcZKV3UsoifprEJP07Rtj99H0hkfCVCOEekeSeWS
	 t3OHDaHEhmVkmXlK8HM6YAOCH76DRHTY1tpplfyM9tY3x+dfdUVMSLhxD2do2Gjr0t6QS
	 /VPvLH8pq5nA2aue4L6KgW/wRMx1z9cClPL9bq5vJrr16Hsby7ADEEEiOQ6sJ39v+Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=1jrfyM8AKRsXsQr/mDzcRHfpMeGCqxxnp8QiMrGkGyA=;
	b=LJ/NRc8qrKEa3VM7XOWZQddCV4GVucpQ2nMnUwR/L+BZLwtCoVDhUOPMN/LHaaXhD/mv
	 sTTSCWeffWnZAgPSw1k49ICqsGF11YGaysGPa0KXyI8thEzbxZpZisbYqb3+6Lu/YcCYG
	 Cl3g27IIzV7HHPB2/aEtCqV4YMZR1XS+QdCmcnlQ33xpUZo6JUaJgKC2VsmzpA2wHgoh7
	 3I4eY00sujfSDzem4MGQbiXSRT9Vkrd4Tkx3qAhxk7DOf+Lc1BkDlESY9RkEfpJTxTCij
	 c9m0Jp6HpkkiKlgPraCeTrTsdUSxX400JSSqkwUeyRFTM2XEE/JqMxf0+ShmzLMPK2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nnv4Ewzs;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2623C606A31F
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 11:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2623C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nnv4Ewzs
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c5133831027so450737366b.2
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 03:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795435157; x=1796039957; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1jrfyM8AKRsXsQr/mDzcRHfpMeGCqxxnp8QiMrGkGyA=;
        b=Nnv4Ewzsl0zbK9WqomGclwh/k39KgQeQgXBNc/AzfBbUyum1Jwvd/YbXnXg9n29OEj
         K9Ij0DC8CzyeIq0tVeeaApk4UfsTam5BGxnvw6s/ZKMk3jvL2FWONroxYavWmgOtsFl/
         pCH33OTHEcBp5Asq6l2vD3q6q2VMRCWAkBXRC3EjS07hdKBCdtwczs0pFbPIeKRuIxID
         xUNzibHvqo+wSbbF6Xz8MLTQWy4Q05WSCpzEyqo7+RmGC8MEsJ5zTaYWtaSTJqfEMPJ+
         ja4H8aB9k1bYTHo3T4iVJsVZEdnn8ZEPeUwM/HyD1ISEGSLI8D0lV/EVTsvmkC8x4VQw
         QwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795435157; x=1796039957;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1jrfyM8AKRsXsQr/mDzcRHfpMeGCqxxnp8QiMrGkGyA=;
        b=Z9DIsgm2OfraclGFGVMa89maUZ9c29Z/xSsxG/7diZhAgJfyfw4ZpAkTfKU44bdXy1
         J5T6vWv8mmNZOek+A5Tvg3bC4gGaPWlpmDfV+rGAeFpwG5Ra2tfboQ12raHEW3NJ0YrW
         GeEWusLvDA4kDoPJ5ebrX+24wBQYYRTetr5M1vkqiU1CQLXk0LSz7JmPFv/lRP4efBNi
         9dGqEky0s5ABxMdNTWRJ/vbls9lV+o6dXWi8nkGiKxV9ZDqNIBCt9Osx4QrwL8LBy81a
         sQ7805rPLgJOOCqR29A3LgiI5Ty9j6g/WSi2HpYmSVVlha1unZd3m6ND0KwJXaDFoyns
         cykg==
X-Forwarded-Encrypted: i=1; AL+hErH9+PD/HecTUQJ7YRpGE4U7bMNWn1RQjWpFllp/ZC6jjNA94jA11tbQx7gzztb2jJPnw2pwDHiRIAq4IQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+f4GiO9VTlObb8GBC0I4xJFuCmQV03/Q8l+OF4iO7NVaj5pQBO
	dnAg22y8n7oCrmI2g9oYBhlOhpYHnfv7iTRA+zSgIvUDKbG0KJhUolA+
X-Gm-Gg: AZFdTZfMO4glJcQTkYxbI4axXB2BMyd+r6uYojmsrx0lH4CHEE7SOR6xkzrrdhc+k5o
	KLqWugM98gGH+pUwjmbqkCNelYoUCjDpk2C5wFB1Js3DmnvNuusUnDCmWwmv7gmSNoCxKeWB+6z
	RGtR4atwff11/UdKUj61Qz/g7K3bAgskqhHsO74EMSXXWIfsbbPWLpD515qORxEXWmYcNZs5T9M
	BCiUSaYYGHMgCGirVxSdpY5exHU3rtnLrzXgiMbprVsa5xzc+2lFtmI3aJiwHZLemIiUehdwiL6
	KyskG4XO9KRaLUaRPTpyLkphw6jtRCbJVw58ZYPFQeVE+To6vXuNAlgSdFFoiMjkibzBambeUDi
	cbFa9zz4Aj2A/KO98jM4uCg5GJYDhilWf9vxzwYsN1vZlaQvdxbXApDlZlWhQpjH0+tpcKDdrrT
	ZqarX7kMJH2wgjymy8JhQiYF2sG35GT42li1lpXMU6MZKnop2S7h6AU2zerBSd9DtKm8FLuuqr9
	KDCnBwgQYp+bLOUeEbPASSwOuzxBD1QKvqzosUHTsPTNAbCuEj/mwmmYh2yjHpe/bn+Qzz1p8tr
	XKC/pBaz07WEcnWzcwstDLG+5BmMQbthJFn5UX/LURDhKkKR9kTBDneA
X-Received: by 2002:a17:907:9306:b0:c3e:e677:5608 with SMTP id a640c23a62f3a-c513a5da8d0mr870341966b.12.1795435157410;
        Mon, 23 Nov 2026 03:59:17 -0800 (PST)
Received: from localhost ([50.7.123.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae68a9asm395946466b.30.2026.11.23.03.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 03:59:17 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 14:59:13 +0300
Message-Id: <DN2KN6PFHOXG.1EWK1XUHY7IKK@gmail.com>
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno"
 <angelogioacchino.delregno@collabora.com>, "Sean Wang"
 <sean.wang@mediatek.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Jiri Slaby" <jirislaby@kernel.org>, "Daniel
 Lezcano" <daniel.lezcano@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>,
 "Mattijs Korpershoek" <mkorpershoek@kernel.org>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, "Kees Cook" <kees@kernel.org>, "Tony Luck"
 <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, <linux-serial@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <phone-devel@vger.kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>, "Conor Dooley"
 <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 0/7] arm64: mediatek: Add initial MT6895 and Xiaomi
 Poco X4 GT support
From: "Alexander Letuchiy" <asalde.le1@gmail.com>
To: "Roman Vivchar" <rva333@protonmail.com>, "Alexander Letuchiy"
 <asalde.le1@gmail.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com>
 <ckJZtdZ4-fPzsa3vkozNyEYYUbG9qd134hYb0hHEuq2nL8WMAR1PS87OpDfXrkU-E-85rsG1I4V99_M41j6-ewkD_41XPguDel3z8z0lmMk=@protonmail.com>
In-Reply-To: <ckJZtdZ4-fPzsa3vkozNyEYYUbG9qd134hYb0hHEuq2nL8WMAR1PS87OpDfXrkU-E-85rsG1I4V99_M41j6-ewkD_41XPguDel3z8z0lmMk=@protonmail.com>

Hi Roman,

On Mon Nov 23, 2026 at 2:41 PM MSK, Roman Vivchar wrote:
> > Bootloader dependency
> > ---------------------
> > This was tested with a modified LK bootloader that is not public.
>=20
> How are other xaga users supposed to boot the kernel? You might want to
> port uniLoader instead, or if you're on an old enough security patch you
> can even replace stock LK with U-Boot. U-Boot chainloading is also
> possible.

Right now I am replacing the stock LK with a modified one that knows
how to handle mainline DTs without expecting downstream Android nodes.

In an ideal world, I would like to replace LK directly with U-Boot as
you suggested, though U-Boot chainloading or uniLoader are also valid
options. Luckily, the security patch level isn't really a concern here =E2=
=80=94
xaga is already EOL and hasn't received official firmware updates for a
while, so LK replacement works across the final stock builds. I
definitely plan to look into a proper open bootloader setup for other
users in the future.

> > Firmware behaviour
> > ------------------
> > Two things in the stock TF-A affect what the DT describes, but not the
> > DT itself:
> >=20
> >  - TF-A rejects CPU_SUSPEND for about the first 40 seconds after boot.
> >    The vendor kernel lifts this earlier with a SiP call, so with this
> >    series the idle states only start to be used after that time.
>=20
> It might be worth porting upstream TF-A too.

Agreed, upstreaming TF-A support for MT6895 is also something I plan to
look into eventually, which would let us drop the reliance on the stock
TF-A quirks altogether.

Best regards,
Alexander
