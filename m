Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794291237;
	b=QqCpiboRxri1jdnTnWuKz1yGQg7Ids6P8oWvJoz2VB9bgIaWWpWa1UcN740NMAa1oezb
	 IxA0XOwacYM/7uoiQDY0XfoRrz85PsYQMyhpgjMpuANIHcYAo/+CSskPemTt+RfFLxuf0
	 H9j/wjPdULkfU2/ya/QZ4FErlm3Gnurp/jpUa/S7eXDPvfG1w1P5N2v4+A4Ip7h1Zl3LU
	 em+KhicoML/sJS2dUyuVePRWkX1X/bOm72P1u8pJLhGybVSnjOBj+/qTPA+j/CH0bfwCl
	 ggR8e3ph42LNG6TnQnZ0dHzduTC7gy9nLbctEZ2GUzw8eruc1fFwTFavdcDwchcUG+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794291237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:Date:Message-Id:
	 To:Cc:In-Reply-To:References:X-Mailer;
	bh=CKmiWAIPJ5ecsAdCtmUhDOFxTZUdFDSXgzTc1zGfnFk=;
	b=zWAPSQrcCdUR5CE8hW7ef+16mVVcFea3LjfRX8M9nyj3hi/WY0Sxwqz+3YI04Bp0nekp
	 DMlbiMQgGbKRtWY3QmnbeIH5gbsphxB11bFPt/AJ0ROFh5QLgU9d3hGy5L1dKv7wtsFuY
	 cTorTjd0sDwAgi7NID1EA+P1oKS/cWgOEfu8Cbedqe8wu14dtiub6xcR3aI+EgGdclICC
	 hWcj/kzLjrGfx7A0ytlRFdYiqeWlKhv5uFbw6JUZDQmpx86TxQ4wpma2hgrvbUMmUXexc
	 dSymLeY2YOOQDgAH5m+f/p3DAHzY8dkBVMETcpH5dCLavwG7sq0DlupSSmhGnw4bmRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vchUYvl6;
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7599E606A31C
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 06:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7599E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vchUYvl6
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3ae93a86008so985764a91.0
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 22:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794291237; x=1794896037; darn=vger.kernel.org;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CKmiWAIPJ5ecsAdCtmUhDOFxTZUdFDSXgzTc1zGfnFk=;
        b=vchUYvl6AlTS7wM1EznmJY+nfZxWtdq8+R7SZ9UXj8vNyftztxmm+I58IVqkP1vvME
         0FdPO3a/lzcisHOL2xs6Kc+jBflC/sDg23X7Q5f45m89reQE5Hxa8DqvqGQmxAR5WJ2T
         FfGymah8pyoPXWzTVSIQmwkwO0RDjaXaW0jxzcqmpxfchUey3uej74ejHeVNFk+XVlLN
         8k4BJlZO+nrd5q2g0unGJaSWwTweUJ3LBnELBnscuNyIko6hfiMAeosKhTVy1QX5IuMb
         cJ8eLefvUbqk7R7YWIwoXNxS/ceckQ0td+Sl67TB2HSebFx3arRE/Ox/q4ZNUSnhTNte
         D8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794291237; x=1794896037;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CKmiWAIPJ5ecsAdCtmUhDOFxTZUdFDSXgzTc1zGfnFk=;
        b=BLfZ+HBRWgjJV0rcLte/yPX1gEf9mblH6w823BODHh9dhyKZzQG4aljX7aP6txS6Tw
         yYYAp5t0eEDvGcIsBy5Xp2Tt3h6WWmoai8RXkeGA1SJMhGbPx/Xi/JThqgMRWnZ+8Et4
         MiMExMW+bxq9qYUFr+hO7+c3RXSb02f7EZAZGcPHCFq9KbNUZAybdWhdjBflaCXfaggg
         R9TOA6C/VvHCmjngovdlIQ5w3q2oJDdY2lVUVf+46oslrOet8hFozR3UaqBMxLavowFq
         0FFNB1Ybi6zzKjYRvGwFMfjHTvyfuyAR+0WhtzBr1eWHdASPsBQBTpIHE4hEAyH7QByf
         zW1Q==
