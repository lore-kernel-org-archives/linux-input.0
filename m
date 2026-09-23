Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55775391E44;
	Wed, 23 Sep 2026 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182130; cv=none; b=cCth3QHMlsa6DeNMHBu3eLdJS29gC50pmeZ/FSU0U9fJPdklFwflZLLWT1ha0V/suivayOMkkuZROuokwPtjnQSGo2QM0ArsD8XVBxnmldqCt9jC+QzosKNZS/2rc3IvgK8AQN/Rq3XSzE69A2phmDSYpzvNby5Zih1bnzGkh0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182130; c=relaxed/simple;
	bh=BYIcpqAK16u8g+M1ivZG04ozTWXFHJj+IGRrNdFggnI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LmGosnYTeLMp/Fne4fw/I27hY7xCo9piI9OARNUfxcznIzYdCgxS9LfK3l8Z4/m7MFlryfxBbs553UX/jib0bJaWjpNPKFAmwxbT0DYLZ06EM0XT5SLgfh3i0+ZCddaY6iFBm3odpmotbkHnN1M5AF6QkovSxwwZ7zTEKHDitEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/xOVlLM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/xOVlLM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEE41F000FF;
	Wed, 23 Sep 2026 16:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790182128;
	bh=tE52/jnXHmgC9c9ae7W6XJ5JCQheopPCzSagzGWBE6s=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=d/xOVlLMkNP6XYktVSHYJIuf+3XfEPlcz9zLYPUIqH/6OavnsW3B1ZsSgON76BXoh
	 IZPivHP9d4boYVrMU9TWMmBJXxw1TIFzwO80TXbOnxGTZ4DQKZcNmXb7Hc3s1T4yNK
	 4+ZC9n8JIM57CJIRnXn4xAg9+tjpv9FpbuVD+bbY0V9HAFSSNQJVYl7WpGaajCB0DM
	 a708L+wynsXSzLBXWHs2SMWV6sw49kn7f3SDB2MFFYMF1mP7XEBr/J79DzFBo5sIqy
	 t4n4PNUvKfDdPJXBIu3eiPAviuMBzGCrIxBbg406u0uSJ9/KHwnB81MVtIFRwf+Po6
	 19+NxWpiFQ06w==
Date: Wed, 23 Sep 2026 18:48:45 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Even Xu <even.xu@intel.com>
cc: bentiss@kernel.org, srinivas.pandruvada@linux.intel.com, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] HID: Intel-thc-hid: Fix potential buffer overflow
In-Reply-To: <20260922024638.932865-1-even.xu@intel.com>
Message-ID: <86p88s15-qp61-1pn4-9308-5po75rp7q192@xreary.bet>
References: <20260922024638.932865-1-even.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 22 Sep 2026, Even Xu wrote:

> This patch set allocate enough space for both the payload and the
> packet header for quicki2c and quickspi input and output buffers to 
> prevent a buffer overflow when the payload reaches its maximum size,
> as their sizes are currently calculated from the payload length only.
> 
> Even Xu (2):
>   HID: Intel-thc-hid: Intel-quicki2c: Fix buffer overflow
>   HID: Intel-thc-hid: Intel-quickspi: Fix buffer overflow

Applied to hid.git#for-7.3/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

