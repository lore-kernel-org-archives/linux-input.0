Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794551339;
	b=yqHovAVEJiNYm/23aF5u0+YYXN597bpuvCW9jww7ZwybLvNQdDorKifxILYuNgbyHBsg
	 kgzB3lPPenfIjbMf93enQZFxorV39A0N3b6qFt3rq77ljKtm0NSVyxSr9/RwwxBjvdN0a
	 T7HkD94oNHe2YXEqHBSJMDtYoVEU96SF6efHEHOVczgtPxJUU2V/cC4KG/xFqm79e8x6D
	 Q2NrvArpp6BtrV7QZhFmJVaf7H2bFp/ry7KEywytO+yZZE/L97dLsMRLOFRmVsDgD257T
	 oR3OUNSUZDecp837UIuyhTg+A9YQ+gkKoi9WrN9M6YBjAc1ZjXVVLyXMD04g+TbmSyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794551339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=eMtI/QvyBu7WYuIQjEeNFc1ytajl1TcdksT1CryvP7Q=;
	b=1PEpJzHNkQp5l0pn5Lwv96TwbV7/3Nks8VzCQglghwSNdvKIXRJdgfyLPpNEMaau0J5J
	 M4MRADluck+Oeg5vKlJgaPEZtiNIMM9sYtrE7keBQ8q1yW2jBnNKGkvIqKXVyrU4KJSP2
	 3GM1+WO62BrfQPlLdnhIX+bCdDGN6HhhoJUoUEpq+XRMmaP6k+01ciBf2jmdmPGJgP/0K
	 o2g4tugaGlC8gujiRTwNdcc9JcEgPfTTPCytWgyef1ZhWDgQZ3qYM9lik1w0gphPuhPpP
	 J2tuGKNXL06asRTrxHi2iXbDfoLzFi+F6ErnbV8UgiBy7L7DJB1iqkFDoDkNG9LfaAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=cz+kn4Du;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A050F606A31C
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 06:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A050F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=cz+kn4Du
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-491846221ffso537288f8f.3
        for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 22:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794551337; x=1795156137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eMtI/QvyBu7WYuIQjEeNFc1ytajl1TcdksT1CryvP7Q=;
        b=cz+kn4DuwLvFxEnT1RdO8AR1F0oXhLYwqMLGi15pJafOa2ZLuQePGzmS7ybyfi+k4R
         WYiiGoHG3sb31cMtl1+ZxQbkXtMAi4UZF4EvnXICafNJ5fWBMHe5WQVzeeJICIx8nvsH
         LiOi25YLkt3ocFE/UzCKppsR+wA1Ug5dI7ymde9WPwJ/rIZEJ2Alei2RTLNgGDOgUOOA
         /k9+0wb46DDy97V5Idh86mkwudDy+7/Mqg42ecANFcVbDlMlQ3gtFoeW9H2Dr8MOqVv8
         XMiA3LXF49UOzeEfJnuFw3IdEUPHKbg0Jps4yu6DcRThZHDg5FpWnNmI7Efa2m/LQQuN
         h+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794551337; x=1795156137;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eMtI/QvyBu7WYuIQjEeNFc1ytajl1TcdksT1CryvP7Q=;
        b=qg00831Me7dvRwP0lGntnkWVrr0oEDlR5XbvhRKr69eVJPuC1pUIVdkTFbKKgw+gr1
         bgDrlTMRwG13OPwzeKU0cx289LBrTgB8y9H1gwa9smFmfojcY0OkVpM3EtmDEVafTjnL
         A2pXwl2Kp24uWGhNhXR8u3IDKvIY1jtMA9SAnTMnmWyTzTAyJAY2myoUMjiySK0eIgs3
         mv3s7j4QPtsZZE4FZ7+FhWrXSKt3oP6/eS+os06HoSdqUHl6lsZGk7A6xZX4n9+J6yVX
         UWk4D/id8jPpJgQkK7SnmOTHa/oENqlEtE4LeeFVBLHbK2k05FiT78AVLjbwubT5c618
         xDIQ==
X-Forwarded-Encrypted: i=1; AL+hErGpqg/bd50TCLORPh/EnIjHYbdE6VHMIak6oaYPXF4cYFv+ViCPD2uDbjQ2h/SU2SawmA7n7V9fC97BrQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/p8AKnx5bJuazHNkBMVPl2Xi1LiZoo/3UANmIx389Tuv9xiR4X
	ke9EzkCQ3cIO61lhdMSIp65quOEkTR8KAToQGcgXc9/gBS0rfhzFZOvnR2LwY7QUGU0=
