From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] drivers/input/ff-core.c needs <linux/sched.h>
Date: Wed, 2 Jul 2008 16:43:27 -0400
Message-ID: <20080702164128.ZZRA012@mailhub.coreip.homeip.net>
References: <Pine.LNX.4.64.0807011300110.21227@anakin> <20080701084316.ZZRA012@mailhub.coreip.homeip.net> <20080701130517.GA29863@cs181140183.pp.htv.fi> <20080701092542.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.249]:3787 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754263AbYGBUne (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Jul 2008 16:43:34 -0400
Received: by an-out-0708.google.com with SMTP id d40so104526and.103
        for <linux-input@vger.kernel.org>; Wed, 02 Jul 2008 13:43:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080701092542.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>, Adrian Bunk <bunk@kernel.org>

On Tue, Jul 01, 2008 at 09:27:02AM -0400, Dmitry Torokhov wrote:
> On Tue, Jul 01, 2008 at 04:05:17PM +0300, Adrian Bunk wrote:
> > 
> > Can we go with Geert's patch for 2.6.26 and if you want to fix it 
> > properly you can send a patch for 2.6.27?
> > 
> 
> No, no, I am totally fine with Geert's fix, I am talking about later of
> course.

Linus, will you apply Geert's patch directly or you would prefer me
set up my tree for another pull?

-- 
Dmitry
