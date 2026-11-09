Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211899;
	b=KKZfQcfW1qlWCA1tLcxRGoYZPlGASvcM+lXJW1adeWOC3l43VL+UW7BWOdR/oqVf5ZD2
	 qqv+AsewL3NxC8OAROPC+fV4FNSxrP7S3Uc7mASI/CVGg3PrCL2tw8Zfz+sRUUMPehdox
	 P5JY19ZJ1AWYWnK8BvW1YKNb0suUlJaTp+g+PJzuTeO/rHjPmJR3nIq+o+RqifmSmKbUU
	 msbKanplzId8qpFzRveYN809EFKzkUQcloRyhRIFA6pVP1Vv/xbxwd/Lk8dh0/du6w3Ha
	 dU1AMtujrExeTYWrl5SnfVNYbWC15uFlImS4WB3tdWui6sHQYRCiA1DVzy5oBbYN7/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211899;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=mKhvsObZrPPQtj6ZJlFblKsUPwWm8d6ZB8vx+wF7BDc=;
	b=3AFIitFniBf2HbP3S75oX6B1yLK1RQWRG5BxOzSfbOdVFqHKgC1PIo+sa7TAW3CKsYQg
	 uJgmM6fdVmbp23OM4xug7Mw1d4tyVkYlwUkPihTXxRQROL0rfpuVOWahNFNDYT7pgJuLC
	 JB2UD2YpdmduBpo3dGSRvPogxG+XkoucHRUzM5/xOB441YpjnMX3U6z50WdAkodT2kQnj
	 +cmmQPSyWqoS9bBn6DsjdQzw23aiHD316HQOlpB/HQdEnzcUrgLabk8fpJzfIno0exrDx
	 U/c2DU4n+DMdn5azZ+hRKq7gajO17xjJlpc69ovD8h1+fiPO2JR2pSXA/cKS43jUN5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V6fCsRA0;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC118606A31C
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 08:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC118606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V6fCsRA0
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b1ce85287aso511172c88.0
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 00:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794211898; x=1794816698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mKhvsObZrPPQtj6ZJlFblKsUPwWm8d6ZB8vx+wF7BDc=;
        b=V6fCsRA0dFS4v9KdWGpEZHQGeDkNgijAvP/htZHms/bgPnMY3z6Ha/VGR+qRiB/tZT
         yeUl+8vboUTroog8qizr4aT5JoSzsb1A9B+hx5IlTjyhSrO1fINSwSsAEOdJzBALMIoW
         IF5gpSB6p+cw1lbtglErG6nL2UspWIuSsX54ttj0B088MtYFVgkKUcNBULAIXFB7HvzR
         WbfqX/V5w9Zb21QDeVu8I3dMvjovmxN1fr8oThYR84B73vwdw8Lik/euRdH2gvc1Uln4
         n5WuThlOsRoGWuuqVn7sq1OQUn5Ex24bBrl/OXDYOzWV+XRyWaq5P0gEPmNTsjIjPKCl
         RzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794211898; x=1794816698;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mKhvsObZrPPQtj6ZJlFblKsUPwWm8d6ZB8vx+wF7BDc=;
        b=wfuwBZZZXFhBVHNWEOtj1mXITuacRyq6LWd8Ufr4qFFZtOs1bBzuKWtDbK9w6RFi5G
         ht/Ctdf23zAouoWr8e9KmbGcq8LMRVOXNg61/+xifgAbDQH9AeLkmCpsmRNdb/ryyS7F
         E7awSG7Ag67+V9n5Fpgt0m48SqOv8qdiv/YqzM+r+/qHIBrwvi6klIE/+o5/eiMdhRFD
         0Sonc8wm7NbY4bLRl+HflhwDVeQ4+CxjF/u4NyRvBpx/gcLOz6+upWXTcDO/Cql+y8jU
         wo7SvmjZSQ0PZvIgR42FDO/S/CZbcgQfd+B/Jr9YkktIWLKxCtf8pYNGv67EKCC1wabC
         xSsQ==
