Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C599D345CAA;
	Mon,  9 Mar 2026 18:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773080510; cv=none; b=FT1l0SkdXEdSeBB0EEO7T8eKNd58To8tKAP2JpQiH9ja6eeJfQbUf5DFnzN19JkYmV1aQiRKFPPaOIEPt3CTEsaz2Z6JkenqnXH3HrLnZkc3ObtQy5ltJCNS6Z5OOTUMsL0EF0RQRhlEFp4b90myGdrKh8XNIoB6m2Dv8O3+Wjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773080510; c=relaxed/simple;
	bh=AhzJup4FGxhmrZeX9UGvsuHLYgt55HtGCy3bEWb8xB0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dN+LIh8skmNKtcxLSqbIf+5YMEn0BfzW6xfxlvH2ghGLtafvjLutWzOTj7r0xT/hJoel+6ON1q3hRim80CPAPlb55ik6VFV0WsSYkEDPqbfW9q3rbaQWPxZS7EDAOWEZloRJ0cQjr2DQYyBxDi84PHmQY/bBM1P5BA3JjUr61Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nU1Aa+WG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nU1Aa+WG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B709FC4CEF7;
	Mon,  9 Mar 2026 18:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773080510;
	bh=AhzJup4FGxhmrZeX9UGvsuHLYgt55HtGCy3bEWb8xB0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=nU1Aa+WGuq2HAwAzr9X0jTiE0LU8XvMhspnOtQWmyPxsJvbT8LTOaA0ATs2ybcral
	 HpKseFPG9hU1IcV83X9VGJVBQaUxxRVfOHZLSFooU0uUqc0I8zz7f6KdnqCQwRSWUx
	 lCSDUdevBpsdTrkIPjiOCzHiDRMU03LX/lg8M2ljU3xdEcrEV5w0z66UZQ04UTWhjU
	 R3ommc7u2n/UR50NzyqQx7YKYYyhO1ecWfO/0gm/ctuuSCg9mDoZKyFDP1LRp4QACv
	 BbJkf6vRbUC0H6x5yEN+vemXCBvs3in+pnyRu9al2cdXRLW1FIKNcLUB4GMSO7IwRq
	 chZ2QMtc0tE6Q==
Date: Mon, 9 Mar 2026 19:21:47 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: input: use __free(kfree) to clean up temporary
 buffers
In-Reply-To: <aaPIp-z92hMsI7J5@google.com>
Message-ID: <s02p88n6-p0p5-pq32-p609-884ors6335nr@xreary.bet>
References: <aaPIp-z92hMsI7J5@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 28 Feb 2026, Dmitry Torokhov wrote:

> The __free() cleanup automatically releases given resource when leaving
> the scope, so use it to make the code less cluttered with error
> handling.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied to hid.git#for-7.1/core. Thanks,

-- 
Jiri Kosina
SUSE Labs

