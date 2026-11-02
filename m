Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657063;
	b=4npw7EUr2zP8iDSQWXwREmyR8HpGqaPcw/7NRMek3amPSr6Sd/TgZhCwIc7yTSqOe7JB
	 WQ8yzgvbinLC6zr4urfNYs6ctFmPdT617Jd9Z7fhFR/952NdSuGweeJ/ZSQn2S/VHDc9T
	 97MwtPChwnRagYcSZSRYXwpHUmOJQjRrEwPBF+cd6XqfqlwczsNiTs6ioV9aoFK2BVP7h
	 TWmGyXmL4Jr2AUMgGRvoq6OUFyQ+d8uvTzAa6482ESzBiiqjz79qDgj9ncYZBqhmUn4Z7
	 +uQUnsItDwfzMzEa61R3vsiC3yauy9tmuIDOmubiZAsBQXol3RrBLwJXAe3xZLOVjhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657063;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=V5VztfzJrWDxjlD/VFABloyHPIk581E899r6l20/kAo=;
	b=ZhPXDgmzU+ydk/EwiRLL2hx2FT9FqblVlLG2GSq0z+wkGS18ogjV6LmDzzOo6ktTZWKN
	 71HcSAOH1NGDNXedRLGJAXmySzHlSYXBALTomq6+Z4Fro/dxlJaCtfp7Ysh4z2J9OhuNm
	 vtXMqNIy/XxRiLTk189fyr6IR84BN45021tUCjfIPLYAp+BSzpvlOvUhffzqnnpgph0cw
	 LrC4JJeSHBMC4d1xdprl6xsZ3q/2DiYo0Q/PA/ISbOxEVrZuUvSkehI/jlU3WSvC1FoSW
	 BfM1czzP9ZunW5laSaEHczHXGnXAJFhAmkFTxdrSYGwZYOevKeIAt9/pu6fs/ygTgkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=MWGKaBJE;
	arc=none smtp.remote-ip=185.70.43.19
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07BB606A33B;
	Mon,  2 Nov 2026 22:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D07BB606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=MWGKaBJE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793657060; x=1793916260;
	bh=V5VztfzJrWDxjlD/VFABloyHPIk581E899r6l20/kAo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=MWGKaBJEFvPmWGYUpZggxT7q03suZ12NVuuZPEsnl9Hh5kznqfQtzNzNhhdlHsQ9l
	 iuFrGvp3GUh3ZndirXO5wbV/gmmK7IV6UigP0zEBNfKDL/OwXfRQYz0FO4A5dd/MMK
	 8F/2fl7GbPCLYBelKYwynE8mjSwa6RDT0uTsndZ+VJMBV5qlM21EzwettyloWMgcBn
	 YNQ7iw47Zpt5K7czYqvKKDGpF1VOy+NxSohG8zOXa8YKmh8XmnIHGeDRpjF1bKUB52
	 Refd6pTPoeLnKB3SKQxwHpsFpTXNhBDHTqWEp7U34VInJeL5Lh9Sy09ZrUYlGNz13b
	 vYPF6YSWCHjnQ==
Date: Mon, 02 Nov 2026 22:04:15 +0000
To: armandas.kvietkus@proton.me
From: "armandas.kvietkus" <armandas.kvietkus@proton.me>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Griffin Kroah-Hartman <griffin.kroah@fairphone.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/2] Input: Add Awinic AW8697 haptics driver
Message-ID: <7UzsL30ZdbikdQ_AC2lKWodTDlSLbGkXX54JDLjJzrOYSH3B5uKQ225Tr0K_UoGAupzycVlvsV8SEbcgNe8JOX22SBwfU5qyzhAGrd0Qofk=@proton.me>
In-Reply-To: <20261013-mainlining-v3-0-fca981f62b57@proton.me>
References: <20261013-mainlining-v3-0-fca981f62b57@proton.me>
Feedback-ID: 164226125:user:proton
X-Pm-Message-ID: 9fd370d796cd0d90404080b3dff9fc6d0aa2330f
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

Gentle ping on this series now that v7.4-rc1 is out.

The binding has Krzysztof's ack. v3 has the two fixes Uwe asked for
on v2. Is there anything else you want changed in the driver?

Thanks,
Armandas

