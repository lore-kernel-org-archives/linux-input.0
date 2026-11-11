Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423452;
	b=shHx/StoLbyFabEQm0WpQpncIjfMUmrNxFLrWXubFR8QTd/oX4hl4/+9oStcWKvynEPL
	 u9acmoKWsxDiF26ZEBMnhgeTrhQ1GXsVraFcixjmizTEvJZhXnZ1iBTJBsPgDQewU+hzl
	 Ikte3u5uHhw65TTXcq/y8gxiVn1mXIhSsqvkkQlFc5hF5s7NdNa6lXQCWlHWqusS4Mbpx
	 3H56IRG0lfmLphD51CVDzy7W5ZGvlawCtEUsoVj2FhuDDQXhDRpjF+rjoLm60k7+bF4Jn
	 +dyPH/3V/p67pmlap6e9E348mUeh23EulIKVvzTF/EQ+Fz5M06ylrzDJY7S7H9zJgHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=PvpWB91aPTgwry8ewGxxPpJ/Tnw5Kh2x9Pevtsk6tvc=;
	b=1qePxNEcaHodzaLynU6Jr6U23r3HDfEcD5RmvvLD1NOr3ALtfq0xT6UF4HxhtLx/m4TS
	 0V0D8V1tGVFAxzJnH7pqRem4hb5hHwGsJPdy5a96qHJSLWqECHeZYjmtE9jmvigeldiwZ
	 7aWUK+aApRTdIMR9WiLGqHUSZ+o4oqN8CtSrBBNoHIvdHPJcKhcTo78TtDJHl3iN4pvIG
	 9eBT2naCvAmdlNiellRHDc2iWvvudLW91l64Wiw1iey5eQY6mlfE18j6/YsK9XSzEIepO
	 I40qoK3dyB8Ae+Lj9b1z92iJp/SclN6aj0sfBpOwy8+hxySw0b7DmSuzi52cATxOprQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YqelvLj0;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A970C606A31C
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 18:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A970C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YqelvLj0
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3282db206d3so3669967eec.0
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 10:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794423451; x=1795028251; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PvpWB91aPTgwry8ewGxxPpJ/Tnw5Kh2x9Pevtsk6tvc=;
        b=YqelvLj0IRxUDkbhDT0kpkrGCVYzruw66Dcu0yzW54FSc72f8KaVVf7vx3iPDwt4UO
         IC4rTwAqX7rTeOsM7NLMgqiyU7I/dwzinL9Gln+xYVxXNo3e2gSczsTOuhKkOdv1fkuo
         wUzeJ5IJ4vz7MjA9T0otZn2oMwvlUdrPTdRCiQSLnQhRGWdubFn7iDBe4eFRm75Cc6/V
         sByJk680AmDD86w2J7KVjGSKGjhOTezQfDrYxlGsDZ590Db4qIVZBi8oAHT3E6nuhtUI
         4hW9dpLTqOEVKHeYedZM03IFRhkso3XIZNDfuFTQX3wqpAFmjT/QncA8KYVPBBLxahkp
         xCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794423451; x=1795028251;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PvpWB91aPTgwry8ewGxxPpJ/Tnw5Kh2x9Pevtsk6tvc=;
        b=ySU5RnGPBfbwIOCg5b5vXPJ2awthVPlefe9DCldEizILut24EZCuuXfCrCCO+AdGg/
         Ofl+/zIW2nTifV3Nm8OQXIBafAGaBJhhMEKpGpy0J20bcMGQDQcjRY+0Ux6dPLc2tWPo
         u0IMOfYIIKytIdxJaaEuYf9N8+PDh6GCRAQQGI4rwmTKNQ+Hxq/imovyYE30pnDLZw6v
         iQ/El7qzjoVjeWzesHp5R8Eq+DHKv/qg9DWkXbB7Ge9knFpkAJFXNxbSg4byBY8YxFJ6
         8kKl4xSXECK5V5Yhw9Eid1jemo6qit2NCn/QNfJ/Ne5PGKbBpxsXThFzb5VQ45Uo7zk0
         2qSA==
X-Forwarded-Encrypted: i=1; AL+hErH5oxTS8oJ640WBdU2vfxuZYNArfGU9xVUeU4yyI6IPcZ/RrXU0WRDXFvkdS64bj+UV140bBwpVr/2diA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/i67/lJYUe40BIMNw6UoaGC9w5ozKnVzrDQg1/fsyyJy6kDw9i
	WZdeEJSM0os15Mx5OhdCk3ybEAtjrS5xm+m8JH1wXKVFPfZvnKwcvZgEzEI8jQ==
X-Gm-Gg: AYBFou3f7pZwFbv/cQAf2ROc7w3cE4ZWvDqdmJeIh7KiUCndbf54/yrFcn3IJ4CdB5q
	sdSyaVB3uf2rgMlKl53yHHn2ItEJqrzEFOKutrypJSCIFCPMpYOekQ09GXWcSjuIJtJvaMIzTC/
	7FgZiKbJpQL26921iElnIMzzZrk7mvIt8vRUG/HcGUB23VF4LU2Q77s2mNah9cLx4jZkhtb/AHI
	lH7NrvgOYiCDx8MDmlQ2cq93n39+srA/YpMcsUerLZlaMn/D+n5+K1DI/h5yC+DxUgjsLXaSHOe
	gsD9I+gobt/BD0cwo8Koy78nYw9AOZf9s7AkLOUgZt6ifyZQbphEWyg2mgmE9IOzf+5TbBA479h
	J2mrbj8OUE1wbIJveFDeaztWK4vR0AbdutdVliKmB+eCcs+g8wYZEYGIgLyoBrxQw6LURSCL2qa
	ayIC5pTyypKJ8TVLwe8E83n5RuyOyYEAyoJPtWB8qpJoF5aBEuLsNEGXzl84JJb4b6Mznr3ttUX
	uTiWBZH60C61i1lYbXk9Pu7DtDwPgEpY0nPb3BrHuZKGwppZ2ThroL2LZep7XW2xoW1WtKUe4Sh
	+HWJhs5m1+uAFbuecZucVmy3GARNrLFfhvl6YJZq0kelMSMRw5X4ZjxfYkPkKY+mwcEJqA==
X-Received: by 2002:a05:7300:1ca2:b0:36a:12c1:3adb with SMTP id 5a478bee46e88-37685896bc5mr3836499eec.20.1794423450736;
        Wed, 11 Nov 2026 10:57:30 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520bfb58dsm33703047eec.18.2026.11.11.10.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 10:57:29 -0800 (PST)
Date: Wed, 11 Nov 2026 10:57:28 -0800
Message-ID: <496e56a7c537e04be4b946e46439e103@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH v2 16/33] HID: logitech-hidpp: preserve transport error codes in __hidpp_send_report()
In-Reply-To: <sashiko-outbox-208632@kernel.org>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com> <20261110-hid-logitech-hidpp-v2-16-30743e91d83b@gmail.com> <sashiko-outbox-208632@kernel.org>
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
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, Nov 11, 2026 at 08:47:14AM +0000, sashiko-reviews@lists.linux.dev wrote:
> [Severity: Low]
> Since this fixes the return value logic in __hidpp_send_report(), should
> the commit message include a Fixes tag:
>
>   Fixes: 2f31c5252910 ("HID: Introduce hidpp, a module to handle Logitech hid++ devices")

This is a preparatory cleanup for the negative error code rework in the
following patch rather than a critical or urgent standalone bug fix that
needs to be backported to stable trees, so omitting the Fixes tag here is
intentional.

Thanks.

-- 
Dmitry
