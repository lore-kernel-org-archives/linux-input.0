From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [RFC][PATCH] input: Introduce device information ioctl
Date: Wed, 08 Dec 2010 20:04:50 +0100
Message-ID: <4CFFD6D2.5060703@euromail.se>
References: <1291706726-8835-1-git-send-email-rydberg@euromail.se> <20101207091653.GA22416@core.coreip.homeip.net> <4CFE919A.1040704@euromail.se> <20101208060200.GD4140@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:57015 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756203Ab0LHTF3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 8 Dec 2010 14:05:29 -0500
In-Reply-To: <20101208060200.GD4140@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ping Cheng <pingc@wacom.com>, Chris Bagwell <chris@cnpbagwell.com>

> One concern is that while 32 distinct device types should be enough

> should we plan for larger capability array? Should we use variable
> length ioctl - like EVIOCGKEY(len) - even though Arnd does not like
> them?


Sounds good, but then again the struct approach feels quite extensible too...


> Also, we already have /sys/class/input/input0/capabilities/ so should we
> call new data item something else? Quirks maybe?


Works fine in my book.

Thanks,
Henrik
