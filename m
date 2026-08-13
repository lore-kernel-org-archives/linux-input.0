Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9442E8B64
	for <Linux-input@vger.kernel.org>; Thu, 13 Aug 2026 00:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786581746; cv=none; b=BaXxcr2fCF8y9hS2FVk2uDA8XnsS6tYw0xGTIziXsOQKdtzTZdAeZrJzXL2vHIqdYPUOYqssOPT3v+bRhb/4tVW0dLAqP8Lq/SAgwV5eSY2DBCqdEzDR7YatGMos3ZGPW4YWj3ZkQ1+dq5PWq4Zz44eEzwaER/5il07zCu+lq1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786581746; c=relaxed/simple;
	bh=OsV9Oy41uT1nJ4nKS7IzoQ0qg2DjIMTlXCfai4Dj+qA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFpbxZy90lTb0xbGqgqpwnzqWznpQZMMCAIGOdxEnIHRWBHMEpdwNTwlaou2U7Xs0aioh/ptc0Sn2zv8hGmo/aOE4y19tQsTgNcNu89Xfh5ZLo8oXK3Zv1BnQ18Orj/RzXRkWok/vTnjd8pzI9jWTsXFroMI12GxFbeQJna1sjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Na/u4AzO; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Na/u4AzO"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d049069377so16311125ad.0
        for <Linux-input@vger.kernel.org>; Wed, 12 Aug 2026 17:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786581744; x=1787186544; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9bMNjwXaATg2criQVvp41oeHF0qjGmHcyZl6nW6DMuA=;
        b=Na/u4AzO2ltNfdL0hzIuV1wGJCertas6jkLpi40IPx4gKdPi3K6zU7ZECxNqhLLsxq
         nlK3f2aOYsPpcajhnIs4/qm1xQp41eoGBI1BJlDmdCLbxf9aiAKiHfXOEG/fRBo3mAQa
         A84cnqdrcGamy0RdgIqOFzLtoCTqgEBtdLP0Yd9wGSxjGrkNG+wCKVXrWd6Nz/KhUVvz
         jIuHkpwKaB4CBlG9G6MEO/vVormtXuvgdmRXZnJtdB9/edaCC3xavFig1U7MeZO8D7qT
         lSIBw/10z2ONRxl1O2HR9pohy3F9MgEVWq1Tz5RGidvbWzVZtsvyk7fDiN0ilcGzRy1v
         /VXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786581744; x=1787186544;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9bMNjwXaATg2criQVvp41oeHF0qjGmHcyZl6nW6DMuA=;
        b=lcvm0/LoikHGD56X1T38wOvhF7yOp5YHaydiUPadLJ3YUZ/Fko0iaEEQmAqX8AJyIJ
         SkxD2+VPCmix0Gm68w7WWBdMVmE4L8PLAUgSQPjTxF5DahuYTD03ZIUUS12QZnS8iWDl
         pMmarRhXDbow+2JzHDMNcUUC24rNa7v2e4v4JbgP4V0z/rUg4RmQRswNqkip/yVh/Kkh
         0UTC5EmtMV4tqc0GdXtFNpDoFquX7ggxpZPrL9w5aFzF3xwdXdAe2XptQfrO1fsRHcZd
         JdidxBJHJ0UNnIHW/QqmftC7J7+1Ir4I9yvvzRS6J3kjxSygPVRLMhSnYGH3PxkR3LSc
         oyCg==
X-Forwarded-Encrypted: i=1; AHgh+Ro37+wmVOsbIimjpCxzuNDbLKHYVKQ1RHVj3C5FehrG6a6hAKFcBCswLI6ok6y96yQxyBVZ9Q+TKwyYSA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2RZOJY/5NFRLVp9QmAHjHcmp9Qr6PX/GC0mVHBgcOa+Rpn3wz
	96gb02rNsEvqwqrhaubrQSRs5NpBSAG8W4uZP4Ezd8chuT0EkELGo+uRGNuuCQ==
X-Gm-Gg: AR+sD10O5xqgG4ik+eOFTMuQdkA9pNugtPfFDCj9kgfb430Lt6wkNXixrG0YhIUmnVM
	a97Ufb12mhgq3F91ygGL7BjQj1OWtbEX0QwVs8MroHvu+FCMyWSsXwc0Za9rhVO4E8g9H22fCaX
	B2bEFTRihmpL6mdAVdiM0QfSMo+qITVFFz8uJKYl14SZNSzwEB9Mo8YfV7NTtwL89uSr2+CqBpf
	Gq4ug3QDk698dHhkWfkjr6ut2y6P2rAGtzULyPces0UubLrxS9bxOj88YDwKj+7N76kiGQPHxVk
	1e/9XVeh3ymMaOoEg/wLD245BfDZrAFnN/nePMgy4RM0dkSnDWcshPuK+14SYMGIwhRq5Sbf2xH
	Pcc0xHTgTp72XqAWlOKyqgiojmqMRGsaaNg7lbnAvrq++Rd8rOSlnJmFEGiAhZcRf7xlVtI7qhk
	171N7UKpbMFaccjnYiGXxljkxzvTO3w+GyBDPCCm76RXMxSwL6u5s4BPHtxhWnsHJ27alw92Ur4
	wwU3OwlULlHisCmtdi3GFhJhqF8JQ==
X-Received: by 2002:a17:90b:278e:b0:381:25ce:bcc2 with SMTP id 98e67ed59e1d1-3931e0242f8mr2728237a91.6.1786581744054;
        Wed, 12 Aug 2026 17:42:24 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:8656:b5a6:1038:61b9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ec08284f4sm1181428eec.31.2026.08.12.17.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 17:42:23 -0700 (PDT)
From: "Dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
X-Google-Original-From: "Dmitry.torokhov@gmail.com" <Dmitry.torokhov@gmail.com>
Date: Wed, 12 Aug 2026 17:42:20 -0700
To: Jingle Wu =?utf-8?B?5ZCz6YeR5ZyL?= <jingle.wu@emc.com.tw>
Cc: "Linux-kernel@vger.kernel.org" <Linux-kernel@vger.kernel.org>, 
	"Linux-input@vger.kernel.org" <Linux-input@vger.kernel.org>
Subject: Re: [PATCH] Input: elan_i2c - Optimize update speed for IC Type 0x19.
Message-ID: <an0S6INPQaCFUASL@google.com>
References: <KL1PR01MB5116A253A126179473EDB7ACDCCA2@KL1PR01MB5116.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <KL1PR01MB5116A253A126179473EDB7ACDCCA2@KL1PR01MB5116.apcprd01.prod.exchangelabs.com>

On Wed, Jul 29, 2026 at 06:19:19AM +0000, Jingle Wu 吳金國 wrote:
> Reduce update time by optimizing the update sequence and removing unnecessary delays.
> 
> Signed-off-by: Jingle Wu mailto:jingle.wu@emc.com.tw

Applied, thank you.

-- 
Dmitry
