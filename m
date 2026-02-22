Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB721139D0A;
	Sun, 22 Feb 2026 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771757227; cv=none; b=PXQpwz4Q4a3rybYNLOhditHAlXK+JQNjctN22C/EtltgCFq3FOy3hKqw/mnnjDnqpGEvM4nUF3Pknpo/yReLiGozQ2i5y0WsQJrCn71U66Yiw1gGJqXvzzAeV4fvHga+80dLNfP2GYPNr734C8Xl5FKIu1YHaehoTyRmQSJDv8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771757227; c=relaxed/simple;
	bh=jyTe6/7585xOZslPuWrnHhgQCpQ+tubMZunqtQG4ZII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8l4QN6GJ6i4+3Nj0vJCR6pm0SJq5jkF6G3m/3oiRrybCerziuXBSJUtR1QVvt6V5f7F4B9Y42kY8g3m3zONBsNVdqhRBGoKKp8PP9EX12P9Vw2lsRJHEI8BzSYl6dTtgQXcdMavjuhQOsMfibLizSv2xtA9JDRDLzyM4PWp9K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNo26T/T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNo26T/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB5FC116D0;
	Sun, 22 Feb 2026 10:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771757227;
	bh=jyTe6/7585xOZslPuWrnHhgQCpQ+tubMZunqtQG4ZII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HNo26T/T5BS5fsQBmmyRjZuTL5hyBUpU8SHPk3gLGpD/ps7mCozJo/yAmeSJ2YarE
	 sharBFjKJRusOyOwYUGxFU95oJkpUvddlCCy6ppNu7qw3ZQOOsbn5t+zeGtGDDDVgE
	 dwcJyC/0QK6N6n+lfMevxTpZF+GXOiLCHZGt+9TqHOfnDZK9F7uRYREpVcSLwSIzvv
	 EYwJwAh8oYMQyQi4WyB4JTYHr5a4wfDROUylY0xr4yidFFBMjf5BA2WOpt5dlS6BfM
	 umRTwhXo3wYArxCSaENRDNsqZAXpTNfNitO3SGNigAT0SKBvhkaLaPINiCv7YCUn24
	 HKGqKS4+jwaug==
Date: Sun, 22 Feb 2026 18:47:03 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Fabio Baltieri <fabiobaltieri@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, Simon Glass <sjg@chromium.org>,
	linux-input@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] Input: cros_ec_keyb - use u8 instead of uint8_t
Message-ID: <aZrep2k3ql_SxtuS@tzungbi-laptop>
References: <20260222003717.471977-1-dmitry.torokhov@gmail.com>
 <20260222003717.471977-3-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222003717.471977-3-dmitry.torokhov@gmail.com>

On Sat, Feb 21, 2026 at 04:37:11PM -0800, Dmitry Torokhov wrote:
> In the kernel u8/u16/u32 are preferred to the uint*_t variants.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