X-Gm-Message-State: APuU4Z+iuGxpsofc0Zf22qkQ7Eh4RnniwVUvodFkJXXBXdP/X7ur+oRx
	bEwP6XKdvHPRyEl8ybFAEkywBQOKiK6Ym45DnQVwn1yXfkQkls2JdPqp
X-Gm-Gg: AYBFou3Dy1/TNYkLx4Pc28vXDOdUcq+mFyBlKwPnxtNX/zAK4IUfT/Xgu3lu2sw0717
	LRpjgooiGCBuOxRv4pX1n0DExmHzs5mtHG5enGY7Gfsh5jgFFbxB8wUxH5AepW9V5G8jJTau8Kh
	fLjRMhOP9AkGEWPDB988k1d1jv2BxiljTaV5gkc2SHypx190oIwyjQmgRQyZsnPccqxS5eejbB5
	IdvGTLcdo+v9mAQtuwk5M0v7hgKTvp3reYDVCGClUzjICtgugIuVAwUqwNisZ3kQFQ+wW/vStq0
	ud9qYt6UaWpvHOEY+JAsQVSL6gaAEzDr/ixUvrKNh3qhtTvzPYwA9mfEEdcI2/lMLNBtDurKzUs
	VIf2mkzxL4loD0x+qq9PZrSCQFZNif3oeEmiUV6BDxVmEe4EWnmPsV/2l2zZEi2gmw5b+WSw4lk
	VwD7K71AI9GurFqhgBYMdRuna/CplKKHruS2NqioSpyYvCfseFn+gsZ6DUd30+DqAXkFvdOf65/
	7M/h+7/8/2pWchqperrFZ76aSiBXm4T6zZslxzr7rsAKg/WM9itIoVCj6UR1R5s/PeBb4rSmUI+
	Xm7m3Ja+NHJ9zpOvh1CHsj5unB4IDm1vIryK3OQeG09uWmwofNQykCdCeaB27pEGApJKiyCdTwg
	P0YNls1QbIQNdsac0sAoYVj3oDuI2PEDJ
X-Received: by 2002:a17:90b:3c86:b0:3b0:ae41:2706 with SMTP id 98e67ed59e1d1-3b166cb9b6dmr1857937a91.4.1794291236670;
        Mon, 09 Nov 2026 22:13:56 -0800 (PST)
Received: from [100.64.227.9] (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b166f542edsm2510720a91.0.2026.11.09.22.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 22:13:56 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: HID: picolcd: maintainer address in MAINTAINERS is bouncing
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 10 Nov 2026 17:11:54 +1100
Message-Id: <179429111488.2.10039575148973146335.b4-reply@b4>
To: jikos@kernel.org, bentiss@kernel.org
Cc: linux-input@vger.kernel.org
In-Reply-To: <CANOyQmHU_aynnHxDwiGPp_jRBB+ZEK_stZGfix-7=kRx67a6-Q@mail.gmail.com>
References: <CANOyQmH4EU=6kb+d2ELL68FLj8yvtq8McHtUMWthQ3WUJQTuWQ@mail.gmail.com>
 <CANOyQmHU_aynnHxDwiGPp_jRBB+ZEK_stZGfix-7=kRx67a6-Q@mail.gmail.com>
X-Mailer: b4 0.16.0

Hi Jiri, Benjamin,

On Thu, 29 Oct 2026 06:07:09 -0700 Aveline Noir wrote:

> Is there an updated contact address for Bruno, or should
> the MAINTAINERS entry be updated?
>
> I'd also be happy to help with PicoLCD maintenance if needed.

Just following up on this. Have you had a chance to look into
Bruno's contact address and the PicoLCD maintainer entry?

Thanks,
Aveline Noir
