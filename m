Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BD146A60B;
	Fri,  4 Sep 2026 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788517907; cv=none; b=r3bdDKxPTQ1DzDogMq6+pYVxTg2fEWPExqh3iYbvhZjX4KTV8qtMMtXbw5fL9ASKAw+npvj+18JyQTj2bv5yCmpzQATiVuwu9x7JTD3V/79OHyl0JGJgz1CJ/K+vEw33tQU4Vi3jtkk+9vcsPc4fHm3rIaNnU7nrmGmMFqY2L0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788517907; c=relaxed/simple;
	bh=Xjh7tT0uI2pYMf6GjPk2jwUGlvo24xJgQl1WWEOO2VQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P5JoI2b7wYViSlEkRNspGfXru7uTiZs++77H2T/ox76frYqLOGWM0X+Ub8bE9BS5Anck0sdLttCLEAcQVKt6Nx0/ghJ2aAZEPz+2Sc8f1dwdtBVBquwMJbgYOqU5IflmeCoQbaOw6tvxWtcj6AQn8XT1xCu1NGt4TYtpa7ofz6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=nkvTuRkv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FYIE3Ajx; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="nkvTuRkv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FYIE3Ajx"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id ACD06EC00B9;
	Fri,  4 Sep 2026 06:31:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 04 Sep 2026 06:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1788517904; x=1788604304; bh=/nM+7dclz8bTkwQKTyb7BCdsGylCRsWM
	Xfgqy1Zn6Zs=; b=nkvTuRkvqNX7yBdrRs2vXxHOsY1TlO0+Hm8TZpN19ejbxcpZ
	peu9qEQikQU0GuatrCKCsi0S/yZjqfmTSePz8Mf17hmxcaul0naVWLEZoAc6peNz
	X7nRWnaDXrNST42/cqyEgXMsbaauZKraazVbXHpAAgWLRhLsq+zx4k5ncCs1MUH5
	uHZkpu+B+udU4vuTuYDS7hXLnTSM7TWWz7nEyE745VJ7NUvl61x/n33LVgCmdH9u
	rAjU/VbAyFUZu8LJkpSAWbrSAGLS2IHbXFuK/m5vEwS4pUBwCS5kGJWYZInAVK+H
	uMEngiUG7Edgcrv7oBV0sfvxRH2OthZq8xjrhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788517904; x=
	1788604304; bh=/nM+7dclz8bTkwQKTyb7BCdsGylCRsWMXfgqy1Zn6Zs=; b=F
	YIE3Ajx/zoJu33stgfrRnfJ33VllzIKz9SsZaaiY3uzCN0orN3DJdmSa9wfhdPhO
	Ed5NPjuhAAic7nvPdGN6PGS/XoPLQsShoBdFKlaB0IlHmMdGbw40Lv/ourlCkt88
	SDf7FHmQWuPczBMSW0GvFPtl+sJtgdXo6vkCZaKOxqZP3C6MPY6DOTPSHBWLTpm1
	5i0IWThEe2sJKzhZ27mwzds/J3eP7X3OKZFNXk4lWvDvMq3Nnic19BHR73KCRLWn
	zdYgXA1aR9UnlExOl3j27ll/S4eWFlWKupPA4fUkGwHV6lwuUPDCjf+lu358UR6V
	RDntXyu7FftAckrrOrDqQ==
X-ME-Sender: <xms:EJ6aassRf9xtpRKDHPYUD-kj0mpLWXnL8bk8YAOhL6Aofpn2bwE_KQ>
    <xme:EJ6aaqJj6gur0cHzd5IeyC6VpYT8NRsTVieeCl9KVjwwZKSuZ8Mvegu_6DlKBrpTh
    uwbNdLSBvpHAq0nNFUdikN8-_Xk27VTX092QPkG7W6K_FXdHki4ByAX5g>
