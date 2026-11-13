Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584910;
	b=Or8mafWRHIKGaoQ1E5DJxoWtwgziwmRlKEqyTMVzuTKFoxiLCrgz3+4ErCF1TIBVycWx
	 Q+tUySzjWzPa8beoCUxnxZbXus3lvoCLi3TQzK7e885upL8BDZa8oPvkLck8ifqjuShRH
	 k+XO0zlXNhAx1NJ56xn0m+SAOEYTdRqBIyiXcgO2CCR4Ka6UNhi4VFh9MkloJOvd1OQ5g
	 H322PzLjA+In9sD8zQw9WzjZiumoO1u75Wyaay3yC897dL3IqLdkTsNDw1y0FCCoDVzdR
	 XaaSwEtiYae1lZlo/gze7jBvD/KsFkLIMoqEvt2ZUWhLMU+0Anq/AvbeZjL0CuFG++w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=4JQ8+H0JmbBf+PQButIDd4R/MJa+hAkJuZe6gYLdONM=;
	b=fPmmWnsBKlQo/tsx5iCovKMsXRr7HW7SmIR3QjM4+qhwtdbRDVlUi+ebNtuv3JKuAeuo
	 Zp/98LNfrQdc2CByFy/ZbtmR5Y5ufDWlrQb7Ubn+6O9Qu7cFYQknFRX6EgdIJSPVjIQEX
	 GY+9YUBqb6USm7OVqdoOW4imA4WsQtE6X98pHEb1D3ey27SH+lz1+AF3xKvf4fMcN0z+Y
	 J+SRU8jdjPsqTS3fNBPw72/7wgvZMMdAjJgZZX+ywOvAAebBr1fJ3z+uUMXrq617Rnfjd
	 6KNdROetysPruwitkdygiMXUdzBYl3sjDTXGUc/GARGMJ9lqVIQCysxPtN+RglE4ToA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HxTPZOZ1;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFDB606A331
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 15:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AFDB606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HxTPZOZ1
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1b244fb7fffso1145505c88.1
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 07:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794584909; x=1795189709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4JQ8+H0JmbBf+PQButIDd4R/MJa+hAkJuZe6gYLdONM=;
        b=HxTPZOZ1wdaQhJWrsAQGtyl1XKuZIm6V7/EM8G/h/K8YvOCiU6viMxkydeV3VpaeII
         kPaJzNl67Ki1bJd2U02hqCO3RZK8HuRkI8goikQ972Ac1umrpqeDa9PDXBtyHoFvaCDa
         EexRARJvUXFIuoGWo3LuQEf+pp/NxyZ3rXGjzn3RQueltc3D3m9hY0ZBFYXUMcKFj6di
         wpwWUcBpvOFEbNx8e09PlrYodBE6RSw5V6trVfQM92nJtAjF/1e56uCejMaUBYwQq0xx
         AtqKpIpzm3imbjqSuVxbsxB/uD0FuWGhj7j7KxumDigQ3yELfKsEtgy2n3US5HJep4ig
         wn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794584909; x=1795189709;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4JQ8+H0JmbBf+PQButIDd4R/MJa+hAkJuZe6gYLdONM=;
        b=bUBml5MFNR7fxwcqQ/N+eVck4S7yPFRWsoDrLkZg/eS2TyfTkV/pS2BXMfSWcmXR4v
         c76lLzgroBVuJ+BHYKXCb/OTzCmU5tyXqrL5OFyjjKnLC+8NyrxfqeSDYbeGA0r+ZevY
         z0Q6o3gAJ4hwaDJb4Z/Zc3WqxFAWdWwLLuI15IJISMmt3ACi3imEaB4SUFuCq656o+kd
         4Wi7p7KZR/j7oZkWxD59tfPuPUICZLlwga+od5s+FKVJ/rd16+XWgUeSdbwlFaApPG8V
         S/53RSryGzlzG0vb5l8fTaGhEy3cthWQ6gmyulleIUe3iEuzFnVohDoNwkmoTaVqvUY8
         GeBg==
X-Forwarded-Encrypted: i=1; AL+hErEN6S4tejkngRVyBo4QnSGWnW8jtPRwxuzMsemlYSEPxAwNPfP66/PtowUTSGgOGEPt2kHuAFRZSERzhw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Z33JyIQexh6CSOoZe6OOeQWqQdid7gXO033H+uMpSDSeobM/T
	nuaHdxRp9PLbU/8QDjDPJEwBOr/cEWv0L1sVYTxloVIpNG+8ZMiNYs8M
X-Gm-Gg: AYBFou0nF07sxF89HisVTMApm6Mi9FHrNP02EYTkAqQdkMh/QToFzxx0TrzW2N4lr5j
	cdh2JPY06KI1sw9V13VV9LhJjBND86FUo4sEz/n3CUpm75BH9RQ1cM1s9lNMr2fGBLXPJyRQKKo
	6vdwFIWVfYB1BDbD129KiIkZ4MJu5gS/BuaTBbD7pTfYOZwWZwMquoj24pFIvFvVECLOGXdO2u3
	HjqA2xsZ6wpY4sRX3J3qNY43JTsRftLWGbxA0l58U8eoUcAdOyJTOkl7o+qTwcOHT7o2lA50STe
	/cAL/eig6ziQDiFjr2Q9rRRanVQmu/OtWo1w+f84tCuid0X8kluric0bJaGZ+mri2zL9ihyA9Ry
	w0EfFNJINF2h4Wwq64Kit50VHoaanCUqPlHJaXfQ/ZhcBu/UUKRRCBcEpp+QxeP+6Smn6SIpLqz
	9QoIr328ewGFgHT86TPpibuNXGDqBtybGigjgIZAvLK6uB5mQcRm+jES/3l7VKJW/QcIGKpi8xE
	y1ZFIiLt4qfADUIC6/RHDDac5kLLL6BShJs096AcFxXuVYQ7VygTHc0fDI7CG7ckcvjL3SWNi5r
	ZAH1RW2KmziGQCJ1BeofoL+QQsPr5y16eQyy3Aakne4MhMFv/Vpj7KJfXxSTfaF2J5hM8Cg=
X-Received: by 2002:a05:7022:f905:b0:1a6:53cc:7454 with SMTP id a92af1059eb24-1b50311d32amr2553855c88.27.1794584909005;
        Fri, 13 Nov 2026 07:48:29 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:48f1:7a0b:9bfb:4205])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b505b5bf76sm5641828c88.10.2026.11.13.07.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:48:28 -0800 (PST)
Date: Fri, 13 Nov 2026 07:48:25 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Eliav Farber <farbere@amazon.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Armin Wolf <W_Armin@gmx.de>, Sebastian Reichel <sre@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/7] Input: adp5585: use
 devm_blocking_notifier_chain_register()
Message-ID: <avcxRXFG57_mWX_P@google.com>
References: <20261113104218.32566-1-farbere@amazon.com>
 <20261113104218.32566-3-farbere@amazon.com>
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
In-Reply-To: <20261113104218.32566-3-farbere@amazon.com>

On Fri, Nov 13, 2026 at 10:42:04AM +0000, Eliav Farber wrote:
> Replace the blocking_notifier_chain_register() +
> devm_add_action_or_reset() pattern with a single call to
> devm_blocking_notifier_chain_register(), removing the
> adp5585_keys_unreg_notifier() callback.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied, thank you.

-- 
Dmitry
