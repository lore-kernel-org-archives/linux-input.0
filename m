Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2460122F77B;
	Thu,  9 Apr 2026 15:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775750255; cv=none; b=uOV2tJdTofepFS4MjXgmUgEZ7wXVRk4u0+6JBKMBnl01ySr+eBEq2jWSk0z+7ca16mzn6RW1FzL7sz0eQNipVWVXoQqM2bdFfefPBISCv3+ybBcaV4PHt4nEq3nCSMXAiPqg9ROeEKI18XrBvHhoQ+qG3UbUBqVtjnyeBUiOXPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775750255; c=relaxed/simple;
	bh=S1NoH+phqyureM+EmjfE9oKR+ynW9UVsnngzW+Do1ec=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LTTH/HsoYNn3opIwKCoS0453+gtDcZ56gQy6aqzbbOzbCWyW2A5fzdfHjajwSb3M+FIJ/b9MDFh4jrYxt8/ZOFHBUVVEqbSqDuGr36cd8Yzp/JMTBiGcR6gk8jrCyPa0O/jhI8xbdj2mW1VNzn6sbCxWt5RdjAkvd+JTEA2m1Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/u5OwxU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/u5OwxU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D11C4CEF7;
	Thu,  9 Apr 2026 15:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775750255;
	bh=S1NoH+phqyureM+EmjfE9oKR+ynW9UVsnngzW+Do1ec=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=S/u5OwxUd1wsbWN+j3h9fJ4mxXT0d73TEq4Ikiba+4+3NNA/t++EE9Jcj9KkRj/Q6
	 2ER+U//vkncGlLVYrO/6w3vuh6LyOh5hEhNYeugrzpJtMLSKQlFUweR3THl++VK2Ww
	 6RbIA1h3I6Q+iu/tLvWY6Z4xfM04vQX0pebO9oNK59ikiHMFdtVo0xLo1j3K+k13P6
	 8lZ7MC7PSuySFPUQoxOgbt6TslbZFigmq79HIz1TPvypt04n85QePYcR6QuIeXmdEh
	 9u9Snmrrco7+KCY93DdMaVk4+4WlAyk7XH8Pv6Bz1BKEeMkffeSYlkGKX5rG6LurmA
	 /g1NpxpKjv9ww==
Date: Thu, 9 Apr 2026 17:57:32 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Miao Li <limiao870622@163.com>
cc: bentiss@kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Miao Li <limiao@kylinos.cn>
Subject: Re: [PATCH] HID: huawei: fix CD30 keyboard report descriptor issue
In-Reply-To: <20260318091249.217283-1-limiao870622@163.com>
Message-ID: <6n986qn4-nrn6-931s-5pn4-98613598nr03@xreary.bet>
References: <20260318091249.217283-1-limiao870622@163.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 18 Mar 2026, Miao Li wrote:

> From: Miao Li <limiao@kylinos.cn>
> 
> When the Huawei CD30 USB keyboard undergoes 500 reboot cycles,
> initialization may fail due to a report descriptor problem.

Oh wow, that's a novelty I think.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

