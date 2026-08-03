Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB42423E85;
	Mon,  3 Aug 2026 17:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778628; cv=none; b=JzpqSKuL1JF+rXavaKBJW9PTj3gURgeWv5VtqHxuD8ptPQ1iSd4VxpAabklk+jPS3Mg/rbdLcdZFX1ZVs+xWWdQ0jF/QRiTtLXH+8d1WlQgjmMVYAX84TSaouSfPK8i1AlCfSnHHlkBPzahTJ1RwQiskrJmGU5lZIrqv5VdHxIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778628; c=relaxed/simple;
	bh=XYqoOS/XgAyrokNeBBkCnPN+RCEEpQEXviLdsM5U0EA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QTIdF0pMs+Ujf1D3ICo+GLm9QmP/wr9UzYcqA9CSL1eR82NWlYv6a6sBO76ZzLxNAcDWQTkICkarIFIoxbN0+UzkWO8dkJC78tBwoGs1oXWWR0VikUDwRVYmfsOZH6TcEmWhmQdvu35PR6oeSufQRhVSn2MkHV20oXHPcqi0UAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kb1rIvGC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kb1rIvGC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6F91F000E9;
	Mon,  3 Aug 2026 17:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785778627;
	bh=dfZK/jAodh6Wx0uqt4afa8hJ3jcksMxlGWqE3+jyBbo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Kb1rIvGChwDU1gysbDEHvUj2m+BN39MosfwF/GM7hzIqNyACs15JkLhlAQM0Lu25+
	 f68RIgY5D1CB1dIHromMXb0b1btSh+S4TVAvCgRTJDpgQS7e0eqT+RXNDktNLPOe55
	 mTVptjk5TtDtvvjRypeW9If/xL//urseL7EIBESnU8bSf7pHCZIIYln3sYXvob5cwg
	 R/BWGVq6U5SJqB8DoRuQDlQ+RyoC1e236QyUgESyb+0hdne5xeEyLC6OQ4cIszAOqR
	 OBt/3BOqmA4W/cnYAtw0yiyV7ZGVKN3VR1v6G/GTnJsNZyoi9L1Zg8yPRtHqK414ak
	 /u5woX3R7UFEQ==
Date: Mon, 3 Aug 2026 19:37:04 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Aditya Garg <gargaditya08@proton.me>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Linux Input Mailing List <linux-input@vger.kernel.org>, 
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 RESEND] HID: appletb-kbd: add option to switch default
 layer on double pressing fn key
In-Reply-To: <20260620112635.17246-1-gargaditya08@proton.me>
Message-ID: <1qq5363o-p24p-5p8n-op02-1q85prsq320s@xreary.bet>
References: <20260620112635.17246-1-gargaditya08@proton.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 20 Jun 2026, Aditya Garg wrote:

> From: Aditya Garg <gargaditya08@proton.me>
> 
> This patch enables a user to switch the default layer from media to fn
> keys and vice-versa upon double pressing the fn key. This behaviour can
> be configured using the double_press_switch_time module parameter whose
> value depicts the time in milliseconds within which the fn key must be
> pressed again to switch the default layer. If set to 0, it simply
> disables this behaviour.

I know that historically the apple driver had all this kind of tuning as 
kernel module parameters, but wouldn't it make more sense to start using 
sysfs attributes for these?

Thanks,

-- 
Jiri Kosina
SUSE Labs

