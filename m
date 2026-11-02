Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793592267;
	b=FUsa/KbOMFos62IOMeRL0g4rWI9ThfwFiL54RoXTbxnMXPl/w0jJ7RhjzdcjJayp+8Ps
	 QNbXwGtvYmGpX9ihUcmnO1FlbB/2yz6rhr9B7PYFI/0bxEi3yANyw2oB6a9bBTru32XPD
	 UqiGs+ydtI8JqtTVBkQcFCISQB/2Ag+d2ohr9RWXrZDFm7r2MIZrJzriBYJHcwONi3hlH
	 jv8ogrBXPCyanv7TpMBBMgTMsNFRNryKEXhgriuOKYG7OGJvRI3jw/cmt20TwT83T1OZg
	 eaYBXM8L/W3hhfqqj6EeOZDzL6LTlrU7nC2KBRMiwqQ4GsZXPf8VTOLGlkOiNHZCvKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793592267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=VoBL1fg1knaJIkUVWNPfYfv2x4Q0uTv93/Tn44/ErLk=;
	b=dUalxscGGVBWNKtjxcyKs/7bPF3xnDGKHEPQ/muPqC73tJdF7I47g83HFOb21s5I5PEO
	 qO1JxhlTJJg9NPE1GeQ1E92XsUCv33AbV8ZbpbIfs6Gw/ytIpq0l45sOc4lrSH0bZkAm2
	 WO3rCdESWKWB8fPxwguh6eEUgws31oxe5vSRrUdEJomHOUr+f6IM/EEtA2NyGqbTItsVb
	 2Pj/VvW39kUhYfgfHz6l5ZRbjcQuSEMpu8vD6TBwsTW6AXAokqBZBqxeuPqGevDrXFhaE
	 tMEmsns2V6ThUgArHITrYOZSBGat2fExhdNipUuP5J8VHSM/rUg4R6YtCqYzA4iGhqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=njgNK7Zd;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24932606A327
	for <linux-input@vger.kernel.org>; Mon,  2 Nov 2026 04:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24932606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=njgNK7Zd
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-15943c9c005so148287c88.1
        for <linux-input@vger.kernel.org>; Sun, 01 Nov 2026 20:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793592266; x=1794197066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VoBL1fg1knaJIkUVWNPfYfv2x4Q0uTv93/Tn44/ErLk=;
        b=njgNK7Zd9sPBHMbCEZOZr6eVDUWt5KBuD+VTP+s5bqmhvtslQ8ZL2sG2+HN6HyuFVC
         /+Z5tEizHBWdkrRM0OF5q5WMfZdalD9gQNPBs9DTYP+elbCql0MeR7kzaPyPDea7kuAT
         rwnGZvYRrJBI+Pc4kguE08MyRN2WT7+LTczIPZGGvlCNlpXvU1OhXizINJ5HswSnqv+d
         2u4SiKplJO46unhLgZ4QD3txxVYKeGcT3nN3r4xkqMllZmAdCYg0NEnikkTh4oJX74WH
         PzS2RMW00PUFXM6veBossspVxxZmczbNTrIwJf9qvZWkUw8Pn2s/XmyVMZsNwtZizWxV
         EJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793592266; x=1794197066;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VoBL1fg1knaJIkUVWNPfYfv2x4Q0uTv93/Tn44/ErLk=;
        b=mumI1iCMRhbQ3AAhblwxPXH99yIQ/LCLu3kMKm8hOq8rUq/YMJTqJG67+gRjpyM2aa
         9TtEuqz1mB4iCWMHXjrPxShghYIwIV6bkiWCgb6taqA5QjsUqPPSq4OFLrlpzyqrXMYv
         G6uUo4KLfGLX910IibD83nXB3OsQjT9Vv6pr6vdP40XlkL/FHq6HxqxD61ViRW2s+LNY
         xcEEqRtE4KeijiJB/y18ZK91vsKpgTCfgNr/Eb02mRRBGoRPifR87fVL2MXB/iRQ83lg
         4ePb7IxgfkNhDcea853cxqbfmm3GP8N05/YTpLTe/JpXjz5kd4HcwhR1NbY9OnIbwWU8
         EwJA==
