Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794421456;
	b=wXhc886psHW319RAafv20x+MuRJWYFrXafPfq7sqhSW641d7+PQLpdbc/y1WlyNqTzPx
	 Y+i1yV6qbbBnJcc5AIFNDN4nKJi/JZKkjldWtPXvdXsxwDdQ9JAHtFF54dEPXAbvvy+ro
	 g4yqTLlbVyefvFp75KvFQBtSFbZ+3vyU4IRQlqWe5zf/GF7Vmy/O7UQH5rIL4o7WZ8eH/
	 0PPd7doT6fvGz3I2r6KHJPnjpfM8B4+2fO0HyUj8j2xqW84CYev1RHfxOzGt/IwwNmCrB
	 KphrSrfuE3q5KK8GGum8vQynDPur0PDQzr6QhcOMd3lUdmIqbFekTZMbQfFYeV1PLRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794421456;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=T/Cug62F0T5BgzSE9J2QbWqWeH1HDNLx89W6EJ+jfRQ=;
	b=OLpj817oJ603sJ8C0ko/RfAX3FhcMP6E+XUkD9tllY9HmIxow01rykPMC8uRqrvqiL0Y
	 ZpjOo9byjbMHXsZWvIDlCdVERBG3TR81vL+vFA2gx7hYou/KR63QDHMekbBztpX0KZW4J
	 Pi6EWvY3/jtbZQhEU07HnYS5Ut9wo4kfdSc7WZJdwue5RVlmJ2nfzHWzBRlB4ycHr7/jR
	 BXF9Ww4k8z37izUE/jxvggIyOnV4Gksrjcy94TWHA46l+OhuKE2YJjwPDHwsth79Yxe8c
	 sviuVa0eLRsH3Hi20znHVd3sYmv0Y1crlv9e8am9C99uRpaxrrzMsYVk/lvf3fQP8CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=YHRBSwh3;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71540606A321
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 18:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71540606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=YHRBSwh3
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso23958135e9.1
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 10:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794421454; x=1795026254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T/Cug62F0T5BgzSE9J2QbWqWeH1HDNLx89W6EJ+jfRQ=;
        b=YHRBSwh34NIYtfsSjPBrTnkaZbIbigUxfp8ODDzdV8X6YSbbi++f4LEOnWXiYqgHW2
         VuMN6iIUA69gW4m4+jfz16LNttaRLPG7F02zWW83MEkgpkr2FYvWCxwUHtXh5YR67dwc
         l3JPHMih96I4AlM2djClT1/xt3W6rQ3zNP4vELcqx6Y4ZMyskjIxYvib5bXOPIX2yHFI
         c9Zrnl1d2JvSbOeba2yoKTTpIvz+y9fGyUJukkdUJvuVtdtroxaPEA9M7xWU/sZo6Wio
         kb0JjiqE+G58D0rxnNlT+a/VeYdFrJRlhblAR7kVBdLkiwuOl/w/5owlasVibv9OC+x2
         1UsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794421454; x=1795026254;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T/Cug62F0T5BgzSE9J2QbWqWeH1HDNLx89W6EJ+jfRQ=;
        b=lL5fGJGmSEkD/p02r1rk3x31oAYczqSJYi2r6EAJyniRYMD2VUCSumWPZC3Kp4Q1gp
         /ZwiYu7o783M99z6Ikrp0uPNsiJfX57Enf7r4lJ8khmLiFPjQHS7dkd8w9hYGVJrMRbO
         ylITLFdANi+zn5mX4goN0lCLdHI5Hi5+Z9jpDY4pGrpcw/JdWfcgoVXYR+fL2AAHV2jS
         4AQO4R/LeeokCEZ5Zw8TknIkaTQdNWYottZ8rxlMIRJ+taXZP+68svJKkpgZkTmQ+jXG
         cYHz/b/o0QDjC6j+BmnUCyrWMlVzZDeecz+pkUcyvaBpAnXE4Nj9pbUYQ5d8yjSo+MYN
         oRLw==
X-Gm-Message-State: APuU4Z/+WZt7Y31sRaxj5XJgVeGHieT8qgRUdCZsbsKXaFAb7hxCPVu7
	+h+fioQB0jzp+Ci9fIJvb8Yj5TRUWuPkQLy4IrVJR24/LXBiO1/b0UAdiyCyjxL5GOc=
