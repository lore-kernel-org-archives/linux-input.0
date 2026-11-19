Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795120445;
	b=4jyx6w6tfCtWuw6B7UDx1gV+Vl7etaXJpUsGaCe7ZHW+1JyHytfwUJBsx8PCyHc4oh+t
	 mxA/8Oe8IOEOTOJtyeE/B/VJRH5hzk3BxMRoTxXJzLOqLICyeUrS14xuX6eg8YETxt//D
	 mUddMWvIfvmbedav5usnV6tzJ2UavjSIo4RoD8IXr8NOae5jYI6QuAaDspLfNEpbGo2RT
	 SAB3/FFXOhO5CxdnwCjWgeM9aeTjNB+Q15NaF7dgefu3lgwigQQooKEqa4PM6R3jG8OyE
	 B2R3Glv8H/2ACWCw26P/rfuUBur4LcfyWWBc/BmpRpPFFLpaP4jdPut1DVSgaMMA7kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120445;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=Mzoq4npiXk3rD3rCKkfgNVYBODAsF8ohlXRBacGpMdo=;
	b=EDY6/yhbHTIBRMeLSK4d4tdVdCq3w1dAh+QwhaeO2PZupxfamcdBvF8aWWydP7yNTWEu
	 g4NfZtq/WZnlA3Q1Q98pnl8vqgiNsQlLleZrxaFMn8OHxAIS3gNtmjoFA6ZflB7DHtV6w
	 +OfshiBngG/SWdbz+SYBdF7YkdeTGZGuqypJ4XQzDGfA9N6MWhzr4XKRtOW239gbJa+d0
	 6Kxf+beuzqmqTdW3XO+v3jw5Kvr4CtdjaElv6ABHGv+avMWSLu0eEyg8EpARHVkKXpxQR
	 /Ij7YjRLVfMZeRYFl5hq09wDUwpWKX4VN3fN6H/ogkBvx0mOsQXoEmkXgzHOBltQ8bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jSypZVPJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B8960A5BEA;
	Thu, 19 Nov 2026 20:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jSypZVPJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3961F000C0;
	Thu, 19 Nov 2026 20:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795120445;
	bh=Mzoq4npiXk3rD3rCKkfgNVYBODAsF8ohlXRBacGpMdo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=jSypZVPJu+EbK3cjfM6+9/Z3SlL2mIsVOoxH4Jpjd/088Jt9LPtBT3O2TEGFv3gEC
	 aQf3QQPILtRoXOFH9HLxxki23UWf44HJIX8gm4iQDpOM2Kqe9Hr7YORW2mBAyHNHou
	 vo/jwJ+/22yN+2pQSmDpHxPOSCOS9Abh0gsInoJN8I8YvTT632OaIQJ5UGjM88Ix9I
	 G8C6syo/niFas52Jd9XjXwda9j8pHUBPcdPJyJcoPULsYlO0AjSdTsnUi6QAqalIfs
	 R6d+ka/gr9oEXFJQ8C6XKjtdJ0Pc0Iyw0RjLjfCyeV55b+NqA2XqSa0oyd0j8gQFN7
	 ZPi2y5eC01WMg==
Date: Thu, 19 Nov 2026 21:34:02 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc: jic23@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org, 
    linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
    simeon@maryasin.name, lixu.zhang@intel.com, crofts@kernel.org
Subject: Re: [PATCH v3 0/7] HID: sensor: custom: use-after-free after
 remove
In-Reply-To: <20261109195949.384888-1-srinivas.pandruvada@linux.intel.com>
Message-ID: <84031467-654s-q1nn-0sq7-rns4sq48962o@xreary.bet>
References: <20261109195949.384888-1-srinivas.pandruvada@linux.intel.com>
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

On Mon, 9 Nov 2026, Srinivas Pandruvada wrote:

> This is v3 version with changes suggested by shashiko-bot and Jonathan.
> Also rebased on top of 7.4-rc2 kernel release.
> 
> This patch series is essentially the same version that was sent to
> Semyon for testing.
> 
> Following a feedback review conducted with various AI models, it was
> suggested to break each change into individual, separate patches. This
> makes perfect sense, which is why this series now contains more patches.
> 
> Additionally, these reviews identified issues in the adjacent probe and
> removal code when active sensor instances are present. I have addressed
> those issues in this version as well.
> 
> v3:
> - Address comment on patch 6/7 by Shashiko on useless goto
> and suggestion to remove sensor_hub_remove_callback() for
> err_remove_dev_if.
> - On patch 4/7 : HID: sensor: custom: Fix state lifetime during removal
> Rename goto as suggested by Jonathan
> 
> For using guard(), need a follow up patch as that will be a cleanup.

Now in hid.git#for-7.4/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

