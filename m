Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792445528;
	b=lIJ4Y6aycP5xag02OHPsaBOSP7WDeZZPphMkXevbpY+fv4CNJcM3se8bMf9qyUhNSiyK
	 rxHmTMeFCpNXD77+GxnklvYTZLfGjyCPahjLBgaby+9nVbn76/rBfq12dMN8Cq0rTEZC1
	 PpifVSGVTHHCXNlw66WKGTncpeNmKO6O/zQQPaLdrBjSg2RaT287m4vkHQ/y3ujNVKCia
	 FkYIWKS77gRifxb3oPXio2hC8S8/dU3+4a8IxjP9dH73H+6WNTLpyyegT8yUg7l+SA/xF
	 qt+YOVpgMCA/UoAOi2bKsZBhQvb74u9PgUSKWtOqDQsSTXKkWK/l+4q7iZrYdi5s56Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792445528;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=TuVHoTWOLcCyB9PSRvxtA5wjt2JdJw+LyuZbMuRvoqU=;
	b=w/qdsRDbyTnz62SditVJm+cIlkgEYA443DKgmKlrDeVQUoltsQAE6GlUt9uXc6YZGWX1
	 2jJt7Vc+GLTph9LMtLE+INfBRPopOBXLBu/wiGmHZ6S7ODS58FPb4h17bGnYV0b1n+50R
	 LSvlLqzx+NT6yoA7LhoL+RlkiPCs/lAGrGcdHDWwj+zO2r19ZapcB1HHcKJfdXrdEd60z
	 joA2nuOXfUPa3H3hmpr05e+Rk+hT/My3/30gpO/a35n4Z+GyEnHuAF62Kgp/hgA0rF4yK
	 KXPoqnPY+K8AdXksNvu+bmNfm46Pa6alIqfvdR/EXMhdCW1RBbxKtuQY7wgXK03VIwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sB0vLkAE;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9B7606A325
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 21:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F9B7606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sB0vLkAE
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso6290364eec.1
        for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 14:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792445527; x=1793050327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TuVHoTWOLcCyB9PSRvxtA5wjt2JdJw+LyuZbMuRvoqU=;
        b=sB0vLkAEH+wKhJ8Cxe/5ZMP162nPvlE5GdfkvBekaDyBFLX0p/o/PJGYJ3m5YN3CQQ
         rE89zT5uCaC49tspBnG8VEmCCJazzuLMfdmqU77AYNC0IN3+CRUM7ufo/V2ry+fwvyTF
         5bYx67SjVPyM5xZL9GakJ9GcWKHEH+Wkgjkj0cQN40K2z4LXR65r6ShUPPfNzzyK/A2E
         UXUmfrHJ8Hj4MLHs8sNiLM9ScEayvARU4cHzABtX2K3eULznPMq25pkjXuBjrbpNLV/M
         Mu8fYVIX14Q/24xaNeJQV6G6lp/fKKlBp/AuY3x1nx7+fezvo/wOsXPwDvxl9okBAeTK
         X4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792445527; x=1793050327;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TuVHoTWOLcCyB9PSRvxtA5wjt2JdJw+LyuZbMuRvoqU=;
        b=F8CmnnufpxbiWND7s/dQENWtwpZbwsjEOp5HoWCryd+v0M/d9+z+T8IvJRfkHyvF5C
         FQH4xNu6M3HjNBAgnO1ZZojdLfhMqT3/2mQMcsKBlffLygLhKslC+r7dqOPqc8q9pTlp
         qoCem4hIb23S5ixzNLrdKHgag9KGcSXG9XV56GGt5EgT7Kyzz6tKKot2thjjfrRhw32s
         UI5vAfUKzJSu1yL1GHeWtPzrzgCrBVDJkZdeYxz6iDbet+KjGmlylAodhsjKPAkt3xzH
         /vCf5jifx9Lo0GHA9btYvZhpjR3pemPBy3phnT/b4cykwxbyya92LPurlldpKRP2S6Qr
         XObw==
X-Forwarded-Encrypted: i=1; AKwUvByvk5i6aR/S2B0D68VldoRD2mTXMqPlfp2RDAVGRVzVbrwbTbnOhEjeYXgbi1+5cxeXF9TkrhozkpqQOw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJipnzm02qbRStgVaerndV8/ljzBlc50aDpgADAZklIGYRViia4
	C2cwMQl0VzDvFkF6b7XP8V9JKJkmfunDXfIoSSIxsmGUvMntU4LkYB+1
X-Gm-Gg: AYBFou2/dWvjXQcySw47XkUHTvrHnvaYWTyh+5RxxR4XAdNjHYbmBN0chVkKHKehqkO
	fBX5AiZKfnlZxNcogv268iIK4gLaaaRx9x8ntelaz4wkF7z2G7PKJ4VxSJqo5aVWNu/uxpgFSN/
	V4IKoWao/uyhHnMskakZMBmBdRxNNFl7nieGbh2/SPomMh24fTKjRRFs1L1nLa6xEfTABMfd7zT
	ElojBQ02NvkK7tI15lL+uArtQ4J1x00Q2NMtPyFVbd5Ld7guG6JTE7agw4uhHRehMbvb5c5hMTy
	B62SvM6Vr3wI1gjo1NWc78oh0HdkZqAmfAI8RbDQtkAh/aNfvMR8hgnw0ZGGpDHvPHPBXIxwHl+
	ebH5AvNJow2sXoETllz2LOrDSo8YmPXUPK9qggU8feixH3dt02b2bg8DzjmsVHm7W7+lISuGDVt
	wzTcIAxe5W1hCbzeemIApPvx3nT6DIG92eFGGuWLVIU9CNrTedjnT5QB5a09kNaP3XFGp1/IGMY
	IX0HeQvzfZpIqtV8c4RwPBtQVUIPB3HPAUTOx1a
X-Received: by 2002:a05:693c:87d9:20b0:365:b147:b458 with SMTP id 5a478bee46e88-365b147b492mr1344116eec.3.1792445527063;
        Mon, 19 Oct 2026 14:32:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:7c21:7991:4e59:de42])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm63920435eec.24.2026.10.19.14.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 14:32:05 -0700 (PDT)
Date: Mon, 19 Oct 2026 14:32:02 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Frank.Li@oss.nxp.com
Cc: Support Opensource <support.opensource@diasemi.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev, 
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/1] dt-bindings: input: dlg,da9062-onkey: Allow
 wakeup-source property
Message-ID: <ataMRZc7a0y6IUnG@google.com>
References: <20261012210054.2848389-1-Frank.Li@oss.nxp.com>
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
In-Reply-To: <20261012210054.2848389-1-Frank.Li@oss.nxp.com>

On Mon, Oct 12, 2026 at 05:00:53PM -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Allow wakeup-source property to fix below CHECK_DTBS warnings:
>   arch/arm/boot/dts/nxp/imx/imx6dl-emcon-avari.dtb: onkey (dlg,da9063-onkey): 'wakeup-source' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thank you.

-- 
Dmitry
