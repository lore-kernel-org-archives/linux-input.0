Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795265283;
	b=TkFB+s0UwT90hiGmXYvS+n94HOpaOXFGPuLXnBHfKcxSJbGHUQHES9/CbqKDZBYfbr53
	 pDxk7g2RUQEVTVBk2jCJk/FB8iYCdvIdbKUGcRV6K9GN/96XDGrzH3ie0f/kJMsN6Mo4c
	 pyxrFYyRA0Lu5cLBBl/kFmiHZIJhEzeC9NmqZF/FJHOYWGtH5miwbpklbvoEBY+nZ99fu
	 V9dKQLqDNPqqHn8PEOdOxJZSrrUuzS9UPpUApoeXl7RXchxpLq7810znWM11MlJ8tjmH0
	 IPp4yat/jjL+KZ7SDNKwO4lsvmEMHB8NRMyeg5IYhwDSok6j6rGDU/MfB1ilXvM+WNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795265283;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mbs8yphZYSdgLesZ5UwYWWAr05LD56b8iNCr+g2EdXo=;
	b=bVr6D0q361Soz13KQQX+gDQRrCpUg+VfBJi9iW+pscviNaLshsOGrEcF5tAm16YBmR5A
	 geDEa6KrYaxOQvsSxzK8evKpAF0ER6NEnIUBgm+eUbtkPrdsh5LP0xPlyWx8o87cn74aP
	 MgLbMQryj/wSIqsF1jxTaaUmW/ucee4K5Hl7jpQ1OHa9vhJ2/6+AHlkn5wW7E1uA4OiqV
	 ZgVkBE61AjgbYohx/wfUKHJHjpduc490kUZGA+jpoVXeS7rHS/7Qp9dHNgQEPI2eTD5N3
	 055dGEYgAjSk93xhPD3RrEPzHmb6GqwhIk8LvWPAoDcI3eXwEA95UQSJHxlzg6ikjIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cGE5xqTf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6A3606A320;
	Sat, 21 Nov 2026 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cGE5xqTf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792F41F000CA;
	Sat, 21 Nov 2026 12:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795265282;
	bh=mbs8yphZYSdgLesZ5UwYWWAr05LD56b8iNCr+g2EdXo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cGE5xqTfAg+CYuSkim5zrKDXmZNZlPwECNARUsWn3mretAbdzGVokQmTpmVUVGSFD
	 vGheXsVAIxvyZoWCl+xWxhN5naY7WTJex5+E/9uneb+cPY2hVjjdN3RguZsRV22PSB
	 XFgIEuh8GN/7u/pZEzigeDkW85m1m7rLrtaSvkm+00FkRTmEsBuihl+hSohxcUfY0k
	 D5Nu5fxBwIz/HQ8vxreJi0vrDjA4F6YZt7iyuAd6t0vZrFD7b+9nQx+cHxIli/yfmt
	 j6IbsFIUsEp7ng0/635H0CrqEmslJbVrCiA86Tdqtumj52BUIzJrUdEa4ZTUoieNp0
	 LlSTbtdZA751w==
Message-ID: <sashiko-outbox-227023@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 09/13] dt-bindings: mmc: add SiRF AT550 SDHCI
 host controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuugo Yoneda" <yogo.0917.sabu@gmail.com>, devicetree@vger.kernel.org
Cc: linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261121-at550-rfc-v1-v2-9-b0309d0789b2@gmail.com>
References: <20261121-at550-rfc-v1-v2-0-b0309d0789b2@gmail.com>
 <20261121-at550-rfc-v1-v2-9-b0309d0789b2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 12:48:02 +0000
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
- [Low] dt-bindings: mmc: sirf,at550-sdhci: interrupts listed before
  clocks
--

commit 7a97d09f5813c4b58599decfce4e11c1cc543404
Author: Yuugo Yoneda <yogo.0917.sabu@gmail.com>

dt-bindings: mmc: add SiRF AT550 SDHCI host controller

This commit adds the Devicetree binding schema for the SiRF AT550 SDHCI
host controller and registers it in MAINTAINERS.

> diff --git a/Documentation/devicetree/bindings/mmc/sirf,at550-sdhci.yaml =
b/Documentation/devicetree/bindings/mmc/sirf,at550-sdhci.yaml
> new file mode 100644
> index 0000000000000..ca0c7c4146740
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sirf,at550-sdhci.yaml
> @@ -0,0 +1,50 @@

[ ... ]

> +properties:
> +  compatible:
> +    const: sirf,at550-sdhci
> +  reg:
> +    maxItems: 1
> +  interrupts:
> +    maxItems: 1
> +  clocks:
> +    maxItems: 1

[Severity: Low]
This isn't a bug, but in DT binding schemas, clocks should be listed
before interrupts to follow the canonical property order (compatible, reg,
clocks, interrupts).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-at550-rfc-=
v1-v2-0-b0309d0789b2@gmail.com?part=3D9
