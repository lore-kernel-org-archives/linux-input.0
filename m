Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795123522;
	b=vHaHhb4m5/Ra84Ac6nHEcnKH7bXKRbTOtG9uJdeg5qhecDgJ24glsPAZMhDp4A2PSoE3
	 rsd42W0qpPWfGpamEpXYXbfnESPzcjeq+HoK/6AzwhwWodBz9J0XMBmbS3NnfYiG3yYKJ
	 lK2gQmQuCBT+FArBzx1GYnSDp9QDEBO0+RclHgnkRGuczKmmbPjUg8/b2el5bfKiX/xJH
	 sTXppqMqsrORPYI1x4GoxHGWLJhURbhL2KsVbLVXeGK34xqD0Rdb5rVPlAFwLPkUOWVuA
	 XoZ7WPTkgJXnwYz6jU4axEqIfiA+OnVXKdZ2bF2LEiUnI1uk8MOQay8dytIVOpvA4Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795123522;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=QOKsC3xVbY57/8IWJfCT9+9xgZrVTbBDY+kMeMv024g=;
	b=OMQb1kcDnAVaoWPua0jzyAWpaP8Z2HeNsTWFuL0p2l/tzTeqNCjktoVISIu1rNFU1uf9
	 Ro/nIxSTwdJ39OAS/06hscd91IM144j8Ov7OzG8PvW3X9H+DCXbSzCZUcaBjjCwpagX69
	 iWezK4TBuoNjMaRZ0Q3fpK4szd8If8XS6XeRgoPjKm6x5XqjwKrSJHqKMzvJl5297rYnR
	 rolJOjk9a4tquZ36Wc9BgOKrBbfe+X6q0AhUX/ccWF7XqDo0tt/1EDecOwJiryNZ2ofXR
	 rC2F3pqxonrpYb/uAza+hg2PVHBsMk+GBrjW4kfHIegMd606leG1KZTQJzDB+z1nYnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=begH4psp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735AD606A320;
	Thu, 19 Nov 2026 21:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=begH4psp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733611F000C6;
	Thu, 19 Nov 2026 21:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795123522;
	bh=QOKsC3xVbY57/8IWJfCT9+9xgZrVTbBDY+kMeMv024g=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=begH4pspNQtZxaRBrpcbY+NIGIZSeWwfuG+HTn1k2Bcl+xL8cZva2g7elZMbQRBLe
	 IyQMIVQ2tO5fDSjLFldbDB7WiXLgNdPY2QEi1y7vAFWmGMsbW0/foyzpnc2N3mbyDT
	 NgfCQaIOxicRf0wFF1fNKoXcjIu65NFkCRCZPk4udka8kyngmiWZYCOYpQeV4IzsqU
	 /aP1GLQUm6g2/oBrcTJ/XyQVWXDEpb0zMqNwxvqpI7XtsGEUMtYU/2DHqeiPMuy3wC
	 RSCcnqZ9wR7LMXIM8wDCEBrqRMcCD3aCaDpTtG3l2p+MF+6baw7TmD3hBwZpDTmQRR
	 8kLhErzH2kVtg==
Date: Thu, 19 Nov 2026 22:25:19 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Mathias Krause <minipli@grsecurity.net>
cc: Even Xu <even.xu@intel.com>, Xinpeng Sun <xinpeng.sun@intel.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: Intel-thc-hid: Fix REGMAP dependency
In-Reply-To: <20261105170116.3193223-1-minipli@grsecurity.net>
Message-ID: <ro7rqos8-66op-977q-p788-o56os833r750@xreary.bet>
References: <20261105170116.3193223-1-minipli@grsecurity.net>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 5 Nov 2026, Mathias Krause wrote:

> intel-thc-{dev,dma}.c make use of the regmap API and related data
> structures, breaking the build if CONFIG_REGMAP isn't set.
> 
> Fix that by forcibly enabling REGMAP when this driver gets build.
> 
> Fixes: 1b2d05384c29 ("HID: intel-thc-hid: Add basic THC driver skeleton")
> Signed-off-by: Mathias Krause <minipli@grsecurity.net>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

