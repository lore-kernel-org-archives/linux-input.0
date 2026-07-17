Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE183C10A3
	for <linux-input@vger.kernel.org>; Fri, 17 Jul 2026 22:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784328912; cv=none; b=hQR/wGHKxvQB3D7hrXXPfH+s8vvAxI59dXVW0qpF64aX8p4hwNcAVVmIVRzYQx35fckR9droxdp3oHkQQnAyiz6RjW5atrEZzGUD1ICbDrqCpBwWuHK5jpwUr8NPPlbtQmg7W6bt0KXHuPN1bIPWsZihaQs2ujzEzG3ljv8TnU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784328912; c=relaxed/simple;
	bh=/H5NR1XjuB5PBtIh0P2j5Pkh/z/QnUQXzoBrrBBcjLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kadqL4bZv7LO/RkRxjaCLdQvSZ7CijycWnkYKjgLVqg75/Nn9oUPVNjbWsYtCTBAWt7pvmdoKAv/c7CCLigYIf9O3uPKCjzR9lXMQtxxuk4S3xvyvyKp2/uHOBRVcQyuXFOEskylDoC0SDDdNTrmgXsSDKNw4xY/kEEqRcWuFpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bb62yGSJ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bb62yGSJ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493f75f7172so63402775e9.1
        for <linux-input@vger.kernel.org>; Fri, 17 Jul 2026 15:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784328902; x=1784933702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ToPSRvPgjkr/VzS5dlOPGe6gHdaxzFfNfDhw4kgPyTc=;
        b=Bb62yGSJrIcePJvnsbDqlhY/dTOu/lR1Ir44ey9olRDzQrbaiadTNdehGbrqObAysV
         PglTJbpaQ/LN0OEXSQjhlfMQY3n3VKGgA/GjrSnmdvQDPuidRxcBcCjcXDkT8BM/pDZU
         gcrk7+qUv0JEun8H+SgFP3gqSGQ9BXDZs4GSR00FQCr6kOUYSTj8GoOc628Xfp9nXkWv
         WB8xkKW+dw4Ykc+t8maUG+WCXVeNh5bXJA/fJr7hygR/CvdpjEDDN3Vd+e9uwU8LwA12
         eD1yFbkcSsPLSl0ZWD2JwTzDJbUJqaYfSHdec8sqtRNBeXOo2kenoH/zdAAqPt+hTdZ7
         GhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784328902; x=1784933702;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ToPSRvPgjkr/VzS5dlOPGe6gHdaxzFfNfDhw4kgPyTc=;
        b=G+74GPYFxfZ2sx/HT5lJ43eq94cDGGqYN+exsKjRV8kJOFeRpEI0qVxk+3lGEhrZyM
         GKhBqiSv7f7rAqNr44LaEX+jNMDDTXJQMZMuK6y4wPnWKHT4gHcqkCwjh2cyEpC1udDw
         EtcpTdl/tonY+zA7qdYbgPNZd6XJWYDLoqluE0EWIY6+rAHdptJLIbK8Cvma8L4J74PA
         RMKgzpRizG3+zSmCuShmn9KSPJI7+62BO0FNZ2gD7P59eVGbpKRXWoNN7LgMSI48HbTe
         IeNnPqw3EC3U7cTzilLcPb/3YbUyuSvWmkllwAg+zp/9rLrBcXXH6H06zzyn/LRxX5FU
         dd+w==
X-Forwarded-Encrypted: i=1; AHgh+Rpbu7yF4Z17NHjbODdmWoAdOyA8+lISh3yPyiKlIHQMQR2qgrOxO9DZ8bf3SXt0FP1LOtw9C43oPKoahA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDi9Eyvc+oh7OX6Ylm3qUD2x0hIOaJe7RI6OkS0GIntFJDxApM
	RvbeuOVW7hYOyh7WOB4JooDSr9Px4MHy+MTUvDx7dcunD5n94S1oed86
X-Gm-Gg: AfdE7ckWOoxDLFcDeig+VO8iri74QvHdh4lWdhjkXFPQ7jjxq34lWyIDDoymXXYPCiY
	mS06/8Vgg0R/44SRTQZqRc75LK5T8SxJJVB+6jGiHQJ2XZGBOfn1JSetdp0+tzcxHC28aSeoW2a
	9asXp1O0mOznaQlDbRD6sy7GIj4460RYEJwA4AqUcXrNBJwF2AyiY76BAD9XDp7LmlN79tX03VC
	7QbmddI2GXv17WHVR7n1PwRDQpgRN27JtA1wippBBHEewRdWTL7/T+mi8rdVYeQyhrNO9R9QgQi
	NM1xEu+5QwHfRGDwWqOfFLCLitQ/7npfxM3BrkNyyJAE43gA58DBytwH4j5hZ8wPgpZatyHSIRP
	qkra2DNddVmLQ69SZDYrsgpUPNq7U2SBqTTSj19wwZMHD/i3wNcyP4E0e0yB08FjzOogHJRUsNU
	EUZsPtImTJOGLKfiHD6yl2WGJIIHr4EQKMt9Jznm9YQb/tw0SQqEfWykuV/QgVhg7WLEFo9m0Eb
	k1w4RfWHdVJiBSU2Tj/5wrM44w9kQHsrp8iKvd0eoajNhYUmTBh
X-Received: by 2002:a05:600c:3b20:b0:495:4f62:c9f5 with SMTP id 5b1f17b1804b1-4954f62ca61mr18323005e9.24.1784328901759;
        Fri, 17 Jul 2026 15:55:01 -0700 (PDT)
Received: from ?IPV6:2a05:87c3:2001:7400:47cc:69bf:39fc:49b7? ([2a05:87c3:2001:7400:47cc:69bf:39fc:49b7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2692a3sm73164955e9.0.2026.07.17.15.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 15:55:01 -0700 (PDT)
Message-ID: <41f36ffa-0f07-4237-ac30-990d7a5c1ca6@gmail.com>
Date: Fri, 17 Jul 2026 23:55:01 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] HID: corsair-void: fix out-of-bounds read in
 corsair_void_raw_event
To: Jiale Yao <yaojiale02@163.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, stuart.a.hayhurst@gmail.com
References: <20260714131611.269929-1-yaojiale02@163.com>
 <20260714131611.269929-2-yaojiale02@163.com>
Content-Language: en-GB
From: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
In-Reply-To: <20260714131611.269929-2-yaojiale02@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Looking through this, I had a couple thoughts:

  - It should send a warning for unexpected sizes, since most likely 
it's a format we haven't seen yet

  - 5 is a bit of a magic number, especially as some packets of other 
sizes pass through, but we don't do anything with them (yet?)

  - AFAIK returning 0 indicates everything was OK, when actually we 
bailed out. By convention, shouldn't this return 1 on failure?


The patch I submitted a few weeks ago handled these: 
https://lore.kernel.org/all/20260630010656.626157-3-stuart.a.hayhurst@gmail.com/


Stuart

