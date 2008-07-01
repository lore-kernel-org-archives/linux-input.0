From: Adrian Bunk <bunk@kernel.org>
Subject: m68k input/ff-core.c build error
Date: Tue, 1 Jul 2008 14:56:19 +0300
Message-ID: <20080701115619.GB17558@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp4.pp.htv.fi ([213.243.153.38]:60326 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753171AbYGAL4i (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Jul 2008 07:56:38 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>, geert@linux-m68k.org, zippel@linux-m68k.org
Cc: linux-m68k@lists.linux-m68k.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Commit 656acd2bbc4ce7f224de499ee255698701396c48
(Input: fix locking in force-feedback core)
causes the following build error on m68k:

<--  snip  -->

...
  CC      drivers/input/ff-core.o
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/input/ff-core.c: In function 'input_ff_upload':
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/input/ff-core.c:172: error: dereferencing pointer to incomplete type
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/input/ff-core.c: In function 'erase_effect':
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/input/ff-core.c:197: error: dereferencing pointer to incomplete type
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/input/ff-core.c:204: error: dereferencing pointer to incomplete type
make[3]: *** [drivers/input/ff-core.o] Error 1

<--  snip  -->

Not sure what exactly the problem is, the failures are the
added spin_unlock_irq(&dev->event_lock)'s.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

