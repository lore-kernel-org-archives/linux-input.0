From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] drivers/input/ff-core.c needs <linux/sched.h>
Date: Tue, 1 Jul 2008 08:46:54 -0400
Message-ID: <20080701084316.ZZRA012@mailhub.coreip.homeip.net>
References: <Pine.LNX.4.64.0807011300110.21227@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:52810 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422AbYGAMrY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Jul 2008 08:47:24 -0400
Received: by an-out-0708.google.com with SMTP id d40so398104and.103
        for <linux-input@vger.kernel.org>; Tue, 01 Jul 2008 05:47:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0807011300110.21227@anakin>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>

On Tue, Jul 01, 2008 at 01:55:25PM +0200, Geert Uytterhoeven wrote:
> commit 656acd2bbc4ce7f224de499ee255698701396c48
> Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Date:   Thu Jun 26 11:30:02 2008 -0400
> 
>     Input: fix locking in force-feedback core
> 
>     The newly added event_lock spinlock in the input core disallows sleeping
>     and therefore using mutexes in event handlers. Convert force-feedback 
>     core to rely on event_lock instead of mutex to protect slots allocated  
>     for fore-feedback effects. The original mutex is still used to serialize
>     uploading and erasing of effects.
> 
> causes the following regression on m68k:
> 
> | linux/drivers/input/ff-core.c: In function 'input_ff_upload':
> | linux/drivers/input/ff-core.c:172: error: dereferencing pointer to incomplete type
> | linux/drivers/input/ff-core.c: In function 'erase_effect':
> | linux/drivers/input/ff-core.c:197: error: dereferencing pointer to incomplete type
> | linux/drivers/input/ff-core.c:204: error: dereferencing pointer to incomplete type
> | make[4]: *** [drivers/input/ff-core.o] Error 1
> 

Argh! Sorry about it.

> As the incomplete type is `struct task_struct', including <linux/sched.h> fixes
> it.

Not linux/spinlock.h? I wonder if I need to include linux/spinlock.h and
linux/mutex.h directly from linux/input.h... What is the current
policy on headers - do they need to include everything to be
functional or it is responsibility of the user?

-- 
Dmitry
