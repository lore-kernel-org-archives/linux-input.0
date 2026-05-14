Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B143D7A19;
	Thu, 14 May 2026 07:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778742666; cv=none; b=Q9ErJQCj00tETmCQuTs+US+u6zOrQnTcZhsSrGRBIk/QNCNJTVVNkHmwu0ld3P1TsoakpNHP2BDJ6/bTczhHEJnIqdCp5v4Yt4xUokEQzwMZE2chpnAA1tM6n8xBrZrheXMBA3gNTTk1WHNHX+HlZGtHcH00bjB9j1Va7IAuCeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778742666; c=relaxed/simple;
	bh=7EMk745eLOidv9+WGveteqG9qCPkmuX7NzNZ+478+6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbPrdi66gWsfvaIbLozTQZrmf4085xy8TYAlCmo2ZmbGAnK2QdUTVvG7VCg2eu9H1sNJNdDPhrFs/QazsugZBa0TmoOS5UJfq0mJB+kwDixgyRCisJ+zp0eWrkjX2CbopZtHDwisyUwQlTwuArTzxy25j26B5P5kktaF+fxXF3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net; spf=pass smtp.mailfrom=who-t.net; dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b=Qf7oDPWc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oD7bKa8/; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=who-t.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="Qf7oDPWc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oD7bKa8/"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 8C605EC01B4;
	Thu, 14 May 2026 03:11:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 14 May 2026 03:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778742662; x=1778829062; bh=H5rBFCSMrD
	kAQ8rE94o8gpUy9uCiiJqJorNdiKMYRnI=; b=Qf7oDPWcNaf2xG8kMqgXOdHNMB
	V56pO5HzQdb1tkpqmTSEz1PDrKj67fMB3Rq5dgL3E1rCD2pmszxMYxSAN5YgcOW2
	NKzBoqQ4jMz8eH/ieQmg6b4bvQgEOlspWBuZLpDvvsTHt02K1EXoNPLrdB6/IHcA
	iIYoMj+pGWliBiema9k6N2iuvU19jW87FMraxOZ2vPmJn2kMktMEiWhtIYc4ioWP
	HBPYvBt5Je1Y9dYRcvLO4Nlc9nkABYEF9qXB/0jDV6nWwLRMXCHZyePpZv/Ecpdf
	vBgM3RijmzxkQh0hYfczPO76a3Mm4QufKXj3IhvVYcm0NufYl902mpAyLczw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778742662; x=1778829062; bh=H5rBFCSMrDkAQ8rE94o8gpUy9uCiiJqJorN
	diKMYRnI=; b=oD7bKa8/r6RgyCm9dOCUX1IkadMhYUAZO/1L+zk+4t4AHDwER97
	8DWVxqm/aWNIjPTv1a+09dTtGUIuw98cje+Ol8A1vZ4DgMvrdZgqENPHOTOb3XaI
	v5rqcFi+Dt+DvTSTj5V0Urld45lQ+DrJx4+wLHks16Os4xM+xkadNic55zKXutGc
	Y/YQ/V7Lq1TvXwXYmFlOBtGBxfOUQWJ8FjniPN1eJD2yclb4pVx0juPRNKpxShJ7
	dcEEL5rXYoJdj3zCYLpNzdM7E4+bIe02yiIM7rAc5s2d2GhjaEHJKE9iGwv6SeB8
	N1uYrx0Saeujdpf5MsajlluF/m7q2x4/nKA==
X-ME-Sender: <xms:hnUFarnX4Y9D7WhORWAplaVP0pcjH9Ffyk5KsrPEhXq3S84Aw4hlNQ>
    <xme:hnUFaoJ_clv-66lXkkvdIJw-Vkz1NdqWt64jYouqH0H1ZHCjuAtL5Vkn6iGcD2UzJ
    qpCdNtP03uXH0WKVop1ORENcHsTeZ_G9uIFGUeTi7F8axjEJOYEMYk>
X-ME-Received: <xmr:hnUFao7lnHzJ7OuLOewH2ap-tqw8bd6TSwLt8VJcvMYxA1SjJGwPiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdeikeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgvthgvrhcu
    jfhuthhtvghrvghruceophgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvghtqe
    enucggtffrrghtthgvrhhnpeekvdekgeehfeejgfdvudffhfevheejffevgfeigfekhfdu
    ieefudfgtedugfetgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvthdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhgshdvtddule
    dvtddufedtvdeggeesghhmrghilhdrtghomhdprhgtphhtthhopegumhhithhrhidrthho
    rhhokhhhohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgvvghssehkvghrnhgvlh
    drohhrghdprhgtphhtthhopegsvghnthhishhssehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhinhhpuhhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hnUFak1wI1fKcKcsf7mfQqPVEkwOZfdWmtiPvbopWrvOiwwnsPgVWg>
    <xmx:hnUFamd1AEymJCvLFgPhuc9-5EawDzafaylJQLhiQbkVAn-i1We_9Q>
    <xmx:hnUFaieLblE6ryky9KQRkdXnAifKHMR4H8N1M3m_3tfbMrMKqM_O1w>
    <xmx:hnUFapwlTgKDyk8cLEQIURImRSvLPHM2XoK9f5OLU-hFaJO_JME-hQ>
    <xmx:hnUFajdLhxOan5cc5Ep0IO7ZDvbZaK-nel8JEWNCgS_kbLjOjZoMNC-K>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 03:10:58 -0400 (EDT)
Date: Thu, 14 May 2026 17:10:54 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: wacom_w8001 - avoid double release of pen input
 device
Message-ID: <20260514071054.GA66370@tassie>
References: <20260430071311.451957-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430071311.451957-1-lgs201920130244@gmail.com>

On Thu, Apr 30, 2026 at 03:13:11PM +0800, Guangshuo Li wrote:
> When registering the touch input device fails after the pen input device
> has already been registered, w8001_connect() jumps to fail4 and
> unregisters w8001->pen_dev.  It then falls through to fail1 where
> input_dev_pen is passed to input_free_device().
> 
> Once input_register_device() has succeeded, the device must be released
> with input_unregister_device(), and input_free_device() must not be used
> on the same object afterwards.  Since input_dev_pen still aliases
> w8001->pen_dev, this can result in a use-after-free or kref underflow.
> 
> Clear the local and container aliases after unregistering the pen device
> so that the common cleanup path does not try to free it again.
> 
> This issue was found by a static analysis tool I am developing.
> 
> Fixes: e0361b70175f0 ("Input: wacom_w8001 - split the touch and pen devices into two devices")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>

thanks

Cheers,
  Peter

> ---
>  drivers/input/touchscreen/wacom_w8001.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
> index 45930d731873..a3b283c59cdd 100644
> --- a/drivers/input/touchscreen/wacom_w8001.c
> +++ b/drivers/input/touchscreen/wacom_w8001.c
> @@ -665,8 +665,11 @@ static int w8001_connect(struct serio *serio, struct serio_driver *drv)
>  	return 0;
>  
>  fail4:
> -	if (w8001->pen_dev)
> +	if (w8001->pen_dev) {
>  		input_unregister_device(w8001->pen_dev);
> +		input_dev_pen = NULL;
> +		w8001->pen_dev = NULL;
> +	}
>  fail3:
>  	serio_close(serio);
>  fail2:
> -- 
> 2.43.0
> 
