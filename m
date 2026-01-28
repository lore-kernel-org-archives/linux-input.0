Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E5E350A3B;
	Wed, 28 Jan 2026 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769608169; cv=none; b=uOIjyq3srM8ALH7V8iWi85Ojkva8vWp2PCHd3zfCvTiC6DvV0xfli4wgUomJJZQ6qe3f8HABT2wyz4VHQiqxo9s4iVgKQhhO86FgmYz0uAT/WpsGiocn/yh1n1iQrZsVRf6qAWtCtADLliQkJ3aQwh681Em4xXjGququJ4wAZKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769608169; c=relaxed/simple;
	bh=jY+7nyOj3bjl3JgHt5hwdkbBRkY9nbAm5GIvMZ0fCOE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EKJrnvW4d6278PCmpY6dSHNw/pY5/YBqAflvnrDE+OHwOPraV1HM7hspdBNjbs0Ke3696Mk48uGeD340cuUVzsJjWAHbVdIvRbritnt9hjzfxjImL0NdQE83Tr7YzVlBhaGxTUX0Jx+Fo4Hhm5YLir9OpA9PDdpl/jmG82W7iBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQs/bBOW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQs/bBOW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3EAC4CEF1;
	Wed, 28 Jan 2026 13:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769608169;
	bh=jY+7nyOj3bjl3JgHt5hwdkbBRkY9nbAm5GIvMZ0fCOE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UQs/bBOWvaNexPKKPEg4kaFW8U2MGAa4937kwFHYMpTut/VljcIeHLWvBgSmT020c
	 PBKzC8VgYEwM/o3RM3k1O/y675u/vnLCUBFEQlawaXrA83B7os4Ji5HxEeRLS5E5JO
	 DzsoslN7+gIFpBsGfv4ztvs7/HDC6FjuHaPIULHpVWLRyBT5ogQRqwtkyBXKt9CgCd
	 +Z6Ro4qgY5gcgmsLx9ETgWd1mi5l5aEShgdWRUgee6WLyCv7jgAhFRq8qjRTFYzjLo
	 j52ij00a3chvgRlHoxvYBj97oAllWS06tbOMmjheBTKso2K2MiX0I2Ri0S4fe8n09M
	 spv9tYn3D8Ytw==
From: Thomas Gleixner <tglx@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>, linux-input@vger.kernel.org
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, Cheng-Yang Chou
 <yphbchou0911@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Frank Li <Frank.Li@nxp.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Jinjie Ruan <ruanjinjie@huawei.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@oss.qualcomm.com>, Marc Zyngier <maz@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] linux/interrupt.h: allow "guard" notation to
 disable and reenable IRQ with valid IRQ check
In-Reply-To: <701e739d-2e82-40e7-87b5-b4ec92903af6@mailbox.org>
References: <20260121232522.154771-1-marek.vasut+renesas@mailbox.org>
 <87sebrbenj.ffs@tglx> <701e739d-2e82-40e7-87b5-b4ec92903af6@mailbox.org>
Date: Wed, 28 Jan 2026 14:49:25 +0100
Message-ID: <871pj9alui.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 28 2026 at 13:23, Marek Vasut wrote:
> On 1/27/26 10:14 AM, Thomas Gleixner wrote:
>> disable_valid_irq is a pretty non-intuitive name if you look at it just
>> by reading a usage site. It's not really improving the readability of
>> the code, it's in fact obscuring it as the reader has to actually look
>> up what the hell this means and then stumble upon a completely
>> undocumented lock guard define.
>> 
>> I'm all for using guards, but using guards just for the sake of using
>> guards is not a really good approach.
> I wouldn't even be opposed to converting the ili2xxx driver (the piece 
> of code in patch 2/2 of this series) back to simple enable/disable_irq() 
> . I am not particularly on board even with the disable_irq lock guard, 
> or more specifically, lock guard used for non-lock things like this.

I agree that guard() is a slight misnomer for such usage, but this is
about scoped auto cleanups, so using it this way makes a lot of sense
when the scope mechanism is sensible.

Thanks,

        tglx

