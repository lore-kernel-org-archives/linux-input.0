From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2] Input: Make ADS7846 independent on regulator
Date: Tue, 5 Oct 2010 20:35:08 +0100
Message-ID: <20101005203508.7df590db@lxorguk.ukuu.org.uk>
References: <1280560182-7071-1-git-send-email-marek.vasut@gmail.com>
	<4C862EB3.4080006@compulab.co.il>
	<20100907125335.GD25830@sirena.org.uk>
	<201009091027.18176.marek.vasut@gmail.com>
	<20100909094120.GB1988@rakim.wolfsonmicro.main>
	<4CAACA63.6090202@compulab.co.il>
	<20101005161608.GD19730@core.coreip.homeip.net>
	<20101005164037.GA20555@opensource.wolfsonmicro.com>
	<20101005180703.GD21399@core.coreip.homeip.net>
	<20101005185942.GA22808@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44735 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751822Ab0JETKr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Oct 2010 15:10:47 -0400
In-Reply-To: <20101005185942.GA22808@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Igor Grinberg <grinberg@compulab.co.il>, Marek Vasut <marek.vasut@gmail.com>, linux-arm-kernel@lists.infradead.org, vapier@gentoo.org, khilman@deeprootsystems.com, linux-kernel@vger.kernel.org, pavel@ucw.cz, linux-input@vger.kernel.org, eric.y.miao@gmail.com, akpm@linux-foundation.org

> If the board doesn't use regulators you can just disable the regulator
> API at which point it compiles out into stubs which report success -
> this has been the case from day one.  There's only an issue if the board
> has a regulator configuration which is partially visible to software.

Which is quite likely on anything complex and means that hardcoding
regulator assumptions is bad.

I actually see two ways of attacking that, one is that the dummy
regulator *and* the compiled in regulator system have a standard
regulator value that can be passed which means "report success, move
along nothing to see" that could be passed into drivers, the other is to
not stick the stuff in drivers.

I suspect the former may be cleaner ?

Alan
