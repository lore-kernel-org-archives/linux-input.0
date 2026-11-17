Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919875;
	b=Q7GuO95fWQUYTkYDHde3syxJPa6+eqt2F7L+sH95Xc69gLTea/xPcjMNdzI7rn3YZHO8
	 5D5m5x6zNnPYxBua3n+nDROdz3/ZB9Ze3nuudbYRbLQs+C+t+D0INYqEGRDZkAnSQh57n
	 M9YonhMzDFns3grUCGyvxpcurhUXw9zKsT3sod5aoPDrfUyS7Z5j2GFsXm3HOpQwWVl/C
	 LhiGl1EWxsl1glvlqbEudykWlkshDK7gwxGBXozOWWMetQrUkXw2fphJld86AExNHz5+a
	 JPDohLtJ0I4am2A15mmdsxJ1TukrKn/GlTKoG5vKvNhyRsT8/QH+wnbpKRxxdSWl0kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919875;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bPc/tkXm29ES90LPGNiFh5SDVDhkBJg4N6KrnFhUIiU=;
	b=yF2nCwIrP/NiAztWFx59utpP4UIW+Ouv0GymMZtuxLXbAIikhL/6gHTcbtXOn6dhBECT
	 MvPy9uA5scwWvVrXMPPchPSbcp4GJofB0EH6lbg6wnKL3Tb6Fno+fXr9299H45lkpm4GQ
	 T9CvYjo6h26g8mauorY+8xn027FbR6Jc2gdYEu4Y+pcaM44+/D1T05FZGRcdBamuQ1SPR
	 iERn/n3xYOUbK9lDY4+s9GWhALscsPNWi8LugMdveVFpVwp8ftVQMBxFipD46mHuXyrOV
	 CpsIZPpGZkLgVHWg7AN41GPoa7P0VuewnEfdEqkOmxf0EdT75po/H6+T71HFd/lgdCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gp4Edevx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1295E60A261C;
	Tue, 17 Nov 2026 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gp4Edevx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344AF1F000C4;
	Tue, 17 Nov 2026 12:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794919874;
	bh=bPc/tkXm29ES90LPGNiFh5SDVDhkBJg4N6KrnFhUIiU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gp4Edevxixx2PwmFnm0t5IWia2+eCwdShKNoZ6tIHDordHMY2sRIM2hYFhzda7gqr
	 aU7TymabDq6atfO79h3rwS0UiNL3kyIlPvJANPCwzE+hvddKWUAP6Jk9cJ53/1Wos8
	 uvT8GjV/WjaVvjlJ0szRvdRxNx9nuw9+OOqhOw81CWm7aeU2ZOk5ITq9dIYJihtZ4Z
	 sFp7IQbEsZkdH10oaQZ3ODgckjoAd7K9N9iUj0wHHgtnblmaz3gmgnqeJb4mSt3TkB
	 yUjQiV8OjrcH1jECQyqy1kNuHFK/Cw/OovGQtbKEpxTLlrC9johFebxeLs4jzd9CNq
	 4cNWZJdfDENsA==
Message-ID: <sashiko-outbox-218806@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 06/11] dt-bindings: input: touchscreen: add Silicon
 Works SW42902
Reply-To: sashiko-reviews@lists.linux.dev
To: rofikkerneldev <rofikcoga@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261117123946.668557-7-rofikcoga@gmail.com>
References: <20261117123946.668557-1-rofikcoga@gmail.com>
 <20261117123946.668557-7-rofikcoga@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 12:51:13 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] dt-bindings: input: touchscreen: username handle used in
  sign-off and maintainer
- [Medium] dt-bindings: input: lg,sw42902: power rails modeled as GPIOs
  instead of supplies
--

commit c2a344c3130db163c68195828fdefbdfd36cd07a
Author: rofikkerneldev <rofikcoga@gmail.com>

> dt-bindings: input: touchscreen: add Silicon Works SW42902
>
> Document the I2C touchscreen and its interrupt, reset, power-enable,
> and panel-size properties.
>
> Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>

[Severity: High]
The Developer's Certificate of Origin requires a real human name (known
identity) rather than an account handle or pseudonym in Signed-off-by
trailers, the commit Author header, the binding's maintainers list, and
MAINTAINERS.

> diff --git a/Documentation/devicetree/bindings/input/touchscreen/lg,sw429=
02.yaml b/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.ya=
ml
> new file mode 100644
> index 0000000000000..c56cfb8530eeb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
> @@ -0,0 +1,74 @@

[ ... ]

> +  vcl-gpios:
> +    maxItems: 1
> +    description: Active-high enable for the 3.3 V rail
> +
> +  vdd-gpios:
> +    maxItems: 1
> +    description: Active-high enable for the 1.8 V rail
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - reset-gpios
> +  - vcl-gpios
> +  - vdd-gpios

[Severity: Medium]
Should the 3.3 V VCL and 1.8 V VDD power inputs be described as
vcl-supply and vdd-supply regulator properties instead of vcl-gpios and
vdd-gpios?

VCL and VDD are power supply rails on the SW42902 controller rather than
GPIO pins, so requiring GPIO properties in the binding prevents it from
describing boards powered by PMIC regulators or always-on supplies.
GPIO-switched rails on a specific board can be modeled as regulator-fixed
nodes in the board DTS connected to vcl-supply and vdd-supply.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117123946.6685=
57-1-rofikcoga@gmail.com?part=3D6
