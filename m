From: simon@mungewell.org
Subject: Re: [PATCH v4 01/24] input: Add ff-memless-next module
Date: Tue, 20 May 2014 16:16:12 -0400
Message-ID: <865ad8dbc7ae0d13c045bd2a85cff2e2.squirrel@mungewell.org>
References: <1398524543-15012-1-git-send-email-madcatxster@devoid-pointer.net>
    <1818063.tFLKhAd1oy@sigyn>
    <20140514180558.GB30089@core.coreip.homeip.net>
    <2965006.XKYHWj9YzJ@sigyn>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:59980 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbaETUQP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 May 2014 16:16:15 -0400
In-Reply-To: <2965006.XKYHWj9YzJ@sigyn>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?=22Michal_Mal=FD=22?= <madcatxster@devoid-pointer.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jkosina@suse.cz, elias.vds@gmail.com, anssi.hannula@iki.fi, simon@mungewell.org


> To bring this to a conclusion we could go from, would this be an
> acceptable
> solution?
>
> - Have the HW-specific driver talk directly to ff-core and reimplement
> upload(),
> play(), etc.
> - Rewrite "ff-memless-next" so that it is not a self-contained module but
> a
> library of functions.
> - Have the driver either:
>   - Upload an effect to a device directly if the device can fully manage
> the
> effect by itself.
>   - Use provided timing functions to know when an effect should start,
> stop,
> restart etc...
>   - Use provided timing AND processing functions to combine effects that
> can be
> combined into one, calculate periodic waveforms etc?
>
> I have no problem with throwing my current approach away but before I
> start working on a new one I'd like to know which way to go...

Hi all,
If the driver itself (hid-logitech, via hid-lg4ff for example) is more
involved in the creation/timing/management of the effects, does this mean
that we end up with code duplicated in lots of places?

Also, does this mean that the 'old' ff-memless system would remain in
kernel? If not, who will reworking each driver?



Regarding the question of emulated vs. real effects, can we extend the API
so that applications can know which effects are really supported, and
enable/disable emulation somehow?

Apologies for asking some many questions, without answering anything...
Simon

