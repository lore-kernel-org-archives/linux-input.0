Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795370647;
	b=GZulIQysVrJ4hD51nNPnMDNfmQNY5hGEcncHTkzsBHs+3TFhzM5z/oveq9RjDGWURt2f
	 RlOP6H6LlsxuYqc5KZVWIWHiTxzdmzu1cnjL07x4E9td0knVkppe9Q/ODrBE1mnTft7P7
	 k22QJ2GuZvK0N6Slsa0q63RuVKja/AY+e11c/wzntAMPZU5NUsmZy1rCdefT01hHtjyeQ
	 xpW3dvzRwnQ0JjQwTLsIYl3/fosRrV7sXWinXypFZt4TvG2zm5DrFhNXvSmmfqEoftrFA
	 1zmdHSz0CynBoyZsY3arirjdUtV6AI25JUOrKy2mBbg84NsIgQcQ4d23mzhowZzz9cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795370647;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To;
	bh=ihpfqV09MUmYak+OSGP8+YzvL6ralFIX4WEZ4Ld4FXA=;
	b=D/lxw9Ue65MkvMtO8aYTq795K13wd/zoVUutaEkcPAh1rtrCGOomRzRvWsUVABgYqIxe
	 n5ocj70pnyqe/UYwaP2wheuCmw8a8kE0mNLVzKCN/ezlmTiDNfA8EYhG4jEZsv8WdY615
	 oS8J6QXo4fnNxyvTTQGEmLR/upV1ATDJeUASPTLWpd78zGB+T1xKQ3mXNmvdClmr6guEF
	 e2u6tjDNWzXgZZCu6FEuoKqvWPiEXi/EvV9Lw3WaRuXmNvWtXQHOKq3IzGQqCGpl9dwVL
	 JLAOfyES/yktjx0xXrjy8HMoHGIpbE1jHrKdUnCK30RmERl8D2RmFHdlT0zt30iZQ+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=suxrScFN;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FA7606A320
	for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 18:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82FA7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=suxrScFN
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso433088866b.2
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 10:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795370646; x=1795975446; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ihpfqV09MUmYak+OSGP8+YzvL6ralFIX4WEZ4Ld4FXA=;
        b=suxrScFNt663K/FCQKi1rTK40Oo7KcLgwAaOC8a6sQX0y/Btq5ghhX3bSV+bHz2gG+
         ZjQgYA4LmiWBlz2NFBDeNclDDwGblOTVPkws4xILKxoDtFtQFoW2A5YxJAHZhnrNChir
         nAPxJoZtTRyV++BtC5YC6fXTo6r0Xe/mYU00dKH7SNqghMPcUtDDRGEQz65f0V7Ptfv3
         zIcoEksb0gZr9OGQkbD/4qvEs694yA8Fb2DV7MvKk/cqY0Rp3U0exU4RuoX5MtPMbc6m
         BNiIv07Cixo8P7eFfXXBlTIxchpjtQoLF9Z9XllTxXztXLS5mSp5NpAQwslZeMix28bN
         VATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795370646; x=1795975446;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ihpfqV09MUmYak+OSGP8+YzvL6ralFIX4WEZ4Ld4FXA=;
        b=bWBNRysrvtnyhGkbXXwDFkiNibHzsFOpg/pTy0wTemuSKE4a2kvVOpA1X9df9rpWSu
         q4LtysyIEK7j5CcNG2JLA3rv0ZI0C2M9kyXpytpjG9ESMtoyDF36Cej7U1gJwVLd2/vC
         X2dHLS6L4DZCm6lcsj5jSlPRxKiACC6UpM1WJJr28DwpIE/7/g2pUewJHrtPmPARbqLy
         3vtzmrk6b4YSRGH5VyIXIYDRMPkmwYpeKR/GYGgj0ToFWFX8P3oCPTQmcxeUKufOkc/c
         BUz41Y7U3lwvEpYwljEnoBAZxpAVmSnmbUDXRd2ujO3n2nb4zoEWym70qVO9/g0AKeml
         Lk0A==
X-Gm-Message-State: APuU4Z8GVy/KY8xG3duhl9WLt1wBsXdXQebZsDnOrDdNqyP2UDRN5Yqh
	fPMo/XD4v3ablUFOx7rBxmzAkPSBCUpW4idU4zYdFhLHXliml459TrEc
X-Gm-Gg: AZFdTZdwYdQ7W4o1Mzfnrj0SyAIrEJANXO5shMnbtmJB6YXDDg9xKdCqGVXeGNElUSr
	+bz/mbQihDMFSWWvM84JRK5fy2cnocmODY0IxbiKmu+DrboByPtyQxRSc4dA52GlywEcsdzc1Q9
	cycM1X7L1Rf259a+5N9t4524MjPJiBc5QYrgx1tUgvYioIQTm1soPKc1dBqWy+oBLOOXm1+QDlK
	Q+OnGiQJM7FjygK/rareYnoiGYYdAJpCZGPMoa7S2RGeCAC1z//+h0bijoI3VP8sk7CEVrIPkq4
	Isq5IYzCvsZUFvYfC03DM2kXjyj3JC3i1IbJs+r2mLZtN4ZJTrnQxqEabqOqgE7NHK4Uhy225wd
	cdDjQGWRBIYiW+JVMV13Y/zpppd1jHCDhqTmNaI3Sbo8BACsR0/BRVGIcaMUH6d+GJrMWD3JqsD
	RWjUC9QWNSeifEsDgDWps+QsG8PqU9tL6sQAga8PRZHn4C7CSamotu1oMrLmMQDxI3IpkB/RN+d
	OtVQ6Yh2wtRo4BcQrTWDggtnceG3DXwTBkIre5XR9HxbQ2k33qVHytVHVbVPsDXL1/NF/udFPRk
	lPh8b2j5J5F9djBKi9bMYOrtR2or
X-Received: by 2002:a17:907:1187:b0:c49:903e:1e19 with SMTP id a640c23a62f3a-c513a8595d0mr591204966b.26.1795370645863;
        Sun, 22 Nov 2026 10:04:05 -0800 (PST)
Received: from localhost ([2001:1b81:1b55:aa00:48b3:8eff:fe5b:7d15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ad00232sm346383766b.12.2026.11.22.10.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 10:04:05 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 22 Nov 2026 19:04:04 +0100
Message-Id: <DN1XRZVL1VTQ.2HAQS0P1U3042@gmail.com>
Cc: <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: input: touchscreen: hynitron,cst816x:
 Reference touchscreen.yaml
From: "Oleh Kuzhylnyi" <kuzhylol@gmail.com>
To: "Gerard Marull-Paretas" <gerard@teslabs.com>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
X-Mailer: aerc 0.17.0
References: <20261122093405.70406-1-gerard@teslabs.com>
 <20261122093405.70406-2-gerard@teslabs.com>
In-Reply-To: <20261122093405.70406-2-gerard@teslabs.com>

Thank you!

Acked-by: Oleh Kuzhylnyi <kuzhylol@gmail.com>

Best regards,
Oleh Kuzhylnyi
