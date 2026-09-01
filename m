Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F0733C192;
	Tue,  1 Sep 2026 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271379; cv=none; b=nX8eVYba4J+a+eVijXHTAoGEiApyrHmwTEoFhzQ049ouvUfgTRONFJw2Bpxmn3SefItsnc8ygXOAUBZb6O9n7d0a/gKcVTaIMff5d7blumG2PjN7+HjYzO2189m6+JBcMRn/yLb6JtA7fkRmcufzfiFSa2r1hSpaekcF7SEhjAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271379; c=relaxed/simple;
	bh=hWUJTaZkCXIjQprvWTtogTZt6wej3aAuj55Iw5RSm/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnuWbE4T43rm0b5ZQop7iLdTnRqdj8D0FWDWhVusNNWemZRu65Av7ml1eQICTb3YbCSrYO5xrTLFnlZOxk7I7u6VB8tSMXGMNXL//IpLQLRt9LZJc1ND/y2p+vevSD5oSJ2p7S9Ap/PpmVYsug/cEF3I36dBBHVxhPB77/EW5iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPtcXMbX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPtcXMbX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D9E1F00A3D;
	Tue,  1 Sep 2026 14:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788271378;
	bh=lkZhtGJry6jaZ3PtQ5+ne71QEsfKiPG+5TwJ1CPt2WI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EPtcXMbXjNCGpT++gWFCoJVKRXqcm61WqqCTVEcJ9zQly3/OaAV9stMwAM/mMfKBV
	 8rgOIQso64094Wp7W7aYTjJWnb2XaTWw1Um1441cJOcyHZdCG4+7uIifUAuMh3U7kv
	 6Hqn2uIASlx5F/32e2Iesd76y2D56sfxYw5PJTWszZQYVdlBeQTVz7Q62SmFc/7o9f
	 I6GLeC1igW80atW8n6CCXqGw2ViY9KQCjsQ4+NWFGUlvD7K/D+KXG16pEd1lZunGib
	 jVDst3diXaUAgaeu9Y5Uhpfrc545X40/ilA9kv/7kLRivfBm7di4WMrZG83He3qxAl
	 oOKL/jojRuAlQ==
Date: Tue, 1 Sep 2026 16:02:53 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Michael Zaidman <michael.zaidman@gmail.com>
Cc: lee@kernel.org, linusw@kernel.org, jikos@kernel.org, brgl@kernel.org, 
	linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] HID: ft260: add UART and GPIO support, plus I2C
 fixes
Message-ID: <apaLLD4ZXhNV-Dph@beelink>
References: <20260827205116.GJ2943942@google.com>
 <20260827222550.24634-1-michael.zaidman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827222550.24634-1-michael.zaidman@gmail.com>

On Aug 28 2026, Michael Zaidman wrote:
> On Thu, 27 Aug 2026 at 21:51 +0100, Lee Jones wrote:
> > That's precisely what MFD is.  It's one chip, usually with a shared and
> > overlapping register spaces, that conducts multiple functions.  This is
> > no different to any other single-chip device or SoC.
> >
> > Shoving everything into a single driver isn't how things are done in
> > Linux.  This should be divided up into the associated sub-systems where
> > each part can be reviewed and looked after by the appropriate SMEs.
> 
> Understood, and I am not going to argue MFD scope with you. But this
> is not specific to my series, so I would rather not decide it here on
> my own.
> 
> drivers/hid already registers other subsystems' devices from a
> hid_driver: hid-cp2112 adds an i2c_adapter and a gpiochip, hid-mcp2221
> adds an i2c_adapter, a gpiochip and an IIO device, and hid-ft260 has
> hosted the I2C adapter since v5.13, commit 6a82582d9fa4 ("HID: ft260:
> add usb hid to i2c host bridge driver").
> 
> So the split you are asking for is not a change to this series. It
> means moving code that has been in drivers/hid since v5.13 into an MFD
> parent with cells, and the same reasoning would apply to cp2112 and
> mcp2221. I am willing to discuss that as its own conversion, but it
> needs the HID maintainers to agree on the direction first, and I do
> not think the UART and GPIO support should wait behind it.

I don't think Lee or Linus ever asked you to do any conversion of
existing drivers. Just show the example on how things should be done :)

If moving to MFD gives real benefits, these other drivers can be done
later.

> 
> It would also spread the driver over four trees, so a fix touching the
> shared chip state becomes a cross-tree series with coordinated merges
> between four maintainers - a cost the single driver does not have.
> 
> Jiri, Benjamin - this is your call. Do you want FT260 functionality to
> keep growing inside hid-ft260, as cp2112 and mcp2221 do today, or do
> you want a drivers/hid to MFD conversion for this class of USB HID
> bridge chips?

TBH, I'm not a big fan of having multiple subsystems children into HID.
Mostly because I can't review the best practive in each of them. However,
for quite a long time, HID was mostly for input devices, and input is a
different subsystem.

That being said, there are 2 types of HID devices:
- ones with defined standard usages (keyboards, mice, touchscreen,
	battery, etc) and using MFD for those would certainly be overthinking
- others use raw HID device with a custom protocol (cp2112, mcp2221,
	ft260), these could be MFD candidates

And of course, we have the exception with the standardly defined sensors
through hid-sensor-hub.c which goes through MFD :)

TL;DR: I'm not opposed to a MFD conversion of hid-ft260.c, nor I'm not
formally pushing towards it. I think we need to take the pragmatic
approach and see if the benefits for it are worth it.

From the description on how the ft260 works and the intrications between
all functions, this seems like a lot of pain to maintain a single core
MFD chip, but not having to maintain I2C, UART, GPIO is appealing.

The question about the cross tree merging is something that can't really
be discussed without having seen the code. Assuming you can split all
the drivers into their own subsystem + MFD HID parent, we could very
well merge the newly additions independently, assuming the MFD HID
parent API is stable enough. The only cross subsystem we need to take
care of today is the existing functionality, but that can be sorted out
by splitting the i2c_adapter part into its own file, and then let the
I2C maintainer move the file into their tree later.

It is maybe a lot to ask, but Michael, can you demo the MFD split on
one/two functionality so we can check which approach is the best?
Ideally 2 features that would be intricating well enough to demonstrate
how hard/easy it would be.

Cheers,
Benjamin