X-ME-Received: <xmr:EJ6aal_MXEUq8163pggdqvgcqF9Zd0TxqGshuYEj1JztA-CNozcl-yY_YqxlA93qZQIjf4NiHj28PNC5G1-goBHyAkI>
X-ME-Proxy-Cause: dmFkZTF2SBZe7YcpwH0fIJro9dg8+LoFHkHL2HT1n8GLVDnfWYPFi510ghZHOd1b0/9wl8
    Cx1sKXv1pE4ZEiSSHADPuU8u9qd4Gt1SD1gCNdGRZ4+T4l2pyd34pBk4Q540rA4USeXvcs
    j+7IUqqywkAVYjEJ0fHK0PIPAFvqjrArM+uXPnpVh3jj5SPlbFB/J3GGpIwnHhGFt54m/d
    HqahjBahNmNkr1vDZvCiLjCrA/+AXwARP175mkGnCHDneQykh6CKj8bMi7ldAUhzFK0Kuq
    PoCsrSWDN3DidcrdS2x2qU3JvZZUQQ6njqaMLmJebWgESMoucOGi5OiX02uMV9/WfoQ+Kh
    +cKDBKpWqMpOz3fc/BAc1q2sifeChukwn6twwlMF5gJodXYaick23AKMoQFjMpyjabTgvz
    uUFRpvSxHH5qUa9BpmOClOQAd1UqdEdoF3ykiRHxHRVkyjU7RWrAl4vcwXR1wO4RipsJ8X
    NsMHSwA8G+B38bEtsl0WNILmnzfSWYiku0f4aYF8gWQhTHvFFz46bPiCaSOJ3u83x7fztC
    T/vjidFVHpoDtHHsKfKmGpciTr5zMAOJdS4It4I7Y4mjRJsK1x32BQ0Q1VX7F8s4V404rP
    +clM3h0MvIie47QVnV9T0N2kbVjCgXN4A+mBJC+sIX54v9PR6J9sY8UqsQJQ
X-ME-Proxy: <xmx:EJ6aajy-AQQ6oxWP2WCAqfPNrCJjAMAjGFDUKR7EaHmjjdgY3hJW8A>
    <xmx:EJ6aai5D0iDeTLvi5VGlXRaWbgFROmZxtfFuanvmwGHH5b5fgybnZg>
    <xmx:EJ6aaq_pskKB_YP1MD_vwa5REzJS5S2loG26ElK2KgCx8RfAekLGSg>
    <xmx:EJ6aanp3AefMoIEuIYc5V0KJHqqGWJJyJmv7Itv3H7x9cmfN5SjZWQ>
    <xmx:EJ6aagzv4ml1OtBrWMGEW6Fc0_zoJdhqLOsPPZ7jtVj_witUb3zDRWF9>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 06:31:41 -0400 (EDT)
Message-ID: <e4eda66c1a73f4a403ec10c50dad251f4b02af0f.camel@alistair23.me>
Subject: Re: [PATCH] Input: cyttsp5 - clamp the HID report size before memcpy
From: Alistair <alistair@alistair23.me>
To: Linkai Gong <gonglinkai@kylinos.cn>, Linus Walleij <linusw@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, =?ISO-8859-1?Q?Myl=E8ne?= Josserand
	 <mylene.josserand@bootlin.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 04 Sep 2026 20:31:39 +1000
In-Reply-To: <20260901122649.1173066-1-gonglinkai@kylinos.cn>
References: <20260901122649.1173066-1-gonglinkai@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-01 at 20:26 +0800, Linkai Gong wrote:
> The size field comes from the device and is used as the memcpy()
> length into response_buf, which is CY_MAX_INPUT bytes.
>=20
> Fixes: 5b0c03e24a06 ("Input: Add driver for Cypress Generation 5
> touchscreen")
> Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>

Reviewed-by: Alistair Francis <alistair@alistair23.me>

Alistair

> ---
> =C2=A0drivers/input/touchscreen/cyttsp5.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/input/touchscreen/cyttsp5.c
> b/drivers/input/touchscreen/cyttsp5.c
> index 9266c07314be..e878a02dc9b7 100644
> --- a/drivers/input/touchscreen/cyttsp5.c
> +++ b/drivers/input/touchscreen/cyttsp5.c
> @@ -710,6 +710,7 @@ static irqreturn_t cyttsp5_handle_irq(int irq,
> void *handle)
> =C2=A0		size =3D 2;
> =C2=A0	} else {
> =C2=A0		report_id =3D ts->input_buf[2];
> +		size =3D min(size, CY_MAX_INPUT);
> =C2=A0	}
> =C2=A0
> =C2=A0	switch (report_id) {
