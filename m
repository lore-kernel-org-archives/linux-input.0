Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268263101C2
	for <linux-input@vger.kernel.org>; Wed, 25 Feb 2026 21:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772054828; cv=none; b=CKQ6NV8PNR1WWP5Ft6KOajWTPSKc6xTYOmabijr+fm7yinNk3al5C04gNrB/KyAQSslz0TUAZyWqbMb6m49aUczs+M3US79UIDDgKzpxdHEKWP85q1gYY5Qs5XkBzLNKNxT+Ou51KrP27GVJqiCAy6MSKQPpHczaFWZ+aLcrcB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772054828; c=relaxed/simple;
	bh=yGGMDF5JAAyQ7t/X+LED3I2wNOi+oFXMl1uT9N+vUHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UGXhb2TLJSVdwfOKoTKngcDyjApB+2S24UesQYy36GcoUaP7jP1CdUNshn9JydxLgTytaJyFFMQZ9il0Ey4csk7f5zpKaGP0vbk0qLhXI+5hSuP2UX1JC37HHUbiVBxZXh3mzPezBfI3WvRz6Jh7BuYITFdeUhhqd/a0MJYP03k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PzBp7ysd; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PzBp7ysd"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-463a0e14abfso125684b6e.2
        for <linux-input@vger.kernel.org>; Wed, 25 Feb 2026 13:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772054825; x=1772659625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6qd3od5gT9Y56WsM6DlqnASWYdZTTGBmXPSgA7J3iS4=;
        b=PzBp7ysdmb3gfHHG4xNmOTe9VXSE5URpzf8AeQjKsPRKZtNZ180XrZmWGei4QIEMag
         YEV87ONmpK5yI2NAdKi5qvT4gcCMlDdlLTWud/y4qZlDiOB4gKDUpX6Mfc5OIZQhms5q
         0tcNhY3n116NvydPlxv9UhK2UNl3PXy1VSTxNkDcU+6FFSFzrBtDTS7ULHTuQLXxIkjV
         yEpsZk/JYKG3mv/LrR2mo2t+gkExij091/8H+me92LRPCUtNu1GXFjX33CjuOVbVpDhp
         lgqGflnVKqHz5fz1weHNbX8iog6LwPYBlbBKG5gc6bt4Tvih/IzuWWTAsU19BXdrAkSd
         9E+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772054825; x=1772659625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6qd3od5gT9Y56WsM6DlqnASWYdZTTGBmXPSgA7J3iS4=;
        b=o0TzsI7EuyvfvNzx5QkDBP/fOHE+zakW+PTFl4EBCDL+SsmQkg1Itlvq+WHscGFtUw
         Ujer26SMKjTdwA6sXenDAZ5TI0qvK1oAcLfJjT6s3lgcAOUzI7mv2oZq7pw/HYdE8lq7
         YUeY7MBDsmQVLq74M4RjLMTVchRGEtK8tY5nEVlM0NrHRHtAsORbzhHOXbaA4kRrTscy
         +snJmKMiSAnE7fKwoMRKxQmADHKvgMo9wHOHPQx9TMEb7XUtuj9Cy2dCtf0sINYnxA9w
         UbagwGClKBYQDUJwcA9wwnsM0HWxCPnYrwjFVu2wLBNeFWTv7zWQEDH8IDGPmZduSlrH
         YvlA==
X-Forwarded-Encrypted: i=1; AJvYcCXoaRv6H6OrwTek/+b+Uy1+PH60+gXskcX4jitnN4FmnjW0E9Rt64pS054Xo0JKz0KzFLM4SSJwgxSpNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YygHtgUiPD1lhPIfE9G9723znLsTHiv/1MeVw1o944jS5h/oEUC
	8EOuSmTOiGC/zwUUH3RUMlWiKAyFhBdPTrF9rV5tuk/2bPp+DIJwZcovvGEnelHbsAk=
X-Gm-Gg: ATEYQzyR56kGJJ8EcuvtnNQlwgtTxMnElql9Gy4KaaDyw+QY8ptmMK8S6YwG+bss8oA
	W/G2G5fTCfgtxddrX+94rAvoa7JLRyqiwcy+/zA3mTeuRELVGt4gsKfTy30FcLEXJf8WCHqtath
	C1A+/RDzn7ToFqmp6nmD5ZWZcj7MDhOwZlT0jtzGe/wnf9Bw4odgzPOkdjYja7ss7EwOwKJSSGd
	M2gCBi73Dw10GKdlHIn+NFQ30qLObZ3+BP8hyG64wUowEtvGALotrOmvCk6Hq8BAeB9nUD5pPtH
	XsibyHm4UgxD0GnN4h4KIJXkMMMzWy9Wpk/5d/vkqkSCL/oGYFGMyXTidMFQ4agBMaXX9dpYIgL
	TzeCmk7ZEYWISoSVYqTbqlRV+C0ZDVHjm8kHPIBGiHepzC1GYMcvuJQiQTS+yzHUKw0eKyU8sBr
	NXVptMoM5W3yDb6fQ2/rf2ns11YBLLiYQFsOJmRai9AD3QWpw0T7GXmM99iSSdeFOL3Cg5TnI=
