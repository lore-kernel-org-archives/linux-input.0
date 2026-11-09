Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794212372;
	b=GH2Xi9PslJt1GjCvMaqy4O5BDffqugJ5WXN12x04UWeey9mBBkBRsFR+gR8HyphiEmbM
	 IrU6RH38DlOu5tk5DbOuy0+4+yekNtU1Hn9LimuEihhL1HcDo0UkFIq0VqasD2Hr3bXgm
	 5ZyItJLjoZWi+Gy0Tv1oKB8E56c5ow0BDJSIOz1T1QXkzlD1gnpUWj94RnUD0wgPMPmp+
	 wF6CILJIcXqflCL7q6uuIF2DSWECexYsCHqyo1kcrgFMflchYk3OLMN0LczBBobmIz21/
	 0OQWy1rAJeGxD9q2adKFuN2t8+ZzYOs9SwXSaI0vj4o0+I2SOsvAjg3BV4S6jz9CXRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794212372;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=GNxYsHePFA72rBQ5eqylSPzfvf1h+1IxKFP0UMZoV3A=;
	b=d9RLrnGTjE1r7WSXcmBvdfTYUIeSfiQNqNHlbIcToYI0R9nSqFhQEv/OtBEf4OcCVFBc
	 woK6489UASCttBJDRs8t5YNprcx7rkWTl3Vz5Y2eeSWWwhEeQi9R+YZq7ITT6s80+70D7
	 fwshaE89y2yInCQzK3tGZPK+op9f2aPFok7XRkdDqRh7l135anFsuOz1ftdVAhWqr5+RJ
	 p3HnPs265VlkBC3vLp00LgmQmrzMITakvfQrQR03i1DPzNVdQpnynk3sY+3leKrFRQtdO
	 7FIGapiODq7noo/VXPDyobxOtb95Twc7NPq58Nn0Qq81ygN0GK2Oe6BheRs4PptSV/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HnVBXWlP;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AA3606A322
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 08:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77AA3606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HnVBXWlP
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so1067074eec.0
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 00:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794212371; x=1794817171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GNxYsHePFA72rBQ5eqylSPzfvf1h+1IxKFP0UMZoV3A=;
        b=HnVBXWlPvReTKYPPoSDUoZyz4QmqAxMwlfUfQZBW6dphuu2aUqTwcL+BhQ0ENYZ/tT
         BftDOXhkxQ+oGnp+wox+GyJaYEnkA3TQ4qzuNWYelFgeKWDoX9IDOZ9iYJJcBCP961QE
         Jf8vZl0MCQs9m11jTDCiV2XwMc8rWb9Fxzp1ODuvOX3JQwKt0sCrcBk8ml/P9dQBY520
         iqXy4JD+SOVc27Qso62i3CqkVcwTwo42vB1SPhB2yJUs2iFfZe7EYoN9yIiM/loSFY2J
         ajtcq6Wgn5tKKawfwsdbpl5BDRwMhugxY1K0Sj8BpcBKTxxvWQznY+EyousmkFr7QOnF
         eFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794212371; x=1794817171;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GNxYsHePFA72rBQ5eqylSPzfvf1h+1IxKFP0UMZoV3A=;
        b=qyOl972S8VGxoG1stWPDD538oroQpAAjKcjudpfAA+S52TFKmSRJ5kXAjWf47SH92c
         5W9oo7y/ZksSyfxZwYjxqerqe1wjjY761c1NdqvcLAqS8ZMrCd5P1+1MXqdBFz1hExlw
         0kq1oskbonL6STu29N9bXI/Ln/ze2KGtOF4/6kqo/omnMmCv2KC9vki6wIUSQ2YbF8z8
         ZfKdzjFiEksuVHu3sSSio7MYNhdMhWqrzxGFMedM5VQpHzb4JVYGsKAwZWkyxHQvXPvH
         XmsM+dWK+ZwKCcfrqWzecELMN8UPteybmn3E331tqSm0xC6sszSCnyHGBIrK5Cos7LhB
         Qk0A==
X-Gm-Message-State: APuU4Z+GyFnMfxFb0t1Jo/tZcSvzLjY6Npl80GmKbNTte624aBAiDbjT
	QTq/jVa/c5ePQKbareImxYaqHU2np4T6xGFtMAhu9Ez9LjsEqN4kWbZ1
X-Gm-Gg: AYBFou20nv7IfykeIh3bd47JZ6XYvl60GF/sYXaW/Ekuv6vrd24hTo2I6Qgw4QkkYdK
	el97kheT62iUBELlWYrscy+SAE0QRnfvzIl227zIOGenwzhU/0U1BejjN9FmCBoXvUpUZd6Hgdn
	Ln83O6PglD/1Cisb/nACx0uRpBUeMPwNNxTPPmK7NCEx50XJQbVgWsLQNTxYHEZgd1cw3zfuSqq
	VurBJpvCHE2Spm87YWamGFuqhqjwgCdOrmsCqUVimwOftj9Ggjdn3Xn0BcFvpqqJ1uigNEUQVWE
	DIQfazwXobRK4zgx/JUbKRH0S3l6ac7y9M29BmvO3dCrOT9N/RueNKX1Ev7Fs1b2hqnyd9eBLLu
	yurZAOoLcgsEhpoyp2RAWpM5vGdPER/X1oddM3GSMlwXv2DKPJ4Ww0jUHn8bUoPfSLDFF/Yla1T
	fkcmlyv/awcyxPa33gRc4E1CBU7eC5DA48CU8yljC4Z0Pi5PoTBOJqEfABoi6TslRwxyKAl7DO6
	1DIHW+sRn8oCDXEqHY+i+V3QUoiyV1la4asbJqCBWsrGePqo64QUSvP62y9JFXaChdMI3gQV7B5
	8t09ifuD5r9MVQ4Sr1sJP6XOgDQgNQk9X/xl7yPws5sP3Z+nGWXdJbieKizPTMmpikev
X-Received: by 2002:a05:693c:62cd:b0:369:ef63:ea95 with SMTP id 5a478bee46e88-372566143ecmr6512053eec.6.1794212371386;
        Mon, 09 Nov 2026 00:19:31 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37265619774sm11812904eec.8.2026.11.09.00.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 00:19:30 -0800 (PST)
Date: Mon, 9 Nov 2026 00:19:27 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liuc63@xiaopeng.com
Subject: Re: [PATCH v2] Input: joydev - avoid an undefined shift in the
 legacy 0x read
Message-ID: <avGCAIRLN8QxPY2c@google.com>
References: <auorp8LgmW8Fr9tY@google.com>
 <20261104030708.791730-1-zhugl3@xiaopeng.com>
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
In-Reply-To: <20261104030708.791730-1-zhugl3@xiaopeng.com>

On Wed, Nov 04, 2026 at 11:07:08AM +0800, Guanglei Zhu wrote:
> The legacy 0.x read path shifts the axis values by the calibration
> constants that JS_SET_CAL installs:
> 
>         data.x = (joydev->abs[0] / 256 + 128) >> joydev->glue.JS_CORR.x;
>         data.y = (joydev->abs[1] / 256 + 128) >> joydev->glue.JS_CORR.y;
> 
> JS_CORR is copied straight from userspace as three s32 values and
> never validated, so the shift count can be negative or wider than
> the type, which is undefined behavior: the shift compiles to
> whatever the architecture does with an out-of-range count, and the
> compiler is free to assume it cannot happen.
> 
> Clamp the shift count to the width of the shifted value.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>

Applied, thank you.

-- 
Dmitry
