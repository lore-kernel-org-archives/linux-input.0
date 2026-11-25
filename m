Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617774;
	b=HoMUeFEWjtUKkgAPE46kXuVkj1eXNYhwhKp+kmHKbAKGDBTbnvMAueIrv2cDRDikzPbY
	 8Etao6CpPVNBvOmpW4qJi4vz2DwYcIvsIWkDCCwh7XTV5Sbi2GtFi9DNORh/IsiWiwi+j
	 9MHoSdSnh/xP/htSKcXtmEOh0cngC8T4OESLSRzVpxMcpVu4nYfoMwcFk/79Mv5pIU197
	 pr4fohoBuosK1ECt8r3bFlvk36XE3SPRtx3QXY86E56BJGt7YvPr9PxQLjVq46ptcTZmz
	 Luck59P9IgLjIFQUdfqAjkM0aALQA7GRsyuM4PtXUL9DkriLMuMP5bwuOfA2+tZ6JDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617774;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=pe1ZMe82aYurb6rarn1VrDghVHB1DbUnPtYdYIQXQBY=;
	b=HZDwTvzgY6d7WAGZ0JdCM0TUF2OcEqYZHxCS5e3DZU+IFleDQLTDsomyEKv5Da0dJB7Y
	 LnzMADuJuLtnG2y/hgLDIqOI1fPv1ENi9bgQjmDmR2JRXRFRLRKmEObnq1yKgYBtvy5Ei
	 BCXjIhm9BJe44+i8rwQZxPZf+kBubUxjxBaRuj4kqm1MU7fz2+LddDvHmezyjC8YJbpMv
	 5W9w0a60AGIu6xbGolXcH+ddORvILlQZPDVVuz11s+Z0mebJnajz1cl9z2E5pJjjY3QS8
	 eT2ceDdl9TWwioaV5k00L0Ywc0ZvSjMBjFvNylQ2sujXJ0R6vEgtbRk/O4nxYhvhXwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b="EZW3/ZuY";
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95133606A323
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 14:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95133606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=EZW3/ZuY
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5365f9a04c5so42794161cf.1
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 06:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1795617772; x=1796222572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pe1ZMe82aYurb6rarn1VrDghVHB1DbUnPtYdYIQXQBY=;
        b=EZW3/ZuY9WExbtSmj8DEkIib33heZdtGlhNDFx+tWdjASShaGJG9l1m82Kj/MaL+Fp
         dpSIbAnEHbFlVz+hIeuZe2jUZo7AJHmM9qcPUK5q4JUVqrygllkLlH5tKigPAwlBeJEB
         9LB10PLPNriJ9LdP2TBPATITfz7dOocLcdPXlVrWDP+RhnNxnuqb2E0hJfrMM+wCq9Jj
         0kjnypjQJIIlk11Kkm8Toq0P5eSeNb2pMa1k0pZ3FpVxzPKKXpMeyZeumx/o0vJkVbcZ
         vPXRC8FrppaPLwV8HvL9WH84Z2AFAp0gZ44kP+l6CyLkE5MwSC6VlDY2fKA7gEMmX/Xv
         DhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795617772; x=1796222572;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pe1ZMe82aYurb6rarn1VrDghVHB1DbUnPtYdYIQXQBY=;
        b=hEB84TcHr3Iv3nuuScGfSz81+ECBDmb95z60eeK6ZOIoxEUsV4wOsn9+akftmWj/Iy
         HMjS6R6h7O2A2kSuJrLGH/r+TsAduGkfjD228EBTbga3vghRBKhjUfXf4cZyQzeHSYvH
         RGk6wey4k9GYxq+60c+sjUwU2fJboGBZKPF6zM/snDZ7zHpYoSwdU5+1udPIeLwFWOkD
         RkWWTno75DKZapsdgdKAX6uAasTfLYfp1HibzEtcndA3Iz3Gae+SIG9Fnyjh+Vt2wysw
         4FrMBnzVpbmI9jtnvXh9OhudVl3wUr7sXrjD++AwNApKFDTxs82odCJ2ONEjYYH9GJbh
         DOSw==
