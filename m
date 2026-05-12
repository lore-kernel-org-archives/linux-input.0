Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53E93E173D
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600609; cv=none; b=S8rlB/uQKYluZa67yP83TdjBgDNwJFutkOicjsKJ8oWQHqgRIyUYvRjluRA59F16ULR7GxuC1irtXg2dMlupNVs2boGGMiWDutNgwo2sd04ED4z1lCt0QY+eXGSLqpFlOurl2hflVF9kzz51wyXg1Cf/yHvbLCa3eSOSTHKnbFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600609; c=relaxed/simple;
	bh=Jk4I8MqY1lHUzEq7l3H+G3wIdRuvm3dNt/fU7NvdU+I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EF8H3UUhCEMOART8YOsiAQIqR8EWIyM7mGu3et6ND0nURzEtpID7YnarCexwj+MS3+24I5AZSJEfAv2krbsm/eRLRFeOUdYwtGvrl2kPMW4gEwK7clJtt8VNpibJvt6ZltKOb0RVxz3kmR6jTXM611YPTYeLbc3vY+I74rT0USw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g35dr78Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g35dr78Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A1CC2BCB0;
	Tue, 12 May 2026 15:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778600609;
	bh=Jk4I8MqY1lHUzEq7l3H+G3wIdRuvm3dNt/fU7NvdU+I=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=g35dr78ZO/XFeLvZuus1SomDhRLY9+pz5pwchWWppQKuzmNXO7gV7RbmShDL/EsBY
	 aslSUm4NgJ2v4isF3IvS8EoFYU/59PnwHnEBdhqUpgJwgY73dgzaa+7gk/wtY/dYbp
	 5+67GZHa9GwcoMkpuW/P1h1X5yogHvGtYav6Bk3meNCl+e3NR+7gtmkwJWPw283Fq5
	 MYPYIH0lbZaq0R6pd1fNNA6hNgpvNm+mPWNodlbf07jEcV5mCxzDcKhyiQK2H2pYVH
	 GK/ou/X3MPUMh9pR1DJ9A3MJlua3nCdbSGHPEBJD31jkXbY8dVfzM9lf2iqJPg8qNo
	 6FDPMYUgmCLeg==
Date: Tue, 12 May 2026 17:43:26 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Vicki Pfau <vi@endrift.com>
cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH v4 0/3] HID: nintendo: Add preliminary Switch 2 controller
 driver
In-Reply-To: <20260415073142.1303505-1-vi@endrift.com>
Message-ID: <rqposs64-2nnp-5552-nqp3-o45q11328o97@xreary.bet>
References: <20260415073142.1303505-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 15 Apr 2026, Vicki Pfau wrote:

> This series adds preliminary support for Switch 2 controllers using the
> same split-driver model as previous versions. This is a minor iteration on
> v3 (which was erroneously submitted as v2 again), fixing an issue where we
> checked for NULL instead of handling an ERR_PTR, as well as a few typo
> fixes.
> 
> Vicki Pfau (3):
>   HID: nintendo: Add preliminary Switch 2 controller driver
>   HID: nintendo: Add rumble support for Switch 2 controllers
>   HID: nintendo: Add unified report format support

Vicki,

are you planning v5 with Silvan's comment addressed, please?

Thanks,

-- 
Jiri Kosina
SUSE Labs

