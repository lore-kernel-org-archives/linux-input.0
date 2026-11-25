Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602177;
	b=4jplOrZMTi2EclVM54PS0zLAAA8M/K/Q7W2bZlv2xrihU636gb8bBMPPJfosULUXznj0
	 waKFYl7CRH0acXKzf5SIw9hxEz+21Uacje6I6LE2u32BWcOKeu8CPYplybNilGW6vtUEw
	 4vCLG3/FsN3lx3MPeiAAJTXdJpPMPw8LT/EYTvYd2S7xBeIHsLuy2S0Vg/QwU3y2IfzXL
	 86HUbt5p0vvmaEguYOIHP3sG1vuv2G20Uu4TzuFoVbCGVon94Y/hAiGmuQIs9ljcHiM6+
	 03YpKm2YjxcUHcH97GMW4p3EjLHiwv42u0nSaN6Mp4MDMSPJlGUYR96Tg350LKDybdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602177;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:From:To:Cc:Subject:In-Reply-To:References;
	bh=fK3tKISj3R25ArhBdy5LM7VopeCl3BiNHMyMArgUl0M=;
	b=TNI1CbzzCKSe/lvzqyUgoiBXRkQUSvG9PP25xYBT4d3aB7zsyN55gqM6v0NMEZSVdQ15
	 RyKZbcJQWTOu4Jf+W77Ld7+r5dzmMLtrhpL2NfKz6g9+CgTDSa7BIT/xkTuljYS2vRuSH
	 Jffh47WWxjDIzrUhIFKFWZG2IIvlIUDuTC+J5k0jaAwr4Ly32vrJEE+2FJmZEac7X3q/C
	 k9zIDdRE8hg40G0vT5+KtzhsGOHnzACKjxHu9TX8N9p7MPitB4mF07VuwsNjEDHH12jx9
	 enDRsn8hEeOFMPaxbXOxJpU6N7ZHqLPFKvAyg7dddPTpEzeJfbcChh5IEfIdbatGU1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=B8GNBCfk;
	arc=none smtp.remote-ip=162.62.57.49
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3B4606A31E;
	Wed, 25 Nov 2026 10:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A3B4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=B8GNBCfk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795602165; bh=fK3tKISj3R25ArhBdy5LM7VopeCl3BiNHMyMArgUl0M=;
	h=From:To:Cc:Subject:In-Reply-To:References;
	b=B8GNBCfkblKhl6TOcGp2hDi3EssDZrsTX2bduAyTKpPg0lcVBo9MBZprXP3FlzNpq
	 AMZyZ7NaqyHuKEI0RDaj86yvfj3L0zmf+iUrVSmM+jeA9MCDjvisvE3q3kN0bUo08q
	 T43teeGb1jcbdtqbXmevmMZpsbVnXTpIhPBBDJNU=
Received: from [172.20.10.2] ([240e:47e:32f9:92c3:8064:1335:aef9:f3d1])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 5ABBA6A3; Wed, 25 Nov 2026 18:22:43 +0800
X-QQ-mid: xmsmtpt1795602163ty7ddubw1
Message-ID: <tencent_B5ED38EF87A715D7F71A61C813EBEF0F6A06@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+ZKVBiD/neVVJOZQa17843ytV7XWf3iVWxCttgHZToC973ei0aS
	 NYtd4s6YAMYBD62XlclZSXyjRchRuTnUUneAF0RajY2nCnW/Cpp2hTtqbQbA5ZvY9hJNHWwuCNCg
	 lHjmjM5EeMAiMMPAvZTJ2WwFEiELRPaHOgfZYxnHgyrc87pbE5Bs/4rhDLMDM3dqKeGzmHVNt7pL
	 JWzZUDfxa51ROrart2e5RvkJ0PtKzMz28TVd35ZtWcz5LPgTDrf7N5q8m/9AfoAI72KcOjTsVBAI
	 QUjbYBBn0wB1TkaZ7g9CvAEpJJhKyift32J3ada0n/pMXfgj2uL9HPULjqmcjFj8jij88jxdjjRT
	 4p//xo2Z3U+tpCVJyMSPySjV9TPbiWybqjZM86P7bPvoGDviGf6seaJ80pNxdzOxRA8PibBmkQGu
	 qhSKuj4XaglaOvfovsGxXVIqkDaVIy0Pr9eTCwCHYEVMmrnxZXcwYD9sdRm4JQexxwqw1zRhEr1V
	 bOPgINHoCDV/gODr+vzGeD7k/T3b/oeqnXtRatqNJmFp0EeFe2MEhu4++d3xL5/bk6g5u2moF94p
	 4DuvE0fXhz5fXPw0siaEKOSvar0OlnV1MDOVW+zRM65Td1PO8bJXvyudesF+hXRUL/M4c+tvRyn4
	 bmJ6CMQ9uqZZAGVd6ZawQBj6u8G6S70CG2f+yeyKg6QG8VeXmcpNPsOYWFH46YtnJfLvmJ94Otm1
	 7lQvwhHad23gG+6duAY4WX3/u7x7ZfZCWOquwcMOrMB6xv37nUrVo+J8PWP26YBtyAQmFEpwqVqd
	 O5/7AiM4qKShjY063FPDWoKqBBjrNpi5mRcGIbaXnU/dmNPciyvY+rooaQ0RU7kviZtJLf7OAIKh
	 hsCp+d6UI0MgoMxscm9y4BdRTgL4euxrAoog7FnKXyDdEAKVaQc58bpVhyOHePWB8jQGGBptlRq6
	 kGuxSd7E3CoNaspI3nRRXxX9ug29b5BuhDi+u9fNJA+fNmvUOP5/SLuNCb6egdGT9jgGWI8P7zOd
	 BPCBYw4lY2mTW66yFk8KlsghIc1jogeuLARQKv4hhGa3yR/rGbdDupHriHM6tdFTNmLCQbvTLygL
	 Wj/kAn
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Hefei <3066883572@qq.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: display: add VIEWE JD9365TX panel binding
In-Reply-To: <179559080931.9063.6197450233674722560.b4-reply@b4>
References: <179559080931.9063.6197450233674722560.b4-reply@b4>

SGkgS3J6eXN6dG9mLAoKVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suIEkgcmFuIGNoZWNrcGF0Y2gg
YW5kIGNoZWNrcGF0Y2ggLS1zdHJpY3QgYW5kCmFkZHJlc3NlZCB0aGUgcmVwb3J0ZWQgaXNzdWVz
LiBQbGVhc2Ugc2VlIFBBVENIIHY2IG9mIHRoaXMgc2VyaWVzCihNZXNzYWdlLUlEOiA8MjAyNjEx
MjUxMDIxMzAuMjU2LTEtMzA2Njg4MzU3MkBxcS5jb20+KS4KClNvcnJ5IGZvciB0aGUgbm9pc2Ug
b24gdGhlIGVhcmxpZXIgcmV2aXNpb25zLgoKQmVzdCByZWdhcmRzLApIZWZlaQo=

