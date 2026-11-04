Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793763535;
	b=fclULdSO1UZ6LHFgDSbNGYkSl0OlJR5+wz6jSkA9mTGOs6hl6NUFTDbM7V0DS0vQeRxh
	 t3AQguJv5CZq9On/CN7k7GElDCEhzeGNPR9cUpZdud94L8mHZpn6yYE/dOnFYFA6fBVql
	 sul7eyS5U0Sks75Z26JpajG8qfjV/TReac3Aad9XZ+ZBIxGm1j8vyoBGpo4PS8KbNTbwz
	 2E6bY+ElPo4xN6U7rHF3i/KR7mPLtgmUpypl+uEmVmf+yaXhPbpkV7DKTm5R7+8riyxd3
	 Ndcn4PK97tP7U00K4cDreQYZnovQcmEDTDPSVoCqjrI5/E2LX2eiPvmNuLxW5fpjM2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793763535;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:From:
	 To:Cc:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Content-Disposition;
	bh=rvyyEItMjhpjcCiR5G2iyawMRAc8IGNvunoyBM1eU1k=;
	b=Yn9OLKd1uskRAprmJkhTXbicDYG0cmLyovf7bZX5gItUqHwuGDLL5aaVA4nYXExRTb1E
	 iPUC4OWbBWHHaBO3bJMBvI9G8y+G8KAe8hR44zrRzBPxYKy7EzwhFZFCAOTgzVU2/iArV
	 XYH2ChIrfcOhPr/MAUH2mJ2Qs4AWCbkI3iKXg6HedmZWO4ay3kbiLEkZNdhiqjcmXXK2V
	 ckuFgo2SmvD4v+v/L08ltRfVq8uSPif/y4qxY1xAjKJoewK5r5Qe2IKXy5ktTtuMRBhvk
	 YvU1uvMVjyLLw5kpuTBRU6ZPkF2XUtVqLt1T3ddxkra10knsVUeceBtMzX/6599mzpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IMnGGHbZ;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1250D606A329
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 03:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1250D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IMnGGHbZ
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36cedf1bd63so156374eec.1
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2026 19:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793763534; x=1794368334; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rvyyEItMjhpjcCiR5G2iyawMRAc8IGNvunoyBM1eU1k=;
        b=IMnGGHbZfzS4ZMXl77G8FzBSzJN04aU4eLBtXEhq2+SM14tDfaYWKhh4FUKDjtRN1m
         8pUDfwsP/9AEG+JbxPf7bWMErkI8kLMWHa6yJqshjWAjwwoOkWajG5XMDxrXrs1xbF3r
         dgcH9WRjJ+Ls85cyHl8GjtuQw+we8F0IOvFL67s/MVpuRJ5Tq7QwYJ6GWKzGTYYBrnh2
         QpL+mk1HCYGFhnhPXf3sPUWhs/FbqLyVStAk4oGTEyfH2DMGI7KrFY4BHXscStSUB5P5
         2sFhgObS9Qru4z9ZkapYnlJo1FaEmHXb36SAUivo6oEGOWOrIB/vE0HVinok4jg5WfXW
         62vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793763534; x=1794368334;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rvyyEItMjhpjcCiR5G2iyawMRAc8IGNvunoyBM1eU1k=;
        b=oaXhMEO0RpJSaKgo52Bo/Ll7zADuQ/XPz2zyqv7KS0X3x+Tr/F7KJPEaxI4tUjUx2P
         TNznLuan8MA0UH/z57ICYsCdpa9sFv7RI7whU9FB3yqZbF0eThLat2bzmlTq3ALAcoIs
         e7U/t135ue3OXt6+4kfOkgolRs+Weo5GP9h24iIwz4ZZGm8fYmpoKRLhU9GqmNkWTbsT
         vVTy8mEdbHSSdhX7FEdOYKLp1xAJfd8HqG5qJBugdB7pHU90fzM7sPyEF8Jx+GcBn5tp
         2AI3oyPo6rZpJwNVdKH/+4D90kPzUb6vp+z+wELsKKlZJVbQUellbVAhwghHGccerSuo
         CUqQ==
X-Gm-Message-State: APuU4Z9zg9LUIYVID835fwHi9nuJYmQa2dzKp94pP1Hh+Wna2I7jqD9B
	8k+5/STl46TB6XAaa28KkaoIyaz37bSSTFF1ncC5vy/CsdEiXSBPFNaN
