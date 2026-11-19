Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795123123;
	b=PW7AsrDeBAJ5dY0NWJ9cHKcwuwmxUrErm/nVgMTjTQob2xhNdPusJUWGlTwJ89T1BOZJ
	 z54LxnNpk0b4mdUPwuxbQ6mMlWOljLe9m6AJg2n6nC6s9qv01YUmI00wTcvg7EYrjW0p6
	 xZqD3p5h+peWZvXYgfivTn8tw8cxGH6ElJ0PMOCQpB5rkAlPw3R8zNuR8JiIj4Btt+N2I
	 oIPSlOQIhVu/tYqAjg/TIMT3oM3JBxJBFS6FM6t/hx9McIA/vR110+UZ1sE+cb62J4uBc
	 Bk9cf3Wz3pFaoGU8dZWub3g+HslF4B7t+vJa57aZMS/HUjG/uHsVy/IG6678mJYktbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795123123;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=iXjT8T9D7Psk8Z0Vh6qia3U6KALhVtnGfEy3t/WSrh4=;
	b=ecGZ8R9dG41Cq7uU5hzNcv72yVRbJLdKqACvAWG8vLhIrmxtGuYnounWyx/P/s9O3L/u
	 Tq0WNDwcd3XBlezGi0b+HLRjaxH65jA7Y0K3M+MuK0ChqFeYN1f7phFkUzsxLN1efzpil
	 51IU8K2Bt88oDQI01Vneu/YMBtC9Wl/HxxR7ShU9jV66KR96HjFfqCizV0pFr1IZXZxpN
	 p/NslKGBDMULdHQNvDaLwxmILkSKFHPqbfICcaDq/pSRyQkSBoso3/LC0+okLCl+79MJp
	 XSlCnN6LPzVXz3SXmawDj74PBTgTweWhqa8o+ozI5TdNRXaLA+L07Hse2aHx14/d5TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JyKIbkvH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA10E606A320;
	Thu, 19 Nov 2026 21:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JyKIbkvH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEE71F000C4;
	Thu, 19 Nov 2026 21:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795123123;
	bh=iXjT8T9D7Psk8Z0Vh6qia3U6KALhVtnGfEy3t/WSrh4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=JyKIbkvHO6+P54ZYRrmOboxzSBv94S/8qMohdaOfzdJf1nAsEL0ngDCUmamzh5lPt
	 rq2xC0YjMAezh6VAJSVuzkXgU6JgVHVJbR8pgin+dmBaf5p3AP809J5RYCv1jpV/l/
	 P513e8JcJxJ5TfE87wzAXRSgRt4K0GLJEKi0M85unVdftXy+9vdn8Fb1kBYarpRzuo
	 HLkTEghBlwMeKH83aDitrm3mvqhprVgS/Qjh0uNLIjHRRkUQ7JlN7ECirvRnntr5bA
	 mRFmcTpIspRtYhJgrjkJVXR/XOXUW/6S3cAJyja3f94NsQdDbdUdqQwIg+qRYnONXn
	 nJuJPSua+QJAw==
Date: Thu, 19 Nov 2026 22:18:38 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Even Xu <even.xu@intel.com>
cc: bentiss@kernel.org, srinivas.pandruvada@linux.intel.com, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Rui Zhang <rui1.zhang@intel.com>
Subject: Re: [PATCH 1/4] HID: Intel-thc-hid: Intel-thc: Add safe DMA read
 interfaces
In-Reply-To: <20261116082805.3986615-2-even.xu@intel.com>
Message-ID: <snqq816n-8167-q00n-65q1-69p49ro39648@xreary.bet>
References: <20261116082805.3986615-1-even.xu@intel.com> <20261116082805.3986615-2-even.xu@intel.com>
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

On Mon, 16 Nov 2026, Even Xu wrote:

> THC DMA buffers are rounded up to a 4 KB boundary, but callers may
> allocate smaller receive buffers. Checking a frame against the DMA
> capacity alone does not protect the destination when do DMA buffer
> copying.
> 
> Add thc_rxdma_read_safe() and thc_swdma_read_safe() with an explicit
> destination capacity to check both the DMA capacity and the supplied
> size before copying.
> 
> Keep the original interfaces as compatibility wrappers.
> 
> Fixes: a688404b2e20 ("HID: intel-thc-hid: intel-thc: Add THC DMA interfaces")
> Signed-off-by: Even Xu <even.xu@intel.com>
> Tested-by: Rui Zhang <rui1.zhang@intel.com>

I have applied the series, thanks.

-- 
Jiri Kosina
SUSE Labs

