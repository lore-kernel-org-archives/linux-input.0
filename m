Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE124FD27E;
	Fri, 16 Oct 2026 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792169106; cv=none; b=dEJpCj3zGNpTvtbXIdK6JmJ9SuNrwhmlQC9KCOWqzJBApGRkWe64TiJHLzGa8LuJ4kSHSprBFoWiaszXRuTDvQL4TuMNvXMdu0cHKXRt8fU0WcSQue8v9fVlVWtw0z8cOeJjzq1tQ+IhMoooOnvGXjV3oO9CON3ybCtYKishzZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792169106; c=relaxed/simple;
	bh=/OiVgVxpwbpXkfCrpnpYx3Ihy+io2EfVJwfNkA8DxxI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Ft7QheBOMcUSv3+VUghuKpF8KO6xVRXBBuQERn3cGnELTLrBftFwqc8iZC3x/1mX/mSXUn3i2LijTrRRPCF0aRFhslzQw0pNUmPFF1EhI6wPUDhF441JdIv2/wnLih/GpUGuCz0tWcObHBEJiK286JI/5c6t/04Aat6wTuP+vQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDsKW4nu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDsKW4nu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7661F000C4;
	Fri, 16 Oct 2026 16:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792169104;
	bh=5mx/1ybJsIQg9P8lIAdRtJ/VMzCkdNmAYluRg7lvk/A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lDsKW4nuaQkyoNff2IyRxKwFLloxJVm3MB4U4BcHiWB0sja2U5dtaPtd+zPsJMVui
	 2snW6tSfwm4wkapNm3Pb709qRe7jE6SuQh3Goe/zrMs2fLfhrwlqcdxJTwsVZBGfDC
	 adtGdLqh1JVpY4h8W7zfydzj/mqmbdEyDUFzmeLIS3Fttiurntw/mYHdOIduFn84+x
	 g04CvYKO7Pq/uLx/6GH+WVvfok8yF7CgYQwnQw82dMTq/CWhYBSNjFytkcfYacz8N2
	 2ttpsKKw40zXYIqYGLQI7PoZ+SvrblKGEzo2N0gt/X2e+OlLiL/GetCiLxJcqop0wD
	 zhXfLbLrTkRNA==
Message-ID: <sashiko-outbox-174660@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: input: add OnePlus pogo-pin
 keyboard
Reply-To: sashiko-reviews@lists.linux.dev
To: wyibo6109@gmail.com, linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261016163859.1070138-2-wyibo6109@gmail.com>
References: <20261016163859.1070138-1-wyibo6109@gmail.com>
 <20261016163859.1070138-2-wyibo6109@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 16:45:03 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] MAINTAINERS: new ONEPLUS entry is inserted out of alphabetical order
--

commit a3b7a3bdc211b0789ad103d539fa35e6dcf0f689
Author: Yibo Wang <wyibo6109@gmail.com>

dt-bindings: input: add OnePlus pogo-pin keyboard

This commit adds device tree bindings for the OnePlus Pad and OPPO Pad
pogo-pin smart keyboards. It defines the required properties for the keyboa=
rd
MCU attached via UART, and adds the corresponding maintainer entry.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index b8c4e1080af94..d81e400059ced 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20154,6 +20154,12 @@ S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-dev
>  F:	drivers/usb/misc/onboard_usb_dev.c
> =20
> +ONEPLUS POGO-PIN KEYBOARD DRIVER
> +M:	Yibo Wang <wyibo6109@gmail.com>
> +L:	linux-input@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
> +
>  ONENAND FLASH DRIVER

[Severity: Low]
This isn't a bug, but should this new maintainer entry be placed further
down to preserve alphabetical sorting? Since P in ONEPLUS comes after N in
ONENAND, inserting it here places it out of alphabetical order, which might
trigger warnings from automated sorting checks or checkpatch.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016163859.1070=
138-1-wyibo6109@gmail.com?part=3D1
