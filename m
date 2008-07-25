From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: drivers/input/serio/hp_sdc.c: Removed duplicated include
Date: Fri, 25 Jul 2008 09:19:12 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807250917050.5249@nehalem.linux-foundation.org>
References: <20080725231334.9146.WEIYI.HUANG@gmail.com> <20080725115152.ZZRA012@mailhub.coreip.homeip.net> <20080725115621.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44057 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750878AbYGYQWi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Jul 2008 12:22:38 -0400
In-Reply-To: <20080725115621.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Huang Weiyi <weiyi.huang@gmail.com>, linux-input@vger.kernel.org



On Fri, 25 Jul 2008, Dmitry Torokhov wrote:
> 
> Linus, commit 0f17e4c796e89d1f69f13b653aba60e6ccfb8ae0 is basically a
> duplicate of 4933d07531711e399d8d578036aa9fc1be2f9b20, both add
> linux/semaphore.h but in 2 slightly different places. Do you want to
> just revert the first one or to take a new patch correcting the problem?

I'll revert 4933d07, thanks.

		Linus