X-Gm-Gg: AYBFou1q0e65ywdhZCmWaVWBqtxUFSNTN5cS+SoJqpWai9l+C2+7QPQ6zAyRfvvkLhn
	LFKdeWsfwo+ZlqfLtbMDEuwuSKZU2PzO9MZPoKJZ1Xi48QQYGQe1dQ+WzZsFQBsMApachTUP0iQ
	IHwlQX2sIisi0+bowEzsBhvTF5nJ3H7zQxjRLE5wCjtUm293MOP6sAMaJHXH0IMeS1Rwjs5oO70
	U1euwrPIC51iXe1GTPxL4oyZkC3EXRzgap63jyYslQLfMpiNZXy1aZegq6P7tMEtcBPpaZ6t1Bs
	zzO9FQx8n/CJfvm3nEkjqfiWWRbOM5eyp32t9yQnvESzh7mr3INCjzNVKf8ORErHxEEV6hHKGvC
	52nxI4xY20xrQo/oi2/xb9EVo4X95VEPjPSP1RWjYapi9ENk2dyyc20JKexmcCM8xMKwwq0sBAM
	gpGeoDwWIwaCWkQbb/gwCtp+3enLsSuMmbmNr2tQqoAEM3HxoqFDK5Ff12VmzZuve7sD3uCct3w
	XJz7MU4oMBLveosEh995Sdm9uF12LruasmwoXGM73iMV4V5ArKm+Gf6cNTm0/kGEQkgpNokuDsb
	AnTmy3DC1B6UYv8/OQ59fUet7/PJjuub4UCxuDZ4a39nIuK2ZiLm4iGaMEbPRy/voZK2JkdhNRo
	ah4z+5yRRaDJ0hX9eYg==
X-Received: by 2002:a05:600c:810c:b0:4a1:fbd2:f689 with SMTP id 5b1f17b1804b1-4ba09379cc1mr53582795e9.7.1794421453796;
        Wed, 11 Nov 2026 10:24:13 -0800 (PST)
Received: from localhost (p200300f65f19a9045674a4e2f3db58c3.dip0.t-ipconnect.de. [2003:f6:5f19:a904:5674:a4e2:f3db:58c3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb4e251686sm7879725e9.3.2026.11.11.10.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 10:24:13 -0800 (PST)
Date: Wed, 11 Nov 2026 19:24:12 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: Fix comment about header defining HID_GROUP_ANY
Message-ID: <avSynjK8ZIxQ3Wfs@monoceros>
References: <20260730204136.1606050-2-u.kleine-koenig@baylibre.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2y3yufkwod7zojzi"
Content-Disposition: inline
In-Reply-To: <20260730204136.1606050-2-u.kleine-koenig@baylibre.com>


--2y3yufkwod7zojzi
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] HID: Fix comment about header defining HID_GROUP_ANY
MIME-Version: 1.0

Hello,

On Thu, Jul 30, 2026 at 10:41:36PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> Since commit ad428f5811bd ("mod_devicetable.h: Split into per subsystem
> headers") HID_GROUP_ANY isn't defined in linux/mod_devicetable.h
> (directly) any more. Fix the comment accordingly.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>
> ---
>  include/linux/hid.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index b240baa95ab5..56bd7f274387 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -424,7 +424,7 @@ struct hid_item {
>  /*
>   * HID device groups
>   *
> - * Note: HID_GROUP_ANY is declared in linux/mod_devicetable.h
> + * Note: HID_GROUP_ANY is declared in <linux/device-id/hid.h>
>   * and has a value of 0x0000
>   */
>  #define HID_GROUP_GENERIC			0x0001
>=20
> base-commit: 95d6a9ccef99117115e41e9adb271243bd5e985b

This patch still applies to next-20261110. Is it still on someone's
radar?

Best regards
Uwe

--2y3yufkwod7zojzi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr0sskACgkQj4D7WH0S
/k5uBwgAj7m3B+KJTxJ09WwpnTqKGauOlsDjImVnU2Ev2OhtzpkeIPRBVvEnb16X
6L/rJHa6WFpeju41JGEvT0ZrSAlCiI2pGkmtQlSJTGhw5zSj2oNpLWv24dwPHBlp
ALpXbRYLxlaJ61cGMCvHk2Bv4oCwwPt3eqv5y0Z45f3yyjnA6Soi+G142v2mcfyg
cugcqK2ZEoxLC5IMQYoQsSdGYUvepvZ2NOClUStwk10YBC2NmGgwqxGZk25wniYa
FufdSUpMe1KmCam87ux9xoBXGU/gIPlH7uavpJyTmSRBR3aZMdqPMsA/LxPxnJ+b
ET/zQC4TZ/OBqodl04WATqTgyMzriQ==
=KCRm
-----END PGP SIGNATURE-----

--2y3yufkwod7zojzi--
