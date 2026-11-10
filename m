Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278181;
	b=5SzWg6lf5UP080wTLeOl6+Ilht/zFvCOpkp4SFMVNCeTb0F9JDcr2lPDhw5i7M14xMic
	 niHAMbMuEs5sU01e8XdE4H0FyFv0XJ8r+CFB1PvBjCsmZaOLT7W0t8zOCrRq8eMFlsW0W
	 +3ARq7bRGhuyROOnDeaMZalIMDYkW2ysVcdoIPb/dxMaEf6Zuk7+ZuMDTOcjtokS4bqW5
	 VYbN9BcEj/iFXJY+DopESS0JqwrQ5uyNFxIJoUL5DA5lVLEdMW7IlcKpQNeuNN5Xue8HP
	 IbMlUAIeBdvtqSmxUMbnjksjY/xRAPCbxZDGISPNv0/C5LCcaA8r1cyYqNtFPf5Siqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=I3vLkJZQD0rVpmgjfOcaWg93t6TdJv+fzjBvHDBOP/c=;
	b=Bekz/vjKtcJdf6mzxNEzwHFrRptxFfxtXW/0qGkWzq2wkYUHaPItTnc8RbJVI/JU2tQ9
	 AoY5/GWTiyQTEy1BEYXmcF/3gLH4l6KezgCzKoxpT/Je8jW1QbfaRUwuXsK2EZkmjSFkV
	 hyJLP5N2XCj7pwGGjFrYUoKrcbjP9cXAitsAXNDAMiF1UtQ82Y0yVokwKpEGVjKzgOX/R
	 nj2DTady9LhmQHOMQ9EvKjwH8WEIhlo6BsbVZY83YBi6dt5rfiXPE/9fnRLmYS5/BhwQH
	 Eo31Igz75BobXRXlrDhugbrG7PTAaXbJeXp5cnGicJ0bzRZZy4FO8GTvjf8aPqgiaBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NjnZ5oMH;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9D2606A31C
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 02:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F9D2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NjnZ5oMH
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1a3c08d6928so2772912c88.0
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 18:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794278180; x=1794882980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I3vLkJZQD0rVpmgjfOcaWg93t6TdJv+fzjBvHDBOP/c=;
        b=NjnZ5oMHIPP1eMYOkel3mxmL4O+4lh4UavbGQ0x8iYv3OBu0P3R21QBlmc035MYJ1P
         ScvcDc5YjSV32zsFbIUqfQ5AE8OGXPY+J4TL24K272+Ea8f1dIUC6MYLiSpmQBaDrbYd
         IJ4pFpwrdAnQdyDk6q939qMuc3gTOsGyywSWTjysvOv8uFs1XcozEw6YiDdFnAzmODiQ
         YjEYCpl9izC3klbEchDFgsc3ppbyQrCnIra9jbB1uDPU6SieieVUVPoK/1f4uOnL8Uwm
         g68WbK8QP7kstdYvMDW+oFuODtfNDmYakQiS/8VXLuGgptyQxL1+3EGYzsgh3gBJP6I9
         kBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794278180; x=1794882980;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I3vLkJZQD0rVpmgjfOcaWg93t6TdJv+fzjBvHDBOP/c=;
        b=dH8SseERpckm2ks+qz9Pj4dyvePalLZeFLlEblqxuuRlcWFkQ/qeN6ggGV2OnZ3YsH
         1LLBcXFq+mjmdhh4fURXdl68XAJ6Nwk+U5oTX2Q5+c9IxU4gz8nziHvCy50nlnE1MXQG
         69rAr/aMJTE9Y35JlZiDxQEckP6+1EIdcMWDZ+0pfeDYBDaZcKPQ+snyed7aCNeoGxZ5
         A8PoIOR5Cg+HsDk+FkhdYObt2uXSMJ6W49qEE7/XnLSvvd30HEhVz2AcDawcPVLN/3X2
         5vpQQht2rPnjyPp8nTiE1kckRNFVj6j1ygkaP72w1NUaEN1rj8aJsOkQ+VoGzMIcGpgm
         VMcw==
X-Forwarded-Encrypted: i=1; AL+hErHpC/q3eS+EBbezGSMlRot7SH7OM+wzM8ZqII8xJfyNY3Ty5EFy30jsQ5BpNR/EbU6AxH1OSRgVamI/4Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z/V8Bfbf739CGta5zjBmZW9GoggcQZDNMMPHF6PFbVcK4TDfMWD
	5pQJaaOmt4JlRaLXrLF/XwO0y5RUc1eCVfaMcHYub+WgBj9ObQRFGIIx
