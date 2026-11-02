Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793589903;
	b=WOe9qBkJFcyKoBbtzw06fQslHW+mCL/OFoQnz2CyM40O6LXH7JtG2hxqUczEFkknZI2H
	 EPddERY9OAftskixAkS857F4gA7OSlP+EKviFOmCcDtNnqLdNtPTRZOoFTSwM6TvKt/Dc
	 lMBJ5hl24L8py+eHmhf0pK3k2Vb0cq07/csNCjitXPgMeEO3+Rp1Llrix71+nGe9ZuDPn
	 4Y3Pd2Pw4UXDEZGAYi0xgERZUVbIk155aGoGwJZfDJyr55nDgElWK/8CxH2IuPHd6M5ul
	 Rdiqr5p5znJto2SZX8m6D7qvaRVM5TUepGmALKy7FniPs12ux7ChOwhU3IBP7sVROVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793589903;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=0E9J9e3u2hpIBhyJEtBBeasR/W1HfV4YhtxW7rdlBNc=;
	b=BajujW9OdUruVoD7jnE4eZ2Mxsk88x3W/JYTrs89MFwcVkSzIRIAVj3DMcF+ar2u5zEk
	 hcMx8jPY2sqoUbD2oIiSsg3SjbMGGT9bT3qwZJ745C6sL3LMEhvfaGhtxEWjZjVntHxCL
	 eeIWwJ2QTAgbmzMpI7yABus+X3hV4W0LokQ0opeWcD51564tZJXrkm4iOeK6RzjiyLZdd
	 DfNqOt4ZjpFwk+kAO8lgd6Jx+v8nynLsWldPXlQRmpj54cJiyQqPAtVu1uNbVV4LrJ299
	 U6QT3x7cZ2kiwflUksVGc/lc0R3+3bXZBYzyRCwjo9W3Hq18j9I5w4BZQEZflbq5GfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cUrMkkDg;
	arc=none smtp.remote-ip=74.125.231.130
Received: from mail-oo2-f2.google.com (mail-oo2-f2.google.com [74.125.231.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B232606A327
	for <linux-input@vger.kernel.org>; Mon,  2 Nov 2026 03:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B232606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cUrMkkDg
Received: by mail-oo2-f2.google.com with SMTP id 46e09a7af769-824413e10dcso1553618a34.1
        for <linux-input@vger.kernel.org>; Sun, 01 Nov 2026 19:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793589902; x=1794194702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0E9J9e3u2hpIBhyJEtBBeasR/W1HfV4YhtxW7rdlBNc=;
        b=cUrMkkDgUhZ2oFqr/ht1C6GIkzL8jnOecTg0iysKs4K0V0mxwdwyXY3xWu98lZpSNJ
         Jnt2Ef2rl+7W51+MUtYfjfKGW83QauEE5mW42k7QWGOCmUVJch91o3ELG9oKSGA7S95u
         ALxRO73CswZIVDGpUX7qrCJ85V/7lapjCoChdK3be984hrVvQ/StzgimZbrTUpKQOfbK
         3SCKaRVR2MopzLBJSiozfI3ZYobPcxXpK9/M3SDTeeXMMKnfvdLBZMvTZfdKdV+7cpWc
         NrXXlzDVBH6n5L03Pq6fmOmZirWYuoUEVYULgrxD+sVDuTHBKcFzH+I6oPit4BX4rYXr
         Ozlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793589902; x=1794194702;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0E9J9e3u2hpIBhyJEtBBeasR/W1HfV4YhtxW7rdlBNc=;
        b=0d84GzXaoSacdzmypSDf++Vee/j5/++Lj9wPvVrzhAHZ5i61dfQ+FKJ5mdug/7Y53Q
         HL+4a+HMN+eWReRZoYt1RCj8fhJp66Vxk1NFzF1Fo0sKrVF3TJ3Eaj0PzxXUY3wUewty
         SP5rO/vQbYqBKYCvujTwOg6BhJ7Dta626A9ycpUV+1EnubXsCgmG2AAQl7SkaKJVEf2a
         jockEAEgEOVD07Rpc5/dWR0NO8ZA6Qqon8n/hS2JgIn+3OstbQl3BNRlUfHq3sC3zmuG
         GzM5nwIsZx957Yyop4LcFKOL0wlIfes/DOL0JzCXvNbhicTHBZ7P2IJa1HaNvvog6WTI
         Xn0w==
X-Gm-Message-State: AFq9FYKYXZjsiv8GuFuQhXV+TSP49DNVIe1v4Tl/o1GwQVMh90piIP8B
	plV3YNQCJTWu3mpz4CGs6JcyIt+nwPxCrlFY6xc519nb5HKj4g3/vcUC
X-Gm-Gg: AYBFou3FOaCFSHt4aWgrVw+3+K8MWUvoPhKdpPwbflsTnDQtaOJY301qX0PIsdnpF9T
	C+IznC7lD9K9UN8DZWs6NXhOPbwHAI+yGGDQQJMO1yFqvrjbzeQpLU4N/5nNkb9sLJSEcvGWhOP
	lRSk1UrkPzT8028fFebtncNCkJ5pOpMs1fesaPUZ3d8QexPOiynWj/6QTP7bYl0m2y3ThlXqbUg
	RtuN6xyfmbZ9tVoeUFxiez/NnY2Bxkl20+X3pMCAS8IKBwlyl9umPM0r3WBdB2/tD5mvqnDTi70
	nbMWJzG1ycArIe+pCDcaGMWu1H9CPse9KNVmLNsTMF6fm6wpvPnO1isFs3wiQuS7oetcGnn7DbL
	QxCvv0WlN+ynzgSHQY7CyGXBhcPb5Lou86qV3PwAFWuGW0NbpIeUbpB8b9Ryp5iav5ZCFqxhiWU
	HtdqiTItuz1mjjTKS7/FbkAqxlFx3AQx8zrNg4fmKiuTq1Yr80nDiHSaT7Fr+0A8nEXryPQWIjv
	DCAUC1AxDKcA1hFfHmmN/Iqlv+3C0Zg4kZbhRhGNtazIWwSNXrrgol2aRi/TH3muAzWGkv2ukOF
	3rTYCkP7WFbmNBPi6mBMhYMuO2fsCrLkA+yeKBuYhRA/
X-Received: by 2002:a05:6820:168a:b0:6f3:6cf9:f182 with SMTP id 006d021491bc7-714f2480119mr5364303eaf.50.1793589901912;
        Sun, 01 Nov 2026 19:25:01 -0800 (PST)
Received: from ?IPV6:2600:8804:5716:d800::f01a? ([2600:8804:5716:d800::f01a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d35499153sm8255830a34.9.2026.11.01.19.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 19:25:00 -0800 (PST)
Message-ID: <34cec90f-b6f7-49ec-a531-72150891dbb0@gmail.com>
Date: Sun, 1 Nov 2026 21:24:58 -0600
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
Subject: Re: [PATCH] dt-bindings: input: mediatek,mt6779-keypad: add the
 MT8173 keypad
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20260915-rbrue-suez-upstreaming-mt8173-keypad-v1-1-96c325efacbe@gmail.com>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <20260915-rbrue-suez-upstreaming-mt8173-keypad-v1-1-96c325efacbe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dmitry,

Gentle ping on this one. It has an ack from Rob and reviews from Mattijr 
and AngeloGioacchino. The device tree for the Amazon Fire HD 10 (2017) 
that I'm posting for 7.5 uses it for the volume keys. The patch should 
apply to input/next with a three-way merge. I can resend it rebased if 
that's easier.

Thank you, best regards,

Ryan Brue
