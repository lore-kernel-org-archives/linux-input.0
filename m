From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Retire gamecon?
Date: Tue, 12 Aug 2014 22:17:42 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1408122212340.15220@pobox.suse.cz>
References: <20140812170722.GC5563@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46306 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754179AbaHLURo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Aug 2014 16:17:44 -0400
In-Reply-To: <20140812170722.GC5563@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>

On Tue, 12 Aug 2014, Dmitry Torokhov wrote:

> I am wondering it it is time to retire gamecon support from the kernel. 

Absolutely no objections from me on this, but I guess Vojtech's opinion is 
much more relevant here, as he has actually *seen* this hardware (I 
guess) :)

> It hasn't been working well ever since cpufreq became mainstream and it 
> becomes increasingly hard to find hardware and software that would run 
> on such old hardware.

Makes me wonder though what makes gamecon so special among other drivers 
of such kind (such as JOYSTICK_DB9, to name one randomly picked example).

-- 
Jiri Kosina
SUSE Labs
