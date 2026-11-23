Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795434097;
	b=qXGFKQu6Ax2wmNpyEmA2EHRmOJJnOYCsLs2Yj1pub0iMzkLtY/ySF0r8VeZBAOaDcxkC
	 t2ITXz8R8VltH0s+xb10dJMjRjTjdKjwCyiWqlFRxlCyL51giF2veuE2cp12zaP/7caLR
	 sSLbOL7MGAFpzzdqY17nttyNyaZhkCFM2QZlTz03RO764gxU173uB9+XFi2z4VxPHl0YK
	 Bc8oQsc/xygV4Rx90eziiyjCfKpfO0UGwI1R8OtnL8pMJqFyM1BC2VUcALYT/Km/TyZRt
	 vnXwe7Q/K8v+oIJwIa9gdWLzCCtXOUX7d2R/UREV7EbAJXT4JTkdbJaw0hfOFtNFipw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795434097;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=hPH+xwQQ5YvRprFEfig6JwjI4JJt7gcVnXPnZvpsz58=;
	b=qvy4DPtj9P2eS/37fjb2pQAeVns3f9n8Ht5vEYAASFDWUGrLyg4L8iDg+n10pJjaGx8E
	 /kzv2lTSwiLEMGE3r3fAZYvLSQk8NXQSyoCwBtHiwVGhif96G2thhwzaFewxMzNPeAc25
	 gygc+tzX4RzyAJne5LhKKCdjarLMhQRuYiRqXN0jRGfBrENI6O1F7KWB5iEDSZbdc5y3U
	 jc3AJ0C6sXmvKcNH7ybX386rjiCwfz/ebbfVHW5gp54wQY7vYFdZfxkRSgfiYOVx3SYRK
	 TiEsKGThCqzBYx3cdcvDmSvRa/AZfyTTTx3zQ7GGnqgECt5Srm++QN5uXEHlRGu/T5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=AqvTCW5q;
	arc=none smtp.remote-ip=109.224.244.122
Received: from mail-244122.protonmail.ch (mail-244122.protonmail.ch [109.224.244.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C2B606A32A;
	Mon, 23 Nov 2026 11:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52C2B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=AqvTCW5q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1795434092; x=1795693292;
	bh=hPH+xwQQ5YvRprFEfig6JwjI4JJt7gcVnXPnZvpsz58=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=AqvTCW5qPw2qcd8PAjH5z5PbIyHUU6oizOI+s+K7cDDXtV7PFmj9IPlnbrb215L2x
	 m/RWi1veWIhSUlB/2yxBLWKrJ69FXS+kDOfxoOAtKdY0VGw8HX5V4CcN9NMqqdSUOO
	 TkIY/hivq//dNMMUveqVLQH7TGTHMWrbAEWJz1WnXIp5tUbeopHRYv8Nald0kGqiD6
	 +ZHfgxEipxsOUqfvrohVIY580xB1XNgjb6Uv0ukoGEnvbw3xOJCRhfzLNO0s80dZKr
	 coDUkztBL3JK1cVGJ9a4XYR96VHe4UDIgcQUy1tcuYlBRkExLmlf0LDqW/KmalhSrC
	 CcDxrCenLvhJw==
Date: Mon, 23 Nov 2026 11:41:26 +0000
To: Alexander Letuchiy <asalde.le1@gmail.com>
From: Roman Vivchar <rva333@protonmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sean Wang <sean.wang@mediatek.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, linux-input@vger.kernel.org, phone-devel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 0/7] arm64: mediatek: Add initial MT6895 and Xiaomi Poco X4 GT support
Message-ID: <ckJZtdZ4-fPzsa3vkozNyEYYUbG9qd134hYb0hHEuq2nL8WMAR1PS87OpDfXrkU-E-85rsG1I4V99_M41j6-ewkD_41XPguDel3z8z0lmMk=@protonmail.com>
In-Reply-To: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com>
References: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: c6b719aaffbb9f16cf86df1433c20e78eaceb862
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Monday, November 23rd, 2026 at 1:19 PM, Alexander Letuchiy <asalde.le1@g=
mail.com> wrote:

> This series adds initial support for the MediaTek MT6895 (Dimensity
> 8000/8100) SoC and the Xiaomi xaga board, sold as Xiaomi Poco X4 GT, Redm=
i
> Note 11T Pro/Pro+ and Redmi K50i. It is enough to boot to an initramfs
> with a serial console, CPU idle, the CPU and DSU PMUs and the volume down
> key.
>=20
> Dependencies
> ------------
> The SoC DT describes the pin controller and the board DT uses its pinmux
> macros, so this series depends on the MT6895 pinctrl series:
> https://patch.msgid.link/20261118-pinctrl-mt6895-v2-0-0728c4eddcac@gmail.=
com
>=20
> Bootloader dependency
> ---------------------
> This was tested with a modified LK bootloader that is not public.

How are other xaga users supposed to boot the kernel? You might want to
port uniLoader instead, or if you're on an old enough security patch you
can even replace stock LK with U-Boot. U-Boot chainloading is also
possible.

> The stock LK cannot boot this DT, as its Android fixups expect nodes
> that are not present here.
>=20
> The DT relies on the bootloader to:
>=20
>  - update the /memory node
>  - add all firmware carveouts to /reserved-memory
>  - pass the command line from the boot image
>=20
> The carveout addresses are therefore not listed in the DT, as the
> bootloader allocates some of them dynamically. I can describe the
> fixed ones in the DT if that is preferred.
>=20
> Firmware behaviour
> ------------------
> Two things in the stock TF-A affect what the DT describes, but not the
> DT itself:
>=20
>  - TF-A rejects CPU_SUSPEND for about the first 40 seconds after boot.
>    The vendor kernel lifts this earlier with a SiP call, so with this
>    series the idle states only start to be used after that time.

It might be worth porting upstream TF-A too.

Best regards,
Roman
