Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64004CA294;
	Wed, 16 Sep 2026 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789563493; cv=none; b=Ujq1DrUoNBcMgNa+3lh3GYM5tU0oPiVjSTOU6TDNJTMdVl2Fip7Xry/w0MoYN1SMwzHAxjXK0WYogBhwLsUUsCv2DMp6yXGT6mRB3AeQbmNsiju9/g62dZBUNMDfacfOJTVT350EiO3U2OcTb48+5wDz92tN6keiEWzvAM63c3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789563493; c=relaxed/simple;
	bh=SYwvEnBtoRvkWlwTU6VnVVX8VuVIEly6xYIE1/OGa84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5+OMlZG/Z4DoQN9mra6m01y5KUAEzD6UeAoFr843L/Io6ouYYo5/0kM7o1vSKElWW2fSmCib6hiug71aZN0WRBUUQqys2yol/uN1BB7qrHSwBeRGuhEmAQrRFThyZthgoEbpfS8KK52oSGAphQ8r09SrCmUOVXLnSDIl+k3pIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWCiE1DN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWCiE1DN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E0D1F000FF;
	Wed, 16 Sep 2026 12:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789563491;
	bh=QoXOg1u3NsNbwWPxDCs5h7mSE7ScahjImhGtlViVVlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eWCiE1DNDqHffIHbOSRjkoLRdNb1TTURzCxVCQpQowTO8ljc6W1GZNHT0v37RQdPV
	 xv7F7T1MBO788o7cXWmzvpOEGt/EyEM/f1iVuluNeDiiZDLaPvClv9GhjJsIYtlD8J
	 zUVvRnkwmHYlQ7y1FHxZYMJ8pCx4NOa929Hr41bbFos4FijuhHHZ+rdTwCtdSWFLFM
	 roW+l6up+C0W5VCGGu8POu9XTkRi25w0jKDgFhAqXFWYY9iSbGUu5dy1LyGUStSwPZ
	 Rcj0/kmreWpdmzrit6gMXF3RQVRJBU08RljJSUUKS6eBTSxOKiOtttuNtwZLWd0Izm
	 74jHm1OqHwNlQ==
Date: Wed, 16 Sep 2026 13:58:06 +0100
From: Lee Jones <lee@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	Michael Zaidman <michael.zaidman@gmail.com>, jikos@kernel.org,
	brgl@kernel.org, linux-input@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] HID: ft260: add UART and GPIO support, plus I2C
 fixes
Message-ID: <20260916125806.GR11487@google.com>
References: <20260827205116.GJ2943942@google.com>
 <20260827222550.24634-1-michael.zaidman@gmail.com>
 <apaLLD4ZXhNV-Dph@beelink>
 <CAD++jLng_gdqoehT+c8sXoqy+tdUc7eAXXpAvhC_zJZwnX5tzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLng_gdqoehT+c8sXoqy+tdUc7eAXXpAvhC_zJZwnX5tzA@mail.gmail.com>

On Mon, 14 Sep 2026, Linus Walleij wrote:

> Hi Benjamin, Lee,
> 
> On Tue, Sep 1, 2026 at 4:03 PM Benjamin Tissoires <bentiss@kernel.org> wrote:
> 
> > TBH, I'm not a big fan of having multiple subsystems children into HID.
> > Mostly because I can't review the best practive in each of them. However,
> > for quite a long time, HID was mostly for input devices, and input is a
> > different subsystem.
> >
> > That being said, there are 2 types of HID devices:
> > - ones with defined standard usages (keyboards, mice, touchscreen,
> >         battery, etc) and using MFD for those would certainly be overthinking
> > - others use raw HID device with a custom protocol (cp2112, mcp2221,
> >         ft260), these could be MFD candidates
> 
> Surely, as HID start to attract chips which clearly fall into the MFD
> category of things, with a plethora of subsystems hooking into the
> same HID device, we must find a way for HID devices to spawn
> MFD cells?
> 
> MFD solved and evolved a system for handling exactly this type
> of situation.
> 
> Whether there should be an MFD device in the middle spawning
> each a HID, GPIO, I2C, UART cell or whether HID device itself should
> sit in the nexus and gain the ability to simply spawn out MFD cells
> from itself is what we need to figure out.

There's no figuring that part out.

If you want to use the MFD API, the part that uses it must reside in
drivers/mfd.  Else it becomes a nightmare to maintain and things get
wild, quickly.

You'd be surprised what "creative" engineers can do with it!

-- 
Lee Jones