X-Gm-Gg: AYBFou1fBbtUFDG0Sti1KNG98lHClUvVr31SwrZOAl94FTevrqaWhiwT2S1gYelhdhM
	KSsE4IWQVAXNWvpSkDN1nVYeuhgbG+c/euiYMRZW90HlRlT66fV/WlGnZoMI1iNvZCkNZXosmLe
	gzpslYNsEI34PajK5ibB9K9hyrX43KkWrX1m/d2FeTyzwqLcfxC/CDFUYPMd9kc686OLRC56YYk
	WZKs2sg1X/AcpnpC7PUuHEcbfQcr6xkPOsfxDsLToeApiGeWwSQJ6hbo6EoEx03czVtxNtcyjK0
	pebVYMMoPQ6n0AAcHTNUK2ScEPZEe0lHHSv+PHYvrL8VLP0PWTt8k4vhoR0ec0zj4Zw7VueHTjd
	hfRKUclru3qJZIoljkvVhfZvq0HP0LoD0mJYDplEUnrX6rQsFU4N87QQ/Zq4fFKgRMk+8WCUeUu
	q8wD4ItUY5+ynBIu3tPJrIV7SUf8LLixuHhMenOfHAWTOopKkxqBWIZIc6aN/wvRx4hMoYv2Yp0
	Lqnu8HxtHJ17x6jEptjGNPtLPyPeA13aYiRLm4VXPRjr2FrOT68PGzhwbgjFVGQJ6t5cfbh4lh5
	RT9XTftoFpU1uj087GSHzRyTiKqO05hcEKaoR6ghV7xE6wsS4D4dZLzJ2z/wtTAwkUJZ
X-Received: by 2002:a05:7300:f80e:b0:36c:98e5:a6c1 with SMTP id 5a478bee46e88-36c98e5ad0dmr4158661eec.19.1793763534132;
        Tue, 03 Nov 2026 19:38:54 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:88b4:22ec:d621:c1b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3981ff0sm3310812eec.24.2026.11.03.19.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 19:38:53 -0800 (PST)
Date: Tue, 03 Nov 2026 19:38:52 -0800
Message-ID: <8063a24bb9f75bb9096c947d8ffa7123@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Input: joydev - avoid signed overflow in the broken-axis correction
In-Reply-To: <20261103085514.431010-1-zhugl3@xiaopeng.com>
References: <20261103084135.426629-2-zhugl3@xiaopeng.com> <20261103085514.431010-1-zhugl3@xiaopeng.com>
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

Hi Guanglei,

On Tue, Nov 03, 2026 at 04:55:14PM +0800, Guanglei Zhu wrote:
> The JS_CORR_BROKEN correction multiplies two user-controlled 32-bit
> values before shifting and clamping the result:
...
> -	case JS_CORR_BROKEN:
> -		value = value > corr->coef[0] ? (value < corr->coef[1] ? 0 :
> -			((corr->coef[3] * (value - corr->coef[1])) >> 14)) :
> -			((corr->coef[2] * (value - corr->coef[0])) >> 14);
> +	case JS_CORR_BROKEN: {
> +		s64 tmp = value > corr->coef[0] ?
> +			(value < corr->coef[1] ? 0 :
> +			 (s64)corr->coef[3] * ((s64)value - corr->coef[1])) :
> +			(s64)corr->coef[2] * ((s64)value - corr->coef[0]);
> +
> +		value = clamp_t(s64, tmp >> 14, -32767, 32767);
>  		break;
> +	}

Assigning to value and breaking out of the switch causes value to be
clamped a second time at the end of joydev_correct(). Also, pre-converting
value to s64 and replacing the nested ternary with if/else statements
avoids all the explicit (s64) casts and returns 0 immediately when the
input is in the deadzone:

static int joydev_correct(int value, struct js_corr *corr)
{
	s64 v64;

	switch (corr->type) {
	case JS_CORR_NONE:
		return clamp(value, -32767, 32767);

	case JS_CORR_BROKEN:
		v64 = value;
		if (value < corr->coef[0])
			v64 = (v64 - corr->coef[0]) * corr->coef[2];
		else if (value > corr->coef[0] && value > corr->coef[1])
			v64 = (v64 - corr->coef[1]) * corr->coef[3];
		else
			return 0;

		return clamp_val(v64 >> 14, -32767, 32767);

	default:
		return 0;
	}
}

Also, please note that the kernel builds with -fno-strict-overflow, so
signed overflow is defined as two's-complement wraparound rather than
compiler undefined behavior, and please drop Fixes and Cc: stable as
this only affects synthetic coefficients passed via JSIOCSCORR.

Thanks.

-- 
Dmitry
