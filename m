Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795635500;
	b=KshOUi1z4PQoAPq7x4N4IxM+vUzej7CcD5012lH5o1OpQzNAr0mnmFAtgukLE6qQBvkG
	 SDnj3NT7NvK2YnCef/H8WpUJgpqBnE4SFYrVOpCVLftntKerb/hBV3+aqsj+dSa0nidWt
	 toCT5lLEMc4UcZCpOwAYuapZiUxhs0MkZbMaJD67A3AUaUxrxcB7TBmTcF5hlfEJBElTy
	 qpCXzs7upnKReBLpd/I+WMcAsA36r46SMMvarY/lmN3CDw6sNoSbPTNq0RkdSR7Bbn8Kw
	 E4bReJoPO0SA3PWyq9eDZrvkvnjrKzWY5fSfn+BehoPDpPwVcVWRjCDfJW9gxdUg9UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795635500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dXKYI3EJxaQV5jIHUv9yi8G36X/Qj3DOc1D0IScmz1Y=;
	b=zDA76kXaKrZGTaqtikK8AE03g+jvmDCymtryjHfMD0kI6GEw0xJoWlyq2/DsT0a2V4TR
	 9z3J4XjROu/V35BIjmdjJhyAFgvSE9mvZRTP1UcJsl18/7ACnRBuyE34DW2F7yuJXBgq2
	 3Fjk0m8zNukwSt5CqnabDvMwnr87/ywskWIZ2m8bkSDmkYXmH07fP89KX5k9oGCOQSH5I
	 hbDaksg8H8nHS3V0EBRro6U72g03vbTisqqYOOkJCoiwSqurc0BzSo66my2o7j86i9++z
	 wEZPar3+OJ3/5mmUmFCeO61sPXvADY64/OaVMaWlwvQHeBnhuBG4ihw26UHCBfQOSow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MwpqHJf9;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9850606A332
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 19:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9850606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MwpqHJf9
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so53475605e9.0
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 11:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795635498; x=1796240298; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dXKYI3EJxaQV5jIHUv9yi8G36X/Qj3DOc1D0IScmz1Y=;
        b=MwpqHJf9Zki+TsDgpLUnfz3iPp40YjADzk8uJKW4iaX/Zwuc4txSCT2qW0hS2BEx0g
         /x3x00L9fmJk9L1f3P/+zNZgVjAK7GGPAHL9jBT+GA3jPx3nQB9eBXxZwvr3N+gnJ25E
         tpHQbwzTSIeeg5HB1JboF7LiGiPMCWAFUBCpIn17A1jiKAjPJaid+SYLvzVCGPHySIAH
         Afslz28eQ9JW3GidBgF9AKbS4Jtxw3FLREt8UnXWrX4dta9VcZnn2M9Pwcp19XNVXK+X
         wYHW9PG5er9VAQSOhaovy3hIrSQzULFNUcJhK0a29YC6TicyUh2bwN85kNEBLTxwugTk
         mxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795635498; x=1796240298;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dXKYI3EJxaQV5jIHUv9yi8G36X/Qj3DOc1D0IScmz1Y=;
        b=m7V+ow4i5NjhQrbUfDeaPGgp9kVEtZrviX7qM1QQ8JjJff2xiWQEwG4SslK2Jx4DoX
         9scdChB0/kWRzWRuc4VJqYgHM6wThbAm8QVqqCw6V3eoCeIebjS+9XqG80z+WMYk/4ue
         LdtjuGiIts5aUsS6xOBhqIrujP16WWZ6+N0lyqRqYfgGL4UbS2L1YbP8MfTmszIPy94P
         K6sHELnQfshOnaRV39ZKspzbgNI+9fwhNQBphrsEyOaJTKbZGs5g285HbjAj8Cf0CvoJ
         7ATfEdZ86IUFRRs7jCAdKyTyJf24d6BcBWIUILRLCkBTlZ5SdH/EsI9fBH92cQNN10IW
         0RrA==
X-Forwarded-Encrypted: i=1; AL+hErEw55eZGf/nByx3GjGoEmodVDA/+eOj/mVJLgF+sWwfOteiSiusS/hJg5H0cDX7F/e+FDCIyqhXPFPcvw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+m+eKAlVViiwB//7e/Keg61IlDpbqJ9/eEIAw4u2OkJgnSkd3z
	NgjjWUkRzmhHIJQ+H50LlA+7HY9cbCaL2LsqzhHwHanvI6lif3y9dGx8
