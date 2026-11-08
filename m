Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794112008;
	b=b+cr+inrPo3jGHD35vdYdIO4jwF5Xb5ox5SPmJLRHdQ4DEotXhyutHeFIcVUvbf5SNVs
	 5uq7JYvgaz0pFwxwnGwG3sqfneRZ4rlYLY6tuzrQYUbEQOfBK5FPZSN4Fi8Iz4cLmxxa5
	 +O+kmMYbB5pExw8EzkoZjP1lNP2k6U/uHISPGBvEveC8Vplu/OvNeuY3rYj9cZbKo4rWw
	 CcMb9ZRAqAF1i6VTuttlWFJjHh0gb/a5ftCZL1uFgb+Pr146pyO/7divEdTZzbGBO0O7u
	 V7RKLhSwh4UJ387MNlREOUQnLO5uk4GDGwss5ALu8Ip6unZ1frYc+pIF+fD/O+65Z8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794112008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=AiM+LPeAW+0kbmk+BQ1RmFOTod2teJOvZsGbeHlaw4g=;
	b=4sVlAjGoSYRM15C06NgM7/LeWxAird0DJqJvFLArr+OGefnAWhC8mi4md1dkoJ022ov2
	 6J3gDcm5j6NSM+doY4R+1zcF/lK4wRW3MSP2Kr7+Zt3K9zNCfe7zRzL+GdZ/MFl7PW4KX
	 cINcimywMpL6dl3NHkLGLguYwo0XgaT1HBo2Z8C24e+MgzSS3WP0fCH0Yit/A///sjd5k
	 up1gtQ9s9MQ80Q2s5FH0YCsxpaTgtlutckAZvRCnATeIuM8zcOT4gqvOd8bRzuA6RpR4o
	 ixO0SOpR6jpHlh7EWYhrC6CRCiwyUtC11QK8p/Q1CtOxEAhn1tirkg/xB+L/FlwCU+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jFzdKciB;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6D6606A31C
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 04:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD6D6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jFzdKciB
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36f8cdd30beso503701eec.1
        for <linux-input@vger.kernel.org>; Sat, 07 Nov 2026 20:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794112007; x=1794716807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AiM+LPeAW+0kbmk+BQ1RmFOTod2teJOvZsGbeHlaw4g=;
        b=jFzdKciBfSGwXz56NKPGSVznZX8U7LUlUXxCQ1T42+qxNK8/F8FxEYDSGXj/IGh/m6
         oSUtim8njzpW4+lf7ekqtnpm9qWX+LdlVbuyQmxeSF3V39VY9qGpFGdU4j83/HP/2XH3
         l4u7zJdgN0nC2+mCAVVazZu3pU75lBWkOqougha1r4Zm6EWc+RS1b5GqBnSpmDvN+wBp
         Z6ZRFQrM9Dt5lc0qs7aGwSNYdVlm79D1+rzBRP9l2Rqi+hV0clMamOMI9SCgWjCVTgrS
         sB+1aEHbZmfIKxE3ZgzmHwwH5yxwM36Bj6WDnIZFvqrEq2mw9ZWdAL1kanExgPx3NhcR
         thyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794112007; x=1794716807;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AiM+LPeAW+0kbmk+BQ1RmFOTod2teJOvZsGbeHlaw4g=;
        b=k6ljmzyBUaId0MR3UUnisEOtscMuPGpS1xjv4q1ReZtzNFZCstZqr/kbKlo6d0e9+F
         vIW90Rbndce+cys98ualOjsRY0hPE6U8lY5HiSq4IHAxHG/Z+E2d1dVMqLO4NwwcqDlK
         CEIW/v835ERV/XmVq+IYAHuekoDGxG6MK3XV4WeJevPtCke6LzcSk5nY1OaK1tkVEYkv
         WMImqX0DOy0R99N6KMfg6fA8lvIY34EcYm7ZOpIDLgcFFX3vV+SvGAqtFnB1OVL7Be3u
         r6bEhmEWi4TzgdU0MUebFiOHP5LrFa4DJKa1nDoCg0kXPRsL4T8hJvzxvQCaCj9mksJf
         IwDw==
X-Forwarded-Encrypted: i=1; AL+hErHaYrzswIXFh3a9ovJlFzLh5CwU60vi7FAIgesAx/6Xba44OK95ZuPX+3puDBqFF4EWdQy6Z9+ybmJtlQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9mSNVPEXknp8/lEaBlS/uEOUdHxCj5GP3xmKIKIUuh0HRba42S
	GOY/9afGlfDPZc74R5X35p7FobBHkPtIvOBmc5LromPiEwBtH/i8xf8Y
X-Gm-Gg: AYBFou0xtkw9I/3u1xbjPjgQcN4l4PrC9Wy4nju7CvCvHxrceV5njw+BS2cfnSMLyP8
	yC2jcyhfhnRyHxxnSTrWLwoHijPZ/W7adncpTCTjRbMIrv9LTiJt7VqEnFgAGYwQXTIw4TXf4sQ
	KiqnvurQZFwEttDiwaovJdad/VUwZ4l6eAVSwT0nNvGRYqX32AvBngpcnXQRspNq5/bxPqdlwDk
	V2SOAnoTOPBaCNYOMsxEQHagZBNR3KgjwKkfve3Bld62UjmKFNwadNm7GUaif+/qWTeF2M3x0h3
	jDfpJAV//chL8+X6gc/5K2p0GbSSN8CQfLp8txEGpyhww+SsKmIlaqsRQ3731R00utmyFIoemsl
	1APuAyi1eivpXtzOJHwy8EJSRjPf57cCkmCdx64MBExCjYh4jlcgqna+J05fF8zPqQH6U0DGl4J
	EgBLY+DmX/Lt1Nwh2ENoT1SR/GnFzg8fSAn9Aje8xD3ntuDoz0PDAkn+pgSHRVmIGlJ5fNtUtR9
	jDe8+GI7/0ERtymabUb5TFA8WsqxHwaaTQxXLkrEZMtLzPopyZwuW/+wKhoDdbHv7cdAfsJGjjt
	cbUrECcHUkX9wPtdVBEUeBiodVS3U158TStprec0cBWZWBwgNoo93r5GiMoUMCIpvV5Z
X-Received: by 2002:a05:7301:b96:b0:366:dbf9:32bd with SMTP id 5a478bee46e88-3725d77d5f0mr1214989eec.9.1794112006772;
        Sat, 07 Nov 2026 20:26:46 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:5a4:1cb9:242d:4f00])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372667d6088sm2650583eec.25.2026.11.07.20.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 20:26:46 -0800 (PST)
Date: Sat, 7 Nov 2026 20:26:43 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Thorsten Blum <blum@kernel.org>
Cc: Dmitry Torokhov <dtor@insightbb.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: amijoy - fix memory region leak on
 registration failure
Message-ID: <au_5_1B_OVWQVau-@google.com>
References: <20261108004952.394691-3-blum@kernel.org>
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
In-Reply-To: <20261108004952.394691-3-blum@kernel.org>

On Sun, Nov 08, 2026 at 01:49:52AM +0100, Thorsten Blum wrote:
> If input_register_device() fails in amijoy_init(), release the memory
> region for the current port before cleaning up the previously registered
> ports.
> 
> Consolidate the error paths while at it.
> 
> Fixes: 127278ce2254 ("Input: joysticks - handle errors when registering input devices")
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Applied, thank you.

-- 
Dmitry
