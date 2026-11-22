Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795340049;
	b=Z3Bwg/TK8eODMpJJTTRF9iGbP9y98yNdS17vPA3CK7FhTffN9NpQckr0IIqLS5IE6YmP
	 JJEZwPwKTIrvLdMyRpSJ3tI/AlSgNaYOkD2G8s8DRJiGKy80TgmUu+sO0tcuOe0Fk++aA
	 vadY5rGlXUlPgJs2i9JuIS7e0EHnC2QMoA6hQwRTTX99iSGZsCnS6UpyBp5Et/jWwsBAV
	 JavJSvkC3zusJ+RseNlcv2gsVvlDiixL0lxTlFGIPi2LHogS1bOG4HAvcW7Qoq4LWFlnM
	 E7ejxYqwx6JItCaOS0S9R4+LXTZ2l4yL+PF5lrClcv7zQ5BRyGgFRJTYp798f3Umgwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795340049;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=MuQqDS4gHRiIDL/AerQd8OJ/xrrO8MJ2dvAzRmjTLio=;
	b=22qyIBdwM5N3syJHU9+4d4GhxRLMqsaOgvPWEUuwVbWo32xU0zUbhu9ER5TxxpyCYvnV
	 Zpm1jDVMmE6jZdRRDPuJCjfKV75cY9p16C+8clMAK4lBasgGJt+KkKeDdjjEw8LGZ9LAH
	 yvLLvj+lknvOaITgQ7tHsIsEzVVrtm0UGxNAcDDeKUQpdWal+ndYVO77YIzQ87AewCkQ6
	 QSOQuKcfEuWRrae2sCsXuOiAm1WFktalz6NwGI8eMYBOgeGavFXBzyAdoBx5SA5i1oG9x
	 unAQzM1UyKYRKO6TkJiUl0wEE1Nsa/xDpXREI3WJUu2LxxNaLh2NSXjCUyKzM9I1MGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=teslabs.com;
	spf=fail smtp.mailfrom=teslabs.com;
	dkim=pass header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="fVlBys2/";
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3A1606A32C
	for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 09:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA3A1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=teslabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=teslabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fVlBys2/
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so1837180f8f.0
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 01:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teslabs-com.20260707.gappssmtp.com; s=20260707; t=1795340047; x=1795944847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MuQqDS4gHRiIDL/AerQd8OJ/xrrO8MJ2dvAzRmjTLio=;
        b=fVlBys2/1b9RonUCt+ctCL0AFnUAaSbp9xup9SH4y05xeewwNLJoQLtaq/JM9aGvwz
         YCcWWAp9kfarcxdpWfXqnOpooDVodnj1eziNgUNi+lM4W5MBj3FAPFGUBrKZcyfDfL6/
         EnA3JZ2yejNWEfuFd5F3DzH+lFPxlNEsNRhH5LCnwGUDMcFrIT9ychQLz034ThQhkFNM
         /q1BRTa9tVHwKWhAFF0GqEqrpf3V4p2EVyIm2LtQ0a//FIbsVqXyepMGJ8lsPt+AbN17
         wfnmGO5YuH/3OJ6DE3xxCoHk4GNdtN3xycReOflY9h5OD+OyR93DHh0SaVKgTR1YIMit
         ziIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795340047; x=1795944847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MuQqDS4gHRiIDL/AerQd8OJ/xrrO8MJ2dvAzRmjTLio=;
        b=kI4SyLgNSCsGzxRbghQ6rWSM7bsrhXGiLND/c26tbAQFW4RckeS556LS8ZfPTvdASj
         KySI8b8cJW/68XcM6ucnoiG7rA/fWwmGpTnpuMfWS9shcYbYsMyYXeVXSdGX5XPSPXuf
         XhUAxFvnl+ttZIoryl7ZBclp16lz09EitVloMsalp6g0swoZiG6gLhHlim/ynDmnxq0G
         FcxxEzqmvVvu03TIGFZtr0czjHkl0xA3RSXnsmGtEkyQCqt7mdhFrbBFTPiWTqCQAIjx
         5cDxDVM059sksxhjwwK4Pdn0xUoRyrPGqap92F6KVhQsXM7Rsonrv6hzR8f2CvQiUnFz
         WTbg==
