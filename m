Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0622C1595;
	Mon,  3 Aug 2026 19:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785784778; cv=none; b=TihO3dfo4I+n8zYq9Gl9Btkvbp4jxo3pX5G7t6VW4fJyEOq/VpNq7RPENHcgb6cozwEhUmdfXzRa6FDaJtvM/rUutcSdYJKzGEx4pP6PkrZ5v+mX/XRCYa+S/E5DRQkuULCrSNfaXJI0RrzdKUgGlr8dI9nJXitq09eRf6UVww4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785784778; c=relaxed/simple;
	bh=A4tYl/LGTIX5rv2WBGSfdMGsGQeLwJKac861nGXGCvI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NPb0IZ4RbPg2A1p+ytt+hDr2M2kcAIVGu34a/9MMM2KYZroZTobrcgqH6NI7BuLNHaagDaqFitPkRppgBO3P8r7BB9W0LmiNFm9wZweSXeWaOemz/e0V0tLswd3hkUxuTmGqHCRWz/T/SVPpyp2mZNhvAYqTx0j5dyyYExs269M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auY7/d70; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auY7/d70"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91161F000E9;
	Mon,  3 Aug 2026 19:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785784777;
	bh=xvzHsTdKSH299lg0Hj3k64BGaQNm4r4su2CyvChTqPM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=auY7/d70qrtl/dEOq1ksLBJZAy+fbP0MdUA/t4FcgNlM6UPkwx94gKp+Yw8HTEO2r
	 ISdZPrxTs6Ouf3mYbnMFGDvX0XHg3ourgy0kwyC5pzEB7NI/YrqzSdhNovzLRC2XOO
	 W3fH0It3cJwQ+86TiPTMGMWdJGbs6jHVrtzKHGqirj6ChLGmZ851SvJUgcLC3Wwq0q
	 pO61MMatW7ByQp/oKFMpIpb3Cv7h/MNH5/k/l07BIZeCL9FaygrrCxb2Gp85zB+Om0
	 eQ69aJnj4kqkUJlTn/xk8Q5SwKRXjlsxciSMpGUEczLG7ypHhteM4SqHWblesYg7TN
	 ef6wctUAYq3oA==
Date: Mon, 3 Aug 2026 21:19:34 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Chao Huang <958028483@qq.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Douglas Anderson <dianders@chromium.org>, 
    Matthias Kaehlcke <mka@chromium.org>, 
    Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Chao Huang <huangchao@kylinos.cn>
Subject: Re: [PATCH] HID: i2c-hid: goodix: Disable VDD on VDDIO enable
 failure
In-Reply-To: <tencent_FE1CA7ED99022E1734F8C9CAB538AB477405@qq.com>
Message-ID: <no2r7p52-n6qq-2q8p-pq63-29218rss7s6o@xreary.bet>
References: <tencent_FE1CA7ED99022E1734F8C9CAB538AB477405@qq.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 22 Jul 2026, Chao Huang wrote:

> From: Chao Huang <huangchao@kylinos.cn>
> 
> If enabling VDDIO fails after VDD has been enabled, the power-up
> path returns without disabling VDD. This leaves the regulator enabled
> and its enable count unbalanced.
> 
> Disable VDD before returning the VDDIO error.
> 
> Fixes: eb16f59e8e58 ("HID: i2c-hid: goodix: Add mainboard-vddio-supply")
> Signed-off-by: Chao Huang <huangchao@kylinos.cn>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

