Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793894018;
	b=O7bFg6/noVEvTclnr2185Xs05Oifnril5t96BIpocBuXi8Aa/m7q3OMcJgoma23Wgl/n
	 eCktkpOWN+REdLZUkx99npZjcmPUAkcRvq5U2W37Hu6WjOYdI4+BlSoHDyaJvMAIiNQsc
	 /aaIaqjJWP7EvuFbgjvUpQjfHV4sTgmmP7u3sz6nm7CVU3hBRdZh3rjbiP7CzDcP7VY+8
	 iHr6gi7pUPlO417n5iICSSl7fRY7ltohwiHXPmtIjYJBFtdefVCNv9hyK+El/U20ehr9Z
	 Ce6x8HEZrvw4yhK3TP9cE3EAyTgd3VSqYjW59i/Vsaa7d2beit9qGoK1w5ld/kTY97g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894018;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NpiuQc88QJ0I27SQ8ytpfc2Od32zRylhCgjrQ3y3TY8=;
	b=glgy0HfXQseAh++pMQehMR+ebMdhNex8rm4Ut9vv9DASArLELoyiCCeOv2MA7hoi6+5a
	 YbNo1UIvYjj0EbFfma1fXX/KorgZX2/B7cVyT34/QQ8gCHxCD9BKiNbII2DhHQneHovRn
	 S0AY8utEmnFjoKWKwivwMYOnWK9OxnKxXXYoAVRgZfmOt6piWem3A9togIUgTXtlh/XRK
	 YAnhF1ZOspjrUcfr8qrgOg41KFR0d+tnBEu88F7sZsXLbe63TDAyNC0pOg60ZOEdsGs8O
	 zuBq9+qIxKY8Wp2Ym8XIMCQ8wUmNHNtHvy6YullHmD28tJ5R2Cq3BQ0IhS53CewVzAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="guxQ/B+Q";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E848606A331
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=guxQ/B+Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D8D1F000C1;
	Thu,  5 Nov 2026 15:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793894017;
	bh=NpiuQc88QJ0I27SQ8ytpfc2Od32zRylhCgjrQ3y3TY8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=guxQ/B+QvvJqijnSnudqcXZSeZ47YmCvBx96488UpWH5/tiuaCFV3U1tCpv1QgG/M
	 2EDtKrgjCmLpRcvj2CgPLvWFU1SA7crYMpyTc/cr/njMnnifAMONidoGbPUbumErIK
	 fyv9rNKlOLpmjZDo0cFefmy4+dr0u1li1bswGTbT6vEOpevEvLwZya4KFTqEphzShO
	 Au4TCIFK85so7sZczuy2HHLys1A0rJHRDEYVo/t2lsWlfzu+8d5TrxYq/RTrt76uRw
	 xYbql4dG5IzaFASmeCWOITOnXrJ0aqdtsf+/v3rFlbpNqh292sCrXD1YCvtH54I/Tw
	 C5sH/9XDOo3yg==
Message-ID: <sashiko-outbox-199362@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Input: lpc32xx-keys - reject matrices bigger than
 the hardware has
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanglei Zhu" <zhugl3@xiaopeng.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261104030709.791761-1-zhugl3@xiaopeng.com>
References: <auos7TgVNv7EWnbj@google.com>
 <20261104030709.791761-1-zhugl3@xiaopeng.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 15:53:37 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Input: lpc32xx-keys: undeclared LPC32XX_MAX_MATRIX_SIZE in lpc32xx_=
parse_dt()
--

commit ae2a42c5ed13c05919e7d77f5f4978ad957e69a7
Author: Guanglei Zhu <zhugl3@xiaopeng.com>

Input: lpc32xx-keys - reject matrices bigger than the hardware has

This commit adds an upper-bound check in lpc32xx_parse_dt() to reject device
tree keypad matrices larger than LPC32XX_MAX_MATRIX_SIZE, preventing
out-of-bounds accesses to the lastkeystates array.

> diff --git a/drivers/input/keyboard/lpc32xx-keys.c b/drivers/input/keyboa=
rd/lpc32xx-keys.c
> index 285d5c32fe70f..b7cd968311cd2 100644
> --- a/drivers/input/keyboard/lpc32xx-keys.c
> +++ b/drivers/input/keyboard/lpc32xx-keys.c
> @@ -65,7 +65,7 @@ struct lpc32xx_kscan_drv {
>  	unsigned int row_shift;
>  	unsigned short *keymap;	/* Pointer to key map for the scan matrix */
> =20
> -	u8 lastkeystates[8];
> +	u8 lastkeystates[LPC32XX_MAX_MATRIX_SIZE];
>  };
> =20
>  static void lpc32xx_mod_states(struct lpc32xx_kscan_drv *kscandat, int c=
ol)
> @@ -141,6 +141,12 @@ static int lpc32xx_parse_dt(struct device *dev,
>  		dev_err(dev, "rows and columns must be equal!\n");
>  		return -EINVAL;
>  	}
> +	if (rows > LPC32XX_MAX_MATRIX_SIZE) {
> +		dev_err(dev, "rows and columns must be at most %d!\n",
> +			LPC32XX_MAX_MATRIX_SIZE);
> +		return -EINVAL;
> +	}

[Severity: Low]
Does this break the build when CONFIG_KEYBOARD_LPC32XX is enabled? Both
struct lpc32xx_kscan_drv and lpc32xx_parse_dt() in
drivers/input/keyboard/lpc32xx-keys.c reference LPC32XX_MAX_MATRIX_SIZE,
which is not defined anywhere in the file or included headers. Was a
#define LPC32XX_MAX_MATRIX_SIZE 8 macro definition omitted from the patch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104030709.7917=
61-1-zhugl3@xiaopeng.com?part=3D1
