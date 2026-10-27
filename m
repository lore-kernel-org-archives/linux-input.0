Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793126489;
	b=LEBhe9WwiEtTc+3vZs1otMApu8qk59VoLd688mDalxplKjAprEYlB1KTBjN2Axpjtz6j
	 mY80Xit4MolkRq1KGreCDTvJ9lQVSCgiBl1qAM0mR3UsNbFGxLz9SoQ5tcjG+4n+7rIe9
	 H3/8nOZvPl9qeZXhfcOpXJ4WNkOW7Jj6w7DZ4BECuPmcYA9vYV/NPVQTF1w8qaYBbqZ0g
	 TdQJZbvYEZC8Ci3C2VHzT2/8C1UiLy0hmFGgq+ir/WXmhotitHSbJY573gXBXRvVVrDtC
	 qtj2UiMmL1A6WaXXQ+40m4ACxAOwHcFTp7vgAxLsuzgHh01SSbqnkENPufO2HbmoL0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793126489;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=Ueqp4ooYCIC0ww/I1nNHHuU8J5a6V0zw1krZPC0NXzI=;
	b=N1ZCLFQwLRVJKomMge62QFXqlTPXf9u5mbtCuKkBxy+0eXXIzl87qbn4YxGYWXNOI+sC
	 B2PfwWsQlV273Kdevs+ckkbw/FdG9LUfkkjUE+8R20olVab2FwNTxBGk0eL/yE7ZACI3T
	 +2tt4bIxCmDzLMXsCLr14Sat5jL3aBCqKYCZ+47Nf7iukNMgFG8BFbMWBfaGZa2yjohPW
	 tn1vq2TIZnxhk1x4iZgkwM/vMsvusDKp7Pe4GRDvbAioZNWgF+zA9NMm8gYI8mWKm49kW
	 P9wj3a73OwcZ81dAMNZVDjG+s/n7uF0IzVOGs23xUR1dGYAGKvwwKn3tWBss3FTFKwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NMcgWaUI;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BDA606A31A
	for <linux-input@vger.kernel.org>; Tue, 27 Oct 2026 18:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9BDA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NMcgWaUI
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-185fd3a4ca3so159878c88.0
        for <linux-input@vger.kernel.org>; Tue, 27 Oct 2026 11:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793126488; x=1793731288; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ueqp4ooYCIC0ww/I1nNHHuU8J5a6V0zw1krZPC0NXzI=;
        b=NMcgWaUIy5IbpYvU1M8ji+8J0udcnMxFTkFc8wRiK/ySQoIVoqU6lUrwAj5UA4fMZx
         AejLPo8Pxd5VSPvH/ZdUMq8EZhnPPY6tCBnghLR8ZfD2Xowd4ZTrc8aFziGik8BNAECc
         lkfdF6fMdDFjPo/BheY94D3GweY+Hng/WIKviypsOy0Ytz/CJjslGtzsB11fCWQUKvGH
         vc3cj2KzbZIox6q5nXhuMav+E/wX9bM4iQgy5I/0MjzPv1DVmf66ZBxfXNUnItaZa6OY
         EIImIkClQdDHzU8Mv8vGhvcPkLGPu5RvzCX0QLF2XWQnngleEGf6wG6LMgar6wGWmZ8S
         UhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793126488; x=1793731288;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ueqp4ooYCIC0ww/I1nNHHuU8J5a6V0zw1krZPC0NXzI=;
        b=y0Sldq9eF9NPnkQ+0/9hCP3gmhcFEdynTJitkoxRj/vMbRPoyuJqeDHIbCJqptBiw3
         sCZQXCEBIY+qcyilfR+CzgiamTe4i6V01j/X1+21+xaxAP8ioa5RYENWQLazpxB/N/B1
         M+DXZ0T5Wa9Nlt2rIpTBMVOxtUvtuRVlBxd9y1rz8VRcoROmkXTWX6CdF1Ed2IfrCgn4
         arysiONIzXNFJrvSZi2/+L5aCcGKsZK7qQrxfy5Lmfsf0OD19Pg6PXsxzyFEZPZeQTaJ
         EyxX49PXgsWxJj51sQcBW/qzEilaEP3QGMpGhVuKdKLq+G/HgfCjZUm2j5fWnI5+uBxK
         1SEQ==
X-Gm-Message-State: AFq9FYJcxJG8/jWLI2PBqMgFeZEg2k4HfD9T884RyPOjuH4wOTd16dsR
	Cmq0a1xufwWK+iZMeAfDoFy+LJv7qVjnaR16wDtZnO8zJvgStBPSPvpC
X-Gm-Gg: AYBFou3GDmIkCFjpqQKIUHRLyvwENpqMC00uvlghrrqxgEttmEMHCo+B4fSDG7O5RX9
	nTTX5ncrFUDLTmZZpJ1rIPDxxehANL1W5jyL264cMjzVix5p7ie5soN+FTFruA/HQ7sgTxdF6jA
	b17lYtN1nc/IlwxLQLlq2fQTdtuUViIsHvqLcUTTM13W1oSwmxgfugPNraMVVI/gKMSjwxA8zqX
	SW6cg9FMJjuuqPTwfaUDdGGQITPQFK3tx4qSZWyLbibO7c1l2tV5ckdBOZIFaEU0u8AL+uKYr6y
	PBFAV5xTVgKVIKvuOnIdWw0KlB2XXpP2xgIK/RMk7k2kPm+n+djt8+Yj7plFC7IewDgb7lcqBqr
	ufSxG4BeDhyADo8X3NA5lBuNIqrinrDd82j6aGMgnQSgEycm3mld+m5DYTlpLPXPdIo35MfP0dt
	wGyez300UZ0q3wT63MzrVNWfqVD6PNM+3qBAkofiZ1V5hY/w9pLQJgQ6zfAgV9Ty5MQ9CYk8B9c
	uWT0kyQhxinRhnyIYAfM9RBIOH+I4+UMs+3ZQUINew2/cE5pak5dd5vShyrGKCQ12nJx8InLb6h
	wY1ZBwfRHjP2DfPxhYDEnHr3jtOOsRWJudpEhAf6izwTlxO3Nd0IPyDGL5Lj3JSsklCL0P0=
X-Received: by 2002:a05:7301:d185:b0:35d:eafd:5737 with SMTP id 5a478bee46e88-36a20418d01mr392582eec.22.1793126487975;
        Tue, 27 Oct 2026 11:41:27 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:9958:9525:7799:82b5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec9276sm60615854eec.25.2026.10.27.11.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 11:41:27 -0700 (PDT)
Date: Tue, 27 Oct 2026 11:41:24 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: =?utf-8?B?SXbDoW4=?= Ezequiel Rodriguez <ivanrwcm25@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Input: evdev: propagate EVIOCSFF copy errors
 correctly
Message-ID: <auDwT-N9DzZZ9BJo@google.com>
References: <20260831152156.166514-1-ivanrwcm25@gmail.com>
 <20260831192752.258550-2-ivanrwcm25@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260831192752.258550-2-ivanrwcm25@gmail.com>

On Mon, Aug 31, 2026 at 04:27:51PM -0300, Iván Ezequiel Rodriguez wrote:
> Return the error from input_ff_effect_from_user() instead of always
> mapping failures to -EFAULT, so wrong buffer sizes surface as -EINVAL.
> 
> Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>

Applied, thank you.

-- 
Dmitry
