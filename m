Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B77D18C02E;
	Mon, 12 Oct 2026 06:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791786279; cv=none; b=TqziCRBlRzoS2Z0sj3sehIpZknaqdAnKiNTRVpIts9C10zOBTVvtnxagpVPYr6vhNnSzFIWWEbbF4NJWWeD3jxSNPhuJw+KkZuKx5sdEg6N9X2biPY6tEPxQ8WMKbtSuzfC2P2KFUkzGdVurz0POIlXA1OOdYoHSJKVNL2S2eOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791786279; c=relaxed/simple;
	bh=/RQbZ5/sUYQWawqvcXx55XHw3NFhGIJGSTIO5l2ExpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYDi9nbuJ+P6DzPd7aU2FKE8Pq2aVfkM9KvIRO42KnGz70qy9yBiZqYWytixd9+SzFOd/fm+uho+IN8X9x9FQ6mJKAt9SP0CA11JGUsb9Ooke2qlDuyuB6+7jLIWlOZWjV0g/WMJ6xNSws3GqjyeVHLjQL0xLzNDK7Jj5vYhqMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcYp4eQu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcYp4eQu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08B51F0089B;
	Mon, 12 Oct 2026 06:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791786277;
	bh=Lu7lzrmvKCJs5PH0Sflob7Z+uS95//5XE/N1Xwr88KM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RcYp4eQuEYcAMD6xkeBPLjgC1mIVdD04K1ulgyGhexmFp3qyWpiN2boc3C/KGQDcW
	 p/Uc6r2pa5XyHnE9ftixzj4KhKydrIkX/COHXuGYshCKqBUCKds3WGdjLzC75QIBCr
	 YZCwliUZKpwij+ostTIQP0x5T7bkC0j4CaluJFIsqWRMwMfQJH8hHwaUQ2FTsQHOmU
	 0HJgOcQz6Dyldyao6r/N+mcCYfZLgSaexJUmyXjx0cJBlOQdcSOwhPK4Recj8GUFuF
	 6uSj+hyxMnMULf2fl3SeGAckYkPIlsAe6aKt5Wlhp+tE3HkbAOyUrb1XLUrxAGtZYJ
	 weUYU7F9QV1/A==
Date: Mon, 12 Oct 2026 08:24:34 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: wyibo6109@gmail.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	linux-input@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: input: add OnePlus pogo-pin keyboard
Message-ID: <20261012-weightless-meaty-fennec-cdce10@quoll>
References: <20261009122046.551915-1-wyibo6109@gmail.com>
 <20261010143836.173883-1-wyibo6109@gmail.com>
 <20261010143836.173883-2-wyibo6109@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261010143836.173883-2-wyibo6109@gmail.com>

On Sat, Oct 10, 2026 at 09:38:35AM -0500, wyibo6109@gmail.com wrote:
> From: Yibo Wang <wyibo6109@gmail.com>
> 
> Binding for the Tinno keyboard MCU used by the OnePlus Pad 3 Pro /
> Pad 4 and OPPO Pad 5 Pro smart keyboards, attached to a tablet UART.
> Describes the supply, TX-gate and wake GPIOs, with a MAINTAINERS entry.
> 
> The touchpad is described through the common touchscreen properties
> (touchscreen-size-x/y, touchscreen-x-mm/y-mm): the MCU protocol has no
> way to query the touchpad geometry and the same MCU is shipped in
> keyboards with different touchpad matrices.

How is that possible? Same OnePlus Pad 3 Pro has different matrices?

Best regards,
Krzysztof

