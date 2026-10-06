Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EF23E49C1;
	Tue,  6 Oct 2026 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791289622; cv=none; b=dUMi3UJocAnpR9BrobtIayKGkO2jxoRo5n+QwSXdaF3nPgaRusRONP16ZV40vbcaZ7hlNa0BeK2JyWk4mg45qiFv6Mv2B6iq6pU/OVtsBh+K5tulvXMZ+/hBTzoToXcj6wpJ2DF1Ihu/9tFfDyfJ6/UZdpmYLN3Eb9dpimzQX4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791289622; c=relaxed/simple;
	bh=qk9+s7ob2earTizZz8FVYkIJuSlrmFmRDPJg53oi7YE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ImV1iz8+nWAwPtzZCOfB2gKoHooUIUciOiG/iEIYQp2wdp/8J3BvcvDh0dGWRqBBMG2iP9j4IfnWU5KMHUvFJSogIyyv64pT2PFP3Ex1jExwCwzjnDJmeu4tF4udnlcmKzXwYh+TRaiaUDPgWfYFGNyiIF1M5D/2NcUf5thcRNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWjd01M8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWjd01M8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0272C1F000FF;
	Tue,  6 Oct 2026 12:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791289621;
	bh=Pd/wKsOKfWxUPCjrJlzJ/8ojQpo+hZO/Vy7OgdiYt34=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XWjd01M8kpQ+a7fyzbZ2zDERMSre2BCNJb+HWEhh5MKXt6DiIEjrlVAafKwGD+4Gp
	 zIGHZxouAoU8pOwve7As0tvITVISJGysLPDbePD3L4q4wQvNL9kdXzbgEEtqVvmpRu
	 jHfxepm5PwDZlXBp13dnCx5v06oNgKFeUp/0LuU+REEk1BDDEuQHmOk66TUaUyxkhP
	 E9bnMa9nHEUcEJG1elzCzSzeX1KhTjyDmx4rkVlnw2yMCMacUgwqkC5w1eg6C0614z
	 qYnz9qfO0Y8r9aWWNvxbLI/ly6oop997IRol2yF+YLN2lmT8mo+jkERsvPHIEzdGOH
	 swOgueBjwC14Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/7] arm64: dts: qcom: generalmobile-shamrock: new
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: robh@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20261006-msm8952-initial-support-v4-7-ecdcc1ac620c@mainlining.org>
References: <20261006-msm8952-initial-support-v4-0-ecdcc1ac620c@mainlining.org>
 <20261006-msm8952-initial-support-v4-7-ecdcc1ac620c@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 12:27:00 +0000
Message-Id: <20261006122701.0272C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] arm64: dts: qcom: missing status okay for serial console
--

commit 4edd65c8f134e38dc5d335fdbe677afa8c5e9969
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

arm64: dts: qcom: generalmobile-shamrock: new device

Add General Mobile Shamrock (GM 5 Plus). Shamrock is designed similar to
L9300.

> diff --git a/arch/arm64/boot/dts/qcom/msm8952-generalmobile-shamrock.dts =
b/arch/arm64/boot/dts/qcom/msm8952-generalmobile-shamrock.dts
> new file mode 100644
> index 0000000000000..9114b232cb1bb
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8952-generalmobile-shamrock.dts
> @@ -0,0 +1,435 @@

[ ... ]

> +	aliases {
> +		mmc0 =3D &sdhc_1; /* SDC1 eMMC slot */
> +		mmc1 =3D &sdhc_2; /* SDC2 SD card slot */
> +		serial0 =3D &blsp1_uart2;
> +	};

[ ... ]

> +	chosen {
> +		stdout-path =3D "serial0:115200n8";

[Severity: Medium]
Since stdout-path and aliases map the serial console to blsp1_uart2, does
this board file also need to enable the underlying UART node?

The UART device is left disabled by default in msm8952.dtsi, and the status
is not overridden to "okay" here in msm8952-generalmobile-shamrock.dts. As a
result, the device driver will not probe and the system will lack serial
console output, which could break debugging and boot logs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-msm8952-in=
itial-support-v4-0-ecdcc1ac620c@mainlining.org?part=3D7
