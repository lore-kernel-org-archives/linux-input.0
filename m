Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795369890;
	b=g4BSMV7+W/7CFOtefyKJNiiegAlUVhxCIq9WG8VvphoH4qRlvs4S6iik6c/tQm2ZpAlP
	 O4lWBwGJnjY9X0/cEkix5vqIt18EVvX7pH3Vrb/483njjJrFcB4YV/hiK1zO2j0NFkgX9
	 Qh0mRlOUa9Rt0EUbC6XdwZ0HnndjStSYjuYpaVo8Jc1LMy4bLPDzWKip4biwA/Ew6Z21R
	 XCD3wekwD3djjxKWG3H4Y/nHy0FiMxNmkXy/+XXmBwUmjr2bptKxIDeyiOdodT0h345Od
	 mJI6kt7YyDBBvcJI084ln/noo3wA0SbmKoE0XPPOqn7UpNCs853W+uLsa/NLO/+DgOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795369890;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 From:To:Subject:X-Mailer:References:In-Reply-To;
	bh=1yMVaQOiv9B9KFhOF3+nr4ODmkWDhOk1vIMDXuWTipE=;
	b=ofiqsMGRYSJOIPeld8KMmfrZjRa681f8LVRCxABGZZ0oSLuOGq6mvSeHPEY5qByQjAIo
	 I7oqD3wvvV71BqgbkwumlgyYm8XyxM2vtwYFzS8I0gZDLmahrpy9ry61MYMNuonaP4FDb
	 P81EwPCT5Bg4CQ/hxN6YBlrCjU8hey7mpdojvch9qU909gFHzG7AemHaADTAWPBqiYw8r
	 3FJnuDovN9sFBIUkKGSATKymLAWhkx+tObH5tALkAfqh0R1ptowdZj+A1l5T3InoUh9hb
	 3v8hHh7stELEdIRYGJMWczh20X9lBBmOVQuR3Z1fAby10oJj1vEZpzcG1H5CD3jQLHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ocIXO8tt;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9AB606A338
	for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 17:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B9AB606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ocIXO8tt
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b8815693e2so2853384a12.0
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 09:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795369889; x=1795974689; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1yMVaQOiv9B9KFhOF3+nr4ODmkWDhOk1vIMDXuWTipE=;
        b=ocIXO8ttGSav0YlCF+6rCaq8/A8X2+hNimH0KNNt7I8Z9pOrjNimf6xfgJBVch5CGn
         KdCLCmQvhRJQmg+wq3LCmcS/aWe5jMCrTsvjj3iLIKo/Vvy32mijdyC9QMACnldboU5G
         dHAjOx0ZaXPBXk/nJRlk8HKX+DgTHqUzs/37rU8qLYE7Jo+VJgwyk+BWvT655W93m3af
         xGZ/d0wGUIkj3tukmsQcJZ4AQywSoBoYmLdHbQ2qQdQHp5Y+04Zr/Jspmr2v0MCB3XI+
         4kWCF8bBWRHnzBedRjqt4a7KGLvIHh2yn+lvE28DhKfqTK5SnwZ++0TTbvVpqox0w0zr
         QVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795369889; x=1795974689;
        h=in-reply-to:references:subject:to:from:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1yMVaQOiv9B9KFhOF3+nr4ODmkWDhOk1vIMDXuWTipE=;
        b=iUC1KHaSda1LvGsdykoeWP4si7eJmrjxzJzfnnvjuroikuUWQEs8rCaZNaDyY7dWsw
         dOSqy7rl5aPqIoSlEhEFuV2ZCfUtHAhBOhqP8fLfFphIq32c5nUoDm7uOQ23taRtsqth
         XVFZXV7RFER6atZYFhkFgxk/07PxB0579W6eQj6y5s1/6yH+Ehc6avL0lCz05mvmaPU0
         jMbyrAUG5pv2NTdhLvyFEtVx2Sn3L574I2s0DUITwXDBEPb/kW/Sk1a7cIXaF7pkMWax
         pNLzgQGjgLpDWce0QenUwQ/Zt6O/keISDJUpMT1bOos8UgzWn2TGPOqZQFttWPQ93gPp
         49fw==
