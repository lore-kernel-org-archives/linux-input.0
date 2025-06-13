Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E183218E377;
	Fri, 13 Jun 2025 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749823759; cv=none; b=lbLSPuptK/V3sG+Id7DrEFrHA6oH4ZCGOOTugFFVKGqknuYpzazX/1ekFI61QgMG7ctClhx0aqoQvom3T6NH4bF75prFj8V4F+kWewsSLqt8DZvZE18e9zYE51P+xpcmXs1iHUXzENPWfKg3T4hUZ0WDCppU5kOIvujZOMisAR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749823759; c=relaxed/simple;
	bh=pnwrk6Z3PaD1SswHTlvmVN1ZNXmiAd5TVeaAsr4frM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltdWKKTqAlUPtWllP/3i1K3rN2ESnRBMy0u4YbWcT/UeB08gSg1OuDNaLar0o3bWVO7ENzLtK2WtKXFW2n5RVVDJVeBKQ8aHIzAlX9RuZNx1Oj2oLbKGmBus86LZd3H8dKll+6G6rOx1jDV+eUDXuk8FuFJa4+auFFWPDj+p5I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4nPHDq2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4nPHDq2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8319AC4CEE3;
	Fri, 13 Jun 2025 14:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749823758;
	bh=pnwrk6Z3PaD1SswHTlvmVN1ZNXmiAd5TVeaAsr4frM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i4nPHDq2JYDTbEy3TO7BY/Erv5XcW3qz7NzFcW7B/BiyCspubUMhnsCD5adX+eec3
	 1oR2oWqpIMT8+zKOCwW9/pVd+2fkjXSyMRhx3lYdD8wNpgSNJM/sIF+szMfvrVlOkg
	 rIP6MrC7X1GLRTFS1HcnhStZ6JrYdpO5mLU9hm7yUNTLraH8EFWrwLdKkcFIjTcPnf
	 wCAP0sHL1zJqd/88HwSPwL3A0CaU7XUpeGb7CtF2Ev91xVkpfELq8hJYGA37O2Qnil
	 AHbxjp4oduEfcOb+J5wAbVq+2A6u1LKY/gOokn3E1htxCCqigAngzevlnm7msoXM8+
	 r4YJdEew9SRUQ==
Date: Fri, 13 Jun 2025 15:09:13 +0100
From: Lee Jones <lee@kernel.org>
To: Job Sava <jsava@criticallink.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Julien Panis <jpanis@baylibre.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, jcormier@criticallink.com
Subject: Re: [PATCH 2/3] mfd: tps6594-pwrbutton: Add powerbutton functionality
Message-ID: <20250613140913.GF897353@google.com>
References: <20250520-linux-stable-tps6594-pwrbutton-v1-0-0cc5c6e0415c@criticallink.com>
 <20250520-linux-stable-tps6594-pwrbutton-v1-2-0cc5c6e0415c@criticallink.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250520-linux-stable-tps6594-pwrbutton-v1-2-0cc5c6e0415c@criticallink.com>

On Tue, 20 May 2025, Job Sava wrote:

> TPS6594 defines two interrupts for the powerbutton one for push and
> one for release.
> 
> This driver is very simple in that it maps the push interrupt to a key
> input and the release interrupt to a key release.
> 
> Signed-off-by: Job Sava <jsava@criticallink.com>
> ---
>  drivers/input/misc/Kconfig             |  10 +++
>  drivers/input/misc/Makefile            |   1 +
>  drivers/input/misc/tps6594-pwrbutton.c | 126 +++++++++++++++++++++++++++++++++
>  drivers/mfd/tps6594-core.c             |  25 ++++++-

This should be a separate patch.

>  4 files changed, 160 insertions(+), 2 deletions(-)

[...]

-- 
Lee Jones [李琼斯]