X-Forwarded-Encrypted: i=1; AKwUvBxJ8PbeTVzXRUpXEu9CEHHl3jCidRwcbABBdEZlkgpirqzxjmsImDoukTrP/RGd1ncTkfnKJlTbD6SBYg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJvgDkuL5tBAixBeTHdVA68PDwHH9RV2EOoHV6ovDo9npFffTdH
	u9d5sEjouhlTGKgeTJHHDkoElqJtKbvxi82PiaffNpsuz3VZ2mIZttbC
X-Gm-Gg: AYBFou2gDEA1FoY9p7LdVsUegE3owYRPmlhIkYNTfrwrVUs195W8+5R8fRQ7fOFSpOm
	JTMIeIhjOeMxcQ3wGi0T17w7DcY7pORWRV6qzT2sMp0bwsGesVPSIw9GnSFQYG+8XHAqyLgCS+Y
	+dBYjCocsycAW+I3qZZCt2aFRXALnrXlsLfu8md9AxC03ls0YRnBxCEh95nvKaWt6tMbV4jpkJf
	Q3WQ9SGxnIpKQYRtcZSANqEQOL3bMXMYCgF+vg+uKjdaynQo6+sVYFFHlVb+xXycZk8bQ5ovjb0
	bxW9eM7hrh+LT0bfvC0seXa60Nig5bpmD6j4QUmOavGX6EnxxldBsr4l0WbjiBNOjBqS24SxS5P
	dbp/Ct7oMdt+DEzUVUIY5uF1zaRG1SsGdUAeoU7ruOMFZ87VQhsbwL3sf2RR0olDyqARfIzm8B6
	WaHTo0OTZovz+8jydMFc9mK0L/BGYKUHoT/pGBMgFyl/6zb/nK6VlFgNh3NblQNxc2iJ82J5pvf
	DE7OQ4+GD5juaoUgOxFVXJ8IJeqDO7Ge2FhC9oS9SM0ss33y5x6yQ2/ASX7DWXuxsDKSmKEYCpS
	mAczA8bBO3YnVQtFtddDOy5Iyb0lilkjnlQCR+wplek46gP0OCjCBjtiEixl4zPhP8CTBOg=
X-Received: by 2002:a05:7022:b043:20b0:19c:dd9b:d09e with SMTP id a92af1059eb24-1ac5cdf9b17mr14479268c88.23.1793592266054;
        Sun, 01 Nov 2026 20:04:26 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:d75c:a9d8:6c00:c5c6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1845817csm29283682c88.5.2026.11.01.20.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 20:04:25 -0800 (PST)
Date: Sun, 1 Nov 2026 20:04:22 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ryan Brue <ryanbrue.dev@gmail.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: input: mediatek,mt6779-keypad: add the
 MT8173 keypad
Message-ID: <augLnMBF7Mbw9_sL@google.com>
References: <20260915-rbrue-suez-upstreaming-mt8173-keypad-v1-1-96c325efacbe@gmail.com>
 <34cec90f-b6f7-49ec-a531-72150891dbb0@gmail.com>
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
In-Reply-To: <34cec90f-b6f7-49ec-a531-72150891dbb0@gmail.com>

Hi Ryan,

On Sun, Nov 01, 2026 at 09:24:58PM -0600, Ryan Brue wrote:
> Hi Dmitry,
> 
> Gentle ping on this one. It has an ack from Rob and reviews from Mattijr and
> AngeloGioacchino. The device tree for the Amazon Fire HD 10 (2017) that I'm
> posting for 7.5 uses it for the volume keys. The patch should apply to
> input/next with a three-way merge. I can resend it rebased if that's easier.

Applied, sorry for the delay.

-- 
Dmitry
