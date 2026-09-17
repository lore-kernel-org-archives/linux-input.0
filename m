Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8F24B1CF7;
	Thu, 17 Sep 2026 10:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639514; cv=none; b=M71GtIcWGnnxf66k8OhVotTo1u4w+YzbOdN3gNNi7yOnUFYj6OthFfJi3P9+syeAcbsz33Ldiyj/eRDfOCm+qeZhhRQFnM/WvN+ui7K8IF/1jLpA7KPzQJ3GkZ+EOniVQnnhU/EYPChROzHya6a2akxlWzTQg8L4DemGlo7UO10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639514; c=relaxed/simple;
	bh=8twaT9zLI/VWKHo/Ti18avE0HnBxOYc5otwq7psWXaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmsT6D+9mw87m0h5r9m4u+WJoV1CeF/AUBDD/gFpmMsmQd/u+8Dn2Hv8wY5s/Dv6scK3biyzAmGt0JK9V6c7qTXZ8KWa2BnxoAGpWhPjolLXP/Tqng/u6gvGhuJcxDaULm8n/g9TZTeT6dDTmDvIp9b77UcfQLUHe4PoNW30h70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6yP7X8Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6yP7X8Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1760A1F000FF;
	Thu, 17 Sep 2026 10:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789639499;
	bh=Jbm4chty2zYyyLMXqcWCL6EkoK03pWrHLt0hOsiDGns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c6yP7X8Q0UqQoGqQHlZEAfYr2HaADgEEOz9Hc8hhZj6Kt13UlDqvEVSzH5lGPysqt
	 UeR8nBuHUktjqDP4q8d0ZHOMOavagMRkvKbM08AdhgOqfJQHqv4h1MONi7bn0rhPCL
	 /ygclqhTvcqwrKDbdqy/ovrpb27tuazxIPS3s+Fvea31QBpkz1u9bfh0y472KHPZ53
	 NVATpWWa9Zl2CcuHu8gDJ54kH/4qyMidW23idvEzLwbWbwEnenbhgOr6ITXYwzctC+
	 uL7GqhlVRU8qUHVRVZTwq3VUCOQ4phsX1CQOiDLXaC1d+Uqc9lUCOzoabi7j5D13kY
	 jzIvRLjRHCIkQ==
Date: Thu, 17 Sep 2026 11:04:55 +0100
From: Lee Jones <lee@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Michael Zaidman <michael.zaidman@gmail.com>, jikos@kernel.org,
	brgl@kernel.org, linux-input@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] HID: ft260: add UART and GPIO support, plus I2C
 fixes
Message-ID: <20260917100455.GG1605367@google.com>
References: <20260827205116.GJ2943942@google.com>
 <20260827222550.24634-1-michael.zaidman@gmail.com>
 <apaLLD4ZXhNV-Dph@beelink>
 <CAD++jLng_gdqoehT+c8sXoqy+tdUc7eAXXpAvhC_zJZwnX5tzA@mail.gmail.com>
 <20260916125806.GR11487@google.com>
 <aqucXBi0Fmq-tCWr@beelink>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqucXBi0Fmq-tCWr@beelink>

On Thu, 17 Sep 2026, Benjamin Tissoires wrote:

> On Sep 16 2026, Lee Jones wrote:
> > On Mon, 14 Sep 2026, Linus Walleij wrote:
> > 
> > > Hi Benjamin, Lee,
> > > 
> > > On Tue, Sep 1, 2026 at 4:03 PM Benjamin Tissoires <bentiss@kernel.org> wrote:
> > > 
> > > > TBH, I'm not a big fan of having multiple subsystems children into HID.
> > > > Mostly because I can't review the best practive in each of them. However,
> > > > for quite a long time, HID was mostly for input devices, and input is a
> > > > different subsystem.
> > > >
> > > > That being said, there are 2 types of HID devices:
> > > > - ones with defined standard usages (keyboards, mice, touchscreen,
> > > >         battery, etc) and using MFD for those would certainly be overthinking
> > > > - others use raw HID device with a custom protocol (cp2112, mcp2221,
> > > >         ft260), these could be MFD candidates
> > > 
> > > Surely, as HID start to attract chips which clearly fall into the MFD
> > > category of things, with a plethora of subsystems hooking into the
> > > same HID device, we must find a way for HID devices to spawn
> > > MFD cells?
> > > 
> > > MFD solved and evolved a system for handling exactly this type
> > > of situation.
> > > 
> > > Whether there should be an MFD device in the middle spawning
> > > each a HID, GPIO, I2C, UART cell or whether HID device itself should
> > > sit in the nexus and gain the ability to simply spawn out MFD cells
> > > from itself is what we need to figure out.
> > 
> > There's no figuring that part out.
> > 
> > If you want to use the MFD API, the part that uses it must reside in
> > drivers/mfd.  Else it becomes a nightmare to maintain and things get
> > wild, quickly.
> 
> Historically speaking, HID devices always have been under drivers/hid.
> They are usually leaf drivers, only hooking to input/battery/LEDs.
> 
> As mentioned, hid-sensor-hub is an exception but this got sorted out by
> splitting the HID part from the IIO.
> 
> Looking at the various MFD-like HID drivers, they all share the common
> point of not really being HID devices: they rely on a custom protocol
> handled in .raw_event().
> 
> So I think I'd be OK to have those drivers moved to the mfd tree as long
> as they only rely on low level HID API, and do not have to deal with
> "generic" HID report descriptors. If that arise, I think we should split
> the HID/MFD parts like hid-sensor-hub does.
> 
> So you can have my unformal acked-by for transfering those drivers.

A couple of caveats to this:

Only the most basic set-up parts need to go into MFD (shared resource
allocation, core device initialisation: clocks, resets, regulators,
IRQs, etc.  Anything that does a 'thing' needs to reside in the
applicable sub-system that supports the 'thing'.

Device need to straddle at least 2 additional subsystems to qualify as
an MFD which undoubtibly would be HID and then something else: gpio,
regulator, uart, iio, clk, what have you. 

> Last, I'm currently using a cp2112 as a i2c-hid bridge in my upstream
> CI. It's relying on a DSDT override in the VM to actually work, and I'd
> like to keep that around. So my main request here is to keep the
> equivalent of the DSDT override in the MFD cells, at least for this one.

I have no idea what that means, but we can discuss it.  Maybe this lives
in some form of platform data?  I'd be able to advise better when I know
what it is.

-- 
Lee Jones
