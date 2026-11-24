Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.247.164.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795547520;
	b=eb5HFPX7kFqR1yB9fwWbQdvK4Iw/kmUJrmF0zcusxEftCv6M+VJ3EWfYLCcp6q6Z3owo
	 Upo+JWdqMQgoUoqqXdQxoZFFxNh20MidQHuV/i1tMOL2O9oEgGkiPliVlx0Ej/apDsVP7
	 hBdO/NYQi7WkdHK7/EOnEWgF6LqQY5OcILswsWg8a5WiEJdhIfgzWE/EeKGy0smofg0ms
	 UyUsuS64TM6oeEvdeEawS/09x/8fGlMr102JMnjiap9bl+72tdDype883lQ9mKPSr32Fo
	 meGs5kS9Iw5AeP4eNUuR1j6LDlop09RbzklU3LeABFbb5DGzL3/YBYg3tRtByMD64zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795547520;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Last-TLS-Session-Version;
	bh=h16iHEu+wVsnvRLwNgveiU34+uS5wLYc+vzGKDwpDP8=;
	b=gRtk+6XRQkl067tSzTdbIt0TN1UEPF1ScHiLr/i0NzI5BhBWVQY2FTEGPzZrZglFOXpY
	 Bq/tsZpMPoouN1VAPUKRc20guopHgO+ZEPTxEi17iojGFqdpNA9HZHkI82Fk/hHwCN02i
	 5qJH+OTi8IFwv08RjHPqyDnHDPST41aRfdOkmmFvcNgzJBkU/O9Cx1ByKZKX+KpKLTWvL
	 2GavLXnT5GHQpUzWo+ZKc/l3tJazkM9gBOMm1m3araJ+QkpvTAeQKhvpIOPTTFOkjon7y
	 3ovHZ2xRgxYuWVm6n72SNGiP6HAUrFjGuRTpX8RypT0B9bYJGvk/9Wap50mGJYp1SPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=koesling.info;
	spf=none smtp.mailfrom=koesling.info;
	dkim=pass header.d=koesling.info header.i=@koesling.info header.a=rsa-sha256 header.s=dkim header.b=F4pAw5uS;
	arc=none smtp.remote-ip=84.247.164.36
Received: from mail.koesling.network (mail.koesling.network [84.247.164.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8052E606A321
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 19:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8052E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=koesling.info
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=koesling.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=koesling.info header.i=@koesling.info header.a=rsa-sha256 header.s=dkim header.b=F4pAw5uS
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 058421320F7F;
	Tue, 24 Nov 2026 20:11:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koesling.info;
	s=dkim; t=1795547516; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=h16iHEu+wVsnvRLwNgveiU34+uS5wLYc+vzGKDwpDP8=;
	b=F4pAw5uSLdkQRP2cHaqhcvlEI2nPDP2Ydvn/+sGM0S30T8FPKREPj1YaKAZKEvICfvZSdb
	nEFYblUZ9gHr/1tkeYYtBj6gfrMcZ+f9N6uSvL8HKvN1AqgT54xWTSn1pMSGTmQcgzPOLm
	oN0ffv03Ku/wBRYfosNi0rlWP7Sivd84vljTGDHZNaqGWYeXzumvuhDc6krKQu9Gwddsjl
	BvxFtgHo1ty9kqQ8G9GTJihslhAGTO5nve95HtLK5ADzPE7qLGXeqqrHZT/4+/xMrI6XRj
	GAFaU/bmgqRuEGNsSELLhoDYRHZ8Wg46JUzRs+4IFKYNnPfVlMSb4U5nMJxfdA==
From: Nikolas Koesling <nikolas@koesling.info>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org, Aaron Ma <mapengyu@gmail.com>
Subject: Re: [PATCH v2 3/3] HID: pulsar: add support for Akko Gaming Mouse
Date: Tue, 24 Nov 2026 20:11:55 +0100
Message-ID: <FZtYs5hkRyun2eYsm46vxw@koesling.info>
In-Reply-To: <20261124141315.6745-3-mapengyu@gmail.com>
References:
 <20261124141315.6745-1-mapengyu@gmail.com>
 <20261124141315.6745-3-mapengyu@gmail.com>
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

Do these IDs cover all Akko gaming mice, or only one specific model?
If it's a single model, it would be good to use its real name in the driver
header and Kconfig help in place of "Gaming Mouse".

Acked-by: Nikolas Koesling <nikolas@koesling.info>

Thanks,
Nikolas



