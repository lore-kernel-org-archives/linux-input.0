Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795004820;
	b=uXflSXg7z01GOGIS0lTvf6HHVBmbTo7YIaZh5rZR+xEayJIFRwllG3jNB6SnMPpv/FJO
	 gdHMiCgRyYPubi8Wphek9OF/jGr1kVm0LAb6+mPxUTdv9McAPe1XVVM9tEHLI6albrLFk
	 ZYvwHiSd86RBBr6SYCHVVQuijT6QbxzWvhsIc2HYJStgENz4P0AYFn7yKJC2YxG4ktUFH
	 trJR6tPzFil1Yo6NAbFrYVDLS3UhUWGcoibyw1BYDI9RNBKI9arbv2Fju/W9m/K3P1LL0
	 /pYXyNWZ/GfNtEG49VqFuE6uMnI3wKQ1GKD2pLBwOEu+SNXbEzblGvBUvWxBZPUG4VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795004820;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Nq6nHtcQPov6ng/GWbkcWdOEm4htQT9mHmFTo86WOlM=;
	b=HkCXZ0dmMLsKhrpByvhAYsp2AiYmHGN12pDMYndUP/iSONWCj0HNK4LQfhR45Oqo6uJL
	 3QlcOI6VlndRIbmzWsNRosAi19vtWOhNj+wp3+HM1IkijNDcj6kjaSTetnVuCc0isAFeV
	 RgWPVHbdRJj8iuOjZgZNCGdYgUWGIi8lM5xUZj5BmpV3FcC6Vys/BSpP8afo5ImWQiYO4
	 g4ENR61kem0pQy0HpWXUJjKL4ZAWpWzhf/kfs86fwJGrfj9IMi5hwvpbSny07Ux8hjXWg
	 /sI8SM3vWTA2eitWqo+P7+vj/aX0cikvLFCpYJrBy+0XRgI/zTH9SwcVeJBDmjnuIOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VrSQrjOq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56965606A31C;
	Wed, 18 Nov 2026 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VrSQrjOq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C97D1F000C4;
	Wed, 18 Nov 2026 12:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795004819;
	bh=Nq6nHtcQPov6ng/GWbkcWdOEm4htQT9mHmFTo86WOlM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VrSQrjOq0nmUymOLLSCiUHOsQN/TLXPfgsyaCQFA8P5f9O6PZV2HvPy7tPM4A6QN7
	 RD1YWdG79mV0HJwAJPdd28In/P+cRD+rxlruKAjjJCHsOd8frG1IU179eKm8xAO9fW
	 udRisRAaGIMA0h0BP1IuuShD8B+hOnvPLJECTf7vHnBOo2o1snVjQ0uru+ZC7y964D
	 kTaMG8O2Hhpgn9xCuvJT2iN0f37hdYbQe+wRn8QHId5LQ4xK6/6KxbcU1bhpxyMGAe
	 o/fHTEo7e93rehvurXz0mNyDbfmThjBsbnuTMBDIL/Qp2oRSpQarKGce2YTxznva9U
	 EaJ7O/+jW2ojw==
Message-ID: <sashiko-outbox-220911@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/10] arm64: dts: qcom: sm8250-lg-timelm: enable
 SW43103 panel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abdur Rofik" <rofikcoga@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261118120714.31505-8-rofikcoga@gmail.com>
References: <20261118120714.31505-1-rofikcoga@gmail.com>
 <20261118120714.31505-8-rofikcoga@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 12:26:59 +0000
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
- [Low] arm64: dts: qcom: unused dt-bindings/phy/phy.h include in
  sm8250-lg-timelm.dts
--

commit 374b6a1bedb56450ce91de89b10571b27d001468
Author: Abdur Rofik <rofikcoga@gmail.com>

arm64: dts: qcom: sm8250-lg-timelm: enable SW43103 panel

This commit enables MDSS, DSI0, and its PHY, and attaches the LG SW43103
panel in the sm8250-lg-timelm device tree.

> diff --git a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts b/arch/arm64/b=
oot/dts/qcom/sm8250-lg-timelm.dts
> index 1b2b67486fee7..d307a52cd0e62 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
> @@ -8,6 +8,7 @@
> =20
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/phy/phy.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include "sm8250.dtsi"
>  #include "pm8150.dtsi"

[Severity: Low]
Is <dt-bindings/phy/phy.h> needed here?  None of its macros are used in
sm8250-lg-timelm.dts.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118120714.3150=
5-1-rofikcoga@gmail.com?part=3D7
