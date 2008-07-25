From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: drivers/input/serio/hp_sdc.c: Removed duplicated include
Date: Fri, 25 Jul 2008 12:00:59 -0400
Message-ID: <20080725115621.ZZRA012@mailhub.coreip.homeip.net>
References: <20080725231334.9146.WEIYI.HUANG@gmail.com> <20080725115152.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.248]:55433 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbYGYQBC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Jul 2008 12:01:02 -0400
Received: by hs-out-0708.google.com with SMTP id 4so482751hsl.5
        for <linux-input@vger.kernel.org>; Fri, 25 Jul 2008 09:01:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080725115152.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Huang Weiyi <weiyi.huang@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-input@vger.kernel.org

On Fri, Jul 25, 2008 at 11:52:19AM -0400, Dmitry Torokhov wrote:
> On Fri, Jul 25, 2008 at 11:30:20PM +0800, Huang Weiyi wrote:
> > Removed duplicated include file <linux/semaphore.h> in 
> > drivers/input/serio/hp_sdc.c.
> > 
> 
> What tree is it against? I don't seem to have teh duplicate.
> 

Ah, I see...

Linus, commit 0f17e4c796e89d1f69f13b653aba60e6ccfb8ae0 is basically a
duplicate of 4933d07531711e399d8d578036aa9fc1be2f9b20, both add
linux/semaphore.h but in 2 slightly different places. Do you want to
just revert the first one or to take a new patch correcting the problem?

-- 
Dmitry
