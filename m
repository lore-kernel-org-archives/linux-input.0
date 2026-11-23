Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795400910;
	b=F687JkxQwAvu6F3nOtkragEuOSOSKAt4oE0HsygDft0dGdgZqFiMxwc+K3LLorDVZQiV
	 HfWgu+kvEL1zD4fYU62/H0huRrw6MJBJxHjABgMv53yjvTxvD6c+/iZfkizfk7n+dq15y
	 C0tqmHWfbVfNw1AeAdDrAmayQCqs0ZFh1LkXWGAPSL8ZjoE2ECe7+zWrAi50OagNur/31
	 EHxKNf42ECy3ku3ekGbM1PhGeDW9vAuML5aaXJouj8Qa8p0rMyNd5gfOKBQiSy1wy8yeT
	 oK9ntP//8a/ypDJFvFdb+qCCUDrfbN40XyDc1AbziT765wLDdPRmgHzmA7Wvicy7mCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795400910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Sl/jKCVgSD32LaFfQfoKkqKt/VZL+Shvp0SZIGxaeZI=;
	b=cuYAJyfOuOlGUqxjjlH3VR2dUJUthxgUbla6GPy61MB9iVyUXG9uXsGXxrFKmC4plfuZ
	 jTE0vg1/lKUyNILTPDz00QgNXI2ujN93uDnpAGrhj/whxFvl7ZDHpKjCGzdo6WJgjCeKx
	 FBcyJUX6ucQyWPHsJyFWpUtd+W5UGED/iJWiKQ+JSK9iLw9Z4YcAu5VXbaz477VR/qEeX
	 LmHbGwViBavlds531isZibptnvjzjausNwugCW7Qsc/hrqfPC9weja2oLVBlKzwWxXNjO
	 qiTGS+HZgMSp3e+BHjjboS1zb950m3M2DxuV5BH7mdZug5GKom/BeR/osUVwvfKND5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NkHnYc8C;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D091A606A327
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 02:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D091A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NkHnYc8C
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-33fb4680717so7879594eec.1
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 18:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795400909; x=1796005709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Sl/jKCVgSD32LaFfQfoKkqKt/VZL+Shvp0SZIGxaeZI=;
        b=NkHnYc8CUqkuAR+TowFEkpv+JMo/jYm6MgCrAZoVYCGYXO53FaBRVwKXld+eDVJeRh
         vLL0Z653Z5+lD2/NcaVgyOSfNpKOpIRvjjzBQrWGhcFa1duZGU9U535sv1R1y+zzGKIi
         zcy0ybik9BFKVf1MV26saHmIFZc0VHPkKlgycOWtPLl4siReomtZRs9fZsFEribO5+pw
         GWCeKBkkhotP3FWS0ccMerw6Zh4FloKAt0gThBZjJNSSvV/QFXIP6IhWl/wVQkKAe7V6
         IvARRdsnNavMzUg6uqgNfO+SJVLTjPq5viFqhze2tmMurHbsUOnBk5COvMeV1TB42DPo
         cUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795400909; x=1796005709;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sl/jKCVgSD32LaFfQfoKkqKt/VZL+Shvp0SZIGxaeZI=;
        b=QDbmQkBUNqq11ZBxCk94t7Akqiu9SWruCbeIAOGtvi4blqiUdXLAlw4/QNMXMBIESd
         YOtTro6bRPNUnYa6ZAzp4y03TrkbMnszQiq/jNS8Hqk+tF7On46AFIXxA2iKUDZw0mPp
         ciiEWZaMvIJqn5Ie8kA80iYLWyHGSsPIFavj132pUq+UrT1TdZemVrLEQ8LT2QZfY33h
         dc/vB3ZvVVbN1zUa//ACm6T40aPX4pEKDtmWerIrdtEPtUNv2IbWlVvC9oJDddn6KNvn
         gEhKrdSGCvX5KzreywhFsEF4CKzzcmMsrMU7C3ojNPfM0/IsdSi6JuEZZgmO/OlBLpxC
         VTbA==
X-Forwarded-Encrypted: i=1; AL+hErGAfrSUSBDHG+fHJfhB2EmnGhxMCC38pORYssCtTmQuipXkZt4jSOa0Pw57bDdqpDlHtG2LCA1G9PrrBg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+L7PPtI2RuxPiRIKXbdSa2XOvp3oJnbi8qJMujgC65yXDGhs3t
	FtYbBvuhJT2xBguoez8l79pfsq9UjS0PLGS202yNzOX1y5RJQbW8rsOt
X-Gm-Gg: AZFdTZd6xMmnNbzKmPnL2Zqm4lHXZT+hGeO/PcdYXcrSwTIW5WdRG+rrysuIvnT+GPC
	iIbEzZ4FNfUyzIAD8a8Yl7K4jadsH4Sln7SwBES7s/63BY97GzeYaICbBUwqk6aQDEgzvS5HwAG
	+bIeNiynEG+rFLJNELbKYlSCbVTbB6XR0BurwR8zEVGNQ8E+wVl9MiyZbHH4P8ZMUNg83l+j8ve
	Bmlz7ePTDZU65thVrru29epIu7GGhiFpRHEkNfpPJnwB2BxTbVYemyH2Nt5Vvf5s7eHyca3MyLu
	dcv8xEVBhO8znroIu1UFd3oKxDi+jdKzyodM6vDba5GJim02+cUkiEiWFJr3IYwskBdv7IMqi1b
	zT175HTYpwZ2F2619nXygP3vD8liIOwt8cV6YsqGU2NsaL3ViNE+XeT5kB/hs/L5f9rHZJqNBKd
	HEmv8lSXwbt3ILByjT61ZkT7Pe9LEk/6sgOW0EndBZ3ejD4c2c4s+enMBicyN5UEoZYEAD7S1Th
	PxzX9JdMyKhnW8PAlbSkSEfeDPLsDCy1JBsnDxTS57iqZqZ+YcOsQGx1dN9o0bOH7+nXawVmwFr
	8wCPC0UGEMmFSE8hEkhi+WpcCzzgK/GeGUHmX92HN/Ona4kcWxop/V/uFOHBh+taIRItQVI=
X-Received: by 2002:a05:7301:d805:b0:385:ce95:2e14 with SMTP id 5a478bee46e88-385ce953221mr9510209eec.30.1795400908908;
        Sun, 22 Nov 2026 18:28:28 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:f002:4621:aeeb:e0e7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm35337348eec.10.2026.11.22.18.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 18:28:28 -0800 (PST)
Date: Sun, 22 Nov 2026 18:28:25 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Geert Uytterhoeven <geert@kernel.org>
Cc: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, Lee Jones <lee@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, mfd@lists.linux.dev, linux-input@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v2 2/4] input: keyboard: Enable compile-testing for
 KEYBOARD_ASUS_TRANSFORMER_EC
Message-ID: <awOkxOB_owPvollr@google.com>
References: <cover.1795355432.git.geert+renesas@glider.be>
 <8b0c54dbf722168d9272a4bde9ed4618c19e8afb.1795355432.git.geert+renesas@glider.be>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b0c54dbf722168d9272a4bde9ed4618c19e8afb.1795355432.git.geert+renesas@glider.be>

On Sun, Nov 22, 2026 at 02:56:31PM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> The Asus Transformer's Mobile Dock multimedia keys driver builds fine
> when MFD_ASUS_TRANSFORMER_EC is not enabled.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thank you.

-- 
Dmitry