X-Forwarded-Encrypted: i=1; AL+hErHW7V80E6+hdfJ8uBUXEg+cAguqJD6Dj95wyGuRL2fzff8Q9+TiabO4MLgwuNuxGSBfxG3ASEwpUMmqeg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/aiG6PUS+HcIoLkv8JcDQ0Xd81ohYXLER0IwBjyYCtb6cVhbUe
	Xbzl6/+Z7R6rb8SqiUo8xxjMolIiYGCcvOvca2oWKR7RPKHqRSvb/Uiu
X-Gm-Gg: AZFdTZfhI/CCj1/sE/8YAH7HupEmcTLeHA5xmPfMGdIz3n4/MSY50YVu/LS6w2XH8A/
	4wuCRdhdUtTMtWD+EyW4oxTkP5fAvkeXVSPX5CKOPFTVyr0sBTWAJFYgJxEwl2Zy0D7HWlIy+oT
	/kWJgAspOJM2vn31oHbkAfqAIDjE8903hu3qc4CoNTUlWktl/wAbFRji0Ic5LrMsa2lzTk/EzA7
	n4ZVsfQ7mPVCUDw6TcrZSmlmkackXL0weHRxaEQkHLIM/Z9d6Nrr7H+9Yrx8hmNv91PxQ5mD5Bi
	dXorQi7daIbLe1NVULHxrEblTeCfKMoF6MXw+bZu8Zkt9YSHBCX2CBkqCT9/Uj5xF8uRv4W0c8n
	LM4UBNUugXb8MqQU7gECkExeIn2Rgpa5h1oasgtbC9oMzOcF4xNtkYrV2UVixVg6z65Z8zBqwkH
	h0CtEdJQ3Yu9EpfBZD8XCb4zY94QCemSszHiEFKtU6Dck3e9M4AThuI4SIzXPTTMrca3eLaaCMS
	6MOHVj7BxqetGtcZhZhmNZqm7S2iEMJV/7r7qOlFPspfSAPdmNswVWUIdCM+3vo0YsEgs3k1X8m
	YcnzTPVO8d0a2w6G+A7roRranEQg0Mshi7Gc8ZAb0Ns28NUAkQ==
X-Received: by 2002:a05:6402:350f:b0:6b7:d189:6044 with SMTP id 4fb4d7f45d1cf-6ba37e64b27mr6482678a12.17.1795369888545;
        Sun, 22 Nov 2026 09:51:28 -0800 (PST)
Received: from localhost ([2001:1b81:1b55:aa00:48b3:8eff:fe5b:7d15])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370e8adbsm4246918a12.17.2026.11.22.09.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 09:51:28 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 22 Nov 2026 18:51:27 +0100
Message-Id: <DN1XIBUZ90MF.2JOY3U2VDD3ZP@gmail.com>
From: "Oleh Kuzhylnyi" <kuzhylol@gmail.com>
To: "Oleh Kuzhylnyi" <kuzhylol@gmail.com>, "Daniel Golle"
 <daniel@makrotopia.org>, "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Hendrik Noack"
 <hendrik-noack@gmx.de>, "Arnd Bergmann" <arnd@arndb.de>, "Ferass El Hafidi"
 <funderscore@postmarketos.org>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, <linux-input@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] Input: hynitron-cst816x: respect touchscreen DT
 properties
X-Mailer: aerc 0.17.0
References: <cover.1790944534.git.daniel@makrotopia.org>
 <75b8436b900ecdce7f29513a7403b851986a3a1b.1790944534.git.daniel@makrotopia.org> <DLWC73DK15W4.2LCL8MREV6FDM@gmail.com>
In-Reply-To: <DLWC73DK15W4.2LCL8MREV6FDM@gmail.com>

Looks good to me.

Reviewed-by: Oleh Kuzhylnyi <kuzhylol@gmail.com>

Best regards,
Oleh Kuzhylnyi
