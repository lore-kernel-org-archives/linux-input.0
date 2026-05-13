Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFDF375AB5
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 21:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778707670; cv=none; b=iTBDQzhZ3D1mq7xEDrRb0D6MRu/cLGeVyX2sjCudjFhEyQbNJ04432JCxkvR7P0hI6AxNEwi4tN+sfoOLd66hikTq7L3EYllkAb+RiibEwyDJOYT8gj5wV5aHeZNGzl9jBkXe15Yq7f/lex48NGgMyUnb8PZPbo1n7k9XsurS24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778707670; c=relaxed/simple;
	bh=IkLVxbIxtoX7x8zmZe3rgwTgrCgejw26yFvR4NKkVfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfwurAnu/entAX69UizNyomJsNAbYCw5vJqk+oMv1+/+m5kq9Pw1Q7/1GFa9HN5qliTLN5QS/2W3LoIBx8Q0hLc9xZLYGiBDfXz6JYvLjQcAxpcGJRCA8R18H5Wly7W+eeqf6R1BjhVtjcT7VZexnnBMxxQPy6moyAu6OKepmCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHU0mptp; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHU0mptp"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b4520f6b32so12341553eec.0
        for <linux-input@vger.kernel.org>; Wed, 13 May 2026 14:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778707669; x=1779312469; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a+XteDkE+wxHWucZvCRyQds297KtxSoUYMihllinTGQ=;
        b=JHU0mptp2STQtAaPlewuKKWaJKd8NV5DNbCmnXqjRlx1uhi36MsDgPwIuKhaPqjoBn
         WwydYB1bnEm/AiEaic1kUzuKx/+j0wvCFnsowVcoaj0ohw9dkxP2tZYsGHRq9MvuWOuo
         mRFin6p3SwI6FqhW2jtLfgoppieFxdS++MMBjy1MbAUm/KOUBsorZrA4v3RkisdoiTTn
         q3Oe2mDEB2w8KGPcszLlxLusBMMfhfFGhxA5LDtzReLHUdo1bPEFkpIFRw1Vqj2gOGGC
         js9RccnA3aFpvVT7X7TuzvIMTsGUeV8VWB9A8cXPfb7Dgm3YN1/lT34cznmDuzzZA6Ii
         tliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778707669; x=1779312469;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+XteDkE+wxHWucZvCRyQds297KtxSoUYMihllinTGQ=;
        b=sn5b/wdtdY+5IxfejQUxPheWJLO8jIcerf9dLMcuIqnMllX3PKMgDQ6ESKTxjL18d4
         uiOJ+AS42qfy59ZqwpntcDo7sXOb575RS9UzmpII1PJAhO8Un4Yhfd3wwowS/nySK79N
         MQQ4crWLBfbHjgjdwPbPbdx0WBqT1Xiw7xf+/Be4NDYyx9lFhTVe+yIe9v0hv88ENnkk
         8xfgbKtGsxnXhrIbZo5SOwA4ismrAPemgwGG8Ja8VdchmMGWm82oJwC7PfIK742b+rJU
         LDRZ0+Snv5imcf2JFt0oRaKHftzkcZhLkl5UCWc4BemMyLMRSjhHOz3qhRy2GiHCkzyV
         VAPg==
X-Gm-Message-State: AOJu0Yz/sJjMZyZUdxI0prphWxEVP7Wsa5IbnQj6cCRYmeqqE/KiH0xq
	5yZ1yC5zjVX9hAo0ckYKJYpxYlbnPZlIK95/qreMfAi4Kkrt6Powi2ICGTJWuQ==
X-Gm-Gg: Acq92OHI1KEFWWEBDEeyjdoAw5VeDozdVkuAZL2ATZXgKooTTGLEfYQm26iLMsCuLLY
	VfHlLpXyY+7HeWoSIy48Vjoudh9Khfv96pF+sVlsgdNXxLaXi7KJeTMqwk8skd98EOBaC6sF3Gk
	TSPCJvKfR673jUBEXblLDK9g2hrH+lT0IBhDrcW8GoR5VPGodUv4oMBZSnK9ELrXWfM7mjoFF1v
	6+vkfOsPYq1/yE3W+EjA1iJx2YH2jyQ9lXpGZ2C+ephgCcsqbUW44TWhMhwvClUJWvFwi7cH5ya
	r5zrMrjcS2ZFImbCIGcLsyX3zKwNvYa5XKlnPCdVtmzeQmTbYLGmNAI4lzXLOAuDofk8SiEysOv
	FeYw5dCCcJ+7iit8i40/IV5c0OEPXwDqqkoX+bk97fnXw9pvv434YAUaAU+Kw7sl4Smq0HnW1D/
	6RlT1uCU1Vi/L9CiTC0TonKKL6INK3qlg/GeER8G/EdqgvgHN7mrGx5PZIzDMSWjYd
X-Received: by 2002:a05:7301:608c:b0:2da:45f8:1b41 with SMTP id 5a478bee46e88-30155f2ffdcmr2650005eec.19.1778707668651;
        Wed, 13 May 2026 14:27:48 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e25b:b38f:c027:f0cb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bbd50sm515390eec.20.2026.05.13.14.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 14:27:48 -0700 (PDT)
Date: Wed, 13 May 2026 14:27:44 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: contacto@bazaes.cl
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: synaptics - add LEN2058 to SMBus passlist for
 ThinkPad E490
Message-ID: <agTso46UcMSGaIYx@google.com>
References: <20260513045749.185969-1-contacto@bazaes.cl>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260513045749.185969-1-contacto@bazaes.cl>

On Wed, May 13, 2026 at 12:57:44AM -0400, contacto@bazaes.cl wrote:
> From: Nicolás Bazaes <contacto@bazaes.cl>
> 
> The Lenovo ThinkPad E490 (PNP ID: LEN2058) has a Synaptics TM3471-020
> touchpad that supports SMBus/RMI4 mode but is not listed in
> smbus_pnp_ids[]. Without this entry, psmouse ignores the
> synaptics_intertouch parameter and falls back to PS/2 mode even when
> explicitly requested.
> 
> Adding LEN2058 to the passlist enables RMI4 over SMBus, which provides
> better multitouch support and matches the behavior of similar ThinkPad
> models already in the list (E480/LEN2054, E580/LEN2055).
> 
> Tested on ThinkPad E490 with kernel 7.0.5-zen1 and Arch Linux.
> 
> Signed-off-by: Nicolás Bazaes <contacto@bazaes.cl>
> Assisted-by: Claude <claude.ai>

Thank you for the patch. From checkpatch.pl:

WARNING: Assisted-by expects 'AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]' format

Thanks.

-- 
Dmitry
