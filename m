Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.247.164.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794095204;
	b=Gar5omQdQKSkrzYQvDVvgoMoOc3kuC+J2P65dEO6EelDRdR2iA+wqXZ87LuCkJk67q3B
	 q77nmo6xdAkm78Sv/Y/gp6EHUjcWQi/tk0GtExrJ3s+vWmPgPSp8jTwD9DswrLC8IVoW6
	 +d9iYy3tWsniP6RwBMAQB5BggCtor9MbWlfjFUuElWxptWn/CzDYkwH+pFcpOIQAHuGpl
	 AFD9nuki72lzke+F6rTQ2lLuvQo+FbTbDezP8a56Qg1ym5Om1M6l9u7J1b6/arpRv2/KB
	 OfZN2QR4vygTOZUkadae/Flj4Kk8z2ziyR4i2y9ChEMRrucIfdtMmYT94mMGdigv6lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794095204;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Last-TLS-Session-Version;
	bh=S58YIltNapRszv8kjdiHJJofWMjSjUfsQ1JILMuxbCY=;
	b=zV0PuXVIEizHhdaeu7uhxsD49qAoXvw6eTEh5pLBtgmCyBimlb4SA3BkQsYWrToVdH2y
	 yzIR5HQlJHxRn1igMVfj8OFku45onYKRs/jHs3xcHv7qohFk4x8P1jVrGOXXMAac2fkTq
	 rbiN7rdVPbSZx6zv98/phpWvyvKssiP+5Qe7c1KUa2KMozpwOjOFVS218cj9JJy5hnzrh
	 N3yUbmjNo82aL44yar99v1fiDptcpUcuMXlSddNm8c9EXC8d4TYe7HF6YD5sv/6fvPQWK
	 cWKfXNOjUs2FyUcHzeLuRXXmy6fHv8164WAVQQMDB/z3qb6jPdm4rFmzo0wHvaMK3/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=koesling.info;
	spf=none smtp.mailfrom=koesling.info;
	dkim=pass header.d=koesling.info header.i=@koesling.info header.a=rsa-sha256 header.s=dkim header.b=X31CDf2V;
	arc=none smtp.remote-ip=84.247.164.36
Received: from mail.koesling.network (mail.koesling.network [84.247.164.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CB4606A332;
	Sat,  7 Nov 2026 23:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9CB4606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=koesling.info
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=koesling.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=koesling.info header.i=@koesling.info header.a=rsa-sha256 header.s=dkim header.b=X31CDf2V
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 938041320410;
	Sun, 08 Nov 2026 00:46:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koesling.info;
	s=dkim; t=1794095200;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=S58YIltNapRszv8kjdiHJJofWMjSjUfsQ1JILMuxbCY=;
	b=X31CDf2VA+QAY7FTaxWSpRVjVWhrBXq68825eAhB25phumoxZ4Rfyu/K54rbWem8fkWTVb
	A4kuhzr59m19q2MTZ/t3/wGfvnZCJH5FVlL4QXmXgkWoV6ekQLE+5jGxvOS19fTRxRwnAW
	Hmt82nve//wyzbavuMI2+l7Y+84ocVbxusCrABsVVIO01+/wdBZk4v1BS+6OkjAam6KMDx
	lNH5lMek1HIKak1P8eV6MU7ZLnXQlVbl3BfJNkd4bOumLDtZlG8TY3e19tTQ+7Yr1q8q6a
	mWAUCPQIYkoBWFZbb56PoA0irzARPSJh+5cRKEcNLLUQXHVjACDg1Pmyvs/FWg==
From: Nikolas Koesling <nikolas@koesling.info>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Aryan Sinha <sinha.aryan03@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aryan Sinha <sinha.aryan03@gmail.com>
Subject: Re: [PATCH v3] HID: pulsar: print errors with %pe
Date: Sun, 08 Nov 2026 00:46:34 +0100
Message-ID: <euuepDlEQQyNpsBZCEye0A@koesling.info>
In-Reply-To: <20261107162419.9051-1-sinha.aryan03@gmail.com>
References: <20261107162419.9051-1-sinha.aryan03@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3

> %pe prints the symbolic errno, which is easier to read in a log than the
> raw number. Convert every print in the driver that logs an errno so they
> all report the same way.
> 
> The prints that log data bytes, battery readings or a byte count are left
> on %d, those are not error values.
> 
> Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>

Reviewed-by: Nikolas Koesling <nikolas@koesling.info>

Thanks,                                                                                                                                                                                                                          
Nikolas



