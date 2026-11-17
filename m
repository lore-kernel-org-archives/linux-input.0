Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919902;
	b=RBontlFspP1rSeWoUR7qYe7PQJg3/P9ttmxqfqIp15dcydFSZlhh/5zRzUETCYu403at
	 s09+ftN9XQaNdWlwyVFWT301eADvLoPp6iNz5vyuX47pm1DwcIo329XDA3edBMaHE8cn/
	 jB3lXBELgZnA4I6qucP+azhZLUto09Rl9bKNARDofw5POX+jFRsSibRJwSGa1PCjwppjd
	 YoOpY9ceTSylmURRNSqA2tqLarFMVVdO/TmG6/Sb6RYf/Ml4W7aogSlA0/ri8VSWrB1MM
	 RzR5VtABoD2Wo8Id5/wq5LC2kAWC9fQ8JKHxG3pIfUk9RERAfzy4zwcoVESZTVh5qhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919902;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fGtOVnCx5r8R49kbtcig0TmxQsowQ/HRgdElWSS2vuU=;
	b=igh57hagydQXVq3Jkw4hbxeUz0se/dmChvBI2zAwvDhmxcZ0LIjhFJpYSZLouynFMV8U
	 /gEdWe8QNAIubyzUIr2fKQ3GtyObigdAoxvB/MHP7BZyP00hVATmpkPVyjYQ4TUznOLJi
	 ce/pQXEwUNkjWhU36CK3Xwzf3oJBwd+5Wi81AkEab+hAok6WhXLtBA0fA7jbwHbK77aW1
	 FnL5tqHYYcPT3aSflj4TywDGmTtAb0ODWLl9eFwkYlLg2GnXMtpKOQkvch3rnLuB/PlEX
	 Z2jITKtLH2jrmpPuE4a/BX2hUPTCx9vfypZn+j2jeRdkv5dpo6kTKeSN21xZbSiECDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZs3ch23;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BB4606A323;
	Tue, 17 Nov 2026 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZs3ch23
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC091F000C4;
	Tue, 17 Nov 2026 12:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794919902;
	bh=fGtOVnCx5r8R49kbtcig0TmxQsowQ/HRgdElWSS2vuU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BZs3ch23n8V47XS155+s+EALMGasR76F8dOmeD3n4ATVEQEF9FpBgST05M1SMFgNW
	 EePcCYr6Dt2HWQab9NlrDayzW7Zq7sTJk30GWwYhkMxtp9BVnGk8vqcazod8Lygpjs
	 Vtb8pSx90JA/1IW2Q50bEP0DtqcLi36XmSJ+dJ5xQbdsfHAzCoFJC0kLpjhpn3HnBz
	 QtuWmtfbUclGrK5feg49dz58uABQ52g0KMgzaVSskk6is6LNWymfKFvuVVcKEHzDKK
	 fn8fqxed0/K2yKaYOEBL7BMqPZTXD4AbB3E67RogiOsUkzaQAwGID8hnlFfWn1jN92
	 CnMrPqHEs/XqA==
Message-ID: <sashiko-outbox-218810@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 04/11] dt-bindings: display: panel: add LG SW43103
Reply-To: sashiko-reviews@lists.linux.dev
To: rofikkerneldev <rofikcoga@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261117123946.668557-5-rofikcoga@gmail.com>
References: <20261117123946.668557-1-rofikcoga@gmail.com>
 <20261117123946.668557-5-rofikcoga@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 12:51:41 +0000
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
- [High] dt-bindings: display: panel: lg,sw43103: handle used instead of
  real name
- [Low] MAINTAINERS: LG SW43103 PANEL DRIVER added out of alphabetical
  order
--

commit 8f35306c3ad9479ca0f821358a8333dce583f152
Author: rofikkerneldev <rofikcoga@gmail.com>

> dt-bindings: display: panel: add LG SW43103
>
> Document the SW43103 FHD+ AMOLED panel used by the LG V60. The panel
> uses DSI command mode with DSC and DCS backlight control.
>
> Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>
> ---
>  .../bindings/display/panel/lg,sw43103.yaml    | 70 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/lg,sw=
43103.yaml
>
> diff --git a/Documentation/devicetree/bindings/display/panel/lg,sw43103.y=
aml b/Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
> new file mode 100644
> index 0000000000000..edd007e2c0d76
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/lg,sw43103.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LG / BOE SW43103 1080x2460 DSI cmd mode panel
> +
> +maintainers:
> +  - rofikkerneldev <rofikcoga@gmail.com>

[Severity: High]
The commit Author, Signed-off-by trailer, DT binding schema maintainers
entry, and MAINTAINERS M: entry all use the handle "rofikkerneldev" instead
of a full real name.  Under the Developer's Certificate of Origin in
Documentation/process/submitting-patches.rst and the MAINTAINERS file
requirements, these must use a real name in the form
"FullName <address@domain>".

[ ... ]

> diff --git a/MAINTAINERS b/MAINTAINERS
> index c88fc0e019296..e7e32c23ba2fd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15231,6 +15231,11 @@ Q:	http://patchwork.linuxtv.org/project/linux-me=
dia/list/
>  T:	git git://linuxtv.org/mkrufky/tuners.git
>  F:	drivers/media/dvb-frontends/lgdt3305.*
> =20
> +LG SW43103 PANEL DRIVER
> +M:	rofikkerneldev <rofikcoga@gmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
> +

[Severity: Low]
This new section is out of alphabetical order in MAINTAINERS, which causes
scripts/parse-maintainers.pl --order to warn.  Since a space sorts before
digits and letters, "LG SW43103 PANEL DRIVER" should be placed after
"LG LAPTOP EXTRAS" and before "LG2160 MEDIA DRIVER".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117123946.6685=
57-1-rofikcoga@gmail.com?part=3D4
