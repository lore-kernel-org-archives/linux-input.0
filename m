Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDA172621
	for <linux-input@vger.kernel.org>; Thu, 19 Feb 2026 02:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771469050; cv=none; b=K0BNc3DTYrshGQiYjlGt1Ixo2Jz9Zr6CyMEiq42qlp49VXarOnWSw/q7n7XIfNuE3IJjAwFpA8hEno3/VWqbwKWdcbKaUzsJXVeMqM8kgotk7M+TcHOocmbA7IMqBbkrCpPY1JoAP1/V1MqeZ+D5LTRW9zbqopag+sZDchfThX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771469050; c=relaxed/simple;
	bh=vktJ3im/6OPBRManBVUO0BprXANEX5kKIlc9w4qNznA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uY8ciCmpfWIXBDTJTJSeQubBl1he7X9QMU4jWfyBb1puTrq4oBw7fT49u6SlrNX7jfG9WnRR1539fQJK+Q95hOxfCoDafmb5oEPWp/bNBSJNSHv2eGmpafmYgxidDVBnu9Ilt0p6X2/DznqVuk7xd4Z562pHm73s6R3af3Ag6fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbLr02Ur; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbLr02Ur"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12732165d1eso494573c88.1
        for <linux-input@vger.kernel.org>; Wed, 18 Feb 2026 18:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771469048; x=1772073848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fvBcEx0da8ba/Dg774YzM71+VsStxzft++u/8tHeW2k=;
        b=LbLr02UrGpn4X9bI35IVUAYpw2c8o85N2ozS0m1CaWcpyBHjrXqJlE3YvGh4LZXAfh
         jX93PkPmeqfUX70rX6zu54JdCXBBBR1+/kFYzdIVLuuIro2N5AmvICg6H3KvlONBkFKY
         rQzy30aG+VmknpKXduIOpwmJtwmCSQ1OG9Vo1I06fIjNCHkDwjehW2LD9aXIFTz4AEgW
         vZvt9gHmJVM4rLzzeS4H54uax8HK6SW8SU/syz1UaQoXUTJmaaY2+MgiLXuzM5eyE4uW
         HjjcLKJlzVee41El5ehtEKuCKk7YNAICCxMHZLO1nNpfjTV+S1KUdtKXViVBeu+tAIxG
         3CoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771469048; x=1772073848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvBcEx0da8ba/Dg774YzM71+VsStxzft++u/8tHeW2k=;
        b=d6E7tiTnOFsxsTjaC6XEtQe/s2y4J2RHhlhvVGYGqg2kyVAzJJlxWpyCeszqzo6Nao
         Tr2958Kk56QAVn1qusAaolQMV5wYh/JoEfdW9rlKet7rNDNl2I67o/ET87kaJSYSmxoP
         ZPlKTCppHy0TIvX03Z/Yp1MADaUDvHM+wX97n61fdlwQSgEmnZFxHl09YXVklIY3iRUt
         X0W6eUdS5dpE6vX4TSGt8QnTEJHKRJ+XQCS7nCIRk3DVfeOvgvT0JUxRb+NY3gAn8dPE
         2AxMrHEDaL2M0JEbwKk8gjSFrwzf5YA6rFaM15WX7nmtJl0UR7708WCF6Yi34LV8ovpg
         kfgA==
X-Gm-Message-State: AOJu0YwfQ5IUjcpG+w/Ur09S1UG1mGtb5woFfjkcvglLoYkSW49PYvVw
	7SPLv9AlKwNzB45PiIo3Rax6NyTqI2wt5wC4eI8LoC6FcvpaN2BFzzRV
X-Gm-Gg: AZuq6aI1xUFFPP1SoJ3mp+j/5lwT6oPXGK/AHF+hbPLS+CVpCp/MaN7Qpq9xS9TDAi4
	UZjQ1Tgj/JHAo0E14xMriUGCCH9CdYXpyxbUUkhAJu2XAIhEeCzgXtuB63kdV3kVxBr5iOT24/T
	eQ8UeeT870mpw/K4S4YS5Rzr3i1x61qI0x8tCZAzqanahpS+28O9AFaa6DnUyu2xXvNUOBdd8XL
	S17Mkn9YV8Uznf3jsGKgUWm3lKXe+a7OaONerzsRjq3jSaWr+FXBM0JqihjtrB3LfwvKpRKOJJX
	7XN4Ih12C2e0hHXLn7eExa5YJRRvg/4CnrNxViAIzfMI9ZzKxJ7/jo8DQWsg2ZmZgGDW5YHhCNL
	On5WjI5hlW+meu/oGUUi1V+D+vAE3M29e0jygAWCrLuR8CUqlnFD+F/HIfhiHJnuG4BIJuiPIfv
	P9pGPkhPDXS5PFMBecopgd+AFqV8q9qpso9Y8YezP9rmmXWTzA5DvobutRtT91Kg9c
X-Received: by 2002:a05:7022:49c:b0:124:9acd:3c4b with SMTP id a92af1059eb24-12759a73eb5mr1832252c88.42.1771469048225;
        Wed, 18 Feb 2026 18:44:08 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:265b:f5ad:9e03:677e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742c64282sm27350581c88.5.2026.02.18.18.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 18:44:07 -0800 (PST)
Date: Wed, 18 Feb 2026 18:44:05 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Yauhen Kharuzhy <jekhor@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v2 0/5] DRV260x: Support ACPI-enumerated devices
Message-ID: <aZZ412nKFcdMQJ1h@google.com>
References: <20260215141435.727872-1-jekhor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215141435.727872-1-jekhor@gmail.com>

On Sun, Feb 15, 2026 at 04:14:30PM +0200, Yauhen Kharuzhy wrote:
> Lenovo Yoga Book YB1-X90 and YB1-X91 tablets use haptics controllers
> DRV2604L. The X91 (Windows tablet) uses ACPI to define its configuration,
> such as I2C address and GPIO connections. The X90 (Android tablet)
> doesn't have it in the ACPI, but the device may be defined as an
> i2c_board in the x86-android-tablets driver.
> 
> To support these variants, add an ACPI matching table and add additional
> I2C IDs to the I2C matching table (the driver supports DRV2604(L),
> DRV2605(L) devices).
> 
> Also, implement a timeout for waiting for calibration,
> and fix the non-working suspend due to unbalanced regulator_disable() call.

Applied the series with a small modification in #4.

Thanks.

-- 
Dmitry
