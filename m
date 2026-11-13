Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794548391;
	b=S04+7mOKWi+DUUV17uwB0SsCmnZBriemgUqwdkcZ2hxwo8ZT3jgTdJV9R/imr3FEsNuE
	 ePsBf596CCn/fKEsWp5afpIRVgJV0wUb0U6SCR/CF3kYk/eUFmBiv9iPFLBdSvE+hCnqR
	 B2t12CDyu3xUHq/u8T/HLWCb7LSkc6dD0qvQ7iwwOzerB7j8P9Ojd7xL6ZwqFxQhBO4zK
	 xqHmRbleXT0A+7rsQieq+dESuH6NK8/8LUosPgFQilPbOtS2vomg3rYEWh5xzVkzm7Apf
	 aJClL4kWF0cCeWIX1wv7ffaiiEPAczULfEjoy6YfaLVFIPueN0uHiaAoUNMGnT/sQdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794548391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=MLrmlNGp9hXCiWV6hUp8+jx/5lwfA9JbymC0IwYnPhE=;
	b=1tInPrPBVFuaQ94iSTLL9uheFHChsG0fe/lJQ9OMCghTCi+iMsIG70ekf+FucCNYv13l
	 jf8WKc1LWgA3Nak6Z7yAxGSusiB0WMjLvnqtg4xo2wHNTM+IwEAQigtofCQUHOemaTOFd
	 Ko/DD7mPhdhFGHOj6PeCSj2lOzGeEpBYRKqGLOiE20Fuu4D1YJDZ6sercsY467UD2xGFJ
	 d73rOwKkDCtZqlNNK9ZSGw4dESmYNX2m5cNrskIgCySRY6k5qENdNDwt9Biqpv5qn4cyL
	 92PAAo14ukc7lZAAB7NqUB3PKbG1Urtf3ZhjorjETDSYYVhXm8ZbWDxDLcOG6dIRpoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oh5wPJLa;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C75606A32A
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 05:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1C75606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oh5wPJLa
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3720addb068so941420eec.1
        for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 21:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794548390; x=1795153190; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MLrmlNGp9hXCiWV6hUp8+jx/5lwfA9JbymC0IwYnPhE=;
        b=oh5wPJLaagbyJyKOYBAuotMRSAH06GN+KO6+qs/fbimUELrgotcY3XGGG9YMI8IzGY
         GNEBPUBXNCVaupGLqs6DyodDSR0sMl5Arr6REDqD2vxXUyqgNdPhKVk6lBBqqUsJ74N2
         +wXNbKMeJQmteVX4zbCE7dq1mlMygBba39y36tBGXrpR84WhRwoyoVjUl0PZUvyxVPpL
         XDYqYZDFG4l6/SsVThD56I3MxEJvOuSUlnGtffggWSyLzuOt6Ypc2ruQtyTcS966hD8G
         iqmjf6PcAftLCMjoaJ1QitkAas10qOE6Ot2pzg4WWh0uPbSUBfkHgccbKat6en8CNlG+
         dYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794548390; x=1795153190;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MLrmlNGp9hXCiWV6hUp8+jx/5lwfA9JbymC0IwYnPhE=;
        b=f4szVhO1f/TG9FGsU40NbONode53UZDACJyr0HE2uzgTFB2j9cZa7Mgt4WsQqTBpCx
         oXuqlyCiCvtGTw01Yv6E+xXNVqi1US2wRpIv7KtGNgyWsb5x+PzejLGa3m8/+/IfaGmi
         2VkaWyqsZdSx06Qjf6DMV2VAe1xkrvX5Nakc42uQXTL0TGfMBvxO7YxWcy+VfQK+EYN3
         iWhsOJyjENsW0FD/8Nt4ICr0HBFwPd4KPmu30Jhgi5tXA7k78SGat2rJJq/mdpxIEQK+
         F+nN7B+UPP7PqHaDIKHYQOJN6rmVT5Wptnm17aaAxJhfHQWWWrvWZekxjtCzS23hnFFI
         BlDw==
X-Forwarded-Encrypted: i=1; AL+hErFbZk2X2EDf5rJC7xPsICBNiRL1U35zlg1JCm+PtDd/RPoH2UYgVTV9OY4fnDG2s8hjy7zAM/pfx0qzWw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8+GaKt+IIkBoZvBoq9sVMPs/mbjKDtk7KAJxvEquscHtCv2nr9
	ws3e9JwFKf2YUkkt2VBD/tX1RcNlO49J+lttltMTJ+WPmd/cd2PBCAgd
