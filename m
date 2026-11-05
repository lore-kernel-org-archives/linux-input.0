Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872262;
	b=KOljz3sDhO9ZFkUlz+7SDSeYjjRYqc7zpOHivgvfNbezfCoyT8tCuCFEl6dfkM0j2XwM
	 48iEvs/t56KppgUyScTIoy8UW0UKzd+5JmnBzEPKPmCtYzFirzAIlXCjd0h3lJ2S5Xm4R
	 PznDYu/1yAIg/ydWVX2Ejh5NHc0jkMKg7rKoIhFmiHE7XMttLkSEYL8AxPrv2nRSoSbsb
	 xlJQIx8Ug9BJL+7em8taLcoPKkVIjW+fKM6PTHZP3hoM8+d6Dy6yMZvSHYD5+tas2Dful
	 6c9XyTRFWuV5Brf/b1fYRY23UFGQls/TrlZd9DWKIQe1cgADNUaB95APY7Sigz3MMWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872262;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=tdN8BYMaeX7sTpIs2KSSI8cpoUWm37wgO48E1qU6ekw=;
	b=CMGfJqYyv1ukPGLafZp4NDYoULZWHkuvJjxRu1ysQZFynNrhQGhWyLttmBvePj9VevyC
	 +IcXI0Q97QPcUPe1Sd96331lubgbb+EYR5qNyLwVFLj00hdDxOwTGTRnTNacKJR/De/Q4
	 4oIgLpMucPRguTXzdfFeRJJ30rXH7x9No4gpGSHvii5KiRQOe5JC+thsoYfsAomyos3PQ
	 hfSl6EuKucXdkW/pIxUeqew4CuFwG2pUoydK52LedH/0PRk91BxzwPnFiOP+AZTCVNKx1
	 hXwWGR5Jywquj6N2I52KxitTeBhr5z4Ynz1OihlVw2hM6fklwZ5ndYfG7XACRWUIU4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jannau.net;
	spf=pass smtp.mailfrom=jannau.net;
	dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=vlChj5hA;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=uwWBP3kN;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EAF606D802
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 09:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75EAF606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=vlChj5hA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=uwWBP3kN
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E7E6F7A01C1
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 04:50:50 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 05 Nov 2026 04:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793872247; x=1793958647; bh=tdN8BYMaeX
	7sTpIs2KSSI8cpoUWm37wgO48E1qU6ekw=; b=vlChj5hAm+yauxECvQLZD4ueJs
	sXpm11K2nkX/7f5Crn29If2tk6Wt7FCq/GUQf9ulMVw5pDGgrCXnSbqPGSfi/lGQ
	fAgGhES4B2KCieRLE3g6TgLvXfM97cI5EZPW3IQg41ATQMOG0IsVDOPEaQX34if7
	ZLcmLDjOcEsyG7OPpsktGZ6IWTxrRSvkKnu67H5+mwpF4g7+7zOFoF1+aZDnROp8
	nILDggqf/5VZq5DqEVhyVhyExhLurP8DqhuoivPCb7vrAbdI36fmJAYK4qWTQTm0
	EeUzcmKUdlPmDTXKn5mnLRzoFC/aHr++c7+33I29TG+Aheau7K5rKKhoN/4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793872247; x=1793958647; bh=tdN8BYMaeX7sTpIs2KSSI8cpoUWm37wgO48
	E1qU6ekw=; b=uwWBP3kN9w+75gBPbfgDC+qAvB7SNgPm8dkgsbCxW/RzBoBur/V
	NSBmgCU5cN35/JXpkIyE48u3PaOkO9Us1CcJ4z7+cr5enGaSj4nmF3bAhrcwF1u+
	DywjCfPk5FJFUn2/hceggfJJoAYo7E0sIFH9g3qb4hP0UNv6YRnzijd8PW3cBitC
	hZpPsvc0vQC0fcZHRcqYGzYfW1Dbe3zL+CVMlVQ7wE5qZP2ghMssrQcFtukF0AaH
	BmZPq39xM4wn2FQKC74UxAoTMqGxwwtp9QYNvFNkWGUUJtxA1r1aw7vQ+8Frr7Xl
	3xmjr4oRbT6gOJ06JYPdCYOOaKXIVWQucxQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793872247; d=jannau.net;
	mf=PGpAamFubmF1Lm5ldD4=;
	rt=PGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:Ow8OFtAd5jghWZUCVhb4TjHXDLZJuNX9EpN/bq4fagZNqxB
	zmwYCZX916eTV9H1iRSvrEpiyRTYBWthX5bY05xTGQDEfz1pG6joWXQOWeKEWXw1
	i26FsuW+jH8w7DQ3SAU7PlZwdpk+/3qKrcRl8C39Y+apgaC5RCOtIY+zrC6QJ2zk
	4ax16nN6dg71f6UtW5mOUvbbqYuKHo/+bqnsIcwLrfZprKMOXJBfzETKOZ5vsmmI
	NlGuoaK/vT4Sb+DdriKujgrH+gvIdRx/IN2hbjDGnzQrT7I0P1QpVriQt3zPd9i3
	Z+t3hStZ5BpLVwxlFHqQqXBSFxn/kpXIdozkVDA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:hcUY8h0j0LtFuIHMfF1T4A4PydzG7IsIpufK/aUTZRo=:y5J/XCGySFoLlnfhT9D2Nb1VIKNEe959FeusWkn1xjk=;