X-Gm-Message-State: APuU4Z+hR/ibcvBOXc4BW+HJsURoGrbluO7BwKOPLTFj4fKj4NtUTFdR
	genvWgcPD4hn19hZF7A814OJrT1skZr7e/L1NRbev8NHgtDTNO4PXReL
X-Gm-Gg: AYBFou2em5bh0JxbeXrssArwRQiNHoLKACejhgdNZ3uxbA5uA25L5zpC9J2RV/ZgJWz
	OMbicE7I+vY5gT19y9P0ir8lT9PcuZDWBLawUnuZ6o12dGHwNrLBgthxoVs+lVjfUYEB9behUQl
	qju9CoTd/VHAD4ztrfPPdVoyNjgSqgv/pLTdzVUhwjmhEr/kwfxonyWvBK9e6v+TlksHxul2Rh6
	der4tQsWi2SQZ6TvRU35t1h5M6KoMenkn8LBkvs0cDx4CgZkPbMGEuqA6GhHzvLQXtPUUuXFXsD
	8xb5fR+Go4H5vF2dlJqUOEU8c5yYv337FRJZ14Q5e/ruaMR+8KwAocIuWNV9tCCVctYYP4jaXpf
	cvlYrnB9+fkQynG9T9gn+6CJDhMZWq9aPGi9W8mD9GoO7VzmR33cUKFi7RBIy3g4Z/qf4HiYPbt
	o2jDAUPRYkNzRFgvKSYtmJbqRPEUjp1o2Vieiixt3HTEZatmIp/hHNGSxxzUt5NU5Ve1YP5Phs8
	PLGm40QyqeqPI0P55XPea+bT2l7z113iz+49p9xNqpnpLUGestKIHZpecLDP8+XoiytFoWfpakb
	qKG0Vp/v4o7Z/fNfqKB79/mUMQzDmvv2lgQg6m7hKZkV07R4SE9wSGTyLYXumbWbspfT
X-Received: by 2002:a05:7301:da0a:b0:36a:1434:c691 with SMTP id 5a478bee46e88-37256bed190mr5906511eec.14.1794211897671;
        Mon, 09 Nov 2026 00:11:37 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37265618e11sm10757848eec.7.2026.11.09.00.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 00:11:36 -0800 (PST)
Date: Mon, 9 Nov 2026 00:11:34 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liuc63@xiaopeng.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] Input: tegra-kbc - check the pin numbers from the
 device tree
Message-ID: <avGAIkcHMhfvn-0B@google.com>
References: <20261103084135.426629-7-zhugl3@xiaopeng.com>
 <20261105021303.4206-1-zhugl3@xiaopeng.com>
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
In-Reply-To: <20261105021303.4206-1-zhugl3@xiaopeng.com>

On Thu, Nov 05, 2026 at 10:13:03AM +0800, Guanglei Zhu wrote:
> The row and column pin lists are read straight from the device tree
> and used to index the pin configuration array:
> 
> 	for (i = 0; i < num_rows; i++) {
> 		kbc->pin_cfg[rows_cfg[i]].type = PIN_CFG_ROW;
> 		kbc->pin_cfg[rows_cfg[i]].num = i;
> 	}
> 
> The helper only limits how many entries it reads, not what they
> contain. Not all Tegra variants have KBC_MAX_GPIO pins - Tegra114,
> for example, has 11 rows + 8 columns = 19 - and the setup loop only
> initializes pin_cfg[] up to kbc->num_rows_and_columns, so a device
> tree that names a pin the variant does not have makes the row and
> column stores write over pin_cfg entries that were never touched,
> and the later check_pin_cfg() walk reads that stale data back as
> valid configuration.
> 
> Reject pin numbers the variant does not have.
> 
> Fixes: 88390243a993 ("Input: tegra-kbc - add support for rows/columns configuration from dt")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>

Applied, thank you (but dropped stable).

-- 
Dmitry