X-Gm-Gg: AYBFou3o/gYaj4hcbK7dbWOpCBwEkEk9abm+rBWlLpL59uXUlrEjqU1xooW41uISMyj
	d2ayV+iZJ4EBjt72qzGWL/rK7UARliEBxhtEhM61fnrT1spcMappYO4Hoqkc+VBoNGDTb8jWElL
	5M3AEaioAqPMZPrcTU0HD16oPUNnXDRwLRER0r0WV4gxRdcHfp43An+tYjnyOlvkZOawFbwkpyN
	59cuk+3UcG1yKY34GfvlXdPivfVNlgPVV1jY1M4ZaQg/+z/TqsnwbcY8YfmWSKbD4HayVD757Hi
	dAoeEoSwLVdFxKskx2GvGxV969WX9Rhp8Tnx5pFRKjNLWMeap9uLNYqhYrsVN/nwN41BcywOxzP
	IXxYwYofI4e9sISGAIjMilzkrANjlkbaM+GAh0X5XKj8ZEeAaK3Q/ZDsiH2tb5aNwlv+5QHNaYK
	6GHhtbRkYkav6jTZUA5BM4DnGcyOGNYZnDQOBbCjlUE0KN3A3bWEq41IGof/GLHaFE1hYkVZNkG
	P1fxcQtAzy2EDBkIXGOrMqRpyDqw6qeMSNrlCtOi81Y5+N1riWGPb3ePZSOdC6Gc72haI0FDG8H
	rQmVp2lb1u4uFgf8r7fUf82rXXRCKOOymPQ+Y8Oc1JjMIBArliwfgzAuEZwFnc90ONz6W/E=
X-Received: by 2002:a05:693c:87d0:20b0:372:3bad:c861 with SMTP id 5a478bee46e88-379680ccd5amr1351913eec.41.1794548389777;
        Thu, 12 Nov 2026 21:39:49 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:48f1:7a0b:9bfb:4205])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379559189e8sm3785444eec.11.2026.11.12.21.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:39:49 -0800 (PST)
Date: Thu, 12 Nov 2026 21:39:48 -0800
Message-ID: <5252f18157db7e26e27dd3ae2acb5b39@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Gideon Heinz <gideonheinz02@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	=?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Hans de Goede <hansg@kernel.org>,
	Edwin Velds <e.velds@gmail.com>,
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 00/33] HID: logitech-hidpp: G920 force-feedback fixes, rework, and cleanups
In-Reply-To: <CAPb1+K2NSGzvp5b8_CfRrDK2trD74+pCi_a+OYV4cza++DP=8w@mail.gmail.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com> <CAPb1+K2BxnfQ7VUQ15td5f9pVhn-ARSM9EjfOU8WuW72o+cvPg@mail.gmail.com> <2f722967b6db0692d4dd4164aff39b62@gmail.com> <CAPb1+K1J2F-=cJF_+Z+RkA+9uLD8-15m3hDv71DSPG47XLJttw@mail.gmail.com> <CAPb1+K1pr7wtp-CCE4x4i4HzVkGfpiyXRBdqWJ-fmJpx_-pfqA@mail.gmail.com> <CAPb1+K1mmyvipXSx96-j-+zgxeTztLNfYYTuERw0Ykf5WDv9sg@mail.gmail.com> <CAPb1+K2NSGzvp5b8_CfRrDK2trD74+pCi_a+OYV4cza++DP=8w@mail.gmail.com>
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
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Gideon,

On Thu, Nov 12, 2026 at 03:50:37PM +0100, Gideon Heinz wrote:
> Hi Dmitry,
>
> One more result, this time the combination you asked for: your input
> core patch in the kernel, plus the v2 series without patch 22/33 as
> the driver.
>
> Setup: CachyOS 7.3.4 kernel with only your "Input: destroy
> force-feedback device on input unregistration" patch built in. On top
> of that, hid-logitech-hidpp built out of tree against the 7.3.4
> headers from your v2 base (630059a5a632) with patches 1-21 and 23-33
> (7.3.4 already has a different G920 init fix, so I could not apply the
> series to the in-tree driver directly).
>
> Same reproduction: fftest holding the G920 event node at the effect
> prompt, rmmod hid_logitech_hidpp, then exiting fftest. Result: rmmod
> returns in 98 ms, there are no "Failed to send command to device!"
> lines at all, no hung task warning, and fftest exits normally with the
> machine staying up. For comparison, your input patch with the stock
> 7.3.4 driver took about 3 minutes and printed 12 failures, as in my
> previous mail.
>
> If you would like me to add a Tested-by for the combination (input
> patch + series without 22/33), please say so.

Thank you again for all the thorough testing and for verifying both the
input core patch and the updated hid-logitech-hidpp series!

I have added your Tested-by to the input core patch and will merge it
through the input tree myself. I will also give Benjamin and Jiri a
chance to take a look at the hid-logitech-hidpp series, and with your
permission I will add your Tested-by to those patches as well if I need
to respin them (and drop patch 22/33 in favor of the input core change).

Thanks.

-- 
Dmitry
