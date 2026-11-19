Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795099101;
	b=gAA/XCO4594BATE0W9xhfzRBYoMHNRVcXxMHGmqEF6oE6UE0nMjU3VEqDxcnw3hz8yHT
	 bJzk63bmyqJg8Ut8kR8K+72VdjNGXifZ9De5YHlBGXuETOlfnK7bsF2sxEZ8ejfdWLyAF
	 DjgkoVRWgz3X75YMsp9w77G/bxA/wj6dE6rk3L+dsrWJrLxKr0tIPLbAWZ/h7KAqDr9Rt
	 Ty36Cg21Nbaja7Mzq/GKqs9DeJgDOUJqmtujQlLv6eVvjR2SkfjEQj2YYTMSjOWuuC1s4
	 TR3YhYFxQj3MlQKoX93+gMnlb4gxFllHpbyYqXSOz+NFpkFAhaTNbHlyd2n1EuqFgEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795099101;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+8eql71CcVH45amzkfTa8BIODfJBUPebSoLQLTVMx2A=;
	b=uXIwP5w95qZAVNVWvmEBgQykHEFTg+KfiIAUZz8Z7Ipuy3PcfvRooDCRyF1/aaklTWUL
	 DTA6NtbcJlaMgkMCcCOu4q7CrOykD1MDcWVBMGH6nmulTKHXU5L82KB6kDUAUbZ7HHrnt
	 a0JrBilNaQpdomCqJzfiCEXChZexbpF8PYl8b95GdKOfAexsjRgDmxINgFBFHqrDWYwRE
	 JbsUyaqkw1trmrxbtCETtJBY8s87ZKP3sZ5xFpOs4aZSJ4Qu95ZEO+L9RXzP4QsiyYFZ2
	 sX0FrNZsIG6eKsoY7Ah16xZjn98IXAGn/X0FIXLhwvG3WVTmos0b9EMPiQI2p5F/U2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AzCFqMBu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB82606A324;
	Thu, 19 Nov 2026 14:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AzCFqMBu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7CF1F000C4;
	Thu, 19 Nov 2026 14:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795099101;
	bh=+8eql71CcVH45amzkfTa8BIODfJBUPebSoLQLTVMx2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AzCFqMBuh+7kRhUB3BW6WTHfGeMPYkDmFs4o5Oc10QPgF+6En2WXulYBJk8vNdF7V
	 u+mlI4yFeHf4Fn4SdXHv6ePQiC2IqXgAWIkbXF2xUfXKHAYX5cfuossOiFOtQb9Wr+
	 WLm7sf+DMOeqhUVz3LP9rFvlsQb1TQd/FoxoX0DRuuOH3wv/5v7+HGRPQ+LUY4CygP
	 yJ/mxddHJbtPdtF4eg+4GuIIzBbBiCcR4Lu/h3MS21C/3XMBPEpXk1y+3697Zzx6+5
	 f6S6BAOcIVmusDEHRlxLsSciTco636DEytjrtOCDpwSPvDEt6QDHrtzF1yt1rd/ByC
	 yqUG3wsXW5mAA==
Date: Thu, 19 Nov 2026 14:38:15 +0000
From: Lee Jones <lee@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Ijae Kim <ae878000@gmail.com>, patches@opensource.cirrus.com,
	mfd@lists.linux.dev, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mfd: core: Reject failed IRQ domain mappings
Message-ID: <20261119143815.GT98456@joneslee-macbookpro.roam.internal>
References: <CAGEsz8Gb=4JS4OAFKppe=LW6JYa2ssJ8APdJJX2Ou_BhzEvZxg@mail.gmail.com>
 <CAGEsz8HEtP7c-JSV=LvhTH9k5uRxq4z+4GgypbE-gmCurghong@mail.gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGEsz8HEtP7c-JSV=LvhTH9k5uRxq4z+4GgypbE-gmCurghong@mail.gmail.com>

I'm totally confused by this.

Firstly, if this is v2, where is v1?  I can't find it.

> irq_create_mapping() returns zero on failure. Storing that value in a
> child IRQ resource lets registration succeed with an invalid IRQ. The
> child then fails to probe, and retrying its probe cannot repair the
> resource after a transient allocation failure.
> 
> Return -ENOMEM through the existing resource cleanup path when mapping
> fails, before registering the child. Leave successful mappings owned by
> the IRQ domain provider, since other consumers may share them.
> 
> Fixes: c94bb233a9fe ("mfd: Make MFD core code Device Tree and IRQ domain aware")
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> 
> ---
> No hardware testing.

Where is the diff?

Did you hand-craft this patch?

> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index 16ad4fd26..e00f31402 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -255,6 +255,10 @@ static int mfd_add_device(struct device *parent, int id,
>  					cell->resources[r].end);
>  				res[r].start = res[r].end = irq_create_mapping(
>  					domain, cell->resources[r].start);
> +				if (!res[r].start) {
> +					ret = -ENOMEM;
> +					goto fail_res_conflict;
> +				}

We can talk about the code when you send me a patch!

>  			} else {
>  				res[r].start = irq_base +
>  					cell->resources[r].start;
> 
> 
> On Tue, 10 Nov 2026 02:32:49 +0000, Myeonghun Pak <mhun512@gmail.com> wrote:
> > Hi Lee and Dmitry,
> >
> > This series fixes WM831x IRQ resource mismatches and follows Dmitry's
> > request for managed onkey IRQ/work cleanup and MFD-provided mapped IRQs.
> > The provider and consumers are converted together to keep their IRQ
> > resources consistent.
> >
> > Changes since v1:
> > - Use managed IRQ/work cleanup instead of storing the onkey IRQ.
> > - Move IRQ mapping into MFD and update all platform consumers.
> > - Reject failed mappings and unwind consumers before removing the domain.
> > - Retain polling for release detection; the chip only interrupts on assertion.
> > - Drop the previous Reviewed-by tag because the implementation changed
> >   substantially.
> >
> > Compile-tested with LLVM, W=1 (arm64), for all 11 changed C objects.
> > No hardware testing.
> >
> > Previous discussion:
> > https://lore.kernel.org/r/atJycIEnUZKVdTjW@google.com
> >
> > Thanks,
> > Myeonghun

How is this in the patch?

Sorry, but this is not acceptable.  If you want to provide additional
context, do so in the cover-letter, or at worst below the '---' not
tagged on to the end of the diff like this.

Try again please.

-- 
Lee Jones
