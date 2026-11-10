Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794277572;
	b=cFhRhQ/rnkL82YyhXYALtu3BeVCeB97B2YM/uZEe8qPqrybh4zt53s8/h0fTJu1lPMay
	 IyAbZloekcJHeCE3fCT71TmQdNzVNGBdveKWqJZ6S4MaRVovY//nAonLpDxPYtOXGE48+
	 T1Fw8hMS2mpOqnF81LtHnjFNaGXWhZMmYmAAnq/Fzs3tWQ+Rpnyxqje+juXtYUTOKIvC5
	 arZ60LvlWHeN3OmTXEGcjw+Y5mKEaKC8VJF+th7HFUJY6HZrF/uO0Y1parRtn45ibXeze
	 pc1e0l2ziusWbktJ2oqbMlPMJAtVEqZDw29z1TaSoCNXv8YbJS5O0OFhiZO1XCuMhMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794277572;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=nMXozHSfJxf2AvAMtoshFLuIIIU01l+UNOII+lpoa8A=;
	b=2Ie1jBSXvugLABMTq2LNMIn7daavsj7juHDxvQEBSWOGQfby5wmNP4V51zJmbh1mJ7pn
	 6zibfCxrmAbtfV9f0cwgR03KNUJnkMSen5XCqWm0UOC8T8YIN7pMuzIL5Bj2MJ+dLpiNb
	 MvOtL31Hh2Eq3uKIoBJhjCGGwdZPGXyCQ54uthwEaHASmYKXRkOxJ87gkD38fD90D9i1u
	 SYkOgzCwZ1a+ifXKuTVKwjx0mvyVqM/qZS2ipQw6323C0SKeXBm6EKrDL3pS5rpnDx3v4
	 xkItguz1gtEoyMTtaw4Scaa+ACQmrniWXC6nCMSRY/EqNMhkVddgvLdcXzeSu/ShJoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FX2fVbNe;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9E0606A31C
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 02:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F9E0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FX2fVbNe
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso2355314c88.1
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 18:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794277571; x=1794882371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nMXozHSfJxf2AvAMtoshFLuIIIU01l+UNOII+lpoa8A=;
        b=FX2fVbNeoet9tNqnAuC9GEH/7TT9G7rqH8VlPFwlBju9rj/G/2HAvWODd8cPiGy44L
         FAZHHgZnjBA1pLMi2MiD7vHLbzjf95YB0LR2q3VAp1R7/RV37wZkcIBexM+qO+OT0U/r
         RLw5PEnxaEnZ8ZU3mo2CniUlNQsDBNnKoYCyxR85/LNIxslu+yQGuwvFnaKLIQ75fG1U
         AK/IXhHrvDMQfZFbj5iqf/9+oPOnWekp0Cjy3LvY0lH1eZyB36/3AKI/8rPpaqZY3SIO
         omjKeBfgiPKhvBcZS11FEH/0ej1rGMS6BM4QSaU/lAzkYzpLxdkUskMp+21iCtebfe/6
         9rTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794277571; x=1794882371;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nMXozHSfJxf2AvAMtoshFLuIIIU01l+UNOII+lpoa8A=;
        b=MBpnpe471YZn4XxzEyWABf0DTs7cul49GJRyiW/x89LhoZXgzua2WUhRrX6Jv91rSY
         JR4vkccjRjXqI0mWOg+Ut9YXEkyzmtALLyUZmQ1p/u5FF4/lwVZjiDqpGgefPwdWxlcj
         a1n9dmWlP9PvwsN+ru4aytYLG6ewv5xY/BCPjrwB9jfSFBUK9rBgTbB6jg7z+wNQvonc
         IlnBOFf6We80pKNArsoebC9VyvZzfhXyVoSGiNjweFt+GMeleUXlGmT4tFm+8sXv/GVB
         VnsXMrzXUOfYVNRPrsZyGCfCPZL6L0lH/wM0B4pkuvHhTNb5+EEQNwg/Jgz6PEHIMjQx
         bwZA==
