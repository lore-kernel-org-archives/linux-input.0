Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096798;
	b=r1yoUzWFBoIk7yCI10dGJKAiIXvarV0i6doM4zFuG0pTAWuNk471FK/1MFPRzbOBsQC+
	 /srUu8LTPBRQX7FA9Erk1QyNrxkHOlvR3WUesG6bbinKS9xZANrhi1ADLO+GwMa/uUPtU
	 DzZfUGDYPFv/acMf+RJ4j8vPjqQzkgc2ijJK/TuBzNXiRNuKFRecuh6gKfihRTwGBScXH
	 fnpMfw5YBQ/A7RBGeIWMwtx2QwhdMHouAYe5L8WQ6llLfVrd30ELmCvUDlhRzAeluWJb/
	 DcDkoLHVPLyTHt7mP5QQvA/OthIXFIIBM5xCP2CJpk1oivHZFZLHmOAlWkGG6san03Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096798;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZLv2vRWbQhoR3AXJJmHap84PJ0JKECPeqJXwjX7GeMw=;
	b=F3ksAP2ZTJFZ2dmUDWGY4gHkRGhkdiDNpyEQH5ItJGKlS5sf2+7aO9Od9/+LTFcvKxx2
	 Q5+IQo8tLdquSDLch/4A+qO6sAxw8fulGYXERXQDdvyhe7ame96pMtC/zXdn0kGFpAx5j
	 0sAiE0/gJczjP87vKC1RZyhZS8rdSbshGbtyBe4PDBYt4J6PUxMbmGooXlhSdZjqBDePc
	 srqVjKc6VuEuC9NZ4DUCKeJN9318vEG7zPHQwN1FW/Kin7IQIYDsUcdWo9+P86Rjv6/SR
	 ZW8JrSQG+AqukvdW+mTSjzReOgfCVEF7pSP9alFaRiP5A24mWnYtId8tQYP0d2DeuUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CWWZGgLE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC9A606A320;
	Thu, 19 Nov 2026 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CWWZGgLE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D94381F000C4;
	Thu, 19 Nov 2026 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795096798;
	bh=ZLv2vRWbQhoR3AXJJmHap84PJ0JKECPeqJXwjX7GeMw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CWWZGgLENGrdb4wF5fgBbflYKi/Qka5hX8vQSXf1hLrcCjXFtPeM+Vmf/cUfIi8gB
	 J8TR0RNP4Ptj/bOZMVjSXJYw0kTPT6t9UfRw+AhIWubVuUdyaVVRsrgdArV3MGadQc
	 3nJiDL13WaMG1cQRwdFDR7x45Fe3j2af2e5X1yuRl/Rg/O2jdZvH0j8W6/ZdskmJxO
	 iOmNd/Kc0LAeJ9Fx6FpcBfzXMwye4XWGoqM0lf5N1nYSPS3egjyCxf5R5JLy7iDPTK
	 qOeWSJ326l8quh28D0PsJqNS+vZUkf5lula3qt8blzZg2v55FS9lzkVZ+ztQ08RyFV
	 F6/CyB6vZtW3g==
Message-ID: <sashiko-outbox-223232@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] power: supply: Enable compile-testing for
 BATTERY_ASUS_TRANSFORMER_EC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geert Uytterhoeven" <geert+renesas@glider.be>
Cc: mfd@lists.linux.dev, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org
In-Reply-To: <8258f896cccf3c27d3034a6eb9bb6f7becfbc1dc.1795095742.git.geert+renesas@glider.be>
References: <cover.1795095742.git.geert+renesas@glider.be>
 <8258f896cccf3c27d3034a6eb9bb6f7becfbc1dc.1795095742.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 13:59:57 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] power: supply: missing I2C dependency on
  BATTERY_ASUS_TRANSFORMER_EC
--

commit 08aa893cb21ca94a6803c481fce373ce94bd11f3
Author: Geert Uytterhoeven <geert+renesas@glider.be>

power: supply: Enable compile-testing for BATTERY_ASUS_TRANSFORMER_EC

This commit relaxes the MFD_ASUS_TRANSFORMER_EC dependency on
BATTERY_ASUS_TRANSFORMER_EC when COMPILE_TEST is enabled.

> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 16d0a38b41b7e..ace0c4ae721ae 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -124,7 +124,7 @@ config BATTERY_CHAGALL
> =20
>  config BATTERY_ASUS_TRANSFORMER_EC
>  	tristate "Asus Transformer's battery driver"
> -	depends on MFD_ASUS_TRANSFORMER_EC
> +	depends on MFD_ASUS_TRANSFORMER_EC || COMPILE_TEST

[Severity: Medium]
Does BATTERY_ASUS_TRANSFORMER_EC also need to depend on I2C?

MFD_ASUS_TRANSFORMER_EC depends on I2C, so relaxing the dependency with
"|| COMPILE_TEST" allows BATTERY_ASUS_TRANSFORMER_EC to be built with
CONFIG_I2C=3Dn or built-in with CONFIG_I2C=3Dm.  Because
asus_ec_battery_refresh() calls i2c_smbus_read_i2c_block_data(), which is
only declared and built when CONFIG_I2C is enabled, those configurations
fail to compile or link.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795095742.gi=
t.geert+renesas@glider.be?part=3D4