X-Gm-Gg: AZFdTZf8KD5jOzfpU8uQupoti0nJWhv/zaDSgNZByREYLELhHa6NLGH9/jYZMsz7IIX
	s4grAK23BIZrw1goSlxY8u23lhhP3MDcaAI9eUnJ22m3b1pHrROWbzBv6Eyw9oaKo6E5kIEy9hJ
	2IH95lJB4GMsQZgbfpvA5Z0wkxd7RbPmVvoS4O40Mu26xORSFUtzYN4OfLLbbL5elR2tbzMMU4L
	1FtnNoUKiHRvRPg3SNJY/TQZ3TjURfLt5WoOPQxOGZIVjIyH3x4V6YfaGG0FhIAB/1I1bIBaBPQ
	W38BLiP08BJu+/tyTDB68ERiGcvDEsftJDRkIoiECP33GU9mRvkidvfLi1lI9z7VJhwvI+Lwd6y
	9N4+LLb52edbGvRiSMQcmsdcnI0HP5j3TkAZ3uCl/R2ELUw2lecNoZuxTWxU45iwKBdCBBlcq53
	lb8re8GQdBALWK4EMGmJQkAahNPUJ+w+OoBt8yWKNJbIi0j2D6RdOMahpcYpk9g2y+yWEv7tivr
	NBHxqdH1JacoBzEyVLp7XTsRaTM3p6Au+9s3LFTFxYftU8ZeldJmWiBDPXRi9C8Iko1ECf+OXmD
	XJsMgC05iEly5LUItYLpZXAvAxjwW6nBGMKX7wrLnA==
X-Received: by 2002:a05:600c:1549:b0:4bb:741d:ea8 with SMTP id 5b1f17b1804b1-4bb8880ad4amr366178805e9.7.1795635498187;
        Wed, 25 Nov 2026 11:38:18 -0800 (PST)
Received: from foxbook (bfh118.neoplus.adsl.tpnet.pl. [83.28.45.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b8429sm848261515e9.14.2026.11.25.11.38.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 25 Nov 2026 11:38:18 -0800 (PST)
Date: Wed, 25 Nov 2026 20:38:23 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Kettler Christian <christian.kettler@stiftung-kifa.ch>
Cc: "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
Subject: Re: Logitech BRIO (046d:085e) stops answering control requests when
 hot-plugged together with a USB-C hub; usbhid probe blocks hub_wq for 60 s
Message-ID: <20261125203823.15fc4478.michal.pecio@gmail.com>
In-Reply-To: <2ced9c1fb45e08a94f56b0f569b01369044b5553.camel@stiftung-kifa.ch>
References: <3cd5f994a6260960cf7751d6383f2b9afc1baeb5.camel@stiftung-kifa.ch>
	<6118ad01-65a0-4357-8118-3122479b554d@rowland.harvard.edu>
	<2ced9c1fb45e08a94f56b0f569b01369044b5553.camel@stiftung-kifa.ch>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Nov 2026 15:09:52 +0000, Kettler Christian wrote:
> The timeouts are not limited to the BRIO, though. During these runs
> the hub itself (VIA 2109:0824) once failed with "device descriptor
> read/all, error -110", the Realtek LAN adapter inside the hub got a
> -110 and was reset, and the hub's card reader was reset as well.
> Re-authorizing the hub (authorized 0/1) never triggers the hang, only
> physically plugging it in does. On the laptop's own ports the BRIO
> never hung (14 plugs, 4 of them on the USB-C port on the same xHCI
> controller, with the same cable and plug adapter).
> 
> So this looks like a problem with this hub rather than with the
> camera. I'm using the BRIO directly on the laptop now and consider
> this closed on my side.

Hi,

Multiple devices misbehaving could be the hub or perhaps the xHCI
controller (looks like some Intel chipset?). You could try a different
one if you have an opportunity.

Though I have no explanation why the camera works on the same port if
the hub is removed from the chain. It may be the hub after all.

Regards,
Michal
