Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795680142;
	b=WVTDwxeOil1n9Y68na/OnXsBcBSvuC9RCmo2nc2bL7LV0ic6KkXAtdZzp/llPfGAXnSj
	 zwZklbes7RY2YFYntnXS3HGQKLm9uz0q6AdYbSuyDP2aliI2bsrQdehgeqXhSSmbeMdTM
	 wT+v1wWt6Psm0TRaPbKPZSXW5wcZznId7BnEHd8CVzeoOUPSoFTXlPspp9bc/HKtvMvnN
	 4r4u2fMmsANXbbllFL/Vyd72oWws7B9vjCZ+D4spcxSz7VOthgkPWNi+xi3jg80IRL4OG
	 NU7yTyXdGRCXYxGAtAPu1B1ChuIrHbDpikViSGbcNR7grE6wZHCLm8aQ5okJnBI2L1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680142;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5WBdpIC7hrsUSUFK3RWJNVEX1ybe0b8DDi3uNiJ2FOA=;
	b=oCYG/p317MQYYo8Kw2wkitM24su7aLuLtCtlM46JwWWGsdVA3SEyAjSxnBQP7+4PfhZR
	 fOXJZI38yrcB75s1WbS50jJIyor4OmyuYp6A/n5nDgBqrvOPrU+8sf0M6SaM2Vrds2lg/
	 wR9gNXuI+rhQA5bh4dVd7UNZnK2eMji+1J0gZghGDKy2kiaeTdQxHfUzFsqLUKcD4qKWq
	 ImgCxhiuTAfSTgT7uHINRejYDVJ7CY2co6vemzSgfi4ojCHkbHRY983tfbymfFjD1JjEO
	 i0puytDunMu33TQ8rHXMZwsP3Yfr0x53TSddxE8qKy6cZaEnvbuzbpjIRb1/UuKfuGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZQMG4sjD;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73100606A31C
	for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 08:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73100606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZQMG4sjD
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-386b8f2f671so3649056eec.1
        for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 00:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795680141; x=1796284941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5WBdpIC7hrsUSUFK3RWJNVEX1ybe0b8DDi3uNiJ2FOA=;
        b=ZQMG4sjDBseBrkpb8YZxaNE8cGyH9yxvtDbr2gT0+NA+lVdC98JnkhYqQOgEEzRI3Q
         aS/AE9iPIa3W+cozWuyyYHFLpzpcF2BY6KDgoWMadFxywb5uPGoWFFvIcVa5bb5MMLtQ
         6JRXRHmKB0lqQcnaoa0ib7gaps1DpHmqp9W9qUBP4L2WQlGdV4cwr49w2fXAtKIX4thT
         6DlmhuG59QIY+uctl1M26DVL3Af5JIA9swoH8qbDkB9v+vMN/eWtWUi4aCKf1KHvb8kY
         GsLJaf6DvK18KkdZseUewIDtNLdcDtEH3ylCPNC5FdKDik7i81k/hElAL0ZckwE75Zox
         KopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795680141; x=1796284941;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5WBdpIC7hrsUSUFK3RWJNVEX1ybe0b8DDi3uNiJ2FOA=;
        b=iw1BdxWb5tkJJDryL7Q4viyDsMDsc81WbtxjYRx8L7zbBY+avIEkUU/wycUNsqzXDV
         LA1Xw+OiBxu93satytIGrzlAoTs+MJ1ovJ8TAIWoEU97Dq9uFGeZwXHZd+UFJQv7IFoo
         2956yKLGS8KS5C1fUGL2NETCvCGVuDXxSdfdo2nljjY+I/2F8ndSF6stTO8ryCej8goT
         RAqCv3YUOQW0yHAbtktajC4t+MoUxK/CN5aBU7N4G3BEPS1t9kNiPG1ejPWMLvWDU3/+
         8WvOjBB9gfxwoeufo0ZmhYSQsi10M4al54HNYT84YS3UnoxrvKWuhbSdIgcSHTl5i2Iu
         jkfQ==
