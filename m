Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F06C49C4A5;
	Tue,  6 Oct 2026 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302125; cv=none; b=Fw5KFfRwJpqSR1rLCzOYfPVzBOJ7tZF4mV0scxC56XX0oNzgn7WIPowt9kHK3dWVL79dp7tBsZ/otwEjeZSQDaT5PyqZvBfwmTStsW7kx1xsJuOkAL6WbYzjg8dKUykMHiCtTvDqukuhNbdFxfjAFYDhvGdYQ7SEE9OMZlkJYhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302125; c=relaxed/simple;
	bh=HE3418bO7cAKAwdWb2y8lfO4eUbtKhBn0NnLcoVcdYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQEkFa/DJ0Z00+DhTqnPUunJ0gIlvBO76EyeV013FvaqGch9ayYs32fp0m+gZOoUCnGvydes5F/QwuYKR8n7t67KtEgkoBLiS/J1XGui6T7KRbDgnrEo1Q5RK6AOjMRQWmFF5Wei/0D+JV0Mb9Q+VXG+tUOySLLDXjB+aDx6J+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnzIo1+T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnzIo1+T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C4C1F0089B;
	Tue,  6 Oct 2026 15:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791302124;
	bh=1fkl/Jj9ydf8PXJruNkZkOdYK5N7nJjHeodLNEE5XJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WnzIo1+TBh8goDe8OxLSELwGQB+lfy9DSLQTR1RyhjJmYZJ7filX5XIdGI6Fn6+Ga
	 31q14emKNWnFqnJkdgZURYvsLqRU10mUE5sXiSmzUhUACAHjG7IhWFc+2Y6HHRYfE9
	 ANM44cMqJDCLQ0pEfYJZ4QjuSXwGHLHEF1AsLLA0YMMdeORctv8L6Es82mtacdGemN
	 H4gm0dOtDktmEq7ODl5rJa5hNBj88vMYBx3gdsTL3Kzir1pLwtWU6qjWSC60a6JmZd
	 mzefn4WrjYvQm6GbQ6Mtd7RX4yeCiTtUACaD27WW7rRQLw0iQrOBv/F2xHjFNPuqA0
	 OwhRzYyLIiHHA==
Date: Tue, 6 Oct 2026 10:55:23 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michael Reeves <michael.reeves077@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Julian Braha <julianbraha@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Yureka Lilian <yureka@cyberchaos.dev>, Neal Gompa <neal@gompa.dev>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Finkelstein <k@chaosmail.tech>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>, devicetree@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Janne Grunau <j@jannau.net>, Sven Peter <sven@kernel.org>,
	iommu@lists.linux.dev, Hector Martin <marcan@marcan.st>,
	Will Deacon <will@kernel.org>, asahi@lists.linux.dev,
	Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v4 02/10] dt-bindings: mailbox: apple: Add DockChannel
 mailbox
Message-ID: <179130212273.2406323.10596921268948570337.robh@kernel.org>
References: <20260925-apple-mtp-keyboard-final-v4-0-304c267518f4@gmail.com>
 <20260925-apple-mtp-keyboard-final-v4-2-304c267518f4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925-apple-mtp-keyboard-final-v4-2-304c267518f4@gmail.com>


On Fri, 25 Sep 2026 22:09:29 +1000, Michael Reeves wrote:
> DockChannel is a FIFO and interrupt block used by Apple coprocessors
> to exchange byte-stream traffic with the AP.
> 
> Describe it as a mailbox provider for HID and serial clients. The FIFO
> interrupt pair is configurable because MTP and DebugUSB use different
> pairs.
> 
> Suggested-by: Yureka Lilian <yureka@cyberchaos.dev>
> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> 
> ---
> Conor's v3 Reviewed-by is not carried forward because this version adds
> the apple,irq-index property.
> ---
>  .../bindings/mailbox/apple,t8112-dockchannel.yaml  | 88 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 89 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

