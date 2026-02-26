Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA26242D98;
	Thu, 26 Feb 2026 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117552; cv=none; b=ha/0SniXP+gajYSjVl6mn9JLQN+PPWJdlrF5XNbV8+0o9sfdGpVA50y9lz7mTjNW6vVxSBH09SeVNNbebx4q1+PzSAj1sni9CIz+Ez6toM6hRCJeeIfehspaV6kNc4TejrgEMOT9S7A1rvSjFCIA0k05VK40ItZ3vVI02+uVw8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117552; c=relaxed/simple;
	bh=krAAC570ADURijjr2s8f11ll1iLfDjE1T4upfwoQ+pw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=f6tmfpwQKwwLsssx6I0hfqCzW05z3wJpV9e78FWscpVXqA7cpow6Ga9Be9D+8IaVBN37wbILu0EoIYzoVXCe92qOJy2nyaYMDB5BjPt/lYupKq6S4jYMzwMBaMw5tq+Ki5cuO7oDdQfQvg3UbNtoFqPWH9ptjIc6+OY/+aEk/ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwJAW0Hg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwJAW0Hg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CD0C116C6;
	Thu, 26 Feb 2026 14:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772117552;
	bh=krAAC570ADURijjr2s8f11ll1iLfDjE1T4upfwoQ+pw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=JwJAW0HgrkYu+H9CbB/Br5i5OSsxqP/X9kMvVxkmT/camnTqrX7XLBqaTMw8xgdN8
	 dqUE2/rjncyyT2wxwAl4q9CRAGMCLMLrBCE5969aSd+0aRD/VN16OHaYQ/5NmTO5Ke
	 UzKKllVA6HWOQKYo8gszbqJfPQx69+c1VkxHJ2/DJgalrpjLXVFGJM3KVjjestHjVY
	 BbrREOF6X1FaeWbDApbKm7ewP2LEy/RsfEnYpLVayPJ1eggFU0UHmnuz2kYSWH8+uV
	 zco4etLWf4z+Lx31A8k0w7PJCCf6m61EwaZ8f9tzg4G2G1FBgdaDFb5E4RGZQbH/5Z
	 reh9vUVdjn6xw==
Date: Thu, 26 Feb 2026 15:52:29 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Doug Anderson <dianders@chromium.org>, 
    Langyan Ye <yelangyan@huaqin.corp-partner.google.com>, robh@kernel.org, 
    krzk+dt@kernel.org, conor+dt@kernel.org, linux-input@vger.kernel.org, 
    devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 RESEND 2/2] HID: i2c-hid: elan: Add parade-tc3408
 timing
In-Reply-To: <aZ_SqXA8ad3SAD3J@google.com>
Message-ID: <60oo865o-r0on-n077-6n06-s45802o2q32s@xreary.bet>
References: <20260108063524.742464-1-yelangyan@huaqin.corp-partner.google.com> <20260108063524.742464-3-yelangyan@huaqin.corp-partner.google.com> <ffqvva5kgyh25mpquackob7fnlaxseu5stgevneqynwa7m77b3@totpb762p6te> <CAD=FV=XKqFTNYopxV9H8rnjEYAgDebW42Ot92aZYiex5MP1wnQ@mail.gmail.com>
 <aZ_SqXA8ad3SAD3J@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 25 Feb 2026, Dmitry Torokhov wrote:

> > > > Parade-tc3408 requires reset to pull down time greater than 10ms,
> > > > so the configuration post_power_delay_ms is 10, and the chipset
> > > > initial time is required to be greater than 300ms,
> > > > so the post_gpio_reset_on_delay_ms is set to 300.
> > > >
> > > > Signed-off-by: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
> > > > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > >
> > > Jiri, Benjamin, another I2C hid with bindings...
> > 
> > I guess maybe this could go through the input tree, but it needs
> > either Jiri's or Benjamin's ack? Is that the plan?
> 
> Jiri, Benjamin,
> 
> I am going to pick up the DT binding changes, do you want me to pick up
> the driver changes as well or do you want to merge them through your
> tree?

I think it's easier if it goes all together to avoid cross-tree 
dependencies.
Please feel free to add

	Acked-by: Jiri Kosina <jkosina@suse.com>

Thanks,

-- 
Jiri Kosina
SUSE Labs

