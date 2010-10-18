From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.36-rc7
Date: Mon, 18 Oct 2010 08:49:41 -0700
Message-ID: <20101018154941.GA5406@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:56104 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755327Ab0JRPtz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Oct 2010 11:49:55 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Daniel Mack <zonque@gmail.com>

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
or
	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive 2 important bug fixes to the evdev input handler. I hope it
is not too late to make 2.6.36...

Changelog:
---------

Daniel Mack (2):
      Input: evdev - fix Ooops in EVIOCGABS/EVIOCSABS
      Input: evdev - fix EVIOCSABS regression


Diffstat:
--------

 drivers/input/evdev.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

Thanks,
Dmitry