X-Forwarded-Encrypted: i=1; AL+hErE+wJmhZap8jAcI9BDXcbMpp084U4v4N1lZANfm4TgkbNf4WDpWMmjPkiVEE3yB/4/HguwCQltvnzZ8Rg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8kSWakxj3/AVnkjEm04vl3FGlMYQgfK0ivn3IGpR0bQkPZrhwn
	8n3TlCeEk2Ia/o5NDpmZbw94uV4C1uoQPLQSBxerZh81f2rOeCdOAQWQ
X-Gm-Gg: AYBFou20DBTa10Bwdq0ZlMrWIIZWsghXKnYwvhIVHqjqoYwpKD2Z1hcfGit3iWZrZSw
	UWnPybvVO8SQ/czOyU+7dBdhEYckUQRQlLoqQqyQX/T14dYyS0W/fXUO64rwdEguhCTqLS4TL/m
	3rhxb/WOpq2HsERo7v6BzNh26ucXvguPrzyMB7HcSXmaGey9iHIoIf9RoFOYYK8tbrKBFtEYY8T
	SHKolGpWchjTAdAqiYoOSqeMsEPzs0klt3Fa5oZDP7dDGZub+WbokZGoz8UJCHGQ7KJJNnSLo+c
	tWOlVfmderg+6Nk/AdeouNQGKgzsMcmp62S7YRTkTQtONrbVQwC187TK6750Jm2T2vMBqyHa+f4
	Cs3SJahTPiGnfM1BobP6IBdq8l3UtTfU+yJNliiRjXo1l60Gde3hKrLz4dOnPVq0PV3rE98BfoD
	VnNCO/hq0Dvw6Vl1AB2i2jt1Ptnnkz8WMvbi5WMiMJyQfWmM2mPielPwak4KG8TMUzaC657eCoA
	t3on4cMYbZ/M57H14/rpKugaPdmQMJKI1+a01CV+Hj/HA3lxizjFkJgponwev6YXJBUKYK0lUar
	VmzMvmwHSsr3Dvh+jGwIHTZccZ9muHehpWBhviIKqjzCftKkGvzQMh5LHOfb/ib951DXrw==
X-Received: by 2002:a05:7022:220a:b0:1a6:4679:6cf4 with SMTP id a92af1059eb24-1b3b603ef0dmr2264248c88.36.1794277571093;
        Mon, 09 Nov 2026 18:26:11 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:856b:460b:b522:14ec])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b4ecccsm2486079c88.13.2026.11.09.18.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 18:26:08 -0800 (PST)
Date: Mon, 9 Nov 2026 18:26:05 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: ivanverbovoy@gmail.com
Cc: Support Opensource <support.opensource@diasemi.com>, 
	Roy Im <roy.im.opensource@diasemi.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] Input: da7280 - do not advertise FF_GAIN
Message-ID: <avKAtJ8VJ7mL2gP4@google.com>
References: <20261109-da7280-fixes-v1-1-09cc3650261c@gmail.com>
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
In-Reply-To: <20261109-da7280-fixes-v1-1-09cc3650261c@gmail.com>

On Mon, Nov 09, 2026 at 07:15:55PM +0200, Ivan Verbovoy via B4 Relay wrote:
> From: Ivan Verbovoy <ivanverbovoy@gmail.com>
> 
> The driver sets FF_GAIN in the device's force feedback capabilities but
> provides no set_gain() callback. input_ff_event() checks the capability
> bit, not the callback, before calling ff->set_gain(), so an EV_FF/FF_GAIN
> event written to the event node by any process with write access to it
> calls through a NULL pointer.
> 
> The driver has no global gain to set: a constant effect carries its own
> level, and a periodic effect plays a pattern from the device's waveform
> memory. Drop FF_GAIN from the capabilities, so that input_ff_event()
> ignores such an event.
> 
> Fixes: cd3f609823a5 ("Input: new da7280 haptic driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ivan Verbovoy <ivanverbovoy@gmail.com>

Applied, thank you.

-- 
Dmitry
