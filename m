Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77114A21
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 01:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789348472; cv=none; b=mN5B+EDKQDeIlCEXeIAWh5wefR/UdkfbKbpooYlKBPrGUFqeFiqrF9bbpNwQRH+YdiMZKVdY/PYsKBj9rv3IdfVqRq6Q4Ulo75AwvKSpD7KieD1BCOa8OBUR8HN72P1fyTOKKzqwixbvspintXKf8Wb0fr+mnrFxY+6csfkh9kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789348472; c=relaxed/simple;
	bh=gkrjiXWQdLchFIxKXa8Y8Btt9pohJwPht7OT6NsVTp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScSwxcpAIka7soENlKtVFJ4aphVHlYvQN6pawm20RrlAIcJKk5Mq+rlJxK99bTgD/hQQkYzzsqlz2Sn6rGfHiQiMmfJHIhUZbn88v0hBoO/SGXnPjosApWCRVa9Mix4VsWUZYqbglpmPGMsQGfhe0bT/cVeCX017OkbaSiWfG0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtcCo8re; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtcCo8re"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so2648638a91.2
        for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 18:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789348470; x=1789953270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L9qAYTqFHjlPEdHHsiRhaOvKJ09w0xbrCmwI5LA1vaE=;
        b=OtcCo8reDX6ASjKJVFIuufoQJlr+dXw+6f+Yq8pzPxjR0loX1mQ1MtvOGH+2zUp0Oe
         zWl3F2Q4bXOUnqF4VJejgdtzP2RFtrcaUlwF+XuGsh1EOp1ZTv+CIwdZExQ1JtHqz2Yi
         sJEC9r0MIFpQd1d8DaEvr4VigA0oi00jOuAUbE6yRDu4RHvindPUTRZCbgoKLtFX20qu
         rWRw3yb5Idrn8hDTt/rU0DlBmwFYSjWpnzin8f3KCVEcgLNGaY2QPuV1IA4dugcPR1Dx
         mRLy9EDLYqc3iCe4cQKSjA8Q9XgQEH0csxkza65s5aeannujrrz7+SmD4djnizxtsF9z
         t2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789348470; x=1789953270;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L9qAYTqFHjlPEdHHsiRhaOvKJ09w0xbrCmwI5LA1vaE=;
        b=IUIRWewOd9uCdjENusSbGrkdvwR1RFkrPCxJe6BzK3DwgdixQw5BT5qn7pp/ljoJYS
         O2df/6cpXbPv5AC3sLjnu4ns+qpX0e1nQBwr/ABfQaDRldYYlY9J02iqnjNnakXxcqPy
         Fq9V5xM/DF4mD3omtID99Q8jMeBoaOZ4clwP5e3K/NyDi0AUqEOe1/LPoiYYBSc+zToU
         bpPQOgb4IWg2CTXB35lRZfWardELvbvftYsBuGk26p3BHL0OudXmitgjGkRhzvVxRaqw
         ouaYU+pW4CrmbLAAMy7/kngg0Eko3PCqBg9cZMTMWpSTZ70JiftJ33RasnQsyxP/nwuI
         Rdfg==
X-Gm-Message-State: AFuF++nExnYW036rnORWJ6E12AV/aJoh7Xk4+uDQ7xLUzTTJ0GtzQPpn
	qNgTgQ2aVGrs64FI3Z44bo4+pbTm/MQRxa9qNoOpl9wfIbK7ukqIrcGmRTcCUw==
X-Gm-Gg: AYBFou2DI2k9xP0sMOyB2GLl99+rR9o9yZkVs0WUKP1yzUdyaWmqm1elUlYKKJ8qHhL
	EJF/7JbuhpzLlBx2qMuYalEsNRXLAuwUET57z4Sh7E2uebuvwtAjKyOhjZzlIx3GzWm0GYQuiUx
	QZU5vd7z0ztl3tWy42n68hY5H2zVGN/wshn3ixzLvlLvT98OgcloJYlONTV4d2CY6HnICwRkLRn
	k3k9wDmifzLrMNQOU16sVB9vYcuARvciRgz5Imb3MXiKDeH9EcjkHvLsaz6lWrQibB61mR7lHqy
	v357mtX1A5BOQssIsZBE90ZObH37nBAUZH5e0Iu5ren5XlUwh0oSGdN1BdSP97vwrj7svjcf1hB
	KNIHMSsX/0lUvTfTvm9dQYvqcDdYFYrV/yuF/oHAzE8f7k2OycgBkql6NGEDmhTRFInqK0+idSN
	Z5Bl3FXZpe3pkBgVj2HXbU1/AQcmvXGaTYcIuaTMiEqwtWIv45TGlHmQVFKxquBSPXrvOxOB75f
	6xg/YZVO8iEH2tHMpGklXhfPSwi6tUEeSqv13zA
X-Received: by 2002:a17:90b:5343:b0:38f:240d:b857 with SMTP id 98e67ed59e1d1-39debf6dc9emr936056a91.2.1789348470237;
        Sun, 13 Sep 2026 18:14:30 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a739:376c:7eb4:ea2d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b8ead8sm21699465c88.10.2026.09.13.18.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 18:14:29 -0700 (PDT)
Date: Sun, 13 Sep 2026 18:14:26 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: linux-input@vger.kernel.org, Aishwarya Pant <aishpant@gmail.com>
Subject: Re: [PATCH] Input: trackpoint: Fix the inertia attribute name in the
 ABI document
Message-ID: <aqdKbize-qlCIjMo@google.com>
References: <20260905102038.42882-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905102038.42882-1-kmehltretter@gmail.com>

On Sat, Sep 05, 2026 at 12:20:38PM +0200, Karl Mehltretter wrote:
> The attribute is created as "inertia" (TRACKPOINT_INT_ATTR(inertia, ...)
> in drivers/input/mouse/trackpoint.c); the ABI file spells the path
> "intertia". The description below it already says inertia.
> 
> Fix the spelling.
> 
> Fixes: aebb47d4e7a9 ("Input: trackpoint: document sysfs interface")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Applied, thank you.

-- 
Dmitry
