Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974E4298CC4;
	Thu, 22 Jan 2026 00:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769041366; cv=none; b=dITxZeyodSzaL+2RNUkGPd0QW3AQaOGnylWdqq77rpUYWeDh89ZHq3FjyeAm/syjMTR81I/1FjfBI6ooTHqt4xq5HNarAcg92/yzCCBqKGhKAXc8PizM2IaIX12QTNHVx7ujkFmRqg9xPNeesofp1yVnMRfSBfcimLqC2IZE3rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769041366; c=relaxed/simple;
	bh=wXmvZaJHnHEmQw4+mzUEmhOQebBaEW15sdCEfCzdAfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FueNOKcNvQZJhbJMgQE3nfVCgTo09DmOktEfLLsUTVv1Mq8TOKbkQQ/FpRPTZalbjkQcp4MKOhKYxfYTmHMFUuD2hLAHYwtuO7o+UTiYZeo+/xNwJYE1CMl4ZLkU37TQ93Bq4JA9WGYiHP3+ENcR86R6shKbk/ML72U++5cjMSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=FnBxAC6+; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FnBxAC6+"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dxMG90270z9vH0;
	Thu, 22 Jan 2026 01:22:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1769041361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqJqIIb9EIJ3nNV1RGBo1mlPESCA3eUUdDSbnApAn3Y=;
	b=FnBxAC6+vAeDnTrxHBbo1um2Pt0wDpVe3mwCnb7Umkdj2dCCfMgtdMavjP91CjOFK1NlR0
	O5J7D+5bDWS7jOV8dsVQ3tlkj1vtak09XdH0PG8J1ueUEHXkFhwIhJZwxokciEBt3bW4xf
	ROax3U+v5sKZIo0KaHn+v1m5mPuVGpif5F09pbQTDBHxGkfatiWN8mF/N8/CVuhTrATCI6
	GCym+gI3ujeqxtcGf1U+NzPScn4pJTTjopzwR3PKpSoOe7vJjR/i2I78RWF9d0R+rTmQMF
	WJMOa8zXLXqPb/KJUbONpB0BztIkVcETQcyfbU6kR/yJagp+/u9DZ3GGFsO07A==
Message-ID: <4bfd68f5-8248-46f3-b37f-94feddd4c0e8@mailbox.org>
Date: Thu, 22 Jan 2026 01:22:38 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 1/2] dt-bindings: touchscreen: trivial-touch: Drop
 'interrupts' requirement for old Ilitek
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Conor Dooley <conor+dt@kernel.org>, Job Noorman <job@noorman.info>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20260121230736.114623-1-marek.vasut+renesas@mailbox.org>
 <kzt3myrtfigzvtuw62eqts5tjfwvlueuzifk7dsm5jvawztsle@5wyzecmltldb>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <kzt3myrtfigzvtuw62eqts5tjfwvlueuzifk7dsm5jvawztsle@5wyzecmltldb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: aaqrxqkrnptf517ry66rnafam6hj3oz1
X-MBO-RS-ID: f2733a4f2f4c726e3c4

On 1/22/26 1:19 AM, Dmitry Torokhov wrote:
> On Thu, Jan 22, 2026 at 12:06:46AM +0100, Marek Vasut wrote:
>> The old Ilitek touch controllers V3 and V6 can operate without
>> interrupt line, in polling mode. Drop the 'interrupts' property
>> requirement for those four controllers. To avoid overloading the
>> trivial-touch, fork the old Ilitek V3/V6 touch controller binding
>> into separate document.
>>
>> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> Applied the lot, thank you.
Likewise, thank you.