X-Gm-Gg: AYBFou2EeZdBJegV4lNPfZBYxPwJIIo0zbYYgAITJO9gIIlzokAiqBc/07OViguip9r
	2iRSR0GmN7wcKRn8Z8vtN8pcdsQKhEVMlmZTTswxxzZ92Gt6eQgh6ZuCZUBp0wU4VPH4zwTQTra
	HCwECPXf64BSGg2EpOu6vQtExwhAn0ysDuKhln3WbQgjGKYdkUJCBFq9N1/xHf0GlAWY2fEpUmb
	VJ4Vics9nzzXBd9V9Dcp1plOwjewulQpdRrIKqQgPEHQOXjqTM2rJNNVjDZR0+etTnqakhyCmn4
	JD5LUSIIDzeAz5Nf9XYIR4NlQ+KRTD2bQ00sZKrYjOIFq2xejzzagzGRiXubd8ZJOmlUkDJRaBT
	y7JxiiItRnm3cAV3R3H8w4AVPnqUCkMPzi9P9Ji9rJNxMQDXrSQSCc7E1O5BAw3TPFOHsTks/6e
	azsaOvryfs7qiLCKk/7yFXa9DsKJ7evmyK4LiQPYu4XXgcrUV/72uOb3y7op4XUW2U6lNC8Izb/
	Xg97/SZQEqUU+l5R++nftexkIvieUkKwLmpJ0OcJRyv1lzyavkm34IIIdhMWhOrKEyuToNvZICF
	i1uDnuraTBaUWsIjmntHkKJ6r6ROmAqIN3K2Vgs74902mm2yIsUU4u/VcB6grAFGRWiP/A==
X-Received: by 2002:a05:7022:1717:b0:1ac:1022:b60c with SMTP id a92af1059eb24-1b3b5e6709fmr1555709c88.1.1794278179655;
        Mon, 09 Nov 2026 18:36:19 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:856b:460b:b522:14ec])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11346sm3608596c88.7.2026.11.09.18.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 18:36:18 -0800 (PST)
Date: Mon, 9 Nov 2026 18:36:15 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Yuan Yao <yaoyuan0329os@gmail.com>, Jingle Wu <jingle.wu@emc.com.tw>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Vishnu Sankar <vishnuocv@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Phoenix Huang =?utf-8?B?6buD5LiW6bWs?= <phoenix@emc.com.tw>, Stanley Chen =?utf-8?B?6Zmz5bu657at?= <stanley.chen@emc.com.tw>
Subject: Re: [PATCH 1/1] Input: trackpoint - Add new ELAN trackpoint device
 variant id 7
Message-ID: <avKBsi-E7IeUgsSY@google.com>
References: <20261102130836.11863-1-yaoyuan0329os@gmail.com>
 <20261102130836.11863-2-yaoyuan0329os@gmail.com>
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
In-Reply-To: <20261102130836.11863-2-yaoyuan0329os@gmail.com>

Hi Yuan,

On Mon, Nov 02, 2026 at 09:08:36PM +0800, Yuan Yao wrote:
> The new ELAN trackpoint variant id 7 is found on thinkpad
> X14 Gen1 laptop(Product Name: 21XMA006CD), it's now
> incorrectly probed as Generic or Logitech PS/2 mouse.
> 
> Add ELAN variant id 7 to match the TP_READ_ID command
> return value, probe the device as trackpoint correctly.
> 
> BEFORE:
> input: PS/2 Generic Mouse as /devices/platform/i8042/serio1/input/input63
> 
> AFTER:
> psmouse serio1: trackpoint: Elan_variant7 TrackPoint firmware: 0xa1, buttons: 3/3
> input: TPPS/2 Elan_variant7 TrackPoint as /devices/platform/i8042/serio1/input/input65
> 
> Signed-off-by: Yuan Yao <yaoyuan0329os@gmail.com>
> ---
>  drivers/input/mouse/trackpoint.c | 2 ++
>  drivers/input/mouse/trackpoint.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
> index 3bd8fdf56cd3..f46fc1665c96 100644
> --- a/drivers/input/mouse/trackpoint.c
> +++ b/drivers/input/mouse/trackpoint.c
> @@ -25,6 +25,7 @@ static const char * const trackpoint_variants[] = {
>  	[TP_VARIANT_NXP]		= "NXP",
>  	[TP_VARIANT_JYT_SYNAPTICS]	= "JYT_Synaptics",
>  	[TP_VARIANT_SYNAPTICS]		= "Synaptics",
> +	[TP_VARIANT_ELAN_ID_7]		= "Elan_variant7"

I wonder if we really need to say "Elan_variant7" or if we should simply
say "Elan" here as well.

Jingle, is this your part? What is the difference from Elan trackpoint
reporting 0x03 as its variant? 

Thanks.

-- 
Dmitry
