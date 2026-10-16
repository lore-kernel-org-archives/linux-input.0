Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FAE372661;
	Fri, 16 Oct 2026 12:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792154334; cv=none; b=TIciHcsTRbrtUX2240e834dHEmxYuQ+xvJSJ40mmUJ5H39EUYdis+o8vxVTOXEJGIO2noLVQzEAfPQSlUkeVDVsESQDVP+CW6F7MON2l30ZQlIfpkyWFVl8bTkR4ivD6JihylBi4x1R62wg4Okz7+fKaOHYwsSEyO5veztRXEF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792154334; c=relaxed/simple;
	bh=NAmfd+ACBer+SQWNwEhgyiECcTNzamm9ww6X57pgwcc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=dpZVaw5n6uKxxXurmRU7ny4RGtP0C7JBgo0shXcYNMd17OBoEb7iFAcs1/skk3RoLCrqLuFuqEzyEM5q08+xK4Qt2oR9QRyA91EhEcG6qbJcSCwjl+eRiyopZ01iOV0wZHnjvsDcRL0c6M/q9nQFYsobIvmTB60OAWz5K23gvzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyHDcKOk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyHDcKOk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E7E1F000C4;
	Fri, 16 Oct 2026 12:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792154332;
	bh=ZXo6cmhGJF9jfz4Y3CPgJnDJcQZWZhFTWcbR1nd+or0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SyHDcKOkjIFFrYxiSoxAVGR0K0k74KBu8aXd0SqEuMMnkCYLDJPiQy1SYF9czRD7b
	 w04o/UezRhHbcXZW8IDQOQyQWZK//frkOR+dOzueEKf0Z3VosaEU/CH49IISjDxEcB
	 aQcghveU6TR/tqITqTGdztayjXDnYQzWd/laTYgzat3m47DSF1I7FxLWjOqc7BXGog
	 7JtAy5rGeu5OEaeusCHi/4Iu/kuDuJ4NfecfYoxfYE7uUISIqtzpXH+HfafNJGjEhT
	 3Av3YvQ7zUYXEqA9O8Iz95kkT9gVE2jR/Fvf0IM5qQMktHUdpURZRDEYWT+KH+ItZJ
	 CQrYNCcdBUnZg==
Message-ID: <sashiko-outbox-174304@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: input: add OnePlus pogo-pin
 keyboard
Reply-To: sashiko-reviews@lists.linux.dev
To: wyibo6109@gmail.com, linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261016123334.1019257-2-wyibo6109@gmail.com>
References: <20261015110859.203989-1-wyibo6109@gmail.com>
 <20261016123334.1019257-1-wyibo6109@gmail.com>
 <20261016123334.1019257-2-wyibo6109@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 12:38:52 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] MAINTAINERS: alphabetical sorting error for ONEPLUS entry
--

commit d93ea6ab73044ac76b5e3e2c76b82b975bf6fd6f
Author: Yibo Wang <wyibo6109@gmail.com>

dt-bindings: input: add OnePlus pogo-pin keyboard

This patch adds the device tree binding for the OnePlus Pad 3 Pro / Pad 4
and OPPO Pad 5 Pro pogo-pin smart keyboards. It defines the compatible
strings, required GPIO properties, and adds a MAINTAINERS entry.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index b8c4e1080af94..d81e400059ced 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
[ ... ]
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
This isn't a bug, but should the ONEPLUS entry be placed after the ONENAND
entry? The MAINTAINERS file is expected to be kept in strict alphabetical
order, and ONEP... follows ONEN... alphabetically.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016123334.1019=
257-1-wyibo6109@gmail.com?part=3D1