X-ME-Sender: <xms:dlHsal-q-K4FO4cmAyi5YW6TQMGK3CVH7r1TMqWp5ZoxAkDK5Smqhw>
    <xme:dlHsalL2zlmmZsYiTmVyRKTz8xEqu1aYCoLum_LeUNVmemMRYQxbvfjqbICktkBtY
    x-HoAkYv_RkLUUqwnDU_pLXiVydNMxEyEv_kblaKwUk3amn4TuZwks>
X-ME-Received: <xmr:dlHsahuz9a2sjqykIAMdqM4w9ZJYpxNbam8HwzbJmZXa4bm5DLmpo322LAakrI_-cN6jdZUVcSnTnk0szW1GJc3CB0D3NgoNN64>
X-ME-Proxy-Cause: dmFkZTEWcDtu48AJclumAXMuoDVfzxGvw7WtcS7yPKlNeJeV7eS+ZMxg1/1zWE7bQKaaOk
    D+TVX5AK/lO0Cf9aYmJ8QhYH9+qyl6KBZmLipS4bkViJE6/5Jeg8VZQnE6Y8OYycqhqLch
    LWnimMTskM/ox+ldUNwjnkD63GBRi7SqBT32NYbZiBfiRjOR55w7mh6zO952HKwwP6BVeD
    drvSOo8XpSDd5sskTY1zD73tvg8h9WVnE7glblYAk7kQ+WF6i66Z2G8frYTGDnyh9/EKqJ
    +4+NntgA49kqO/jZg/+P9b9C4mLch6UI3o8MiiDVTT+qleOgJxiQqJ5GcSELQerQYqgxLh
    7nWxfqV2Elgs2P98haba3C5bXb/hTXnVUwPe5KzxzIJmAtIRL7GB+mIaSxgYJ/jZmJMjpk
    Y8VxwAJqhXs83HkDPPx3XqnGDGF0M/CUpT/AHetEHXunhWhhPVQ6YvZ5D+F4Q7kZv+xXNT
    fQ3EWfn5+qnzstWLO/KaQwrlZJzdS40iBHfCkpNNeHUXgsKN5Dx4TvBibXEcJ0OHLzuTpn
    VsbhOn/2ST6YBmYKXV1cf92AHzZAvXHh93SbPAckMBfwkwUdMcP7wTv5I+glV2f/AHY4V1
    OlYBftkinl11LqeiIvwlFnbXUf1lokb+LtTU2ORCRsKPjIHtsyHEq/v3Yeyw
X-ME-Proxy: <xmx:dlHsammzDbBgauPWNfWLqQLkF3r43NGFKnY02OMrGjvz8uB8ZJT0Iw>
    <xmx:dlHsagkGHOD1j8KDc506ERhHc0iMoORsNWS33QPKvsf0swBGYZVvXg>
    <xmx:dlHsahhDA4sXid3ylCG2QjfVg3lX4GOklxpqwfMU0zrMxkIwOS4Yxg>
    <xmx:dlHsaiHSycWMrphYKELCoOtP6T6OeX5m7PjixscIA8fQegj51AOFFA>
    <xmx:d1HsapZRIsrkinl_cSM2IRw6H6SoL0p2qGSJyXKaXPTs6un01ZHvmYCN>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 04:50:46 -0500 (EST)
Date: Thu, 5 Nov 2026 10:50:44 +0100
From: Janne Grunau <j@jannau.net>
To: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Michael Reeves <michael.reeves077@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-input@vger.kernel.org,
	Yureka Lilian <yureka@cyberchaos.dev>,
	Julian Braha <julianbraha@gmail.com>,
	Sasha Finkelstein <k@chaosmail.tech>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: (subset) [PATCH v4 00/10] Add support for Apple Silicon
 DockChannel internal keyboards
Message-ID: <20261105095044.GA1421246@robin.jannau.net>
References: <20260925-apple-mtp-keyboard-final-v4-0-304c267518f4@gmail.com>
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
Content-Disposition: inline
In-Reply-To: <20260925-apple-mtp-keyboard-final-v4-0-304c267518f4@gmail.com>


On Fri, 25 Sep 2026 22:09:27 +1000, Michael Reeves wrote:
> This series introduces support for the internal keyboards on Apple
> Silicon M2 and M3 MacBook models.
> 
> On these platforms, built-in input devices are managed by a dedicated
> coprocessor running an RTKit-based operating system. Communication
> between this coprocessor and the main processor is carried out over a
> low-latency hardware byte FIFO interface called DockChannel.
> 
> [...]

Applied to local tree (apple-soc/dt-7.5), thanks!

[03/10] dt-bindings: iommu: apple,dart: Add M3 compatibles
        commit: 6c799b8c0df41869fa0d059f7e54f8f84b3989ee

the changes from
[01/10] dt-bindings: mailbox: apple: Add M3 ASC mailbox compatibles

were picked up via "NVMe support for Apple M3, M3 Pro and M3 Max/Ultra devices" [1]

Link: https://lore.kernel.org/asahi/20260925-apple-m3-nvme-v1-0-5e832e2f4aa9@jannau.net/ [1]

Best regards,
-- 
Janne Grunau <j@jannau.net>