X-Gm-Message-State: APuU4Z/fPsKSa4jgH/t7zVnZNgrcSMipab7ziUnpqK2ZUuTBtx8tmyeM
	puSTl3gkPw1QBKnWGDQowTv8m/vSx69vSeAPlIo20r2jdJCAReMN9BYeFxG21A8BbWeKLsl98tp
	lSbWJbvDcEe9N
X-Gm-Gg: AZFdTZe3GhHSKp5ueCjfuQp7UxprRK6eBEYZyx7jpmfpQPMdc1XungVACyW/TP0DWQn
	74VIAqj/7DVyAT24AWm+Yha5jMZJgqG5kbMG8y+eXdfJq0v8txmNdSxGG2dTLtWemz11E8vyOAe
	86vR4NkWFGxCc56MHe8xshlr4liS8NzFrrocs2VuUbl8T+9jHLLweGW8vwPMVqfd9yuljAwjsCB
	tC0/VEwmKNtgOTHr5A2/cCRCKJllaXpvoh2ji8iaXTy2DqN9Q69aKRWZx7vMzR6sOEi+W1zzoge
	4c1equ27GL3KsyXIFNXmZjZY04ZIuUmm2cR2NA95ti9n/xH4yY+6LZCmHh0kZlv34GE7HuNKugQ
	5Q4qaUkoSju1NBpE61BUW6OEHcwXmHJq6aIWuRD0vDIGb8Gc6zghfDPhrphGeZKDRQhN1j/86tK
	c5Rqw/CVBYXGEaPt+vCoAT9Ao+VQ1HTJuGr3L2fZvxuSxCvNTz60BJoLV711VWCedEnfNT9SJoX
	5IvIzO7+lqAafF2+d9kVSRZPuWhVp1umXzXGd3VmCP4BReYKvuZr/h8ZTEyqIQC7/D4CFsWxww5
	ROj5kWpcQaV3yH1vI0oh9jFvWU3cBkOAcz62fP3wl05JO8wpQR+8Q3qLPSF7uJzgHT3QwftlrqJ
	lGqdDYg9UTfI7COcjW+LDzNFQOb2zsT6s
X-Received: by 2002:a05:6000:46c7:b0:49d:7e8c:e8ad with SMTP id ffacd0b85a97d-4abb272758amr11104935f8f.35.1795340046997;
        Sun, 22 Nov 2026 01:34:06 -0800 (PST)
Received: from localhost.localdomain ([139.47.121.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4b1ed8b6a05sm1552848f8f.43.2026.11.22.01.34.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 01:34:06 -0800 (PST)
From: Gerard Marull-Paretas <gerard@teslabs.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleh Kuzhylnyi <kuzhylol@gmail.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 0/2] dt-bindings: input: touchscreen: hynitron,cst816x: Common properties and supply
Date: Sun, 22 Nov 2026 10:34:03 +0100
Message-ID: <20261122093405.70406-1-gerard@teslabs.com>
X-Mailer: git-send-email 2.45.2
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CST816x binding allows no properties besides the controller's
resources and gesture keycodes. Boards also need to describe the
coordinate range and orientation of the panel the controller is fitted
to, and its supply, which is often switched along with the display.

Patch 1 references the common touchscreen schema, patch 2 documents the
supply.

Gerard Marull-Paretas (2):
  dt-bindings: input: touchscreen: hynitron,cst816x: Reference
    touchscreen.yaml
  dt-bindings: input: touchscreen: hynitron,cst816x: Add supply

 .../bindings/input/touchscreen/hynitron,cst816x.yaml  | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)


base-commit: c44104f3642da720164042623e4832836aefdd8e
-- 
2.45.2

