Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEEB2D8364
	for <linux-input@vger.kernel.org>; Sat, 15 Aug 2026 19:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786822087; cv=none; b=YRjx7iZKpEEDCKviedbyNs0aCGOhMlxyYXuiFNfYKJVrgm2i8+TUcnenhyFnOYfyORHrrFF5T6IQz+4eTWJiar5BUsd8AmGbOWomgM+QQfGkzTowcgTQB7x8lCnC/Ox3GfX4jIOFNuY3DgV2wjBdSBvGP+0eiuqc2xBF9HGT6Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786822087; c=relaxed/simple;
	bh=A9dPhSAuV12t8PDaHVfy9oGbpQlEsUYX49Z8df28H8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K69J5BuG4gfMXDBEsP+rQAxnBGbIKFclXtbzfLzLFtJqs9SLEslZb+22X7bC+bgm/aNxh/T0rtiivyzLUQyOxJM0BQyeHH3oM3ZcKSdwKjTnUySTuoe7mEmcDdff7kXpRDQRtwnDkfprQ4HQDycw2tkT2UQ2fjxaskn/V4qfAQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I39iRcks; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I39iRcks"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso2097638a91.1
        for <linux-input@vger.kernel.org>; Sat, 15 Aug 2026 12:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786822085; x=1787426885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=845PduRc+mmqrEPl6KQ9OyGb8f4Id4PgDgtXRZP44Sk=;
        b=I39iRcksFRNkU6NGiaSMOVhLhvrV6YfxYuCkCL8kfjvHCNWtR1pKxbMzt7rvt8z1Wk
         cUlHoUCxj1p8ibTXPgVFNnamI5kcPhCRl6U8E97imyFGax2cX7s2/kAqzIH3v9GrVWaF
         3RjuHl4P/M45ETZpUHMTf5Ak/G4L21w7Luo0gfZHW1ZZWvwoIlV9Wu6joRAy9w2bhFZG
         kH9jijg8b46vHl/Uc0Mr9ACoAfogjViLaRQ80wGzUcpbNkwL6ouyfXR5CAbTF1/NpeNh
         0PwpmuPri9JaWGpNjcBRKkyIAerghqRmXoXahw0U5y4qLfsUT/0IRbGZVAhzGt3vYLde
         xmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786822085; x=1787426885;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=845PduRc+mmqrEPl6KQ9OyGb8f4Id4PgDgtXRZP44Sk=;
        b=LsiCi+G1yJTopbXl4d/2T2GFqK6tEzkY8IpyUKGBEb39SEZFySlen8x1f21yeQNmx+
         jopE089IEgHg6RFkkKtAuD5ILwO9HUNM33wtRqdDCPEPb8htEvRnjOgYml65o4NPUstY
         7drUiDQilQSefLz4wHswi38rR6PqYy2Q+wprVGO5vz0YSDaoQc13RuVVIz1vQPkoBBA8
         WT7Nwz1Rc3wOrysWduQwmyZedhXUyX0KdRL9nFbppR2j3BZ1Rz8w9lRHSepEg66BDP0x
         I3D+vudvYBXlLhojgux0hmefHCL1Y1ZkMVfLmXUvaifhSm8ojVM9x4ua1miDX/SjxYDM
         y4sw==
X-Gm-Message-State: AOJu0YzQxS7jzWIFigYKVLcMr8QlVb7MHwKg+hmPC9M4jnXE02KONHhX
	Pow7EK1DMJcTV9vL+tzviU+cGb6+GApE5+cxhLJ70Cg9O0HX7mVUiRqamUNejn03
X-Gm-Gg: AR+sD11dZ8PPZMbh6ikQPfqtEZ5w63Zfi54a/51NTcH7rg2IkmT8U+q2AiXOQSluZgF
	nxvjJB4d4z8P8hVValgKc1Cvy8aLfPbpqtSodEGPDAVisNJS3GVG5wzZG2690WpzO7A7jkAAE3L
	L4R2WsNOGEvYg9oQ8c19N/N/erIqMunA9qwcwYNYu2na1xmWqNuJ+TMkVESpIvNZAT38JqC8TdH
	crEwitvaU2okikgxIKBf1XNwDM5pfQ2HOnQ2uwjEfKytsvNcSpWXwG71r+vXeZYDb1kVjTDGRYL
	Di9htNgd+tJP596zLQaU7Tr53L3HRan4zHvPYlf0N+zHnK0B2hYJl0fTd1Nm4eGBKrpF1F1VDXW
	Bcmuk0oDwGv5bvT+bCk0LGTE5PT5e+VWZxaH/OEjPGmxxgZSTpS6+OARD2826pA+0+K+GybDl04
	LJDKqBZW8KNb5WiH5hgSCDNOxpatkMQ/1y49FxLanmo0DiiUzqcxipsvPWfYQdycatS3mG7kc4X
	rQz6o6DQzuP02At81sf8kFyuHZEQw==
X-Received: by 2002:a17:90b:33c1:b0:390:b3c5:e2c9 with SMTP id 98e67ed59e1d1-3933b0d5d31mr10107814a91.17.1786822085229;
        Sat, 15 Aug 2026 12:28:05 -0700 (PDT)
Received: from localhost ([2409:40c4:3103:c7f7:a9f:75a8:7ec7:e37b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387e49d3sm22900366c88.7.2026.08.15.12.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 12:28:04 -0700 (PDT)
Date: Sun, 16 Aug 2026 00:57:49 +0530
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: Qiao Ruihao <qiaoruihao20061203@qq.com>
Cc: linux-input@vger.kernel.org, even.xu@intel.com, xinpeng.sun@intel.com
Subject: Re: [BUG] intel-quickspi: touchscreen DMA write timeout (Goodix
 27C6:012D) on Lenovo YOGA Pro 16 IAH10
Message-ID: <aoC9jA2aYsNoLUdO@eggarch>
References: <tencent_DBBAC19E701BEFF670746186D3C6B4CA1D06@qq.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_DBBAC19E701BEFF670746186D3C6B4CA1D06@qq.com>

On Sat, Aug 15, 2026 at 03:19:35PM +0000, Qiao Ruihao wrote:
 
> The touchscreen on my Lenovo YOGA Pro 16 IAH10 does not work under
> Linux. The intel-quickspi driver detects the device, but the
> feature-report fetch (GET_REPORT) fails with a TxDMA write timeout,
> which makes hid-multitouch fail initialization and fall back to a
> generic keyboard, so the screen does not respond to any touch input.

Could you attach full dmesg too?
