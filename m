Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794695315;
	b=4t74xw5/yhqONNuVrk88ZG8uV390T6SYZ7i6K/IM+p51HXMT7o6Uwqp9Zawri0TVWJh1
	 N2VKlcf0+BRqgds3ENc9KgyQTmI0U2SfMKVJnC1gc3Z+AhnpiSXZzTX6VrvwTT8HYhWxq
	 599yvFTr71VWYOSdBl+KTeoecMXdQswVCy2JZPTKtTi9d0iEOk1vLiYN5Yqyeius+icqu
	 vscsIdeTe+UUHU9yQiXXjD7lNl45TEkzqHT3My+aQnzGtbplELkwlv3k8/eIMgw26G/R6
	 FTzzZH+/HVzVGEv93O1Jei5HMyF3TjdZCtlCsz8AtGzDxABHF9w1Hc8v8l5oXPl1Z4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794695315;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=amtvkjecZUJs+R0mWozouJwuNAC0XUJNlgsIkhNFk0g=;
	b=0fvURHJpW5LeFFHx2IQ7mh5nKfmvmFJS0dg2Nd5CtccQcta1wjn7ogEgQEzkBFMkxcIV
	 PXC/ylNIDZttrd8ao2v9xOAfB8ibkSNZXuWoYUVhkk+ZI8ffQqZT03jprajdsrb1o5xEx
	 F5WbEmAinV44qd8cDqZpU9+tF8u9IOiVsL0pTi4L+5s5bxD1OjcoTXGLF4Bgm+mmvI+FF
	 a8MAEWt8jqDQfvADTzVOQC0Db1JIeWwISf0AskONj6w2mMTyhCJJzAKMeXkqEf/4+VOLY
	 79zlQSFGYIpptDU5CeLu4XaJqXFZoSq2Mmtl2np6cjzAreybQmaKSlt+/apabcvmpnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l8Bsi8+K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5244A606A323;
	Sat, 14 Nov 2026 22:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l8Bsi8+K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A71E1F000C4;
	Sat, 14 Nov 2026 22:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794695314;
	bh=amtvkjecZUJs+R0mWozouJwuNAC0XUJNlgsIkhNFk0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=l8Bsi8+K0rRyU3m+KXzKHeY43sGHb+2EWZU9IPusJdZaykjj5+tUW91uVFNiXxkmc
	 znRX5g37Apg6pouCzRKAshXDB9NZGprwHd1R6T7bZEQEe92HswC5N+XolLQCtF5VXx
	 fLnADucnhynNWgRPec6anXcdxK6fNS5jb7lsVSCQ8ZCMWHDCkz4CcvVKHmEjq1CxM1
	 82pEJp6rR7cOzhyrUtlECxgQ6DxkS8na08efXvu78jR0FvwFp6w5eXiZ70F56KxklC
	 9kcncCE+97ZIC3vF8cVwWOXEpq9RDjO9r6hOxtHfx8GNcZyHDCw+T0vh6heyzXruYZ
	 2SDezhqDdY/AA==
Date: Sat, 14 Nov 2026 22:28:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 simeon@maryasin.name, lixu.zhang@intel.com, crofts@kernel.org
Subject: Re: [PATCH v3 0/7] HID: sensor: custom: use-after-free after remove
Message-ID: <20261114222827.4213d48b@jic23-hlaptop>
In-Reply-To: <20261109195949.384888-1-srinivas.pandruvada@linux.intel.com>
References: <20261109195949.384888-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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
Content-Transfer-Encoding: 7bit

On Mon,  9 Nov 2026 11:59:42 -0800
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

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

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Thanks,

J
