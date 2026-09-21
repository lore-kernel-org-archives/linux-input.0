Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDF94BB28B
	for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790008807; cv=none; b=E/wIgKF8TGwIIdfeYXyU4p6FphT4HtCvcKGaeSPhj/aY91dEP8Ssay+BU+ng5db5YQEQpRBW0Jhrqz5e/nWZzEQTz679I4LLatrLDLLnUpfgrHz4zRlnV9affuGQ2GfkGcsPq8xQHow/Q6qJAYv/yJIUa7R3Z6x4PbdgGuihMVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790008807; c=relaxed/simple;
	bh=XCwOJrMJoxxz4JVKyaDvRNRGwW7+lwqfH0ZgZljnW2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7AecGQ7dVVL1/+wwLRf0+AYmW2canD41ocdF74+KhOEHv/JTvKVbN4yL9nGbJmNNYwMo4reJyt1ALZLDehaL9/XTX687CFgDCBYHoB2Q6IJPGCn4UWWzfc/Bk9tGyQfqTrbPMzGnVfEwnEqNc3SSG4FEz/FL6riy4nuE+bneuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMGHvcQX; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMGHvcQX"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea50dc1so1935402a12.0
        for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 09:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790008805; x=1790613605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0H4vlgkEZqik2DP4kSrSQqWycTFLemuL2Tj2cZSeHW4=;
        b=EMGHvcQXgOyUzw7okC+u+bwOw9n4YtdlBcxxDDP9KQJsiewEec4rT8JZEwhx/nbsyb
         dKBIRMA4FQcosgxyZF5ZoT30j5VXI2pyHR0v0hTPkoGlaC0c0BCEyz5IVWN4veaV/6BI
         slzGSslzKiyCQsv4ZHP3s2qUf1oYMb1D6049zsXlrHlNJul08V2KZLa4kQwIIIIIJHGS
         sTWZczqz7ehEwsX/+eLVwNJB4cNbS1lhfoidnBfPG0QmIIKWMibbEa1400olkca5+tB9
         iTTSCCxiVeFKi5Va+v4d4doPHoqOsd0MTCBdK0XOyHNpXny9r3c5gLjGEGvv2ywys5k6
         rPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790008805; x=1790613605;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0H4vlgkEZqik2DP4kSrSQqWycTFLemuL2Tj2cZSeHW4=;
        b=L63KwALqQI1/Jxz/dGbBF+JhlqTe3JLN/2/6Dgo/ty5XDzwcJOCFHBReAZ4GHe3cag
         mgFH3JVP5w1Rnd992LciXEmvsDnCUT7Gn9K9Oyw3aD0AIdasbPbXH9vXpOtyeLLbCuiD
         Qe00Q7VSdhMqibql36h6arAMMHv1kUwaXeAXjizyxmHUEKv/aGlbIO++uAMYEycdf1q6
         MEpFBgn8tBZXw/Sec568vhKYcqM9elnP89p2htWoo0aTnsk6uKS3RLTJWeY8gIINfAwY
         UUVqqDZZ33q/1bVMqCiObP/Vq224bo6sbiNaTwWxoVA6OEcKanJQJGxAJkUx7ijB+08c
         Mfig==
X-Forwarded-Encrypted: i=1; AKwUvBws4sPrqOUzHCeg0aJWbScCzmxY9zYhIxJZWj3v3+Pd15myu8ZmrUS6CIwy7Jcatm0IGi/bgTiN75/GLQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lDsgN30v9TbqPHxiBCK/JZojoTn0aZEJ/SgAi8QqQyPnnLyfqf
	reLQPnVDnLh+YcU5uocxosTzMPuUw4ZRfLq8u5f7gTUHNp8UJ/HOSybv
X-Gm-Gg: AYBFou0QH4inVu4TomzHkDOHN/ts1c4RSvQpT8gOU5r/YuyLnGFsC+TSVQG31wd/i3X
	b9ot2TR+0DJ0OwknxEobmbfy1N0UcdN4qMDqpbU4r+Jv2JtCdmyuTmE3nrKiaSge3C4KnNpBytU
	hp1d7yqx3V7s6DPGeagiZPjwbzAY1z3Kf4S9t51rjICYQcERVC9MfH2hutJEof6wnfWaalann9Y
	dwtqBtV3QdMIzlyCNiusDm89wz0MPVECnswBlXijSh3q/SM3LQFDyc1V91CbosQH884H71hRS3O
	FmcSNmNTIHFxSwsBuiAVtiHcxgpXAiOu9LtAI70l6HnLzVGHHS2S3yy3z7oOct0IlNrObdt2QAI
	Jc3Q6RY6CEigA1uk/LEzUBlpi7ZCz5xFytbRfGJA1Xyrjo1nA2qwGQAkkH/j+/ayLcRR4DxrhyK
	MhgDwjaMIiea42DQ+6kDJRlbJgrCieiVmTztQEWovNuzHhV07fbJ/XI928gSuQfxW6ks1NzIcK4
	YOMxf5cPplSu16jyI3UuPsa+Yyv5ZKRwyz/xH7m
X-Received: by 2002:a05:6a20:7f8a:b0:3d2:89db:1688 with SMTP id adf61e73a8af0-3dd8c3d3adcmr17913842637.2.1790008804824;
        Mon, 21 Sep 2026 09:40:04 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e1a7:4f7b:11d4:34fa])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331433besm32993952eec.16.2026.09.21.09.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 09:40:04 -0700 (PDT)
Date: Mon, 21 Sep 2026 09:40:00 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Zhang Heng <zhangheng@kylinos.cn>
Cc: cryolitia.pukngae@linux.dev, kees+treewide@kernel.org, 
	DongLin_Lyu@outlook.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: atkbd - rate-limit unknown key warnings
Message-ID: <arFZdtgmZXcK9k1V@google.com>
References: <20260921131934.677541-1-zhangheng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921131934.677541-1-zhangheng@kylinos.cn>

Hi Zhang,

On Mon, Sep 21, 2026 at 09:19:34PM +0800, Zhang Heng wrote:
> Replace dev_warn() with dev_warn_ratelimited() for unmapped scancode
> warnings, matching the existing rate-limited handling of spurious
> ACK/NAK events in the same function. 

I do not think this is needed. Unlike spurious NAK/ACKs pressing keys
are initiated by a person and events are naturally rate-limited.

The solution is to indeed map the key to do nothing:

	KEYBOARD_KEY_xx=unknown

Userspace ignores KEY_UNKNOWN events and there are no dmesg logs either.

Thanks.

-- 
Dmitry
