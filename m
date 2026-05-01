Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F191F7569
	for <linux-input@vger.kernel.org>; Fri,  1 May 2026 04:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777610212; cv=none; b=i3FAV8F47gFK5ypQoGYbAQgez2N8JJZI5D2yRsYucTBpAOhe4eZzXPwcfiWRVehF54qRuIjOV9/8cHpOsGSfwgExWPk9cdZj2jNH6kY/DTj6msNZZnGcswQ225fJu4LkhdlJUxZaWiNABBZldFPoIEnA1PfOwT61ety4J8f87UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777610212; c=relaxed/simple;
	bh=w1pT9M9mg7eUK2sPWLZz8L0U5nfFXbTqeZJY+y+h5Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLwaIMInhxdmJ6SxKcvv/imlQNX+XpL4tAx3t+4c+cSOx+vA7cmIbL1zm2DMMnGXE6Z0js1gUltMjRlHaJGQqrXECTNUdwlTQV0PrysjLy/Fus7qC3JGbYEAKdG9tYmuIzN2iZ+GLw6ll18QiAtZNxZOLfoGBiG+yiof/S1cX8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2/CxJ+d; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2/CxJ+d"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2e221a71e19so2297126eec.0
        for <linux-input@vger.kernel.org>; Thu, 30 Apr 2026 21:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777610210; x=1778215010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xGPR+UFOagP7MNesgTuCdliIp0Vodm9r6lolMKcJLkU=;
        b=K2/CxJ+dQRF7JpmaLRrQo/TGqDFvqtAgmVnxp0sPfpUqokbpR7L+KQCtDnu9b+PGC5
         ZfulMoI675P/fB+dxd2GftszWs97gfDHIad7fUJCN34bhg45xGR1DV45hcYvvKwClXri
         a01IgI4/Pl8EKzKl9LjqK9mFWygoE0YJlCB21w+YM3FOZZa3/HVd2mjjYUFD4zHmIATY
         pBQ2e5rWvJKwXWYIqTx3Hzgnc9MEgWykatHlH41EKcYjApf1ePV97cOLNm8wZw5maxvs
         IuldJojrKaSkFarqLEO5l6fJQI2tGBz1/nCULb8EHO/y2wnA792tvCWgwt4mEXtBtxgW
         2m2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777610210; x=1778215010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGPR+UFOagP7MNesgTuCdliIp0Vodm9r6lolMKcJLkU=;
        b=d7bnJO6Me/ESGrA+vuFtt/EtLUdyrqFXTwunu3ulgn5LFWeMqL2BK/oGZZzdeKVdrR
         Nu9QCBadIBf06lvGz8B89zNwQu6qYQ0fHMnbxEDszDLUwOHujgdEuc4aQFt1J039PQXa
         N1I876xlKlxciHHXnesNCG9cqGSl3GXB7NLtFNmhOp5VpTLZLDq2xGS9J0LIoXfd/sRK
         +BPt5L24kG6nw8bbaBdd6BqlPfhp6DDMAiTQu9rp8alvRIdzUurU//bh5QgFRIJnTSLY
         H5OXXGK70bmB8l+AWTVkAPquPlczVWE8tVcIXmKs1ZIYQluFFORuZTiA8Rn9S6ThUaVm
         4XiQ==
X-Forwarded-Encrypted: i=1; AFNElJ9WobV1wsVlOctpQjnYEoP5Z47Q1jTMY8i7GeJS4V1KPIgIu/8a9EEEA4DPMH6zwVaCTjWkibX4i9UD9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrC8C/WwV22ApOCR3ytAtl4ZN6ubhAjXZ4bY27gp80yTR90m/F
	sSjZEqWvWkrKnmY1QCaA/gOjJyAd1DdPJ7FnvWTPaJWNAhzSAK7mYOUR
X-Gm-Gg: AeBDiesrVB9+Uwp5F10/orA1jqJuQIuiGPTmzMAxp+B1gi01k+awGXJkdBaFBGryIoP
	zG/2rWv/ed0apDVpZ4n55HX2GmgJ7A+cm8T4d86imtdoJMb4zBPZ/9Za/Gpf1GdViDZH/BtAYfe
	Plx04BnyDzTs36AhM/VuacbS8vH172KcxfOy7dpv0OatwsmVKQoLzlsUhBkEe4lN57UeVzTbmTN
	bgJw2Uf1dQyCCuXjowMAqc3nmr0zJOJYF6KMro2/UbrAW7bW7WY9mfTaHwgovc6VDJIcmJxNYTk
	KxavgGwbyeuMdtpe7v5VtpzkoqiC1PlrhJyulbzMzxUCzKA0Fn/zozSSkUV6BnthycTaKaI5ghu
	w5l3gIwNiBQhEsn1BlgGMMoUR+vlsRxkRte+joDiYX9wNNcF0Qu7+S9ZsmSzfMTYic5JQqyElMi
	GTSic02cUl8PoIw39H+sVA7SSU+n6PAQSZT4LHo2SiPZNSvALE22SCnUZB92XXToabn4CJfqRre
	jE=
X-Received: by 2002:a05:7301:e8d:b0:2ed:e14:7f5e with SMTP id 5a478bee46e88-2ed3f15aed3mr2637343eec.34.1777610210382;
        Thu, 30 Apr 2026 21:36:50 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:4372:f619:5d87:d4e4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889cf53sm3955869eec.5.2026.04.30.21.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 21:36:49 -0700 (PDT)
Date: Thu, 30 Apr 2026 21:36:46 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org
Subject: Re: [PATCH 2/2] input: pcap_ts - remove unused driver
Message-ID: <afQtoTDYJBkYqpkp@google.com>
References: <20260430164326.2766500-1-arnd@kernel.org>
 <20260430164326.2766500-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430164326.2766500-2-arnd@kernel.org>

On Thu, Apr 30, 2026 at 06:42:48PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Support for the ezx series of phones was removed in 2022, this
> driver is just dead code.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thank you!

From sashiko:

"Does removing this config leave a dangling CONFIG_TOUCHSCREEN_PCAP=m
entry in arch/arm/configs/pxa_defconfig? Would it be better to clean up
that entry as well to avoid a defconfig warning?"

-- 
Dmitry