X-Gm-Gg: AYBFou0le23CJnRfWHw0XBKo4SS9mZtlZ0kxBYVhKCtxboMtZioUd+xj2lJPcdlA3UN
	9F/X15VXqkdxzUtmA9JA9jt/X8BkBqUOTL0/V+U0oQnVhkzr01c7uZKcHaUsMFol6Sur4NwAN45
	wrLTBxCpeOFIz14vau/9YDMq3a8Y1xht7Uao5cByMFK4Ydw+aTGKfK+9wASsbQCF88klrxxIsya
	u9xu1pEiIGrRNyfQjdyIPpsB4U+I2yfUkx7jJ9PW7WB7dJgMlfgeemPbpScWZ9n9g6iZbTKV50+
	AGRsAFY56MAPC4OI37V45Cv8OD7FSosa/MWil6d4PAPHwjrR64FvCRS5bQjg4fZdbwkw8TNM93V
	JStKJnxpeouCteQH8VIJxZPdoPrTYkS5+MluPgWq4NDQSPeK3FEOQxg6NvDnHGALxzl4j7aXcH2
	sdCDCwkQf5+DFtKHEbQUJLsIueQqWpbLvJPyYimabRY7t9KKrNk7VmqlNb/TOupOGFEg/k5a+ph
	mBO99hmFoxThhaIjus7Ia/fhkA4LPQdNcai9ld10SeStoC684h+1Ihlg3oseasbcIXaatKiRVCq
	D4ZJ7uXw6ZrGqVQZjGEx5BpvJEiB/Jim7NJIySMhlNR6Y8vQgugZCdv4sU1yv1Q8nDWVbkqYEg=
	=
X-Received: by 2002:a05:6000:2586:b0:48e:2f7e:bdbb with SMTP id ffacd0b85a97d-49c72c9c8b4mr3464138f8f.50.1794551337038;
        Thu, 12 Nov 2026 22:28:57 -0800 (PST)
Received: from localhost (ip-091-089-005-024.um28.pools.vodafone-ip.de. [91.89.5.24])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-49c5fe373casm3174771f8f.30.2026.11.12.22.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 22:28:56 -0800 (PST)
Date: Fri, 13 Nov 2026 07:28:55 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Feng-Yi Hsueh <fyhsueh4linux@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	linux-input@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] Input: keyboard: Add Nuvoton MA35D1 keypad driver
Message-ID: <avatz4Q8JbrAJNn_@monoceros>
References: <20261110111419.89535-1-fyhsueh4linux@gmail.com>
 <20261110111419.89535-3-fyhsueh4linux@gmail.com>
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
	protocol="application/pgp-signature"; boundary="a2ifqpif6owwxnga"
Content-Disposition: inline
In-Reply-To: <20261110111419.89535-3-fyhsueh4linux@gmail.com>


--a2ifqpif6owwxnga
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v1 2/2] Input: keyboard: Add Nuvoton MA35D1 keypad driver
MIME-Version: 1.0

On Tue, Nov 10, 2026 at 07:14:19PM +0800, Feng-Yi Hsueh wrote:
> +#include <linux/mod_devicetable.h>
> [...]
> +#include <linux/platform_device.h>

Please don't include <linux/mod_devicetable.h> as it introduces a bunch
of unneeded build dependencies. <linux/platform_device.h> is sufficient
to get of_device_id.

Best regards
Uwe

--a2ifqpif6owwxnga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr2riMACgkQj4D7WH0S
/k6KPAf9EQ0HGivhdceUuk66CUKDwtvjh/7/jjrthGgkb+pdJryDbkedlXcCKjK9
b+TSwyp0Ij45TIIFMN/ZFfLea+1FM3nTPndVlZsIIDgJctKr0b9642hqhFrvkbPy
57e6YCZlJnH+P0baX7Z7JCgbPo34/RX6nn3dmY96cVDPx9nlO82bZlUKT0+O81nc
6nAdhy73QjVG7hEQYipP7SJUFRNOCOBxqjT4iIelWp8tvmFrMUdux3Yi2kmSL405
R0HXdDse9VWP/awUS/rl6ACGhds1ZJbh03SA5seeuZxX/6xVqbyap9pvvDIndv21
UM+9r6MVkXax2D6HXkYWSiATc2X9cQ==
=FoqO
-----END PGP SIGNATURE-----

--a2ifqpif6owwxnga--
