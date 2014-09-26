From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 3.17-rc6
Date: Fri, 26 Sep 2014 11:01:11 -0700
Message-ID: <20140926180111.GA3911@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:45575 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755443AbaIZSBR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Sep 2014 14:01:17 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
or
	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get a small fixup to
i8042 adding Asus X450LCP to the nomux list.

Changelog:
---------

Marcos Paulo de Souza (1):
      Input: i8042 - fix Asus X450LCP touchpad detection


Diffstat:
--------

 drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
 1 file changed, 7 insertions(+)


-- 
Dmitry
