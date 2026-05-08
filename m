Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B9032BF5D;
	Fri,  8 May 2026 21:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778277400; cv=none; b=sNp7haAXLrUR+o14Dt5crXvkeOEnXaR2RhzSJQJ8B85MTCmB4mifGJMYkSCzG9Lvr6rjNqoLmR5m1fefd1KAI+LgFqnFRuZ/ge0mBKo/4460LLBzBuvcxrqYGKTOuF3c6GyRE/aDL9cd0i7Qe8qEIBxcTBIe+/b3MN/GVeJ70W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778277400; c=relaxed/simple;
	bh=q0+SHY0qC73hOivLZwbohhJ7pN7Lc5aNx5dZo3S2pxc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hkpCuL0WmpLo6YWwwGkj/kiOLgHKgP3gI8eLU4zNfZxaSvf4E0d0n2eZCCdOU6kwk7lnfqbmVAtMUCx48FkL2WGCGNBaVBS7ivjVz3uTo07nHvQ4b+W/7ZPMc514GlrwmCg4pUThBWTv5+eFrwwmQC4PEEMNqJNKCHCh90wLwdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbfFULzW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbfFULzW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6746FC2BCB4;
	Fri,  8 May 2026 21:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778277399;
	bh=q0+SHY0qC73hOivLZwbohhJ7pN7Lc5aNx5dZo3S2pxc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=SbfFULzWH0kXgp60gI9S45O/epTnQ939THlybn3iDROKZ7+e0cZnw9MeOs/wPyJhQ
	 5c6Wp6+dFUWfaCfUvJZfk+l1c1lq9G3FQcN09agTHY+nHw0m/6c5Yy20yFUR2OVWuM
	 KTFHoFZak9B5+eYl+w4ckxkk4o/RFGJSp+/6RxAI490XSBpLtO1pCmuzLTb6gLunDq
	 iPB2eMR+QlBXYRmck1+o2ikt27TmZkWtcZdUzH7vfwRglrevyrgc6ZYNsP/OGwDnuw
	 RElzgK+RLsre99isML9t/qu2o+zca5auv81eSGO/3xwwuHUT8XlmRe0fUHYchujy5H
	 5RP30DhPbXJpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 4/4] arm64: dts: qcom: milos-fairphone-fp6: add
 supply for Hall Effect sensor
Reply-To: sashiko@lists.linux.dev
To: "Griffin Kroah-Hartman" <griffin.kroah@fairphone.com>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-input@vger.kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260508-gpiokeys-vdd-supply-v1-4-0bb32e8e6428@fairphone.com>
References: <20260508-gpiokeys-vdd-supply-v1-4-0bb32e8e6428@fairphone.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 21:56:38 +0000
Message-Id: <20260508215639.6746FC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing `regulator-always-on` from the Hall sensor's supply cause=
s interrupt storms, spurious events, and broken system wakeup when the inpu=
t device is closed.
--

commit 35bf0d08eef4da2139153f5425e351a93d9d591d
Author: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>

arm64: dts: qcom: milos-fairphone-fp6: add supply for Hall Effect sensor

This commit adds a vdd-supply property to the Hall Effect sensor and removes
the regulator-always-on property from vreg_l10b, relying on the gpio-keys
driver to manage power.

> diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/arm6=
4/boot/dts/qcom/milos-fairphone-fp6.dts
> index c1899db46e714..ae6900c3f75c6 100644
> --- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
> +++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
> @@ -32,13 +32,13 @@ gpio-keys {
>  		pinctrl-0 =3D <&volume_up_default>, <&hall_sensor_default>;
>  		pinctrl-names =3D "default";
> =20
> -		/* Powered by the always-on vreg_l10b */
>  		event-hall-sensor {
>  			label =3D "Hall Effect Sensor";
>  			gpios =3D <&tlmm 70 GPIO_ACTIVE_LOW>;
>  			linux,input-type =3D <EV_SW>;
>  			linux,code =3D <SW_LID>;
>  			linux,can-disable;
> +			vdd-supply =3D <&vreg_l10b>;

When the device is opened, the driver reads the GPIO state immediately after
enabling the regulator. Without a startup-delay-us property on the regulator
to allow the voltage to stabilize, could this read an uninitialized state a=
nd
generate spurious lid events?

>  			wakeup-source;
>  		};
> =20
[ ... ]
> @@ -326,8 +326,6 @@ vreg_l10b: ldo10 {
>  			regulator-min-microvolt =3D <1800000>;
>  			regulator-max-microvolt =3D <1800000>;
>  			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
> -			/* Hall sensor VDD */
> -			regulator-always-on;
>  		};

Could removing this property cause an interrupt storm?

The gpio-keys driver requests and unmasks the GPIO interrupt during probe, =
but
only enables the vdd-supply regulator when the input device is explicitly
opened by userspace.

If the device is closed, the regulator is disabled. Cutting power to the Ha=
ll
sensor while its edge-triggered interrupt remains active might cause the GP=
IO
line to float. A floating line can pick up electrical noise and trigger a
continuous interrupt storm.

Additionally, does this break the system's ability to wake up?

If the system suspends while the device is closed, the sensor remains
unpowered. Even though the wake IRQ is armed due to the wakeup-source
property, an unpowered sensor wouldn't be able to detect lid events to wake
the system.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508-gpiokeys-v=
dd-supply-v1-0-0bb32e8e6428@fairphone.com?part=3D4