X-Forwarded-Encrypted: i=1; AL+hErEnrizWY6p6T30kg1PZHozo3sZhf0HGGF1wExvLaytURM57NnxXqyV5qW8jFmE38FADrA4mpV+CY64uRg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+1Hyz5Y27OSGW3rq14asoGsVYGyyF04JqrKfhY+VxmM/Bv8m/b
	mS9Tymz3XWYwYDaLt/kzvJvmXbUJf8+o1M1qIaZujPrTYelOlZmoT05K
X-Gm-Gg: AZFdTZdep46OGZPPY+wFSiqfgYVKodXaNJUi5bMLTIUbDTaxYKiUl4mwRrH7wS5TXk6
	8u8R2bMoseGUQwpp/a0DTTMp81555kEzTg2FQDzj4cT/U3fY4FiE+i/OCv8jNRZkq1Azp/cH29v
	Fe2pzdh7/ThBZW9AzB1il7LCNv1TOrG9XYrXYvJ2GQmgtFqr7BfSnRnEE51JP4jPR0eXO8ZefR2
	7bkUsOIYnE6ACQ2nvIDJlKGawJBoZQELCUM+c69f9YXn38XBsiiUfegHKuC/5F7uybS4O88INL8
	HQveoT9Z/PhwmKxHsezAj7iwcjWqvo62VCuq3EZq8YHKAxGqx0W3SVIV9dpngZd2RE4igO5wI+/
	68/zbco8yuj8Vl5I8RP1pHublgKMIeKER0dPco1lfFapaPXWPa809XNFId1t6cMz9rtg93uWCyo
	cWiVrKKwXW447RB4yGRIhJqewZfDsQavvhLm+SWuh6P3e/XYNkpKRrvUAXapZlVxlAzxwEZOX+A
	qyyg+2q/EU1InUCcTPO4+ya6ClKR/ADPHTQ4HjZown7iZUOmspG1y1pPQKGU10TUMgDCaJQPVPA
	LSM2V7cJqTeAuzx3tMbNe8RRqPCmFzTfrMEX+Pd5sG6XAK+Na+veFya0yqpbUBvG3lSQ5KQ=
X-Received: by 2002:a05:7301:2222:b0:384:2662:a7fe with SMTP id 5a478bee46e88-3856c9a1180mr18683035eec.1.1795680141364;
        Thu, 26 Nov 2026 00:02:21 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:f528:8797:fe51:9f7e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386b9bdafb5sm27499672eec.9.2026.11.26.00.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 00:02:20 -0800 (PST)
Date: Thu, 26 Nov 2026 00:02:17 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Gerard Marull-Paretas <gerard@teslabs.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Oleh Kuzhylnyi <kuzhylol@gmail.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] dt-bindings: input: touchscreen: hynitron,cst816x:
 Common properties and supply
Message-ID: <awfngq8zPyqYC-d4@google.com>
References: <20261122093405.70406-1-gerard@teslabs.com>
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
In-Reply-To: <20261122093405.70406-1-gerard@teslabs.com>

On Sun, Nov 22, 2026 at 10:34:03AM +0100, Gerard Marull-Paretas wrote:
> The CST816x binding allows no properties besides the controller's
> resources and gesture keycodes. Boards also need to describe the
> coordinate range and orientation of the panel the controller is fitted
> to, and its supply, which is often switched along with the display.
> 
> Patch 1 references the common touchscreen schema, patch 2 documents the
> supply.
> 
> Gerard Marull-Paretas (2):
>   dt-bindings: input: touchscreen: hynitron,cst816x: Reference
>     touchscreen.yaml
>   dt-bindings: input: touchscreen: hynitron,cst816x: Add supply

Applied the lot, thank you.

-- 
Dmitry
