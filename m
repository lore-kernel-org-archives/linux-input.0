Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934D93B42EE;
	Thu, 17 Sep 2026 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789632013; cv=none; b=Hq0PAcOjCC1ogc567VAdvLDgaWrV7bLWuDDtT3g/v4vAmrHY7KxD3l/gKIByQI3LLKZN/Qromp9IiuOgLyBbfJA7EW63covWLVVUoZyVhx3l5q+o/8c+jWKiXUx3GtZEWqeCK2ClBS0L3GoZzzzvfG1IXzK9TCuZFdEgHuI2y8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789632013; c=relaxed/simple;
	bh=t4eRF8+XBIuFbxJfnNVPbx4Ln4LJwPIhnhzoFSEuVvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByqOSi0FcTe2ItP7+VCVHO+s/t65tvtTDabPkckyIT167SyaY8NYu3zp5nYAsjoEvZVcbBfP0uHpXip1yTh2M4MVbKh4xMlXfG3vZFlFQGqQD1wf7gfgL2srV60NKOJgGt5/bEcImY0Z15Enip6SctIUPkIw09cP7+O7UdbIuYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MS8tPaGZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MS8tPaGZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160821F00898;
	Thu, 17 Sep 2026 08:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789632012;
	bh=uE9UWharQqy5/fAiwBZmsbswzhzEgqPDu8gY7vY8sVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MS8tPaGZgC6kUVPjJLHzxqMpCYM03N/2wB6Qnl4lupTK5ptNWVq17LosxvW15sGBP
	 ehIcGeieeaG/wHDo3v9sYYLhqyWuWejbMqVz2p/4OlYtWzH1RTfDKk25OlKzpktxgY
	 yI3AV1TVMUTkIqdZyR2L8R9W7klFJZ+6E3g9wln7KcVyih9LZTIrQ95eoEAiR5k0Rb
	 NYk0COnOf/tUEwetFCcBVjv7wCbIEhCXhQE4TdVMLz7hJIE0WPo8jS75yBk+eTsUPo
	 js5ugsDU7Tt4bMnm9daNa/ZGBjhbF0jEWauFy7zCyLJMpTqRtD/jcUQq/QpYlfrSll
	 qb0aTtu0JNjzA==
Date: Thu, 17 Sep 2026 10:00:07 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, 
	Michael Zaidman <michael.zaidman@gmail.com>, jikos@kernel.org, brgl@kernel.org, linux-input@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] HID: ft260: add UART and GPIO support, plus I2C
 fixes
Message-ID: <aqucXBi0Fmq-tCWr@beelink>
References: <20260827205116.GJ2943942@google.com>
 <20260827222550.24634-1-michael.zaidman@gmail.com>
 <apaLLD4ZXhNV-Dph@beelink>
 <CAD++jLng_gdqoehT+c8sXoqy+tdUc7eAXXpAvhC_zJZwnX5tzA@mail.gmail.com>
 <20260916125806.GR11487@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260916125806.GR11487@google.com>

On Sep 16 2026, Lee Jones wrote:
> On Mon, 14 Sep 2026, Linus Walleij wrote:
> 
> > Hi Benjamin, Lee,
> > 
> > On Tue, Sep 1, 2026 at 4:03 PM Benjamin Tissoires <bentiss@kernel.org> wrote:
> > 
> > > TBH, I'm not a big fan of having multiple subsystems children into HID.
> > > Mostly because I can't review the best practive in each of them. However,
> > > for quite a long time, HID was mostly for input devices, and input is a
> > > different subsystem.
> > >
> > > That being said, there are 2 types of HID devices:
> > > - ones with defined standard usages (keyboards, mice, touchscreen,
> > >         battery, etc) and using MFD for those would certainly be overthinking
> > > - others use raw HID device with a custom protocol (cp2112, mcp2221,
> > >         ft260), these could be MFD candidates
> > 
> > Surely, as HID start to attract chips which clearly fall into the MFD
> > category of things, with a plethora of subsystems hooking into the
> > same HID device, we must find a way for HID devices to spawn
> > MFD cells?
> > 
> > MFD solved and evolved a system for handling exactly this type
> > of situation.
> > 
> > Whether there should be an MFD device in the middle spawning
> > each a HID, GPIO, I2C, UART cell or whether HID device itself should
> > sit in the nexus and gain the ability to simply spawn out MFD cells
> > from itself is what we need to figure out.
> 
> There's no figuring that part out.
> 
> If you want to use the MFD API, the part that uses it must reside in
> drivers/mfd.  Else it becomes a nightmare to maintain and things get
> wild, quickly.

Historically speaking, HID devices always have been under drivers/hid.
They are usually leaf drivers, only hooking to input/battery/LEDs.

As mentioned, hid-sensor-hub is an exception but this got sorted out by
splitting the HID part from the IIO.

Looking at the various MFD-like HID drivers, they all share the common
point of not really being HID devices: they rely on a custom protocol
handled in .raw_event().

So I think I'd be OK to have those drivers moved to the mfd tree as long
as they only rely on low level HID API, and do not have to deal with
"generic" HID report descriptors. If that arise, I think we should split
the HID/MFD parts like hid-sensor-hub does.

So you can have my unformal acked-by for transfering those drivers.

Last, I'm currently using a cp2112 as a i2c-hid bridge in my upstream
CI. It's relying on a DSDT override in the VM to actually work, and I'd
like to keep that around. So my main request here is to keep the
equivalent of the DSDT override in the MFD cells, at least for this one.

Cheers,
Benjamin

> 
> You'd be surprised what "creative" engineers can do with it!
> 
> -- 
> Lee Jones
> 
