Received: from mail-ej2-f26.google.com (mail-ej2-f26.google.com [74.125.228.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F03471CE8
	for <linux-input@vger.kernel.org>; Sun, 20 Sep 2026 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789939458; cv=none; b=B7fv2/OYd6OqlcwpCPX1LdgfHHuEHfhLaPO/I8I3wNsK9SPSdfmV4eNcJA+roYRs9llQc7HbxbIwI2jyAnJkhn6Nl3Tt9Y0A4vaovvIZfs/crreWFe5rPcdxNHNSn/HC1odLA/1+Wo285M2l+q8RF/w3CjfmZs4a9/bXSVlAeyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789939458; c=relaxed/simple;
	bh=HAe9drQ2Ce/111VV1trP80s5SonnyEnE61XjrLoR3uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Do6Cph5/vr9jsa2QgNNekiQOgesa4fN93+J027Ua91RAV8TTkPrEc4GtuyGLfyYkIWJut5drnIwyw4lisnYhqRNkkcIT1JLarYUuqHRJc4FH0rJoEWDdHZ/Ys71j6RLGErQ3zvH3g6YB6lAc1Xb6cp4HehWDk8tVP75IBt046k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUKtGDAT; arc=none smtp.client-ip=74.125.228.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUKtGDAT"
Received: by mail-ej2-f26.google.com with SMTP id a640c23a62f3a-c2940ef15d3so289122966b.2
        for <linux-input@vger.kernel.org>; Sun, 20 Sep 2026 14:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789939454; x=1790544254; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IPZKEOuc6OoXrjfYUnhc3ULWdAsyQzK6Afr3Z+Jdqrg=;
        b=nUKtGDAT8f5U9JJObFbWM2DeBIroGKhiACb2Kzu0KV2ctY0c+Mcu3ImH9atjE22uL+
         kH0M9AcgL0XO+65sHr77ezMo6+AEhvxaGTwBJRBC9EcJBqquFJd1am1oNwvFj3O1SzGD
         8+4gOLoG3TE+YvUEMoI4/9AJ9JONf5MEhK3OfwXBpbvFQXDG2MR/tlNRu/P7YEyM9Btw
         ZT5eZ3iNpEEtF2/Af45zzVdau02iBrjZuJiyc/56gsfr2S3meGXvYjFo+/5rPO/zmNaH
         1ihdWPXGlx+aiA5rXxkcywPLDsPyz5q2GrOt5MlUq21euNDD+BcmHmjb7nEX0U7ndoTi
         GLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789939454; x=1790544254;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IPZKEOuc6OoXrjfYUnhc3ULWdAsyQzK6Afr3Z+Jdqrg=;
        b=gI890NX10b7OQgEfuz2sHKNihlKazTTy+Y1QLZjMdTE33psOTt+/q1DbGYWDallmwp
         4si+m8yrJ1kEcJqDiwe+QbVFHroMjhmVchB3gBHCRqNKdd/IxnDBPNSHkjN3F8icSnKg
         RDDiQyVUn/qtO8/q32/tHOmLzlLZ5iNi0hN8eA2OK/d4RkO80yVjA6vAxX6XoL/FtDrg
         ukOf1RE/A0L0eZ9mOQ45z+kyxTCdiGaLyq5w4cTJM03kx4Itr6Cvp7R9PD6yXY5ksX22
         cKJr+SrFS6PNntw8p4DDcFMPUwnuX0PqucD0f4QzNkU/IOwAo4iDwNtS9n1lEukYGioI
         QuAg==
X-Forwarded-Encrypted: i=1; AKwUvBxM9l0Jtdz5Tp2x/TEq1JLi+LD80IlZkznSgVNJhG8BujH3jOUr0pDW1RSfNiJU+gKIAvomQPqF6Ue0OQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kxkv/UNbP4gNT4909wsABdjnY3aBbP4NrPxZgZxKZsFtoxkzUE
	P21zjeVubgIeIvZY27U0dm0YtRf2gQp44RhLYENlhe7yTSTVZ0s67NE0
X-Gm-Gg: AYBFou1sTzGj1LbSz/ICBRg9CQ+ebQwviw6mSYfZXmmuUE4+Wik0XK/ZAS8taRJmJXI
	F2D/sV4bmfyO8MU4M0NQDc2rLjH5IOQ2dUWulNetBvY0A0AANxAIR6jLFaJCaBskpPMJVRuMppc
	UqNj6bFiotOck5GjrIJfiQbpy8KxkmKQ23ETneH/WQN6cmK+ptEdJC1KLCtnKCXuTRQ3aHt3s5f
	w2Ef1dozj7hOznmLSLGK0fUtOUcZ3sWaBlytAT55MFllo7udBE9zJZGwz3i3Ga6uXjMqBTXWj7V
	YmAVnMshGadlRvBOCda+vJSSUJN0tcgHst25fI2eQ/aa+jWV1rvNA0brwiBgscW5zNMKPiZoN6V
	fiZNjhnPu1CiDmJn9nI6jCpaO/hzeMBxKi8GxOTpSqMCDiSRWIWRrTydJ3Jl7PvfdaTsNM9B7tj
	1zgty1giogDh71HZhSbIjry2O/4/36gko8Q6rdamgwn8cycgZDIeFnq2rynAI15NfmMF7aT629O
	1SiDmCbIsudkmTG2VS5XQ9CHYcCVVm6Bg3v3RCaHwk=
X-Received: by 2002:a17:907:a88e:b0:c29:f5d5:5aa2 with SMTP id a640c23a62f3a-c2a159a99e5mr731499966b.44.1789939454246;
        Sun, 20 Sep 2026 14:24:14 -0700 (PDT)
Received: from [192.168.86.89] (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a3590afccsm219473766b.62.2026.09.20.14.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2026 14:24:12 -0700 (PDT)
Message-ID: <9318fed0-31c0-4991-9f57-a1cabeeebcd9@gmail.com>
Date: Sun, 20 Sep 2026 23:24:10 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION 7.3-rc1] HID: logitech-hidpp: hi-res scroll mode
 forcibly re-enabled on every reconnect for Bolt devices, overriding userspace
To: Roman Stingler <roman.stingler@gmail.com>,
 Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Filipe Lains <lains@riseup.net>, Bastien Nocera <hadess@hadess.net>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
References: <20260920094508.39682-1-roman.stingler@gmail.com>
 <arAe2iRkYh9p98Rf@eggarch> <20260920205058.11958-1-roman.stingler@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Erik_H=C3=A5kansson?= <erikhakan@gmail.com>
In-Reply-To: <20260920205058.11958-1-roman.stingler@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

> Possibly related
> ================
> 
> On this same Bolt topology the wheel also scrolls far too far per detent,
> apparently because hid-logitech-dj does not forward the hi-res wheel reports
> to hid-logitech-hidpp, so the multiplier-15 steps reach userspace unscaled.
> There is an out-of-tree DKMS workaround for exactly this WPID:
> 
>   https://github.com/Magnetar-OS/logitech-bolt-hidpp-dkms
> 
> I am reporting only the mode-reset problem here, but the two look like
> neighbouring consequences of the same commit and may be worth considering
> together.

There are two different patches that aim to solve this, but it looks like the
dkms fix is a bit more robust.
https://lore.kernel.org/linux-input/20260901-bolt-scroll-fix-v1-1-58bca7ae487f@protonmail.com/
https://lore.kernel.org/linux-input/20260904034843.1340846-1-rafael@rcpassos.me/

I think the best approach would probably be to apply Rafael's patch and see
if there's anything from the dkms patches that's worth including too.

Regards,
Erik