X-Forwarded-Encrypted: i=1; AL+hErFRrchuqsZC46GhCtr1I3mBwnUP7UnX8zb2jgoS2qHytpbgE4oGPZFfuFG5dAei37v9S7SYvE0lq8SGTA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8ylK6jgGGUFfTOwTT4Mo6v1+gu1MT7S5OfgAtQqaTXI7H+X+xY
	pjqjtNNJaesfUPYYLw+T67GBXuDwduixdSgqnXiYlY3K6h4NfmmbcHKsmwQrplKIqg==
X-Gm-Gg: AZFdTZf11DoPObfaSuXuMdK1VeYWxuTcq64GH1/4EcBfNV2rnRK30JhKTp+XPyjuoGm
	xPp6p7VAExlXl1XUyyhs22oYpvmfC+fBvLCgVLB6VuotPTS84/zP/puMMup8g8uXm/ULPFweJDQ
	Ki/TWhxwj1ENBd8h05+sWYpwQJOY2GZdIU/DCsVpzE2DzZ6SECREAsjxYH/kweALLsP549vIGPt
	kmk69JgUv1UxpAXEwWFx7LPccLBIYlG1sL7jUDI1lTrvL8YjHCQy+CbJvEc9lcvtRFaheyj+4BY
	NvjXoRPSmhiza459NrEO35rBMwvX+jKoNDzDpAbuMYlqgeL1qYN2VMwjiGQUq7vsd24dvU5jSYf
	Qj4ORaey6lnPMyC3v2j5dqvnfl8Wb20v1kbil95NnsVcAJtW1JNyF2aXTWnlShnHJEOTQoOZws2
	ybicGaSL1kFteCM6J0PoozOht+6BclD6L3Q+d6cj1VL79+h8MOQk7sP5QLB8KV5xbZJeV6ghUEf
	xa+Hh0Dgc4XeXzCkMXO96rkSN6u14lveaaJzRqrrW5wvciAVfsJwAf68fih3XPfFDS96D1JVQp7
	kPHfuN/QegiHkU4iZF95i9mbGPjfSg==
X-Received: by 2002:a05:622a:a19:b0:55d:33e0:abff with SMTP id d75a77b69052e-55d76933293mr358229581cf.6.1795617772385;
        Wed, 25 Nov 2026 06:42:52 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d00:161a::9a34])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78e4fc12sm154986831cf.0.2026.11.25.06.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:42:51 -0800 (PST)
Date: Wed, 25 Nov 2026 09:42:49 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Kettler Christian <christian.kettler@stiftung-kifa.ch>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
Subject: Re: Logitech BRIO (046d:085e) stops answering control requests when
 hot-plugged together with a USB-C hub; usbhid probe blocks hub_wq for 60 s
Message-ID: <6118ad01-65a0-4357-8118-3122479b554d@rowland.harvard.edu>
References: <3cd5f994a6260960cf7751d6383f2b9afc1baeb5.camel@stiftung-kifa.ch>
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
In-Reply-To: <3cd5f994a6260960cf7751d6383f2b9afc1baeb5.camel@stiftung-kifa.ch>

On Tue, Nov 24, 2026 at 07:56:35PM +0000, Kettler Christian wrote:
> Subject: Logitech BRIO (046d:085e) stops answering control requests
> when hot-plugged together with a USB-C hub; usbhid probe blocks hub_wq
> for 60 s

> 1. Is there a known issue with the BRIO stopping to answer control
>    transfers shortly after enumeration (with the usbhid probe being
> only
>    the first request that waits)? Would a quirk (e.g.
>    USB_QUIRK_DELAY_CTRL_MSG for 046d:085e, or an snd-usb-audio
>    control-message delay) be worth testing? Ignoring the HID interface
>    alone does not help.

No similar issues are known to me.

Go ahead and test any quirks you think might be relevant.  As for 
whether that will be worthwhile -- who knows?

> 2. Can the kernel recover from a device that stops answering control
>    requests during probe without blocking hub_wq for every interface in
>    turn?

No.  The reason is because the device might stop answering requests on 
one interface only, but go on answering them on other interfaces.  One 
non-working interface shouldn't prevent other interfaces from being 
probed, if they might be working.

Alan Stern