X-Received: by 2002:a05:6870:2188:b0:3e8:8e56:671a with SMTP id 586e51a60fabf-4157b210230mr8655778fac.54.1772054824819;
        Wed, 25 Feb 2026 13:27:04 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:146:def2:caeb:cb1f? ([2600:8803:e7e4:500:146:def2:caeb:cb1f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cf2572bsm64198fac.2.2026.02.25.13.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 13:27:04 -0800 (PST)
Message-ID: <120c7f33-4ca1-4d35-ac1b-b65362f1adfc@baylibre.com>
Date: Wed, 25 Feb 2026 15:27:01 -0600
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/7] iio: Rename 'sign' field to `format` in struct
 iio_scan_type
To: Francesco Lavra <flavra@baylibre.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Lucas Stankus <lucas.p.stankus@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>,
 Ramona Gradinariu <ramona.gradinariu@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Petre Rodan <petre.rodan@subdimension.ro>,
 Dan Robertson <dan@dlrobertson.com>, Benson Leung <bleung@chromium.org>,
 Guenter Roeck <groeck@chromium.org>, Jiri Kosina <jikos@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Esteban Blanc <eblanc@baylibre.com>, Jorge Marques
 <jorge.marques@analog.com>, Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Renato Lui Geh
 <renatogeh@gmail.com>, Eugen Hristev <eugen.hristev@linaro.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andreas Klinger
 <ak@it-klinger.de>, Paul Cercueil <paul@crapouillou.net>,
 Ramona Bolboaca <ramona.bolboaca@analog.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Kent Gustavsson <kent@minoris.se>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Marius Cristea <marius.cristea@microchip.com>,
 Heiko Stuebner <heiko@sntech.de>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Kurt Borja <kuurtb@gmail.com>,
 Francesco Dolcini <francesco@dolcini.it>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>, =?UTF-8?Q?Leonard_G=C3=B6hrs?=
 <l.goehrs@pengutronix.de>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Haibo Chen <haibo.chen@nxp.com>, Salih Erim <salih.erim@amd.com>,
 Conall O'Griofa <conall.ogriofa@amd.com>, Michal Simek
 <michal.simek@amd.com>, Gustavo Silva <gustavograzs@gmail.com>,
 Tomasz Duszynski <tduszyns@gmail.com>, Roan van Dijk <roan@protonic.nl>,
 Jyoti Bhayana <jbhayana@google.com>, Mariel Tinaco
 <Mariel.Tinaco@analog.com>, Nishant Malpani <nish.malpani25@gmail.com>,
 Rui Miguel Silva <rmfrfs@gmail.com>, Linus Walleij <linusw@kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Alex Lanzano
 <lanzano.alex@gmail.com>, Jagath Jog J <jagathjog1996@gmail.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 Remi Buisson <remi.buisson@tdk.com>, Christian Eggers <ceggers@arri.de>,
 Mudit Sharma <muditsharma.info@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, =?UTF-8?Q?Ond=C5=99ej_Jir?=
 =?UTF-8?Q?man?= <megi@xff.cz>, Song Qiang <songqiang1304521@gmail.com>,
 Dixit Parmar <dixitparmar19@gmail.com>,
 Gerald Loacker <gerald.loacker@wolfvision.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 chrome-platform@lists.linux.dev, linux-input@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-mediatek@lists.infradead.org, imx@lists.linux.dev,
 linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com
References: <20260225100421.2366864-1-flavra@baylibre.com>
 <20260225101735.2368252-1-flavra@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260225101735.2368252-1-flavra@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/26 4:17 AM, Francesco Lavra wrote:
> This field is used to differentiate between signed and unsigned integers.
> A following commit will extend its use to in order to add support for non-
> integer scan elements; therefore, change its name from 'sign' to a more
> generic 'format'.
> 

Maybe Jonathan is OK with doing this all at once, but another alternative
could be to introduce a union to allow both names at the same time, then
we could make the change more gradually.
