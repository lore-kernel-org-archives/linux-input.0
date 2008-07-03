From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] drivers/input/ff-core.c needs <linux/sched.h>
Date: Wed, 2 Jul 2008 18:39:55 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807021839390.18105@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0807011300110.21227@anakin> <20080701084316.ZZRA012@mailhub.coreip.homeip.net> <20080701130517.GA29863@cs181140183.pp.htv.fi> <20080701092542.ZZRA012@mailhub.coreip.homeip.net> <20080702164128.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33069 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752171AbYGCBkT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Jul 2008 21:40:19 -0400
In-Reply-To: <20080702164128.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>, Adrian Bunk <bunk@kernel.org>



On Wed, 2 Jul 2008, Dmitry Torokhov wrote:
> 
> Linus, will you apply Geert's patch directly or you would prefer me
> set up my tree for another pull?

I took it directly.

		Linus
