Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0233128AB
	for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 20:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781470778; cv=none; b=Z/nvB2uiGUR9eETZyvYwWecn6WXt/dtuMtDJGuLApvNlbR8k+FVYCBSYh8tQcRw1stKqsIL5H9bcrl5Cs0gYCseGdAFY4QGOniQazwL3JAox58FxhPthniMPuRyDE4FfRjLgbPBaM19U11QkPJk5OzWXNgguGhFuVdXuDuI7XpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781470778; c=relaxed/simple;
	bh=sNFbsCJeOPwaKXPQsEzBaBiGJ/DYOlHjGmLRUzVAt0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zw6TwEEZefuRexL/3mYT2v4CjvYNQ4mU0Bb7PXgoRFRVlfghH9T2lC/BEgHDRj+n/eKO1zIB02lF1afApgEWMla7VgmW8eMOSqKGgiV5y46YpMfSEw5BhZLHF6DrxQzuZ44I7NuHKCV4g19HL8zQ8hU0KhHMYRP5K6gfxSFoId0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+U25mLD; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+U25mLD"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3042a388168so1971274eec.1
        for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 13:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781470775; x=1782075575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E7BZf0PcZi/GMW4QTHsLeXW1vcBsvCPvj3Zq/xHb3eg=;
        b=A+U25mLDMx0jIRZXj/5J5pxOkLYgHZSxQXw+CVZ6DyOH5kCenglMf6LTP7AeTixUIW
         WKYn+bodA7mEBWicO78zHykg/VTtRwfL41OryeTungKyNj4zHaBsL3xuv6wiQEiOk9X6
         8pROQPM83R0y3O0sipyx9bdlCPUnGukDdvxGkp6VqaRKaWfLOjw75NDguHDQw6CbmvoN
         nB1WPzMJ5V2A946XnMYbA5X2MVH73wd+UWvhmshmryPnrYTJYT5nYPBlX0wDNcrSR80i
         tec4shkjLzwl6T5f92qNB9PDbpsVKJ65lEtdun1ZL6sKKlldBPW0t45/GXc7JZ7xt3/D
         JFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781470775; x=1782075575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7BZf0PcZi/GMW4QTHsLeXW1vcBsvCPvj3Zq/xHb3eg=;
        b=V7p68iec2ItVgG/YLB7FtBB8nSgnUVQj38FDVBOp8H6tAW7qWgQQXFnSCLzyW/XKkq
         DTDVgwMxM+nN9AEGYELUQtCx+Wu6i5NAYwGgS9/zMc1PCn1Xvsly1HslBryo0zDmBon2
         pm6/dnIxD2D1NRCh8DM1fLw2V9wLJ+hsp5Yv1TvtOxCheEMeC45Zdy+vkkr1b9q6ogVw
         U9bjlw/2JqC57maq+kv7LbsqzHHeZbrDVe3EtoMzEIxKcKff1uqMBb4wnF1dHBcLsuJU
         yjmJud1FQ3iLK97GcCxXogBqXPgI62MVfg+bGGjob956O9hCjIzmEFGu20+ociHAQG5j
         k5LQ==
X-Gm-Message-State: AOJu0YyUsAFgphUKbqDOf6WVJ8cke8Pl5xQ702z86XuctAcA4Gpg3lMb
	ByJJrs2B/zLde21FVmkiCdQL9B8geJXf8WuGE6rzBaLvBBRFTaa/e+db
X-Gm-Gg: Acq92OHU1sB392b1SJ6f8wCvye+WccgcC/uOzEjeYC9Oa31Ob+n+nEsti/g0tHf+LrG
	B5pIG8s+Fu7186bP7CXF+xiX2PkyV8zIXzI4Gz7s9gSnGx01dGEDuJghZuTKahc4oxrzfk9EvLs
	OdE0jn3kW6PDdMLyfxV0NQd+zRpB5skvNWmWbXDD+U3YN1mNmINLnQVzoDWXIwWXPbbqozStuhZ
	i4mcqTlNQ/40ywyjyJVf7Fo/gU3G0Y4HsSo66hvdYAL+ujdVzg+PzvVNY+O/Tcjho+u594k8bcI
	AXjVuEFBm3IG3hLOcj/YfFXZ9drhSm1I0fWyTnVza1+B1q1Dd1lJiwXxUYoK1X2vbf+MAEGjpBC
	tCuabLPz2iQXmVuetmkM97kTLWqO0LlFQgr7RxyIP39Cv7fOUZyEyVGJlWq21g0DzO1V+DqY9z4
	8sw63dWh+FEjcUGle2Yvqb9QktJFSJZZdXjLoP4VHa7X2BOsBemv/oppUAESW2cs3I9LbY1snzC
	F4=
X-Received: by 2002:a05:7301:e103:b0:307:91f5:9522 with SMTP id 5a478bee46e88-3081de03505mr3904694eec.4.1781470775486;
        Sun, 14 Jun 2026 13:59:35 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:5d91:5c26:602d:6a99])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea4f7a0sm11104337eec.24.2026.06.14.13.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 13:59:34 -0700 (PDT)
Date: Sun, 14 Jun 2026 13:59:32 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: hexlabsecurity@proton.me
Cc: linux-input@vger.kernel.org, Rick Koch <n1gp@hotmail.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: touchwin - reset the packet index on every
 complete packet
Message-ID: <ai8WLJQsQda3r4eI@google.com>
References: <20260613-b4-disp-69921bfd-v1-1-82c036899959@proton.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613-b4-disp-69921bfd-v1-1-82c036899959@proton.me>

On Sat, Jun 13, 2026 at 08:07:20PM -0500, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> tw_interrupt() accumulates each non-zero serial byte into a fixed
> three-byte buffer with a running index that is only reset once a full
> packet has been received *and* the device's two Y bytes agree:
> 
> 	tw->data[tw->idx++] = data;
> 	if (tw->idx == TW_LENGTH && tw->data[1] == tw->data[2]) {
> 		...
> 		tw->idx = 0;
> 	}
> 
> The reset is gated on tw->data[1] == tw->data[2], a value the device
> controls.  A malicious, malfunctioning or counterfeit Touchwindow
> peripheral can stream non-zero bytes whose 2nd and 3rd bytes differ: the
> index reaches TW_LENGTH without the equality holding, is never reset, and
> keeps growing, so tw->data[tw->idx++] walks off the end of the three-byte
> array and the rest of the heap-allocated struct tw, one attacker-chosen
> byte at a time -- an unbounded, device-driven heap out-of-bounds write.
> 
> Reset the index on every completed packet and report an event only when
> the two Y bytes match, like the other serio touchscreen drivers do.
> 
> Fixes: 11ea3173d5f2 ("Input: add driver for Touchwin serial touchscreens")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Applied, thank you.

-- 
Dmitry
