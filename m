Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793835933;
	b=TnddJwNypX5ZK7jzZVeuGnsfC8ouewuTx+CKImUHjGaOQUsqbr/pN/nxBMrcWR3WD2OQ
	 McNhpg6+H8h64QvCUWxbaFBHdpqSq/P8O1RbTLxwqUcoKrlajoE2VBYJ9Wf7RsDbWzyAE
	 H7KXQh7ClGIKMq1jIW16eZU6WQX/IG6J5M+aDmfEyDCpqAXCr/74qCBw7PepoDb1kTQTP
	 FQHVP3T3uJK4BUNfVFJ+yKLJCK2J4fawz4dbfpZvv5CL1dqeSeU3pxdN2aZV9Aekn0oYm
	 uPqEKH/ugzt26sj1+23H6nxCMhIqOiLks58oiAi+rGehyJp4fz5QyYAO/HP92XImHxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793835933;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=4kXbR01S3M5L+wtam7WkgU+NSUFvLBmF0YPHzpjKWcg=;
	b=xGlgzGUFB9kvMOqEtzFAn4+L8W1tMMaQetr8iJHRTd6FCQpiAJ+A8E+NUY8csoKwfl0q
	 RXEi1FHER+fU7YaKtbouqJE31m7cQJVlNaHT60w1k7ZSxrPUt/cws16phpLBy6ToFLlSz
	 l3UVadLL3DeENWdgxDNTXPWbxCEP3gNfoqSSSMkP6KP6tVc+JJq4gl9xQuz2AEc4UP572
	 yyUf/XmEZycMl88RfzefJeTYdXrpNJxCXxGZ7C4DEKBpdc5KDCKBOhEaHjBf+yrnsP04q
	 XKfahKBwnN4Lzawup4b8ybIyKTUEauGK3QfDVlnlrcLlbyOd3nT5pQVSzSwtF9Ex64Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0vlZURf7;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D18606A329
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 23:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62D18606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0vlZURf7
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36d6765756fso1268488eec.1
        for <linux-input@vger.kernel.org>; Wed, 04 Nov 2026 15:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793835932; x=1794440732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4kXbR01S3M5L+wtam7WkgU+NSUFvLBmF0YPHzpjKWcg=;
        b=0vlZURf7k5QquqgfLumFSqEumWZLZz148w7NNP2RiTozESJ6wZf5/ruRNYPMYYn8oY
         5XOtsT2C9BJvtIoxTQrIpf7V4LgUBc31QryMJ6dHc6ooH80PZHAau/0Y8q9n9lnHaWAs
         9+WnUhGfhV4WWLUFanZdJXZzkm2IWmr9GR76/TAicGphHaO/MHSNjrQVYPhP/BzaH+Eo
         5ze0IH2gUp4UqQieDGpjC0XNrphW7ubrV1pJ4oIjUhr5Xs7vSYlUW6th6R809IT4OAP1
         Q0/k9TJZwuFSbK4vP9YmSj8TKcxhqbEWQczHlr+OWyKfXG1J3/m9HFj5BPr3CCtoCn6E
         kx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793835932; x=1794440732;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4kXbR01S3M5L+wtam7WkgU+NSUFvLBmF0YPHzpjKWcg=;
        b=XDDoU0hjpgwh/MeOxi0+cIaIFq8hX/V89VI3VJIFZYvpFhX6TJOaK7NsywDALipPOW
         4VQPn2qL+5FG93xxbC9bQCOf/hsGEDGoacKKxRZobQxhVil8MCQxSzeFsvFicQM93Q0O
         ntTnTeLrr06+H7XRQOIc/kCCSPtaRWnOoacVysHqgfW7x6utmLv335oI+p9hwYf6UlnQ
         ir4R5HJN+JgS29QW+jo2jFO+7Hokgn5bdrrro46A7lZmygJlEtviK2nUOIUFlrmJvB2P
         LXpnLhVZpecR436IU6xfPpsoNoTwRvWtXFf7KJ98/rNEz5odDgkBQDjFLEiIBeKf/KPV
         lJjQ==
