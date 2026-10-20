Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504521;
	b=tDzDmCwBRE88vapcdC/S+glpTexbYpgz79xxU5VGEe6v46vlfeeB2R7Z04fXYXbrl7ZX
	 RD9Zqw7PrnovZoP2zvaXHLSV1AdW6lS/2WCZu56F4rYq9fA/y9j+tXGhbDdLZZ9krrqet
	 uFucW5Fup3oX4B8oF0fTivgs67HgPTLtfUqsbFQMZpjWAxvfASjonfZNkbGxcXwLFxPcw
	 SJEkCDVrqYTzz8HwzBg1lNdapnkYOWGBVzW1WNtOn79IiJS3e+9xgJbwgmF0HsFwcruyx
	 RhqcWKTKOhh9nKqgBM7n6sIEsLA7BxKSd7Bsp7/Ynzj+S8jGgAT+My3HkunN4yQjzNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504521;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:To:Cc:References:Subject:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=X2p4JTwfJ1piszdZG0VJu8KYQx7hIWUhfphlyqlIUmI=;
	b=LGXpvgiv5tha7x0URNsPtyxwfeoqgxPYGXMhl8e63mEAo0rnfqMrNgokWuTu6Gdb1ZaK
	 NtJE2yx6QtlsKyD/a7K1likofOvgvcPOSPRQ3R0dvtyCRHB+qFJBjY3S2zfBKC/dSTVhN
	 JTXVRuakJ8LHMzoprLURn43SC+PvxcY8umdXs6nLhSsJXBTrri0vn281S+v2MZpitAiX4
	 RgE7xY1iMEueUKFzZM9aHAAF+UnjghcsXXiJWIVdyTBQDqEkNgRKyLgFbdbty4ICst4ET
	 opJq6J73ynk31q3wHYWZqEfu8f/+UCivP31MxKAV3PFSdBF0pASpNm4WF5iAxSeh2Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=leCmKsPO;
	arc=none smtp.remote-ip=212.227.17.12
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1147606A327;
	Tue, 20 Oct 2026 13:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1147606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=leCmKsPO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1792504515; x=1793109315; i=markus.elfring@web.de;
	bh=X2p4JTwfJ1piszdZG0VJu8KYQx7hIWUhfphlyqlIUmI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=leCmKsPOB0LyQYrfckhMbxWBQ0YHy/F5+xDCmzXW62Rc8j9yZV7evL5Sgtu6E7pH
	 hpzgAnHMtjTqjwpjOeXTX9jj7+aUBqFjvN6ve8r8dMIJ+JiqtO/9R6unmRpupz7D2
	 XqHHbXfnCldaDjIv461vTl5R0mbJMGZeiJu+1CLU0Ljv7J4MPv05Vi/EbKV06sPxc
	 nBjDWkrJTa//zensYm2JhRT4QaE5ZfF9PIiY3R0Ek6CC3g+3Skxm0Dre67UHvXYXQ
	 T+PVYbJeqTk5bY/xSAHq8DNaJ4AFCxQn77cg6v/NE/AyXccGXlPOFs3ILw4RLdn99
	 Sr261qML9UD78Ue10w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlsKH-1ws2ld2zNj-00j0Tu; Tue, 20
 Oct 2026 15:55:14 +0200
Message-ID: <11e5b498-f221-47dd-938c-41fc8c90409a@web.de>
Date: Tue, 20 Oct 2026 15:55:11 +0200
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
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
References: <20261019100406.103687-7-clamor95@gmail.com>
Subject: Re: [PATCH v12 6/7] power: supply: Add driver for ASUS Transformer
 battery
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20261019100406.103687-7-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pH1lNASG5+FJlYdQF9Xhd4yf8sYE9tFIPlEyikz1iJpmmxowQkD
 7YruASTfniO9/kh3lcSigyYLwZ3WL391iircvmtakklK3wV2Ckult6aMA4auNGK0o6np/lk
 94MH2kitpWE7z87kk/dc5aw22ItLgQ1BKID4JaiA6dZW+XmpDgqtfIqKRnAzg0lmRe/fmR3
 EMoNTXwcDfFRcL4Sg2pUA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HEQUdSyR99U=;4iKyCHJc4T88H6ZOBmb4gij4R6C
 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
 VkkRTTng==

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
> +
> +	guard(mutex)(&priv->battery_lock);
> +
> +	if (psp >=3D ARRAY_SIZE(asus_ec_battery_prop_offs))
> +		return -EINVAL;
> +
> +	offs =3D asus_ec_battery_prop_offs[psp];
=E2=80=A6

What did hinder to make such data type specifications really consistent?
https://lore.kernel.org/linux-pm/9ac1d196-0e4c-4592-812f-c44c56e135b3@web.=
de/

Regards,
Markus
