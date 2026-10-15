Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDB256E050;
	Thu, 15 Oct 2026 18:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792087611; cv=none; b=Vo1zt6/WNQ2s3OMlSIAyvoWWrxgCD0T9nPKHC6EY+A+nKCMc1pCvlirJXgN8Z6mvCmgEoU8CWoFiupiWRTmLTsrwsuRmRZPfMhqpYB3EjhfPB2o/XBz8q2BJ0mtJucZgZpI0+RyLjWdnCimfTeMKPOUNj37lXYiNjiPAMELt+kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792087611; c=relaxed/simple;
	bh=apnf5ilhckoCj/e6Ds3O0A7OciVgM9/RgqMEDtsownY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=t56t4b/yDylvP1wWKaWkHD7CAf15nRAerOM3RYJj+GFSBAYRb8I7Z5FlU4sQjCKs3l/k3PnVz8TmpNqnd2dUlcTjNTXq2G6b89PQBhxXkx2FwovfikM1Hkood0fJbCLzqTj6xxZNM8TnkOi8MeGb97zHV0u+2kNeOfbRZ6iVL0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sqXRIzcC; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sqXRIzcC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1792087589; x=1792692389; i=markus.elfring@web.de;
	bh=dF1lq9sYAvpOPnUPnt0z/SjBhVGrEpP1GeOVEnwZKOM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sqXRIzcC+wlYHaj58V8LjaABEuqWROEQuS+qoFOMOLNLEqbeseEMmbGdupqzPBP5
	 446enlhc9jtph08QxbAF5k67OGGprFjHr1N1mAKm/Z9/NUgYV0zn4ZRKOJgzAvIrk
	 daYuqFzk8oko0Nm1PwDNeJXwLLx/ouUW0jWgQA5/sgcwGzrOcrG8QSO+zGOfXC2kF
	 BH2BHA5hQo3fqfQB9OOjqmPb0Z7/zF73+Vc3g64/a5qD+d3qCytU+LteJNI/pH26f
	 g6TWXs4TsWgQa2Qz8Cl6jhPZ8LZ/HJKe52Zg1FghQEa57EPW4iP6UZRtG7CuoeTbq
	 rnm7RMaxoHbu0J1tJQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MUUAM-1x8igP03cW-00QW6j; Thu, 15
 Oct 2026 20:06:29 +0200
Message-ID: <f26b6bba-2c2e-46b3-9350-0ba0785cf3ba@web.de>
Date: Thu, 15 Oct 2026 20:06:25 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 Svyatoslav Ryhel <clamor95@gmail.com>, linux-pm@vger.kernel.org,
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev,
 Conor Dooley <conor+dt@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Florian Krischer <florian.krischer@fkr.dev>, Ion Agorria <ion@agorria.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Sebastian Reichel <sre@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20261013173504.451391-7-clamor95@gmail.com>
Subject: Re: [PATCH v11 6/7] power: supply: Add driver for ASUS Transformer
 battery
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20261013173504.451391-7-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:esBdW2OTnliU0jcFW5M90tsbECakvKK3ScgbsdjiOh9Inq/vFtL
 Y9IHndKeOOO+wdVIQf1M0d7SpGYcSXbLOlwyh3Yn2Lgiibmyj5xQaDZNSI3AGYTQEioA8P7
 RVo18QThBxjQwsX/LYUuFj/WRO2FZkmnrwpuqvTusEWlEMV5V9yYemZjPer9unHkC0b11/A
 ROf+GYfKH8Ce7ACJTO3Kg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Rdyz6YMXe2Q=;wv3VYpm5q5nxGDfSiUNs9al7UbS
 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

=E2=80=A6
> +++ b/drivers/power/supply/asus-transformer-ec-battery.c
> @@ -0,0 +1,289 @@
=E2=80=A6
> +static const unsigned int asus_ec_battery_prop_offs[] =3D {
> +	[POWER_SUPPLY_PROP_STATUS] =3D 1,
=E2=80=A6
> +};
> +
> +static int asus_ec_battery_get_value(struct asus_ec_battery_data *priv,
> +				     enum power_supply_property psp)
> +{
> +	int ret, offs;
=E2=80=A6

The referenced array provides unsigned integers.
Would you like to specify a more appropriate data type for the correspondi=
ng variable?

Regards,
Markus