X-Gm-Message-State: APuU4Z8RD95gUcGOQoVAJIgJw48S2zJop5i9wb0x17yR0FAQ5JQ0kLOi
	YJh9dySXysx/rPh5ih+JElA2HgyEy5gJTYUouM/XreefpvnvjYooobZp
X-Gm-Gg: AYBFou2KtJTRXPteJ8NeKz925HnAiJ9CQjXjUzq4lNA9Gp2uBR+mFvFDomZfF2PFMou
	5DaBIeaEMgoP3ls3H9w67GSf2yKhem0w4cV5cXRO7kS3erZJOcmq/xh2Idn3eYb57cJ1uy4LGDh
	bRoEebdQpzkZ92J+c75YcKDhn78YknIef+Zb72iHwD4uFjeQt/tFYr9rwGsLjW4mjOasOthsBRJ
	m0sGYqxDhaVsT4cN4Q1fEY4DxYhL+C4VMiXWISmCWklorK4nM7xAFwb/fEsfMCeRmU9eu/b7mRJ
	9XAtlaAJBCtqO/J3vAXaOadJPvLTl1aoH8BngUYHC0P4gtO7eKPuzs3EsaTwXwEVM/Fd51d1QbG
	u19Am0EliqimPoWuUIucTBRMvHzBiaK4DXmXwu3Hg4gismJsmucTJrDpo1lzE58MvtoI/IFm26t
	iYE1E7/V2dqdbT54sFCl32/MaYWA04WSGrCJkbhROwhiIY5EfI8N9ycmt9jekTSF6XknIsEXS0C
	/JBcvrmVzQ1qMr2f/Qrcy+lYW4A7qSt0ZoluTvP1yFdHLR+Nv0Kc2G0IoVE1LC8QGkbhIqsOXnU
	fi8WIeEfJ8Vv///OtLkvoGhj3Omfu6dI1lt1EbNGiqAZVLEWMANwQ4g7jUdmmRu3SEX1nc0=
X-Received: by 2002:a05:693c:20c5:10b0:36c:da71:37e0 with SMTP id 5a478bee46e88-36cda807b27mr4610132eec.2.1793835932074;
        Wed, 04 Nov 2026 15:45:32 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:c8f4:b7d9:252f:4483])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39972d4sm18076499eec.26.2026.11.04.15.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 15:45:31 -0800 (PST)
Date: Wed, 4 Nov 2026 15:45:28 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liuc63@xiaopeng.com
Subject: Re: [PATCH v3] Input: joydev - avoid signed overflow in the
 broken-axis correction
Message-ID: <auvDldWq6qnN4Hnd@google.com>
References: <8063a24bb9f75bb9096c947d8ffa7123@gmail.com>
 <20261104055058.854710-1-zhugl3@xiaopeng.com>
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
In-Reply-To: <20261104055058.854710-1-zhugl3@xiaopeng.com>

On Wed, Nov 04, 2026 at 01:50:58PM +0800, Guanglei Zhu wrote:
> The JS_CORR_BROKEN correction multiplies two 32-bit values taken
> from user space via JSIOCSCORR before shifting and clamping:
> 
> 	value = value > corr->coef[0] ? (value < corr->coef[1] ? 0 :
> 			((corr->coef[3] * (value - corr->coef[1])) >> 14)) :
> 			((corr->coef[2] * (value - corr->coef[0])) >> 14);
> 
> Nothing bounds the coefficients, so with large enough values the
> products wrap around and the correction returns bogus axis values
> for the rest of the session.
> 
> Compute the correction in 64 bits and clamp once, and flatten the
> nested ternary so the dead zone returns 0 directly.
> 
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>

Applied, thank you.

-- 
Dmitry
