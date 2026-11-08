Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794111996;
	b=yKk5tjSS5urx/u0DFJse0GAiqkEAL6oLQyMEA2nXw7Szd4dUL9e4hPMuHRRMPPJusZxh
	 IRQwWtU9qiRm0PUhRCaNRB6dVt7DTov/g/bS4WxdQcHpwXhtqjHYP9JclLFh/QWI5WcKp
	 FsWx6oBF4Sd9kdLS4g/FVJUEpPFtcnVhJlwx5vIv2ehsN52fcec+dvTUAfN5PXamj9/4B
	 dFMMBh1i+TqvpUtNSPMt4vybZaM4Y5goJwyV72zeyMai5npk1XeKygbgwkh/boFAeiiAQ
	 hGYPzfvCW+wuavP3X96N1mbfW+J06kEMY176N7NIAQsiFURN5DBG27nRNwkQSPB1m/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794111996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=njyJJB6va/RqrZ7iHDzS1u9pLjUtbXjnhiE6IUdL/0g=;
	b=tglUUDhZeS0YzU1cNuoCAsoGHnrhSG/Iq0x4HHAdfb+LGmi3UhN5yb9T9k3nWg+WxoVU
	 fYbELkSD5zfE/vFDCSscVmitLP0bsckjTUWD+TsuGs6au5KxTV9nqmIhOh401I690CAVi
	 oBEz1VxPlvpPX5fiZEpu509J/K6IWv5aijy2uIbF/0IVARsQqB6N2C5YKx0i0YAI+t4Zx
	 w+SpLkBr30piQawYmrWXcHmsefdU8uHKH722+BSV9Cx7XmXx67cBCP8sqTw0XiK549wt6
	 7y7ojFCEEkxf4kiVkN/+ghB5nDwQJfs2Lc8nAndBC++d/LyjVHcERDZ8G/sHps5RfWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=grc0VMcV;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F5F606A31D
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 04:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19F5F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=grc0VMcV
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3704d30b84fso202297eec.1
        for <linux-input@vger.kernel.org>; Sat, 07 Nov 2026 20:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794111995; x=1794716795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=njyJJB6va/RqrZ7iHDzS1u9pLjUtbXjnhiE6IUdL/0g=;
        b=grc0VMcV3BVdh7jhhMbrgmrNGnHzKK6cEnqHqxstWAnN/QYUJwS5zwEhIFMRAI0sVV
         9Fw206AdgEWJmCY2ufV0R0u6UdpM0+lISrWzgFQNlb2WaGkUM7cNkA8AJN/z8TvBYw3z
         TdrCrm8TGkLzV5G8Mz74TLTag0Hd/EQAkYKqxUnmAruUUQlBX066Qe2o01oFl3XwCk8C
         vdzAiLuwiq00MBMY5TW3jDKtz9UP2u+vFWondWDSntenxoTH0trLQlea5WPFJQWZzB+6
         YYCTwJDFOxp3IRD0CMJCJ6S+55aljkGiot5N9+LY2L2GcqWCsubWXF8PXS2M+0M+Bz8n
         I1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794111995; x=1794716795;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=njyJJB6va/RqrZ7iHDzS1u9pLjUtbXjnhiE6IUdL/0g=;
        b=Vcff/fmlPWNIETml6AvXrCP02bRam/hA6HN8zq1h4cE4LN939SRzZchbB18Gz9UWTc
         nWFFIsIGN2hSfJ26mV95gYjwSeylWkiVOEnvZVqUal+3AmOuT+1UkWQQpq4KMJ+spRLF
         iG30w04lHc091UylPUCrIlAlfHkwJTRaSFvrIE9g4ghiIXX92BZkTXga+uDb96zQ+Oah
         MtZgJghy1/BqkFBNFquyXgl9TNbJ9RUeeWB/esAUPRK5/qr2ynzW5MBbFdl+f870TeVv
         fq+6NajmxUpgexsvMuGkOuFrWtGG1aO7nh1IxL+uL7lfdShBoN+yY+omBzNFYUKfxJAF
         Nahg==
X-Gm-Message-State: APuU4Z9PMlvMd+WGidP5EAItLbVnncCFBCdCNesG8MVN848wTkBxjAmw
	XXHL/xQwOEK2y2P1uu2+uYw/azMZw0F/zEIavObq4BXaQdorYFdv2XEU3iyvcQ==
X-Gm-Gg: AYBFou16DD1nBUJSyatyqJoQkLH8GNaty0N4iQDi6uzMVpHh9YIxYod4nV3+QeSdDD8
	BYwRnbgSUPUcKna2ECMOv5ceIZ/jpU5G0ByzcvssyIrwGQmrH9YrGG7DqGLYOydqs79g4OVeUbs
	sGFMwpXvJ0Q5Iz7cVcMn3R7GrRlJR7tRGkbAtdtqZLDiu40A5OT1QOOhb7ZFgNYRWgTrDEcOsbX
	PHgbM+kF4konGyxWfHLDclHOqVVy6SBIJ9AedGO5lemxTbI6n1AaW6fdqqgFazIpItERIZJELs4
	CJJ6vZfBm0v0y36x95fIfcurlyI1Vy2WcKAeUOUNdG7nULzos9xLQEDBN9hHhfLnEbfuKYzHvHP
	LrnQTyd68lXHHWlfR/S6A1QriBJ0U7g3dAaPNE69QBHXADnmj0GYtbUPdUyeVNxIzhTbw5gh55X
	WoZXYDJL1y0Al4gzG0PjVQQFCmC5DxUco9+2hUHm/22Qu5scGB2IVi4sc6OG/9Vwsdq0DRuQs31
	uQcWSe44jDX2scS0nZUsUU/59K44ZDYe9veMX0fdVM4a5d720N+xX/KXEVyfaJrVrkfqvTKY+8t
	UQSgj3Q6g4yDxgcwhdrj48hpnqntfMh4sbduyrd+IEo+2G1ajEA595aVUp7QJcsb4eWAz0rz75l
	aXC6A2w6/AHs3zQ==
X-Received: by 2002:a05:7300:79c9:b0:36c:b1a9:542 with SMTP id 5a478bee46e88-3725e04de3emr1622032eec.29.1794111995038;
        Sat, 07 Nov 2026 20:26:35 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:5a4:1cb9:242d:4f00])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37265a16c49sm2251480eec.10.2026.11.07.20.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 20:26:34 -0800 (PST)
Date: Sat, 7 Nov 2026 20:26:31 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Thorsten Blum <blum@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: amijoy - remove amijoy_phys
Message-ID: <au_59Ml4mAdZzg8a@google.com>
References: <20261107234349.382944-3-blum@kernel.org>
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
In-Reply-To: <20261107234349.382944-3-blum@kernel.org>

On Sun, Nov 08, 2026 at 12:43:47AM +0100, Thorsten Blum wrote:
> amijoy_phys has only two entries and is only used by amijoy_init().
> Select the physical path directly and remove the array.
> 
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Applied, thank you.

-- 
Dmitry
