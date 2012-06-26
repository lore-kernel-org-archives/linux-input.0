From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v6] Touchscreen driver for FT5x06 based EDT displays
Date: Tue, 26 Jun 2012 20:21:37 +0200
Message-ID: <20120626182137.GA259@polaris.bitmath.org>
References: <1333564079-23893-2-git-send-email-simon.budig@kernelconcepts.de>
 <1340408898-491-1-git-send-email-simon.budig@kernelconcepts.de>
 <1340408898-491-2-git-send-email-simon.budig@kernelconcepts.de>
 <20120625085113.GA648@polaris.bitmath.org>
 <20120626020600.GD24705@core.coreip.homeip.net>
 <4FE97B99.9050506@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:34606 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758903Ab2FZSSW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jun 2012 14:18:22 -0400
Received: from ipb3.telenor.se (ipb3.telenor.se [195.54.127.166])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id 6B38ACE15
	for <linux-input@vger.kernel.org>; Tue, 26 Jun 2012 20:18:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4FE97B99.9050506@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Budig <simon.budig@kernelconcepts.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, olivier@sobrie.be, agust@denx.de, yanok@emcraft.com

> So yeah, the raw data is not as useful as one might hope and I am
> perfectly fine with moving it (together with the "mode" parameter) to
> the debugfs.

Great, thanks.

> I think adding gain/offset/threshold to the platform data makes a lot
> of sense, since different defaults for devices with a 4mm glass plate
> in front of the sensor are necessary and can be done in the board
> file. However, I think it has to be possible to change them at
> runtime, and I don't think that is a debug only thing. Hence I'd
> prefer to have them somewhere else than in debugfs.

This sounds like a reasonable compromise. It removes the direct need
for userspace tuning, but leaves the possibility open for the so
inclined.

Thanks,
Henrik
