Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA7E2FD7BE
	for <linux-input@vger.kernel.org>; Wed, 29 Apr 2026 19:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777490354; cv=none; b=HSAaO++D/PEsj2ndCgBDDMLcfvWmKARIEAVBKw1S3qRS2LlGN7C36ZRs2xlAyykxZsCe36V8LxS4ftzKE7fif8k4qYB2Zg0jdp6L8n8p2ANprrxlXjf7D+fmjIlzJid5BLWx7gCbgb3p9LHJ3iEh9vMEfV9IVVQ0scGPQXL6frw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777490354; c=relaxed/simple;
	bh=kE6z6ho481l3cRMIBg1rjaXuPr/oIN2dimR6vL3X4OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXBiY9UtvC6KjGQom/VsTNGfC3DGpLLwY2OYPHA3uApTablCsnh9DL/wEHeHcqiqAI8vbvaz8J8APd4QgRfxEqgNVuSlpHB8wSQBLsYxrH+bFDFCKjc1dBEQtREvHgOpb6LOXQq1P7Mpkz5sOfRhAjH/6Kt5XQF3vinm+gLYOcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYSnVTNF; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYSnVTNF"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12de530cbf1so353939c88.0
        for <linux-input@vger.kernel.org>; Wed, 29 Apr 2026 12:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777490353; x=1778095153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=01rquaTt7d61QtrEpYATFjqsbMMGQjEoJs+Y2dcPj8w=;
        b=JYSnVTNFLCdlQ763sQtm2Wly08DJv6/hbybz83UsID4Jm5UOVq18R8wjWxg/RRMNEZ
         4si19zKAJqBM4dKxIX+zGIHF+DHBRFSRwDyfDbqL6UvTvnG/SIGdCiGu0g1zuOmIJ3mW
         PWFwuoGLxmIzspyAx7vkpKW3PfrL319H/BrD8wcmvJc3NVn1+UmTbyCTiKfwbZLkgoAa
         CnVN/Nna8CYct1fwo9GIqkqb57n1g7sADA15x41Kguxay3l7Borf+ZtdLN0TFAF4u2Vv
         rHO/7tSrD/x2RMoaE2nN7vKdtH4syZpfT+qMJkU5iHYn5/0vE1B8Knn9Ahhr7HIL2ZcN
         bMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777490353; x=1778095153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01rquaTt7d61QtrEpYATFjqsbMMGQjEoJs+Y2dcPj8w=;
        b=WCrN+Pk4VGGqeyjHClGEiMbeEtj1piFRQ/57N/y1uP6nXPQ0R+Ex+uJAj5Ksx9OYmR
         yZHlOX+JP006TVfUufMaHI42yaa3PPbf+irvFVKGE3KlSRcd5yrxG5RDmz77V5AXT+Iz
         lTmpubGwca9pXoPH1xNjGb2H7wdEM99MrIJt87i116pLMQvR7DPYyRHp4t4JCGaGohvm
         x1mRTEDcskizP2VnLfpM2rCTY5galxC2N26TBbsu5+zKhy+zlIU7QikCrI/0IJipoRLf
         5RNyo2fuJJlUBjlcMegCj5TfQ1CU4I2Of8szDmYQVmUAVMStkPhBDoPAy38yTYYnNmP4
         M8WQ==
X-Forwarded-Encrypted: i=1; AFNElJ9QVZBH+uFY/pu4f/idIVCmpvMqNQvNKCuCELsJnFMMRpGaeSS3S0L0Vg3F7HngxRpigYwwWyHUW8N32g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFnuUIb6/uS7YLUi8v2t4GXKPX7/G8V7ZNe37XLwlQUrlMJdDa
	dRSvjbI2GA04xGGJXOUaeryV9KLvq1DPj1Qh3CDMmBmNo61ue7m2ZonK8Ff3og==
X-Gm-Gg: AeBDievolzzTKTd5pbIs+iKEQFKI349RhJPlUK2CPERX+NCd6CvpiwIkThPVyfv6fma
	hfYCzU4+Q2xK2OlbT6WEmjAVD4xC2GB7vuqgKfRCatSVrB/HwbnpEd+jOcyPW3TMpvjETibVWRJ
	JmzmrGrkgAVbl/HGRsMY9knTC01uPNn1Grb1ktx7RYbVPMuyuCEzqUZaW2YtQ++k/X6Fl7k83wU
	V1orMkw45e4F5y8gihg14PP29YPPJolPs47I4WiDKydagmtuIxmliJJqgIc6GxTDtXtuh7Jpn6e
	aIM/wbyYwgbl/tplztASGnoj3lZumKzN5IDLsmUHxdcFmKdH1acq2mLskbCleLuxSkMrKr/UZrC
	rkWjL839yAoQ2HzRuhQmaG9gC0O5Avb7ZioxSYj2kIAaX7jnmyYlOd8GAOFxTI8OMx9oj9GmmKJ
	KjnKObAn5m0bbHUmgukYT6QlQ+x1BAubEUilJnlSGGkJJluUuC1k6wQd5R9oTkHapoVH1B+Onlz
	cbTAMdypIiq
X-Received: by 2002:a05:7022:23a8:b0:12a:b3c4:c3b6 with SMTP id a92af1059eb24-12ddd984e39mr4038307c88.21.1777490352727;
        Wed, 29 Apr 2026 12:19:12 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:54e3:5ca2:4f82:c61])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12de32173acsm4929916c88.5.2026.04.29.12.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 12:19:12 -0700 (PDT)
Date: Wed, 29 Apr 2026 12:19:09 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kris Bahnsen <kris@embeddedts.com>
Cc: Marek Vasut <marex@denx.de>, stable@vger.kernel.org, 
	Mark Featherston <mark@embeddedts.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: ads7846 - don't use scratch for tx_buf when
 clearing register
Message-ID: <afJZSCXeoSO502o1@google.com>
References: <20260427174657.691272-1-kris@embeddedTS.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427174657.691272-1-kris@embeddedTS.com>

On Mon, Apr 27, 2026 at 05:46:57PM +0000, Kris Bahnsen wrote:
> The workaround for XPT2046 clears the command register, giving the
> touchscreen controller a NOP. The change incorrectly re-uses the
> req->scratch variable which is used as rx_buf for xfer[5], so by
> the time xfer[6] occurs, the contents of req->scratch may not be
> 0. It was found that the touchscreen controller can end up in
> a completely unresponsive state due to it being given a command
> the driver does not expect.
> 
> Instead, rely on the spi_transfer behavior of tx_buf being NULL to
> transmit all 0 bits. Also set rx_buf to NULL because the value
> returned does not matter. Thus moving the 3 byte pattern to clear
> the command register to a single message.

Unfortunately my suggestion was flawed: I think this will flood the logs
with "Bufferless transfer has length %3". We need to have either tx or
rx buffer :(

Thanks.

-- 
Dmitry
