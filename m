From: Jason Wessel <jason.wessel@windriver.com>
Subject: [PATCH 0/3] input / sysrq fixes for use with kdb
Date: Thu,  7 Oct 2010 15:35:45 -0500
Message-ID: <1286483748-1171-1-git-send-email-jason.wessel@windriver.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:57498 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab0JGUgA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Oct 2010 16:36:00 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: kgdb-bugreport@lists.sourceforge.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

The goal of this patch set is to help eliminate the problems of
resuming from the kernel debugger and having "stuck keys".

I am completely open to moving the code chunks around if it makes more
sense to put the function in the input.c.

I had posted the first patch in the series before and never received
an ack or acceptance into the linux-input merge queue.

Thanks,
Jason.

---

The following changes since commit cb655d0f3d57c23db51b981648e452988c0223f9:
  Linus Torvalds (1):
        Linux 2.6.36-rc7

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jwessel/linux-2.6-kgdb.git for_input

Jason Wessel (2):
      keyboard,kgdboc: Allow key release on kernel resume
      sysrq,keyboard: properly deal with alt-sysrq in sysrq input filter

Maxim Levitsky (1):
      keyboard,kdb: inject SYN events in kbd_clear_keys_helper

 drivers/char/keyboard.c  |   38 +++++++++++++++++++++++++++
 drivers/char/sysrq.c     |   64 +++++++++++++++++++++++++++++++++++++++++++--
 drivers/serial/kgdboc.c  |   13 +++++++++
 include/linux/kbd_kern.h |    1 +
 4 files changed, 113 insertions(+), 3 deletions(-)
